Return-Path: <netdev+bounces-248922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8344AD11664
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 295D83026D80
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66D346E53;
	Mon, 12 Jan 2026 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrlKWx+y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C593346E61
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208600; cv=none; b=SXp20T85ZSyqocAVP/fPCGRSTB1J/ZM5epjP5LquTV2ErdpJ9UFFIqil6S5d8i3yffQQgueWteJfQxM5I54PqiSyL6tV2uaMeyG3RiHxOJ8MccYSALCdEJGN4q5AH4BCBbraEH4sO2kssz2NSKLweS7Wn5FCQyohWyu2vIS280Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208600; c=relaxed/simple;
	bh=uIlL1TesxPAL+j5ySj25Skrss4WO/SL0ackhRPMVxYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1+Pd0lfMYbRFL7vGV7BTBe7eSmjvXCM4sWy3UDfPRNYsiLKMibuHybL7EKKzifHu8il1hb/WpStnNnZ96ASzSqxkWWSTpIuHrwUZPi66Fay1Sqzy+GncMhcQL/wahu7QA007cThSfSLxdLaeaIDBS1lOTr/kr9OmWz5BYlFzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrlKWx+y; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ffa95fc5f1so62970791cf.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 01:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768208595; x=1768813395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYekpeL873Q/xCGRxoaN26TWZbwOPIDS4BfElGQRGaY=;
        b=YrlKWx+yW2bXoK5hlaTBCUzKWfs8EjHXNIKlVGr37nMk9RH7zHwebNH/jUpXbEmEJp
         z3OlYkYPAu5G0NUhRycZWpubneZQCwRF9mHbH0hsY3ug1B+oWynfuQebgf0i8AyDYXIA
         FTXHj7pWcLC/QNzcfT748e449MxHzQ2M5nml/X238SbOmicD211yhpGfG4fu1ucA2mhl
         ULvSvBgPJQIaajdwcGwAczUmSoMQbGwPdkGd0Q0yS+I8eX3uhNYKte0GlzuW3JcIghWD
         74GGdG3wb1wkj7D3uoYx/gQ3euOIO4J/+oDeZhi+9H4lJGJ3f3ZHCn3o6LzCfVyAgIsr
         PE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768208595; x=1768813395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYekpeL873Q/xCGRxoaN26TWZbwOPIDS4BfElGQRGaY=;
        b=pFHOKJZrVZdOvCQEJ+eagBWOpxf8l/CHNSpPeqJ1K/5MJRAPxKeCvZaE3pjMiq2ljk
         cYppeMY1IYRio/KGXgtYcPhEyTMGAl2ufp7+agFTeNj4jPfk6JsdGKCxT/+tTt+VNHtu
         x3ab3fHTtpbiXnksALyDBkamyQzrD4BIjyfBkISWqfZgw6qhioBuHlpj/lJhiHcErt29
         BQeiuV0FTP1SEA++UXasT36ZkcKzlPh0uq7zrKCoQYeuesBnOuMiWWz76O0ffcLbM7FX
         72juEXHcj98HDXTevM1aSmFDyXpVkdnt6OPXuVLwNe85oj82xvOUcFlfR1DmN89qdZYy
         r7qA==
X-Forwarded-Encrypted: i=1; AJvYcCXCuAHJOfZ57yBMWOCRON0/af4UiXyzs0zOGLSDdQ/pd0x41+EK/iEjmOzQ6CBInkqsqnv/Oqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9UDpDzXQKlMPcYj9mjxGVIVuHy95an+eBFE2pfzyMnURrcc7
	jLbzsI+T9WW4rvmLXm9q7vwfiEQG7PEZjk0tykkxULK64kxsCqc3K2QVsONMHNhM6jHci5snw9g
	j2c+KrT8r1mLnNkubS1XQvsHP8pR8w9FzE3cTrptZ
