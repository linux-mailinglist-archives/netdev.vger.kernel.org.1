Return-Path: <netdev+bounces-237564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B040AC4D374
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DFF3B0F15
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EBC3502BC;
	Tue, 11 Nov 2025 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcbZsR5Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBls8FG2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD3347FF8
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858110; cv=none; b=TsKUmmmskXzwJxGx/fOpAANqUYyXz0AQ1kRbeI6WXbil5xk30boqt5hTDLqIummNt5ZulenyfZsdSlomILQMHPhCa7tFhfjBYc04pLPPo6fGt8W8t01SU67CWccyxxuCjYg/OrUhkyf25dI0cYkBwSpZ6gjy4rzroDjacw+qRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858110; c=relaxed/simple;
	bh=jPYlSKbbxPShmT/j1owIcqg9LSaWtN/iy5tvOnqbOQc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KeTSghPM0Zhc8Nb+t62DnQ4LPFYDWkO3Tg0cXGF0dRhMNXfTx78od9cAGa5hbj271MAQa/oRSF5UdwaoQSNXPP8SqfCZv4vLVuVjhw9Ut2305BPU7Vgz/At7SIcTYWfXGLu4uc3Kytf1t3BcdQHd6RuhKxaAjo9CSuooeAs80pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcbZsR5Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBls8FG2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762858107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=702tscy4MQhNVgtuEfCcAB2EHb/k9VMlM8tKTxfp3Zs=;
	b=gcbZsR5QtmyWBdgzRXLGHPmCmkeosn+XW48erP+6VSA4oInIPEl2d0TFZmz43QwuS3gVF6
	z3GZbZBf5YcKsHxK9LprYGOnLMcrQvKsM+OG0GvUfsRNJbhlgU5UKVXBnMGyu6x1pcQwNl
	tqX94isODahWBTd7F6/ZCjB35XHJIrA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-JTtpGj8IM6GI0CboxYaJZQ-1; Tue, 11 Nov 2025 05:48:25 -0500
X-MC-Unique: JTtpGj8IM6GI0CboxYaJZQ-1
X-Mimecast-MFC-AGG-ID: JTtpGj8IM6GI0CboxYaJZQ_1762858104
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4777b59119dso19088765e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762858104; x=1763462904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=702tscy4MQhNVgtuEfCcAB2EHb/k9VMlM8tKTxfp3Zs=;
        b=ZBls8FG2ujiMr9Pw6ggjLbU/s3yowgM9HrEczw2vuhf4b0h6TgsCdn4Dg7Y+yUZoVs
         +s9k8+RdOTeRbStXypHx5l9W+P0xa/CwSBL4H/X3FkGK7yisX8Wmj05fqTOHzCL3Gpeh
         spw4ghfCVUgFkWX80icZ7I10jcKKgIb4m9n9QcvIw6v80sZvJSn48OhFXkKlXTpS+dRn
         pYQsVtUJJbsc7L1VCa8GeUfiDPea6hhS5JgLLCRZHZvEQL1pduj66iOJORKYWJscUSDv
         kRxWby0VtYWKDISdz2etTB3KXUJp1hi+mC0Gxc5dgg5f+724B0JYaxoZFTSC+LTmIcjQ
         v6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858104; x=1763462904;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=702tscy4MQhNVgtuEfCcAB2EHb/k9VMlM8tKTxfp3Zs=;
        b=VBRiB/zGX9ZS1zJAmTj7L71LE+FT9sTUP7os00ykBx19jwzGtBWjSkf6DjEpTPGMVk
         ofVYAG9lU8Lgpr1XbqAX669Lnpedat5j7zh4eXVdWS7GoD6oGrFIMdEUT/YxcmnQYRKC
         ppDrKRZD/ocm+oQsKfowq9NoBwBEHKiSWgEuMleyL2M97asz4el4z1tJHPVW8ZoVIh2u
         NgA6wGKkM+vUC9iB7W1SUqmPpB/9m4CVi+6OrK4FC0romSue1KhTUlBUFmiIQdkR6OQm
         xisprE6L9nzJyrqO0ua06pqXmNaDwzzqANBiOzGG4rqES704UoP8BczaabiCoRkieail
         /YDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9+OF1YFOSA6lhyGNOOuZ2fE8lITvimVv5XmI+46HGoZQmpJYkoR6kW/R2kwZynJLyaE35ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6YNRKyB54QROn2z3DWNz1nQkjkaMilH6XtBZ3Fy4gSVvJDAqT
	/2Uy8turo1QJFPL++4O3rINT4rK1VlBpicKVw/VMKgxF8FaJ0nNJXx6G2AsztFY8z+s1rNhTnxv
	C8JvqWeX1OKAk7kFdFVRMl/nKUYZRFdsexyBzww83B6heBL89mr7KWqHhzw==
X-Gm-Gg: ASbGncu1yGKi/n8pp9Xf8sgdon5cdFFeQ4nDrHsWH3emq86V5VGQQkcWV5SBe1Bb94j
	0N3DAjl1rPOWQMbXS6GUtf0akD3FcEEBsbOSsBp8mZw5XO0HgHps8L3AqpKBEgVyusp3T8ZCquR
	OTNWwjH+43FzDixXzsW6rqHPdRUkB6PMemIYBiBVEpmCcSNvGHPU5QutVrSkfkfxVC/GZsx52Ri
	n1V8J1AghJYVXes7pTEyDxfAPMymXviMrDtIvlTBJaHYIaxdFTxgvJ4lVeGrMqBPcewhzBRIBof
	eo40VaxFPn7/FLkVxpHT50N6lG0phLINZPaQO9ubEpJ7C0dqzOBEN7e7opI/G3GBsGaSP+cjb+p
	Z3g==
X-Received: by 2002:a05:600c:474c:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-47773228b80mr83633695e9.1.1762858104231;
        Tue, 11 Nov 2025 02:48:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF+RWqDNIiIpdYlbLwd8BM3n7tt8c8GRXGm3n3mN1y4siRCVR9yYMpmg7EqPzIAyqkss0fNw==
X-Received: by 2002:a05:600c:474c:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-47773228b80mr83633445e9.1.1762858103781;
        Tue, 11 Nov 2025 02:48:23 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477816431f9sm16926605e9.1.2025.11.11.02.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 02:48:23 -0800 (PST)
Message-ID: <e1d7d4c1-263f-4f2e-b1c0-6672ce6d7d58@redhat.com>
Date: Tue, 11 Nov 2025 11:48:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter
 caps
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251107041523.1928-1-danielj@nvidia.com>
 <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
Content-Language: en-US
In-Reply-To: <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 11:42 AM, Paolo Abeni wrote:
> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
>> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>  	}
>>  	vi->guest_offloads_capable = vi->guest_offloads;
>>  
>> +	/* Initialize flow filters. Not supported is an acceptable and common
>> +	 * return code
>> +	 */
>> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
>> +	if (err && err != -EOPNOTSUPP) {
>> +		rtnl_unlock();
>> +		goto free_unregister_netdev;
> 
> I'm sorry for not noticing the following earlier, but it looks like that
> the code could error out on ENOMEM even if the feature is not really
> supported,  when `cap_id_list` allocation fails, which in turn looks a
> bit bad, as the allocated chunk is not that small (32K if I read
> correctly).
What about considering even ENOMEM not fatal here?

/P


