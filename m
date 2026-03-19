Return-Path: <netdev+bounces-269538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG67Oo0nvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:42:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAA12CEFF2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0359430A0A7A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC963E9F73;
	Thu, 19 Mar 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMjHWdyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355FF3ED128
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937687; cv=none; b=czpFzncotgSvt5evIFFARdccNeLpTjLo80q/LCyDfcTCPL1fxcgtjxqm6ges37Fx0/FkD88wYw+x751VgK878Q5/CdICcGWzHj0516M8ML7uyrjHJEaVuExhIRkLBWfrPqrWF9PRD/gkMzzpQbYb2pAY9s3KCGmeDAw1FWs+zJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937687; c=relaxed/simple;
	bh=lyyfFcVukzGyp3mr/uo3LQOIJLwUruHPkgD85TY1k9Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nXa1E1QCsC7PbuFg7WD0Qz9RA8td08QKgDs/q959Q9tfpb6M0sbcaQW5+mIJ9XtMizWdl9VGsVStqESxYd4aVLuJKAgZHu61vrLEFTtdiRYLjRWMtuzvz794COStFVLlV1sdrPYVrQf6Hoq/IOIkbroEDpIz77//FosvaeYuD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMjHWdyJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a74765703so11989127b3.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773937679; x=1774542479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGMWnPGIJbj2fv9GIUzL/R2uEsOmgvgdO4zPTwPVrbk=;
        b=FMjHWdyJsZzhRFsFiklDBlAJsQLsjegcILmlSwc6RL43AMAwWeup7693/zzlXIrxvj
         sK+ztbiTJ+OcVKkF5Ib5ewecjpG74qMRRJpqBGjSLIVMRHDWXsegdEQGn95xRePOf7Sq
         +26Awo800oa3Lhqs9qvLZ3Hz+S5FHjERQdZmCavrRwT0HHkMOoAAd3N9BIjANX3p1a6A
         j+rVKADgQmQXAIfT1JYse94sgRslZw3cixCQZkrRQ5fdM3/XxMddd00zBnSeFSdb3E40
         YS6DEgeAgA4C2IcbN2K+XRJUmvqEdqBY1gRpEILZJ26luq48XsvSWxGLbJsBY5Sn0EYk
         QAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937679; x=1774542479;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGMWnPGIJbj2fv9GIUzL/R2uEsOmgvgdO4zPTwPVrbk=;
        b=YrCUUKGzpw+QPNUCDd3w4PKoNhZGv6uxaRgJ03Yu6s8XwidWHKVguO+qqWnJYYVL73
         v+4uKnlZc+SbzgzO/vS5bejCx1tdPPY4cORv6l+4GEytS/9xozyBfE5e9wFEzi08q134
         Z1yX5OMuNc+uOxvFOrzm4SXl+yYlYaitbKOHMiFspxweAgO3Qzsf9miI4nz7C+OyjGHs
         SOLzoXhJgKgXB43MwgWEA+N2yycQMeLXmiEGT9lJTssNt7RVUYKBVi+SKBI9s89npjWi
         149b0hiNhvod9Ih40QrYSKKV3ffJIAm4gZK2E4C0UNXkrlIUQp0ekbCrdvBJB5xrjtoC
         ovow==
X-Gm-Message-State: AOJu0Ywe3pIgTQfVP1XYv3Yk4xup2a980Xo7fOiLsSMpNjXOkOXfIfUA
	nn806b2Hj0BBb/tN+nzZoX+oro4L6Vm7SmL7nYzaCa+GXdh3ogfQ7WXw
X-Gm-Gg: ATEYQzwj+4U3iddfPO+SzZNuKyYkMrWq8K3ANgYxlXSyeP83FYX5zaxRRwI33ErJ0Jq
	LNeo2vbT/k5wNuAZvr/GfACpf9u0MAgs7NY/aOurKD+Wx7etc49LrO71u2+WJtdmpWT67X+/o4T
	iW2aP8DDyzc5kl6vQK42/ABiixg3coALh9acoTkYNwBxWR4r7tl4a+W8Y/QgMuCsnToL6Ns/HX4
	HE9OmFSDYWgJX7lxyTuG+hIGuUd9DbCJwo/gy6EUJT/KmMCCBogPkJGEgIFqFhyn7I10vmDF9l9
	gwZVdaNY2ZOjlPh+fkIZ5HXJJsa62G7FuLuytLKxKR58YPSHE7OJSgxqwup5hzZlZ/5QkIpzza7
	yUGIIB+GifPeCKVIFD+I2k5M8KS2N14FmWx5qgSdteJZuRFFGyON2CFgfMm3H5y1wQqRFfI7ayr
	mEPkDL1fUCQpAJaEOtwwGFlDn4g84i44MzYgZVgadB+UTV9Dh8ykM/QcflFLas6xAh9TQXZIme3
	RMu
X-Received: by 2002:a05:690c:6891:b0:799:1913:1147 with SMTP id 00721157ae682-79a71900b11mr89869617b3.27.1773937678746;
        Thu, 19 Mar 2026 09:27:58 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a7136f0c1sm39424137b3.7.2026.03.19.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:27:57 -0700 (PDT)
