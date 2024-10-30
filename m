Return-Path: <netdev+bounces-140550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6849B6DF2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8772819EF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EC8213136;
	Wed, 30 Oct 2024 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hItd5qp9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B7205AC7
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320777; cv=none; b=tikR5b1ESj0zmsPoyaMkAlGn692JqGuUUZt43ojLBSr6ScuuwoGz6D/qIbQ7JP7Aaxg8idFm6ReE8bKaEVZ+HGnlwG5DfahKEOiuGKpAIqvyX1hU8xzYgwSz5so5sUamMx9XVgcl4L6eDUZw0EVufhMMzetruIB/xFUVNIf2apY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320777; c=relaxed/simple;
	bh=TxazTRsHHPQ610urISAHNKk7dOK31X6k7lxlztysTSg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8/Jqv905jO4IPf5oU8MDvDu2AioJ0D2Pxylc0kQ8WKtvp/E8wxbRlSRSa9FjhsdkuC2SfJzsM5jRlJrqxos7jqEe60+9M2ukONMpfepmev+lEFchun1WcsE0OoSAz5su6emE+GGjdQwKnN8ri9XZnFZGilSBHN6LzDargJ2HfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hItd5qp9; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b14f3927ddso16236385a.3
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730320774; x=1730925574; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rE/QfYn16jnRJDVP8Nela8ifJJQ5nLJ6NC2S82ORqmU=;
        b=hItd5qp9oNUyd2x5uwtfu0twfyGRqM4k0PqR/O754trZzPvsylqbzTiZm91E2lwYMM
         LleA+kjFvhWNGtEsZ32u4cltuNNVT6Y4FiEk3f2DPQdnj+IC/RgT0xrDuJS/D/mEPEDH
         Rni33ZMhB0Xiq0qIhHhPgbiHPOWnLpvagCamM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320774; x=1730925574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rE/QfYn16jnRJDVP8Nela8ifJJQ5nLJ6NC2S82ORqmU=;
        b=WUInvuCZTf2ZBARu4hEJQ7lJK3irT5LeMjLeCkRTErv0HZdMVDgIFhjiLGHyNHpe+D
         0wjZu3WQZfJrRn6z6X0yhIDVoGwbSi4pKtS+hvkKJpmuSnjjM6QoXasQr5WSek+ASr3Z
         ug8dlaOoeN3pQtTLNeDmeMWtJMiRhh9jfiB4eJOpLAUYJ00847SBFtYDAOc2HEIgP+kS
         rqst4OWYztGhXZ7fGoGZnejY3r1Epf+qt8+iVrxPDDpzMsynlm2Dp5zLeqWNCWGyH+tA
         NmFwFCNjMbtRF7pNAgDZjC6WFCT7ZMoPkRIm6P5pDfQo8XdXi2YO/xEPgYykmq9TL1c8
         IeuA==
X-Forwarded-Encrypted: i=1; AJvYcCX9S5e8yheCmOhn+HKkmPKGVpg6JOpc7tEJwXj+vC5ZlC78LZHPSQZJpMK/LsfGUFFwE1T7NjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWLVcS5Z4s/eDThwfhpE8eEYi3/VUQ4Z2IFsZEBGDnZ1oZjE1S
	O8juZ/FyF5D9xRdf6pLWucYtAc05JhKm6UklJXuiqLzFhnB7cVFs5Vxo+Rj4Mg==
X-Google-Smtp-Source: AGHT+IEyXvDMgjCJpXlH30SpQ30IvVpafb5ds6H7r+JkBg2Lgh1IfpfIZJ5RUlFH7s36Cb5OruHphQ==
X-Received: by 2002:a05:620a:24d3:b0:7b1:1a1e:3013 with SMTP id af79cd13be357-7b193ed6f69mr2357095385a.8.1730320774215;
        Wed, 30 Oct 2024 13:39:34 -0700 (PDT)
