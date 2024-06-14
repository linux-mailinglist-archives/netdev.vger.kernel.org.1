Return-Path: <netdev+bounces-103461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80773908351
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 07:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDFF1C22190
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 05:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501F1474B1;
	Fri, 14 Jun 2024 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG3LGOmV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40635146D77;
	Fri, 14 Jun 2024 05:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342930; cv=none; b=fYfgQPsT08pKyDRRVQ2sc85LKAur7s2Qhx/j06CUVkpT6rmAToLp7m9BN/OxXJz4bgbiGaA9y/pJNEfRKwRdK1+PUSF/hW4Ga2l6ggPr9viPnwgEYTbuBVgMEAGGqZw6hc6/moPiEi5RSL2sNscZUu85y3urwTkyyJt+yIlcc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342930; c=relaxed/simple;
	bh=4AYzeDRQoygv9tptn5empnF0ZSheTur+UeZr/as2jho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBABK2M2qDr35T2tvFqzkXjyKDCMpyA4CiA+kUF42gU3Sbj5VnxIXOM8NuXE4Bb4cfsKDgVMIxXozmNSWPncRuc5ryutGj0aI7gOsfOzEFp/3bNDwbBtuHU3xgP8GjjwD6sLQu+pfYPHGaWfCIGbxnPUnIWNT5iJcVI9O3IzpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG3LGOmV; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f977acff19so827693a34.3;
        Thu, 13 Jun 2024 22:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718342928; x=1718947728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw/wpX2rAqV+uUeAuGGK7ciQ1Eeb9FNFDIAoWNVW3Fw=;
        b=bG3LGOmVoQdDGaFhKm/+UlHVy3LJE33iAyyevQyZx4/E8vPHjfjzpp7tcA4siAr0cu
         B6c3ZPt0fi+dwnWHIa355R2TEDh9/yuX7SwSWqjPBsrIaeOw4qov4sINlUTOFfeu9Wop
         4fdveOzJQHit0RSGKJb5K8rqJWo0vRDE0rz89rOf08IS8Wk6fswCVeqx6U3xy27pXYn/
         Xxwm4hkmE3GU5HsypdbGBbCTWaJQTDTi/37GWDlC3RZeVlJ9UxmMrU0zJtp2r3pPv5nT
         0X+paXdXXRwLVCghiy/zwyvYBYH3iiPHdM+BhV7vpnBhPZ87kaXeItFjbm/+BFYgRAbM
         lZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718342928; x=1718947728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw/wpX2rAqV+uUeAuGGK7ciQ1Eeb9FNFDIAoWNVW3Fw=;
        b=K5EiMeAeOKXBpBSZGQXk74xtqk7FtaWzjpHmnSvrx5FuHS9UsqmI6GNlzt7/xv2Jyk
         LhDk+cLYmBf/sLMu4rlCXYFvDuwQ18Wk/xtE5IPewx4ihd3w1HOOQBgXBNSx3Zj0R/EK
         E2b4O+pkbck3dw7SbMm5OgwZNuBRuyQnM/GGpkWJWkcd+zBBadbuoMcb1mgprJriCqFz
         kv1C7Gnste46qSLuKbIiAEllQnO9f4m4BI3Tdum2H01FEfF1rjbzeJ8Gxeq0K5jeZgnh
         CJclhC+elDbPSXSKdwSaLsTj5vdUfnE1Ia0RM1yC8fqyNstekjsN7VeErgP9YNMaLkl2
         C+2A==
X-Forwarded-Encrypted: i=1; AJvYcCVtTBWpfpsesr5Hg84/b4Yb78bUDy3XGG+4bjsR0/CXJsHROnT/+k2+ZWk/v/RGDQI6T4k/Ke6O3ytfOg+REQe9qli7kzV1WUg4wRlgxh/3wOxMz9I317o99EV8/SlYv/xoPHh1
X-Gm-Message-State: AOJu0YyU4ZkM2d+i6dVvyU7ZQe9ke3y1eDDQ1BkKvvVDZlQJwDA2JUMv
	DNIxASlsPpsQMoi/hbERurlglnEcV6rN3UvJfKBTdWkoDZKsteLT
X-Google-Smtp-Source: AGHT+IHGmC3uIyBCAhuw0E+MosfhQS9mHFZU4B9Da80064YdPUcHuTQB2Xbr9RyhO+OvfFAHopjXmg==
X-Received: by 2002:a05:6870:41d4:b0:254:a09c:6ddf with SMTP id 586e51a60fabf-2584298e0ffmr1896203fac.24.1718342928140;
        Thu, 13 Jun 2024 22:28:48 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91f699sm2242495b3a.36.2024.06.13.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 22:28:47 -0700 (PDT)
Date: Fri, 14 Jun 2024 13:28:35 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Joao Pinto <jpinto@synopsys.com>, Corinna Vinschen <vinschen@redhat.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1] net: stmmac: Enable TSO on VLANs
Message-ID: <20240614132835.000025bb@gmail.com>
In-Reply-To: <ZmrN2W8Fye450TKs@shell.armlinux.org.uk>
References: <20240613023808.448495-1-0x1207@gmail.com>
	<ZmrN2W8Fye450TKs@shell.armlinux.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 11:45:45 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Jun 13, 2024 at 10:38:08AM +0800, Furong Xu wrote:
> > @@ -4239,16 +4239,32 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	struct stmmac_txq_stats *txq_stats;
> >  	int tmp_pay_len = 0, first_tx;
> >  	struct stmmac_tx_queue *tx_q;
> > -	bool has_vlan, set_ic;
> > +	bool set_ic;
> >  	u8 proto_hdr_len, hdr;
> >  	u32 pay_len, mss;
> >  	dma_addr_t des;
> >  	int i;
> > +	struct vlan_ethhdr *veth;
> >  
> >  	tx_q = &priv->dma_conf.tx_queue[queue];
> >  	txq_stats = &priv->xstats.txq_stats[queue];
> >  	first_tx = tx_q->cur_tx;
> >  
> > +	if (skb_vlan_tag_present(skb)) {
> > +		/* Always insert VLAN tag to SKB payload for TSO frames.
> > +		 *
> > +		 * Never insert VLAN tag by HW, since segments splited by
> > +		 * TSO engine will be un-tagged by mistake.
> > +		 */
> > +		skb_push(skb, VLAN_HLEN);
> > +		memmove(skb->data, skb->data + VLAN_HLEN, ETH_ALEN * 2);
> > +
> > +		veth = skb_vlan_eth_hdr(skb);
> > +		veth->h_vlan_proto = skb->vlan_proto;
> > +		veth->h_vlan_TCI = htons(skb_vlan_tag_get(skb));
> > +		__vlan_hwaccel_clear_tag(skb);
> > +	}  
> 
> I think drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c::
> otx2_sq_append_skb() does something similar, but uses a helper
> instead:
> 
>         if (skb_shinfo(skb)->gso_size && !is_hw_tso_supported(pfvf, skb)) {
>                 /* Insert vlan tag before giving pkt to tso */
>                 if (skb_vlan_tag_present(skb))
>                         skb = __vlan_hwaccel_push_inside(skb);
>                 otx2_sq_append_tso(pfvf, sq, skb, qidx);
>                 return true;
>         }
> 
> Maybe __vlan_hwaccel_push_inside() should be used here?
> 

Yes, it should. Thanks for your comments.
I will send a new patch.

