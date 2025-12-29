Return-Path: <netdev+bounces-246245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03785CE7A59
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 17:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 140B33018414
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD828488D;
	Mon, 29 Dec 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9y8VqKV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjMZMMd5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957E1DB125
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026500; cv=none; b=G5PakUIuHjOhqt9FSruPfvArzawnzyiSmgvr+FwVCm4oecM6I3IxczcS+a7n9HWHq3mzWI6r94cER6lCllMGm836d04UCDnDizC9qMdvyzlOXgiBW5SUbSLXOGW32oYDYG7uGCxKgkAcAwIFxadkaYbfb3aXs3+zxMsrBoRN9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026500; c=relaxed/simple;
	bh=erNds734pLhyo2IuhkHeEy9WhoqgmQRoacL6Efme4OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFrHvFaPiFTzv4mm9QSASymY7A7egt9Wn5F4reinyy0YjKh+ut80/VCrnlbElCrFIam2m+Uxt2kNmDGo9waqDJYKAyZyPk/af/x5NpOoPr0tT7wK8PI7QvB1gdyzCCFGiJhx0NBxkmrfkhdQedkjTmrQss+EgLMpFJUIzizu5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9y8VqKV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjMZMMd5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767026495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYn3jQE6vngRVH3G1pRtRLPP2F+9+MHMDtsX3KrLli4=;
	b=B9y8VqKVAULCYxhlL3X6vuFK0giy9gz6idaf0F8ssqV+IzbwyFgsA1ATntLRWYfr5cJJ9f
	LJb4Dk5u3YWbImBJKjhgzoPNWVOVu/IqcAj2sXC7MJpcx9UFHAESRsnU5iWKCAmrjyzHJ5
	PjHzkgYPJ6FoUx8/MBaY8dV0t51JFL4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-j0tSy6tfO_aRpJjfT8LtCg-1; Mon, 29 Dec 2025 11:41:34 -0500
X-MC-Unique: j0tSy6tfO_aRpJjfT8LtCg-1
X-Mimecast-MFC-AGG-ID: j0tSy6tfO_aRpJjfT8LtCg_1767026493
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3c4468d8so22225945e9.2
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767026493; x=1767631293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bYn3jQE6vngRVH3G1pRtRLPP2F+9+MHMDtsX3KrLli4=;
        b=FjMZMMd5iTEhMU3C5+WLeTIyEByrBOm8dQTYElFSZTcIxuRSVL0SDZD8L/BAC8SOWf
         09KTg7ULT373+1ToCoBExOuMvPLGZ7k/lJdN7tWSKSjVo0DmApWtkps+84LHDFVr0rBD
         2bUrr3h/r/J1mf4m0MtII3ZEplsIo1hnBaAx8He+ZWYS7wXihL98TG4PiSoz83Lx9SjY
         re/cnDv9dlasQ4ZNxCzZexJ4S14/kPn8ek6iQNmBSagjCYPP+9WU4WvRq4mELgnUy3PR
         Sv/evu4MdA1cDzon0+3Z8G51yKYoSlGU4GJnPqsA5CBmVKc3mUYTumt+CgEy20GvenIw
         4GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767026493; x=1767631293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYn3jQE6vngRVH3G1pRtRLPP2F+9+MHMDtsX3KrLli4=;
        b=bXhDH0l90Wsu1PviXVyyHVmtIA/IEOgSFIOvFie5a73kNSlcwV3xRHV4IX4xqVvYsy
         YwQE6GZ7i+kOCAbL+eXKxa60o9roJ+XeZCEtZD+JqHxUCdfTKklxpXzC3zWBi/iKkPAN
         j5nGPnCn9Li0xqcNw/zX2gu6TAVqDMw11h9vysmyoHgRbqngDSP05EwcLY2l0DkNdtVp
         r0YPDSz0AQvSmo37ubUOG4iV+wF9c/Oy6Bbftv1cntZkFGIFxNbnbN6fu3gZb2nKlS0p
         oO0ODlCz0Gf17BKf5jZZm4TAoWlPkVd15EOQ3KVc53qmo8gOqG3wdQN699IBAZLvzUmC
         qDjA==
X-Forwarded-Encrypted: i=1; AJvYcCU4dlegKEqj8aHXkUwRQhjzT/PBETu2uLYwymCmrkyGv/YewA6IVMOWm4dZVovip4mTqrbMMCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwupV5846qGONOf8EWzTFaEsV/Ch2K3yjHHEow6zXJATwhWYWTO
	iGkHELavGhdze8mBK8LIvnCbhhTpcuz5nzDUnuGpWzJzNOWZQbKLDAIHTQsU767itDQmg9/q3Ye
	enGpplGYWw1bpS4y6aIQwr5fK6yT58Bkf2zk3/T/IYlx1c+pajvgJ4ZvBvW5CO40riw==
