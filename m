Return-Path: <netdev+bounces-83111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BCE890D95
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 23:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6166AB21CC9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 22:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC4A1384B3;
	Thu, 28 Mar 2024 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR3ONRho"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325412DDAC
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664916; cv=none; b=usvDsn0P1pm3fZ+fsW3Wk9f79I1q+ZpU4snPkK6cMShcquYGTp/yXALpUZjZ4D3dcCGyR/2sk9wMpYPLvl/H6Sodo2YALfCQAaWdFSGLZd2GlLa9Dd/1VDI1IvMF+l93xF69nVz1HKFOBJQmw2cwkB/D4YMRsIoHmcoO/pgrRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664916; c=relaxed/simple;
	bh=eEhouD3IOSrRPQ5JUilgmokM1mem5EMCfIufBd4bx0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2+xz0kJs0zM3snL6ReCkeUYBJxT8gvCl9P2ciBjLA2rmYHVV0IFK9C4tdhSztgJ84Xhj4Zqig3WrI9iRX0sCkquVCipLHhefPlvvxKhosFHyWNmqBNikPzFIus1XpTjqm1Ju8CPAwPFrxbc51Qw7zdbgLBQOPss6Oi731Y8Ihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR3ONRho; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ddd1624beso926523f8f.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711664913; x=1712269713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cM5BqpIjNpc3SVp5qd4EaNi1mFFZ1EgjlVdiqB9qVp8=;
        b=nR3ONRhodqeNDIejwhVfh6EHa7QRdBfBVn8M80SKaZD2YuyuVr98LNptIRY7I7sJtr
         uXJso4+bTM31w4kAyktl1lqFi8+MAjuXQY7L6SNyXaRBqlanpg6FLKWzUgrhChe78E1e
         O7kjMuUriWerb2Xp3JTfUS0dYEAObq+dx6cspP5puiVk8M7r9VVdEomiYSfTN8KzEG4r
         FgH8g67JH1ibvZnzAGpWpo7NEQay72VozHe2uJuBVcqWHCH89Bio9H/iv3rczkEink5G
         x29U+oNNfA1UAsUNbF2mdCbFKEzMxNv0b7+HDOQe+BzAnH7jcwnte7W4xr9o8PXzHsDh
         ADXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711664913; x=1712269713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cM5BqpIjNpc3SVp5qd4EaNi1mFFZ1EgjlVdiqB9qVp8=;
        b=fAu+kMV/JCgL/WpWKpe8T+o91nCNQIlr4zZVjcjCLUDRDvzYfzHnoNf0oXDgGjj6t+
         enLvE+aa3USG5EPyd8H+Zp7x+po/zYeL1BZdEs+L0rXjHG5n9roJn4lDPfPC3BuyqjLH
         4b+AQMgbXVvPlvbCodbKi95PWz2yXuaJy8dfv+eAHSTNApLj9TEQryV/F4Vi3WW7nHlv
         HD3RKInerti+D9JsoG27uaLbDhSQkoYW5xrct7017qPd6eVzxBkaHt16vQdOsNcEt/Vy
         JpcHpPhmsH81Ta9XLWOquuIdBguvLxOKY5QiGCvqIsRzvCKGBe8LPXMA5M5umxRUObYN
         2++w==
X-Forwarded-Encrypted: i=1; AJvYcCXhJyrpqA2XIgpNTmSiY60Pp8hclyodMMosxOpVt7HmOslmkHCtXgc4OUUrCa5ryO15mpAfGuwazLxf4sm7FDd1mLwkxk4p
X-Gm-Message-State: AOJu0YztZWsXxQXBNt5BVlNHtas7IqI+H5sPD9lu7J9V/M0N0yRubshu
	DwL2QoxaZrzf2wUVUiHEoWU1cwBtznpfo5kRnyznfN9b1XtxGRMj9qHF58Hu
X-Google-Smtp-Source: AGHT+IHOpigh5LGMyOv0K98WmGq6fT6xBqlMtmZctRRgsKrmDhyGyvfbxc96GhYdszOWUAU5RtvyMw==
X-Received: by 2002:a5d:5408:0:b0:33e:c0f0:c159 with SMTP id g8-20020a5d5408000000b0033ec0f0c159mr3070515wrv.10.1711664913331;
        Thu, 28 Mar 2024 15:28:33 -0700 (PDT)
Received: from [172.27.34.173] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c502300b004149744dc49sm3604786wmr.22.2024.03.28.15.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 15:28:33 -0700 (PDT)
Message-ID: <a7f042f9-7e74-457b-876a-6a7427a55847@gmail.com>
Date: Fri, 29 Mar 2024 00:28:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] mlx5e misc patches
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240328092501.3a2e5531@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240328092501.3a2e5531@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/03/2024 18:25, Jakub Kicinski wrote:
> On Wed, 27 Mar 2024 00:20:14 +0200 Tariq Toukan wrote:
>> This patchset includes small features and misc code enhancements for the
>> mlx5e driver.
>>
>> Patches 1-4 by Gal improves the mlx5e ethtool stats implementation, for
>> example by using standard helpers ethtool_sprintf/puts.
>>
>> Patch 5 by Carolina adds exposure of RX packet drop counters of VFs/SFs
>> on their representor.
>>
>> Patch 6 by me adds a reset option for the FW command interface debugfs
>> stats entries. This allows explicit FW command interface stats reset
>> between different runs of a test case.
>>
>> Patches 7 and 8 are simple cleanups.
> 
> This is purely mlx5 changes, since you're not listed as the maintainer
> it'd be good to add an note to the cover letter explaining your
> expectations. 

This is targeted for net-next. I should add myself in the proper mlx5 
maintainers section. We'll submit a patch for that.

> Otherwise you may have just typo'ed the subject and
> have actually meant it for mlx5-next.
> 


