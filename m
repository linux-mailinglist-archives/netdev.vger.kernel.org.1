Return-Path: <netdev+bounces-156581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC4A071A4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551EE3A5C5D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BBE2153CE;
	Thu,  9 Jan 2025 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFOQmSTz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7112594BA
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415462; cv=none; b=Veo7l7Fwsmv65z6jPR166Nj8IWmw0iE0BsnaD6zgocfQcWUp/I2vpLYxTi39yNF/OM9QT613od273xm2BYqYwyUVrzJK7lIDxAGtrlUT6jV5ALP9d77GjVcTiC3IJnzfoC+vHq/SbpI+jXI7ziKJUU1ieWm8bmrRvElZmTrbsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415462; c=relaxed/simple;
	bh=fU8s7w7K7tvNKOVFFKMzVGMmQWFxUprl9XPXzD7hEBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVOGT3r5XFAoQgOsd+Rl5vBXhI8g0nNhH65s19zogQJnfHm/wIy9wKowx+ggM9YyajmQIJDgHkdm52ArZko9Xz7CC8s6uoFkj3XVA3FS4iLyksihy805uPA4R+unoRu+4/cyZPzjvh7bZfqvB45HrDdAzR1kmyiCfJ/MYPDApCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFOQmSTz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736415459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlguHxDSv6f2kjam2JyYQgfvVb9DaN2aNRpw2oQi+Nc=;
	b=AFOQmSTz7/A8IlVZytHZ0Dhy7TskflXSK/T9F9r8LVEAhlhhCSfij4ChApqt4aWOI35b+E
	9Ovc9l8qpIH2/iKCrxFAPmYz2b1j40pR09uGrMm1PTmBtQK+smOZKPTHzrcchlzsvWywZS
	4oZTwJuw3Y8ksPHL9byn+RB68/c/T08=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-wNypPUEcOIyl5Dbehzb_jA-1; Thu, 09 Jan 2025 04:37:38 -0500
X-MC-Unique: wNypPUEcOIyl5Dbehzb_jA-1
X-Mimecast-MFC-AGG-ID: wNypPUEcOIyl5Dbehzb_jA
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e178d4f8so121899785a.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 01:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736415457; x=1737020257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlguHxDSv6f2kjam2JyYQgfvVb9DaN2aNRpw2oQi+Nc=;
        b=C38HLaQm8yP7DEOOlDbVazV5Vdaozee3GAPaAmNjkoVb5h+7Msg7730SgCTcBNYBSc
         T71cwRvGSgDI41BOAIOrrb9hP0PL0bUP2XG6ZDSawe7zjL4XwruAJKeaFVLSDhHcm9LY
         G2D7iDYNpFxAQKoA0XkdB9DfrgEcZP0xEXBpbOOuo8xY+62YsTLx1Hyj3LTn4e8E2NfL
         hULqHQmthkFHVIzJY35F9qmbxXO+bsiYB1m8lwhtWFyoOthyy/TxlwAecAIKFV8GVuFp
         aVX29GQhYnvWz+j8AvbIJAXvSyVCzqqBIbcDb2NFdhu3U7z2/GclnkuBGc2XfijqAbla
         /awQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIxKIUKWuejk11hMFhmy0FXd8I++S6Svdq0dnGoLWqCY9y0C6Vk2bnmxTZF3N8eWuLgxPpiQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoopZDKdASplUX0Lm6NTSv7L64HEEaxL7ZT01NN7YdXSX1PLat
	14gtNU7qk2xZBL8XCgDzQAKgL5jNTlcmiC5oUjspZPetGQD/RgApaX2XVyqlpq0uQ7Zcq1/aFSq
	FYaXmohYKsp9aKLLMhD123S/HWWT2bnDgLEXOO8V3cKmpVgdYOtkhHw==
X-Gm-Gg: ASbGncudMSEOFpA2WAELkPrstc2ssHwFRwXtvVd9qvIbf7fJ0jxdX1m0vDKQpSMx07H
	3Tyx377fTIyO8s/2oqyzAFnVq0VRMeZ08PRKT+25QFr6JufI9pLdUZCtvpxQNYK80l6Bv1Gp2YL
	Z6t9mrjoao32+LPNf1QL4Scsq//nlxXGgnkX0mW8OO0lZfehrJ+zRfbo3FH5rgJqh6O7lR9ADsa
	MloU/V0UKj+jED2Q/TKnG9dAiJpEzqYr4gAzbqE3sf55Mxk9rAKLB0A3RZfvZRAAgcAffE63Fpo
	gNruxc+I
X-Received: by 2002:a05:620a:2443:b0:7b6:72bc:df67 with SMTP id af79cd13be357-7bcd96fa150mr889455085a.1.1736415457731;
        Thu, 09 Jan 2025 01:37:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2F6Ru6Ok/aPxAZik1gN132odWyGCZsSRKmKWIOUestXgwhfS9+7n6PwHtMVo8+7sYD3e+Kg==
X-Received: by 2002:a05:620a:2443:b0:7b6:72bc:df67 with SMTP id af79cd13be357-7bcd96fa150mr889452685a.1.1736415457435;
        Thu, 09 Jan 2025 01:37:37 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3237e3bsm49254385a.23.2025.01.09.01.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 01:37:37 -0800 (PST)
Message-ID: <690fc7d2-c235-450c-981a-a889f976936e@redhat.com>
Date: Thu, 9 Jan 2025 10:37:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/14] net: pse-pd: Split ethtool_get_status into
 multiple callbacks
To: Jakub Kicinski <kuba@kernel.org>,
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
 <20250104-b4-feature_poe_arrange-v1-8-92f804bd74ed@bootlin.com>
 <20250107171554.742dcf59@kernel.org>
 <20250108102736.18c8a58f@kmaincent-XPS-13-7390>
 <20250108093645.72947028@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250108093645.72947028@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 6:36 PM, Jakub Kicinski wrote:
> On Wed, 8 Jan 2025 10:27:36 +0100 Kory Maincent wrote:
>>> Is there a reason this is defined in ethtool.h?  
>>
>> I moved in to ethtool because the PSE drivers does not need it anymore.
>> I can keep it in pse.h.
>>
>>> I have a weak preference towards keeping it in pse-pd/pse.h
>>> since touching ethtool.h rebuilds bulk of networking code.
>>> From that perspective it's also suboptimal that pse-pd/pse.h
>>> pulls in ethtool.h.  
>>
>> Do you prefer the other way around, ethtool.h pulls in pse.h?
> 
> No, no, I'd say the order of deceasing preference is:
>  - headers are independent
>  - smaller header includes bigger one
>  - bigger one includes smaller one

In this specific case, given the widespread inclusion of ethtool.h, I
think keeping the struct definition in pse.h is necessary - the reduced
incremental builds time would be a good enough reason for it.

Thanks!

Paolo


