Return-Path: <netdev+bounces-120155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F295875A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5821C20FBC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257A318FDA6;
	Tue, 20 Aug 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wW6meeFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D318FC81
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158274; cv=none; b=fIkA8Id4e17uk1FTStLP5iY152C83I7hsUj72MgMYr512F+qgkHM8OS+ZOQINrls/9/Gjm1+UQ3QEhZBwSKJE2lOxHtcdotT+Wryn361SdO3Noq8HUy4MfaQaosNy3Ov9G5+QT6716hzheFiAWl6V8NL0R19QeCSDdbcIDBuucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158274; c=relaxed/simple;
	bh=6hKhagBBJjQI2SW5tWYvwEixQVJ9tM/nzXa0Cu3Lzns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+SSOpkE2NEpDcz25rEfOxcKNl87dan3uX8caQJqfoM91IIitc+L9PL8qRjOfnTJV/QBMW5xhOJxJ1lYhGA+Jj9jw24zUDqruptonYSvuXe+7jpU3YsVApiH5EgFP71CdN4PNvQolSBZz3jymNHgRi6GYBIqRlE9QbktNy5Voq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wW6meeFv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so395424766b.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724158270; x=1724763070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYcA78G5RhJo7Uos3s8dtpmIaAs2azh93tN9QBu7tds=;
        b=wW6meeFvBK8pAY76Z194ly0iCFsD7mUFH6iot//0Pz1+vL2aldNx7r5i+Mf5Y1lDJO
         2YjV9VpO68n1GS5B8atiwzaky5WazJPH5A0UsHCZs4sq2AADythFKxIzBJMID1mIg/R8
         W8PWjImKSkq8td13ZvOmjGTU2BeVdV4yayFU59FrnwG3Z4nC4FprixccKToq4ngVrq++
         0qKxfGq0NyygnLu1kNBgZvRn7xBjSvxm65D6EZzaQW0wJ0zx8M1JJxApeBsWSVubbswI
         Hiy45UPk4l3vK78IrJY98iK5TbBDRRQcWvDNVkBY3+3KoFOMxeuowUBg0ZyPH4dH3D5H
         syxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158270; x=1724763070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYcA78G5RhJo7Uos3s8dtpmIaAs2azh93tN9QBu7tds=;
        b=vob67tZDwvhYNAGYZPK2OJgQ5YKPfN8m0q8dOA+Kj/LbAgZTeEVWUv6dDX3mWyqOKJ
         orVkWujOg+LurdSbEOtQBrf25Ckviz058XbXQBwJ3vMqAr6swSrA3IdD5Ye9G8rEy+K4
         UFHkY6bwGM3F557pKkDwTPryVUJMShO3XkJ4NIXz/l00L3L+S9SUPv+qmOTWCGPbdSux
         ZGDwJY6pofqIffpLDO4DenSR88UifHLtkEVxhzG8jk/HeMg9RNhQ7fMA0fPYcd73ZIhP
         BErw0+kxtGg3Tu4NxV2nPgmKBPteGJ20FrQmCIAYjPqpxT9GYlOQCvBDjSnjs4rXTXP9
         Qo9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNsXnb4Dh1qXm2A7KlZCLNhJIm5qfSJet7cbd5TO8EljRTewVsPsbWJdukn+rkJEN/vbbKfa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TiTIRoA/jHncks0gy1zMp6RGgVTfpZ7bCiHAilHcC0bseSeH
	et+ocFV+P+1298P9eMPZ1PrZIEYsYQS+oFQhsk/b+vbNI1ASS3pNTLILmJTiRBg=
X-Google-Smtp-Source: AGHT+IHTa06NbX/kCgJascBw6CQ5ajUwd6PH8fTI2ZNrUr0LWfAYkWF3PBQRTnU6zKM08DzlPxRrxA==
X-Received: by 2002:a17:907:9717:b0:a72:6b08:ab24 with SMTP id a640c23a62f3a-a83928a4178mr1099677766b.14.1724158270057;
        Tue, 20 Aug 2024 05:51:10 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfe4csm758097366b.89.2024.08.20.05.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 05:51:09 -0700 (PDT)
Message-ID: <1635feb8-eef2-47ef-bcde-eb55dbde19e5@blackwall.org>
Date: Tue, 20 Aug 2024 15:51:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 1/3] bonding: add common function to check
 ipsec device
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240820004840.510412-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2024 03:48, Hangbin Liu wrote:
> This patch adds a common function to check the status of IPSec devices.
> This function will be useful for future implementations, such as IPSec ESN
> and state offload callbacks.
> 
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   drivers/net/bonding/bond_main.c | 48 ++++++++++++++++++++++++---------
>   1 file changed, 35 insertions(+), 13 deletions(-)
> 

Looks good to me,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



