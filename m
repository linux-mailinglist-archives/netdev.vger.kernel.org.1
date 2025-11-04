Return-Path: <netdev+bounces-235466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60633C31125
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E44B64F4C1C
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9272EB841;
	Tue,  4 Nov 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvGnXHbp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D5212542
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260681; cv=none; b=Dl4lRPXGVYmkV9NTK13OVNmYPPG7bHk8Q+OD0i6duw+krgAu5KmmOiexGMAB//Bs1bw/oNFV9OnJEy4DoOrW0BjczRPv/PDg23AnmVzfQJ7PpO7x71YOAcE283gVHkhXLP0FhOlL02esE4eo1Qai5q8v7CiDWz1GqU9R0m/yVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260681; c=relaxed/simple;
	bh=Tm7Z1rbJg1xBtYLywrxZOtnC4oE4srr+4uBIseDYWug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ML9cZT/tQoVu+/gHTC8/TF1bgqU+wugTIfowIm0XBkHlLOu3/uCEzp2XENO/3n1NnAbyLyUbdbMk6hrEVrIewvP5+kWXI4CZuCTavdgdJKL2Hn38wyrIAhNB8673kVlLJDnD7wYDthZ8J3ibThg7MSn9SLONK0yOPjRCr5mxz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvGnXHbp; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8802b66c811so52466596d6.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260679; x=1762865479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eNACkyQqVSo6Hmo5PjkrfufaeZZc3fNY7YlAuWMuRq0=;
        b=dvGnXHbpBabcXnzRnM6SfnJRJdhcUrfu7DWxWACFpfYxqxVPLOHCOV250+gGlVqaCN
         FoxYutoTSt/9t4Wzi/xkydfelXC0MWBN6itwSaSmkMFQJjM0FpT1+GkmH0IPqXW0U8lR
         A0Y9d1t2S0vKXFrMsguWkeFGiEjvg8IHfldf0S6UZvTikVD3jCJl9eQI91vo3RFmLafZ
         JPdDBrAtwVfVMkJrlQkhomY2RSc0gePKqxcdHf1vTUfLUINmXZHnZkgfT+cnJt9b9y5B
         IOmCKKUhgw7V7uJ0ZVz9Fg6iS3w4jR3cOSt2O/Eybs+9pw7oO7VKwOfRjxE7swYYJv6I
         MDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260679; x=1762865479;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNACkyQqVSo6Hmo5PjkrfufaeZZc3fNY7YlAuWMuRq0=;
        b=mbwKDVvx/46HxpWNmenwGVOFoAeWLUsI5z0A7NSumqKZUfWSe3JaJdGTu60pCQT4DS
         NAjOQlKcIZA33NhRPKHf0wx6jxgb27GMZyYosaUswSrBcuL4JFdwxAvFv+nvwcZlg1zV
         4Fo66dwMv9r6Hk/m25XmrBZp8K16ZdxBQANHGD4ud1hchHXDBi7NJtAQinfMoBkgW3Dp
         opGRxoz3XJ+B5AdgSfczKwgkgf/+Xd/2YnjG36sFB3ggvHc0UqQO2nv6s7HdE3A5c4nC
         UMRoUBQC7Bwh5vqEpWL0JIiFrJ57r7+qVhsnFRKfIQkSNPAjEgY1iBeLuIrqaAxTPnKJ
         xeng==
X-Forwarded-Encrypted: i=1; AJvYcCXgsT6KfS41hdMPiTgyEc28ZMhS2C+J8PQib0AGYFLMjy3T8eKkDy/zYoX3f/m3Depkb1LQK1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEyOPDeK5vjMuN1NV9tQzQGYoa5ZmXRaYTzjfttWWtN9XrxBC
	qyyf+WPwXIj80v+bZIOP1psQeTmHwrbfHyLeGSg6rVoxqi9Yefe54Q6K
