Return-Path: <netdev+bounces-148452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58F49E1B0B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C66728B311
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25EB1E3DE5;
	Tue,  3 Dec 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcFlMqJe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F21E009A
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225621; cv=none; b=Wxqz7nZ0VSZhAMJ9TLgvLED0257AQMIRUmXtbN+4L+0RT4Kk+QPgK36gJMbnS0TF+dj6J7HUdec99GQioOR03OS3MNbZxyHejScqNjB6W+8TLCMzCTWEWZugGgIm/vSqROSzKZsfMJgE2YKIhBoMy2ia1NhomGgBeAJ2piH/Ws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225621; c=relaxed/simple;
	bh=AHmmkPHjvu7RIKywEf+EAV3LQMeU6/vP4mpQ4B4VTxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVImSW30jL+/9iuGNe/0qkmtkvxrlxstknaruzwvukIuRuO2/2pDjLl9T5zzLnewPPyz78vbvaMfRJ+83tTJNeOafYAnW8iU65mtoR00zZK4aaA3ShWs0h6tve1IPDs00A4nS9jKb/eR0OxvcPV5D1rXmqUe4CX/bbgS5r+xoDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcFlMqJe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733225619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zREU+lwYhiaQLLeLq6O0V37r0ooXMYuGzQk3sQUa+FM=;
	b=EcFlMqJeFGV/mn0p2xgtXEmScexNjCnI91qxteotQYOSJttkmWwM0b++xyS18cbVq0zENz
	JgDMg1Qhq2y8r1fQr7aceVbZO/3y0tmg70vvVwWtRZrIvJsBOmVEYqcm3Cj5KKbV4mQ3+J
	JfkvSjN5nZ42pEs+an48nAGWjJCN1P0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-46V0H8WTP5i87sMpjyPf2g-1; Tue, 03 Dec 2024 06:33:37 -0500
X-MC-Unique: 46V0H8WTP5i87sMpjyPf2g-1
X-Mimecast-MFC-AGG-ID: 46V0H8WTP5i87sMpjyPf2g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d80576abso3110225f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 03:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225616; x=1733830416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zREU+lwYhiaQLLeLq6O0V37r0ooXMYuGzQk3sQUa+FM=;
        b=dq6jrgB2QhFdpnDi9ZUh9wYeokCgjjsK/yaTuwwp3jlTGKtnOBfZFN4+7G6W46LY2i
         dn/JJXIVuYZDvJMyxKiw45CFbahKJPDHMFPs7jOgn5E8NmXnOXugg18xPijPrWciFgqh
         SjbNRHKq9A7AxnY7zgF76FJ222N+d/bWbgDxYW/wIdZTyabcL5oh5eJx1Paon4lHJT85
         jKIKV8NmmUAj5NnTdpH8DSrDiEhuOD2xF5Z8RnO2UQwW2InP81nIv5KgHuZGQviClqqw
         RO/tePqBAnVFv4abXeDSxxgc+DMmgZpio5OMSP7Z+1T7dXTy7uMVIOrQK8SgBkJbu2Ti
         nP+w==
X-Forwarded-Encrypted: i=1; AJvYcCW3rO2XtooTFG6cuJ9xmZ8j8L679EdxfZoueH+WVU+rAqLJbIoyMC+n5dwgjH2zfoASjquDQMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRC16wgIbNklVU7ezjDMU+sZ2siAkV14pJ3Smgb0wYdQFCkAjN
	QAemq9d6zYa85TYczCySot2a5o5eDKhrBCmWS5Mhsz5xYP0JUYKatn5MTUUVswoiUhNCvXWUzT5
	zBamHuoNC98NGzAJ6tWkr43yN5valMa4UDzyOWFyJDF6zidQIfMVdSQ==
X-Gm-Gg: ASbGnctLaa35BqmVztfBfoRSzimvvvmNZoaJqO+WDyOAK5ic+jN2W1BZObVncQ0c9ZZ
	/5jkTirO7uIdiai2vP6SbOmKNcM8tc0gCb3tu/G7QImdPaJ8Lj9IxqwSvAUuDHbJmZkTZjlweWs
	JCulWR7MWRLLxZPFkLGMQFRJ702NU7bJu0mSJX5Eii0D10BM/A0vAss/rf2i9apOsvqq7S8bAdX
	VCVMm2i0c0w5wDttosiJt1j7Fwq533q1c8+H2m1eQTX7cKn5dvJQs5qNH37a2s5lmoHvwXtm1P7
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr2302353f8f.56.1733225616659;
        Tue, 03 Dec 2024 03:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhUjhzZs78Nz7CtLp5MQzYsLnMpSAwzkbqY7OFNZJSdUe3DRiH8XjGzF8cD+LMHI88SBHTyg==
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr2302316f8f.56.1733225616306;
        Tue, 03 Dec 2024 03:33:36 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385fd599b31sm1570921f8f.21.2024.12.03.03.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:33:35 -0800 (PST)
Message-ID: <4c426297-6215-46a4-a9bc-371fb4efe2d1@redhat.com>
Date: Tue, 3 Dec 2024 12:33:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v2] net/smc: Remove unused function
 parameter in __smc_diag_dump
To: manas18244@iiitd.ac.in, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20241202-fix-oops-__smc_diag_dump-v2-1-119736963ba9@iiitd.ac.in>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-fix-oops-__smc_diag_dump-v2-1-119736963ba9@iiitd.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 11:10, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

The signed-off-by tag must include your full name, see:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/submitting-patches.rst#L440

Thanks,

Paolo


