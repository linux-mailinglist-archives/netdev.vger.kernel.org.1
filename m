Return-Path: <netdev+bounces-173094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CDCA57298
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDED1893D2F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC0121859D;
	Fri,  7 Mar 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTRQ7AI+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E720FA9C
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377452; cv=none; b=dAMv6kqjsNHI8JqbVdkLVkq7NwdjOnnRh2tISImDWiHEIxUTFjiZQC3s1WWFCc3X0eecm0leISbtt0NA4MZPPM01iv/TjNZFvTCt22YPmWKb8wictQqozGB6JVQtQhHiBIGT9mjQ3MHHXeo6d6r/VFwSV5m2yu9I5es0U87U3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377452; c=relaxed/simple;
	bh=xBwsZvR9mPYzHqQQdYsBF3K26HDAZLbrQKyvYv1EvJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxFHT9LD83/RgjXicclRwqYjg/PdcCzRRsOjSJ1fptIcr/wUZ/GnyNspS3kNhighSNws7LwLpDzUxSB9nRYvL9wzKkES72jB1MxkMlyqHXeCDjmu0CF+4RjpN/oIIiieb+UxChMyE3luhRFyex4ZltAMyYqVpf2O8HhQRbaawdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTRQ7AI+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22359001f1aso57499115ad.3
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 11:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741377450; x=1741982250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=36nySxrL1jZFx9QGQRXVKg6cBig4ikBt3d9GDE0V3wc=;
        b=TTRQ7AI+rn7+OLxTPgX65tkYB49T6N2Bb/8ON82F5A0rCzRYsVlnaZgPbdZbfMlrkO
         SgwgdsxvLMlPs8XtW1zAnIub6Ci4x48luNcgw5Osgmk6qIQvgyn6irbk6af8A4akZblX
         2HmXYK3L80YeAdHqxqvnZAKvi6oebQVcxDDgdaKsguYjcQQr+E67GL5Fo3uaSGZaRkSd
         J4HD7H5kqQIQx/5GZaf+FboM6lUvzbHkDAMmVNq35KebUR+rAfpn10jJ3Qb60VweoWDw
         rZF22xkfnehNgZpwKveSz31/Xuskak0CMi7VmYsefnGe8lkRhfxn+gg2f9k0RPN6M4Le
         JeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741377450; x=1741982250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36nySxrL1jZFx9QGQRXVKg6cBig4ikBt3d9GDE0V3wc=;
        b=m09oAsvGqd0hl+Br39DgHPmb1Ry0VyUKXCMsRjzgSTuT1YWK7VTrwPV8C8X5/8tcIh
         z6vLx0/Qe0qiSvDer7HEk7hinwkZIudbYnHXbfMj5NUuL7tMSHMT0bh21o16boEv/z63
         Xg8eWzaCEXi55etkW0sMh6dBVqb/WtQ7F056g5FS2+GTQ90ZzTDoHSLr+dF8dc3xnGeF
         Z6G8OyleJCj+8xiZA00ybQsfoZwuQ8qfvZHvggYTJnxT6vzzfY3JI2aUUzYCywW61qVa
         RGldlOvGmso/WrsN7y2n0WZ9MqYxOJMxJC8ypMzG3oYtXkSraViAddzElqdBYrCReVbP
         aD3g==
X-Forwarded-Encrypted: i=1; AJvYcCU6Tr363fEXWb7DaaTDDAYbHYk1+NvSJ36dR79TlUAIugCKtJ+vCUlbUbsB2p1/BRpaDIazAZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXnb8qLRgVtowmn3vHKK8POdnno/T4mo7sXA2bT+nMMnOdhZGZ
	fqWsyNumC1ixYb80HNuSEQRE0tIZ3JMhok2wIEt7ihE9ALynMHE=
