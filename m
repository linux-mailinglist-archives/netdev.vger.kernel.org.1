Return-Path: <netdev+bounces-247677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CBCFD3CD
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12451300857C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47B32D0D9;
	Wed,  7 Jan 2026 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="F6Z0bFtZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06E315D5D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782602; cv=none; b=QrJordG9ITewpPzslpRH1QVYXoF2HHSqiKlN1BYEblEHOCXCSh0lC+Ig/uCZjNnugypcWKehJKFeudtzFEKclxjbfpLS4x2ORV068N4ByTcPkWoURAGS3iyBmU9+AjDjeAGd8Lz2WAFlGd2yuTYr5qGFSh+1fK3dE1nPi5mddmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782602; c=relaxed/simple;
	bh=T4mzP6OgEoWdzEXiAAG5hgql3rQ9+t9k7si8T9xImio=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xi9D2NdtEaLTAOgN7Uc6tuw+mD8aOJe3EDwi0sxNbynd7aY+vZvnzBkqt7ACPmLqIpxnEsCMTfYFGx5XPHK4qtBKtg3AIZnll6nJ7vTeGcS+hIhI/Sa0/3Kmy1EN7koqcseWgfKXEcxGw5nFNBHbN/7CNG5r8BkkkZfOJyp6aUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=F6Z0bFtZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7633027cb2so355562366b.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 02:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767782599; x=1768387399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qk1lvXiz4voWR1ZfaahAyMiThkZy6UNBmvs4Kl9U7ZU=;
        b=F6Z0bFtZebCOWqJFsQ7mm4kelm4/AmpaQNJZY/Y+xkqJOTx3JFCqZ5lDxXkHgcxksy
         2zqemvyQHkrgMjsr+boCq9+cFGgZ4wFwZkrcGaCgx18sdAVmVwN2C8ZvSqQkVHSbGooF
         LSzzkCw8D5JCpp/EsvxlFv7wTOuWUBmgltuAC0ZSBy5LyLnH4KS4/ANtrPRxe4wNdy+g
         vE9MfYt9/QEgeKnA1KO9gaEHVubQUKR+fsQeyRBHatiz2ANyXh1N5NvIv/5lrTjAJqgf
         Sb4srIhW68mOBnK0THr05iz2i8fmmth+bghTzpddDjrF5/GWiExIfwPmnRnwgcvitjms
         Orug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767782599; x=1768387399;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk1lvXiz4voWR1ZfaahAyMiThkZy6UNBmvs4Kl9U7ZU=;
        b=Toi4+IO+pHGtziuGwkGZyIsv411T6gAJ2VfLwxIEaNgPEPCFxGaFVqY/kB28j2cf7u
         2Z89//7pxJjWuqvBKG8DfsBTibeMMxzGhSaQzqptSlInMUx2pNoDsH4zySFfAJr3pEa3
         iKzChD6ZsJ3mTAxmDvVJwlYJPkICuxD47rM7oMt3SgL6npJYjO8YNrUYLQltWrbeheqU
         XeJtNDmQTUKUoFGxcUh4neulJ7dWh/1gKCh7uVBqSFiW1se8TFvcAYCZNZlfvoDYTZ55
         5xuzuloIjShU03a1eQd8eUrM1ShfyF/4t5TEeB/kTjVq82hKPjIk0lKxSri0hh7ZVrMA
         7eFg==
X-Forwarded-Encrypted: i=1; AJvYcCXBfFOBw7VnNVsPDWFjP3aUoB1RI5LE50MQS4QcZKTTz8yjeD4E0YZQdy6Q6x9BXAPuwsl39e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTi9qy4MCbtAPsCv4XjXjqmteRZnHnrq8aiJvzNeb4XcIu+HkV
	23rspFXwsfF4E7VgXA1tDivhrVx6TMVMRGPaDpKTOFeVOxbWTJcES4HtntREUOSfqXs=
X-Gm-Gg: AY/fxX70eEWKyxDH+VHAPmkkvc4CWkIJxyaPNFhZogNsQmWlIulwWi5rwPis+ssJjBt
	nyDvZCftZa46GZPY2FPpvJoL5sQqk3NkQ8qvwQUm9HbPolCxcUaeB9P0wNUZ2pikjqUAO1x6NJf
	ICGTCE1hzVlC0KzkanCq22GNcuivzmmj1JuxdTkujGckHXftcL9A3DFP4eW9x75s3JINcrhkZpk
	JShq96IEaIWBUesbsQCnQeO7fVrwYdQgAx01Z74Thd90biMmsqSoOHrngeKzuBe/zaNCROFKnj3
	z/FV5qE/vUZJNVZ97iTu75kVZ75TGyGtRVnara69FrU/2SWp3zq4Cc6YVtWoQOJkWX8g6J+lmq+
	1rEK4bUkEOr331eZejM7R0jjBz3hjcAAQiTbSmqz3Oz21GdNdxWh/CZqzcpYuI9okLjweW9vH57
	JLLRqzXmh+zqIPdPZ2qgkBBnD3LoLsZ4qX5Y0tgC/9aQ3OMfbdkaV26a2TFpg+2FiEC8dBgw==
X-Google-Smtp-Source: AGHT+IGWCTFUPaSWXKXyaD6NwyBRzCc/wl0oT/qiKvRr5LnXIfHDT2nHcPZ9hY272IiSXaWD8XqCBg==
X-Received: by 2002:a17:907:3da6:b0:b73:8792:c3ca with SMTP id a640c23a62f3a-b8444f4e39dmr195819066b.32.1767782598421;
        Wed, 07 Jan 2026 02:43:18 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a234000sm484966666b.4.2026.01.07.02.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 02:43:00 -0800 (PST)
Message-ID: <64698c47-18a8-4dae-938c-ef8203031396@blackwall.org>
Date: Wed, 7 Jan 2026 12:43:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: bridge: annotate data-races around
 fdb->{updated,used}
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>
References: <20260107083219.3219130-1-edumazet@google.com>
 <40b42159-d7d7-44a4-9312-24cf87fd532b@blackwall.org>
Content-Language: en-US
In-Reply-To: <40b42159-d7d7-44a4-9312-24cf87fd532b@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/01/2026 11:00, Nikolay Aleksandrov wrote:
> On 07/01/2026 10:32, Eric Dumazet wrote:
>> fdb->updated and fdb->used are read and written locklessly.
>>
>> Add READ_ONCE()/WRITE_ONCE() annotations.
>>
>> Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity 
>> notifications for any fdb entries")
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>> v2: annotate all problematic fdb->updated and fdb->used reads/writes.
>> v1: https://lore.kernel.org/netdev/CANn89iL8-e_jphcg49eX=zdWrOeuA- 
>> AJDL0qhsTrApA4YnOFEg@mail.gmail.com/T/ 
>> #mf99b76469697813939abe745f42ace3e201ef6f4
>>
>>   net/bridge/br_fdb.c | 28 ++++++++++++++++------------
>>   1 file changed, 16 insertions(+), 12 deletions(-)
>>
> 
> +CC Ido
> 
> Oh you took care of ->used as well, even better. Thanks!
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 

Sorry, I forgot about br_input.c: br_handle_frame_finish()
use of ->used:
...
                 if (now != dst->used)
                         dst->used = now;
...

That will need annotations as well.

