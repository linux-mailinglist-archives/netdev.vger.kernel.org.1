Return-Path: <netdev+bounces-114121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EDD94102A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45B31C20DEB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB61940A9;
	Tue, 30 Jul 2024 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZshxtnv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A140BF2
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337470; cv=none; b=HTSfpoylpnI6+92lPVpVG0jYV1ghcEUcA979nmnsEpnPUqoPuqhjSLXM/827ngNII93j7NKnf+r0M+8S85tZFCi6MH6RkuwJMwKKeaWEPZ6esmOA/CoQ9DgjzUf2AMNIcWd+u5ga9HWhd+TwjMuWkoH+Ocj4hC/NGaFoLQqvHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337470; c=relaxed/simple;
	bh=Ek7LZA5Adjm3ym/z9e5JoSavsfcTgjsWk6/6JIJ7t3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXHJYx0x65isY8VqOr/o3+DC+GAXyJYn+pltv5tE1xZmawO7gXiwZsBtWUt7ibCPYQcmLJZyzaCccbihDHC2fYiNwXfd3CxQTio+OW0fzfrUZKP6gwpSq6OV+D1ZBG5lq2sXgVFbYW8hfHTZfqCIa/rhK2WUGTTOteKvqinnf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZshxtnv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722337467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezFPTQ1WGSxucSjVp5951QXGyi8WZfLh5S7gZkt1lk4=;
	b=BZshxtnvBjYRNuHXSEqr/Id/SHAyssSJAt4IDWdldbQiFCqBlsRGlPIZTQd0g0+DPRvgIP
	eqA+IulplPHiYOmndar0VowPDxFT+eDQrWlMssWfqnc5SCzpA5KGiWfUEze6IcZaMoCZGG
	cyxNtRZmLotjMfV3up0TRsXcfWf6XCc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-o_CaYYc3PXyaiFTJSgMEnw-1; Tue, 30 Jul 2024 07:04:26 -0400
X-MC-Unique: o_CaYYc3PXyaiFTJSgMEnw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428076fef5dso25754715e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 04:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337465; x=1722942265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezFPTQ1WGSxucSjVp5951QXGyi8WZfLh5S7gZkt1lk4=;
        b=lC9d3kNB/zBvyaBCeLyqK8nXw/n3dam35hPaTLX47db687EIOWAHzR3nPBezNy3Bw8
         mKbaJHU50KUsItZYnINRf1KWK7IwFYw1r++BCYu1VMUz08bcj2I402TU9QN1RD1UeTPc
         hfLOdmv2Np95dMuEfQcXLPeSA/rW9oYegHw+3MdGS7TfScNujxurnWxb2DrYjZThymQe
         Gc+IStUjS/Qz72r62/gHqq382PmH8SSapvPVBTP8H9dy7qiZPIYXsRJWzy/7RqazIMt8
         WwftxjXlPIA9qlQpybuja6BadBpSoKrTtdeMsfcpCmutVwjs+lTI4+9uXYGM4wZ/fPzY
         AyTA==
X-Forwarded-Encrypted: i=1; AJvYcCXtNwoVkBiiPQZr+CnekxInC8r7JhR1WHOKvxBAwwifPEk1MucrnpXgGW/VRZIvaGijCcI00FcvcZ/7n4rZrhf+MnHBFm9b
X-Gm-Message-State: AOJu0YwNcGmhYAr0YIMdfBggANo1p4PfKDPO4tGp+oMQYlHZm09XWqLt
	TDfXN5QxzpGJU4+A04DBONPivyeIlFMKPYMOxYmDsxfCSV2bFOqTonWeglVRRCEADQGTAryfNog
	2/AAUrHEd+e6FomSDPYyCwrOTnYWgBN+8r0QFCnwq9TPVvPlhs7QBNw==
X-Received: by 2002:a05:600c:3153:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-42811dcd2e1mr67798165e9.26.1722337464875;
        Tue, 30 Jul 2024 04:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE39v1pXN85w2qGztmjiUvkkGOPsZjbJmzMayqH+ReAnENY9kABuKyGJDrx7hXWY7gOyf34nA==
X-Received: by 2002:a05:600c:3153:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-42811dcd2e1mr67797975e9.26.1722337464436;
        Tue, 30 Jul 2024 04:04:24 -0700 (PDT)
Received: from [192.168.88.254] ([213.175.51.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280f8da2f7sm143824605e9.10.2024.07.30.04.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:04:24 -0700 (PDT)
Message-ID: <03c24731-e56f-44b2-b0a3-6afd7f14f77b@redhat.com>
Date: Tue, 30 Jul 2024 13:04:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: XDP Performance Regression in recent kernel versions
To: Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "hawk@kernel.org" <hawk@kernel.org>,
 "mianosebastiano@gmail.com" <mianosebastiano@gmail.com>
Cc: "toke@redhat.com" <toke@redhat.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com>
 <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
 <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com>
Content-Language: en-US
From: Samuel Dobron <sdobron@redhat.com>
In-Reply-To: <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Could you try adding the mentioned parameters to your kernel arguments
> and check if you still see the degradation? 

Hey,
So i tried multiple kernels around v5.15 as well as couple of previous
v6.xx and there is no difference with spectre v2 mitigations enabled
or disabled.

No difference on other drivers as well.


Sam.


