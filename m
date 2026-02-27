Return-Path: <netdev+bounces-261722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNGaG4YboWlhqQQAu9opvQ
	(envelope-from <netdev+bounces-261722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 05:20:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 143081B29B5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 05:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8D76307814A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99190356A2B;
	Fri, 27 Feb 2026 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8vu5ywv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8D347FD0
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165695; cv=none; b=Ej+h+Xrtl6MOWrcG5C2J1EKsOyKj3Dgp1rf8z0ZgGBsid+UDwbXAe016AO8/JTvqJiIaKoz/JedYJZlqOMKWEwk8p/LPXIvrh+kOsgg2iRSnQ84xuwBerNPd7s3zV4T9/1FpgWnOox5u7OHafaIxyJQomulkxuJQM3jmbX9bBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165695; c=relaxed/simple;
	bh=Gs/pKQwH9oEtI+kh0WAwy+xeE9gG/o9N9rMwPHZZ6+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR+mim5ag24riaOq73SSnyUXupVDZDcCW+4rEgArhEEkZ/J1lwaREDykS4/k4VFwKlW+ICrmwZrOe+Q3SHbQVIlqRgN/qPYWnGAJVvz4XclfhK3b4mKtKsNmDsqXOoBTw+bKOCKUoeJp2/2w3kWpWakBM8ykULIYZmKb2UnW0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8vu5ywv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so921209a91.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772165694; x=1772770494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUNsocJu+CsJs541F5Hy2fpBAZtIUCUpvMDQ/p/bFPE=;
        b=F8vu5ywvsxLLd82Tk+QvVi8uhCpE6R44sWSO+g5gGL6n35t0wmsX8xRKQ7l5Sbhl0o
         OaEFhUxh+mr+ELszuhljsQl7wqBs2DB3fpUmrcIzWGTwOMlsqu/5/qPlpph74SXz9Xo0
         wrOe0sJnBTNX/6VvKGzkHHhOTGezNyZDZm69XZfZRtMuYtJDjapgdRgfBd2/90JkTGfy
         G1AkZ8+xkCOf9Ni0zHoehX5GhKhjvUop5VMhpiXbLp/GDkmpvvYnUm/mpE4v805C62Qy
         ooouMfJyz+O3m7aJOvbTxZEhQK8vY9y6QGeTaLwhdGRTok7nUEkKehXiNINEiDuXqkiG
         O2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165694; x=1772770494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUNsocJu+CsJs541F5Hy2fpBAZtIUCUpvMDQ/p/bFPE=;
        b=afpfRY7PPzrLbses2zy/eb4ksHNQgEmzn4979URjXqkjz1QrgGJumYGMHGyreFXmkr
         vMGU878syA+5827S5jLg8lnKiL+dlsyCKdESrbS06CPF2ScP/V3/pJcxEWrBbBT/rFvF
         Rk/GRODU1i13X6Pl2T3aO1zUPlpm2n4by0gTOMFBWwkurmDtJ66k/QUZJiCE+Im1RmKs
         erPGaCUaWHvUI3wPoxlZivZaPminUu145VQ9Ri8mmRpStLs8x8yPtwtWzwU+PVBp0qRb
         G/TnCXi5lebt1/yGDafIB2GegpU9kne0GWgb9tiuPs4TK22WSAMZLfKysVr8MX3kigFt
         uKRQ==
X-Gm-Message-State: AOJu0YzYM+3M97J1EFI8DcSvIKoFhNu6I6cYHp+4jBfd3ovscT33KZ8/
	PdUxC/zNOjVbqasYzrLO0Udr2/YQznBqbB91M7+LfFvywELI/UEuh1I4yUkVi/D/2EY=
X-Gm-Gg: ATEYQzx2Xg1PMH8MIcnt8UC3+ePzw784HsBZidLnxCHBzWT4jVhzIoGxvo4FVhFTqYr
	A+s+peIiCBOvCV4bABtEPvRwduqpZowoTwicgSSp1ZWx/qGaetj5PyPe3N/qf5iOXaxsxCcfkfL
	eyxtVdBDAzV0CvxgupHpKvOVo/uzUiL1aTrc2S3bUcgB9Tpl1MFzq6L3QLEYRg5QwLiV4kGg8y2
	PdZiItaUPuSsh+yrLoAPveBvl7P2kgkywUc1B/H6Gl3DzAA33XDXBc8CFlIVV908Td3BY3RAlHu
	WQE8kco6K/EP9AYOhSrSwMbiGlomz41jwhDx4wPoFJTbp02EVKYfFT1hLIj6Xs5nqxNZ+J4w46U
	cuVpV2QRBy5hKKO4/TFwksZawCRQSsx/iqGBQDwcFqZbRc+mHc8gDbUr7Z+iK7jD0oNBbqO2uQw
	V3h1CxAch9RKe7PB9VcapR8WF65tY=
X-Received: by 2002:a17:90a:fc4d:b0:359:1cbd:5495 with SMTP id 98e67ed59e1d1-35965c27e66mr1359669a91.6.1772165693735;
        Thu, 26 Feb 2026 20:14:53 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcc94desm3265535a91.7.2026.02.26.20.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:14:53 -0800 (PST)
Date: Fri, 27 Feb 2026 04:14:45 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net 1/3] bonding: set AD_RX_PORT_DISABLED when
 disabling a port
