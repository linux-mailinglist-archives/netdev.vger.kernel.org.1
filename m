Return-Path: <netdev+bounces-198575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E69ADCBD0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9595A175C64
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C577290BC4;
	Tue, 17 Jun 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsDLtXIr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654032DE216
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750164359; cv=none; b=foIA8WZVa3FdZH+8xNAVOpTQdJvGAJQs73NqhhZV6GlrL12IaFHo0ItV9G3ayb0//by3B7qFMjqDi87JCnuOS4RtRN2BoV+dR28svu4aToulHvgTz7wtLkYLE2zfslg6JE8X8b1oVNtIn40h0oNgS+SOrmD+L6hVu+50Kb06aKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750164359; c=relaxed/simple;
	bh=QxZLfUTEIFdVHJkWCH6cSGdXKxkzLmbolb7cty2jJws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=to0YzEjjZD0HN7Xwd0Edi2KobJ6O3NRLtEMBZ0+X8K5vis46n7sQdh2qgKGgtTYXpTo6Kh9RX1j+JNZ6netj70YmEJUlaZmMXP5BtrECGEpXlVPcHSg2m+NRXRYd6OeVaLlhw0vUhqetpkvC8fsFB/9q8s1hOZ0CiN8olzi6oKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsDLtXIr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750164356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYUkWUOYnsC7CSh9B18Rcje/1ENNTK97RWp3t1nu5V4=;
	b=UsDLtXIrxTIDIpYOfIqL+TyYRrQIB1XzLluC6VaNJB4dtDDC+igNNtuqXYugw6BB8Q1cG1
	hR3y2NWXJpKo0okp0sp8u1oAUwKTXYEnA23Ax40d1bz2/y8Gf/CPNAdJ+EzjYpxuTphnZd
	wRJj4AcaR2O9POhMp4/enF+6gAUKPtI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-AlZyCxgDOrGSZ4BmSYgViQ-1; Tue, 17 Jun 2025 08:45:55 -0400
X-MC-Unique: AlZyCxgDOrGSZ4BmSYgViQ-1
X-Mimecast-MFC-AGG-ID: AlZyCxgDOrGSZ4BmSYgViQ_1750164354
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a50816cc58so1921323f8f.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 05:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750164354; x=1750769154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYUkWUOYnsC7CSh9B18Rcje/1ENNTK97RWp3t1nu5V4=;
        b=FAKjvc/wzWc1xdAaQCPgSQf7PGEkRucKyjKTS/ugU31YA1BshDDMn2AXhAcFwwVzmW
         DcEnC/xa5901nho7QRm7EsAUOjyp3fkBQLzSHg8gRL2t4tSbcibGFDt+qf3FaTBgvEH4
         0nUhHPVHjE/XtwG7bYIT8FvUhX95LrmhMqV+F/KOdXPtx7y7kzulxoQ2TUQm81beDDKh
         poJT40dWoqtb0S7XM7VaJSI6fLug4ulu7AS63ogrQIpDOGkRhqj3EeWJmG5b23T2FrST
         kJ+1om1zPp7Py1WqecVryBOckBvFIEW23JjFbbgUaV0Mm7r9UjCmIt+FY0CBfhpJvisB
         J2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXPeH9idhDvhGikP+Ru5lDDiPMRCC51QhTEiTre5N3sS0OGxczGur2w7p6uNubEhK714fwmnXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNz6OBaHEnvOQ5KoEoTcyJ0XSBzu0mAePoG3TI8dUMrmLqZFw
	rv4KCo+eIy62K6X531lWUpU3wF4eaK/FiuxPigipq5djyTDcN9mhs+5LcgBTHM4aFPamo7e2gDB
	EvIpMU1PPBIyHG9QKF6mZZ1E60V5M1Rc7L5iI/SZ5qC3zpJRIsiNLtkLrwQ==
X-Gm-Gg: ASbGncsUt3W44qaHJ/iq7pHiKT+Ynl6WoGtm//rE7nErwpfrysVwuJbxHXskZwe6BRj
	SHhVmVVacAxfmqYZpqkVnSadFoLqJ6G4Ddx8Y4nfpNp+LEbu6PZKGxV7rzmb4Dgjms0J1bQbzAZ
	FLzoJAxmezmF8mlGNfCddiIPQ3pYV6Dq/tZj8SjUhOiE8QggnCKWiN8uthucWGpP47yqr4LRdBQ
	iDMUfxWOeX0/7Sbkc1X74B9Yk07O42L+mp6UJF/77QTfs+f0Fb9dgOoxhH93GLqGrK5CWTwzrTq
	TDu703zA0PUzCeYLbvdblcwQydL0Nw==
