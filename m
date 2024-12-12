Return-Path: <netdev+bounces-151364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A09EE68A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85DF1886D66
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8A212D89;
	Thu, 12 Dec 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9DVQiAw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268D158DB1
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006042; cv=none; b=H785b2XZ8PBiyI0B3E/I9hloG++kqU4tPdSNIR6jjfeuKHycLIIRk6HkGXIxMS8/2UCISWxMXqX944kQmM3Tbb/+YPUvU+CeV8WbqFK80te51GHZYDYtIhHaHsjtdEgcCn4PuY75uuT88zIkjoQ3n1yu8WavvA12u4B2a70ssLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006042; c=relaxed/simple;
	bh=QZRkLPEj2S7kLjrroCGhEvsM5QqkT9AA0+/38b8JvVI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Yv672Y68YDil9fIWn5m9WzPr0hT9TCQlvVdAXfoWEuhGfXbV1O7UcWuKnM6HAeUQSNAYns0R+k39pAPApvWQcRdkIhWKE+0NShhIlFqex+dLzVHkkohmJQ7FtB98y16EYlyVJuQEybNN0Eib4mhQifxyJDkIITQ/jBwlJQ+Sbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9DVQiAw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734006039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlJp+qxTqninqrTTH8Idhretk/YwbbGsFFh4YF66Xoo=;
	b=g9DVQiAw2T/L8EJRqI9MGe4imGYMkDqPQ8/oBk2JjduTak1zYyRiICi+qxG1eL5/70nXyb
	6d85n4WbGbwFCfNb/EQHwPMBwuPF5rPNeMED1uX2e3BhwZp/geZOeOOROBScOpHoeY0ps5
	4FqBT/4A96x++xQmoJxXCjIO7034QN8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-1iBFZaKNOK-kDSSVfkzYhg-1; Thu, 12 Dec 2024 07:20:38 -0500
X-MC-Unique: 1iBFZaKNOK-kDSSVfkzYhg-1
X-Mimecast-MFC-AGG-ID: 1iBFZaKNOK-kDSSVfkzYhg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43582d49dacso5089625e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734006037; x=1734610837;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlJp+qxTqninqrTTH8Idhretk/YwbbGsFFh4YF66Xoo=;
        b=NRdtP5iLEjfOdCyqe7veVqTc5jin4k1lAwAyyhZ3jo4N8DdZ9I1iBXaeex2APqF3f8
         utv3T+1dPI8M1qrlQHNlYZBV6rGxXqZHBamgLeerFwHXPxzsjv1m7/zt8YyXfQ7w2n/2
         2xRF/77Ycrs0jI50eBySPn8ltEexPU9Dk+wnmkxI7y4bti3cZ3Ka6FmvfyMrtul0RNQH
         BCvomsobW5DLLUIKSF1ivY81jLjxg4c354LSt5QHF68VnjeOrKt72zBuj0wgrB61YQ+J
         sebjEhRrQtsuo+wNpx9bEVlAs2Cn33ZHUFcHuaIO6GL8Kk4ao2EDtaYidyJOm7FYAFMi
         FoGw==
X-Forwarded-Encrypted: i=1; AJvYcCWLfvfiiZJXOhYOG58vqG9eVZzFeqBRGRtIENYUQeFKMK9LVKifMsWEFYEaoZv28J2kbqTxJhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSd1z3S8R2QE8uIok5IDjZJKaxMpoDpTNEgFHW+DUTju0F5V8
	uAbqVI3XxcRpvXI7wi5YUu3oRQQdWnvenKoEdY+DGZYcVWDgeyLQ7DnVpXhet9jCBpheqmqTGe4
	pNByX2/U3l9KTxbVhQusEEuEmhlXWtAZ83UZ1fL8e7MBp1U9M6lxPzg==
X-Gm-Gg: ASbGncuM5YE9HzCt9w+4Jd6tMeNyRNRmxdVIzIh/hj4gZQQ/pfiOQxHSBuvfHHQ+mE6
	sutjeKWMV47SF+g4GX2cw5MNK7/z0bmsIJ7L1FiURkunkIXs++5tGuyppPT4FXBcJuy6kVh8vST
	YUtSixHCn3Z/WMBfhBswYrFFlnqmlWYh1qfMh0Z6lDH2UF1DIO15o5tYg+yVxAV6/ySdUZdF8T5
	x3NUI+PTIDQDSt8hQ31b1ybRVZHY2g3YvCx+87Gq9y7wjZA+UdpNIr6yDVvQDSa9MHJHcRpKVb5
	7/u322Y=
X-Received: by 2002:a05:600c:3b13:b0:434:f335:849 with SMTP id 5b1f17b1804b1-4362288371emr25177775e9.29.1734006036724;
        Thu, 12 Dec 2024 04:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPr6pCTmhnA9QQQ2uGIDQaJpz5PmV2aUGfUE1rnGpdMOOO6lxTU89fpfR/gpd5bVP3n+GR+Q==
X-Received: by 2002:a05:600c:3b13:b0:434:f335:849 with SMTP id 5b1f17b1804b1-4362288371emr25177585e9.29.1734006036355;
        Thu, 12 Dec 2024 04:20:36 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559edc3sm15173045e9.22.2024.12.12.04.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 04:20:35 -0800 (PST)
Message-ID: <b6ebd1f0-d914-4044-913b-621071a1b123@redhat.com>
Date: Thu, 12 Dec 2024 13:20:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-12-11
From: Paolo Abeni <pabeni@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org
References: <20241211172115.1816733-1-luiz.dentz@gmail.com>
 <ba32a8c5-3d90-437e-a4bc-a67304230f79@redhat.com>
Content-Language: en-US
In-Reply-To: <ba32a8c5-3d90-437e-a4bc-a67304230f79@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/24 12:55, Paolo Abeni wrote:
> On 12/11/24 18:21, Luiz Augusto von Dentz wrote:
>> The following changes since commit 3dd002f20098b9569f8fd7f8703f364571e2e975:
>>
>>   net: renesas: rswitch: handle stop vs interrupt race (2024-12-10 19:08:00 -0800)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-12-11
>>
>> for you to fetch changes up to 69e8a8410d7bcd3636091b5915a939b9972f99f1:
>>
>>   Bluetooth: btmtk: avoid UAF in btmtk_process_coredump (2024-12-11 12:01:13 -0500)
> 
> On top of this I see a new build warning:
> 
> net/bluetooth/hci_core.c:60:1: warning: symbol 'hci_cb_list_lock' was
> not declared. Should it be static?
> 
> Would you mind fixing that and re-sending? We are still on time for
> tomorrow 'net' PR.

Whoops, I lost track of current time, the net PR will be later today
(sorry for the confusion!), but there is stills some time for the update.

/P


