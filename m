Return-Path: <netdev+bounces-184132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A470A936A4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A17AB9E0
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC82741DC;
	Fri, 18 Apr 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sVAibe0l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F28270EAE
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744976658; cv=none; b=VLGcGTRDTQQ5phZyrV6PnhReOef0951HhMxsm8r7u+ZcK054/fbcnrfli+lTh/Zz9dbs+n/6NA/C4YrGpSRntPY/83YMtXffc7e94tLXr5qBIQv+NnhWlRp11weSRBukFnd8c985eMSVFdJ5c0W0Fm30NcRz+ImGiHGgVcQon9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744976658; c=relaxed/simple;
	bh=/S8Tszduxr/rfzX1nsbkv+2Ge9p7ezXjGfhSoL1IcMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5/+GP0s1jgYG/bjBkQMRKQ1PywVSuTDYxMhY3KlB9V6VFRaEVmPI9Bp7+C4bRiohcEG3ZV3dQY6XWcgMPsX6P6wrtSo3yB+iHcYGKK1hT7BZPOt53EkLRrZO8mmVnOQ8PLEJH92WWkvpDyxans4mlzQI6CLnYvWdjDouHhBPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=sVAibe0l; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bb647eb23so1526299b3a.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744976656; x=1745581456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mW6h7dOASK/1qrcNuwQb88KVmv2J52zJrM076k3r8g4=;
        b=sVAibe0l8kwL63yzfaYV06vvJb/WCoC4hIlGS+Rd3op1BqG0Wy4e36kD282NnJek+r
         s8NXwUuN/OmxO5pxiG6A1SifwS9C9Y/8jS/4eNee32yuIJd/Ra0x8h8m2N94V1AGwJ/f
         WfrapF/ZHmX7/n9FOAHDrSK4G5v1sWmVz5rWNJJQtsmP4misIp/8SO2YbfY8jW94KHoA
         Z75R+F8ohkePgDC92BWiHV4rd9MGKhIeYX/p1hGz1R/1nPFLzIzTZ4Su0G/HwvtsqSTf
         btmCeebX6v0taEoR6pzkpI3eHYRLpCDPkadAw+wxY5UmyPLY92KmUTHKvqtzfIqtnXlM
         L4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744976656; x=1745581456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW6h7dOASK/1qrcNuwQb88KVmv2J52zJrM076k3r8g4=;
        b=XmbBuF2g07cjMY4PQSnyc/+o9AHJVZXTvB+PmeysHux5ywMyrhPPVtd4RQTnU6Ovtt
         NQSRcA77tSZm009hb9QigfQ26q/l1h0Jyw3BefV+t/r+gVBjtzb1kiIqZQ/YDnATL+kr
         4/0iz2eJ/Hul8aDYqT7RA2bEppWwbznS2kKL1vZtSBqoTagas9lloPIwm13AhcbTJW5Z
         jVaY0izhFaBnZJjrROUBYarruLf5bQKCTV4z9EGTVEj46oNJK/obmZqkXxRe+wNPqE1f
         /lfJ1Xbrgtcg81RYZRgCii5sQO822HMXFmjxc9JaPqPHhf+ZYolT0qbrevSlbU8VtRXu
         8Z8w==
X-Forwarded-Encrypted: i=1; AJvYcCUh2QrYG2wdGCCW/JVYe/+wFCS3b5ABgGQq9a1ZZin4Hz0WJmssBxoz6NBu2hTy6vzRqyg1KFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKgDCEZGM65cZZsjV3HuqfZdIhql3DozaU+c6UaXt923Yd7Kr
	oCgGS0bio5kEe/zAo16tdochjyIUbDLa8LjpX94XJnzWXoiW4zKE/Lc+3U+kmhGz02LH2t0sSB4
	=
X-Gm-Gg: ASbGncvtsKHyMnMt2LYmY09K1vMAtnSPiOX++KNZoEqtkpUpNg9TAGWlhZsVHyWVpcR
	uCovel6xrPrNTyikBb2ZYaFGXyKLbyKy0X/iBFDQeUKW79kBdEecRlo9BgH0iToR7v432KsqgMn
	vgFFw+PdRDv5c7Nmj4qh3n28eX3uDCNpgcGMOAgwMzGLZ+2vEkFLRrk2SE/Dub32x2nij6BH3Zc
	lxO+nOHp/0QkNqUoipbTUQWsNRrX3R2hS/2QYONMQHqBdt6z+cKcCA/GDN08yhJQUEbBZuETFlE
	S6vLZ64y+B837D5Fnm3TRwBgcCCwme99aw6V/c8eSjMlOTmFA9H4e4BYOgwGEivu7Z8SNFjthy0
	7MmRA8INJBHo=
X-Google-Smtp-Source: AGHT+IGIX14bOe8lBhfStA9gEl8T8ZRPaoRPLrVwQSIgBvbp7bGPWEm2RMQ9fdU/YadzbBdBZrNEJg==
X-Received: by 2002:a05:6a20:c6c9:b0:1f5:591b:4f7a with SMTP id adf61e73a8af0-203cbd4feedmr4322097637.38.1744976656448;
        Fri, 18 Apr 2025 04:44:16 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:dc7b:da12:1e53:d800:3508? ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db157be12sm1198079a12.64.2025.04.18.04.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 04:44:16 -0700 (PDT)
Message-ID: <dbd22817-305a-4e7d-b8df-1343f5284501@mojatatu.com>
Date: Fri, 18 Apr 2025 08:44:12 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 3/3] selftests/tc-testing: Add test for HFSC queue
 emptying during peek operation
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, gerrard.tai@starlabs.sg
References: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
 <20250417184732.943057-4-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250417184732.943057-4-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/25 15:47, Cong Wang wrote:
> Add a selftest to exercise the condition where qdisc implementations
> like netem or codel might empty the queue during a peek operation.
> This tests the defensive code path in HFSC that checks the queue length
> again after peeking to handle this case.
> 
> Based on the reproducer from Gerrard, improved by Jamal.
> 
> Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
> Cc: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Tested-by: Victor Nogueira <victor@mojatatu.com>

