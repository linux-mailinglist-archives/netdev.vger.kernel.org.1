Return-Path: <netdev+bounces-228186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D9FBC4222
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 11:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 159904E2B56
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468DC2EC559;
	Wed,  8 Oct 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/PezEze"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A21E25F9
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914938; cv=none; b=u0VOKICd3UJiCtmkGKqz6bm5BPRKnQHZfgWhCiynkWlKYVMHvU34AAgF+jMdLew0BYz5UzEJ7/OhIqYAQifUYWEtsXOOuVv1pEuaE+4Qy5nuxpL9H8eZvvNGeUVWL2u9161uiRhjguViMNtCfis5uQ3S7c4IwZG1T3h6uFB8Q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914938; c=relaxed/simple;
	bh=h3nhzC7BiB5iL8CN/G8smyMRGRkr4gcP10PuoFOLAGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IWz+HV3BCP3Ht89/HNYsa2iEmp5xevOyx+429udl9sg5nv/3LxVyjGt52QsLTji0ejAx8eMz2WjNaN59Z9D820+tCpBPyiq3e+9IpK71wn8U0BhTfe7CbwS9rU8fC9RL15tbee6H2GbW/VcmpxHubn+Xn8kY92APloYWUrfgXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/PezEze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759914935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BwUajDCtCRKIVUkWwqzUdyXREWZQ5RXzorq2Q7OsQE=;
	b=C/PezEzed54sv0FR/f8J1ZAdFdJpphLJwD3zFAPtPa5xrlQ9POsr/MYepYLMaInVbbgbDi
	YmofuN8J/Ari61fwJ5HiJi3A3DIz+sJC/voR+jDbSaGeX9vxHRP0syZ0KeiEbcSvpHyt2M
	s73H2fZGvR1h7VIn10Ko12lvY/iA8cI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-E9dWBaAuOiOXRnOcl0A-bg-1; Wed, 08 Oct 2025 05:15:33 -0400
X-MC-Unique: E9dWBaAuOiOXRnOcl0A-bg-1
X-Mimecast-MFC-AGG-ID: E9dWBaAuOiOXRnOcl0A-bg_1759914932
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-401dbafbcfaso4366433f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 02:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759914932; x=1760519732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BwUajDCtCRKIVUkWwqzUdyXREWZQ5RXzorq2Q7OsQE=;
        b=J519embr9bm2iT/q9ShcHdRFUfboTw7+RsGTh8xxDGGfZznViZxvL6tPc4xXSLxOkF
         t0xKlZRkdxfbvooaQfUZT/3aTHeB/sjmv5ToItEumkF0cv+6kj87s8vwnCfmC1eE1fK4
         hJlwI/RIAKDRZKCRvdeeCfy+lHLXd9M7TzpsZytDLQVDyJxM4WynAenOZL2nglXVP50c
         R3lyR5SGpbgdinK0XW1BZ8BffXvLB1wPw4BHqSTwD0oXxqDD02rWHPxFpsg1zcCOKeto
         9vbSq4+rTBDl+YpninSBWfleT5JiNxtuGFQ/mPt7JQ3QeuDqID3fPeiU7kJnVJ933Ns6
         Uk/A==
X-Forwarded-Encrypted: i=1; AJvYcCVOuIi3gr3ON6EYgBLilDh3PnACwyykzoAGsCjejZCC+KEHoNoMxkRIkJhQVOCmyQ56IGvEKhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQR775c7lfbquSF2ULPK+IQpWbDK5KfxGi67CK5pYOlf9TN7sg
	9KvJaJkLEX6U8ps4NHyyMhvp6+4QGf1FGd+FkmipAfX6gOBgIdMQq/0Vl/n4s0lcAdV6LSuCOF6
	voJLAvF0MqFdcOq0eWMFPXXlrTOq55sdjM3YDOZPtPAHQCt9O9OrAh06B6w==
X-Gm-Gg: ASbGncuVntUGYjlb+ShCxaEXJmWOuu2YcQ2AxZM8782HobMwRD4zNrNQja9ggaLo02j
	BdBVWCllEu4Xdas+QoSw7D8WVCwilaN2yTKkDCJnf4bUmouB0T0LCd8hDvc+yo7XuJou6TTNdX3
	PfK3Anxcx+wU9b6TNdvoUodp9CDmHrXIt6LNF+EI2DSXBN/8LcbULoLDm+7rKwqCzHv/AD+0Rs/
	goxhkJxKdhPVCMJ9IA8kyBbhqbtN5sG3knXZjdZl0IUcj45EPzOPsMZYdBQxqmUmYhL7yqFkYKb
	01o2EP3li8E4lFyAI9bBLAkeOLa9LKw4UEnagvmkpEp2CzpwE9dwruw5KkJJV/kcp9jU6RKioFu
	5zgtnUbcH+V+ohIHgJg==
X-Received: by 2002:a05:6000:1888:b0:3fd:bf1d:15ac with SMTP id ffacd0b85a97d-4266726c5edmr1506926f8f.20.1759914932141;
        Wed, 08 Oct 2025 02:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPnTNtDXO3Nz+L6CqDMdd0CPKASHK9kAR9L1cTMeV4bFfN2/OOXHew6L2M90HxGoLqdcYlgA==
X-Received: by 2002:a05:6000:1888:b0:3fd:bf1d:15ac with SMTP id ffacd0b85a97d-4266726c5edmr1506906f8f.20.1759914931732;
        Wed, 08 Oct 2025 02:15:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b40sm29074843f8f.2.2025.10.08.02.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:15:31 -0700 (PDT)
Message-ID: <cec8fd69-a645-4b6f-bb17-7a0e912095ed@redhat.com>
Date: Wed, 8 Oct 2025 11:15:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] LPC 2025: Networking track CFP
To: Alexandra Winter <wintera@linux.ibm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <537d0492-c2ad-4189-bb87-5d2d4b47bc29@redhat.com>
 <f3d545b7-a77a-4bcc-9231-69dbb99c2199@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f3d545b7-a77a-4bcc-9231-69dbb99c2199@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 10:37 AM, Alexandra Winter wrote:
> On 24.09.25 10:09, Paolo Abeni wrote:
>> We are pleased to announce the (belated) Call for Proposals (CFP) for
>> the Networking track at the 2025 edition of the Linux Plumbers
>> Conference (LPC) which is taking place in Tokyo, Japan,
>> on December 11th - 13th, 2025.
> 
> 
> It seems LPC 2025 is already sold out and has a waiting list:
> https://lpc.events/blog/current/
> 
> Does anybody have insights wrt the Networking track?
> Are there any reserved tickets?

There will be a small number of passes reserved for the accepted talks
and the committee, but I don't have more info other than that.

/P


