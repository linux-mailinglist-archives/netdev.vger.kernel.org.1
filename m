Return-Path: <netdev+bounces-156961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9A8A0868C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 06:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E20160DFE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 05:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292221E2602;
	Fri, 10 Jan 2025 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZeLpnWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A326746E
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487213; cv=none; b=SzSjPaiX/TipR53LISdAAUouQkMbjyaftbF2bHp+qE/XuOmN9Yeff8Du0HytoEVz0WVCjym2fi72dpgo/RJapQIa8Rr3kb/LBbCKAYSaJ7hI2wbXqqZzsEHzkRoP1NHguO1dX/SoZi3fV1vn/mQQ6Hyoj5pPxo3l96Dzsc8fEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487213; c=relaxed/simple;
	bh=hxRTMp4mpwSU8jnHghh6r5i8faflXs6Biek6mneBQ78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMKaTgTdlM+o1mGLhjfSjxo+IBl3GIueUV8v0Ci13fhMS/T9qznT/2SEQyW+oFBDrLKmzwM0OyeGS6WeA5ZL9Xq6JQY7XWuG+vur8aJc9d8BuKFLVpynFBVitkx/O0P9j76RnAI/3wTpXhuO8zibwP1K7PGuTUiQ1i3V9Chahhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZeLpnWN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b662090so25407045ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 21:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736487211; x=1737092011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdP1H6r78BZYoDOcYSzOfB3PzRaCWyLA9wYEqm3AXu4=;
        b=XZeLpnWNJ9bNrIhnr2UDdzZOe0oq8IQD33+7Kw5CLrhtFKwSakE9E2rhDGNckzAgqm
         9jsPoRSxc0VL2us4CujHRPQbaPyPOtKDUIWGR0Ey/Z+A99iFD+3HfbZqR4crbbp2U0Ia
         gRTiXZ1+XcmqFnfN2Y7NMXmqkKCstVAjVWiSLwq2gq+d+TuLl7ha/eW781q4mh8Oa32c
         XsZgOucD31DIqY+NiA464eIv0eaGIsnoWs/njU/gJ5/47jHjk6BWGhDBRunXsbkONq9d
         aCiD/cVvAa9uyyn0EgUf/iF9/DQvyTqCtSkKyWjkZmo7lBei2o/WigveoQFq0h63NnJs
         2zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736487211; x=1737092011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdP1H6r78BZYoDOcYSzOfB3PzRaCWyLA9wYEqm3AXu4=;
        b=xTERdmoyEHBF4c7YiBdNA71S0qQ0gKwdgGSPqifecCk/pzSelNqAYYo9fALoWt+74M
         UIxCqyXtzZ4pHd2SqBg0CnzxgsJhaQXilMQtG+7zw0R/GI0LeCRj5Daco8vMI9x8wuaX
         WOt2WP4GONHuwmPf04dQOjoTmVG9I3CCYt8Vj60Tl1+fX4qqdKlrhXfUwVvdm8eZx0AI
         thK3HIoQG+DSBXj4FPuxIQqLMZENJeR1oPA+eyoGPAzFmOsf4y1kdBuw36RI5ildB5cx
         sDMgpmlAaqSc5WTbD0lCAmM4t+V8aEDMvE4EAvJnzMNY1BB8B4pwSXGBpBkxrKYJNEc3
         igDA==
X-Forwarded-Encrypted: i=1; AJvYcCUE77ap3XF0Oe6lJa7hPQ6PiXb6HwI99rOArTOguurDuiVj9CU5GoY7E8K5p/IrciWle92miig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1UekVjgWR3vZeEl0RTVOeM1vLvz+IsMZhHkhPMCu/Gwuf8wpA
	LBGlHiDwG2GPO78oqA8f6v5rNupTv+py5UgpFFp1sHJpscuY5A34