Message-ID: <aaEaNRof1yjUynNe@fedora>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
 <20260226125331.28147-2-liuhangbin@gmail.com>
 <942584.1772155015@famine>
 <aaEB6X6WPs7EBM33@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaEB6X6WPs7EBM33@fedora>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261722-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,if3:email]
X-Rspamd-Queue-Id: 143081B29B5
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:31:05AM +0000, Hangbin Liu wrote:
> > 	I haven't tested this in some time, though, so my question is
> > whether this change affects the failover time when an active aggregator
> > is de-selected in favor of another aggregator.  By "failover time," I
> > mean how long transmission and/or reception are interrupted when
> > changing from one aggregator to another.  I presume that if aggregator
> > failover ater this change requires LACPDU exchanges, etc, it will take
> > longer to fail over.
> 
> I haven't tested it yet. I think the failover time should be in 1 second.
> Let me do some testing today.

I did a test and the failover takes about 200ms with the environment in patch 03.

Here is the full log

Code: the timer count starts after the old active port link down.
```
ip -n "${c_ns}" link set eth1 down
date +'%F %T.%3N'
ip -n ${c_ns} -d link show eth2
while ! ip -n ${c_ns} -d link show eth2 | grep -q distributing; do
        sleep 0.01
done
date +'%F %T.%3N'
ip -n ${c_ns} -d link show eth2
```

Log:
2026-02-26 22:59:54.334   <-- The time when eth1 link down

5: eth2@if3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
    link/ether 12:40:54:81:d3:80 brd ff:ff:ff:ff:ff:ff link-netns b_ns-PKIXVg promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state BACKUP mii_status UP link_failure_count 0 perm_hwaddr 26:10:46:58:22:e4 queue_id 0 prio 0 ad_aggregator_id 2 ad_actor_oper_port_state 7 ad_actor_oper_port_state_str <active,short_timeout,aggregating> ad_partner_oper_port_state 15 ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync> actor_port_prio 1000 addrgenmode eui64 numtxqueues 4 numrxqueues 4 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

2026-02-26 22:59:54.529   <--- The time when eth2 enter collecting,distributing state

5: eth2@if3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
    link/ether 12:40:54:81:d3:80 brd ff:ff:ff:ff:ff:ff link-netns b_ns-PKIXVg promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state ACTIVE mii_status UP link_failure_count 0 perm_hwaddr 26:10:46:58:22:e4 queue_id 0 prio 0 ad_aggregator_id 2 ad_actor_oper_port_state 63 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state 63 ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 1000 addrgenmode eui64 numtxqueues 4 numrxqueues 4 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

Thanks
Hangbin

