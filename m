Return-Path: <netdev+bounces-252589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JK5AY7QcmnKpgAAu9opvQ
	(envelope-from <netdev+bounces-252589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:36:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D47806F252
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48AAA30158AF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360F8335575;
	Fri, 23 Jan 2026 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN34oewB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027D33C18E
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132160; cv=none; b=ftaBW3F7uWECN+E47oGCDJqBSNIx5lXeVOwovGatgeayxDFzRNcd5Yc4w1xn/KWE9BXMSibhdn/WYBh1bl8Cx9fYpOALE3OuB/yw1fM3/bxia8mQGEq72hNwUZYY1YG4RZPiqbEDLj8xBm3NwfPKkvawEm/Q93MXzKfNzX2aYwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132160; c=relaxed/simple;
	bh=2sKKfuZvSO4Y/wsbrMkxgqevJ4IlggeO53KVGPHSQzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2sxar8U6buQJSZxulaKohKs3iT97gPOnLyZQsXc/maCbB0IOYbLkXwjG1zhQcDART+cfQB85xex6+tkgI8dgeshEDsf+WS7XBDdBV3M53YdhsiBxnG0qA9ufrDoYekKFo+PCGTAy8qKJq3VD0DpwX5ST5VXuILlLr5cg52mxbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN34oewB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380C7C116C6;
	Fri, 23 Jan 2026 01:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132157;
	bh=2sKKfuZvSO4Y/wsbrMkxgqevJ4IlggeO53KVGPHSQzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AN34oewBVvpi7T53uL3ImPKVWmbnukbYEjSx5R2e0/4vRmEu8CXWqzQBHnC4FDEjy
	 6u/++0RC8+9kOj0LCUKEuFlAwBTOQlAAbL0oREOjIdEb5RiMKLf+gwPXXb3P9uB4fM
	 ej9jV0XeRIhMlr23wvWTB0uSs7oLAjbf/uaGaW25d0IskO92l6GasGlrBSTFTLh7Mn
	 IWDjrNrwhTRlWTkikKh5wpyRTXK1yaOJ4hPNWm+ROz7QW12oeSKeKqcfqQldc/V5M2
	 u6H6ZJtUNW3/CO2gJazhBMNZ+elUGlXj/iAvNOloxNC2cVTVvb96RHLO9RCkwtRnYS
	 GKcnxOSnjsKkw==
Date: Thu, 22 Jan 2026 17:35:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jkarrenpalo@gmail.com,
 tglx@linutronix.de, mingo@kernel.org, allison.henderson@oracle.com,
 petrm@nvidia.com, antonio@openvpn.net, bigeasy@linutronix.de
Subject: Re: [PATCH net-next v2 0/9] hsr: Implement more robust duplicate
 discard algorithm
Message-ID: <20260122173556.44d8b77f@kernel.org>
In-Reply-To: <cover.1769093335.git.fmaurer@redhat.com>
References: <cover.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	TAGGED_FROM(0.00)[bounces-252589-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D47806F252
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 15:56:55 +0100 Felix Maurer wrote:
> The duplicate discard algorithms for PRP and HSR do not work reliably
> with certain link faults. Especially with packet loss on one link, the
> duplicate discard algorithms drop valid packets. For a more thorough
> description see patches 4 (for PRP) and 6 (for HSR).

Transient build breakage here - patches 4-7 don't build and will break
bisection. Perhaps wait a few days to give a chance for Sebastian to
TAL before reposting tho?
-- 
pw-bot: cr

