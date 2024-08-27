Return-Path: <netdev+bounces-122314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB924960B27
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1F31C22EEA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9C01BC07A;
	Tue, 27 Aug 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIP/uP8+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193411BA875
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763300; cv=none; b=MfgkYrBvQ0zchLQf9v09Ew0AmSZQ2NltBQDJ3HnYR9msFF37IPbGERKZK8W3vHrFJshTQMgapcg9MBZWVACn3/cDK5zy1hQrvoHFiVTuh0wNvYxN808g81xTEO78SqXInHwhOVmAjduXqVNqmR8ssjndVdb1F2tmPoha/nsDuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763300; c=relaxed/simple;
	bh=6Vea7Snn1Uz5kG+HRqv1WOYzVme5HarUsJsA6T/n0/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+roRMIoce4AyWJtHBBLgj7ric9a5EusBt8T1GiKSh2CdBek6ssagcW5dA0GSUyTMeSdKoGX+8Q3PUmEA8MW+mnnRpzCoJctY4TkqhplQwr7PzMwsNrXm8/kokhE+wN3RpcsYXrsZRgIC1/k4ETg4yHQhKsimiC/7zuVi8oAiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIP/uP8+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724763298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvhPKPj5fM87oEo5FNslIVul+ObBq1WAlqgHhDt1NF8=;
	b=FIP/uP8+qkDMtbz4A2xbwohp1yVEHNIr1YHmjV0fSc0HLtZau+Y/ZuTvnxASdzYjC5IMX7
	cFLqMMEJsG4gXxxxiG7ADjTc1BNZN8MSDJJUBHPdpTMdhMcv0jT5qijOgoKz041p8FRUcs
	JtSXQpWuDnUasKmQnMFdS/njMR8JB2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-_74VTNflOOW-2Ay-o2Wdlg-1; Tue, 27 Aug 2024 08:54:56 -0400
X-MC-Unique: _74VTNflOOW-2Ay-o2Wdlg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42816aacabcso48233345e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763295; x=1725368095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvhPKPj5fM87oEo5FNslIVul+ObBq1WAlqgHhDt1NF8=;
        b=ps31e1OrHgE6Uq15KYTyVIQ+NfxfFwP6xUmIJK2NSUte50Qbr03w3tSExAo7+uXuSk
         hTMjfOlA1G/tm2mFqNoOqzr4IX+RIVoA6gNc1grH4TDIVoACD3XTDSI3QeXfpf/WErUP
         WCy/4KkNAKIQBBU9W/3XguRBQjtWTdLIj0Oxmx/JVbKWdPQdAcEouxPpoj+DIshcqB2h
         INPwEHrMCuc774hnZpNPj0bVDD+VQCdbtSil1DskP8ekq+oSzM1NH8zQE47iVLvTa0Sy
         Ba4cK8v6WlB+rKGM3D1OKxKqfca06VbFqs333I6nsoTC5ptKYwzDXwmwGj8kZ0tigE5/
         ZAig==
X-Gm-Message-State: AOJu0YzhDETlcG5EfeKoRKHumrGJo8M33uBI7/z5W4B7oC7gXGFwWg4q
	Q1AjxSeZEgDAAad7vAkh5zNrRvoasQ9WAxBtH7LDz743BnepSTAaPoArPA+aQCKk5z8MSMH3dqE
	C4bWJvov0GK7Soo0Yijc888vHBbkHXbeZF5lteH/YK8lxK04fVIYblisPfEvVhtoD
X-Received: by 2002:a05:600c:1906:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42acca0228fmr90411305e9.31.1724763295106;
        Tue, 27 Aug 2024 05:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcKzocLFfj1Zx6zpPCdu24ks+pENOx15zFAnOfiJhwTIujoyYSZJ76haH2DnJIoNowgxjnEg==
X-Received: by 2002:a05:600c:1906:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42acca0228fmr90411045e9.31.1724763294667;
        Tue, 27 Aug 2024 05:54:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37307c0c9c7sm13213393f8f.0.2024.08.27.05.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 05:54:54 -0700 (PDT)
Message-ID: <36f312eb-150e-4497-84f0-6bfbaab16d9b@redhat.com>
Date: Tue, 27 Aug 2024 14:54:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: microchip: Use standard regmap locking
To: Mark Brown <broonie@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240822-net-dsa-microchip-regmap-locking-v1-1-d557073b883c@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822-net-dsa-microchip-regmap-locking-v1-1-d557073b883c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 21:53, Mark Brown wrote:
> For unclear reasons the ksz drivers use custom regmap locking which is
> simply a wrapper around a standard mutex. 

According to the commit introducing such lock, 
013572a236ef53cbd1e315e0acf2ee632cc816d4
the ksz driver family one regmap per register width (8/16/32), accessing 
the same set of registers.

The locking implemented with the code removed here allows serializing 
operations using different register widths.

Thanks,

Paolo


