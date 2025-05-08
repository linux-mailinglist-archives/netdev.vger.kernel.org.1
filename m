Return-Path: <netdev+bounces-189008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50786AAFD7D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD5B3B360E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236B2741A9;
	Thu,  8 May 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghh4sxHT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE004274655
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715304; cv=none; b=HrKc0w1ME+Aj3L9Nj8tqoLypEj+9yaq58aqP+p7Rv0L13/mtclTCw4GflNl3zkASMXxTmeGbpxhqxZDK3OZXrKbYhIdAPVyA8UI7O4X9DPjKruVGpT9f9Z3Km1Qn8M1Y2Hbrc0UH0ujJRQx67XvxGyv7F5T0toJbHlS+JR/m/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715304; c=relaxed/simple;
	bh=DmrzkMHCCvrxtZl28d5ICjRzaKDVejqz4EAXI/pJqyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gytd243tZH9xAeG+rkdeUeXxG/idOXnUf+Kp55ZF5PCTYH/ccxkzu+3aTq7qn6QF36c1xffBFGcoFj4rp17uMo/ZHw5FLZBtZRISCW587shmA86c1K7f9QV0nTyt5jv+Et28Bu92i8SzaTucyP1xgrp/2PDRy8hlRSkoo6YyrUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghh4sxHT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0ac853894so908857f8f.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746715301; x=1747320101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fg0L2KD6Ubyu41xDGdXj8Ajw8kfK3GPQaLAMnfHpNaM=;
        b=Ghh4sxHTZL27eLIfKk3P0iP3oT5pfH3/g3R+4UQT+rq/rGOUqO8tRTvL67zZ5vfw1D
         Kl0I2Wg+qlJ9g26ogIlkCCurlhGVKIj3CJQvysXEXumNG4VunkTDOggZ/K8TtLqg3itD
         L2xFFbh7rlobPEXwFQUS1b6C9VP4dYTyaNje4x5bsfHJhDbp8Q9pl/8lwn3CuREyHof1
         hG8lxq73MjXhEoTwlw9qaELzkQiyjwYWPYrVttsgyjV1kzpdjq1eklMXwa1uJkzmshBj
         NCkhce7cZzFLMk1DplRtHSs2Cx66tKUCNDZ0YdjjYb8O+kdEw50LMWNGSgKM6k61qxj/
         INWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746715301; x=1747320101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg0L2KD6Ubyu41xDGdXj8Ajw8kfK3GPQaLAMnfHpNaM=;
        b=mq/z+sQv39wDxJ0jceF938vB4l6ssjsD5T2yfmygKBCx0HjUDBhl2qO6cVRfyJjZ2B
         i4tgOW9XAJv3Tb5fau9lz3p7e5xf9ZRs5sywGm5nnOjZoKx6vi33796/97sL0+Ag7oFE
         OMxtpz4rHtBUC8kaOzLDZT2nPrAl3caXimqZczMsegf3kc8SI30s3Wl6fGWfpgVTpRu1
         0HRj/fUfHAXWJ5iNqXDd4eYgsFZYmr4CytwZKFF4swF9nhA7eG1qseg2jYtnEGWVCLd4
         1Xv86dmba/bXzHgA/PV2eShbF1o/SJhZV+uJZ7LOxEzV1mIiYl1XfJQsrSiSdLPsT9el
         guAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3RPoANWF9F6yrj3b3fAdJh3ZBNACLXz9AbEJNxAyo7o0q+U8CcVbImXDyWRskB0m/Xrdn5ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwlDZcrT/esi1sc+kSE9W2c/4E21oz+FUZNe3nd2XXZvuTPyC
	bgF5qBKL7spXym0LfNJin0jDJKMjHowZTgjIr4JHpXmdTrwPccuS
X-Gm-Gg: ASbGnctrbnRGU76ba4ffY5NGWX0I6tjK3sx2/dulgxL0bD93zEkYdcjhUf3LXzZSOUY
	pKUuhu85/aG+DmXF35kgX4lCQmUYhmC3Kwcjb0HD/awhpmjqDSp+JbWXS4/cxj44uZk1umCHIGm
	hQyC6H+MKCn89eRq25mvvwePNOiICed3LU9dZ1DoZm8SvaO2XDcobRMa7Lk/bDyfUZEIRlQgZu4
	GGDpMgJihUabvKkTMFllzkiNxK3SSJ1YufpfBXIGf9Rg6T2m8GpwQzRNbJJFvUxgwrpIDLMmnz4
	XZFGTza4Tn+F4U+HoNv++roVgVagkGFqzdufkumsCCB/klDY77HrW4I8oDyzA4PGa9niofcPUP0
	qk5BQbkC8MVxgl6f0fEyGVMbGqhdh
X-Google-Smtp-Source: AGHT+IEvoSYZ0f/na4y0BBpuq32Uw6iu1aDm5R87xaBNO03fwUCFVXDlZrDJ1lWpdoZVLZ9arjc4fQ==
X-Received: by 2002:a05:6000:2a1:b0:3a0:9f24:7762 with SMTP id ffacd0b85a97d-3a0ba0a9d4dmr3029090f8f.15.1746715300688;
        Thu, 08 May 2025 07:41:40 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc39sm140259f8f.100.2025.05.08.07.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:41:40 -0700 (PDT)
Message-ID: <a0a458de-44b4-4f08-b6d4-4775212c1cf0@gmail.com>
Date: Thu, 8 May 2025 15:41:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250508103034.885536-1-gal@nvidia.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250508103034.885536-1-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2025 11:30, Gal Pressman wrote:
> The conversion of uapi #defines to enum is not ideal, but as Jakub
> mentioned [1], we have precedent for that.
> 
> [1] https://lore.kernel.org/netdev/20250324073509.6571ade3@kernel.org/

Isn't the traditional solution to this kind of issue to do
#define FOO FOO
after each enumeration constant definition?
Any reason that can't be done here?
-ed