X-Gm-Gg: ASbGncvILGlE05+yV51/wDxymfJEvED26MU6QBIwXNEZk03ZtoiQZPtgGlgfZnSh3St
	dj6x7B5+jga+c2kkJqgJy9ARX/gpYLLB5qHhb1/Z/lkliU3kiNB7SYC/L0vAoggPy4fcnj1XTe/
	wu7DFWwBCd9qdVKyY+o7/dmHdpsR1ZAGnHSzd1ZzOn3+sY45kQ6MehYXTMRdSsd66o8UVwfGoQ2
	S62vsGkHU42IUs+5xp+Ubcro7gLRIFrt39wJTurfU5rVn9ZebEp5LTRpkhn8JSBm5DYRUdd7P8A
	iPrWa5V9VeWClyfq4BxEMo75+nwRyIAO2THl1oEWzgKRco4FGDcIfOqJdJK0iWj+7cv/xKBGxYl
	tJLGEZlxBHS0QeSq8p9S9oQr5tugoGVtjr+7XiikScnG84kwr4Mlew5634fDUQljGxzHcODgfuH
	3fPn5j3U2bnjM+Mny2imK0TBqs7tEKrYpG8xO8Ubq59MQT4h2r/cj29cY=
X-Google-Smtp-Source: AGHT+IFm58ty03czXFexlH5hj0mLZA/g2M5F1UsdQEG3Wd5VnU77sQjl9srK3J0v7dmYKkp7SqLOlQ==
X-Received: by 2002:a05:6214:262e:b0:880:5edf:d177 with SMTP id 6a1803df08f44-8805edfd5b5mr52809046d6.11.1762260678910;
        Tue, 04 Nov 2025 04:51:18 -0800 (PST)
Received: from ?IPV6:2600:4040:93b8:5f00:52dd:c164:4581:b7eb? ([2600:4040:93b8:5f00:52dd:c164:4581:b7eb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060e906efsm19114706d6.45.2025.11.04.04.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:51:18 -0800 (PST)
Message-ID: <6aa2f011-3ba5-4614-950d-d8f0ec62222b@gmail.com>
Date: Tue, 4 Nov 2025 07:51:16 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Manish Chopra <manishc@marvell.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vladimir Oltean <olteanv@gmail.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
 <20251103194554.3203178-3-daniel.zahka@gmail.com>
 <mhm4hkz52gmqok56iuiukdcz2kaowvppbqrfi3zxuq67p3otit@5fhpgu2axab2>
 <db5c46b4-cc66-48bb-aafb-40d83dd3620c@gmail.com>
Content-Language: en-US
In-Reply-To: <db5c46b4-cc66-48bb-aafb-40d83dd3620c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/4/25 6:38 AM, Daniel Zahka wrote:
>
>
> On 11/4/25 5:14 AM, Jiri Pirko wrote:
>> I did some research. 0/DEVICE_DEFAULT should not be ever reported back
>> from FW. It's purpose is for user to reset to default FW configuration.
>> What's the usecase for that? I think you could just avoid
>> 0/DEVICE_DEFAULT entirely, for both get and set.
>
> I find that 0/DEVICE_DEFAULT is reported back on my device. I have 
> observed this same behavior when using the mstconfig tool for setting 
> the parameter too.

e.g.
$ dmesg | grep -i mlx | grep -i firmware
[   10.165767] mlx5_core 0000:01:00.0: firmware version: 28.46.1006

$ ./mstconfig -d 01:00.0 -b ./mlxconfig_host.db query SWP_L4_CHECKSUM_MODE

Device #1:
----------

Device type:        ConnectX7
Name:               CX71143DMC-CDAE_FB_Ax
Description:        ConnectX-7 Ethernet adapter card; 100 GbE OCP3.0; 
Single-port QSFP; Multi Host; 2 Host; PCIe 4.0 x16; Crypto and Secure Boot
Device:             01:00.0

Configurations:                                          Next Boot
         SWP_L4_CHECKSUM_MODE DEVICE_DEFAULT(0)

