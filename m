Return-Path: <netdev+bounces-241984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22267C8B5DB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68673A7F46
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E0207A0B;
	Wed, 26 Nov 2025 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ait/aLkn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="isIhE8Uj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E1201278
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180037; cv=none; b=LjmKqDgcIMzby1ar0yN6OTRP1z/puaibXDe5SCeTliMMns+RszDHGpFU6po463p/s0aUhyco1nmBBb0oaYyKXSB1VQdiRxs15DUhjlFDqC/DR1hn1Ggy5um0hK6xHmwtxExUxnqiNkg2UqNsvCQv7oDKeI8hdvqwcRNAWPmHPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180037; c=relaxed/simple;
	bh=IYZdkZZKGPGx9sx2990egUZQsDNd44OswOXxoE5ncJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFHz8T3xwLWIqThmsCpKt2L1X6pr6REiKQMuyrEtSx227xXFQ+/x6GlLVxmM6+G3kPW6ASN/IWVfDRHppsBTBiX1UTSoPkN8cj79oFi7TKjqN09CPh4sMtkjao7PUuBAGm3KLASdmWy2Xt1Vl6q92yefJmP2zsfAx5sgO6/In/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ait/aLkn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=isIhE8Uj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764180034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YgBhXcGSddKFMYnZCe5lp8J3od8fCjODxmcHFceGH4=;
	b=ait/aLknifM9ACMilxCWqnaHu6n/k4JAWM9kVOdWbeZasQAPDOqUJg4AcZGtkKWpgqFniL
	vHHKU7yuC6RpEAa/21qKtDDls4laoOF+dPMcg+0y+TMgNPL7HcHYXn3vKXdGGNP5dlP3u7
	AVYcjbZp9kMzMAfaFk8Up15E0bWSb6c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Pb-KD6pnO9iVvO0H-QYhSQ-1; Wed, 26 Nov 2025 13:00:30 -0500
X-MC-Unique: Pb-KD6pnO9iVvO0H-QYhSQ-1
X-Mimecast-MFC-AGG-ID: Pb-KD6pnO9iVvO0H-QYhSQ_1764180029
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2f79759bso61239f8f.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764180029; x=1764784829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9YgBhXcGSddKFMYnZCe5lp8J3od8fCjODxmcHFceGH4=;
        b=isIhE8UjL4JiIdJA50kgMgkYZgTNffhnecWANMhWEa81hqzlH29lWDZGDbBQX5fZIi
         a9ImFjEXjnlRdlrp8m7/u3iG4FXyBsOoRO+Ro4feuthirJdVu5GhA12pwpRK0O8vBEHO
         KpeF3B9eb6wfr5QBLOSP7Quv1Bh+E2RFT98zXSqOMz81QPEjk1KWZVYwheg7q2/Uc2Ts
         fQj6mrdXnmRYDLKtfIsXCSp2RwUIeeg/IuiERSJu4pHfIbvpk5Avr2FbaLbKMrMcrAWG
         EtfyRVstjk/Q0s1n7OX8akRpRQQPmKPX7Dwi99kgqkqitKByWE698O8broHG+go2x9vX
         VIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764180029; x=1764784829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YgBhXcGSddKFMYnZCe5lp8J3od8fCjODxmcHFceGH4=;
        b=Inxfy62IbMT6A83ObGJiDxjHpS34cBr3qmgaDZCw2FTI5DU/2Gl5b+Qp/Qfr4nRQZB
         hA13BEvyCeBE9vQkWYL/zyHTqGHONBuwSrdVkAbOK7nvAe2a5Gv8xQ3JdTy1+8BLfaxk
         jD5dAKeIxgb2/N+nhf6145F5uUXvTRlXQEf25RZ5/3fFoC+tUrvF3/rB6ttcsVMSlxuH
         tu6doQ6a72PE7zSNKqgQfWtvyyyuxOjeV2tafK5U8e+cNhnf5HNw/NL3vkRRsVwaPoKs
         HkqequVOXubO0OxD1BQXNPOwLzXpOO517hCZBCdUb0/ft0fBGVl/yf4ktGY90s/qTHH7
         xbTA==
X-Gm-Message-State: AOJu0Yw4S8Tsj2Ozgl5DwfAICRGCmTC7EdRn0SaCBmK4mAxbff0DXqIu
	eykwlNUpB8oAOs4zq5bmwj05xMaL1ktX0Pr4B9J/8/77O0DkISNQf6a5T6opugzazlvlySgNHSt
	8WsnRfb4MQcVLnsEbJNmz5iu0W5LolmABVuLWeTgPdHtw0R+RNvrbZVQHwg==
X-Gm-Gg: ASbGncthqrjgbB7HIePPOhL/N5P5jn1vrXrD16oc3i6gQV05KP+niXYeMbLO3D02131
	L9obRf2n6Bwa9wpZzXBsVi7mPH+95DIUZxzTL1K9dywPArPa7dCYyfQalf5PMXA7ceD+MFgsKQ8
	+byWgTv7qdtHkd7UBsrvm7vdV4LbvV3mjhQnMgib5LbCNQdSINDp88AtTSCpyjnXniqUIJQD6uZ
	8lHYDfNdup32Iyn299a+zMQs04kOIAJw/pDnpjIwubNqSFJ25OVLks3M//SQ6eGIBPNYk7pV/Ti
	BtdbBqsAmPVTMf7Sd4JJfp4iG6arGE+3oAdqgyqcKapiW4x+v5zYJvVZEMoqxHoIity9jzAiI7s
	piCHzHB6+HRTDLW/NUBM3nla40a2AXg==
X-Received: by 2002:a05:6000:290f:b0:429:8bfe:d842 with SMTP id ffacd0b85a97d-42cc1cd8f9fmr23640976f8f.4.1764180029300;
        Wed, 26 Nov 2025 10:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0n3yZ2xVz1rTRRSLX3s4tZ7PRJCUewur62JS2UwJ6l+0kyCvE19owlYWk1fAt9tOk3rS6ZQ==
X-Received: by 2002:a05:6000:290f:b0:429:8bfe:d842 with SMTP id ffacd0b85a97d-42cc1cd8f9fmr23640923f8f.4.1764180028743;
        Wed, 26 Nov 2025 10:00:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm42148196f8f.33.2025.11.26.10.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:00:28 -0800 (PST)
Date: Wed, 26 Nov 2025 13:00:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251126125951-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-8-danielj@nvidia.com>
 <20251124160517-mutt-send-email-mst@kernel.org>
 <1a770ddf-af27-4a44-95e0-b7971deac819@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a770ddf-af27-4a44-95e0-b7971deac819@nvidia.com>

On Wed, Nov 26, 2025 at 10:25:44AM -0600, Dan Jurgens wrote:
> On 11/24/25 3:05 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:15:18PM -0600, Daniel Jurgens wrote:
> >> @@ -5681,6 +5710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
> >>  	.get_rxfh_fields = virtnet_get_hashflow,
> >>  	.set_rxfh_fields = virtnet_set_hashflow,
> >>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> >> +	.set_rxnfc = virtnet_set_rxnfc,
> >>  };
> >>  
> >>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
> > 
> > should we not wire up get_rxnfc too? weird to be able to set but
> > not get.
> > 
> 
> I prefer to do that as the last patch. That's what really turn the
> feature on. ethtool need to do gets before it can set. Also, this patch
> is already quite large.


ok


