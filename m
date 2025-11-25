Return-Path: <netdev+bounces-241538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A8FC85693
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6620B34E02E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB9F32548C;
	Tue, 25 Nov 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvuktbP2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYh6bBEb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040312D7D42
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080790; cv=none; b=HZEgmlHq3LG7i062yKJPDu/FolSr8SlTMOKjZlnEVpY3JLYRQapv/64ey72gAKDE9DngYL13xSChY8AUehdTm5NGfw0AZjR9j8aAjvgcBLZI/U0HBr5nWBUg9UWuMzCBow1uQCjTDntsfeBwVdOu1wd+Jb9e8ffnPs2xHpe3csw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080790; c=relaxed/simple;
	bh=U5u6saZn2iTIpVEynp6gDRuhzzrTr4z4UIohxHUoVDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=az146jUFgr4TRMifHcVPVoYB8aof665euTPpPBo4RnJU86C3qrn433Fs8RSKuSeg1FrbkAweX5W0FruLEptBJeQW4WATZlFJvlP+rKaJqSYe1vofdjy2kEgYBJeGKKscANNJ9eSz9C5sqDoPshKw3Qx4WZAPgWaUW/3k2/I/Hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvuktbP2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYh6bBEb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764080787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5u6saZn2iTIpVEynp6gDRuhzzrTr4z4UIohxHUoVDk=;
	b=gvuktbP2m+38dDRqfQlkfxhW+qPScXIaYtoQgtESBSu4LCcJkIYhe+6q5QBBpsG4QeyF/I
	+vdJ+4EzpJIlI6s3S5AIbP31B47j8Pk1iXC6W7sAbN1zmwz6hWMbx6mNuEujvGhNVbs67Z
	dJ6/rTqXzFUrPUbs9Yq5Z/8wYFfOCFg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-avoRfvcMO-SMOicavHx4JA-1; Tue, 25 Nov 2025 09:26:26 -0500
X-MC-Unique: avoRfvcMO-SMOicavHx4JA-1
X-Mimecast-MFC-AGG-ID: avoRfvcMO-SMOicavHx4JA_1764080786
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47799717212so43628405e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764080785; x=1764685585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5u6saZn2iTIpVEynp6gDRuhzzrTr4z4UIohxHUoVDk=;
        b=BYh6bBEbPFM8J5DAMYEKVWbOt7U+JC49lvPl9sR2AcRPD5o2uW1l5jF8tC2Ogn5sKc
         gejaHdRHshYKfxcq/9YjW3lVFE30ZV69zYAg5fyb4552y6d4hdbRtXlCigxEmOCScFyQ
         VT8kscu2NgWYjlpsibg4PuVqfW1UV+JZFHCg2HP1+arL3qjCtbcuuSiju7Tk6rOFCMbb
         mMXpT0pHHP3Q4ibyPYHoE+sOuSh/N7uuRuUc1U2XgOBkIiOBPcdAPoGnJPqw6uyEedHq
         DPQgJZv1R6rZ53JE8ltDZ29GV18M74eXLHQEhD10If0pO1v2srkx5fJpmXVBzhIPtmd7
         8c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080785; x=1764685585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5u6saZn2iTIpVEynp6gDRuhzzrTr4z4UIohxHUoVDk=;
        b=gOvQZLH2zq865C12t1rnV/b0uEWAW0fTAdId/OruPFnSZweBwZYJ9kyvcpNv6xM7QD
         Sugji2qMvJZndcXENxuKKsb3LAclujVL8YajjIHy8zhCbwqrC959wNQQGGVJYp750o+O
         hSOjdIKHjtc08Rc+O4Obli0m2nt3MOTgzcOtHdbcnFCWvzW7p23ZzP/uBjeo3JyuysCt
         kXYPuDVX1hkuig+LQOdcjn9uY27bwqKRM/P4LnQ8G1BysDbAQrn20xCXv7vAlar2DxTw
         ZBTAWFxTgDFVTIhiqqgETKIJAIPzZ3KMHe5seKw81RGmvn2lskZ/yigPHoPN9O2qAWHk
         YObg==
X-Forwarded-Encrypted: i=1; AJvYcCVcf1Q1rY22F6OJBGCARZbEGuUOAXFPYKMCudhgg2T/x/3seA/z6kGs8NLmKIvB27Pr07tOYDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Boq6ahjiSvgicOz//eEbbS7mWVIN0p3seimxwuEV4jURSAZK
	9zOswb8yiOAZDee3qHBxtVXAz2l63wxd3zdhz/z3vGAPI74bFx3oLKHddF3Ih3xHVLmzqhAIm3i
	DsIC7L77CHH0VeFoqAYOOmuVjkxim2t8qxbGaXBSXmSkVhybxFe9gEuNoHL4XDF7uVQ==
X-Gm-Gg: ASbGncuHqgmvI2bcQLcGOE7dAlY1dNCK60GoIzhCsVgxwYy0+bJ1vtL4y2zPp/rajSb
	DrKNnFjq9luR0X7PbDwDshQw4u5PzEg5jZRVlRAiT4a8Y1vAxzX1F1I6o/5tToBoPeW5ejzqsRn
	03maCvZ6xVXYUC1rc71cJVx9DazzMGw/NROOEuiwGibnJoy/qvIm1ifr89Bor0/nPRn4llmqH3Y
	xLUFmVLEt9ZvWpWb2d/mpRWoeD5I+vx8PqRM8KQZMkqUMCFzXeaWjsJcrMcknnlLQ6cJe14NpUK
	r3v3AF2zRMM9CjtGvGTFBJiv/3A1RvUW/8Y8lYgEo6cjsZ3csntvBfPZ0HqoM6iVr35HWnjpVlZ
	N/a3h8OD7yV0n4g==
X-Received: by 2002:a05:600c:3590:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-477c104fc20mr195497525e9.0.1764080785115;
        Tue, 25 Nov 2025 06:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZaXfPVxOtd161tPfaP0p6wFtwkV3+ZR42m4+eNaUmo7DrGyyx5OQkx0VodjapltytgGteDQ==
X-Received: by 2002:a05:600c:3590:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-477c104fc20mr195497055e9.0.1764080784670;
        Tue, 25 Nov 2025 06:26:24 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040a9cf4sm21155365e9.1.2025.11.25.06.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 06:26:24 -0800 (PST)
Message-ID: <12d4a794-24f4-4201-8671-38851edb7942@redhat.com>
Date: Tue, 25 Nov 2025 15:26:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/12] ipvlan: Don't allow children to use IPs of
 main
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>, Xiao Liang <shaw.leon@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Julian Vetter <julian@outer-limits.org>,
 Ido Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Etienne Champetier <champetier.etienne@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-8-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251120174949.3827500-8-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
> Remember all ip-addresses on main iface and check
> in ipvlan_addr_busy() that addr is not used on main.

Why?

Why using in_dev_for_each_ifa_rcu()/in6_dev->addr_list is not good enough?

Note that IP addtion on the main interface can race with
ipvlan_addr_busy() even with the code you are proposing.

/P


