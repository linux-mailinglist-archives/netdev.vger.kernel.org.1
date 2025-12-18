Return-Path: <netdev+bounces-245393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C3CCCA2F
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52E633022D38
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F537C111;
	Thu, 18 Dec 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtq9Ko9/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ai/DdmwF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36A37C107
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073691; cv=none; b=B6ZDBVgMDAQSx5pFWQsjaJVGBq7hoD1+EvZ3XdKNJ4cuuCV3hfju0JG2GBGFwTiSS4z4w4Jfoo+BxA7jOzrE6Ezo48JkO9m7pvD8xRi/hkwmE9grOBKp++YcaM4g8qbxITFBDH2IjWeH9NcKvFozREjMZ+5y0oddfCw1ojnpLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073691; c=relaxed/simple;
	bh=frrBvs60oEfG4UguaOfZGmMPbH15QsKa0tV3wAzQ8IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf0D5T7RkdwmoJrfwFzDRE2XKUTxPORqTFCNLWc9+XmDfUAPFjF0T1VoUiu3YcMcLQ2eXlvaprsfCEi/GObzYY59CAdhb09xvM3RNSmDXOBX3dz65ZSDbXgURZxsdZ0inRJK1nRTJehcEDt2Hg5I1pMiIbKcjVA94VLDh4Y1eNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtq9Ko9/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ai/DdmwF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766073688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frrBvs60oEfG4UguaOfZGmMPbH15QsKa0tV3wAzQ8IY=;
	b=dtq9Ko9/U83BTq0vU9N/3g8c3LPrzJ6pPVcsAMCZ3L5Jjgl0HKLNMSnu2TFO35z+W0rLYg
	zoavAcRX65di8Ebbc6AULBM4DclZEPh0rLtHQlQQtMMrwrU5dSkMjfXKMBzdcsM3Xki/oI
	HED6og92S/Xi5rMmFDt4EpZHu06FtOo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-sWo-AUiPNU2fa9KTr1K4pg-1; Thu, 18 Dec 2025 11:01:27 -0500
X-MC-Unique: sWo-AUiPNU2fa9KTr1K4pg-1
X-Mimecast-MFC-AGG-ID: sWo-AUiPNU2fa9KTr1K4pg_1766073686
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47799717212so8484245e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766073686; x=1766678486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frrBvs60oEfG4UguaOfZGmMPbH15QsKa0tV3wAzQ8IY=;
        b=ai/DdmwFvi+3BHx2mmnmKjW7R3UsVPu0mB4sbennDQplB/6l/noAUyG4odYmL4Q505
         0OLCZESdEl+/dL28pJBEAsMnU8TMqdG6mH8ROnEn15JPyekNAFcXGhBZvGrk6muLiISu
         evZ0D3dsGgLhBURwe0Z2A/MjwEhDn520eUkst1/jNKxB5kUbhK+P+6xBkwQu+Acl4YMd
         8MFu2TluhRQKWmAeZIo2cPi0Y0sf96lqASzSdSI2FeIvZ/Zieujms9bDWMti9jpFhS/t
         Xa3p8dG9nSCwULtxm59CLWMWL/uj3rTsXpDO1goqdWSD67xj0GpZgTEjKhbNtf7iTKSm
         Iqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766073686; x=1766678486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frrBvs60oEfG4UguaOfZGmMPbH15QsKa0tV3wAzQ8IY=;
        b=G3z2VxCl5yNzoE3j3eXNZB6qtTLtalIe6BdzrXidJXukn+UM/h/Knpaj2ZeokNOjGV
         +gKfIoK+oV/yYYoAi2cBg/Gm7HC1NLrvx0tKx0C6tEIfgjyc778zLYmO6pEbQS0J0GQ9
         jTHyjCvTwP2SYTi1XgJFtPLJq5W4EIXG6atf0p0NHsD4YcdLb4SezDSDb4JCEy4n3HJE
         HZO+c0kQg+70bnt4U0h6OsrCjcBNqTv4bULgoTs62hYoxEiMuXYNDV5OsDHW2Pcc7Au8
         UGaXig9YfpyPh4/6114rjkPf5EfHiDvz+LSdzM5bMZU5GW8ZQFIX3ARPBdkrVQuz4Qcq
         a+4A==
X-Forwarded-Encrypted: i=1; AJvYcCWgTfEk+JvtqcBre6/smOzAyw7i8yum4xdn3VHWQcY2VsepIgoDDIKIidMhQ71FTpC6HMbC41Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXBxf8kBcnn7ujywllCo0YHCzjnHLTB2HVRXAB7Y3FaaHY9SL
	J/c0hSv8GncL1sdydeAE12x9JPu2moSP4L+kCemWzpzarUMiaRbL7isptDuNE/BBI+L/PXqL+pl
	yn3E9iakJWigAXxDIk4u3ackR2zl1vpKX9ZD8/O1v8yU0arwcpiCkbfjtOA==
X-Gm-Gg: AY/fxX4pxuOBJJYMZYR8dNRlqwnv5Si3sNsRe/58Re/hugjeEHh99nCDKXhz1Vy0MwU
	ipItyxTAiD3F1nbb/g71O3NGnm+aejybaaPNUXniS3Q9hZjByLgCfWk3YuEHta0R9Ovr9cJwbXB
	+5/X1G+hWsWPBtf66Zgtybqowdwz+8rFd8YQmvFADYEogSuejxu5XVD6DrDiBF1P7wSKl1jTXJt
	GLy16N4xZH3oAorGOt2H/fTAUiySiIq1UlqHIdviA91nezR96iAkmsdyUsiGOCYGN5++Z0E2eOh
	xs2WYDfFNslpP8OBLgngMly6dm7zGNaeyJVGGcWNuxQqqxfeW9XXcR8EW/2O17lF7KZLiN1rnhI
	7NabQSGWAOZ5e4Q==
X-Received: by 2002:a05:600c:4f84:b0:477:b734:8c41 with SMTP id 5b1f17b1804b1-47a8f8a83cdmr232104165e9.1.1766073686254;
        Thu, 18 Dec 2025 08:01:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0Fb1hl1v7CMUuMK3CpIVkM1FGbXFlOQbkMifKoM01rCwYOxVDgnrazvrrLKI5vKmJhGJFCg==
X-Received: by 2002:a05:600c:4f84:b0:477:b734:8c41 with SMTP id 5b1f17b1804b1-47a8f8a83cdmr232102205e9.1.1766073684351;
        Thu, 18 Dec 2025 08:01:24 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3278439sm47493615e9.13.2025.12.18.08.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 08:01:23 -0800 (PST)
Message-ID: <e128ed6f-5dac-47b7-b329-aecb62d9f8d2@redhat.com>
Date: Thu, 18 Dec 2025 17:01:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 0/3] There are some bugfix for the HNS3 ethernet
 driver
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251211023737.2327018-1-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251211023737.2327018-1-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/25 3:37 AM, Jijie Shao wrote:
> There are some bugfix for the HNS3 ethernet driver

Next time you should include some actual contents in the cover letter,
i.e. very briefly describing the nature of the issue addressed here.

Thanks,

Paolo


