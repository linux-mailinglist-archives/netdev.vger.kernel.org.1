Return-Path: <netdev+bounces-231122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6653EBF575A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188DC403F3F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF42F3C1C;
	Tue, 21 Oct 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPzqLSp1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754531D736
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038205; cv=none; b=Dt1/oVQLRHnFKOJTUpXIAR5mM6u/UOXaJDvtaLjfohoeYXZhBY+vm095VqyrgeAerixCbSjr2KrK90ehXchGm3g6d4XL1DrLmAUzYiuDx3UHqlpRj4sK9A3OBJE6F8eYTAajtXJh+JmjbyX85iyazifNxYuyDbMUtO2qHZiiZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038205; c=relaxed/simple;
	bh=8LQ/nb9TyND2NxmnDu4kFEGAHzYL+AlzQNRURq4dY1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dshOXiTL/tU/fOZhLQrUIhFf88oXp+YD6eC/LjBs5hw+izmM5327ME9oM2pOFWv3NmVOZFSAG0ksH3C4lLrMdNGXB3jmgv9Z1Hf4biyZjDIvJ2Cf8Rk7Vabrvlr/Fdud8VP8eOaLGkm6GrgPu1pVWijJ4E3/Az30fl2RqF+dROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPzqLSp1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761038202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwhZk0idClOTokwdt1kB9ie+33phkwv0ROh+5vx+wgc=;
	b=bPzqLSp1yWuIm91GAVViKb95lw1FRwOtja3UySW039vmeRVPzmyRUGD44YAjnuV73thRdR
	gvVl0X25Y71NVOHJcttVlPvC4zKu/rFQ004izzNf1lfpzemUjaYE5C0GVeIlffTk4UlGP4
	F+JH6Tni/MesrsnBgSUONyW+mE25gwU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-7yW6KoGCNyGa77zx1qW5Tg-1; Tue, 21 Oct 2025 05:16:41 -0400
X-MC-Unique: 7yW6KoGCNyGa77zx1qW5Tg-1
X-Mimecast-MFC-AGG-ID: 7yW6KoGCNyGa77zx1qW5Tg_1761038200
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso3356003f8f.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 02:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038200; x=1761643000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwhZk0idClOTokwdt1kB9ie+33phkwv0ROh+5vx+wgc=;
        b=cpn8R5Io+sPFxBvfP+e5laHcoIQWFuIDptdrlbqy2cFtFzfCbCNy5wX2oX0rEjfAdP
         3pY+ufTf5UVJ6nhMkFf49ruIGG1z+hR94Zyf71sEMcEBeAvU/mVwugBHMP0WiqV7uEY9
         JWi8cT9Sb+ePXS3TbaTpaWZ4UCS6S4jVMYUvDmSHEC/fpzFuhJRrQX0OaBCQluQ073HP
         y9AS1RdRlHSDHlpXDatB/LxB9wZjRcSJIxOdak7ofOiu3J8had/h0kMsqe6GqHoU1RFP
         ToDt1Zkt7oQGq+bnSLBKw7dyKVcP9DCAKexmVXhHoUaPi0mV1Sx4F4DO9t9QB9JTo2YZ
         iCMA==
X-Forwarded-Encrypted: i=1; AJvYcCXy2EdwEdtv8wQS4UaHd6crlg5Pyxdr6pJ+jqYPexNL4wBX/8amiL1Omt6An0k7vlTUhZs+KiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQsvoSRviwfxylzUVfmgp0jIOG4qgFEsxIhYBc/nvdSfJ0Ploj
	fW+T9YaCj92KhZ89xUKGnjjYy7fSgk2Vbj01Tj8/80bg9SY8nTrRMUhvZDnn8opTpNlryHGvVyL
	v1PaoDqCtpdZJhF/t7V0glPzFWCTT2tGlijHbVrqNCPdEkjXIfQ5IC4xvwA==
