Return-Path: <netdev+bounces-193701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E3CAC523C
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF171BA143D
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BEF27A91F;
	Tue, 27 May 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="cuYIwtB2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB027CB02
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360282; cv=none; b=e6q/4LZeZe8xiRtiREg4JfKCKZuF9b6d29WeoOOGS15RS0ddG2wGuUD+MDzY3WziL4T/szEAYdWrRCY1Amo6+osvjyb3rwWE+E+6UxuQwcFgJZPQ7jjTIonwLtMCznl/tMsNaGIya+aDPb0EE5imXcS7NdlG/CUFccxP4ulgXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360282; c=relaxed/simple;
	bh=p/o122X4ljFZBU0Q4dr+Qo7j/z6+e8AKAzXwFIujBOw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XjKSXVD8LlAiUoeIs4RZC6mCAQ03ew9wAx2SIrm/qyIHMz2dSNVVAwfqbO897/uQcfombEMjmtl+9Lsx126vMMwucEaBS3Qtut7fxF8+4ARlGorao0ttkyfcTUMSpxRC+jqQOrm32PdKg3wC3yyw7VMPGciByjPGGzIOzfX2ADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=cuYIwtB2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad8826c05f2so283483566b.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1748360278; x=1748965078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kr+3qVj84AM5v+2SAfanJxOqGK1AMPUEOkve1+U1HuU=;
        b=cuYIwtB2oL3PXQabvsO6CIx/JAJ1otI7lxbsahOmYYoZwhfmYHQa1/Hh+Bj5u/OBgs
         kndde4Cg4z5bliDMDithTCx2eZd5Q7b4jSa5rv01jnCdS+hKYENt8ZxMl8CGu4qiK+tf
         M1Ht2/obKbpuyddqShA1skiqvm+Vb0boig1LkagNFjpfLjS2N9d/eseHih5BUMef7kjJ
         IbfJhTFPlo29Fj6QGB0pgU3hXyJaR29UpE7mryQdmgR0Dvk+xz49+b2bS/Omr/PnajlD
         uefO8EPh2iIUXNrNtd+t8olf74NqF3s60MFDDv7FarwPqLY5zXTjxSUcvvmsggtKtWGr
         uBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748360278; x=1748965078;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kr+3qVj84AM5v+2SAfanJxOqGK1AMPUEOkve1+U1HuU=;
        b=YTNlLsj53QZraphFt2T5v411oAs1sNaRHlQ2enYKx/E0y5TseihSP7xtMTiapAZgLx
         9nFWeK1M6OW9nQT6U/31kKP/ETipmx5tEhhYa59mixtggmiWEl46J30DUebboO8UbTtA
         WFx4HqqcxI+RiDfmgehwo4Yxvjs7fN0F9pIrKU/DRiiDRzAWcqiszJPyYLicnmEILngZ
         OfZZXnTyrwwYN++5t92/bjCUlhs4WqH6R/XCDKHzmKPkivIwtkL1Q1FGF73B1lfUbNz/
         gA+L7rymLYJTqGoG/PbR0m5QaIc2ggdJ8L5sxP89GsIqXS2nIpYSYcC6q0AB0OLb+rQr
         n3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP0MII9N6605bsnl/XOp97o2L4u61Q7gtRQX7QWzRekPwbxsMyK2sdmQw3+t4jYIyePwPY2tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5q5Wf4EHCNXrIpPWtKo8O5vDU8NtxRAc3qqcUGWnQikuJ3Fn
	LcxgkROJmoBTQFd0HFv4ccxeJrKHTpS/PHXCfZSJMIcqyYMAVUMGxIa00YISoAjOcQ4=
