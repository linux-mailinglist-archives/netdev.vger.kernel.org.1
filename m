Return-Path: <netdev+bounces-246141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7748CDFF12
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 17:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 832833009868
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131F63246EC;
	Sat, 27 Dec 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5mflb7b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IB3l30CX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725271DF755
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766852235; cv=none; b=WEAKBjKnyI1FokWZf5E1vAZ6MoOORPkAtKPDZX2e5z9uChuR//IvBWPnX9QbJIfxFqURXHHQY0pRoxJrCGXxXyUQ/4cDm6aaDF7Z5xhqNS+CgeVdXJtz3gEAVNVBsxu0uIL5+9U9hY/MFtqCahZD1XiqW8z7eG5iDfOQ4QBa6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766852235; c=relaxed/simple;
	bh=aRRGlbmgCyPHz8Pa1jKrxpuOs7LmWnSSbtR2xG7LGWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMzvXy6cpTSCJ9Cc0AAJfwK4DQj2qmKxVnGAmqFVJC2KazeKK38Ui+tvxDOcKwuOoW16bNYGnWZoBxS5vLozFoEtb+n/hvN2FoD++Gi2CpTSGM4CvvcwNC0H3i1/13FxDYobuc43c4EcqQGXbGaQ89dnu/+63jSGGPi98M1n/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5mflb7b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IB3l30CX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766852232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0DhKS9gnb7Kke5unA+eryUMQdIhTXQB/KUOZKIfg6Y=;
	b=B5mflb7bnEETptQl3j4mcHXJZ4OrUYUe3mQ0d+j66/olPg3bbCNmt57mnDX5xyUgVl2I5E
	3loUIraVgK0bbGXfM+uCJspMUcWXZCGZ/G3Mft/Z9Q8hBoNCyyqsuUmUdTSbGo3hPEFDOi
	Si6k1MItpqgbiBzSyosNwXLiMiegHuE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-405QetZzOlyYT9ZR0F556w-1; Sat, 27 Dec 2025 11:17:10 -0500
X-MC-Unique: 405QetZzOlyYT9ZR0F556w-1
X-Mimecast-MFC-AGG-ID: 405QetZzOlyYT9ZR0F556w_1766852229
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d4029340aso25125635e9.3
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 08:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766852229; x=1767457029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0DhKS9gnb7Kke5unA+eryUMQdIhTXQB/KUOZKIfg6Y=;
        b=IB3l30CXFdzTgWy/VZAiC6doPVAn8CZRIFkZ4zMlXz9U7jX1GL20bA5uDZqPE1wyad
         0ycPPPAgsgXBthepb7P6JCg1osh9jrnfYDLrZ9/UBL3Sse39sjLAUkSvwGavEAMv/HA8
         gSOZ+e4RKtRCRq6QIvLDhjH734W5PROkiEqQNWVr2TQuLof7XpfwWHFS80kQEhQcfVUV
         nTtn4pJeBbQvfODd/tu4i4Chw6JZStvuxfdCdcalWm4UcioelDPCtLSnP3s3BOLaS+J2
         2Sh/SMq/lJQjvke9rrt+2sNgBOXYh/QNlXaPg5BfBFWJv9SzYSrSU2r4bRA+UQKvKGCK
         RYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766852229; x=1767457029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0DhKS9gnb7Kke5unA+eryUMQdIhTXQB/KUOZKIfg6Y=;
        b=L69ivb8dPnW15AmnP8ELW2vqhAMXqQxyxCGHNozqZ3YMmTNZHydK0dNcU/kd/GfgNF
         qP6Mw2EODCl+U2pg7XwA2rx2xilh093rbkTBpYaLdSqAKTcpYD/6hrdYqPNFt1kCoDTL
         vFFtaw2q+hlBYk2EkBKWubapazbD/2nTnh5wkVouAuge4JnIPAPl/LqdjnZAyKTRiuPI
         c57WXVmz8NwTD6nPAwKTBUVh0po5mcnCzsbqXMPhDSdyOqVOUKtYGr5N3GufiEzTXzPC
         +wo8kl7rGs8BlZiZj4hqvWBQxULAVUwavmUjHWOUAvd3oY7CN4KKZmJ6K9ZtLiwIX1fk
         0xBg==
X-Forwarded-Encrypted: i=1; AJvYcCVauGIb5QdY+2fFBs36FsDdkUsFIWYuKWwhmmcEK4i6XbA4YLm639SbIlRFibdY7idN62wOx6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZ7Gy/qgEVHCvQk1onrXIkOMUyWGsYGx4sqDpJwX6HLU5SJcA
	8N31UgXJITVd9B95v2ljkC9EY6fBlo4LBlL38wmc1TC47V9uYJeY6Xawcp9PVhXTCcUbf5QWj0k
	sfmUMS6Ihn9/91UM9AS2gclzOYr/bQqyKFJqr1QXfScHtul85FvZG+CRZbc5f6MIe4w==
X-Gm-Gg: AY/fxX6Ehjbbtv1VarZCL2pTp9cZkJhI7c6R8VMjMtTVjh7GdJxRk0Tlm42hkYx3Xx0
	/WKcykIkU8/Sn8YZIqfharysREaqS2yfckujHjMKmgYnnJxnbkAH8bWTcZmXurgCT4DaNpinYLS
	UTXXcqOM3hDsRStSt8REmykihaEjyvK79DPM8gwh+KyJzUKoYep2YTCPrfMj8UJEmWZx4JEVR9t
	/Qifjcs7GBMkNgnPcEWsDByjj8ClAf9OojaCDd6LOZgGDNchROowqLwSwPpD85oUqqRHsBzQW0p
	Yuxu7WhxgaV9E9Mz/9RhOyAJEcT25rABCjSiDBc3KjFvZSSmj/bCDQyXosuRnhZp+adKJKM1m6F
	GjShhbijL5Te3tg==
X-Received: by 2002:a05:600c:8905:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-47d1958b749mr246664845e9.26.1766852228090;
        Sat, 27 Dec 2025 08:17:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ5IzKpQKCSa5gQTsNiusCm01o/F/WZ0YJB4faahcQBlfXcNGKZlqaqQCM6lonh9isBaYjyA==
X-Received: by 2002:a05:600c:8905:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-47d1958b749mr246664585e9.26.1766852227698;
        Sat, 27 Dec 2025 08:17:07 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c637sm480624875e9.11.2025.12.27.08.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 08:17:07 -0800 (PST)
Message-ID: <3870b562-c05e-4991-8060-826ea32b0e95@redhat.com>
Date: Sat, 27 Dec 2025 17:17:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: skip multicast entries for fdb_dump()
To: Andrew Lunn <andrew@lunn.ch>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251217205756.172123-1-jonas.gorski@gmail.com>
 <0be6849b-e309-4131-884a-7b352db6c599@lunn.ch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0be6849b-e309-4131-884a-7b352db6c599@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 11:00 PM, Andrew Lunn wrote:
> On Wed, Dec 17, 2025 at 09:57:56PM +0100, Jonas Gorski wrote:
>> port_fdb_dump() is supposed to only add fdb entries, but we iterate over
>> the full ARL table, which also inludes multicast entries.
> 
> includes.

Please do not resend just for the above. I'll (exceptionally) fix it
while applying the patch.

Cheers,

Paolo


