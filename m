Return-Path: <netdev+bounces-254986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLiYORAcfGmAKgIAu9opvQ
	(envelope-from <netdev+bounces-254986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:48:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE3B68B1
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66C31300337F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B83E28000B;
	Fri, 30 Jan 2026 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY8vFV4d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BA21019E
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741326; cv=none; b=h23BKHetsWSxrdNYroJwaZlYqeOwCls7xbxkpxipkW9fgQOY+ukfnbHy+ZKfrr8iAlXlipbFh66E1wnEflIDUlgr5dIC8YjYs/sSW2JqAEB29nna2ca0SoIQfuRV2Kf5WSjyZM1vGu0Ixnl9RBGJdf4Cqvvh7bOs3rF09tv8xjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741326; c=relaxed/simple;
	bh=YZJUQzO/HiYjNkjKiNig5HCSrb815nSS92FtBN6XGhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sO/B9QKbncFLWYUXbTqB6sexM8hTnqgUY+mk+ptTPd8IXf7pPrl+8lFRBFSMzJewPq0ENutPnuMBJ1jr4Fgxmt0bo7mmnz2az0LiieL6sTvgT8C1pzxP+yONmm9jLL8Nn9qn7ft3k6Fjm3J0NhIswd9RF4YvhA7OAnyJcsLg9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY8vFV4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8180AC4CEF7;
	Fri, 30 Jan 2026 02:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741325;
	bh=YZJUQzO/HiYjNkjKiNig5HCSrb815nSS92FtBN6XGhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gY8vFV4d+7VNmc+BibNkhTWTnt2ZyFfOHZQShC2WUlNCrIB7fw14XItnZyf4ukoWR
	 IyVbLCNTx1yREy5aHSZQV3Us8HZ1xsDabEPxtvwivWjq2rJ6D/u8WDleXbAuO9YJcC
	 sFut5/nT+MMTYpBGJr5DhMIcEiCG+gaXFVJefIUGDHLF6OTVUDOF1ybnvnCL4WhTmG
	 0revNH3i8ZQ4bYiehtXawOQe7mfwUARmaNYKmBKJjoJwxAVtenPAWyg5ZdQo+YxW/x
	 Edu6HOqg/pQswC++/InTGaNV55LAO18oeakd1C1v2RWZCa/8WHrmwcIllW8+QAzMFu
	 t388qS8lW2ZqA==
Date: Thu, 29 Jan 2026 18:48:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] ipv6: optimize fl6_update_dst()
Message-ID: <20260129184844.195df52e@kernel.org>
In-Reply-To: <20260128185548.3738781-1-edumazet@google.com>
References: <20260128185548.3738781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254986-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEFE3B68B1
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 18:55:47 +0000 Eric Dumazet wrote:
> - * Returns NULL if no txoptions or no srcrt, otherwise returns orig
> + * Returns NULL if no srcrt or invalid srcrt type, otherwise returns orig

I'm gonna take this opportunity to update this line to Return:
in accordance with kdoc rules, hope you don't mind. Applied.

