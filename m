Return-Path: <netdev+bounces-105139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B099A90FCD1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CE41C237A6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7903B2A2;
	Thu, 20 Jun 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7RcozC1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E811CA1
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865451; cv=none; b=ZLd2v+c5VFcolbrF+ynFhi6FVpA/cE8PqKFfjbsOLHONb7Zu9dORrvSEbkek0P5zR0rXDb8dzuGQ9W4Q6+cxGMxLr1fEqpdmEFyRVXwgTW/fj9oZIiO0b55Z2PtPig80hrQUTVpCRqcgLEA/mMuTAQ4+yMaizSMuZ45Tt2uT4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865451; c=relaxed/simple;
	bh=rOLHd1YxVG8D9uSHJC6UT+rQKSOC8uixPMR6QVeFq2I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nSGU1/MPIOB3V0Wjr78Iif/JC2xb7RCLGVEyjfNsD40RUGmrZQ8wN2M0gRKvmdMCc0sUb8IzZxW37emZFLaW+u+u8SrEGLPinUwDikK9k5y2eN/9WbaUvh2LMCgRwK4Ij48l1L4VxtoA9qAVjguETl1KTQVavFKH4GFPgxhPaXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7RcozC1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421a1b834acso5032665e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 23:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718865449; x=1719470249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVKKZjPIeTPBpzw0RGLHThVhNhA0wk9KLXZTLPxQPCA=;
        b=I7RcozC1XOtqrJm4IpGydVi6FFagMd18J1OnyjEJQf6Q56ma1h37kiVWW6UQzFdhpW
         OB7IVr5HFP3mdXbJKJpw/ki4ZtD0mOIx4ZytABGxWorUo9YE77bNbi8Pj5tHyTfnCLfw
         GNClYpLjM0Kwq5T3Sdze3egksmq8KdFTZk9hxk7ZozClZih58JlvEBN2KQOjROD2FAFw
         5UEUUaYrWcMag21+s8b4Hk6rRuZ6/H1AV91d+i7puJjMI8Tvdk4VtRMKHdsYb79geuJL
         depdFGVYSdsrSdaBO+IUm3ZlZ4b27+Qmhfl+v8bFbVfWakktDKFyq57ztykywHAOgMO4
         vJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865449; x=1719470249;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVKKZjPIeTPBpzw0RGLHThVhNhA0wk9KLXZTLPxQPCA=;
        b=OJYm/lz60VdFpVCeK882hAb0bQRQsTBs/4UXeSZdg+Jephjv+g2gkBbzFn+oLMd8Wi
         TqjjBTQFuwO5Qb+gglR5ShntTp+23qRaUeeQUZ4Wrtx6WGxXM8eXr+vJzgfDdTmPGDVN
         h/Ry4tNIX7pKO4Zpwf0kmGoYYkZeFUdbAugWr2WzHIKqE7VMpQNcSrHG4hcOb7qYE2I/
         Y3rrk1VWXSaRkm0QCdqAGgbzTdBdYDuWmy+Ie6GgaaQHl5eXwIFtR6tQDxHy2mhzLRLc
         W13JXhV9XMLVuSCcUksB5892P3+v0TnUOPKbOLJRcllBvrle49LJK825iYk5bSm5s9FE
         LvUA==
X-Forwarded-Encrypted: i=1; AJvYcCXv8eJHsSvIdgBwaF2ScQHkmWiC58lZ+s5HcCrGUI7xHVTw1M+oA4y7JWRTjiJQhguUlsKpxh1555GZSRZU8Y271BSI13Rh
X-Gm-Message-State: AOJu0YwCYCT+aKyCRVL5nck1dzco/prYT8m387+WsonwDLycQ2dsrJmX
	0HsmyY2Rr7FR4l6jrk7HXjTIMhRi+PSvWmGxbloTr8o3FMZrBW5v
X-Google-Smtp-Source: AGHT+IFINaEtgLaAdA3xCU2wcCf/tuGSYa7Md1gprzOtt5FrFMoAgsAXQ5BspQ92JeBlP8vg++/0oQ==
X-Received: by 2002:a05:600c:4896:b0:421:d8d4:75e3 with SMTP id 5b1f17b1804b1-4247529bcd9mr25099825e9.40.1718865448492;
        Wed, 19 Jun 2024 23:37:28 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b8de5sm13573485e9.10.2024.06.19.23.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:37:28 -0700 (PDT)
Subject: Re: [PATCH v6 net-next 3/9] net: ethtool: record custom RSS contexts
 in the XArray
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
 <e5b4739cd6b2d3324b5c639fa9006f94fc03c255.1718862050.git.ecree.xilinx@gmail.com>
 <ca867437-1533-49d6-a25b-6058e2ee0635@intel.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <08a85083-8c61-8ca5-e860-2b051c043229@gmail.com>
Date: Thu, 20 Jun 2024 07:37:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ca867437-1533-49d6-a25b-6058e2ee0635@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 20/06/2024 07:32, Przemek Kitszel wrote:
> On 6/20/24 07:47, edward.cree@amd.com wrote:
>> From: Edward Cree <ecree.xilinx@gmail.com>
>>
>> Since drivers are still choosing the context IDs, we have to force the
>>   XArray to use the ID they've chosen rather than picking one ourselves,
>>   and handle the case where they give us an ID that's already in use.
> 
> Q: This is a new API, perhaps you could force adopters to convert to
> not choosing ID and switching to allocated one?

Yes, that's exactly what the next patch (#4) does, when it introduces
 the new API.