X-Gm-Gg: ASbGncvLr5qnveEvlKxYFPo+A+Sy5jiy2Dd2TiJPJsXQIXi02Q4Eay7IQlWy9JKW0G2
	bcOqNla85oFY8AyeM5DR9O7JeMnhtmxERuF/uZTBzdySD8+1afUyuQ4K17FdQAo0BUUEPrlSYbs
	UyhxFz6jPbcPl2Qa+p9HdnFO8GOXy9NpIrzFNYb+2wXOphF5GFkWqQ6nxVIQGx6Y7VzgOotnJ1O
	qWz5EfWcmF+nqC9zMNuJ7geP8LrwFMsXritmuHipSajgb+YV+ItsE1/j31P711DX/F8tRL0MCz+
	EzoB3aWoVtpY79K7hRS74GEwXdxiKcUu+RJ4/nv/dFEh
X-Google-Smtp-Source: AGHT+IEfsHWWvj7kyaSO+OVlRBUZkOuVgbTLfibFBn7dcBNWxaFhwVyjZ6nOA6RhtBswv7yrfRXtKQ==
X-Received: by 2002:a05:6a20:1594:b0:1ee:cf5d:c05e with SMTP id adf61e73a8af0-1f544c37ee6mr8278698637.9.1741377449585;
        Fri, 07 Mar 2025 11:57:29 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af281095d74sm3420790a12.17.2025.03.07.11.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:57:29 -0800 (PST)
Date: Fri, 7 Mar 2025 11:57:28 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>, pablo@netfilter.org
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v10 02/14] net: hold netdev instance lock during
 nft ndo_setup_tc
Message-ID: <Z8tPqAawOF8p1Zr8@mini-arch>
References: <20250305163732.2766420-1-sdf@fomichev.me>
 <20250305163732.2766420-3-sdf@fomichev.me>
 <CANn89iJemkvpsQ6LgefYvBBC_foXr=1wrwf7QN25wpX-2QZPiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJemkvpsQ6LgefYvBBC_foXr=1wrwf7QN25wpX-2QZPiQ@mail.gmail.com>

