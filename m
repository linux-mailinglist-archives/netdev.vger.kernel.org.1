Return-Path: <netdev+bounces-126937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217709731C4
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0511F293FF
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250EF18F2D6;
	Tue, 10 Sep 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrW5H+1w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D736188A0C
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963040; cv=none; b=WOPeTzitJ15bV9w8+K+RuGxXDE5pNd6qYhPjE9IunPv75Zj5jwTU4YN65eYdYSJYdsL9JanNf2P0tWfL4++BESFDJAkP6sG2cj8AWM9Xq16Vx6m0d5H4OYpYS/wZHzTx0yUlWvZJTXmzRSobZ4Um34bnYKtpKsPDg8rApr4SkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963040; c=relaxed/simple;
	bh=yQgIcAICTK5FSWGbk9Lt7d2+qEYj6jpsnfuNFFZDyvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRYlWKSjM1lYB6WKmZia1kbg7iZL21Vk8qjL5Smj3pqxjFmRKiZe3OMkVFyCEWxc9eQ3KGjldbTKfUFDx7wd0n7wXDXsiW3p3A5hi3FoBKMktkDa5zTH2Lt6XN5izCbR/KrZeV7+WBY9DpK1wDqMqIVo5MRRmtGKHxNdRFM83Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrW5H+1w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725963037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coz659OmmUlcW3lKa0lCNSzio6M2iQCVXxig+QSR0UM=;
	b=hrW5H+1wbKRr5+l/WQ2cweyMqgdiT3f/FjBuOPWCWTShjHc0k2r00G/Dr12XplOtvZJdzL
	XyUSAZ57IJ4jNcvRmgX1YHIcsu1sgAonJBqprIR8tYB1EaT8w6AywU77z02aoVoUCXR3LG
	7Ik3+Kqtv/9lUvPPSnyPpv6EyFT5rAw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-TpFdmM4kNuW3sKXY3HdzcA-1; Tue, 10 Sep 2024 06:10:36 -0400
X-MC-Unique: TpFdmM4kNuW3sKXY3HdzcA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso42359155e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725963035; x=1726567835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coz659OmmUlcW3lKa0lCNSzio6M2iQCVXxig+QSR0UM=;
        b=COAgZxOE09m/k8uVpdbUJcDohT49N0aG61GEu5SI0z7Blwc5pMe0aqRz1raqGJfmTQ
         GNmJ6k6G+vB2A/Tlovafg3mNbSmQUP+Cm75a8WrM2HklMGwVI0QN20ha/xXRhGhJWQ0K
         1gX0XlIyz39IEVL4shf7w+WKIoC0KtZqIlXPsJlcIXgtqMg8YBMSMSrpKUhO6XGvnzzq
         R3dEZ7Ojx4DhE8rWG2PoCgveIWbO4k2zxEZ+kcZuYMPIKDf8MWuUoRjoiJ1v6nmV9ClV
         p+DQbXP8GdbnSBYIydZq/0H8cJDj5EDWGlTfKPMd3kCtsVdEBTOEcaDh0N0aObhR0SJW
         gD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpfRK273/QPEJItJT0kqeOmZPjaPYFVIC38HEpVLxNYFAhbXscdmxLBIKAM8hYrTM9wrS4mWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jCp85QDcbBRFLzyBFLytZw/pWJ2IWZldP6XvRoIKB1a7SkLB
	jDrBawDfvctiqYpyLwr3uqge0CGJzRtPlESmop6gOJ/C2pTkUn1kT0m/OwWnM4vX21xzrIH65EG
	HsjJJbzg6NyYbovlknLBkOrfxSuyoqfN2CtYnMzDMUJtOfqXwDb5aSg==
X-Received: by 2002:a05:600c:5106:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-42cba834410mr35477105e9.7.1725963034861;
        Tue, 10 Sep 2024 03:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3UJumNEoidGRa50Pqmtdr9Dobsm4P/vGruZsRioKW5XA/TzKoc4apQYmFttnD6MjWJ08qzQ==
X-Received: by 2002:a05:600c:5106:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-42cba834410mr35476865e9.7.1725963034316;
        Tue, 10 Sep 2024 03:10:34 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21cdfsm105744195e9.10.2024.09.10.03.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 03:10:33 -0700 (PDT)
Message-ID: <8a1684ca-755b-4612-afe1-41340b46f2fe@redhat.com>
Date: Tue, 10 Sep 2024 12:10:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add sysctl for smc_limit_hs
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, edumazet@google.com
References: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 04:35, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake workqueue congested"),
> we introduce a mechanism to put constraint on SMC connections visit
> according to the pressure of SMC handshake process.
> 
> At that time, we believed that controlling the feature through netlink
> was sufficient. However, most people have realized now that netlink is
> not convenient in container scenarios, and sysctl is a more suitable
> approach.

Not blocking this patch, but could you please describe why/how NL is 
less convenient? is possibly just a matter of lack of command line tool 
to operate on NL? yaml to the rescue ;)

Cheers,

Paolo


