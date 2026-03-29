Return-Path: <netdev+bounces-273025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNxVF9OjyWnj0QUAu9opvQ
	(envelope-from <netdev+bounces-273025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:12:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C3B354420
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55630300D476
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B42EC0B4;
	Sun, 29 Mar 2026 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5IAqs9a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409B249EB;
	Sun, 29 Mar 2026 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774822352; cv=none; b=Rpn/id/9dG4ryRas9U+FDHckiiz26zbW2GmoCg18JR0m4zVy88q/pS/8Bu6t0Sq5Qwaefy9cXmd7V36pgknAKF+GRnI0L+JbKHp0uNmLnqMikLoKuDNr6UlrswbozIC7DqzRvRgCRNm31pmQ+z9ky2hbbTQfbjENecPE/kXIwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774822352; c=relaxed/simple;
	bh=7gR/RhLuywXK4z4Yd7rCJo6vYLWYlNMRRVny8ORRdmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEZlh23Ct0XACvl0VXRK8261AHXyvFkS9dB/TRC9aK3MFCNyArpoq9FLxSBDD7kqtwoxgtBNh914MNsUDJBDILlbWQM6Jaf5K9NLyOAS5vveoh2FAVl16cE3LHDBBC4lFfdRDnu05ubOJwVRJcE06xtKEXvn9rc1/6IwCG7A5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5IAqs9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88472C116C6;
	Sun, 29 Mar 2026 22:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774822352;
	bh=7gR/RhLuywXK4z4Yd7rCJo6vYLWYlNMRRVny8ORRdmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5IAqs9aCMRjB/2oTjfgQE8t6j2fyW3/y1ZVHXTY7wP7YvgmgSwDKhka2H7txuDg3
	 wdsUP2tFb55Vts1gih6NRtIQsbi2462x9+pKUx0OUSpMLYLRjM8yhu9hPSpq5rKEU0
	 KP03EQSTMvivYq7c+q7NCZZa7LQVh3efCvwXC82WIFxZzgqAF3cmFwlyCAKlVyc+vO
	 q1MqVx2yBwtko2leztRX0NY4sAbEowbq5C0o9KeR3YmdO/qPwFOEG8qpD6LW3k5Fxp
	 GFC+W6q+iEmn3xmVSIYXQbi2fgZo4o9dYrXXMFC50z7IcooaqfOLF8nNWEwVIooc41
	 hz8/onyrdBuTA==
Date: Sun, 29 Mar 2026 15:12:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, andrew+netdev@lunn.ch,
 horms@kernel.org, pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
 leon@kernel.org, bpf@vger.kernel.org
Subject: Re: [net-next v6 07/12] net: bnxt: Add boilerplate GSO code
Message-ID: <20260329151230.7acacbb9@kernel.org>
In-Reply-To: <20260326235238.2940471-8-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-8-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273025-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,iogearbox.net,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5C3B354420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 16:52:26 -0700 Joe Damato wrote:
> @@ -891,6 +891,7 @@ struct bnxt_sw_tx_bd {
>  	u8			is_ts_pkt;
>  	u8			is_push;
>  	u8			action;
> +	u8			is_sw_gso;
>  	unsigned short		nr_frags;

nit: maybe group the is_* together, IOW move new fields before @action?

