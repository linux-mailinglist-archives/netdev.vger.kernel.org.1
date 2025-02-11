Return-Path: <netdev+bounces-165136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618EFA309F3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD9D1888C84
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE31F473A;
	Tue, 11 Feb 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWrRX0Sm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A411DD526
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273466; cv=none; b=UOKVrPhaL1SRkIFISrhyaDZsxGP0BFWEz0tPe1Hk1gqcxe1CSHNiLah/wgNzy3zkyyx6pJpiqx2Lr8y4Gby0ES+e5/Fp+uc5XXnowtOaoYk9/b4je2V3bPA9oVZ7Gti/YKX9Puj0jl7JNvJBCQPdeMK50Z7lDNVoZwoPyMk7Ljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273466; c=relaxed/simple;
	bh=SxRO+2V18543uuVvqtYarJpvwbWlhVTPdjSnXR1nptc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hd9nSaVjFuFa07JITPyra/eys3YY8WTkXkFKnObE0NXuvHkprPZiCc3Xg8icFQjK12A39pGWbZD/j0/8MubkEZq1sUdPEi578eA/Ynldsg6KKG+Tssqr6k7E749JdopzjUWbqqMmp0KUqou5mByiZe2TgcErlFuK4e09PYSaSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWrRX0Sm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739273464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkXaSMBOnMyZHKLeyMgqeVTTrgOxiy57mT/LG6mdTOI=;
	b=FWrRX0SmdDzGc/FLo37O/Kv1uqj/TtZVseuOg1822C+Ap9yn/Y28qJLtqtX770UbWkUWzR
	YLbdDhvVMScl9e7QuBhJu4d2JFeHSRVu5VMSq4QuS7uA0D8uqtEgaV+en06Wpg1zxY0w9x
	aVAllel3CnMIBk+IsSMpmcJnwi3yTtM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-tQusCYx1PUmKhpSm7elPHg-1; Tue, 11 Feb 2025 06:31:02 -0500
X-MC-Unique: tQusCYx1PUmKhpSm7elPHg-1
X-Mimecast-MFC-AGG-ID: tQusCYx1PUmKhpSm7elPHg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dda790cfbso1889559f8f.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 03:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739273461; x=1739878261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkXaSMBOnMyZHKLeyMgqeVTTrgOxiy57mT/LG6mdTOI=;
        b=vKGp+tjFxBOdyBOUWVBlA792Z8e2yssVv0LhS7fKogxYdI65eHT/8CqZP9MDkZTo9j
         ga0Om+1jGWuK8G03R3lSdrtkmpAuEhy0C6uTEG3wi9PL9BGwB88JlOMD/PpQ4L4isJDZ
         hhRaismTqd+QnsvxNzRbmYmuuRNAmqnO00NsQq0R2cJhTDRqaXes6cZC8jrnB4WM3mYC
         A914YnNh2fzFBZYGF9Txil/b32S/Z5oDK8OzlvOY26KlyUEkFIhDoFjpc45Yz+2aef/o
         onUS+MMYkspFlThZ1xiL2yP+3WfJ3RV9Uh5RxTUEEg3F/iihQAE69DZgGKbIpuSZMJKh
         hpcw==
X-Gm-Message-State: AOJu0YzIAZCosI9l2Aj7zxY9ihUAKk3xaz8YMpoZRddLWySBGd9Zpn2m
	oVD/AnDU54643O1kdU+8Hdilh+IKGEY0ycmDTrfhXd+PEMiHIFHuEfsojUqV7UWvSwSPVKYBKey
	KHCa4FnyBz8dtVaNbIOwVyB9urxvokCMXT/aJ4x/EXPZhKd3eOY2abQ==
X-Gm-Gg: ASbGnctzYIjIaHOit24s5zAEB8AV4KE1WmgCp3AbCa9hBwBJyLdetjsVhfxpNk0No+G
	5G4yTU3Ki94yN0MCdwnsP7TmPbSfATl2SNaFo8oZYIHfvRRwCUyKAVCSwyrcSNuA0L/hgS+pBMY
	XfboPcWuc47YBAg3EVorK8Gmck/wMc4TZiN97I0Gkc55hhQ2Kde/HeqMPhXXSXl2s6bEtZDTLtM
	Uz3yS2SgmGRTeCg2B92N4efzTr38AsbZfNN0X/DcDJ+i1HOVsLFgkTCyCiLsdwwrCUS09ffU0yQ
	GIKrIA2eHFaFiVtzb5whDE04nfsYaeAAuok=
X-Received: by 2002:a5d:5846:0:b0:38d:def8:8307 with SMTP id ffacd0b85a97d-38ddef88639mr6802176f8f.55.1739273461492;
        Tue, 11 Feb 2025 03:31:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHayBvfNx73SbQMhbxNkafqfD+FDlmMiZt8eb9H+FDR01lT95RUPwq8zXQKROFW+H5GCWVS0g==
X-Received: by 2002:a5d:5846:0:b0:38d:def8:8307 with SMTP id ffacd0b85a97d-38ddef88639mr6802140f8f.55.1739273461119;
        Tue, 11 Feb 2025 03:31:01 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43941ddc8e9sm68421845e9.26.2025.02.11.03.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 03:30:59 -0800 (PST)
Message-ID: <6abfb27a-8116-4b15-9485-39e5b1f98c2f@redhat.com>
Date: Tue, 11 Feb 2025 12:30:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: refactor clock management in EQoS driver
To: Swathi K S <swathi.ks@samsung.com>, krzk@kernel.org, robh@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, treding@nvidia.com,
 Jisheng.Zhang@synaptics.com, ajayg@nvidia.com, Joao.Pinto@synopsys.com,
 mcoquelin.stm32@gmail.com, andrew@lunn.ch, linux-fsd@tesla.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 ssiddha@tesla.com, xiaolei.wang@windriver.co, si.yanteng@linux.dev,
 fancer.lancer@gmail.com, halaney@redhat.com, pankaj.dubey@samsung.com,
 ravi.patel@samsung.com, gost.dev@samsung.com
References: <CGME20250207122130epcas5p1857043fa03e7356dc8783f43a95716ef@epcas5p1.samsung.com>
 <20250207121849.55815-1-swathi.ks@samsung.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250207121849.55815-1-swathi.ks@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 1:18 PM, Swathi K S wrote:
> Refactor clock management in EQoS driver for code reuse and to avoid
> redundancy. This way, only minimal changes are required when a new platform
> is added.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>

For unclear (to me) reasons, our CI failed to pick this patch. I guess
the too wide recipients list confused the CI, I suggest re-spinning
including only the ML reported by get_maintainers output and adding the
target tree ('net-next') in the subj prefix.

Thanks,

Paolo


