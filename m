Return-Path: <netdev+bounces-166073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAFFA346E0
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB1D16E9BA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3F73FB3B;
	Thu, 13 Feb 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQr0BAOQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADA15DBBA
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460210; cv=none; b=WksoF3I3Zj3EzwWSxKx8+KEdg7HUPD1rbSpPDGvDGo3saD8k8/0mqP1riDLLDbhCQM7SKTEk5LmmBoHUezFsokD275I9BWiL3URc3H4n481e6yDiBVC4erbiRJZ2JA51sywRm0RqVCeCAieyzbdoxw2p6l/MOoPTXyetn8kBoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460210; c=relaxed/simple;
	bh=nnr4AHIDTiSh+ro1sSaSryEfSwd5H8ZFo1YEnu+rzI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1sKYSEBSH8IIfAkAfBz24dE+O7mAhaF6mmmoDTWxchzbF0i6mb1e+rhGXx0W8gd76mir5o2ylgVMuVBVkfovsSWPBFUyPrXFo72XPoTMYfix/6x53CSiPDqImj79TTrgEQ5tpo9CNWnzVzkVmctjOJfhvPLPzJiPntFyfk7Tqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQr0BAOQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739460208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JRSwFTLcKJvaGUhd7mNWEaWNfTd1j4s92cCD0xMuMs=;
	b=IQr0BAOQK0Ld4jk01ZeFd0gjVK8R9JcmvXcx5nPA7IRxBDUTEDIuFbc4qeCE4Xxvb8Jm+O
	AVcgBVV4IAxSZRBM1ehC1ZKRVbz6gcHkfoIBjBzLUVv2xOiAqq+1cZGnl4N1NJ4hk4uECm
	egv/+i60+MxA8BllyE74T50lrQyPunU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-_pUjKzgjNE-rHjmP2qNAbg-1; Thu, 13 Feb 2025 10:23:27 -0500
X-MC-Unique: _pUjKzgjNE-rHjmP2qNAbg-1
X-Mimecast-MFC-AGG-ID: _pUjKzgjNE-rHjmP2qNAbg_1739460206
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438e180821aso5432015e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460204; x=1740065004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JRSwFTLcKJvaGUhd7mNWEaWNfTd1j4s92cCD0xMuMs=;
        b=ckld5d7YB96TkfG+vJHwdmV8tMSIt42dcpSP7Y9YWjgpiUk7gegX+Unw0X2x7jIeTL
         9JlkfD7PS/d81N3kQVWZL16yH2GATLc3KJ/NtvE4ZaKpr3oGB1Sq2cnHhCLUAZGHqWeR
         58YJEeJ72yKR2eSMw0hlYSS++Z5fVqMtCIFUhobVJ6X3i+zBDYN1msW0UF/EWkG29wNB
         uFjHkKyIc9nfS6e3Yi1YhE3eNfX3mdjCuX2s+smQOQ+CQPn4ZzG9/9EmhIY9R/lyTNBn
         ztAzCnawiOMYW6pqIkfb08ruwjUQxdbB3RifQM2t4Hvt5Y87PBxD5LgdwRz8zvqUxwMA
         gbLg==
X-Forwarded-Encrypted: i=1; AJvYcCUjX6XTBX7Mb5do9tZi+OpP33jjKghqp1HlkxhXvshh4f5No2pxjnC9aBeaWaYdDJwHKcXj8uA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4gNiF8KjkPwjHBmUmYvYG4vB4bqW6sekkRSB7rMsO8SiaFkl
	qkMQYXeFSFzgmrLU6MoPpVMYmClgGUTtz+j5DPKpJxtVBw/HPZ8/5DcXhPuJx0Crr3br1h1qOWG
	+lAxn9WZxZ9k8qd/0jfoOVL142vgsRvNxPvKNXYCuB8Y4eIyHqw40eg==
X-Gm-Gg: ASbGncu3ekN8iorY5JIW4eTn0C8PW8WozvE+xfFeASs4Fo9Ip9K3idhaaLFkK5+UGi1
	a2BurncC+Z+Bh3XEB3Xz1B8ikHhbVPZI0xIPFLNmPDxNwSKLR+PCF4maYzv+3T0P+bO/JQrhCSp
	E/zUkvNLH5z+ORlM8otQvNMldT/2Wsgb3K7qJZXkdZcsorqzKQaXuOJ5sCLWXj19Nol/raFUbsj
	SrrtzZQJpCY2rtM8nEuvYl9nuJdpuiii5QEniv0m4l1ihVzyh6q9axazcy+fMTPdiqR9HCAGBob
	61Rrxq8s9oCiCB+zdD79gltcLzCzocLJdPc=
X-Received: by 2002:a05:600c:3485:b0:439:4a1f:cf8b with SMTP id 5b1f17b1804b1-439600fd7dfmr54743585e9.0.1739460204561;
        Thu, 13 Feb 2025 07:23:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGymZURXlriQ+0kCVr74FRJDVtnnFD1vedc8hYAtNzuqdxLQ8CZrwzTUv5N0m6aIs3OGJqbiw==
X-Received: by 2002:a05:600c:3485:b0:439:4a1f:cf8b with SMTP id 5b1f17b1804b1-439600fd7dfmr54743035e9.0.1739460204161;
        Thu, 13 Feb 2025 07:23:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5655sm2157953f8f.77.2025.02.13.07.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:23:23 -0800 (PST)
Message-ID: <6032f70f-4609-46d7-bbfa-c29a63f402ec@redhat.com>
Date: Thu, 13 Feb 2025 16:23:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ethernet: mediatek: add EEE support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20250210125246.1950142-1-dqfext@gmail.com>
 <a42ec2d4-2e4f-4d1d-b204-b637c1106690@redhat.com>
 <Z623GQHI_FHyDyjE@shell.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z623GQHI_FHyDyjE@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 10:10 AM, Russell King (Oracle) wrote:
> On Thu, Feb 13, 2025 at 10:04:50AM +0100, Paolo Abeni wrote:
>> On 2/10/25 1:52 PM, Qingfang Deng wrote:
>>> Add EEE support to MediaTek SoC Ethernet. The register fields are
>>> similar to the ones in MT7531, except that the LPI threshold is in
>>> milliseconds.
>>>
>>> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
>>
>> @Felix, @Sean, @Lorenzo: could you please have a look?
> 
> That would be a waste of time, because it's implementing the "old way"
> including using phy_init_eee() which Andrew wants to get rid of. It
> should be using phylink's EEE management.
> 
> The patches for the mt753x driver converting that over have now been
> apparently merged last night according to patchwork into net-next, but
> something's gone wrong because there's no updates to the git trees
> on korg,

this series:

https://lore.kernel.org/all/Z6nWujbjxlkzK_3P@shell.armlinux.org.uk/

is in net-next commit 443b5ca4d7245eec9a9192461113a4c341e441e5.

In the past few days there has been a few slowdowns in the kernel infra.
Perhaps some mirror or cache not updated?

Cheers,

Paolo


