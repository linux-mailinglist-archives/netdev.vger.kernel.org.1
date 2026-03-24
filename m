Return-Path: <netdev+bounces-271312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOJYBGICw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:30:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA1131CDC7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C3233063000
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBAC35EDA4;
	Tue, 24 Mar 2026 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByrR/SOv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC3299AAB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387807; cv=none; b=NuhNTGluP66u8qJWrI5CQEEEnEfDr73L0qyhM2gRcPoZzPyhJNz7T+I/pz76R+fw2nxEDbA5dg+3c5G59Wrl02y6QOOyYtKuLX3bzqoJbP8V1+ECddAsjRtKFusin8uzyLl7JUyX/oMky+l8fvThFqh2Yv30jCoARmRHMA+fQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387807; c=relaxed/simple;
	bh=SUyDbpt/8MUxAqfAGhISunuQa41CBmxG57DoriVSvY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhhzspksbziED0oYpFXzZ/hcQDpNoVk6f4KIALxKrjNg5xVCQvwdQJDDRNWtSlmd3Fzn7TCxhry7K91+8Mzx8+2hYioqbxtpz9v/IrnLqU4gKXZmaZScuk4vShSkojiK60n50Ycn1wirpAvgEZ6JXJv4pJx0EnArS9kmvA9LxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByrR/SOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B13C19424;
	Tue, 24 Mar 2026 21:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774387807;
	bh=SUyDbpt/8MUxAqfAGhISunuQa41CBmxG57DoriVSvY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ByrR/SOv9WcjufTb/RV8/yCoKdBBRq81+pvq6HK6DovzoZSisNJYd3ne69v4qEgBp
	 Nc6EjnJ8KXFWb2odduZYWvq4439PqXMfbPD8agEVrLsBdI+MKxQ63j8daX5d9+1xMl
	 DJgW4q90LbcCbtWUbZzcibO11YffiDiJDdhn43e7enpEpWj/dMb3WZ6BNFiY3gN0yK
	 9nmRwHptP2vut3FKN+hAs1wC0C6CkJGZY5wEcqZMg7ZFDFjOHUIrr8RIPs1THKLj1Z
	 ILBZbZiHEvhg8oRmUylDKoTMElZwbQYm5HcBi5yTDfogKgdq66rUVB8OtHlxlG5R29
	 NpQ45i+RMo4lQ==
Date: Tue, 24 Mar 2026 14:30:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Hyunwoo
 Kim <imv4bel@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <20260324143006.60e7ca2e@kernel.org>
In-Reply-To: <acJix6cQZyqb94pA@krikkit>
References: <20260320100351.2283994-1-antonio@openvpn.net>
	<20260320100351.2283994-2-antonio@openvpn.net>
	<20260323184304.42c3930f@kernel.org>
	<20260323184543.764a903e@kernel.org>
	<acJix6cQZyqb94pA@krikkit>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[openvpn.net,vger.kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-271312-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EA1131CDC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 11:09:11 +0100 Sabrina Dubroca wrote:
> -------- 8< --------
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index c7f382437630..ebec8c2ff427 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -90,8 +90,11 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>  	netdevice_tracker *tracker = (netdevice_tracker *)&info->user_ptr[1];
>  	struct ovpn_priv *ovpn = info->user_ptr[0];
>  
> -	if (ovpn)
> +	if (ovpn) {
> +		if (READ_ONCE(dev->reg_state) >= NETREG_UNREGISTERING)
> +			ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
>  		netdev_put(ovpn->dev, tracker);
> +	}
>  }
>  
>  static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
> -------- 8< --------
> 
> This would clean up a peer that may have been added while we were
> starting device unregistration. We hold a reference on the device so
> no UAF possible, netdev_wait_allrefs_any will wait for this. If we
> don't have a racing peer creation, ndo_uninit takes care of the peers.

LGTM. This or change all the write paths to check if the device is still
alive after taking the lock.

> Or we can call ovpn_peers_free on every NETDEV_UNREGISTER notification
> that netdev_wait_allrefs_any sends us (but then we don't need it in
> ndo_uninit).

Hm, wouldn't we need a notification _after_ netdev_wait_allrefs_any() ?

> And s/cancel_delayed_work_sync/disable_delayed_work_sync/ for the
> keepalive_work.
> 
> 
> LLM claims it's because of parallel_ops, I don't think this is
> related? It also claims this issue is only for UDP sockets (and TCP
> would see a UAF on the keepalive), but ovpn_peer_new always holds the
> ovpn netdev, so I don't think there's a difference there.

Yup, I think the LLMs are trying to be helpful and are looking for some
write lock earlier in the path. As much as they are annoying I can't
blame them here, I feel like we try to make things lockless too often.

