Return-Path: <netdev+bounces-143238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0A9C1857
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 09:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DACC0B23EE8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06921DE4D9;
	Fri,  8 Nov 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoDksDiT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA491494D4
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055716; cv=none; b=Z99DLohPGbIuGv0NAqOwIlN29+Esuen6TjZyWmeZjFYH4fomLqeX1Rso6e4CRt8pkWiaw5q7WZsXjxnLXMG7gQDXMormDMPT7FGcg6TohsDv/TXUXKXKtYmHoXAqK5xSe/5OZzrhbNVbdrbbTBy5oRIzEb68Dk3l5AXEPYFH5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055716; c=relaxed/simple;
	bh=QUMslSd5+7vmPhBvFqJFbLH0QvtylNmBG3Rd0BiAc18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWaiF31Ce+m6BkKEiw/J70e1stKWdWYZZRogJXZvyKNA4UGIfn/Gn5Zaq12pbrijsGBMqdaIHKcmPV7+90mQtDY+3JQjtm27mHB1oz8DPn1+PNU+hpHYP3w9xAdqH7he9SF8k8QydbOiORnKOezsQTQMLUbl+LF5d7qm5KDAYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoDksDiT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731055713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYHTkptT6ou5l6p02xIsQwxrcvbgxf99D1myY1C6iho=;
	b=eoDksDiTMrS+Y/EdWSDerGzEvHv4ZEuL3wz7WO0ZvjPNqeSPJitRJ8YGuHSUZYTFhm1HuZ
	gfw+l4kP1EbIFpCsyRnbtklw8dCJ+3RaHA7gt3Jk9EkMwu9AcsvMiLf340yG+zma8zglAF
	k+8SCK9UIZrB0LiH6atuz7xpHReeM1w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-MKjjXklsOfejzu4XP-XI1Q-1; Fri, 08 Nov 2024 03:48:31 -0500
X-MC-Unique: MKjjXklsOfejzu4XP-XI1Q-1
X-Mimecast-MFC-AGG-ID: MKjjXklsOfejzu4XP-XI1Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d462b64e3so977059f8f.3
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 00:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055710; x=1731660510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYHTkptT6ou5l6p02xIsQwxrcvbgxf99D1myY1C6iho=;
        b=LRE9pixBt3P91wx7G7QuU4pB2VvIyAeoE2nnBGIq6oN0AEJmhQXSXI0ch90yTx1pjr
         SpU2V/CRnrtoFQ5VmX4gMuZ4Qxi2oqrhYwV96lok80CjgzDytqXaL5k+mtpBfQI43BAb
         l+6KarXoE9Ol/vU9LFzEfcF1D7rS+bJNQry9phnZp7oFVC0t8/f/AR6tu7LJlbuHFHPO
         /YZJrn+NbQji3R3ta/IdeOuX9D3NK8x8Fm1AmWfCL9bO/RO4jhbSHbskY0vsqEn7DXqw
         bCQk17bJsb6cDLyAE8XisC6DwvUQO+2aQgJ9DrKgTlV3Sm0fj3VPp3oMkep5FgB5OQQR
         vgmw==
X-Forwarded-Encrypted: i=1; AJvYcCUtkMDalw+zZmJ3d5tbH4170gDdIUYw0/8ljgm2MY48wo35jIlv2rqsB5+dTA9Gd64nY/1WlIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWL9nrKd2H2pbfOhTGIvwbc2TrVoM0ertGeOjIEIezfbZF8ma6
	2LU1JhBMiS16dZsLMBaTheHd/YekWOcnzeonO9bVm7On49W6O/rTAmjPk2tRiTgnVitiMfCpD+t
	1W/l/Zr4mhJAEaaFgf0PAnWgWWPsmcvTshJJQSHMkBpiAioJatI5ptw==
X-Received: by 2002:a05:6000:1548:b0:381:eb8a:7ddd with SMTP id ffacd0b85a97d-381f1866989mr1759293f8f.15.1731055710715;
        Fri, 08 Nov 2024 00:48:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIaAbzDhaCkwg/UVIfjicTfoiBdfShUzYxSOC6+qJlzAeZo1U91jzrukrCO0X0SBMgRzrjVg==
X-Received: by 2002:a05:6000:1548:b0:381:eb8a:7ddd with SMTP id ffacd0b85a97d-381f1866989mr1759271f8f.15.1731055710387;
        Fri, 08 Nov 2024 00:48:30 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9f8f0asm4046400f8f.79.2024.11.08.00.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 00:48:29 -0800 (PST)
Message-ID: <54bbccb2-6633-4638-9dce-14683b4e320b@redhat.com>
Date: Fri, 8 Nov 2024 09:48:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ppp: remove ppp->closing check
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241104092434.2677-1-dqfext@gmail.com>
 <7e0df321-e297-4d32-aac5-a885de906ad5@redhat.com>
 <CALW65jaKn7HQth6oYYHWYvg7CTZJj2QH66nHyo41BNjAA15Y7g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALW65jaKn7HQth6oYYHWYvg7CTZJj2QH66nHyo41BNjAA15Y7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/8/24 07:09, Qingfang Deng wrote:
> On Thu, Nov 7, 2024 at 8:08 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 11/4/24 10:24, Qingfang Deng wrote:
>>> ppp->closing was used to test if an interface is closing down. But upon
>>> .ndo_uninit() where ppp->closing is set to 1, dev_close() is already
>>> called to bring down an interface and a synchronize_net() guarantees
>>> that no pending TX/RX can take place, so the check is unnecessary.
>>> Remove the check.
>>
>> I'm unsure we can remote such check. The TX callback can be triggered
>> even from a write on the controlling file, and it looks like such file
>> will be untouched by uninit.
> 
> ppp_release (when the file is closed) calls unregister_netdevice, and
> no more writes can happen after that.

AFAICS the device can be deleted even without closing the file, via
netlink or deleting the namespace. In such cases, AFAICS, the file is
still alive.

In any case we need a more solid explanation describing why the change
is safe (and possibly a test-case deleting the device in different ways).

/P