Received: from JRM7P7Q02P.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39e992esm2906285a.25.2024.10.30.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:39:33 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Wed, 30 Oct 2024 16:39:23 -0400
To: Taehee Yoo <ap420073@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, almasrymina@google.com,
	donald.hunter@gmail.com, corbet@lwn.net, andrew+netdev@lunn.ch,
	hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, dw@davidwei.uk,
	sdf@fomichev.me, asml.silence@gmail.com, brett.creeley@amd.com,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
	danieller@nvidia.com, hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com, ahmed.zaki@intel.com, rrameshbabu@nvidia.com,
	idosch@nvidia.com, jiri@resnulli.us, bigeasy@linutronix.de,
	lorenzo@kernel.org, jdamato@fastly.com,
	aleksander.lobakin@intel.com, kaiyuanz@google.com,
	willemb@google.com, daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v4 2/8] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <ZyKZe9a20cQwEhFd@JRM7P7Q02P.dhcp.broadcom.net>
References: <20241022162359.2713094-1-ap420073@gmail.com>
 <20241022162359.2713094-3-ap420073@gmail.com>
 <CACKFLikBKi2jBNG6_O1uFUmMwfBC30ef5AG4ACjVv_K=vv38PA@mail.gmail.com>
 <ZxvwZmJsdFOStYcV@JRM7P7Q02P.dhcp.broadcom.net>
 <CACKFLinbsMQE1jb0G-7iMKAo4ZMKp42xiSCZ0XznBV9pDAs3-g@mail.gmail.com>
 <CAMArcTWrA0ib9XHnSGGH-sNqQ9TG0BaRq+5nsGC3iQv6Zd40rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMArcTWrA0ib9XHnSGGH-sNqQ9TG0BaRq+5nsGC3iQv6Zd40rQ@mail.gmail.com>

