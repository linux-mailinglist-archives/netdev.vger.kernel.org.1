Return-Path: <netdev+bounces-107733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BDE91C318
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61011283812
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A17158DDC;
	Fri, 28 Jun 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVCmwXzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1801DDD1;
	Fri, 28 Jun 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590595; cv=none; b=kWhXEq4xXJPtoDqq5m40D/zCBZAUO+H29RT0hUfziVnSBbeodaUBBYvKcOICyB4QcxPnRww6yBKAfGPg8FYxuSWobnjMF+EGfc1RvtCpefaFFSbafCvlGS9G0oCUgjk98IeVX16mSp5usZx0p3kjDlmHG/P2P4dBu6BHyif+JVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590595; c=relaxed/simple;
	bh=kUvXqnBvHtOKOVoyrAry8R2W3fNVDZiaIqfy/T8T2dU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cwkRdDq46xE6CYWDDplVF8G8OXdmoGLxDFAsCRk5fZ4t2fMgpVwfozU3BNaSXhE7H8x76VjfhhDJoEVT3i8G+S9cCX4HieGyMtF9hQ4n9uZB5rKl+Qo3s/K+vYOq18Ohti7JYiW/QNQD3RD+QB52bfwvu17W9L9GXI+hzUBc7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVCmwXzF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424f2b73629so7775685e9.2;
        Fri, 28 Jun 2024 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719590592; x=1720195392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zbVPE5l8sPpmwo7i3sdwml8CIrNZKhRJoQm31HxkN0=;
        b=nVCmwXzFGwR4q9ouV+sJ3SamEoLFBFZa4c6MkerS6/xiqqfkK4qStrakFDS4Pd/Omm
         yggUi00detkPTErvqFvngbY8kEiSHX2aOnxlIdyQnM+l9RVVSv/KWCAdEGpZhK0gLFqo
         WZUSURtfYhx8o362jtgvqYToSTaCTJPy6qfeNciICJfZDHsHvRhGRD9mjkNHpe4OpRN8
         Gyi4JLzkhMH9LI0aI0aUT11mrgshxHiBc5cJdQZUzhH2du2oQmTfcTQUTseR/NDyUSGa
         CVSzN6a1WlGnv6YfpdxmHnQf485u3kvun0xolpZG2VZaZ9q2/x+5airrJzQN8ZlN7vvl
         YeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719590592; x=1720195392;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zbVPE5l8sPpmwo7i3sdwml8CIrNZKhRJoQm31HxkN0=;
        b=IXvdAxS4mlD9T2W+3nlEBfmxk+JnSrv0Cn+yhB6HNM2UfG+coGvzIHzcHhX39Nr2Z4
         iIXjb4pWZMiBymBOt603Rsst1aCmO3xP7ieb52fA5lkTwCIB3gnmDtuPUsxAOUVG3u3E
         tlP4djaQA1PPI7sTs53UQmzM7zQzf/FUAPiRPVQ5uAz6Hi0qyyEJmODbluF+BpVvgltH
         GJTAH01zM+MQB5Ay7Z72cbsBtErOJtlAHhT247rW74Rkl+r7TIl9097tj7NpbS0gDycB
         peZYvAl4E+ZKdyjMrEcz2E1Z2/RUb5UIkfYeEBxjG9hYD6uOHFquvt/Mz8Lr8CIyRM57
         PIFw==
X-Forwarded-Encrypted: i=1; AJvYcCVlKw3Snl5TfI7sUzG5g2zMFZrmAuHJKahFfHB2Aq7D/Ml8UiU5unhJygROOfHxy96qGtu+gPEympDCVYlwsv8FU5mSjVeToWp1NCvTpf+L+GsRj1nv44RRVi2deuVs6JyfKSfc
X-Gm-Message-State: AOJu0YzXI2I77lBqXm/YigQFQw7iid4nUfMKJAk/XSMilGOrskWB32ca
	F8BZwazq10jzu4M/8ZQXwTaZD0xKMDqBX00JXykcbJPQUiYgsLS7qDHegGx+
X-Google-Smtp-Source: AGHT+IElJ4ATJkyD0CGR+JjcC38BM3SAFZkxgvWcawFFLGQxuVVYAT5YI8FA3TVJ27luv+Fm5j/omg==
X-Received: by 2002:a05:600c:484f:b0:424:ac79:5504 with SMTP id 5b1f17b1804b1-424ac7955demr83728935e9.17.1719590591673;
        Fri, 28 Jun 2024 09:03:11 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3cf85sm41015105e9.4.2024.06.28.09.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 09:03:11 -0700 (PDT)
Subject: Re: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31)
 to bitfields
To: Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew@lunn.ch>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
 <20240625114432.1398320-2-aleksander.lobakin@intel.com>
 <20240626075117.6a250653@kernel.org>
 <e0b66a74-b32b-4e77-a7f7-8fd9c28cb88b@intel.com>
 <20240627125541.3de68e1f@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c561738f-e28f-9231-af04-10937fac61da@gmail.com>
Date: Fri, 28 Jun 2024 17:03:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627125541.3de68e1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 27/06/2024 20:55, Jakub Kicinski wrote:
> On Thu, 27 Jun 2024 11:50:40 +0200 Alexander Lobakin wrote:
>>> I don't think we should group them indiscriminately. Better to add the
>>> asserts flag by flag. Neither of the flags you're breaking out in this
>>> patch are used on the fast path.
>>>
>>> Or is the problem that CACHELINE_ASSERT_GROUP_MEMBER doesn't work on
>>> bitfields?  
>>
>> It generates sizeof(bitfield) which the compilers don't like and don't
>> want to compile ._.
> 
> Mm. Okay, I have no better ideas then.
> 
> Do consider moving the cold flags next to wol_enabled, tho?

My RSS series moves wol_enabled out to struct ethtool_netdev_state [1] so
 this may not be worthwhile?

-ed

[1]: https://lore.kernel.org/netdev/293a562278371de7534ed1eb17531838ca090633.1719502239.git.ecree.xilinx@gmail.com/

