Return-Path: <netdev+bounces-144009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BC9C51B8
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AC61F21FD0
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39661A263F;
	Tue, 12 Nov 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq2W3XCi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675891AAE06
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403067; cv=none; b=FrVbrvU9v0RK9rl41X46xHF7JE6BkDTSv5IF96Mhhzm0RxKPKJ8O8PQC4sohppNJJlVGsHMji9e+kunNE2vrtZ5pmSuPeY6ErZiQ2HRVFtJYb89qqIuwEaMowRhkWw9XMDml51CXiKybc+hpzR7RQ8XFNBcExfAIlDOXB9R0JBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403067; c=relaxed/simple;
	bh=zNRRtlMozq1Ozj48r4nNeYVh9O6jV/fhcr+TQIMkblE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jb+a7CvTI765/vkXxcgFHNlAQ7GXIHWhrdtsPxY0vJlbAeMweoQhUUeLyHtFOHw5OKGNnauosVCuRgjvT+CO9+c3r2eKvWVwu2nvV6ffO2rrBkC4/5+ivz6WpHYy75fSWIhSpCY1fHp+pna7qAaVOtJ9dSgQwd/fJM3h6wAwQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xq2W3XCi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731403065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUZmO2vrf7r83bzqg6GoPGcZR6uwpTYKCCT8l9l6ZYI=;
	b=Xq2W3XCiFO9+fn1kmDdCfMC30wnWIBjrhadPchVt/LNb5BwjXQx+156YxaYk+nIP4f8/um
	oA5zOPH7Krqo/vzHa7a18dCiUkkXwOeoxIpvgNRxfPGY3pkTmhPzZ4BIva0vnMhV0fnZUu
	nHLlEGxMBK1GrWreJjTWflKtz8pBXl4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-hZF6cq5XOsqvD_ZQVbPNcQ-1; Tue, 12 Nov 2024 04:17:44 -0500
X-MC-Unique: hZF6cq5XOsqvD_ZQVbPNcQ-1
X-Mimecast-MFC-AGG-ID: hZF6cq5XOsqvD_ZQVbPNcQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so42051765e9.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 01:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403063; x=1732007863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUZmO2vrf7r83bzqg6GoPGcZR6uwpTYKCCT8l9l6ZYI=;
        b=YTheLf6J0LiFj39gSvlA87B2jpn3zua8JqFiq2gQbhAiuHae/ILTSg7InzzqB/1+Cx
         dr3rsT8FtgS6vkhbvQx0iEy7swZwZIDNZlkB3SbgN3ys+gl49AVozMSX+YfUb85gn+wk
         ufxITnSi/i16aAF2qoywkPxUM41Hcq9qcpjdAxDwmgNvgEzc76WBolT7w6Gnu+l8XjLM
         Xhhxlxjz5rXVPSybExaq/lO24VfBokHq4ed92x3iuxWZk38ckP2IxQZ4vtsQk5IPzk7d
         Z4Y++h4ad/c0ElJzsj7Trp/3LwENeJDpHeX4jxQUFC0lAIp0P3DqVc2dzdBr+EVBb7I+
         eMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRyAKEbZkWMdYj41qF22zDdmKqIyGJcCpKBlNHlTaEBFnYcXBlRAnaVwV6ptzRIG51B6YV3Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKIMWCCknwfV0iSIuo6TwvjVSBiktRgfw/MCIpA3/+vqOX310e
	ZR0K/WGZ/dRAgU7wj6Z12RCjImDqfYT+enqWj88G+WoF+i1SBQQl3oP5L1YZIML42K4/VLInr9w
	vXTcf3uYE9HG3/d6W7CsCju4278iOf06is9PozuOcHEDto0PLH2ES9A==
X-Received: by 2002:a05:600c:35cc:b0:431:1512:743b with SMTP id 5b1f17b1804b1-432b751b715mr124837105e9.21.1731403062706;
        Tue, 12 Nov 2024 01:17:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsEMbxjSuTsRJEpYPVXjdyVvt4My9F/LAOdJf0xB4KchwsKYoZbPB3oV8tuqhizUwJMdOXhg==
X-Received: by 2002:a05:600c:35cc:b0:431:1512:743b with SMTP id 5b1f17b1804b1-432b751b715mr124836865e9.21.1731403062360;
        Tue, 12 Nov 2024 01:17:42 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15134228f8f.88.2024.11.12.01.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 01:17:41 -0800 (PST)
Message-ID: <719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com>
Date: Tue, 12 Nov 2024 10:17:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v6 6/9] netdev-genl: Support setting per-NAPI config
 values
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
 bjorn@rivosinc.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Mina Almasry <almasrymina@google.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, open list <linux-kernel@vger.kernel.org>
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-7-jdamato@fastly.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241011184527.16393-7-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 20:45, Joe Damato wrote:
> +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct napi_struct *napi;
> +	unsigned int napi_id;
> +	int err;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
> +		return -EINVAL;
> +
> +	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
> +
> +	rtnl_lock();
> +
> +	napi = napi_by_id(napi_id);

AFAICS the above causes a RCU splat in the selftests:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/856342/61-busy-poll-test-sh/stderr

because napi_by_id() only checks for the RCU lock.

Could you please have a look?

Thanks!

Paolo