X-Gm-Gg: AY/fxX6xeeVU1CYEimZC1z3oH7YA+5+UQrKJ+jZqZgfr04KCsKtHasFx5AoEZrq/iLX
	o9gyF4p45o2N7Q++ZKWch0h/sfCbsIDonrZee96BGV0dFwPTVXQSvYGar9aALsExKoIEpr8FvuR
	v3Y0WKxV/1DgPZR1DDlOwO3AzDS5fjMROSLBXe5L0xm3nS+powC2qpgJlQebkTZlACXV959v9fu
	PN7kMbStbERWgzYWQTTbPzRR0izSRp02G21EPlZ0NSJ7TlrJyJ0o6QGTShu+UeD/qdsrLo=
X-Google-Smtp-Source: AGHT+IErfp9tA43Y2SyvQ1LCTByw91YVng252tRwj4dEGmt8yb/8X/4f8MgmVarviI+MFyvNG9TMZsB4gbUEVfpiCzk=
X-Received: by 2002:a05:622a:608:b0:4f1:bdb8:b05 with SMTP id
 d75a77b69052e-4ffb4a5d526mr238735781cf.72.1768208594421; Mon, 12 Jan 2026
 01:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112075939.2509397-1-chenzhen126@huawei.com> <20260112075939.2509397-2-chenzhen126@huawei.com>
In-Reply-To: <20260112075939.2509397-2-chenzhen126@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Jan 2026 10:03:03 +0100
X-Gm-Features: AZwV_QjuCVefdPk58sVMmu3aCg3YxPUshT_sD2m4if7Fahn2gAkwMBnJr09KNKM
Message-ID: <CANn89iL5TbT24Xy_=9SrqE=QJ-aF2V+jiuUY37KBnjK-qPcefQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/2] net: vlan: set header_ops to match
 hard_header_len when hw offload is toggled
To: Chen Zhen <chenzhen126@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, huyizhen2@huawei.com, 
	gaoxingwang1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 8:49=E2=80=AFAM Chen Zhen <chenzhen126@huawei.com> =
