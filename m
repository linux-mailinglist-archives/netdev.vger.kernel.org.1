Return-Path: <netdev+bounces-207801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E275AB08994
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA7FA41153
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C828B4E7;
	Thu, 17 Jul 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gUf9+l6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF728C2C9
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745447; cv=none; b=T1BhLdvLR+7yZVihM1rUmUmusdW3xdjZpItk64z7VZKbIKLn+yQqSdWF6zcW3aVH1SXbFNUo7DTYv5Sr4VY1Kx5I/15xryx663Gn9P5Yp0B6Uvlj3yceXdDiNUUlD40LEqG6IDTZsgONeRInEoF6XFV85j+T2dqYBcPQ1NGA8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745447; c=relaxed/simple;
	bh=s1NDVvyZfP0gKGIvF44jtm9qZ3eRUKB51HiwPgrUrSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I6QFNNdwzx6nX2CPyj7qYM7typTqUXP+qNXo0ZVFBqaMi1iBL7DBKmhxZqrUaJj0VuhiIjzjKV1HPOqg79CT5Y0kZgr4gGHfaKYh9eIVQoeXeHYyBnaRlqYIk262Jfj4wKMjgQNLeXmogE+vlbAvwKVFf/5XnGGIPJi6WbuHiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gUf9+l6T; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so112412466b.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752745444; x=1753350244; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAAM4lhv5izq63j2Nmr8n05a/M9PT/HbyAE6Oglq2GU=;
        b=gUf9+l6TrrrEk1KW9acbb5lJoc9HRW3IfIQ26JOGGI6FwpIDkgwruTCP0Uspinv1xw
         gHbxpX2t00MZQfYRYKfC0nSe+be0Bla5gpdFF/M8yZS8iglg8fdJt3Jh4BO6igjMPBk8
         cjpVcFrfuvi6S8V6474Zo+6E4vo9tSrAsteh4gMnSRoMftNzV1aIEPiVyHSB4EfSBM3r
         mhhpyOZAbh2dfuktdEUB26CTxIDdOAY2FO1EMPzq5tofPIhKBhybFm8Gpbm4B76lnqcf
         SWAkUtEsQTJQWCVKkdwKpsdcBUv8JFIhY5f24m5LxmHEtaOIOqCaOW7gAypXG8rGDrZj
         U3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745444; x=1753350244;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAAM4lhv5izq63j2Nmr8n05a/M9PT/HbyAE6Oglq2GU=;
        b=Z0KzwlMDTK9/8O+6DH+Mdt4sU10I4xJVYjfkW0hOXZwatOyefJfPS4dtF2OMMQW+iJ
         UiDJtjNzlKDh6DlWGIUrVMPaWT/QHntf+pP9KqkIi4j2x7syAwKfJd3kFyfkVVmUnfwP
         e4PuQtrFJPPUO4s/TkkbKba01BxsiNwGsefQHQjO11EgH1AIMjAtr76NvXMOZ+N6sBxQ
         hDKhyqlyfrAj2BERiJ7dz/tQjZAqSaNgvRDBaw8lDUC5xYpx3yYm/QPv232A7TsFjOS8
         GyaGXbnY61MKK6l5ZFaLRvKHBTyRWw+9wY01UUOEDQ+8AITeUqbT12nXTTSJtSRo/htH
         xT5w==
X-Forwarded-Encrypted: i=1; AJvYcCWqGxNEUAiIvp3UE/Bd4oXQijHZZQSRfP1D1rtftp2ErmCPLakgZBX0UYY1YXJjxz1MlDN27Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4jSnMwFjos9sdH01WSEXCXFfhh8bDwnHGqaEzZ/x0qjeLwbLe
	zSBp1l+DGCHs/TKVMOUd4tIRj5Dwv++PBoWlCSIAP6qQqu/eoDMjjLieGADWr/WIJpY=
