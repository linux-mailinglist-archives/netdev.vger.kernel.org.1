Return-Path: <netdev+bounces-103752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08975909556
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 03:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A26EB22D04
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 01:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078A71396;
	Sat, 15 Jun 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/utxQU5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA61FB4;
	Sat, 15 Jun 2024 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718415941; cv=none; b=Y2ppQypT4H5IMw9FsxIvRKysUSA898uj2bOFlORSZG+2GsyONttz0AGv4ZN2yukmM+8iUzkzvLWUxe3Ms/xsJ4z2/r7KRJdXFDuqBgH1SdLbXdFt4rvpY5qmiWLIHmv7QnqJ+T+Zh4X26fed31LwY4SLISkWtOw3Atyw6lf+LLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718415941; c=relaxed/simple;
	bh=UXvOutsOs5dGALzZAcEV8aOGIokDUmCprHYddo97Jps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMdhV689dxBWbZFjsU98dw6qnWm+b5GYkUZ9t74NxX2ywLnPvf/s1Dto+hsOpuVScZQPrkZu9AGiAY/rPhUPOSVCCFynhsJ4TySn2QHahUXXdqpfvZW5ojYr3TdFXUd48061tglcvP+fy/6EhssDOU+VDUemucaD+9vdN39uYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/utxQU5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f225ac23bso2703247f8f.0;
        Fri, 14 Jun 2024 18:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718415938; x=1719020738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/CwDK7R6fOWeBV3TrdST66AhZneTiael/jWeUtcx5Y=;
        b=F/utxQU55d52p0OaxCo20qJvABHUryzk6CF3y9VnHWqb2oYM2yKfI5M638/mKeScV7
         /BRrn0eglkqfOIwxJopEjsrUTJwUx0ap5/lePvpoQPOI18le8G4s0hwcbj4tGlKVj5cF
         5PZu27NT0rU3pCKRdQw2C01sX3uqDBNF617mWj9ON/Wbfg5YAoVhgM1eOf6Yge879TpU
         96GlyTPOaxnb6OT90cJtRJECwpPuKwYHXw0Smnbl6YJBED8RWGs11NpKm1X1cz2rcz4N
         nWjluyMpebQtLCSzht5amN1ft0NBoT7iEM/wB1YDiwk108CsaA/NqibzBAQcD4ei9ATD
         cbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718415938; x=1719020738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/CwDK7R6fOWeBV3TrdST66AhZneTiael/jWeUtcx5Y=;
        b=Whs+27yugeKgasPK0MQKKxbV36K5UFcOSYNVcZRCToCcQX8G82eYtGcR2kDcPbwIN1
         kMp6iGklwjDs7fq6UinXrAaDsyW2NyWdUrUDBg0398/2YXBNSS19drmPbrcL7hJV0lfc
         rGoNdkZgwwjGrO3xxzWyq8sZjhmW4OjC48Ef+d8T5mkqDodXZ2c4yxhSS1mMRIJxrgjN
         8nBqt9kyCH7b880xoUnrLl5Ar3a0HtYDBqGnLo1C2eRD6w7WAi7HNhDlDOcCoAbTHMeT
         O+PbYd7+fmFS09yRaVptNV7t8Yg2yeML0P3meCcBdJ7xQgm9ARCiFmZGP5kzzF9qyuho
         QL8w==
X-Forwarded-Encrypted: i=1; AJvYcCVOguoccb0GtTY7TRKfkpK6DUaatVJbO3srf65KQ7iSEKAbok4DhBOsCnz5L4dBiPR17wa3U3cKKy5mgoDdAblGqZpfUZecbAZeE2VITmVMXliOepU8SwBBBCrsQXJtPFIEaakX
X-Gm-Message-State: AOJu0YykEaqhODCtZfUCOtntpD9VYUtw94jiYlOkmuPfNVp9ItNR7+Ef
	TjMxDMZga+Lmtd7RyeehH+lA3/ihm9gCZYoWxUp4Lcq1EE4rHyoR
X-Google-Smtp-Source: AGHT+IEC96cSq0PKKjOhRhprtrElloLoEwM6oq12HAwzG/fn44YC9r6A9tIdRQxFxBlZ8rX/vpCJSg==
X-Received: by 2002:adf:ead1:0:b0:35f:1bd5:1d72 with SMTP id ffacd0b85a97d-3607a7889e5mr3994319f8f.67.1718415938273;
        Fri, 14 Jun 2024 18:45:38 -0700 (PDT)
Received: from [192.168.0.5] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104a48sm5814400f8f.100.2024.06.14.18.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 18:45:37 -0700 (PDT)
Message-ID: <9f934dc7-bfd6-4f3f-a52c-a33f7a662cae@gmail.com>
Date: Sat, 15 Jun 2024 04:46:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1] net: wwan: t7xx: Add debug port
To: Vanillan Wang <songjinjian@hotmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, johannes@sipsolutions.net, loic.poulain@linaro.org,
 ricardo.martinez@linux.intel.com, m.chetan.kumar@linux.intel.com,
 chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 chiranjeevi.rapolu@linux.intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Jinjian Song <jinjian.song@fibocom.com>
References: <MEYP282MB269762C5070B97CD769C8CD5BBC22@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <MEYP282MB269762C5070B97CD769C8CD5BBC22@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.06.2024 12:49, Vanillan Wang wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> Add support for userspace to switch on the debug port(ADB,MIPC).
>   - ADB port: /dev/ccci_sap_adb
>   - MIPC port: /dev/ttyMIPC0

NAK

The WWAN subsystem was purposely introducted to get rid of this mess of 
char devices and their implementation in drivers. If you want to export 
a port, which type is not available in the WWAN subsystem, then 
introduce a new port to the subsystem and then register it from a driver.

--
Sergey

