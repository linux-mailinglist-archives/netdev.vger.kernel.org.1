Return-Path: <netdev+bounces-263654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP8DJdPwp2mWlwAAu9opvQ
	(envelope-from <netdev+bounces-263654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:44:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B681FCC9F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55266301BEF3
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10913932D4;
	Wed,  4 Mar 2026 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLVQiFvT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6293932C8
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613831; cv=none; b=lZsWmTnoFxZ0MEFFeF23fhyXhH1V6YqRFfoOErUJ5Ga/RTWRscutfnB1EM/NDhfhDNYamyjSG/bTu2CMwA1MOy0WHYDuaGVobX4YkIHpUEM4OXebenCDlTcYNOuu4DOfZDGbcq+pz79QzNiICg6LwLycJIs+uwFvIxgRAMPLgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613831; c=relaxed/simple;
	bh=VIJxBhv7XGCFbPbdOeAB7Qdcmzlygb76zrm9jwwzsOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrD+YMZItpuhI0Ru8XvmpIbRfJMNaO0hqRoLUP7wKRueTQh2GazFxf6xmtn9dpgAN/PooLf6EvEgjv29arDlzhv0APGgqD1HseP26lDU1BkussHBcevSVxYZA0MUdrfMOddlUKX+gReO30GO4zAsiPlDgwDhm0rdYzRr0pTTgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLVQiFvT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-824b5cae336so2623297b3a.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 00:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772613830; x=1773218630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3vMQO/IQoYaKESJWlFHP+qMU8qosPwTVj93SXFE13Y=;
        b=RLVQiFvT6sJ/P5I+bpFCEWEUsXmIpCPKMODFKfSa3ClISRLGGNP6+WXqe2hnZ7pee9
         br/024vPcTglhUKNbgy2Bkqrp03LeVZexAZc5L3RACLr9gdMbh7lMAuq8q9ZpxgnZxM3
         9qRi2vY9FueJKRiw9ajtI5oBYwWQoufnbMYyKDB3gluqBSfmKQIratAvyqIVc5gs4LTE
         RWUTVPKySt3coo+6Npmf/rw0TcUi0W/+pDsYmQRchRZ8HK2nLTAlegDvGMzx5lUOUcfx
         6r358bsGfwwvy7fjFuf4a3HkEUs9J6ATTcOCL4tOPWNZRVYPKUCf1tmSvk80JdrUiL4x
         wsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772613830; x=1773218630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3vMQO/IQoYaKESJWlFHP+qMU8qosPwTVj93SXFE13Y=;
        b=ObDiQyA88UrkCyHHKKfGf1V5KiKSHZbQ2sf2TLKakQJyS9fKTd8GGOJp+Gkem4A0YV
         wSN4jJ+toknYtlTwyauxRVpQAipseUPE+vxy2P0xpdZF/bY0H/ADyliWEflSldyXJw0Z
         mxmpbkTeDixA/L77vCZW5Rmt5B8XHzHaEkJHBB0VAV84SBoiSABqGs1d2GFBCaT1xLIY
         DGK3RQjApmbIyK+Qp/WFce61NPJRVFvzI9tdpJ40kv+yg9viX5c+xOb9Y/10S5DmmvYc
         2SPPe3EjBPsGW6KwvTaqZyT4irGNa55hhx1Sll7yu6A2B4zQ7d3wjG/rBp5UR8fqPrw+
         NHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiotWrFzV4KhEYF4oP3pIg2afQZbRjIEJ1WZ5QDsh1ro8/xVoVt8xjBitvx5BbfyN3d0iXSig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6lKFqppvZ5Fd2fUZhDhkNd5Gb3DuaNIXAEPuky+aEdGjr5CG
	1tw4u/xv6iX2Y+kancUN9dKBdBQFCNmiQSXDSi1eqJNnCFW64w8xAPkMuiqnxwoSsrTWZPrII4X
	b3NnK9A==
X-Received: from pfbbj10.prod.google.com ([2002:a05:6a00:318a:b0:7cf:2dad:ff87])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:438f:b0:827:2ee0:411f
 with SMTP id d2e1a72fcca58-82972b61332mr1138758b3a.4.1772613829535; Wed, 04
 Mar 2026 00:43:49 -0800 (PST)
Date: Wed,  4 Mar 2026 08:42:57 +0000
In-Reply-To: <20260304-br-nd-suppress-ipv6-null-fix-v1-1-084356ba8257@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304-br-nd-suppress-ipv6-null-fix-v1-1-084356ba8257@gmail.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304084348.1075022-1-kuniyu@google.com>
Subject: Re: [PATCH] net: bridge: fix NULL dereference in br_do_suppress_nd
 when ipv6.disable=1
From: Kuniyuki Iwashima <kuniyu@google.com>
To: devnull+maximilianpezzullo.gmail.com@kernel.org
Cc: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	gurucp2005@bugzilla.kernel.org, horms@kernel.org, idosch@nvidia.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, maximilianpezzullo@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 08B681FCC9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,davemloft.net,google.com,bugzilla.kernel.org,kernel.org,nvidia.com,vger.kernel.org,gmail.com,redhat.com,blackwall.org];
	TAGGED_FROM(0.00)[bounces-263654-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,maximilianpezzullo.gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Wed, 04 Mar 2026 09:20:23 +0100
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> When the kernel is booted with ipv6.disable=1, the IPv6 module loads
> but skips full initialization, leaving ipv6_stub as NULL. If the bridge
> neigh_suppress feature is enabled on a port and an ICMPv6 Neighbor
> Solicitation arrives, br_do_suppress_nd() calls neigh_lookup() via
> ipv6_stub->nd_tbl without first checking whether ipv6_stub is valid,
> causing a kernel panic.
> 
> Fix this by returning early if ipv6_stub or its nd_tbl pointer is NULL.
> 
> Reported-by: Guruprasad C P <gurucp2005@bugzilla.kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221143
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> ---
>  net/bridge/br_arp_nd_proxy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 1e2b51769eec..0b1b9ba29b7d 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -455,6 +455,9 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>  		return;
>  	}
>  
> +	if (!ipv6_stub || !ipv6_stub->nd_tbl)
> +		return;

ipv6_stub is never be NULL.

Also, Fernando is already working on the fix.
https://lore.kernel.org/netdev/20260226234059.19402-1-fmancera@suse.de/
https://lore.kernel.org/netdev/20260302140847.5941-1-fmancera@suse.de/


> +
>  	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, vlandev);
>  	if (n) {
>  		struct net_bridge_fdb_entry *f;
> 
> ---
> base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
> change-id: 20260304-br-nd-suppress-ipv6-null-fix-0a516fc27f1a
> 
> Best regards,
> -- 
> Maximilian Pezzullo <maximilianpezzullo@gmail.com>

