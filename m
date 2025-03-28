Return-Path: <netdev+bounces-178139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DB6A74E26
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9136B7A6885
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1D21D5CD1;
	Fri, 28 Mar 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2qD2GnB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B718E743;
	Fri, 28 Mar 2025 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177205; cv=none; b=ThyosAwu4u6lNua7wAl8Wv5HalZBDU0mAb6xtNSVFXIXUCKstqlyxkhOLLrOIDgQNFyTF7i1s4+o8a2qrGiUjcvV0JG9atZvU+mzQg4WHppWm7N81RQ41iEj02QS02ZJvXN0mRfTlW1HGgG9N1XGzjSdQS8hqb2XPmagbKuGDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177205; c=relaxed/simple;
	bh=sT9l1soy8g6kWWMfr03ZflF0iPIE60RutKuPCUgizfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZ9m84gSdl8gY1Acom3XctYxUfMqc1QfkC8Gx8gqO8L9ofZW73nwP3A7CV3Xo+1gj/cnyowMIl13avtG7S1r+vACHiNOukw2CkyyG9w9Gpuph6zERzibIH59CFBtfF+Rnd9XeunbTDVO5GGnY7oXVPZvkyTI11nQ1wC0hD9Zrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2qD2GnB; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6ff37565154so21551687b3.3;
        Fri, 28 Mar 2025 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743177203; x=1743782003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7ArQSvGzCkLOtTBEXoN03yuh87JN3AovyX63+l1thA=;
        b=j2qD2GnBKrq6vJU5ScK0iV4iCNVoVRjADCUyVhQVHpUwh6D6CJYmbvswi0TcY30rKn
         a4pAthm9ABCR5fRVlXghUdralBSUl5hrcdHiRbNPJ+189zqSvLI0cGVl2uVmJ3o4soxD
         IOtuubi8CSiUCgLeTnK1/jn6TPunDKx+wTm6r2shiKhLS1kdmfcQKXHYN+Yoin53ea+r
         XlR3wlNIpNzBxRy7UXvtQajpYwc6c/g4oggzOU7MBR4VPw0mRCjEul0mfZUTO4HfGbUw
         rh7K2oWfqEixYjZWSUg/fh5JR4Vd9YStToiEyj+96MtSU/9p4dO+z2bfKIBBrGNbujiH
         g62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743177203; x=1743782003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7ArQSvGzCkLOtTBEXoN03yuh87JN3AovyX63+l1thA=;
        b=kO13wGK19htM8rLr5E/tJ1uGXIZID4BPu1yIXP37kmy3Rbjwdjo1TxczyZKDbZtYLY
         sQLQhPmBE/JMGdPf5bras2Pe5QZBGrg4VA3buJzfsTrrNecEhDszQT4KtAKsFmbXYBt/
         G4uIkdgDzQXYznmITNyRR4o2+57w47386Gul6DFoxLx5t7dJZ9mnmmUUyL4OwGO7zBlx
         cSi2+AkgTohk/IKpNGLN3q8pgmTb9voN1DsqV052th/rCc1WblO5isqeCOL3twGiOFZp
         Q3+sFoU0xV6CxjbG++mqnWKZ/mg43FTE93ZK9Q0DLZDibHjPqmGpvLYxvEtq4GhaKruE
         fl5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUih2LOoVHR9tsxoMlpndEGo9S29wrLfXkcX0nSRPGR7RlQblC8rEnUmvVxX5mXAu1HrmC9x4kF@vger.kernel.org, AJvYcCWfIw2IdvLnKfpW9pCID4Zx9b/K5YO0o5GAPcSOntsVog7cp96tbyQjwRGuBg+O1Ji9NMkf3dsrGc2Fgw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkEldU5GfbMXb9SR0yo8msvWL+Gn+OmbSQ5EHgsTBCY4nypdz
	4eVgMC7Z+enFWAlDApXn8O+Gv3xWbTeX3N0ABXDCIePaIk7+K2gW