X-Gm-Gg: AY/fxX65iI2eI9gFTxFxpV6o97NO5KL8dpGSPaucuMYjqg4P4qIKarO5iuSEFOGAwMD
	MiD5ZN0P0Sf+gieRph72otC+usHU2ZZSSeXkMyoFx1qj3vSyt0qM4lsAB1m4N1yLV+V4bD7o2os
	bACkAYStP8SF9ACNdmBNiWo3/RIGzwaqL1E25XgpxSlK3hvrHmvO67FmHgWXpe1RW54NJXUTk2p
	2iM60EftTONTaIRwf16lBaK16euVeHUM+QHf72G8RWlebkCL+9kko7tnGnHkBudSAPdNuY3w7KY
	IlUeHnYmCuiOkekkVSSkNV+c8egwkavhFXYVoBP/ULC0ULlo4ad/tL2KXzcvp4GOzVCIHvP0bIe
	VvPPDmX//cxKmGQ==
X-Received: by 2002:a05:600c:8209:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-47d2150caafmr326896085e9.34.1767026492800;
        Mon, 29 Dec 2025 08:41:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmuh1Z3nwF0lpjmqjZlKGu0DpKv6n8Wur+/t/yAgN0dAj5yrCvTM2a7xdPIziXO9K76J0VSQ==
X-Received: by 2002:a05:600c:8209:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-47d2150caafmr326895855e9.34.1767026492425;
        Mon, 29 Dec 2025 08:41:32 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm605461255e9.13.2025.12.29.08.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 08:41:31 -0800 (PST)
Message-ID: <3d00ff0b-58b6-484e-b5cf-202ba839acd3@redhat.com>
Date: Mon, 29 Dec 2025 17:41:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mltQQVRDSCB2MSBuZXQtbmV4dCAwMC8xNV0gbmJs?=
 =?UTF-8?Q?_driver_for_Nebulamatrix_NICs?=
To: Illusion Wang <illusion.wang@nebula-matrix.com>,
 Dimon <dimon.zhao@nebula-matrix.com>, Alvin <alvin.wang@nebula-matrix.com>,
 Sam <sam.chen@nebula-matrix.com>, netdev <netdev@vger.kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
 <a9e7c86b-1a08-4ea4-bf41-75d406a13923@redhat.com>
 <19aba6f7-acaf-45cb-985c-54be21592bdc.illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <19aba6f7-acaf-45cb-985c-54be21592bdc.illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/29/25 2:47 AM, Illusion Wang wrote:
> 发件人：Paolo Abeni <pabeni@redhat.com>
> 发送时间：2025年12月23日(周二) 15:08
> 收件人：Illusion Wang<illusion.wang@nebula-matrix.com>; Dimon<dimon.zhao@nebula-matrix.com>; Alvin<alvin.wang@nebula-matrix.com>; Sam<sam.chen@nebula-matrix.com>; netdev<netdev@vger.kernel.org>
> 抄　送：open list<linux-kernel@vger.kernel.org>
> 主　题：Re: [PATCH v1 net-next 00/15] nbl driver for Nebulamatrix NICs
> 
> 
> On 12/23/25 4:50 AM, illusion.wang wrote:
>> The patch series add the nbl driver, which will support the nebula-matrix 18100 and 18110 series 
>> of network cards.
>> This submission is the first phase. which includes the PF-based and VF-based Ethernet transmit 
>> and receive functionality. Once this is merged. will submit addition patches to implement support
>> for other features. such as ethtool support, debugfs support and etc.
>> Our Driver architecture  supports Kernel Mode and Coexistence Mode(kernel and dpdk)
> 
> Not a real review, but this series has several basic issues:
> 
> - each patch should compile and build without warnings on all arches
> - don't use inline in c code
> - avoid using 'module_params'
> - the preferred line width is still 80 chars
>>>>>>
> 
> Thanks for your quick reply!
> However, I noticed that at
> https://github.com/torvalds/linux/commit/bdc48fa11e46f867ea4d75fa59ee87a7f48be144,
> And the checkpatch tool checks for a line width of 100 columns. If we make the change to 80 characters, it might reduce readability.
> Could our driver set the limit to 100 columns instead?

Please use consistent top quoting in your next replies. This one is
quite unreadable.

Networking still uses 80 column boundaries: please adapt your code
accordingly.

Thanks,

Paolo


