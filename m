Return-Path: <netdev+bounces-173446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925CAA58E37
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553833AD1DA
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44663221F12;
	Mon, 10 Mar 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IzOIrQXH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C31401B
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595661; cv=none; b=tCGCN0xfeIXpZTgq3A8UULQ4LjwSFvQdwWEwF2Yuyl9cSqTQpwyjQWhFmxjsGRVg8evcYatI8E7HNzGZXj/6edfeEjFMSZ9VmSSLSVrUsWnNNjo/3xKofa0i/WX4xO6Yx29MbhRyEF/ZFz/poeZKFU2BDk+srZ9Tbv659PiBf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595661; c=relaxed/simple;
	bh=pvy46BxG/jCiJ7xhXX3byEdS6V43yZAv3kmnQ09GnVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGBkLCJ8lYamcXV6CRkQg7nhycP0IslL9G5d1Tz9QLkrb/41tUWXigyxX1p7oPMWgVhMr1UD10LWwm0v3vn0xL4SkKdle+X5cmC5Fwi1GynpU+fKl+XYYoILEEdyObUek35ZUEUXUTZfJ4g4Al3lyUbdgyVlo+fKY3QvK4pZvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IzOIrQXH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso168018066b.1
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 01:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741595657; x=1742200457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2NHSFGieJrXy63h9C9tBiXMMHg1HSP9eRFf8a1NgQY=;
        b=IzOIrQXHJ0cWTF9ZMdAnaFdMn9AS9zXRqGFqhjH4eQULTSYpICL/v5pTugVLSv1ISQ
         +WXjT60fHLdc1FkhBPt0j9LCe5j7cElVmt/3hoHXinZoeLKReJzh9LRbMaVAXt38PxwS
         /kUh8jQk0rIKalXprwYQRJELO6P/L5nWb4Q5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595657; x=1742200457;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2NHSFGieJrXy63h9C9tBiXMMHg1HSP9eRFf8a1NgQY=;
        b=SUwBK6R7LSSYSe20aweXrq7ZMeDvk2UhNw+vbfOHDU1MLd+RRCJuwHR20IZ1Ej3hE2
         vkLh6gsQ97IIPET3TA+1UmbT65PxVNNdsdIgSWb8XZNBm0uwpnRcUsS66FNAY4pwFPqv
         zz8zrhmMKk/KPHn58ycyH++oyxaR2q6h3sLbfNgsAN8RfBZR6s9wSgflrg6BJp4O0b4R
         h8P8id0RQhq0wo1gzuR3PLg3r1i06MPjWH1YIk3hckdZf4Bxj/XF6UK7H87z4jsKBVsD
         MmjxnRel8cUgKtwMir2zNxl7OJpXDf6mmfCnKALblOcKbTc0RJJiRjQTy4/L3wsu3j31
         Hy4w==
X-Forwarded-Encrypted: i=1; AJvYcCVNhs6W+Vn/geghYk/xYLiWf07xf1WrdeUY6fGxYbIg3Jgob1OLRs0G5WBMFuIkjOT2Y3miRKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7KQ806YeaBFixoigeELsbDPAKQ6k8xT8pc5yd7DgWdRqwoObn
	mMyFeER34Lvswl1EiBblp/PRAaqENe+N/XnIcTBoO1NF+p65LCBF2qIpFtI5RQ+9loqeGWKJPW7
	Nc+k=
X-Gm-Gg: ASbGncu5E9S84hY8ORBiHFIPrIWwBCGzauhyIsPIlqLE9NYUveTmSQKqlQiNiYn+x+e
	Y7lmAMrT7qKrw4Uvix/wHuKqixMTpuFbAGC6Eg8ALEauO9QqSMFAIFSCrBeW3voRiQHA3AXm5CA
	KMHaemuzMsEcVfrnIaEM23+1DVcROIEaZo0TteipY9XsQAm4VPGNJbowCcd2P0JZqMTgzWeZWFg
	lSab67uT1z79q4aI1U7VCeBz9dr7fYAYIuT/0FT2p0KPvx6KPgeeKB3DFRQULBfXLys5XZvBFXN
	UhyEZ4UJurfll1c=
X-Google-Smtp-Source: AGHT+IFZvLE5+yAuEYdnhKe40tiikkaeysAEk4mht6wIl9eR/eBXPqLfUik9L3YmGwoHc7gh1HsKqw==
X-Received: by 2002:a17:907:7e92:b0:abb:c647:a4bf with SMTP id a640c23a62f3a-ac252af0495mr1152749666b.23.1741595657509;
        Mon, 10 Mar 2025 01:34:17 -0700 (PDT)
Received: from LQ3V64L9R2 ([46.188.239.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac283e4d50csm318030966b.175.2025.03.10.01.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:34:17 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:34:14 +0100
From: Joe Damato <jdamato@fastly.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 2/4] igb: Link queues to NAPI instances
Message-ID: <Z86kBp2m-L-usV0V@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <20250217-igb_irq-v2-2-4cb502049ac2@linutronix.de>
 <f71d5cee-cafc-4ee0-89fc-35614eb06f94@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f71d5cee-cafc-4ee0-89fc-35614eb06f94@intel.com>

On Fri, Mar 07, 2025 at 02:03:44PM -0800, Tony Nguyen wrote:
> On 2/17/2025 3:31 AM, Kurt Kanzenbach wrote:
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> > index 157d43787fa0b55a74714f69e9e7903b695fcf0a..a5ad090dfe94b6afc8194fe39d28cdd51c7067b0 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> > @@ -45,6 +45,7 @@ static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
> >   	synchronize_net();
> >   	/* Rx/Tx share the same napi context. */
> > +	igb_set_queue_napi(adapter, qid, NULL);
> >   	napi_disable(&rx_ring->q_vector->napi);
> >   	igb_clean_tx_ring(tx_ring);
> > @@ -78,6 +79,7 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
> >   	/* Rx/Tx share the same napi context. */
> >   	napi_enable(&rx_ring->q_vector->napi);
> > +	igb_set_queue_napi(adapter, qid, &rx_ring->q_vector->napi);
> >   }
> >   struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
> 
> I believe Joe's fix/changes [1] need to be done here as well?
> 
> Thanks,
> Tony
> 
> [1] https://lore.kernel.org/intel-wired-lan/9ddf6293-6cb0-47ea-a0e7-cad7d33c2535@intel.com/T/#m863614df1fb3d1980ad09016b1c9ef4e2f0b074e

Yes, the code above should be dropped. Sorry I missed that during
review - thanks for catching that, Tony.

Kurt: when you respin this to fix what Tony mentioned, can you also
run the test mentioned above?

NETIF=eth0 ./tools/testing/selftests/drivers/net/queues.py

