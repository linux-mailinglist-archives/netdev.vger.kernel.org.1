Return-Path: <netdev+bounces-246244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3486ACE768D
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A872D307052E
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1839330D2A;
	Mon, 29 Dec 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUmxGmsw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErNgOxFi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBA330B3C
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025120; cv=none; b=Xzln93dHBIOfv2AbCbUDYw9znSG/UZMpw6PqhUo9EDLKAEz588Bb3DrqswdANHSE5xB9Bh47xPQECsXR6x/BUuNzu5BhTizn8xbYTAcPxWdiHGFxNSquoOllK2VWmh3FEp955RGQnZ2Q9M9VQBsYmt9YNxniKvmq5Gof1xk01bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025120; c=relaxed/simple;
	bh=TBwYFWTz2ztev5/32wN0RyFjZratpdCxrc9vTXfxWms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPdp0FcFtD0CCW9pPDrr9N6s8EmrNjEEhzoDVL5QF0iaXnbNzFVfaeiQejDcYfwgEaQbrxVET0UOu+QamImE4+B+0hNolb7TBQynmfMbKhF6cairBXxf9yzL2lnmWUYz6mFSVJOIoMH7DE7ktUEoZh6A992LIs1dDTRwWNM62UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUmxGmsw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErNgOxFi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767025114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBwYFWTz2ztev5/32wN0RyFjZratpdCxrc9vTXfxWms=;
	b=iUmxGmswe93mYq++ZAdClRqqkyzxMvMXCsgQzg1D2nzytkmMbqTxORdamflYWMrlbYq1TW
	lAT2KJAhNepDYeNIczAfVvfrQVCedHVvuA1j+E3ZYnxyyQNuc8FRv0tP9jxWBQLbCALIcz
	/cxUIYQLU+UEnhWYgcUzCchMEikqGS0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-KEg7DFi1M7ebXvV7xTzn_w-1; Mon, 29 Dec 2025 11:18:32 -0500
X-MC-Unique: KEg7DFi1M7ebXvV7xTzn_w-1
X-Mimecast-MFC-AGG-ID: KEg7DFi1M7ebXvV7xTzn_w_1767025112
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bb3a245d0cso2114085685a.2
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767025112; x=1767629912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBwYFWTz2ztev5/32wN0RyFjZratpdCxrc9vTXfxWms=;
        b=ErNgOxFiW5sJDByM4uFF9hqTlQ3xHJy0BKqNZdriMSjI2mqPBgxpZAAP3u4gz2T9V8
         E2rhUc1DJvmOYHfAS22aWoBoX8Dt9uIC309d47wrIAH5LkSwIlyBnHRCZktLvAR+IqBP
         boZ3wWnmyABXdvoc7VsB7nln0RwBOr+gwS0zd3FjSqiAFqs+2uJe4iuIm3NKoW5YbOS4
         4rjLLi6gtl8A5UC9IqLU5jMikAjx8DtoKp4Ei/wQano3MlyCek7cvFkfYH14K8EO8dya
         fkb+WloSHY0VIiFrXnYkMdDZy2Z7ataSCOSqqB6lBJ2lNpJXG+Jwfz2PbdmX4439a7Md
         RMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767025112; x=1767629912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBwYFWTz2ztev5/32wN0RyFjZratpdCxrc9vTXfxWms=;
        b=AqRVd0AkGsul08b2ANpKn6euEc+ywtx74XPGTJ8z5R6aVcFGCQRcAKvV2Hub4ezeq4
         dR0gkxzPKbDu/BsLAkOWYaWDPrqs5rxqArrnCole9uCY7dwFsxVf+vv0Yna9TDl0WvSd
         jIOCWy+GlPoByQuw7vJHEVKab24HOxYHda2nZLnHAtr5YEsnb6vAqWDGfdcqvz4LRxNO
         bty5JFpoiSH57Bfd2maiQCuvZVsf5lVmivTqikmuETRKwpWXnKlq2qthz39T0K24ftNT
         W0BJyO2oyIZuyuS3A3UUX0+RKSR0enVlL0LDaQjaGCSIYiA3uUnQGmNEcM4jGgwb/tZc
         z+bw==
X-Forwarded-Encrypted: i=1; AJvYcCVvC2Dvw2tmTBXNbxuvqgAE8NDrZ7bZYE7UtfYcGDJh1cn12vKuqWmELrYIwtLqad/bsHH/jsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+G5wX7VgDB3LDMC1v/0zSV5SVN3lxDaISanQ14VBm7/vahxz
	8XYZ7dqmkXZf2ObgeLoudsUoCxdFOL6Tfzf0oaxSqNb9W7NmcS6/h80qNjCjY8QoWPH62T6NAGc
	bGrMF62DhW6gg2l4OXe31ZVC8UjDlEMcJ34oKgSHU7DIMh5i8YFODAUfiKA==
X-Gm-Gg: AY/fxX4rVrd+EqRGg5DZ7qtKiTx9vDL15VQOQNQYO08c/DnrR4szveX52nM9z8GiM+m
	RWQl4VpO0OxX1CXHUeCAsSuE3oltDMRlKIpArfG3m5W6B6jeoSOiTONLAok/TnUl5KrrBIk232n
	EvBKeHh/fT2GXmaNaXNyGCQHGyiQlpC1Jk3c+WiNBoCv9b0X8iZiYIRI/YPwfLmWwxNgX0V/3ZT
	VA0A0/ul9k41XLuCdFtOKFblPIfVMzCVx34/DUE9ztIwUV7E0OONXxDZD/YYg7/m4KshYiY+1dS
	rdmQagfoGXPYaX72W/YlaczTnW9K9/K6VQ0YZ1wq9pxqJfhicY0U2wU0Lmlvmi0b6/raiSZz5OD
	Tv2ub32l2if8uSQ==
X-Received: by 2002:a05:620a:4495:b0:8b2:e4f7:bfc9 with SMTP id af79cd13be357-8c08f68d65cmr4681222385a.39.1767025112087;
        Mon, 29 Dec 2025 08:18:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL4YkPefaFlF9oEJOQlDE4A2f+ZkX/BhH4h+EP406z+I82ZC78jxtOfgEzLtjkNg6U9tOuug==
X-Received: by 2002:a05:620a:4495:b0:8b2:e4f7:bfc9 with SMTP id af79cd13be357-8c08f68d65cmr4681217485a.39.1767025111532;
        Mon, 29 Dec 2025 08:18:31 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975ef6a7sm2315967085a.55.2025.12.29.08.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 08:18:31 -0800 (PST)
Message-ID: <106d58e5-bf93-4ff8-9c1d-9064847dd892@redhat.com>
Date: Mon, 29 Dec 2025 17:18:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] octeon_ep_vf: avoid compiler and IQ/OQ
 reordering
To: Vimlesh Kumar <vimleshk@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
 Veerasenareddy Burru <vburru@marvell.com>,
 Satananda Burla <sburla@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20251219072955.3048238-1-vimleshk@marvell.com>
 <20251219072955.3048238-3-vimleshk@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251219072955.3048238-3-vimleshk@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 8:29 AM, Vimlesh Kumar wrote:
> Utilize READ_ONCE and WRITE_ONCE APIs for IO queue Tx/Rx
> variable access to prevent compiler optimization and reordering.
> Additionally, ensure IO queue OUT/IN_CNT registers are flushed
> by performing a read-back after writing.

Same question here.

/P