X-Gm-Gg: ASbGncvs0IOxwqPjUbuYrELK/Fu62BeXDevuNv8lAipZ0EX8QofKeili7N5F7qx4LYj
	uzqepCZm6lTP+nCRiNzXnEhjuPtub7b05QZFQyUXsFXcghSJOpOTE5O6FVw8+1RnoqR0OD2zCbk
	BO4WLuipjRzVY3hnaFVMbdb3jCpFFQw6R6Bcq+Q2qvIOKG+48GIh0jmaPI7HaPj2tD7RYSsqRzI
	tM18gUS9/LNGIAc2u8tLlulMcUWmCNRpmvTAUsA/NzA7ttU+O09yLzQ1Wts+Q7MlGhKA6Bn53EM
	TRtJ7coy1Rq4dVCtp4X3BOa/b3u6TucZAqoV6UjaULZkVz5ZOJmlWTFfo//ovEqdfgPt2aGy7dy
	QI3+3tK0zFJw=
X-Google-Smtp-Source: AGHT+IFQI6Z/xt8uzZfBqzZsnVh4Wbg6Df7cRyuxlNhChbAAM6BIpDJ8weMCUJPWkNL1ndg0Kw1M1Q==
X-Received: by 2002:a17:907:c26:b0:ad5:a29c:fda1 with SMTP id a640c23a62f3a-ad85b207af6mr1358812566b.46.1748360278164;
        Tue, 27 May 2025 08:37:58 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:cc1:c3d6:1a7c:1c1b? ([2620:10d:c092:500::4:425])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06cdefsm1888275966b.52.2025.05.27.08.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 08:37:57 -0700 (PDT)
Message-ID: <ff26ec09-6c00-4aff-9a18-25bcc4a3a5a7@davidwei.uk>
Date: Tue, 27 May 2025 16:37:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS contexts
 on queue reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
 <20250519204130.3097027-4-michael.chan@broadcom.com>
 <20250520182838.3f083f34@kernel.org>
 <CACKFLikOwZmaucM4y2jMgKZ-s0vRyHBde+wuQRt33ScvfohyDA@mail.gmail.com>
 <20250520185144.25f5cb47@kernel.org>
 <CACKFLimbOCecjpL2oOvj99SN8Ahct84r2grLkPG1491eTRMoxg@mail.gmail.com>
 <20250520191753.4e66bb08@kernel.org>
 <CACKFLikW2=ynZUJYbRfXvt70TsCZf0K=K=6V_Rp37F8gOroSZg@mail.gmail.com>
 <423fd162-d08e-467e-834d-2eb320db9ba1@davidwei.uk>
 <20250522082650.3c4a5bb2@kernel.org>
Content-Language: en-US
In-Reply-To: <20250522082650.3c4a5bb2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-05-22 16:26, Jakub Kicinski wrote:
> On Thu, 22 May 2025 12:01:34 +0100 David Wei wrote:
>> On 5/20/25 19:29, Michael Chan wrote:
>>> On Tue, May 20, 2025 at 7:17 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>>> "reliable" is a bit of a big word that some people would reserve
>>>> for code which is production tested or at the very least very
>>>> heavily validated.
>>>
>>> FWIW, queue_mgmt_ops was heavily tested by Somnath under heavy traffic
>>> conditions.  Obviously RSS contexts were not included during testing
>>> and this problem was missed.
>>
>> IIRC from the initial testing w/ Somnath even though the VNICs are reset
>> the traffic on unrelated queues are unaffected.
> 
> How did you check that? IIUC the device does not currently report
> packet loss due to MRU clamp (!?!)

Only from iperf3. On the server side while it is running, resetting
queues do not affect it. Didn't check for packet drops, though...

> 
>> If we ensure that is the cse with this patchset, would that resolve
>> your concerns Jakub?
> 
> For ZC we expect the queues to be taken out of the main context.
> IIUC it'd be a significant improvement over the status quo if
> we could check which contexts the queue is in (incl. context 0)
> and only clamp MRU on those.

Got it, thanks. Michael, is that something the FW is able to handle
without affecting the queue reset behaviour?

