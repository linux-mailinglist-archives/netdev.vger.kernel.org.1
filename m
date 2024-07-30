Return-Path: <netdev+bounces-114157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB7941345
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA3B1C23739
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EA19FA65;
	Tue, 30 Jul 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epc3vHRX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5C19EEB8
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346604; cv=none; b=I8koWRp+kzsv1gFr15QkoVVHZbQqZEdCRaXRKHsoZZ3JcA4oLk9GKRjNYtjJlvgf0dggmfZvwg+JHdYIk3hVcZvrxnaJ5p4Or4+t+pfvAM6Hw30gJkPN3X9cBHuKHiqtgDKy76lY9ngyzZNquXIzhFSjZ/1s7hZ5zkgza1+CUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346604; c=relaxed/simple;
	bh=JnSM3km5+UXJuj15oLI6ask+ce0zJBxnnqM9DUxBoUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBtSDSPrAELmI7LZbHg06SoqsOG+QHoaHQnDW/9EcRC/9+chSNqYxsr+bzOUgyK1XEghfYqqqRxiibdN1hHwAhbDE+1zM3AzcO3kOPhYgqSDY0t17lhCsO+4BW0Bkha0nQGi5aAhubm1fTHGwR/XdT8MQuNbhCifG5Ez4hZmEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epc3vHRX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722346602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuVNEy4xOWt4Ub4C6yCxDwdkKaweo/B+sDRclbAdOrM=;
	b=epc3vHRXR5stm8P+kB09qLqFRSLnQkBNPvpTc86Dl7hZ3jTCrBX7T0k2gZNHEXpoZEMRrb
	i/BsGgpQ0nRz8udtCbTfNCuw2WSGfkdvDs/eS5xzBjBrJOd9j1yroimooiz62R3nLipuVD
	BqCIiTYJlhJsudWRoV0VR+TR7A7iHzo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-MJvSAwL4OI2vEmbeErpWYw-1; Tue, 30 Jul 2024 09:36:40 -0400
X-MC-Unique: MJvSAwL4OI2vEmbeErpWYw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42808f5d220so6647685e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346599; x=1722951399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuVNEy4xOWt4Ub4C6yCxDwdkKaweo/B+sDRclbAdOrM=;
        b=r+WKMtgL/EKzSYkmwQkQYGXoRrwVbV83V5ByhVoG+2FIhvvrTt02rf00FhkR9tkEbV
         BedC2qjCtTIw0zLfdFsLOJMV64OCgVmn8dpmY5Hg28b+RbQ7obMPBVspY+vgE9KIGv7y
         ylUejLAVYVmpZW4KinVgiTMh0HoU8GAfVeLNRaZZAilrBaDpjNR7sHsuJoZ4BcNU+hNh
         kWtkQgwVtx9Vt3MIa2EjXHhvxSsDyuzGW1nd5CNqP7Ea+lZAIiYLJ2o0zZaMn/Q9L5ej
         54ckYKJsmusx0X17Q5JAyVEsPsSxMu0Xg3hvvQV9Ev5uqnOMgGE9liMEieVQED6PIFkd
         2BQw==
X-Gm-Message-State: AOJu0Ywjce6Zrrcf7lkG0gETS/eBS+6AJ9ry/AkjnPDPUd+M1t8f4vP5
	s8p5WsTL01+XkOyNCcXDYkTDKvaPnbnoco4Ak/JLWyjNwnp9NHzM7Yx3ZtkG/GOy/VHMEJCb4a9
	sAhdV9QfO5Hl9TfGLV5HqF9vTAoTexSi/2LPZhdLnwwdVkF6d/97Kag==
X-Received: by 2002:a05:600c:1387:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-428054feb50mr77825755e9.1.1722346599349;
        Tue, 30 Jul 2024 06:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcKDGMqStai4SGBrwfyOf5Ml0bQCsr1fA3iCXb48gvZ3TtoUsFQrtoVH5p5xe/VdBa9Aw89A==
X-Received: by 2002:a05:600c:1387:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-428054feb50mr77825605e9.1.1722346598990;
        Tue, 30 Jul 2024 06:36:38 -0700 (PDT)
Received: from [192.168.1.24] ([209.198.137.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428197f2597sm92790015e9.24.2024.07.30.06.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 06:36:38 -0700 (PDT)
Message-ID: <b6512bf1-5343-4130-a962-db2617a85fda@redhat.com>
Date: Tue, 30 Jul 2024 15:34:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <ZqjaEyV-YeAH-87D@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZqjaEyV-YeAH-87D@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/30/24 14:18, Jiri Pirko wrote:
> Wed, May 08, 2024 at 10:20:51PM CEST, pabeni@redhat.com wrote:
> 
>> + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
> 
> This is interesting. Do you mean you can put a shaper on a specific VF
> queue from hypervisor? I was thinking about it recently, I have some
> concerns.
> 
> In general a nic user expects all queues to behave in the same way,
> unless he does some sort of configuration (dcb for example).
> VF (the VM side) is not different, it's also a nic.
> 
> If you allow the hypervisor to configure shapers on specifig VF queues,
> you are breaking VM's user expectation. He did not configure any
> different queue treating, yet they are treated differently.
> 
> Is that okay? What do you think?

I'm unsure why you are looking to this old version...

The idea to allow configuring the VF's queues from the hypervisor has 
been removed from the most recent version, for roughly the same reasons 
you mention above.

Cheers,

Paolo



