Return-Path: <netdev+bounces-182929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0BFA8A5D9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CAD44352A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A591B0F23;
	Tue, 15 Apr 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpUskMtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453620DF4;
	Tue, 15 Apr 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738912; cv=none; b=WPfAW1S/wEGrpwWKXcCz0mMtHp7QzWkg158YuqxngYNuEOKYWFiLWAa0GTt9316s4GCoa0nfTCrs45QNWFwnoH4RPbd4dA4AzKnam3n9jHZyDSwogplj9yZNvJ7BQ9QIOCwYVUKXYTRkj8SVLRsKHH9bOl41wXG8p3DN0OAc9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738912; c=relaxed/simple;
	bh=E/7aSL8EdbrgFdboJr2mns2xWXbQJ+JQ1Kb4Fy6iD5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICNowYdpVUgwmTrIU8thrgfq23MEahpMQyDHO1klDxK5Dr+6BNYQHN4FuyhCtx9vo4OFnFn3NQacOAHlfrGp6qEviycBqTHFDdLuSkeSfffqOhF0P6zoY0pL35cWUd0bb2H2sJei7/M0mDW9rfGI8M7v37ySPmEsZWEC378+Nq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpUskMtm; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e904f53151so50468036d6.3;
        Tue, 15 Apr 2025 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744738910; x=1745343710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIbn2H/8wYXEOsjPRSdbZMnXsRSQ7mt9zFcJert8sIc=;
        b=fpUskMtmfSc2geT6QeTClaBP2UDyElOV++9BAhTC5v/LhoHQaMXFx/4MHz+hWt02Js
         aQ9tp7cJqLCqW/AIN4I48Y4tFrL2j2deMSYnAB7yWt8DHLOL5kk11BEj0iL5fLX5fag4
         27yIi5yZeHM4RpJnPUKYX+nVos/GA7sqbZeL2mjA3XIqs+wf05igwHagwHCiPAEpH/Q+
         WKbIevZiKrnInSou+Y1hxPZqzE4c4NQp1grkKyb2YkAcX5Ew+4swxbfBvt77bq8QrMOh
         bBcqCIZU3s3fPgVIDD+sHBZQDKMR1K/aaIzAHXjW72U30suqHFkh3rWepY3kgS8nHoEc
         Wo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744738910; x=1745343710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIbn2H/8wYXEOsjPRSdbZMnXsRSQ7mt9zFcJert8sIc=;
        b=OrQQQr37h3pgNXTzlS535mtECI7OX1iqaLOl/9HfcNys2m4n8PuLSm17zJ/NRay7u5
         9gkHaTHanRl4gvvxQTofTlKNUfeVFFqh4IMjb6tmMOyimSUEMRbGdEqBHqe0zwG+Jgei
         qYpieAIW42d43faBG+Tz9lT8sM+0EljHyqNP/Dxu4L3j5ksWMu8Xp7nGUtrdOdQkuw2s
         3a3/GQImAc9OcKR8Evi0JmSqBDMA7ouXIyYdO5hoXmHYLn1EMEaEwja/JSQ6mbw8nnLW
         /5feJbeEJf0FcIOeG3+Eq0DNjy4kveuo3MmFp4NI30PPO/9y2glcOcMsc85jbX4CSsZ1
         f+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi29sFtD/Zr1mU0hdF6qYkF8SOL2gA/C9JhM1E2edbpDl8MW+xTtpYGYS9g8KGwSWvFIW4Mf9gtd7KiTE=@vger.kernel.org, AJvYcCXjbiJJvs36nIT/C3RE/Wkxw1M6gSOFHaoA+B1bjtb1DWukWX3c3OKEogL3C54mN1CHgRKibw0s@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIIHHqdXG96pObTMmghHQweIQBNUCXdFzroYLqNtKci5Y/dDM
	jBqmsRil55nGcr1iDUtqKV2YnW4Sq7rA8VnmXsLVGW9xnIkwcoU=
X-Gm-Gg: ASbGncsuIApPPh8g6iyej0v6kSWoPDIzpTfAWBN0CjS5jX3Pxt3XcCPpTbevAlE4QZc
	jSNkyxMaEkKNInKgRc0yzslJlU3CT5pGr8FHM/0dizDciBvbKMiapjO0Wwi/I7rJp+6V57tM/ls
	UArFLnOhcvjZy0vUF32gbATdqOBZNY/fhfRcTidCjKRwNqsla3XeY/S9vIoPdiFPcYUHHHUlIz4
	gNcjhFA3uPe0dfHPp05iY6lf5pf3TIRY4QOBSFrA4Ok9phEhwHNK8lW4KZDCNnQhUFGKJdXRqMW
	EWdijuqpQBHDiLScwsIeJb5aojMpfuIP4h8dlb80cqxE+aD4NNJ4G9+gvFJyw244Un5PH3VDAth
	/SCtN1K81BwMQVIqO
X-Google-Smtp-Source: AGHT+IGOklpMYZqBoeR8Oc//exf3CssPvnMzNTGC0x09dxZsvQjngf0zg5icFhmnVNVVRUYJVRbjZA==
X-Received: by 2002:a05:6214:21c4:b0:6eb:28e4:8516 with SMTP id 6a1803df08f44-6f2ad96c387mr6476146d6.33.1744738910188;
        Tue, 15 Apr 2025 10:41:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:c5e9:5591:e693:357f? ([2620:10d:c090:500::7:68bb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea1064esm103605906d6.99.2025.04.15.10.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 10:41:49 -0700 (PDT)
Message-ID: <90466128-1e82-4572-8e24-67af36d85f20@gmail.com>
Date: Tue, 15 Apr 2025 10:41:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: ncsi: Fix GCPS 64-bit member variables
To: Paul Fertser <fercerpav@gmail.com>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, npeacock@meta.com,
 akozlov@meta.com, hkalavakunta@meta.com
References: <20250410172247.1932-1-kalavakunta.hari.prasad@gmail.com>
 <Z/j7kdhvMTIt2jgt@home.paul.comp>
Content-Language: en-US
From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
In-Reply-To: <Z/j7kdhvMTIt2jgt@home.paul.comp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/2025 4:22 AM, Paul Fertser wrote:

> Thank you for working on this. I'll be looking forward to your next
> patch where response validation is added.
> 
> BTW, have you already discussed how exactly you plan to expose the
> statistics to the userspace, is that something that should end up
> visible via e.g. `ethtool -S eth0 --groups nc-si` ?
Hello Paul, Thank you for taking the time to review and provide 
feedback. I will thoroughly investigate the response validation gaps and 
address them as soon as possible. Regarding your suggestion, I agree 
that making statistics visible to userspace via ethtool is a good idea.

