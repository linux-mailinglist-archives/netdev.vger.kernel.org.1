Return-Path: <netdev+bounces-243443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CC3CA12C6
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 19:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C4673001E17
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088B346E73;
	Wed,  3 Dec 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOwJHr7F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/7cAnJB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0D346E71
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786649; cv=none; b=SePtCkhXHmLrI+O2+6CyK4oacJyCEFMLaoq11iigFg8D9vxU5Yg5sXyuaU82CDgHrq1zLYHN1ejgY20PsPpf5UTLxYylsu6ereL43KBMycS6OS5B6fPljF1e6l5uZF5CB228lgy8z9RGBjmnm+WbQl/kKURjINjKbTy02KI1ry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786649; c=relaxed/simple;
	bh=VYxKNEwJsGoFLMu4mlLGH1jje4jvanpQMbiJbSZ292s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIDblOdEYcwxp/cy5X9wslL3OFWjKhY7tj4CpdNHecKi27nuVja7JKor0tMlGY/V5rn2CJFT+nPRhxYCR+WAmddMbtpFjgDGTJJcu1lsWdUiCaNMIOYB5D+qfg699V5kooS7F3/4RxVwbFIPQQcyd9DINvdqRa4lzO1i4x3NfA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOwJHr7F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/7cAnJB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764786636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acsQVvxxVABEXpMRsDvrWebO8JH8k6+nAs9EDdDvZVY=;
	b=NOwJHr7FNQx7wD/ioSjmw8fHB2M7HSmYni/EUP5nhhL9gjbfhTV7f/Qt5ogXNiVLjTJ7Da
	lIalYLLfYH7/htTHDf6guD0eGnG/3kb//r353WGYOQgdaIXm+l5CtpQPoOLm5kBNinOr1U
	fgH2yoYO/pZtWq7+69WGwQ5t760L2tM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-p3lbJKAHMTuKaKSOToSzIg-1; Wed, 03 Dec 2025 13:30:33 -0500
X-MC-Unique: p3lbJKAHMTuKaKSOToSzIg-1
X-Mimecast-MFC-AGG-ID: p3lbJKAHMTuKaKSOToSzIg_1764786633
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42e29783a15so48154f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764786633; x=1765391433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=acsQVvxxVABEXpMRsDvrWebO8JH8k6+nAs9EDdDvZVY=;
        b=B/7cAnJBunq48vfQqivwQbeUWgRSgBEs/qcrMtDOmnHF0SiiwZVYbq4/X2H9RlVaML
         1d81wrV6jdg1QgPfVcir8woZKGf50W2uvghyob5LTQBW2RzAgucpBnnr7ZPZwNa2vtn5
         URE+Heu1Pibi5yZfDTpL2DHQUzP8bMya6NG6bu42Yw20VSazMflfAVhE8y5A3TiDUATx
         Vj4n7mIznlETtkN+OTgvRPL7rGksWZ9LoUJfNQvxbuEA20bZuPlZ3NxH9/vut0XSsShh
         Zedgy2pHmzltG1U4jNM/aeSqgDOrq5e1fQGm/9NWyFzjS2lASe2IVbzpeu8ZfWXIXzPl
         yuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764786633; x=1765391433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acsQVvxxVABEXpMRsDvrWebO8JH8k6+nAs9EDdDvZVY=;
        b=RjI521557dKvdzmV5kjsapojxh4jS6tn0KPgwYnbXbsbqpty/aqSM3ABQPEumVGAnd
         tnM9ALh9BLr0dWvx1PHRFN4yWyDxEGFiuYf8h44BKftGErFY+qOaL/e8xOPCypRsp7+/
         dqFe5NkYXKVmiRk1NfacbO85MlqEUnmW3sSaQ0FMGZXy4MUdVI8IUS/+tWwwUE49tm6s
         NARNsdGAr9+nJo32Da3Y20v30/PkdGsMDl7AyxDL6YDyU1q96a3VFwY9OUwR6Ic6nyie
         s0e8O/3UOuqVlHCAvX0KC3IlJEW3XW8tzdsUVkaqSMlb6Th2x3S+tPCz3OvxMDLGFDZI
         Nrxw==
X-Gm-Message-State: AOJu0YzmkWNjNXAuRhXnmylE4oJAL1gUhHyEPVWd77H6vW/X+v3eo2Dq
	Uat0ZEO2jQIE5mT2P5m7SX+XoczLsrUWC2US61Uu9bjAoQZely3EWuXJHI8HWiQb6z0E4iXs4lR
	GZhawnpuPG1xlcaLvxEZ5KDga4FISt+EW6xZOLrAA2D7hRDJft9wQHFd7rQ==
X-Gm-Gg: ASbGncsdhtOBUL9b9rd7IpQaXKtUGdoMY9qcTgRQH9BB7iKUq3UQsUBYT7YA6ap8Ihu
	9EW9NCJCX4lhjOdpCTsDtbh3+s9zwxcgXS53kCTr0xXqOrAY7m8wHFvkLF98jbDSZY0EHLQ3Ajt
	+5BJsXUMZVk9BLD3iRFZg4of2GvuLPZ4AMwMc9wG90p4ekd+CBi/MtwO8SH7wCtQ5igxXGbjRQj
	WyfnAkblVRPSmhriwJnEdxKXz5/bNzw1O3LzE7Hzk7AJpj6oIqg4CNo7bLQzj7SzvZhfoKoINZh
	W3UTshcbErAzvVnikLchFVce5Mk8N7iJ/6N9K0eeVrs5OFNjU81VCyvZcxR6kmITwpbnBQUY8ZE
	D6BpRtnCuDF6/
X-Received: by 2002:a5d:568d:0:b0:429:d59e:d097 with SMTP id ffacd0b85a97d-42f7876a1d2mr357485f8f.9.1764786632624;
        Wed, 03 Dec 2025 10:30:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDHBFTVB7DGoAI6E1BlomKo2N3EamH9l3ucvy9/gps2BsQhYjdlYa5fv7c+yQ+euCbCalrcw==
X-Received: by 2002:a5d:568d:0:b0:429:d59e:d097 with SMTP id ffacd0b85a97d-42f7876a1d2mr357464f8f.9.1764786632253;
        Wed, 03 Dec 2025 10:30:32 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a38bsm41628603f8f.24.2025.12.03.10.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 10:30:31 -0800 (PST)
Message-ID: <89b15d8b-f145-40f5-a56a-07b73b3ea899@redhat.com>
Date: Wed, 3 Dec 2025 19:30:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MPTCP deadlocks
To: Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20251203073555.1f39300c@kernel.org>
 <b0b6878a-9410-4ee6-a8c1-c54ae258dc40@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b0b6878a-9410-4ee6-a8c1-c54ae258dc40@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 6:37 PM, Matthieu Baerts wrote:
> On 03/12/2025 16:35, Jakub Kicinski wrote:
>> Not sure if its the new machines or some of the recent work in MPTCP
>> but we hit a deadlock in the tests a couple of times:
> 
> Thank you for the message, I didn't notice that, and I didn't see this
> issue in our CI. So maybe due to both the new machines and the recent work.
> 
> I will check if one of my syzkaller instances didn't find the same bug,
> hopefully with a reproducer.

caused by:

ommit f8a1d9b18c5efc76784f5a326e905f641f839894
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon Jul 14 18:41:44 2025 +0200

    mptcp: make fallback action and fallback decision atomic

I think it's just quite unlikely to hit the relevant code path with the
suitable status to trigger the bug.

@Matttbe: if it's ok I'll send a patch directly to net

/P


