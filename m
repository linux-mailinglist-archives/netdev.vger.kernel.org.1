Return-Path: <netdev+bounces-207792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B033B08932
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C733A7EC7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C56272E7A;
	Thu, 17 Jul 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdfoczCu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC41C1ADB
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744225; cv=none; b=GOfW4x0S5qeE5aSI+6SPtNaPNQBcD2Jm/DeGO4bSql0kev/wam9aRknnK9zHMY0nCv5zhqFjG6yrk3W2gXA7QxfalirC6HqLeD2Ct1N3xVbAHhG9OAMCDWXkTadElP5evpVs86xzDr4r/vBHdXFZKanYNUur2yqWB4mEdIen+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744225; c=relaxed/simple;
	bh=/hyJdUXwWol+ZU/FfIJroYwKlKnIGFJqjtkgf90EqO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rah0Pz2L0k/onPdwkpZZOfo/RRTlzSM+0mpgGkSBAp0G0DErCqCJtavfAHrhnCODQVfvo5AotZl7zu7lqb7zA+z/aNlFuTcCvyaiKnPE33iSeDXUO3th97jifJZITLh2oWVF+tNYuBTsoOiF4m1vR3LBYaEWzPK3NXa1OC/8SZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdfoczCu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752744221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pk8ydJJC5c5OmZtcmcN8JUGe95S7jl7Fd2Ky9LBk/lY=;
	b=fdfoczCu0w9Uxynl0eM0pcrzxzqrqdNigdsNpAWZ3P8Ta7B73UvwPbraacurENdVeHkFSD
	PjwcriTZoOA3SG8iANmSYO3s1f4diXvmQkXYlL3g40Qb6cj7nNLvNVEMYWLDzDEPokh09C
	qfnvDzgu8ozoAuct0gdOxPOMcpaAgXk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-z4UFx4tLNxqEZKPvqG_uJQ-1; Thu, 17 Jul 2025 05:23:39 -0400
X-MC-Unique: z4UFx4tLNxqEZKPvqG_uJQ-1
X-Mimecast-MFC-AGG-ID: z4UFx4tLNxqEZKPvqG_uJQ_1752744218
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4561dbbcc7eso2681925e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744218; x=1753349018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk8ydJJC5c5OmZtcmcN8JUGe95S7jl7Fd2Ky9LBk/lY=;
        b=toTFY7OTzGFgT/A0GR5IGyPwX4r1l09nkPUllrCHC7fiKys4txa4i89zq7vO54na5p
         6d1zTlXwzARfWAbxgECh9YwJ3bpUcaXQqdnpYgX8a5g4l3IoTQ9WhiGCWl/afs6S/ZyF
         yz4PjZT0u7pCPnCzyGIzG7SnRysOWYbLuJnbH0LS9v2H4Me/ZOT94KHHrlR6R6QP0ifQ
         pI4Uvwqv1shreCnqaMZLntMsxVf1ICRd+pg1wFSZNqVkbvqS4Cp3KS1TuUf9WJfSjcDn
         bOrVGUqHZgGCXukH/lvxJ/NyqJxy1CjOudnbXiJTv1qUuAaYMxJvbLq64NPDSWK5FFR5
         8Hzw==
X-Gm-Message-State: AOJu0Yy9hPcGn/wKOEy62MrMKBkfNxM19uBiNw4hzqGM4XxqICjqmmaV
	5dOhDWLvexCD5xIaef/0UPm/d+e96RBD9/xxyiRF5Ia3ENdP8xT1/NxuzifyX1EV0YUySOa24cP
	8uNwjf0sKIo5jvpdKvU4MRsloj+PyIjvT5CRldUraUQhVsijui+qW3UmhBQ==
X-Gm-Gg: ASbGncvRvOuYzMtDlx9fXtNbpI2656r1iMTs5TzJMe+C8al46S11JW7n1rdzfc2WQkY
	4PNuH2721Cd20qQ9oqJrqWgoivSl6PMLF5k97QtK6DwJ8POfYS7X7WKYjLa2ZLrOoGi352xBGZ0
	F+faK3AFbxAPl7UmvmP7h8CBFx1PASdRcgETJpUBIOyfaAh0iHw9vfyQh/EmggSrmMIxPDo6caf
	gTCDTrmwikrdrgQgRhvxaTVHUuwsp+zM3V1l1i/e07L8r2P3RmO7fDbYwL5wkrU6gWvYTVpgenJ
	zeU1yQwuEBUigIAj6/txdSzl1DY17jk9JZydkAHY5Qp4z4SHOmmogeDoFUccnYW1Aha6nHj2clT
	TaYAh7asnNh0=
X-Received: by 2002:a05:6000:1447:b0:3b3:1e2e:ee07 with SMTP id ffacd0b85a97d-3b60e53fa01mr4899682f8f.56.1752744218379;
        Thu, 17 Jul 2025 02:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIIRuvXJFAX+PbYX3qODXPeDCv3I0BzWYyJ+HgwayJhpLsOChJE+9gTCRPE3g7uIXLGjW1zA==
X-Received: by 2002:a05:6000:1447:b0:3b3:1e2e:ee07 with SMTP id ffacd0b85a97d-3b60e53fa01mr4899652f8f.56.1752744217825;
        Thu, 17 Jul 2025 02:23:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc23cfsm20540056f8f.37.2025.07.17.02.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:23:37 -0700 (PDT)
Message-ID: <00911a84-c4e3-452e-ab51-1275a43ca4b2@redhat.com>
Date: Thu, 17 Jul 2025 11:23:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] tcp: Consider every port when connecting
 with IP_LOCAL_PORT_RANGE
To: Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com,
 Lee Valentine <lvalentine@cloudflare.com>
References: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
 <20250714-connect-port-search-harder-v3-2-b1a41f249865@cloudflare.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250714-connect-port-search-harder-v3-2-b1a41f249865@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 6:03 PM, Jakub Sitnicki wrote:
> Solution
> --------
> 
> If there is no IP address conflict with any socket bound to a given local
> port, then from the protocol's perspective, the port can be safely shared.
> 
> With that in mind, modify the port search during connect(), that is
> __inet_hash_connect, to consider all bind buckets (ports) when looking for
> a local port for egress.
> 
> To achieve this, add an extra walk over bhash2 buckets for the port to
> check for IP conflicts. The additional walk is not free, so perform it only
> once per port - during the second phase of conflict checking, when the
> bhash bucket is locked.
> 
> We enable this changed behavior only if the IP_LOCAL_PORT_RANGE socket
> option is set. The rationale is that users are likely to care about using
> every possible local port only when they have deliberately constrained the
> ephemeral port range.

I'm not a big fan of piggybacking additional semantic on existing
socketopt, have you considered a new one?

At very least you will need to update the man page.


> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index d3ce6d0a514e..9d8a9c7c8274 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1005,6 +1005,52 @@ EXPORT_IPV6_MOD(inet_bhash2_reset_saddr);
>  #define INET_TABLE_PERTURB_SIZE (1 << CONFIG_INET_TABLE_PERTURB_ORDER)
>  static u32 *table_perturb;
>  
> +/* True on source address conflict with another socket. False otherwise. */
> +static inline bool check_bind2_bucket(const struct sock *sk,
> +				      const struct inet_bind2_bucket *tb2)

Please no inline function in c files.

Thanks,

Paolo