wrote:
>
> When tx-vlan-hw-insert is toggled to on, vlan device hard_header_len
> will be reduced to dev->hard_header_len since commit 029f5fc31cdb
> ("8021q: set hard_header_len when VLAN offload features are toggled"),
> but the header_ops remains unchanged, ndisc skb will be allocated
> with this len and filled in vlan hdr in vlan_dev_hard_header(), but
> with reorder_hdr off, the skb room is not enough so it triggers
> skb_panic() as below:
>
> skbuff: skb_under_panic: text:ffffffffa0535126 len:90 put:14
>  head:ffff916c04232ec0 data:ffff916c04232ebe tail:0x58 end:0x180 dev:veth=
0.10
> ------------[ cut here ]------------
>  kernel BUG at net/core/skbuff.c:197!
>  <TASK>
>   skb_push+0x39/0x40 net/core/skbuff.c:207
>   eth_header+0x26/0xb0 net/ethernet/eth.c:90
>   vlan_dev_hard_header+0x58/0x130 net/8021q/vlan_dev.c:85 [8021q]
>   neigh_connected_output+0xae/0x100 net/core/neighbour.c:1589
>   ip6_finish_output2+0x2cc/0x650 net/ipv6/ip6_output.c:213
>   ip6_finish_output+0x27/0xd0 net/ipv6/ip6_output.c:246
>   ndisc_send_skb+0x1d0/0x370 net/ipv6/ndisc.c:516
>   ndisc_send_ns+0x5a/0xb0 net/ipv6/ndisc.c:672
>   addrconf_dad_work+0x2b5/0x380 net/ipv6/addrconf.c:4258
>   process_one_work+0x17f/0x320 kernel/workqueue.c:2743
>
> Fix this by also setting header_ops of vlan dev when offload feature
> is toggled.
>
> Fixes: 029f5fc31cdb ("8021q: set hard_header_len when VLAN offload featur=
es are toggled")
> Signed-off-by: Chen Zhen <chenzhen126@huawei.com>
> ---
>  net/8021q/vlan.c     |  5 +----
>  net/8021q/vlan.h     |  3 +++
>  net/8021q/vlan_dev.c | 22 ++++++++++++++--------
>  3 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index 2b74ed56eb16..84b3a3f67996 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -323,10 +323,7 @@ static void vlan_transfer_features(struct net_device=
 *dev,
>
>         netif_inherit_tso_max(vlandev, dev);
>
> -       if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
> -               vlandev->hard_header_len =3D dev->hard_header_len;
> -       else
> -               vlandev->hard_header_len =3D dev->hard_header_len + VLAN_=
HLEN;
> +       vlan_dev_set_header_attributes(dev, vlandev, vlan->vlan_proto);
>
>  #if IS_ENABLED(CONFIG_FCOE)
>         vlandev->fcoe_ddp_xid =3D dev->fcoe_ddp_xid;
> diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
> index c7ffe591d593..1d837814e061 100644
> --- a/net/8021q/vlan.h
> +++ b/net/8021q/vlan.h
> @@ -143,6 +143,9 @@ int register_vlan_dev(struct net_device *dev, struct =
netlink_ext_ack *extack);
>  void unregister_vlan_dev(struct net_device *dev, struct list_head *head)=
;
>  bool vlan_dev_inherit_address(struct net_device *dev,
>                               struct net_device *real_dev);
> +void vlan_dev_set_header_attributes(struct net_device *dev,
> +                                   struct net_device *vlan_dev,
> +                                   __be16 proto);
>
>  static inline u32 vlan_get_ingress_priority(struct net_device *dev,
>                                             u16 vlan_tci)
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index fbf296137b09..1fe171748711 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -519,6 +519,19 @@ static const struct device_type vlan_type =3D {
>
>  static const struct net_device_ops vlan_netdev_ops;
>
> +void vlan_dev_set_header_attributes(struct net_device *dev,
> +                                   struct net_device *vlan_dev,
> +                                   __be16 proto)
> +{
> +       if (vlan_hw_offload_capable(dev->features, proto)) {
> +               vlan_dev->header_ops      =3D &vlan_passthru_header_ops;
> +               vlan_dev->hard_header_len =3D dev->hard_header_len;
> +       } else {
> +               vlan_dev->header_ops      =3D &vlan_header_ops;
> +               vlan_dev->hard_header_len =3D dev->hard_header_len + VLAN=
_HLEN;
> +       }
> +}
> +
>  static int vlan_dev_init(struct net_device *dev)
>  {
>         struct vlan_dev_priv *vlan =3D vlan_dev_priv(dev);
> @@ -572,14 +585,7 @@ static int vlan_dev_init(struct net_device *dev)
>  #endif
>
>         dev->needed_headroom =3D real_dev->needed_headroom;
> -       if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)=
) {
> -               dev->header_ops      =3D &vlan_passthru_header_ops;
> -               dev->hard_header_len =3D real_dev->hard_header_len;
> -       } else {
> -               dev->header_ops      =3D &vlan_header_ops;
> -               dev->hard_header_len =3D real_dev->hard_header_len + VLAN=
_HLEN;
> -       }
> -
> +       vlan_dev_set_header_attributes(real_dev, dev, vlan->vlan_proto);
>         dev->netdev_ops =3D &vlan_netdev_ops;
>
>         SET_NETDEV_DEVTYPE(dev, &vlan_type);
> --
> 2.33.0
>

While nice to have, I think a race is still possible.

Some callers might see different hard_header_len values along their
path and crash.

Look at

 commit db5b4e39c4e63700c68a7e65fc4e1f1375273476
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Dec 11 17:35:50 2025 +0000

    ip6_gre: make ip6gre_header() robust


My suggestion would be to always add VLAN_HLEN in hard_header_len,
even if the 'current' operational mode would not request it.