X-Received: by 2002:a05:6000:144e:b0:3a5:3b14:1ba3 with SMTP id ffacd0b85a97d-3a572e58cc9mr10591120f8f.49.1750164353690;
        Tue, 17 Jun 2025 05:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl9BQcpZmRhEGmv7pvvJ6cVLjXCzCX3TEgb6m15O5XE69AmzolQFfm0zghgQdyzP/OZLjVAQ==
X-Received: by 2002:a05:6000:144e:b0:3a5:3b14:1ba3 with SMTP id ffacd0b85a97d-3a572e58cc9mr10591092f8f.49.1750164353213;
        Tue, 17 Jun 2025 05:45:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10::f39? ([2a0d:3344:2448:cb10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b090b0sm13845560f8f.46.2025.06.17.05.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 05:45:52 -0700 (PDT)
Message-ID: <61c54e7b-9ffd-45c4-b37f-c570e310ea45@redhat.com>
Date: Tue, 17 Jun 2025 14:45:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] igc: add private flag to reverse TX queue
 priority in TSN mode
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: faizal.abdul.rahim@intel.com, chwee.lin.choong@intel.com,
 horms@kernel.org, vitaly.lifshits@intel.com, dima.ruinskiy@intel.com,
 Mor Bar-Gabay <morx.bar.gabay@intel.com>, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 kuba@kernel.org
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
 <20250611180314.2059166-6-anthony.l.nguyen@intel.com>
 <26b0a6cd-9f2c-487a-bb7a-d648993b8725@redhat.com>
 <20250617121742.64no35fvb2bbnppf@skbuf>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250617121742.64no35fvb2bbnppf@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 2:17 PM, Vladimir Oltean wrote:
> On Tue, Jun 17, 2025 at 12:06:14PM +0200, Paolo Abeni wrote:
>> On 6/11/25 8:03 PM, Tony Nguyen wrote:
>>> To harmonize TX queue priority behavior between taprio and mqprio, and
>>> to fix these issues without breaking long-standing taprio use cases,
>>> this patch adds a new private flag, called reverse-tsn-txq-prio, to
>>> reverse the TX queue priority. It makes queue 3 the highest and queue 0
>>> the lowest, reusing the TX arbitration logic already used by mqprio.
>> Isn't the above quite the opposite of what Vladimir asked in
>> https://lore.kernel.org/all/20250214113815.37ttoor3isrt34dg@skbuf/ ?
>>
>> """
>> I would expect that for uniform behavior, you would force the users a
>> little bit to adopt the new TX scheduling mode in taprio, otherwise any
>> configuration with preemptible traffic classes would be rejected by the
>> driver.
>> """
>>
>> I don't see him commenting on later version, @Vladimir: does this fits you?
> 
> Indeed, sorry for disappearing from the patch review process.
> 
> I don't see the discrepancy between what Faizal implemented and what we
> discussed. Specifically on the bit you quoted - patch "igc: add
> preemptible queue support in taprio" refuses taprio schedules with
> preemptible TCs if the user hasn't explicitly opted into
> IGC_FLAG_TSN_REVERSE_TXQ_PRIO. If that private flag isn't set,
> everything works as currently documented, just the new features are
> gated.
> 
> The name of the private flag is debatable IMHO, because it's taprio
> specific and the name doesn't reflect that (mqprio uses the "reverse"
> priority assignment to TX queues by default, and this flag doesn't
> change that). Also, "reverse" compared to what? Both operating modes can
> equally be named "reverse". Maybe "taprio-standard-txq-priority" would
> have been clearer regarding what the flag really does. Anyway, I don't
> want to stir up a huge debate around naming if functionality-wise it's
> the same thing, they have to maintain it, I don't.
> 
> Is there something I'm missing? It feels like it.

I misread your original comment as a request to make the 'standard'
priority the default, and the current one reachable only enabling the
priv flag.

I see you are fine with the current status, so the answer to your
question is 'no' ;)

Paolo