X-Gm-Gg: ASbGnctlhzdoTZZKOFxIQZV8KFGspSPqXOiVXDnaKB/U2uRwowbPA2nSvVRxwhORCOT
	BI53SdjYtbRHrxx1oJMrZzCIQeA2COVCqxsIcJwcCH6eg3fZK06VYITYUGGvh8CCKAAWm78naI7
	oaS9G1nTcOy6IEBFbYAEw9NqnsGJxvF2YgnEBkelH8hr4g+wh8ZqG6c7UcO8KVm1264vrN9cL/m
	onYXht7CvYJYF+4LH5KAbGdeA4XUZwSRTW+cOxI/F4VZjd0O2HjYLAz6spPQsZDx/p5TpIJU839
	bznF5YY+pvsN6Ke5c83iYMvnhrjdIHqzXcWMRRwfkZwz5npqjNs5ozU4Cmz/BXmDQGIKh3XrUwW
	huwUvk3NC0oibM3unCDHNQOfZ5qNYV8jbZbqLA3F815JjfOs=
X-Received: by 2002:a05:6000:4b08:b0:427:55e:9a50 with SMTP id ffacd0b85a97d-427055e9a5fmr14239066f8f.22.1761038199797;
        Tue, 21 Oct 2025 02:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7KVV1+IVlCnxGJa+IEfd9KjImXec2CvlmcZyIJuKYZXgdCm3LfUWHQiFa8o4QTz6lM+WKlA==
X-Received: by 2002:a05:6000:4b08:b0:427:55e:9a50 with SMTP id ffacd0b85a97d-427055e9a5fmr14239037f8f.22.1761038199343;
        Tue, 21 Oct 2025 02:16:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm17338241f8f.10.2025.10.21.02.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:16:38 -0700 (PDT)
Message-ID: <1674cec4-4270-43e9-ba32-07d058a79b56@redhat.com>
Date: Tue, 21 Oct 2025 11:16:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 1/6] hinic3: Add PF framework
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Markus.Elfring@web.de, pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>
References: <cover.1760685059.git.zhuyikai1@h-partners.com>
 <beb30a91e7d26245e3736285fe4ceb52d4f9c418.1760685059.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <beb30a91e7d26245e3736285fe4ceb52d4f9c418.1760685059.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 10:30 AM, Fan Gong wrote:
> @@ -431,11 +436,40 @@ static int hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
>  
>  static void hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)
>  {
> +	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);
>  	hinic3_free_cmdqs_channel(hwdev);
>  	hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_COMM, 0);
>  	free_base_mgmt_channel(hwdev);
>  }
>  
> +static void hinic3_auto_sync_time_work(struct work_struct *work)
> +{
> +	struct delayed_work *delay = to_delayed_work(work);
> +	struct hinic3_hwdev *hwdev;
> +
> +	hwdev = container_of(delay, struct hinic3_hwdev, sync_time_task);
> +	queue_delayed_work(hwdev->workq, &hwdev->sync_time_task,
> +			   msecs_to_jiffies(HINIC3_SYNFW_TIME_PERIOD));

It looks like the above unconditionally reschedule itself (also
apparently it's not sync-ing anything?!?)...

> +}
> +
> +static void hinic3_init_ppf_work(struct hinic3_hwdev *hwdev)
> +{
> +	if (hinic3_ppf_idx(hwdev) != hinic3_global_func_id(hwdev))
> +		return;
> +
> +	INIT_DELAYED_WORK(&hwdev->sync_time_task, hinic3_auto_sync_time_work);
> +	queue_delayed_work(hwdev->workq, &hwdev->sync_time_task,
> +			   msecs_to_jiffies(HINIC3_SYNFW_TIME_PERIOD));
> +}
> +
> +static void hinic3_free_ppf_work(struct hinic3_hwdev *hwdev)
> +{
> +	if (hinic3_ppf_idx(hwdev) != hinic3_global_func_id(hwdev))
> +		return;
> +
> +	cancel_delayed_work_sync(&hwdev->sync_time_task);

So here disable_delayed_work_sync() should be used.

> +}
> +
>  static DEFINE_IDA(hinic3_adev_ida);
>  
>  static int hinic3_adev_idx_alloc(void)
> @@ -498,15 +532,19 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
>  		goto err_uninit_comm_ch;
>  	}
>  
> +	hinic3_init_ppf_work(hwdev);
> +
>  	err = hinic3_set_comm_features(hwdev, hwdev->features,
>  				       COMM_MAX_FEATURE_QWORD);
>  	if (err) {
>  		dev_err(hwdev->dev, "Failed to set comm features\n");
> -		goto err_uninit_comm_ch;
> +		goto err_free_ppf_work;
>  	}
>  
>  	return 0;
>  
> +err_free_ppf_work:
> +	hinic3_free_ppf_work(hwdev);

I don't see a similar call in the device cleanup?!?

/P


