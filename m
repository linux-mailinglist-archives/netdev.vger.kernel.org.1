Return-Path: <netdev+bounces-245491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA001CCF140
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A91833002D42
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD8C2E7185;
	Fri, 19 Dec 2025 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvoYspIx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2C0Ay8i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6962C236B
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135184; cv=none; b=ar3cScTnQSNokZGHIXZ4bEKlmZBetTGwk8HiyEcugT2nr7Ju5v62I2qA7E8FcGf2/GU7Yz96bgCbTds1Z1CpH081DPlifp0ObFW3O4uC2f3vFpM6prrENedIDSktERsYTlBx7wwrNBVM5D1tWVNmlc3FfF2F6eWDMnR+tuWyIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135184; c=relaxed/simple;
	bh=Ya983u4axH6kjlKeYBWtPpboTZW33y5xeVr4MOP0TRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPGwDplzzdRV+QKF6tm/16KvCHA49xHxPntlDD5gVzcpS3vSeOAxDBSB9TeO5+Kp20sE7QkHq+t2/7Epf2j/BR2jFAJXLELaSIV25p/arW1CPOLEfKpG45yAJhQGSQ3sOX8CzRwBgwotuIkt/Nv5d0Xk++6Nke5dyPSyk4MV+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvoYspIx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2C0Ay8i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766135181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEJJ3ZBJInAIh15iKCZRVqfAs4YnUHwyNO2S/KWdSaM=;
	b=DvoYspIxx7whvLsOvRUlWLraKaTJf74XQZvts/1Q6/Z1gg8Lc470FRlHXPUJWNauZgPoUE
	v7M0xigBeW0muY5A7Fnzdy7m530lsjJdhSlQSuAy/wXf4hh3nbR3IYTyBOn9u/E3aqpOUz
	FFVz/gpjQjXknU3QBY28MAQt4uS729U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-e_N28IM-OXaj78u4FOIbrQ-1; Fri, 19 Dec 2025 04:06:20 -0500
X-MC-Unique: e_N28IM-OXaj78u4FOIbrQ-1
X-Mimecast-MFC-AGG-ID: e_N28IM-OXaj78u4FOIbrQ_1766135179
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47a83800743so12029455e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 01:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766135179; x=1766739979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEJJ3ZBJInAIh15iKCZRVqfAs4YnUHwyNO2S/KWdSaM=;
        b=N2C0Ay8iFl+7oTUqHvmLPjU7UBmdN/bFA7DZqCeUaZunitNVyo7pGUsH3zOkqNTuMi
         4r9U+g6DkAX0MmKadMDyfyEVoAgRagUPZ2uU8Hke1bMqqX9Trz0/XOo8aTNr8q7ln93n
         68BhAhoRGtbi9iWSZwo6bs+bdH6Jt++JG7IoD/T5m2lZML4Nm52NKRoAoMyHjXCSpSPk
         H+jyYlLD5Oyhzy3Ma04xL4iJoeVRByhsuY+UhGaMrT5FOIbY+90SS1EvbNKsIxq6KJgS
         0sKZwVb4CWnBgNM6RgiCE7Auyx+Enu1u9rLNqtayVmrpGRB90XRchqrFtQakNx4dIpXj
         f6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135179; x=1766739979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEJJ3ZBJInAIh15iKCZRVqfAs4YnUHwyNO2S/KWdSaM=;
        b=V2BKFEdJIwRs04b5P5GxNxfnKqE9GOLuH+oa39v7XjfeNu+a9z4ZdBTlEUvKVtgSoB
         OuxdS5cM7E3zsI12VrBmg+LNkUC7AI9R00xahZFvlDZFT6fwK/LlgUWWvl/JNLI/8Sgn
         uLfrJmSWphPNQj41Hw+OL+kZCfoIUjTtiw2GOj7edmDx/HNqoFM1VF+F7sh+/LNz42Y+
         uk16xheK/XFz4BEDQr2QRd6+KNTPVH1iPQQJ9KFjzVKrpg2oM39B0z1D0dI3GOZQ8lDb
         hndWJ3S5YZRE/BtIRP6EXyfzolPU5Pnimcx2q5FwAq3QhX7eOpCeao1VDsQEb5vW1tsf
         MxfA==
X-Forwarded-Encrypted: i=1; AJvYcCXGaWJ81xaB1xmF1aYWhCET2ANEV2zgpTyxhk8tesz3uU6i5WDzbATTtjepDtT/IcQMgVZ9KVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmYuAIFNBB/UtXSTNhCNH+x6B16DNAaXfHOQ/LsWwZFofejUUD
	rIU6jHr90J3A65XpshlYqt1nQHK8Nxv9XaFAo/MCMO5Ul/nDQcgqYayumRVYi8UP4k0h72VbHLV
	mUoMxQG8FD4PvUOOPtjSClqe9lbgRh2lEMKv/cKE0tOQwVw+2Vw5G+CzrAZN9WtU8Wg==
X-Gm-Gg: AY/fxX7pymMcsidMjJMP1Po0+SGN3rMrIYr2Ux7E7LgrocazQdOhwE/XWNYr+NQqSDI
	g9PNtvuWuul6amOtElqtmNMWoLkKBQnGv0s+a+44VWt2S1DY5l6x6ykcTeqetnTbbW6wSGJzOVG
	/41lQE+qDvfe7f3PeZ5JXukfsvTAeS/DCaPf4j5LvWN7Nt/Wu17HXvAAXqt/4JQSji+6YY6r65Y
	X2UM91HY/LRcBPO7+CI4+z0e4BELwBz8yzSasGxSx562J1VMR9KduM+nGS71PZgyj13oryX7EQg
	vi65H1XI3fND/POI/a5UP/boGcDlWPAYl+8kspSWY+IMpaTm68kWO4KkIRZPX4ZnVqIOqu9FCUu
	SnhFLZC5R+7xj
X-Received: by 2002:a05:600c:c493:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47d18ba7befmr19461125e9.8.1766135178935;
        Fri, 19 Dec 2025 01:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7eioW6Xn+tnoEhKXG2yusHQOhJIOjn1R2GKM3dKlAw2syLOpgGZtPDJfLlzWKSUJFj636Ug==
X-Received: by 2002:a05:600c:c493:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47d18ba7befmr19460835e9.8.1766135178533;
        Fri, 19 Dec 2025 01:06:18 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3963fc3sm32985095e9.0.2025.12.19.01.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:06:17 -0800 (PST)
Message-ID: <63de3a12-36bc-45bf-a3e5-89246f4ec73f@redhat.com>
Date: Fri, 19 Dec 2025 10:06:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next ] vdpa: fix caching attributes of MMIO regions by
 setting them explicitly
To: mst@redhat.com
Cc: virtualization@lists.linux.dev, eperezma@redhat.com, kvm@vger.kernel.org,
 jerinj@marvell.com, ndabilpuram@marvell.com, schalla@marvell.com,
 Kommula Shiva Shankar <kshankar@marvell.com>, netdev@vger.kernel.org,
 jasowang@redhat.com
References: <20251216175918.544641-1-kshankar@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216175918.544641-1-kshankar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 6:59 PM, Kommula Shiva Shankar wrote:
> Explicitly set non-cached caching attributes for MMIO regions.
> Default write-back mode can cause CPU to cache device memory,
> causing invalid reads and unpredictable behavior.
> 
> Invalid read and write issues were observed on ARM64 when mapping the
> notification area to userspace via mmap.
> 
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>

@Micheal: despite the net-next prefix, I assume this patch will go via
your tree, as it looks unrelated from networking.

Cheers,

Paolo


