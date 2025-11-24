Return-Path: <netdev+bounces-241297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45DEC8278D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E973ADCB7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690962EF673;
	Mon, 24 Nov 2025 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mv32uxsw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZu7+mqE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863E2EC560
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018366; cv=none; b=twqVThEG1VxDQ+VqGkHxkGfn2r7ZLbAOdVTJasyNUSST6tO+aIrxfvNE+gnw1eNheiFDHxzbTiCQ5q9quAsSfix/nmjnaOFSB/QL2uH+SoygGsBcSHfrxyeczDhZ07mBDe34CY9ZAGiRh2tj2N1Kioinv8vYBzvPyV8lps35FdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018366; c=relaxed/simple;
	bh=g/E8beR8tUDQn6lIaWmMe0snOaMj2hJxdE6dQ5kv0rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCi9yfIIl27faFXPY6UCe1BZ04wYEBrCj8/qEvS4EV2evoUvK+TS6x3IgJfZifapRiw7IS/ylUrv/K6d7UlX/jrK6ORUYu7sjKFPjcJqzmOhorrkGbF0lTgt1fsN6b3ZaUI5zooWe5E45qg6lyPIhycAC0C404P9vNougNigux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mv32uxsw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZu7+mqE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764018358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlzuh3Vi/CtH9Lvd65m1lkwNjxQfpqQltMC5UipnhYM=;
	b=Mv32uxswBstBiZYnkpIMKfjR9e9+dRvaNsdjJPRzpjs3rzF/wzF3qZ4sZsM7uceFRGm2/8
	jIiSwoBPvks5ATLpw4zpEEyzsAdWHy69iPZC/HJRASNIci3MIMlS/c/y5r1+IhWFrwGCd8
	Khu/KPQNPhjV1DlK9onl9L4at+bcTqQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-YjKxZeWqOoiTRq7fipWILA-1; Mon, 24 Nov 2025 16:05:56 -0500
X-MC-Unique: YjKxZeWqOoiTRq7fipWILA-1
X-Mimecast-MFC-AGG-ID: YjKxZeWqOoiTRq7fipWILA_1764018355
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477212937eeso28006965e9.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764018355; x=1764623155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlzuh3Vi/CtH9Lvd65m1lkwNjxQfpqQltMC5UipnhYM=;
        b=DZu7+mqEQH3YxZbNFnNirBix8NsLe3HhOZ6zqH/KVF9pLQkdKFpi1uBodY0Tdz3qJQ
         arhmVSORwSjO7+SAOzoyXOQRmdWDZVVY03jKw8ULgwbGd8Izw948TvRgVKguCmonqVh1
         UckP39NWaPC8EsVq/pDo2t5Essc/o46kmiC/jg2gV2Gi1XeRRm2U6qN9lx/RIRVh4Mtd
         kBnZnB0sqb+GRnIket3zWVTM7Bhz1q7b35NxJsRQXcD2Y1frxFO8ksh9jH8vMOR50iaA
         s0M5J0ETlDZbKX6+0M6bY8Ffaq6MopshxIEb/yMZQjnhlgOVQBpH0X19f2YQI5vo4kkb
         MLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764018355; x=1764623155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlzuh3Vi/CtH9Lvd65m1lkwNjxQfpqQltMC5UipnhYM=;
        b=nclhMvA0O/TuJ6Xx6GR8M7BzQ8EpppItvBczviu488XaUxzV64kBoagrNolh7Icjmf
         IFfqNAtV7kaBlaTc5keMudWXHqsid7EKSez0vU5cEouzeuYsCvA38x35bfAZVPRYHhbB
         Pkz34L4oQBIdYTFY31FFVSEhMnxciflL+7tJSECl5C/OODd2WqIyYqtv4v++tuZFu2JB
         aRw4utd5GUfgkN/rZVambhFLeUXfRWm7Q+vrg+/C2DZMS6qeWJIIY6W+glhie87oyQHb
         xEvsRxNRQgbvfQwzGrF1nxvLFy5V8g4E6r2IMw0Ss9BcLJ/S2jKBN3y0817OViwRnDuH
         CZ0g==
X-Gm-Message-State: AOJu0Yz51n+8LNiO90meeK/BwFChjcXKlhnYInzX/wrkCTYhPlBv2YhE
	ax43NcYM6ka3J+y3ORO16EnzWhruKnGTp3phOud+bqNeepJ5FHZwl3GpkytI+ZaCcT4RQIbhRsf
	san3u4HN5NwUCY9l33Jom9VSia+jspubDIzJeR3GqUybl+nAYA6bMZ8XT6w==
X-Gm-Gg: ASbGncv1eiXUZkABtgrGtF7LeXkfmxQZG/gCdkWnkGJ0xrifRA1VEoAelTAeFYaY26Q
	3cNJU+R5zoFzlPWFzXvcKeEFGOkug0EwU62ajfPZc9I/TP7K94uM6K/rOUZdpDmvD+fnQaL8cUz
	N5KRBrR151VlVSHE2cJKy7uXJ4nzAVUcOyVKupfsBtrB71s+FmcEi9MNwJJ8rvf7kDW2PTb/fFc
	82VgBUeLS8xZQ8/7Crh2lb8k0PO0V6dbfTfSPFh2wf/7eS8E2byIXhoODepZrLKTkSZfPE0TRIi
	oyyckDWQ3SaEhk2gVzO4daSR03G7BRPAXG1ggeXPUIvPDb9mIS4WAOUcUa9A5WNZdXCuCDmc6NW
	qcBypgYK7zdlkWKHqG1TaBYa4WKtgAA==
X-Received: by 2002:a05:600c:4ed2:b0:477:9e10:3e63 with SMTP id 5b1f17b1804b1-477c1164cebmr127649615e9.35.1764018355430;
        Mon, 24 Nov 2025 13:05:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrr0g8aeqLZwRJYhQFNtT44/ZArFpgI8tE/z7srMCZDG4NbIPNu5jRQhTGIky9yZHR5HEr9g==
X-Received: by 2002:a05:600c:4ed2:b0:477:9e10:3e63 with SMTP id 5b1f17b1804b1-477c1164cebmr127649295e9.35.1764018354969;
        Mon, 24 Nov 2025 13:05:54 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040c70c5sm3152165e9.4.2025.11.24.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:05:54 -0800 (PST)
Date: Mon, 24 Nov 2025 16:05:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251124160517-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119191524.4572-8-danielj@nvidia.com>

On Wed, Nov 19, 2025 at 01:15:18PM -0600, Daniel Jurgens wrote:
> @@ -5681,6 +5710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.set_rxnfc = virtnet_set_rxnfc,
>  };
>  
>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

should we not wire up get_rxnfc too? weird to be able to set but
not get.


