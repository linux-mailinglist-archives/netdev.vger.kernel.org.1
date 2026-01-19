Return-Path: <netdev+bounces-251082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6FD3A99E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4593306AC70
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3FB361DBB;
	Mon, 19 Jan 2026 12:56:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295B359713
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827416; cv=none; b=AXYXPOZYFiAv0CFk8qpByFu7eFxvNj42JZDFhkKpDCvgQFC5X7vTnqwYfx16rhEX/QfExgFfxG2JRdp2EAqnmVL8OaEeCC0wlzEaoYVM9kyHZmZPbTfggAXhKBUCgTrZABxNjCe6n8uZtdabPKaoQL2ZqJ2nyPb/+osJE6/4S7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827416; c=relaxed/simple;
	bh=U/yLA0Xwy5Vf0t9w0/R4dJwYKctX0chF9bQE2FXuqd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V13K8RJRIMVE3pbJAQsmaMPPzLc9RN1MCCeWLZWH2ChjjPw1DlQfYql74fvf8CZu2aBDpdep1wq3xsFsRtBzQwewxfS2uY6+RZaJUQNqnW0nDfRV1OTlk7DuL0CbZRCTl4+3/AJTsRDdjRkCMRUP4oYEtBlmo6luVMY9u5APqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7cfdf7e7d19so2325052a34.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 04:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768827413; x=1769432213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNHrn/XFzhadasziTUy6F7RftXtkLpDR8wFnHICqw0k=;
        b=CQ3YDugCSWQnk2V6ChlzoAqCItDDUroYhH74oD1+jr3qgrwYCE5IjJwUc0R74XjqhZ
         3vfNOmjb6HKukU99r4XtHyvPNbGQs+VgB7f9KtW1tc0XPdUaZocB5AeYidDDhhoyJWdR
         X8knN5pGuskWuSrSIzQrb++8LrZeaHCvWnzbiFrNVUQolWQ8y9pBdK/fJpYExBbVp62g
         wDQljdS1OdlUT768N4NpA9xGXhAFHi27WORATySekseWQNjRSjsQpMNjgDRDjfNe2RRY
         7qTDh8pFbAjD2P3uAAlJCVViOuBsMhSMSSfyUeKdby3SszxlM0suyo2l5FRrriN4pmY2
         addA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0IRdnYA24rMLrUz/q/vkthr+Ntypig+jJy7uIz9ds/htoZxyqwfy5zgpGpWX+PjYP9K6YKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtEnTPmzm/dGpiJxw9LT5ZajmYOmXVhVfQMxHD5bTsaTV+gPW
	E0dnocdSy0+z0KduZm8FBKoRr5U8Wu8hfNzbAwfWUchdtBuKPvFO3C1I
X-Gm-Gg: AY/fxX6sOLY9ilcRlzAfSh6/TtHCbuBbTBfFHBEjLRN9fRe7T+EJnjEudiqjvv9Aom3
	nvaCQgOe7GscYSG3JKWEyO7XI5hpet6HjPllbh/13imYWmiAcsgrnQCHlBfHaDssKWysu0ov6GD
	KSmdBiia5tPxa+fcHcX1p9GSKzVyqkDBucS7PHMHoUm4dXTgBKgmcsXUBx+whcQ08z/W0sN+Ni7
	SfQpPzUVgGIqntuNFTiJSQTLqI8rxVB0ZgcwDgGaUcK4njEY6lX2Skq72b8vNKEMMDU62nf38DD
	dstldCHanYhmtDtmD9D9qh5S82nEZlgwv4anTvuLc4jIZYKoKNMrJZIRBYpeEBo02HoKBFztxO7
	ffB1b86PPOsneD49FrpFoC1ztNuBWm7dMEw7DrGWdpRAropmbEi+q0HHNTiGiPMo7QscMDZuOrg
	Vx
X-Received: by 2002:a05:6830:82ea:b0:7cf:f7c1:d9ac with SMTP id 46e09a7af769-7cff7c1da6dmr4841137a34.9.1768827412551;
        Mon, 19 Jan 2026 04:56:52 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a5f02sm6632883a34.25.2026.01.19.04.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:56:52 -0800 (PST)
Date: Mon, 19 Jan 2026 04:56:49 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Bryan Whitehead <bryan.whitehead@microchip.com>, 
	UNGLinuxDriver@microchip.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Raju Rangoju <Raju.Rangoju@amd.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 1/9] net: benet: convert to use
 .get_rx_ring_count
Message-ID: <l66l2ijd45fkwniaesgau5jdzoxrdyt4t7tnsd6dpo4dlefytf@tugyhkn2th36>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
 <20260115-grxring_big_v2-v1-1-b3e1b58bced5@debian.org>
 <20260117181551.0b139ca1@kernel.org>
 <ziyd3327jr7miqgv2e252w4wpizphomkvxxge6nbjwtg4pyvf4@gvwwi2r7rykl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ziyd3327jr7miqgv2e252w4wpizphomkvxxge6nbjwtg4pyvf4@gvwwi2r7rykl>

On Mon, Jan 19, 2026 at 03:07:12AM -0800, Breno Leitao wrote:
> Hello Jakub,
> 
> On Sat, Jan 17, 2026 at 06:15:51PM -0800, Jakub Kicinski wrote:
> > On Thu, 15 Jan 2026 06:37:48 -0800 Breno Leitao wrote:
> > > -static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
> > > -			u32 *rule_locs)
> > > -{
> > > -	struct be_adapter *adapter = netdev_priv(netdev);
> > > -
> > > -	if (!be_multi_rxq(adapter)) {
> > > -		dev_info(&adapter->pdev->dev,
> > > -			 "ethtool::get_rxnfc: RX flow hashing is disabled\n");
> > > -		return -EINVAL;
> > > -	}
> > 
> > I think we need to add this check to set_rxfh now. The error coming
> > from get_rxnfc/GRXRINGS effectively shielded the driver from set_rxfh
> > calls ever happening when there's only 1 ring. Now they will happen.
> 
> You are absolutely correct. The ethtool core calls
> get_rxnfc(ETHTOOL_GRXRINGS) _before_ allowing RSS configuration via
> set_rxfh, and if it fails, ethtool_set_rxfh() will fail as well. And
> with the current change, ethtool_set_rxfh() will not fail if the adapter
> is not multi-queue.

Upon further consideration, should we implement this limitation directly within
the ethtool infrastructure?

Something as:

Author: Breno Leitao <leitao@debian.org>
Date:   Mon Jan 19 03:25:05 2026 -0800

   ethtool: reject RSS configuration on single-queue devices

    Configuring RSS (Receive Side Scaling) makes no sense when the device
    only has a single RX queue - there is nothing to distribute traffic
    across. The indirection table would just map everything to queue 0.

    Add explicit checks in ethtool_set_rxfh_indir() and ethtool_set_rxfh()
    to reject RSS configuration when the device reports fewer than 2 RX rings.

    This protects all drivers uniformly at the core level.

    Signed-off-by: Breno Leitao <leitao@debian.org>


diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 9431e305b233..899864e96aab 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1380,6 +1380,10 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
                ret = num_rx_rings;
                goto out;
        }
+       if (num_rx_rings < 2) {
+               ret = -EOPNOTSUPP;
+               goto out;
+       }

        if (user_size == 0) {
                u32 *indir = rxfh_dev.indir;
@@ -1599,6 +1603,10 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
                ret = num_rx_rings;
                goto out_free;
        }
+       if (num_rx_rings < 2) {
+               ret = -EOPNOTSUPP;
+               goto out_free;
+       }


