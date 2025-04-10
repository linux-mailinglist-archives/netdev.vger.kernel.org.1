Return-Path: <netdev+bounces-181005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED7A8362F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE643AAC35
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297CD1ADC6D;
	Thu, 10 Apr 2025 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="csFjFbR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6A46B5
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744250777; cv=none; b=cMiGO2Yz1BuLkH+iH6mnXBAZ27/OvEXBTO4IXoYZJPxzo/gFIo0F8Rin/tRJ2ySq2R87Y429LQN/HneYoiRyEdnuaN0+Egx6BD5OcPfCg9cGTO2AoMB8FgUNYP7Fvm+7TYNsNEu9qqbmLr0/teMnqU/AychCiPBTpaI4nBMPagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744250777; c=relaxed/simple;
	bh=00CWvMubTXn8KiaGY9JQiBESkYIbnobhC2OpT6I0kQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0EM8B0ZCAF1gfiuBjgfSFIbBVXH+MuwIdnbSTaFdw1qu72UpYBVpEAMxPJSz+GHhsUjIAjrTRMZsxXEESJfoTDstU1dAtpMQwwX1tnXtBcfY/DTzuOo/S6Q0tDszPgevfx7/nixSgDOfXNvmfWDTemHEOGEvfL5J6pKpluYvIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=csFjFbR6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736b0c68092so202082b3a.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 19:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1744250774; x=1744855574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLfzADnFJZfpkNlgb/x4vFLv1q7ddCAmApIeXYB9u6c=;
        b=csFjFbR6j4sHjK2cNY6GjXXoXlcIdkbijJtYi9+B2VcpPY/7VtOFWUqCkPxZATo0u7
         XWt6lMkfdC+Ld/LPfQyQ2v2aUX4NF9KelxNmfY3XgZht+ZcpqhVi+ezdlHFdMMz8LWk5
         cRUu+DObnI8BVarvF1639pjr+gvuVW66tCJuTsjfHAIeFrynRE3qUE5j3dN2fiIWF4AF
         EH72dTO/y5i26pq/zpqdVAav2t9QQ5kl+sondZVnsIJb4BdcCRD1h4DaXpMoF8ww4XiS
         hX0VvfUGuBuyRuJrPPacdDz0+PxBcrYB7iYNP6ZxnACKSJg1svUofghMSq0ai7nAipSG
         jqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744250774; x=1744855574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLfzADnFJZfpkNlgb/x4vFLv1q7ddCAmApIeXYB9u6c=;
        b=dSHvrYrwSZUENvdeqY9ulnmeY03ki5Awffsb9y+SrS5nKT7XfBGCkvwf+VTxi9Eyy+
         viUL1Y9BTbcygCaJLYe5/G526mX1GUU8dwrD94S/sPVhm+0jNUpyCDTj7+eGVsLsT0xj
         +1rD1jpO+Jz/SMQQcI1uY2UxHpX6ik+sSaIOQ0pB1fh5rjXv4zJf1tiADPKW4ye51zRY
         /OXUacPsckNgmRd+15ea+Q8tZCFo9ZvlP6VnYAniPupL1Se4V4nvnrCa+Tru6L4NsU5v
         ILvafQH78ouyz7f8E6tR/So8JHlx/VINoPJURZrZbg7d6FLPMDrOWD/jPc/u7ujOMD4m
         LSxA==
X-Gm-Message-State: AOJu0YzXty1eD4FJ5sGp3TOKSfd56AUPZcYhn2gqxfJwIqWzeFauJ7zp
	PWzThin/1aJy5jZht727WJewNajzJRWw8ZlpFwo/Qb48GPbTyVXwnvsXdh7uyIo=
X-Gm-Gg: ASbGnctGtaO9/oFiDZVutsZ0A3L+pogclKcyuAx1dSCaPB7RqMl7TRWGglSqXnhsIQ3
	vvS845QCLELo4Cv4+TGoU6lwkUhkBCSDTd0Uvs/IEi+iETBHwlRhjIfU+EuVteEzXu3sSRSE3lT
	mAdlFA9iIFMDeS4WaLKhkCt0+YhT2CrjzzYlDqJWo0V9b9UPKmR+RyF7iQWMdF2IdVTAHTj/XmI
	fx0wyRCGo598otTDg6eoWoSpEj9D4PIg7Yq4e2RdEr/G4/XDx1VQLpVv/ECv68OrK6jAyzsd0kV
	ym/5ZfRP5IUhObw0lYpoZKrb8Slu2Cg9hxw0T0a3RMztDGh+SR5gZEXPyA==
X-Google-Smtp-Source: AGHT+IFcsqF2COoB0ZwKxM1t1iUUhTzcjUC1SauyOA0wnqzk2CF8OJWkpbLX3fklPdOTSQtdrL7y8w==
X-Received: by 2002:a05:6a21:318c:b0:1f5:6e00:14da with SMTP id adf61e73a8af0-201695fb4a7mr2370000637.40.1744250774693;
        Wed, 09 Apr 2025 19:06:14 -0700 (PDT)
Received: from [192.168.1.12] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a322114fsm1935978a12.73.2025.04.09.19.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 19:06:14 -0700 (PDT)
Message-ID: <54a8a9fa-9717-435e-9253-40f3a0a7f779@davidwei.uk>
Date: Wed, 9 Apr 2025 19:06:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] io_uring/zcrx: enable tcp-data-split in selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
References: <20250409163153.2747918-1-dw@davidwei.uk>
 <20250409170622.5085484a@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250409170622.5085484a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-04-09 17:06, Jakub Kicinski wrote:
> On Wed,  9 Apr 2025 09:31:53 -0700 David Wei wrote:
>> For bnxt when the agg ring is used then tcp-data-split is automatically
>> reported to be enabled, but __net_mp_open_rxq() requires tcp-data-split
>> to be explicitly enabled by the user.
> 
>> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>> index 9f271ab6ec04..6a0378e06cab 100755
>> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>> @@ -35,6 +35,7 @@ def test_zcrx(cfg) -> None:
>>      rx_ring = _get_rx_ring_entries(cfg)
>>  
>>      try:
>> +        ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
> 
> You should really use defer() to register the "undo" actions
> individually. Something like:
> 
>          ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
>          defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
>          ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
>          defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
>          ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
>          defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
>          ...
> 
> This patch is fine. But could you follow up and convert the test fully?

I'll send a follow up, one to switch to defer(), then another to call
tcp-data-split on.

