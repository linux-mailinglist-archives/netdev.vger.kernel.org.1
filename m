Return-Path: <netdev+bounces-277228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CdPwI1hv2GlJdQgAu9opvQ
	(envelope-from <netdev+bounces-277228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:32:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CEC3D1D52
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088663013A5B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BDD314A65;
	Fri, 10 Apr 2026 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRq/dWoO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F01247280;
	Fri, 10 Apr 2026 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775791957; cv=none; b=ROoBmWrI3aojf5scUbvkt3wQmn+YVbT5pS4fUDun2Lt2bWKJ5TQFuR2tOiBcNxqpIOJb+0tQr23LpFhUtm1DocFt/oHsE3xoMc9OMK2ULtr1JEvyAoArtIbdI3NiI5cCUv30K1LsiAGGz9lOcNBGuKXCB4yYKSh2qplR7Cwx7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775791957; c=relaxed/simple;
	bh=GpakvOgwTza8dL+Os94zM7yKdqCnyPqtnqh8xzlXhIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gL225LYdn85YB7IPqJuX0mNyupp8ulNmGT2RkXTvkmctUubDtkLsgmzvEE8zq9oPfFU0nL43TfWRBrnZRfkupLhkO5XTuQsYOiQO4s6iWeHgDbNPw8guL7CmMUy/S1BXTZ0r9gaTJyDc+MST9ABKw1PQPWO4bcaGr6XkW76yYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRq/dWoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B01C2BC9E;
	Fri, 10 Apr 2026 03:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775791957;
	bh=GpakvOgwTza8dL+Os94zM7yKdqCnyPqtnqh8xzlXhIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IRq/dWoOIdP59UQxZ8pKvDeDwHc4vPT+1AF+vA3AYSI82Y1VCB6z58aKY/oaBx40g
	 TbNiv5HEiAOpQNOHWHYQIDb/PEOOZalF0Duu10fcP9Z7pUbx4WWXNlzAL5p/p6LPBu
	 ja/VPxyEVQONGcnHc4gayqDl+QSKfc0ea8pTS1VTivQ/Tl5iu9oljOhwLRgjIIG9JQ
	 0ipwbRd/TTkJkezz7HUTfTFyl7fEg+Zr9DDyjr+rcqLLPUGeUWCGchGONl3DS5icYc
	 CI8cpi8/dpO/Qg3kWTuKNOxBMJOE1pc6oukxMooViTBvnYQYH3rNu6fD4AYwSdUCtL
	 NlM2Kbj8wcBPw==
Date: Thu, 9 Apr 2026 20:32:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>, stable
 <stable@kernel.org>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <20260409203235.6b9329f0@kernel.org>
In-Reply-To: <20260409190328.GS469338@kernel.org>
References: <2026040730-untagged-groin-bbb7@gregkh>
	<20260409190328.GS469338@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277228-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08CEC3D1D52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 20:03:28 +0100 Simon Horman wrote:
> I expect that checking skb->len isn't sufficient here
> and pskb_may_pull needs to be used to ensure that
> the data is also available in the linear section of the skb.

Or for simplicity we could also be testing against skb_headlen()
since we don't expect any legit non-linear frames here? Dunno.