Date: Thu, 19 Mar 2026 12:27:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "(JC), Jayachandran" <j-rameshbabu@ti.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Danish Anwar <danishanwar@ti.com>, 
 Daolin Qiu <d-qiu@ti.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>
Message-ID: <willemdebruijn.kernel.8e323262df61@gmail.com>
In-Reply-To: <20260319142613.KHz32I-V@linutronix.de>
References: <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
 <willemdebruijn.kernel.3693c9aa8271@gmail.com>
 <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
 <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
 <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
 <20260317172906.eG2LxlZ7@linutronix.de>
 <willemdebruijn.kernel.17068ce38efa5@gmail.com>
 <20260319142613.KHz32I-V@linutronix.de>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific handling
 for HSR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269538-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.187];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ADAA12CEFF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sebastian Andrzej Siewior wrote:
> On 2026-03-19 09:29:44 [-0400], Willem de Bruijn wrote:
> > > But here you have PACKET_VNET_HDR_SZ to configure virtio_net_hdr. =

> > =

> > I mean an implicit header in the packet. virtio_net_hdr is something
> > that the packet socket needs to inspect. The metadata between ptp4l
> > and hsr_dev_xmit is not, so the packet socket can be oblivious to it.=

> =

> Ah okay. If I insert a header, I would need to scan for something in
> every packet and it must not collide with anything that would include
> the same sequence.

True.

> This means the PTP packets from ptp4l and everything
> else that sends data. That is something I am not very comfortable with.=

> Even the destination MAC address had to be changed a few times during
> testing so scanning for it would not be good.
> =

> > > This
> > > is kind of what I ask for with PACKET_HSR_INFO + PACKET_HSR_BIND_PO=
RT
> > > (and I added static branches so nobody has to suffer with CONFIG_HS=
R
> > > enabled but no HSR enabled socket)..
> > > =

> > > The diff below would be what means to bypass AF_PACKET entirely and=
 use
> > > eth0/ eth1 to send via SLAVE_A/ B and hsr0 with SO_MARK to send wit=
h
> > > system's HSR header but only on one of the two ports.
> > > With HSR-offloading enabled we need to attach the SO_MARK hints als=
o on
> > > eth0/ eth1 devices, too. Otherwise the offloading part will send th=
e
> > > packet on both ports and attach a header (as designed).
> > =

> > eth0/eth1 are not HSR devices, so how would they interpret skb->mark
> > and how would they loop packets to the other port?
> =

> If you look at the diff below, there is the
> hsr_skb_get_header_port_mark() helper.
> =

> So eth0/ eth1 are not HSR devices but they are used as slaves by hsr0.
> The intention is use the eth0/ eth1 devices to pass packets which
> include the HSR-header. So if I send on eth0 the intention is to send
> the packet 1:1 on this device. The skb->mark is not required there
> unless with hardware offload enabled. =


Right, so this is simple without hardware offload. Does this HW
offload exist, or is this aspirational. At least for infrequent PTP
it does not sound important.

> In this case if "PORT" marker is
> used to let the driver know to not duplicate the packet on the other
> port and if "HEADER" marker is set then it won't prepend a HSR header.
> The port marking is the same as for hsr0 and I used the next bit for th=
e
> header to keep things a bit simple.
> The skb->mark with values 1=E2=80=A67 is then not available to anything=
 else in
> this scenario.
> =

> > > diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers=
/net/ethernet/ti/icssg/icssg_common.c
> > > index 79df641b4fb97..a2e50cae01686 100644
> > > --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> > > +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> > > @@ -909,13 +909,17 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk=
_buff *skb, struct net_device *ndev
> > >  	 */
> > >  	dst_tag_id =3D emac->port_id | (q_idx << 8);
> > >  =

> > > -	if (prueth->is_hsr_offload_mode &&
> > > -	    (ndev->features & NETIF_F_HW_HSR_DUP))
> > > -		dst_tag_id =3D PRUETH_UNDIRECTED_PKT_DST_TAG;
> > > +	if (prueth->is_hsr_offload_mode) {
> > > +		bool has_header;
> > > +		bool has_port;
> > >  =

> > > -	if (prueth->is_hsr_offload_mode &&
> > > -	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
> > > -		epib[1] |=3D PRUETH_UNDIRECTED_PKT_TAG_INS;
> > > +		hsr_skb_get_header_port_mark(skb, &has_header, &has_port);
> > > +		if (ndev->features & NETIF_F_HW_HSR_DUP && !has_port)
> > > +			dst_tag_id =3D PRUETH_UNDIRECTED_PKT_DST_TAG;
> > > +
> > > +		if (ndev->features & NETIF_F_HW_HSR_TAG_INS && !has_header)
> > > +			epib[1] |=3D PRUETH_UNDIRECTED_PKT_TAG_INS;
> > > +	}
> > >  =

> > >  	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
> > >  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
> =

> Sebastian



