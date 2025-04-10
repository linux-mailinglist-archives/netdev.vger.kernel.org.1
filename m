Return-Path: <netdev+bounces-180970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D829CA83513
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0431B6685D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85012B63;
	Thu, 10 Apr 2025 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK+Rr0a6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67986FC0B
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744244331; cv=none; b=c1vNhxmXdHfIKqWt6qaa8xo5zj7VTV3FORy5PO9tQ0eTrO1p7kztWQg/VnYHWbTRlu8zr//SvNW188aBxCrpd5ygoj5h42V037go540VNs4cLcV2Od0ZNo5Zqq1qS9ZqCEA2+/nKTIGqj564yAJAGffY3RPUmtU8+uuMsBPIvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744244331; c=relaxed/simple;
	bh=s+PzXNKbJt3JsUCHJdE6Ao7iwC36IXVrQDl9xsIWwC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IR/Mizkz23K9yoi/IojXR9PLCvsgqd2KtEWvz2IT8xAUyikF9k9Uw1qXqTwE64wdq+XGkmit9C5UGg6jC37YeWLLK9FSHNO6BkZOhT9bQvcEmQs5SQGXYPMoRaKKJjAHcPfLqp+6vLooibjTTnrdVbVooBbH8EEdxXoNVNimp7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK+Rr0a6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso179992b3a.2
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744244329; x=1744849129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFlMF8fqDPm14tTvIOjeWMgKHRPyiqOd/HgbgdEetug=;
        b=SK+Rr0a6uVatDRszcOKhLVMwWwIR964cstSGL3BVtV8V7yMPxVnYgY2lTgGlUk5Ev7
         RmxTQIgbwuIoTMkv2ssTtls1NpAJjyIVIzzupHT4jN+R3BDqYk8SQNWjyfVH3FQteNSU
         fhIpuBRFC1H29L73OcDJ7tbwobG0RQsUOpVmqQwGQUFBXWYHbLMzVhwAo8/QnSm7W9bj
         2j9nb3a6Q9Et6G6RrEonfkEBbt/OT6Abhf/8qiq1MwJeAK7sGczyofb1HMAWIkV76hxr
         +SO9T44sy42YqfqHRcEoE+9feLyf5AH4+XtdWJrbURGoLtXoINxMD3lEzJs0mM754X/p
         YR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744244329; x=1744849129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFlMF8fqDPm14tTvIOjeWMgKHRPyiqOd/HgbgdEetug=;
        b=vJBEAypgxoh1RslqCniN1+NJOSNiO8BGX1Rn//KYvQRt4AlKln6jZaxYENC+LsHLhU
         rg7Ue6Wi1HxeyJhuk+AJHLD0Tmbk7thvnbozo758kCz7io82X8FNbdHDGBBuNFYz1zgs
         OhTBuabwGBavs3xN0ZMFw/WCne1PWIvRARASfbLArHMQtsPTC3FazS4DZeVv1hpUL3b7
         ih15wF32VN8Fw0l9xzrRgr2q9rhnnKdimezZScyImpKJw2QCBE7p0hTKRWcC1H56BBRr
         Er4L6uDj+xPOANrjNh74q2Zhzo73gnJ7mWLQoRDSDntGxW2Zjv/BdTEnDdb+stPg1/yy
         V72Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZmbPPRD00X74sFDHnR+FCTuPSrRcaoQT2KpV2wYkOxsfcbILLDs+O+S+ZNKQtHcxkzWW/YwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3bWzgE/GILhaIdkV+vV3N+hA4NFzSn1ksZnOog+GIRumOLrVH
	Z3epdITwCOTXhoybQaUNCoXIyl37nN4kk9+fpUAwtXe+RDNvO/6/
X-Gm-Gg: ASbGnctTmY+kadXzmF5CtkNNHXllYUUo24CWP2DeINof0M2oTgBxM3sQnJkbURCMFV6
	eOeW3lhHm2NMEFiZD/6Kp0oWbS56uB6OAf/cuTkM/gMSShTFrfmDXSSlGGvF9PrXhNMa99VUFgd
	iQegaUdAENHd9RwEMRtse0rzXA25/Y4b0L7ZqZvtUVfns1Bn4DQg7ZaOP7ZxT19Cs3YqdabD4l9
	FmdlWOAPIq6dG+9FrqXNttO27bdKSOwupg+qKwzvVWF60ZBWOysmIbnB4CwczBCb67by3ZGE2SG
	VPJ4Z5rGh3/mgi4kc2uT+It1hKs5yECqJQz9bAoeDl3BKX7zdzK0K5XApadPf/Aeqm/8txQ+Q8D
	7VbZj10DjGwImgrwuVJAaYmY/DQ==
X-Google-Smtp-Source: AGHT+IGqGkgSnnHXVOLnekNKJgYyw+qSPoYkEVs0Of9Ar/Qenq7NmuyfFe3J8vkInq/Z17hAesvJyg==
X-Received: by 2002:a05:6a00:3915:b0:736:34ca:deee with SMTP id d2e1a72fcca58-73bbee5480cmr1003435b3a.7.1744244329395;
        Wed, 09 Apr 2025 17:18:49 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:102c:2ede:cf31:2f66? ([2620:10d:c090:500::5:fad8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e38569sm2061690b3a.93.2025.04.09.17.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 17:18:48 -0700 (PDT)
Message-ID: <0a5fee34-5798-49f5-af3f-c6e56987da62@gmail.com>
Date: Wed, 9 Apr 2025 17:18:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add coverage for hw queue stats
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, suhui@nfschina.com,
 sanman.p211993@gmail.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 kalesh-anakkur.purayil@broadcom.com, kernel-team@meta.com
References: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
 <20250407172151.3802893-3-mohsin.bashr@gmail.com>
 <103301d3-4c38-428d-aa31-501654064183@redhat.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <103301d3-4c38-428d-aa31-501654064183@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>   
>> +	for (i = 0; i < fbd->max_num_queues; i++) {
>> +		/* Report packets dropped due to CQ/BDQ being full/empty */
>> +		rx_over += fbd->hw_stats.hw_q[i].rde_pkt_cq_drop.value;
>> +		rx_over += fbd->hw_stats.hw_q[i].rde_pkt_bdq_drop.value;
> 
> I'm possibly missing something, but AFAICS the above statements can be
> executed without any lock held. Another thread can concurrently call
> fbnic_get_hw_stats() leading to an inconsistent snapshot.
> 
> Should fbnic_get_hw_stats() store the values in a local(ly allocated)
> struct?
> 

Thanks for pointing it out. You are right. Let me fix and resubmit.