X-Gm-Gg: ASbGncsYZ+GOp9I1JO8qSrIKtw6dZ3xFWC38Bo/7HMA/ZrQp4maHueGYMQunuFpVDbR
	YPODOpeTwaJh2rblFdSM4LppwxPKRuJx/CllwutkxSjS1aT56xzCO7noATrO2sWC8C+8qLY0Bek
	k3vFQyAkxrUEBoQWErBAPcG1K8aBX0i3rXpfGHPWaWr4iyErPu44w5vhFM8ghIFIk16jDI6fRYt
	5z/NYJvL9tWDb1sAfHYwgZBd+YmhpqMXvEHlyuPu3xDn2tYWEVUwAZOcY18vb2M41JDhyIc3snd
	TwNzYUYuIcErBp3JtORCaokJCtobr0dBo1D9zW3NxQ/ST9ODO6qEVcSmx0o+VDLlpcE=
X-Google-Smtp-Source: AGHT+IGvERJjffAn9lGWtupVs38GAUyAPk1DPO/OGaC8Od9Qndrrp1k1J3/OD/IDOZXkvQIKjJKqRg==
X-Received: by 2002:a05:690c:640d:b0:6fb:9b19:ab49 with SMTP id 00721157ae682-70224f2208cmr121748237b3.6.1743177202740;
        Fri, 28 Mar 2025 08:53:22 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023aa2ab05sm7519417b3.118.2025.03.28.08.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 08:53:22 -0700 (PDT)
Message-ID: <8f51bb33-c5a5-4046-93d6-f58e841256e5@gmail.com>
Date: Fri, 28 Mar 2025 11:53:21 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb
 flag
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-2-Joseph.Huang@garmin.com>
 <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
 <85a52bd9-8107-4cb8-b967-2646d0e74ab4@gmail.com>
 <ffe6f6cc-7157-48ad-9cde-dc38d8427849@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <ffe6f6cc-7157-48ad-9cde-dc38d8427849@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/2025 6:52 PM, Nikolay Aleksandrov wrote:
> On 3/27/25 00:38, Joseph Huang wrote:
>> On 3/21/2025 4:19 AM, Nikolay Aleksandrov wrote:
>>>> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct 
>>>> net_device *dev, int err, void *pri
>>>>            pp = &p->next) {
>>>>           if (p->key.port != port)
>>>>               continue;
>>>> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>>> +
>>>> +        if (err)
>>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>>>> +        else
>>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>>
>>> These two should be mutually exclusive, either it's offloaded or it 
>>> failed an offload,
>>> shouldn't be possible to have both set. I'd recommend adding some 
>>> helper that takes
>>> care of that.
>>
>> It is true that these two are mutually exclusive, but strictly 
>> speaking there are four types of entries:
>>
>> 1. Entries which are not offload-able (i.e., the ports are not backed 
>> by switchdev)
>> 2. Entries which are being offloaded, but results yet unknown
>> 3. Entries which are successfully offloaded, and
>> 4. Entries which failed to be offloaded
>>
>> Even if we ignore the ones which are being offloaded (type 2 is 
>> transient), we still need two flags, otherwise we won't be able to 
>> tell type 1 from type 4 entries.
>>
>> If we need two flags anyway, having separate flags for type 3 and type 
>> 4 simplifies the logic.
>>
>> Or did I misunderstood your comments?
>>
>> Thanks,
>> Joseph
> 
> I think you misunderstood me, I don't mind having the two flags. :)

Got it. Thanks.

> My point is that they must be managed correctly and shouldn't be allowed
> to be set simultaneously.
> 
> Cheers,
>   Nik
> 

Helper function like this?

+static void set_mdb_pg_offload_flags(bool err, u8 *flags)
+{
+	*flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
+	*flags |= (err ? MDB_PG_FLAGS_OFFLOAD_FAILED : MDB_PG_FLAGS_OFFLOAD);
+}

and then from the call site

-		p->flags |= MDB_PG_FLAGS_OFFLOAD;
+		set_mdb_pg_offload_flags(err, &p->flags);

?

Or simply clearing the flags in-line:

-		p->flags |= MDB_PG_FLAGS_OFFLOAD;
+		p->flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
+
+		if (err)
+			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
+		else
+			p->flags |= MDB_PG_FLAGS_OFFLOAD;

?

Thanks,
Joseph