X-Gm-Gg: ASbGncsFNabIBJTaKPaukvQhWYCXr1sQxNsWXi7ngcwyFHGT1uw+i6bXvsrUalIhU+k
	MCOhi1JqDDMVpbF104qSoSLu3kdJ11Brm2LJZ3cjWixW4dwz+soaiOIrBHFt2dYURo+lfGzjRCT
	U70P8v61Of2KscJDruH8sG/rKxGub/tFGhWyO20Xo1gZ/3dfcY059SXU6gbCfbMETwXq++ZRb6z
	yKxIqASE7l7delU3pcEJyTWWsAmW5mazeKIQNoCCwVOdUMymuNqZX2LXKnSbDs=
X-Google-Smtp-Source: AGHT+IGpXFgYx9QBLE5BKejw1lewtZBlVvulP0O6fcBeqATluc3tQ9vdFbitVdliacGQaxfngJHDXg==
X-Received: by 2002:a17:902:ccc3:b0:216:2bd7:1c27 with SMTP id d9443c01a7336-21a83f72b8cmr144395715ad.33.1736487210762;
        Thu, 09 Jan 2025 21:33:30 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:c586:91c7:b7f1:d942])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a26ac5esm4668711a91.5.2025.01.09.21.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 21:33:30 -0800 (PST)
Date: Thu, 9 Jan 2025 21:33:29 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: sched: calls synchronize_net() only when
 needed
Message-ID: <Z4CxKV5AnfDPRfaF@pop-os.localdomain>
References: <20250109171850.2871194-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109171850.2871194-1-edumazet@google.com>

On Thu, Jan 09, 2025 at 05:18:50PM +0000, Eric Dumazet wrote:
> dev_deactivate_many() role is to remove the qdiscs
> of a network device.
> 
> When/if a qdisc is dismantled, an rcu grace period
> is needed to make sure all outstanding qdisc enqueue
> are done before we proceed with a qdisc reset.
> 
> Most virtual devices do not have a qdisc (if we exclude
> noqueue ones).

Such as? To me, most virtual devices use noqueue:

$ git grep IFF_NO_QUEUE -- drivers/net/
drivers/net/amt.c:      dev->priv_flags         |= IFF_NO_QUEUE;
drivers/net/bareudp.c:  dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/bonding/bond_main.c:        bond_dev->priv_flags |= IFF_BONDING | IFF_UNICAST_FLT | IFF_NO_QUEUE;
drivers/net/caif/caif_serial.c: dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/dummy.c:    dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:        dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/ethernet/netronome/nfp/nfp_net_repr.c:      netdev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
drivers/net/geneve.c:   dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
drivers/net/gtp.c:      dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/ipvlan/ipvlan_main.c:       dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
drivers/net/ipvlan/ipvtap.c:    dev->priv_flags &= ~IFF_NO_QUEUE;
drivers/net/loopback.c: dev->priv_flags         |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
drivers/net/macsec.c:   dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/macvlan.c:  dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/net_failover.c:     failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
drivers/net/netdevsim/netdev.c:                    IFF_NO_QUEUE;
drivers/net/netkit.c:   dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/nlmon.c:    dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/pfcp.c:     dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/team/team_core.c:   dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/veth.c:     dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/vrf.c:      dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/vsockmon.c: dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/vxlan/vxlan_core.c: dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/wan/hdlc_fr.c:      dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/wireguard/device.c: dev->priv_flags |= IFF_NO_QUEUE;
drivers/net/wireless/virtual/mac80211_hwsim.c:  dev->priv_flags |= IFF_NO_QUEUE;


And noqueue_qdisc_ops sets ->enqueue to noop_enqueue():

struct Qdisc_ops noqueue_qdisc_ops __read_mostly = {
        .id             =       "noqueue",
        .priv_size      =       0,
        .init           =       noqueue_init,
        .enqueue        =       noop_enqueue,
        .dequeue        =       noop_dequeue,
        .peek           =       noop_dequeue,
        .owner          =       THIS_MODULE,
};

Thanks.

