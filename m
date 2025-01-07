Return-Path: <netdev+bounces-155736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F193A03805
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF17B7A2259
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE701DED6E;
	Tue,  7 Jan 2025 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBpS4SAI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F818B46C;
	Tue,  7 Jan 2025 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736231788; cv=none; b=fI6wJyl97RirBd4J4hA7f9jhkf9ZyeBDlGLypspJwb8PKDk9d/Mdh4tSszuSJme4IjYDUCqn6SqXq3CbKklTEIFJyKm0BpNaFCs9ObpNAa7kNNj/5j4gevvhwyoAmmawFAB6o9qDjMUXGwAP/2e39XMON6f5SJIc7vX8dotiDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736231788; c=relaxed/simple;
	bh=Kng/mpbUzhaJx0h/7Fasw6w2qS0oY3rIDnnEx7pNUzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR1We0cgNE//WqSWxYr9krufhC9trQeEllJeNjvVUuYmunNo5pARMg/MTJJ/uYn2UWkxWESXdehFIAdWkr9P+9+YhX4NYsQgbQBHty4oDVCiNWvh8NYVSUJUTUPEvVasZaMg+2Z6jEAzxal+Bp4IYA/96f1FYhSYARjI5gMRGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBpS4SAI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21619108a6bso205274805ad.3;
        Mon, 06 Jan 2025 22:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736231786; x=1736836586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kng/mpbUzhaJx0h/7Fasw6w2qS0oY3rIDnnEx7pNUzQ=;
        b=mBpS4SAI3qyiuJ+XyXF9U8RNOKg/aNGWO8iFx6OvqWtHDqVF+2nwQoVF5DX2k7OJYn
         b1jqtCjLY3EJdMFNViVeqM1TZIG7Cd2cdKZXrbwFQGeZR3vHb9oprMC2FfK6ZWMKh1Iu
         DplY9h8og9KJNlGnOnYSas49ElkJ0EGq0pSScDbXsR3yFE5bJCLFaNPMc9YWRXSWzMX5
         oov5emxwPUwe9LxtL/uyy8tn+fm8yZPelFEhXTRbVym4+W7BzCL8An43ZOORXD9DooDA
         tt9r9CNDZpWtVR4UIzIUW/ecjdqMSF+WmbStXDO2REsnrq2t3isOeA6EkgJ7cpxV+ZIA
         CAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736231786; x=1736836586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kng/mpbUzhaJx0h/7Fasw6w2qS0oY3rIDnnEx7pNUzQ=;
        b=Oev4DdbCE7my05vl4rvYv1L+ZcYsk3drTGD/XIfix3QiYpuntM0tW22l0hrpAX/AD/
         VzgKS0hMzfFnfvq168WY7XOe5j6kbpb1o8RzWItsN7thkgNxBfjjwUXsq+K2KZkgmVHc
         +cxdSP/5+nQDGez/6epiRqzkRm4goMAa0VuI/ySnDShNBt2ROSoXLoLujP8puqXjSdmg
         7QiAyes3ephZW16ATsFG0hnv4mZrrUubmjTs4c+k2vcdZwVcqKKOOCHWgDb1MKeAJRrS
         rOoYyEpWB5VRIu7AXTXSyRYQb9uQFIgy2zfiq3oi4zQk3Dwr/GgOqZw0Ch1/fZ7hFbjX
         0eFg==
X-Forwarded-Encrypted: i=1; AJvYcCUuOa8VnnliEoZi4cSVPsuI1xAi8NK9Gz+l+3h2qwjbNJkS8BFR8fqLWqdEfGqjohyganOwu6TPm6jI@vger.kernel.org, AJvYcCV2iaZPVa7tZC87ISc0uucdsgC1yoseE7TEXG0YWXqEdZEEjS+rLcwm/iDSr8eMPm+jKSpdjqLd@vger.kernel.org, AJvYcCXUsCu3ldjfGq1/D8QpNLeTC8RQHSPrSq2QtzhT1aG03ss0AZwo9vrUvBGau4G3RjI03S9JayknTcNHzofg@vger.kernel.org
X-Gm-Message-State: AOJu0YzDmmuzoxb07LsWLRZJpIDSafDdgExYP3cKaYkN/hMwJCyAHL9U
	/3KS0td8+FZbhuIizkCVL+19lUywS/cmK2xv7kulf67oQsayaJQd
X-Gm-Gg: ASbGncskwHmRChoU45N9kI4xb1rHwD8Xdrzni0+RZ2k+OSngsFeY63W2tvc3ZlLSBwU
	Bpznj2JpVIY5GQM8S9BkAVaTyB36NkYnQUgmiiMPHTZUvv9+KQz01D8LZuIYiyQZwgHlmvPqJHK
	EcM91m3GRS4DaPEQ8sW/dTBxJKl5kULWUcXKUmbzil+9tbrMtGi0L65irQSfZF2nQ/herL8yj/t
	/eJTkHIq6Xn83bG2BOqe7UJoFVYlFHc4+tjBp3n+04f9jbUt+34tEYLy3LFGc2svSfYvvkgGXop
	+P/m/v2Shfahm6ABvuGcEe9gCDcqcMjmTEU=
X-Google-Smtp-Source: AGHT+IFB3swUN2iLMUEOpHvMus0FiubXQryQDXtAgLSPcX+ECwaEuxj3DZQ/Bf/+X66C3yI9GBLI7g==
X-Received: by 2002:a17:903:94e:b0:212:68e2:6c81 with SMTP id d9443c01a7336-219e6ea0223mr977864255ad.24.1736231785959;
        Mon, 06 Jan 2025 22:36:25 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a739b423fsm23758445ad.198.2025.01.06.22.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 22:36:25 -0800 (PST)
Message-ID: <83c11616-ac3a-48b8-a513-ca000ff9d48e@gmail.com>
Date: Tue, 7 Jan 2025 14:36:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/3] dt-bindings: net: nuvoton: Add schema for
 Nuvoton MA35 family GMAC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: edumazet@google.com, peppe.cavallaro@st.com, andrew+netdev@lunn.ch,
 joabreu@synopsys.com, netdev@vger.kernel.org, schung@nuvoton.com,
 linux-stm32@st-md-mailman.stormreply.com, kuba@kernel.org,
 openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
 mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org,
 richardcochran@gmail.com, ychuang3@nuvoton.com, krzk+dt@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, yclu4@nuvoton.com,
 conor+dt@kernel.org, alexandre.torgue@foss.st.com, davem@davemloft.net
References: <20250103063241.2306312-1-a0987203069@gmail.com>
 <20250103063241.2306312-2-a0987203069@gmail.com>
 <173592330334.2414402.4730979254460270593.robh@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <173592330334.2414402.4730979254460270593.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Rob Herring (Arm) 於 1/4/2025 12:55 AM 寫道:
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches*only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.

Got it. Thank you for the reminder.🙂

Joey


