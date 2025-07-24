Return-Path: <netdev+bounces-209673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C882B10520
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7386189F9C1
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AAD2222B4;
	Thu, 24 Jul 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="J1FjzCAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820A1A08BC
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347520; cv=none; b=T/eGJnfE+QtugX2w7CorSSTL+zyXYhYcAvG0XoY93TT8UKeURJPrZSLFmqfOUVYTEu+8nODMHumBW2P7KAXxtxAUma5liVA2ZlCIHsHmUcHJ6PrmeYpHo33Xg6emLE57c4iWyjqzIemuDay95mJyhY2wsfHKOK6myT4FVV1TIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347520; c=relaxed/simple;
	bh=+ddaZ506rsQ5QjfCDQXYQASw7kEC6a1LNMFiX+1sn08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nH7DNq30T78SEAKRfmqVkx+azbzxR3KonG4zCBLPOaWmgadRAc3tF6BfdjN9nbyKKvGMRY+I+k9XkoirxIxImyu/vlkor13Olqbg0K2VpMitjdxJl1xMTJLs15kZ5j1rAEQTAJG1Up3/dLtVR0f8yANiwRc9bz0Sd8ya05+Zyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=J1FjzCAf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235e1d710d8so8665765ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753347516; x=1753952316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfVb+Ms4FYhiDmNpEDjfweFeN86HYLgE2j4szngwrNQ=;
        b=J1FjzCAfQlg2UEaziwwE4A3/torAt/ef/uwuoxA5piOJ0M8UcCpCxpEHaqq5FlVTvO
         VOIe3Fvri6yFGl2/wMxWD2UnUn6jaySii4Y43BIAWlMB8DATKNHFYQbEoHX2tc8YE/S4
         3c3+BWVmn//NfJYhajlcFltW/aODPAdNoSIK+M3VVhKeR0FJzgDCW8FlSeiwunxvdWjr
         52rqFhTyGUdeTvVtOwdLVuu9iPxmv3Qc5YxR6AwVD/xUhfRCB1jAPtK5Cg88LggTF2Uj
         SbSyT+flCTLT51R8Cv9DfM4gPVaovnbgQofAott0VHqvaX5HnFUrnTaZdX23pjRWcvcX
         RrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753347516; x=1753952316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfVb+Ms4FYhiDmNpEDjfweFeN86HYLgE2j4szngwrNQ=;
        b=b5JHWudUhPJI3DjRugwOKXByCZeMe9XtEdUoz4UdUT7IGn+WqV7v5v/uifCTl0DYSf
         v5fbAUclPUhsArWcjHAFPchb07A5lpYuG32UVxWXU+CqqSbtxz5Y0r3lcDWHUmu3S47d
         bI8xQ5Ox3hiFcKFcqvDAQtU2KQOTVO7plYqQaWAacYWCZbt6ENtSHdv/8E+rbLJtyghs
         L4tlVq5aBW3vkRMdDxE30Xu/HijdWS0Wlv5Qs60yp3X3TxB6XNI7uRorIDMep61WLgAr
         gyHUGMdnNeIfz88zFG6fnpdKxACO0b95xMc/b7+jqhL2r4FaLt/XmBvVEa3D3GaoiGOf
         xozA==
X-Forwarded-Encrypted: i=1; AJvYcCXp9EjJ6MmltM8cm4Ld1ytG+StSamuFWbLSaYZ6mllxJmjssERylP9T9Mbj8BuLWBjvGxHv1Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTO0klf/v2aDFTtuwai3EoW1BpqSiRt2EN5ivDAqrBYvw3T+h
	na5ZoiBHRltrwnq3OdDkfisQfidXvqRh+sAHd1ZOHpUxm9SD1DNQHWcx4RK9M6KXF1o=
X-Gm-Gg: ASbGncv4NUgIf1zufxzCMjgOM8hRP4Nb26jQH+JWVtF0seJlrhN3kk+VJ4a6uPfD3+Z
	7YfaUEIyx7cWckGQzJX7FFHeiAw9rMsbJy6wKyXi0/ZEAWNMKND/Im5zfec3xR7SVPDUKg3J9UB
	iv7U9umcK+JfLuGLxnh2bQP+oEbqHTIF5FbjAz8J4waS/QSpmLAs2zkXFp4hd67Zq2yFROXY1T2
	1fsyLVvaxZZ9LvQj7I1N0SHnQmWjZn3lDS/fCrQbD83Vpr8h7ixJ/0QEBi9Ary1mgh58VqQCUmf
	NFgR72JGtAsH5tjOaL9K0tmhkEZep+SWeBTHNdyyxRduQ4g9RygTzXeW2maONg13enwfXAOQCik
	kEexn9M+OPuj1RewHX1VbF7Wry2YykDdyQEFngnWooSKvI9nYZL0=
X-Google-Smtp-Source: AGHT+IGRiH9D/EXXGWGOdAkohi6tIi7Ge6FzSYB+fuQDQbT5CcCFVxHGEddCv1K/gEwipVAMoqnyGQ==
X-Received: by 2002:a17:903:1b4d:b0:23d:da20:1685 with SMTP id d9443c01a7336-23f9812c34cmr92548675ad.4.1753347515750;
        Thu, 24 Jul 2025 01:58:35 -0700 (PDT)
Received: from [10.74.24.207] ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475fbecsm10834765ad.36.2025.07.24.01.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:58:35 -0700 (PDT)
Message-ID: <4e3e39ea-b4ae-4785-a8ca-346b66e80a9e@bytedance.com>
Date: Thu, 24 Jul 2025 16:58:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: virtio_close() stuck on napi_disable_locked()
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com>
 <20250722145524.7ae61342@kernel.org>
Content-Language: en-US
From: Zigit Zo <zuozhijie@bytedance.com>
In-Reply-To: <20250722145524.7ae61342@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 5:55 AM, Jakub Kicinski wrote:
> On Tue, 22 Jul 2025 13:00:14 +0200 Paolo Abeni wrote:
>> Hi,
>>
>> The NIPA CI is reporting some hung-up in the stats.py test caused by the
>> virtio_net driver stuck at close time.
>>
>> A sample splat is available here:
>>
>> https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/209441/4-stats-py/stderr
>>
>> AFAICS the issue happens only on debug builds.
>>
>> I'm wild guessing to something similar to the the issue addressed by
>> commit 4bc12818b363bd30f0f7348dd9ab077290a637ae, possibly for tx_napi,
>> but I could not spot anything obvious.
>>
>> Could you please have a look?
> 
> It only hits in around 1 in 5 runs. Likely some pre-existing race, but
> it started popping up for us when be5dcaed694e ("virtio-net: fix
> recursived rtnl_lock() during probe()") was merged. It never hit before.
> If we can't find a quick fix I think we should revert be5dcaed694e for
> now, so that it doesn't end up regressing 6.16 final.

Just found that there's a new test script `netpoll_basic.py`. Before 209441,
this test did not exist at all, I randomly picked some test results prior to
its introduction and did not find any hung logs. Is it relevant?

Regards,

