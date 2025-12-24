Return-Path: <netdev+bounces-245933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A19BBCDB14C
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 02:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829183018F5D
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 01:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E0527F756;
	Wed, 24 Dec 2025 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdYH3I/9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jp3Y52fG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B61C3BF7
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540106; cv=none; b=ATdB0txfG+JlHRbLH3qBdLLdmrXPUNTPyNvaO0yPHcubIIz+GpkYHZtIFEFdh45OYbVOOB8L3Jko5MX6M/BZqdYy1k29jkDS2x2AxomrtSFErvyDN0sheTHjoDP3SGVz7/3g+9iDlruIk2V0a2TZ3EdboEfwG5yUKOq5VSbPq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540106; c=relaxed/simple;
	bh=VxgwS571p6d9ltRCxPlktCpRXiNoc5EoA/Yuj4mRh0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfwsE4y3HhlBJkLKPuGjVVSbUuWeopE52nqGKvXuLyuRGswDSZzD/ARKukFU+ihvoe/q/cMAKvMPR8+3Qrdyr7gb9OorPYPsyDgNzJUxFIV3vt4Tb+9oNm9NOMawz3vG30BHVrwTDBJMJgFzhgK2bw7FSd4yoAXLA58kj2KFuHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdYH3I/9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jp3Y52fG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766540103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ul5RYtwKuLzb4fmUt0dahcK3wJyHyhIWdXTPSkMhGA8=;
	b=FdYH3I/9bNuhWigwB7Dgw0qTvH8fX3xRIJJwEhs2ieGr6Lm2c+MNhqRGJPb12H7qnCJOS+
	qVL/n+QRMWdtl+rUX4Heq1JMMErEbpy+fkmRFEHjxCzAbiI8svdhWR2z9gOjedyAtTe9M4
	KKiHCOYAqyNluX7nzvk/NOgluPgetfM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-ABJWYgOCPJyIdafna6pIww-1; Tue, 23 Dec 2025 20:35:01 -0500
X-MC-Unique: ABJWYgOCPJyIdafna6pIww-1
X-Mimecast-MFC-AGG-ID: ABJWYgOCPJyIdafna6pIww_1766540098
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso28990355e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 17:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766540098; x=1767144898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ul5RYtwKuLzb4fmUt0dahcK3wJyHyhIWdXTPSkMhGA8=;
        b=jp3Y52fGPO/B3hmxJtGq8GKulUZVsVmMrdLGuVjR8jXfaVZtVUrd1GpphDOt2d1dL9
         GdLz5m0JuIi6ia5qj33N/fbRK/DHrSQzh2XsR3S4ClIXOb7WkkgoQotucXmI8RFLiOn6
         z+sgl4gblqgcM5MOsG/gxu7N2ACVeulT8fg859MnKmEzeaaP1rUhXr8ak65YvOMTGbCN
         lUrshpgZJlP05fFhfVjx8KXaamOWMMfyYQxX2lkomJNKKv6OMBQCsnfvtZOSAX7BBEAr
         kz4jD6YpaJUl8xJYreAs5uCp3OM8a/WHrFrZrtVDUGEqBkm2pgfeNIr1RPDeC/cL65Oa
         WRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766540098; x=1767144898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul5RYtwKuLzb4fmUt0dahcK3wJyHyhIWdXTPSkMhGA8=;
        b=ndziSdbeH5gEd5WJZXuYWtyxqvAb4l48tsS9F2ywG8zEp8wPGuqFwOzmm6lHfX2AVn
         KiEPPTf/EMAOzNXn2yZXQlfBHxCV15f42vdc8qOvqgWz42mRfltgt364AfSxhqYEbNBe
         IK99Z98TZDm/Vtzn+6GnHRX636CNJFVN1gV8aX7/tPiqFtRjvEA8p3l7LL8fGDCWG9W7
         /1qlcCe6URkbzTMyCLxQw0ZcrApBclCFU54BTtky425w+yO2o9ayY/hKSFCLJ/DwBnuj
         fiBy2uVZG5tQXZtMuskUmGSvw2f1Kryd7/7wPXXHei4Z7IzVeh7vxFKipl0lUWPOvp9x
         eSng==
X-Gm-Message-State: AOJu0Yy03AD8b4Pc+e6DvgPCBDIngJtNBJSE4Bwiudl/YKw1quMujIbh
	LIuxuJLirBCAV5j+DZiOgo71cKXJQJvePZqJ7xDv3t0OblY85fOxzmNMt9WOz1ocodYWlEosL3E
	Rv44wt4xP6QA0olF1C8qrMGVas78f6oG7eZ8MB5Jx5SCCxss9AvQMIns36g==
X-Gm-Gg: AY/fxX6EXvY6O2ItAe8GgjQ5qvIY4/uC8XnyppU3zAveGK1f8SOhiBFb917BWbdn3yw
	y53zkAIPqLRDNY+ZwmQXExzEl//rc6q1hN2LW3YoOO/vUyU0Bj4q5qoEviJdHKctieIlOq9PLB3
	maOde+Gxxf+E50jY1cCNOauRvc1Q80Nup5+HYoN+vDWKxLmTfLrnNfJ+V8v/CXibGxA6moRHu+3
	LKGTv5P/tTsIl79ogq5OfpK62t/aTlVoA9WTsb+IlMGonBv7I1bY5GirePGHkfrSvvLDrNHBnpd
	mzu8M1vYtdU68vwpMa7Qc5/Hdo5MnZfpTBfnnshTLJkat08aYEKFul/J/YvcPdJ/WwtmAjg5stR
	L
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d18bdfc61mr174135155e9.13.1766540098383;
        Tue, 23 Dec 2025 17:34:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS9I2SQh5r2tYHnvHjQVonS3jrba9soPU92JGUQFF6MGUaVBWeHJ/5ROPtwija6HgeR+BPrA==
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d18bdfc61mr174134935e9.13.1766540097822;
        Tue, 23 Dec 2025 17:34:57 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279d6d8sm319276165e9.10.2025.12.23.17.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:34:57 -0800 (PST)
Date: Tue, 23 Dec 2025 20:34:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251223203310-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223152533.24364-2-minhquangbui99@gmail.com>

>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> @@ -3463,8 +3444,8 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	 * Make sure refill_work does not run concurrently to
>  	 * avoid napi_disable race which leads to deadlock.
>  	 */
> -	disable_delayed_refill(vi);
> -	cancel_delayed_work_sync(&vi->refill);
> +	disable_delayed_refill(rq);
> +	cancel_delayed_work_sync(&rq->refill);
>  	__virtnet_rx_pause(vi, rq);
>  }
>  

disable_delayed_refill is always followed by cancel_delayed_work_sync.
Just put cancel into disable, and reduce code duplication.

-- 
MST