X-Gm-Gg: ASbGncvg+375P5ZOnb7imYU0sPC+uKVuj68Bynl+mBq40ImWinQZOqxrLud4gU8rY+H
	SqVkvUhcA6lr2LTdSz84DIfbQowy775T5SOAwbtqx04fYwbxnvdxHJtsu1S3/VqqIrl7E51ioEv
	RgjTZ4aAWu24lU6gX/ZmQIABQxE+JVk6Madv8tSHsKsRNuwDznDCtfJtXuWAlWmr6ldic7rY+R9
	cpTvl++SZzD0A3/KpSrjdkqPEXa+5jmcA61zwYuqWeUPT5BcevQSrzbv9Az5AoPAKIUEFXwveOC
	4CgZGP6objvjw9bpzsnsmS/4ffO+u3G5d4HKPUpB62s4MQZ2LMIsRg5jSDvQFXMOGHfMMEMuq5K
	lxXIUYGHrzyv284g=
X-Google-Smtp-Source: AGHT+IGKY3d6AejIhGW2dFthMByllYuOCw/qzOz/07+rLOXQ1/KX0RCXAln1gsm/AIarbUxdyKZujw==
X-Received: by 2002:a17:907:724a:b0:ae6:abe9:8cbc with SMTP id a640c23a62f3a-ae9c9940c17mr655593466b.12.1752745443795;
        Thu, 17 Jul 2025 02:44:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e9235esm1346494066b.12.2025.07.17.02.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:44:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  Lee Valentine
 <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next v3 2/3] tcp: Consider every port when
 connecting with IP_LOCAL_PORT_RANGE
In-Reply-To: <00911a84-c4e3-452e-ab51-1275a43ca4b2@redhat.com> (Paolo Abeni's
	message of "Thu, 17 Jul 2025 11:23:36 +0200")
References: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
	<20250714-connect-port-search-harder-v3-2-b1a41f249865@cloudflare.com>
	<00911a84-c4e3-452e-ab51-1275a43ca4b2@redhat.com>
Date: Thu, 17 Jul 2025 11:44:01 +0200
Message-ID: <87qzyfdue6.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 17, 2025 at 11:23 AM +02, Paolo Abeni wrote:
> On 7/14/25 6:03 PM, Jakub Sitnicki wrote:
>> Solution
>> --------
>> 
>> If there is no IP address conflict with any socket bound to a given local
>> port, then from the protocol's perspective, the port can be safely shared.
>> 
>> With that in mind, modify the port search during connect(), that is
>> __inet_hash_connect, to consider all bind buckets (ports) when looking for
>> a local port for egress.
>> 
>> To achieve this, add an extra walk over bhash2 buckets for the port to
>> check for IP conflicts. The additional walk is not free, so perform it only
>> once per port - during the second phase of conflict checking, when the
>> bhash bucket is locked.
>> 
>> We enable this changed behavior only if the IP_LOCAL_PORT_RANGE socket
>> option is set. The rationale is that users are likely to care about using
>> every possible local port only when they have deliberately constrained the
>> ephemeral port range.
>
> I'm not a big fan of piggybacking additional semantic on existing
> socketopt, have you considered a new one?

That's a fair point. Though a dedicated sysctl seems more appropriate in
this case. Akin to how we have ip_autobind_reuse to enable amore
aggresive port sharing strategy on bind() side. How does that sound?

>
> At very least you will need to update the man page.
>
>
>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>> index d3ce6d0a514e..9d8a9c7c8274 100644
>> --- a/net/ipv4/inet_hashtables.c
>> +++ b/net/ipv4/inet_hashtables.c
>> @@ -1005,6 +1005,52 @@ EXPORT_IPV6_MOD(inet_bhash2_reset_saddr);
>>  #define INET_TABLE_PERTURB_SIZE (1 << CONFIG_INET_TABLE_PERTURB_ORDER)
>>  static u32 *table_perturb;
>>  
>> +/* True on source address conflict with another socket. False otherwise. */
>> +static inline bool check_bind2_bucket(const struct sock *sk,
>> +				      const struct inet_bind2_bucket *tb2)
>
> Please no inline function in c files.

Will fix.

Thanks for feedback.