On 03/07, Eric Dumazet wrote:
> On Wed, Mar 5, 2025 at 5:37 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Introduce new dev_setup_tc for nft ndo_setup_tc paths.
> >
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Cc: Saeed Mahameed <saeed@kernel.org>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_main.c |  2 --
> >  include/linux/netdevice.h                   |  2 ++
> >  net/core/dev.c                              | 18 ++++++++++++++++++
> >  net/netfilter/nf_flow_table_offload.c       |  2 +-
> >  net/netfilter/nf_tables_offload.c           |  2 +-
> >  5 files changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > index 9f4d223dffcf..032e1a58af6f 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -3894,10 +3894,8 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
> >         if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
> >                 return 0;
> >
> > -       netdev_lock(netdev);
> >         netif_set_real_num_rx_queues(netdev, total_qps);
> >         netif_set_real_num_tx_queues(netdev, total_qps);
> > -       netdev_unlock(netdev);
> >
> >         return ret;
> >  }
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 33066b155c84..69951eeb96d2 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3353,6 +3353,8 @@ int dev_alloc_name(struct net_device *dev, const char *name);
> >  int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
> >  void dev_close(struct net_device *dev);
> >  void dev_close_many(struct list_head *head, bool unlink);
> > +int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
> > +                void *type_data);
> >  void dev_disable_lro(struct net_device *dev);
> >  int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
> >  u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 7a327c782ea4..57af25683ea1 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -1786,6 +1786,24 @@ void dev_close(struct net_device *dev)
> >  }
> >  EXPORT_SYMBOL(dev_close);
> >
> > +int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
> > +                void *type_data)
> > +{
> > +       const struct net_device_ops *ops = dev->netdev_ops;
> > +       int ret;
> > +
> > +       ASSERT_RTNL();
> > +
> > +       if (!ops->ndo_setup_tc)
> > +               return -EOPNOTSUPP;
> > +
> > +       netdev_lock_ops(dev);
> > +       ret = ops->ndo_setup_tc(dev, type, type_data);
> > +       netdev_unlock_ops(dev);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL(dev_setup_tc);
> >
> >  /**
> >   *     dev_disable_lro - disable Large Receive Offload on a device
> > diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
> > index e06bc36f49fe..0ec4abded10d 100644
> > --- a/net/netfilter/nf_flow_table_offload.c
> > +++ b/net/netfilter/nf_flow_table_offload.c
> > @@ -1175,7 +1175,7 @@ static int nf_flow_table_offload_cmd(struct flow_block_offload *bo,
> >         nf_flow_table_block_offload_init(bo, dev_net(dev), cmd, flowtable,
> >                                          extack);
> >         down_write(&flowtable->flow_block_lock);
> > -       err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, bo);
> > +       err = dev_setup_tc(dev, TC_SETUP_FT, bo);
> >         up_write(&flowtable->flow_block_lock);
> >         if (err < 0)
> >                 return err;
> > diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> > index 64675f1c7f29..b761899c143c 100644
> > --- a/net/netfilter/nf_tables_offload.c
> > +++ b/net/netfilter/nf_tables_offload.c
> > @@ -390,7 +390,7 @@ static int nft_block_offload_cmd(struct nft_base_chain *chain,
> >
> >         nft_flow_block_offload_init(&bo, dev_net(dev), cmd, chain, &extack);
> >
> > -       err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
> > +       err = dev_setup_tc(dev, TC_SETUP_BLOCK, &bo);
> >         if (err < 0)
> >                 return err;
> >
> 
> It seems RTNL was not taken in this path, can you take a look ?
> 
> syzbot reported :
> 
> RTNL: assertion failed at net/core/dev.c (1769)
> WARNING: CPU: 1 PID: 9148 at net/core/dev.c:1769
> dev_setup_tc+0x315/0x360 net/core/dev.c:1769
> Modules linked in:
> CPU: 1 UID: 0 PID: 9148 Comm: syz.3.1494 Not tainted
> 6.14.0-rc5-syzkaller-01064-g2525e16a2bae #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 02/12/2025
> RIP: 0010:dev_setup_tc+0x315/0x360 net/core/dev.c:1769
> Code: cc 49 89 ee e8 dc da f7 f7 c6 05 c0 39 5d 06 01 90 48 c7 c7 a0
> 5e 2e 8d 48 c7 c6 80 5e 2e 8d ba e9 06 00 00 e8 3c 97 b7 f7 90 <0f> 0b
> 90 90 e9 66 fd ff ff 89 d1 80 e1 07 38 c1 0f 8c aa fd ff ff
> RSP: 0018:ffffc9000be3eed0 EFLAGS: 00010246
> RAX: eea924c6092c5700 RBX: 0000000000000000 RCX: 0000000000080000
> RDX: ffffc9000c979000 RSI: 000000000000491b RDI: 000000000000491c
> RBP: ffff88802a810008 R08: ffffffff81818e32 R09: fffffbfff1d3a67c
> R10: dffffc0000000000 R11: fffffbfff1d3a67c R12: ffffc9000be3f070
> R13: ffffffff8d4ab1e0 R14: ffff88802a810008 R15: ffff88802a810000
> FS: 00007fbe7aece6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c2b5042 CR3: 0000000024cd0000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> nf_flow_table_offload_cmd net/netfilter/nf_flow_table_offload.c:1178 [inline]
> nf_flow_table_offload_setup+0x2ff/0x710
> net/netfilter/nf_flow_table_offload.c:1198
> nft_register_flowtable_net_hooks+0x24c/0x570 net/netfilter/nf_tables_api.c:8918
> nf_tables_newflowtable+0x19f4/0x23d0 net/netfilter/nf_tables_api.c:9139
> nfnetlink_rcv_batch net/netfilter/nfnetlink.c:524 [inline]
> nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
> nfnetlink_rcv+0x14e3/0x2ab0 net/netfilter/nfnetlink.c:665
> netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
> netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
> netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
> sock_sendmsg_nosec net/socket.c:709 [inline]
> __sock_sendmsg+0x221/0x270 net/socket.c:724
> ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
> ___sys_sendmsg net/socket.c:2618 [inline]
> __sys_sendmsg+0x269/0x350 net/socket.c:2650
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbe79f8d169

Interesting. Looks like this path (and same for nft_block_offload_cmd?) was
never grabbing grabbing rtnl_lock but calling device's ndo_setup_tc.
Will take a look! CC'd Pablo in case it was by design.