On Sat, Oct 26, 2024 at 02:11:15PM +0900, Taehee Yoo wrote:
> On Sat, Oct 26, 2024 at 7:00 AM Michael Chan <michael.chan@broadcom.com> wrote:
> >
> > On Fri, Oct 25, 2024 at 12:24 PM Andy Gospodarek
> > <andrew.gospodarek@broadcom.com> wrote:
> 
> Hi Andy,
> Thank you so much for your review!
> 
> > >
> > > On Thu, Oct 24, 2024 at 10:02:30PM -0700, Michael Chan wrote:
> > > > On Tue, Oct 22, 2024 at 9:24 AM Taehee Yoo <ap420073@gmail.com> wrote:
> > > > >
> > > > > NICs that uses bnxt_en driver supports tcp-data-split feature by the
> > > > > name of HDS(header-data-split).
> > > > > But there is no implementation for the HDS to enable or disable by
> > > > > ethtool.
> > > > > Only getting the current HDS status is implemented and The HDS is just
> > > > > automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
> > > > > The hds_threshold follows rx-copybreak value. and it was unchangeable.
> > > > >
> > > > > This implements `ethtool -G <interface name> tcp-data-split <value>`
> > > > > command option.
> > > > > The value can be <on>, <off>, and <auto> but the <auto> will be
> > > > > automatically changed to <on>.
> > > > >
> > > > > HDS feature relies on the aggregation ring.
> > > > > So, if HDS is enabled, the bnxt_en driver initializes the aggregation
> > > > > ring.
> > > > > This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.
> > > > >
> > > > > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > > > > ---
> > > > >
> > > > > v4:
> > > > >  - Do not support disable tcp-data-split.
> > > > >  - Add Test tag from Stanislav.
> > > > >
> > > > > v3:
> > > > >  - No changes.
> > > > >
> > > > > v2:
> > > > >  - Do not set hds_threshold to 0.
> > > > >
> > > > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  8 +++-----
> > > > >  drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  5 +++--
> > > > >  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 +++++++++++++
> > > > >  3 files changed, 19 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > > index 0f5fe9ba691d..91ea42ff9b17 100644
> > > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > >
> > > > > @@ -6420,15 +6420,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
> > > > >
> > > > >         req->flags = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLACEMENT);
> > > > >         req->enables = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_THRESH_VALID);
> > > > > +       req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
> > > > >
> > > > > -       if (BNXT_RX_PAGE_MODE(bp)) {
> > > > > -               req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
> > > >
> > > > Please explain why this "if" condition is removed.
> > > > BNXT_RX_PAGE_MODE() means that we are in XDP mode and we currently
> > > > don't support HDS in XDP mode.  Added Andy Gospo to CC so he can also
> > > > comment.
> > > >
> > >
> > > In bnxt_set_rx_skb_mode we set BNXT_FLAG_RX_PAGE_MODE and clear
> > > BNXT_FLAG_AGG_RINGS
> >
> > The BNXT_FLAG_AGG_RINGS flag is true if the JUMBO, GRO, or LRO flag is
> > set.  So even though it is initially cleared in
> > bnxt_set_rx_skb_mode(), we'll set the JUMBO flag if we are in
> > multi-buffer XDP mode.  Again, we don't enable HDS in any XDP mode so
> > I think we need to keep the original logic here to skip setting the
> > HDS threshold if BNXT_FLAG_RX_PAGE_MODE is set.
> 
> I thought the HDS is disallowed only when single-buffer XDP is set.
> By this series, Core API disallows tcp-data-split only when
> single-buffer XDP is set, but it allows tcp-data-split to set when
> multi-buffer XDP is set.

So you are saying that a user could set copybreak with ethtool (included
in patch 1) and when a multibuffer XDP program is attached to an
interface with an MTU of 9k, only the header will be in the first page
and all the TCP data will be in the pages that follow?

> +       if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> +           dev_xdp_sb_prog_count(dev)) {
> +               NL_SET_ERR_MSG(info->extack,
> +                              "tcp-data-split can not be enabled with
> single buffer XDP");
> +               return -EINVAL;
> +       }
> 
> I think other drivers would allow tcp-data-split on multi buffer XDP,
> so I wouldn't like to remove this condition check code.
> 

I have no problem keeping that logic in the core kernel.  I'm just
asking you to please preserve the existing logic since it is
functionally equivalent and easier to read/compare to other spots where
XDP single-buffer mode is used.

> I will not set HDS if XDP is set in the bnxt_hwrm_vnic_set_hds()
> In addition, I think we need to add a condition to check XDP is set in
> bnxt_set_ringparam().
> 
> >
> > > , so this should work.  The only issue is that we
> > > have spots in the driver where we check BNXT_RX_PAGE_MODE(bp) to
> > > indicate that XDP single-buffer mode is enabled on the device.
> > >
> > > If you need to respin this series I would prefer that the change is like
> > > below to key off the page mode being disabled and BNXT_FLAG_AGG_RINGS
> > > being enabled to setup HDS.  This will serve as a reminder that this is
> > > for XDP.
> > >
> > > @@ -6418,15 +6418,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
> > >
> > >         req->flags = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLACEMENT);
> > >         req->enables = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_THRESH_VALID);
> > > +       req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
> > >
> > > -       if (BNXT_RX_PAGE_MODE(bp)) {
> > > -               req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
> > > -       } else {
> > > +       if (!BNXT_RX_PAGE_MODE(bp) && (bp->flags & BNXT_FLAG_AGG_RINGS)) {
> > >                 req->flags |= cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV4 |
> > >                                           VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
> > >                 req->enables |=
> > >                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
> > > -               req->jumbo_thresh = cpu_to_le16(bp->rx_copy_thresh);
> > >                 req->hds_threshold = cpu_to_le16(bp->rx_copy_thresh);
> > >         }
> > >         req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
> > >
> 
> Thanks a lot!
> Taehee Yoo

