Return-Path: <netdev+bounces-161261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB2A20634
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 09:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2FD16536E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EB01DED67;
	Tue, 28 Jan 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fU4haa5m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEF4A1D
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052873; cv=none; b=ryy+b4Tee6ccKGFfuS1mQ6wyMlNw64e/HKWQQjEpUsZL7LIf0x21kKP5jDujorKUo1LEdpAdPIcerhR70jzPQtEQYe+az2oU4O6SdYQzNf2cceejz4ac6RMugZ3kxn7qweh3vmgcItqK6gOE1l9C74ODML9+bv55X2Yn+GSVbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052873; c=relaxed/simple;
	bh=gpHgaExqVx1qVDGNdsbnMWh350AWQDaeWhmLVygNQ+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiR/+yvTz2G3cYl2E0tkM0zHDUEyNvs1VbQUgd1p0L/FMTRAvo+pnHXmvIM0Os49CG0AebtRkZF53Gc4pIZ7vRyo6l16wHXNnbqJjSm5oTwVy5DGOXO/huAH98+9wwU6jsHFcesJyXE8ujvsa2R5eEc1CrCysEKU8uBIMVOboZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fU4haa5m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738052870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zeeb7pR2TFD2qStUpO2wKQcSg5+i4dVbUBw+87bVMgQ=;
	b=fU4haa5mn7oFOHRxhv1krkEgkAJY5i+8XZ57XvTHo4+/5U7qRr5Toubzx0oYacQNZLqZZw
	NkNT+HT3gkQ7KiLr/KqeSuNGBVHjs6JyG2q0t5esqZ0zpIqE1biZV5phNXaE1dtUny+3k2
	FU/0q+RgCF/WQXAtmN4W6GbKbwAwyFg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-ciBK9M68OE-HtLdXyWr4kg-1; Tue, 28 Jan 2025 03:27:47 -0500
X-MC-Unique: ciBK9M68OE-HtLdXyWr4kg-1
X-Mimecast-MFC-AGG-ID: ciBK9M68OE-HtLdXyWr4kg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38639b4f19cso3524300f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 00:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738052866; x=1738657666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zeeb7pR2TFD2qStUpO2wKQcSg5+i4dVbUBw+87bVMgQ=;
        b=SMCCmN1q+fij1hi72jtJ26NPkCSGd2DL7EJhVL15P2bWQQNZGmOoCMSTMUQQWwuvMs
         2jTRfVvjbfUTh/t1onojP6XkhkjsPEW6TeQOHR5yCw4vQgiN/E9LVXsA7pvgBXlHSI/a
         wqJVBDQAj6iJ8ZZ16WJax9addrcM1LRN5bj74BnayMgg33c5rjPgKNd6IO1iLbr6u9cy
         6awVLs+0Jy0xW0/LUqYVnELWnjzyFaeov62uJ8O+SlRPy2JWR2GABLoF/fj01DoR19FX
         /eDWWfGqwHbZWfVdZ+ytBl6XiViI7bKxH9i7LZOJUp90c7SYOHOBEE3KD2SnZMIjseOT
         i2Yw==
X-Gm-Message-State: AOJu0YytjYCdg/Cp0+sZtocLTw5xE3k2SfkWzUtXFTMHO88KJ6nUFCdS
	feTXNs6RKo2OXMYa9mTc87u78ruo8cZPDYsSRZ0HmrzhOOS9/MiuFVBlNv6+wi8A11D8IU674F6
	t+WlEe23hiuUAVXJaEFyDjX+Xo/C9bWcFLh3Cnm88LN13P1JeFgtXfjVmc2EusA==
X-Gm-Gg: ASbGncsmNzABAUp2VR6eUf50OThaglJjpl8Vjss9Xe2nmGtlZoYpfaSuXW1pKNFFClo
	2Evx+8hkSqWS/BLvZNwTRDbO5sEWCdzc0u0qVJOlltNMaWPBpqmbsZag0KKse6eCwiE+AEtlHR4
	VpQ1FRur1pbsGyY05cTDHFLcQQQ2jDundTe8Y3PdILIus7d4nHcx+Ro76H7MQbZVll+SpteKTkV
	IKbZ/I+bFPtX4eh3Fk2LjFqTssFJH0V7iGdFk3W4Q12N2RoGBx3zUXszWhUqLtXosR4EmPqSc7Q
	dj404nRoWxbDNx0Cl8r/RO2nyBL6+iCQAIM=
X-Received: by 2002:a05:6000:2ce:b0:38b:ec34:2d62 with SMTP id ffacd0b85a97d-38bf5669750mr44514118f8f.24.1738052865812;
        Tue, 28 Jan 2025 00:27:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMPi3k+U7sEZGEtw3/03d/jmCHBxqVbbK6JX4D7aNWCiCEHhmSRzw8BD6VM7gB+k0b1Dt91A==
X-Received: by 2002:a05:6000:2ce:b0:38b:ec34:2d62 with SMTP id ffacd0b85a97d-38bf5669750mr44514099f8f.24.1738052865501;
        Tue, 28 Jan 2025 00:27:45 -0800 (PST)
Received: from [192.168.88.253] (146-241-48-130.dyn.eolo.it. [146.241.48.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd508257sm158765475e9.23.2025.01.28.00.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 00:27:44 -0800 (PST)
Message-ID: <7e0d243a-5b66-4cf5-afaf-644694330c8e@redhat.com>
Date: Tue, 28 Jan 2025 09:27:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/12] net: homa: create homa_pool.h and
 homa_pool.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-5-ouster@cs.stanford.edu>
 <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com>
 <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
 <4e43078f-a41e-4953-9ee9-de579bd92914@redhat.com>
 <CAGXJAmxPzrnve-LKKhVNnHCpTeYV=MkuBu0qaAu_YmQP5CSXhg@mail.gmail.com>
 <595520fc-d456-4e62-9c39-947ccfb86d0d@redhat.com>
 <CAGXJAmz6TL8C5Q2=__5nxCBudDd_+NbnaabnB6+Tt79A3HyK9g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmz6TL8C5Q2=__5nxCBudDd_+NbnaabnB6+Tt79A3HyK9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/27/25 8:12 PM, John Ousterhout wrote:
> On Mon, Jan 27, 2025 at 10:28 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> Please do. In fact using the raw variant when not needed will bring only
>> shortcoming.
> 
> Will do. Just for my information, when is the raw variant "needed"?

Ah, I just noticed the related documentation has typo (in the name), so
you probably missed it:

 * raw_processor_id() - get the current (unstable) CPU id
 *
 * For then you know what you are doing and need an unstable
 * CPU id.

'unstable' means it can actually change under the hood, so the caller is
looking just for 'an hint' of the current processor id. A sample
use-case is for socket lookup scoring, e.g. as used by the TCP and UDP
protocols.

/P


