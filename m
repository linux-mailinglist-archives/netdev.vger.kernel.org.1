Return-Path: <netdev+bounces-191808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B958DABD56F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF6E7A62B3
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B6A2741BE;
	Tue, 20 May 2025 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZcWgcbn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67326A0BD
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737939; cv=none; b=fR4xRcM8WQ8OsNwQZefv5CA7BU/S86x3mGvCpiEZqdQV9IHQao4KMtn12cjj/wEToVuwfZtE4ebZWTYrLMlvDltDFIX6pTo1TCZdEpJODw6WJlRHbJyGJQSbJVlQFBEtQeBrhCU6Lcesh4abivque0rnjFAlwgDdFc0DyQcGx14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737939; c=relaxed/simple;
	bh=ePwGN8Y0DoVX2g4Ip/ZOdJELBN6I3uKulMoa73KDies=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0DM365h9W3OJuOKPwvqeBe1IlwYYckvgzH0bgdi9DmbmCpVkzHL6ZXDqQ9O12/G2IKp07Zn8inUR9ypwfjeVPmQ+ZIS7v1sUw3qvi50Nd4PZUcN8F2TR0E9f8oLuX/RnbuAstUlNTPPdIfNESheT+xcWLgl0XzCnNGH4VFgbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZcWgcbn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747737936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPuN31vyRfCiT58hBpDg3337QXG1/M78UWgajMt94ic=;
	b=JZcWgcbnZtHC4ymgbtSbpeBWkd8fIbWWvfFBx7aRG3L/V126i1pQQKJMxyhRdrbDcPydIa
	7MIMSjyuDsTRK1pJKqlF/ulR8YWmMrOCKK3AtqvJ1v/h91Mq4XPME7pHYl4Lyn4aUmBTy7
	ExygndPz25fqusteHSuSuiogeVnaIh0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-ke0MhAjXPHG9Fe-wPfenWw-1; Tue, 20 May 2025 06:45:35 -0400
X-MC-Unique: ke0MhAjXPHG9Fe-wPfenWw-1
X-Mimecast-MFC-AGG-ID: ke0MhAjXPHG9Fe-wPfenWw_1747737934
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-445135eb689so17056265e9.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 03:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747737934; x=1748342734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPuN31vyRfCiT58hBpDg3337QXG1/M78UWgajMt94ic=;
        b=q7esbAtaRCzr6zI+3/zzBRQ03UX8eoNDLqO4ElEsyFeh0DjcpOZ0PRDqzSFe33vMwS
         KxrNp1UaNz3eQc3zQbyWNUOi+BAPW7jkfKy5tNWFVzUEoWjyepulYKWUj1lzoigSuU/7
         w5xTcvmzTcPqLy3lXTcUYxVGwpwdviAl+vkGh80l0OA4q2dju/kqjcfnT5tTY63nsHdB
         8qdnYQOBW3yNhoZz6mQHneR7v61fQHeh+zzXbcf1uAce7+TKrVCSqZ37x/kg4HtPYpDJ
         J/XakiTsK7glc1Dsq9JRO8m05Ku1nEN0/S33lPFkaRWyWL3wVaxpU86BWnK/8EoP2f60
         NLgA==
X-Gm-Message-State: AOJu0YwKVbtYiNuNyfMQIlxTsN9gUvBp3MlN6ufKnZ+5iXTaNdPaPQ4z
	Jv0vy/J0f8pYmri/wTAOQGYT7X+FtZjbjJNAjaT+nNTa2yvlx3bQ2V7Jk5iLHX7fTf4Xvt40Sa6
	k33tbAOgQc4Fi828bG3hEF0K/gcDc4txQoXAXx8f7HOQMrtcpZwLvhpVS+g==
X-Gm-Gg: ASbGncvi8MDdiy529v8n+vC+kjvVE5Xm79zUotY0mdCcjRn9A6C6lSBHIXjLKi3FueI
	+s849jPFOVX6hHWLNYjbc7UneOApLb5nK+7gWoTj6e1oTpz+UElOIv/KHFjHfeACUqSCMOUkNrB
	N3p8GKPTQ7isqA1/yoVUu2clH4XCixiuBO0XnKLOeQxBja5Sqax3xUMAkjcbzptYqmWgPmxYO0W
	+LsJVVVM6hr6pQEIYbd9xrigCQAvIthNydVFwZcw3pcYdaLj0QN6HDvKD8tu4k3PdCTDFZukdKA
	E8SktX7Mgi3F7HuXy9u8biUdehp/ERO2qQj500EH7Sdg6NCwGdv6+JrqdNI=
X-Received: by 2002:a05:600c:8708:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-442fd64e42fmr145346275e9.19.1747737933931;
        Tue, 20 May 2025 03:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4vsKazWhWOtZ5YAuO9jE6ISOk2Hn1wNIGdDi6mnADkPRQF8doWmBPgi/SdcCWNIJwqDy3IA==
X-Received: by 2002:a05:600c:8708:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-442fd64e42fmr145346025e9.19.1747737933559;
        Tue, 20 May 2025 03:45:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0ac6sm26467505e9.15.2025.05.20.03.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:45:33 -0700 (PDT)
Message-ID: <914ef57a-7c22-448c-b9a3-0580e5311102@redhat.com>
Date: Tue, 20 May 2025 12:45:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: move
 mdiobus_setup_mdiodev_from_board_info to mdio_bus_provider.c
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <de5f64cb-1d9f-414e-b506-c924dd9f951d@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <de5f64cb-1d9f-414e-b506-c924dd9f951d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 10:11 PM, Heiner Kallweit wrote:
> Move mdiobus_setup_mdiodev_from_board_info() to mdio_bus_provider.c.
> Benefits are:
> - The function doesn't have to be exported any longer and can be made
>   static.
> - We can call mdiobus_create_device() directly instead of passing it
>   as a callback.
> 
> Only drawback is that now list and mutex have to be exported.

... so the total exports count actually increases, and I personally
think that exporting a function is preferable to exporting a variable.

@Andrew, Russell: WDYT?

Thanks,

Paolo


