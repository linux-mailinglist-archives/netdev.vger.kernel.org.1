Return-Path: <netdev+bounces-188348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A7CAAC704
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858A4467D02
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6728003B;
	Tue,  6 May 2025 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUe3A7Um"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59A27585E
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539639; cv=none; b=YC3I2A37FsuwL2Dd/ZFhK23lROMMZlSMNDl++lOHq6IWOfQrbrEF3SRMuhqDMnVSdgwC7XXBzgu1mxtJpjk0hGufxf6vHlEGIzONjG6H+JBG1sAtd0MBrJ8fzjzDGSCmQ7eegbAsPGmeE6k6NJbfFQqazttbZgNnRqCbLuU+XSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539639; c=relaxed/simple;
	bh=jk8IPUOhFSl7xS+J+w5S6t5sEdN30Mlqwf72SBoEAhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/NY90hMyqmTFQN1W93ZrT6nPSjJoJ/lA/FM2q9Iow7qXIFx1DcyI1r6Uyzft0RR3nPLU5g+bhtzOuhmtyIQpXDstt5sPxF9y0JujnlJ2qzoqqkrfyX0a+JyTx9h/3zn3LQtauskCW/0/Dfu3MZ0ouwoBkr6iLb9M0GiXQKmiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUe3A7Um; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746539637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLfPkVVABPBRhYmPGTE54pe7g1W2AfEmrluw2R0EMC0=;
	b=JUe3A7UmUxz5sYcYWlCcf99c0KVyfTIK5RRZjBJOlFCE6gfGZkbazRftcmD/+6tu6S5x7F
	YBMqti+kciUH+QRyzs2nySOR0BwVErIyXjGoLKaAS+dY08rJkPpiM+Zg6Qrlk8f1Ua9784
	FBseeMIuJvTz6kf/oMSLkdjzI1ffmq8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-Jq4NDXIFPbWuG4BJdGlKOQ-1; Tue, 06 May 2025 09:53:55 -0400
X-MC-Unique: Jq4NDXIFPbWuG4BJdGlKOQ-1
X-Mimecast-MFC-AGG-ID: Jq4NDXIFPbWuG4BJdGlKOQ_1746539635
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39c1b1c0969so3413947f8f.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 06:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539634; x=1747144434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLfPkVVABPBRhYmPGTE54pe7g1W2AfEmrluw2R0EMC0=;
        b=aDHpD/GUt5ANRVE93vqKHzxNzNWBCjb7EY9EbqJXNOhllw7cag2Ii9WmrlqWQ+YvhK
         jxVkuw3KPlusHrFjG41iTA2ZR/EGVxEn5EzZhXRaaeWHU7j8B/XcL8A27nhPxgmNMK0z
         3n0iFkr5uXekBEIt6PtNVeF7oTSB+9b61T+hACLxD/ksYTY/G9H1A7mXEtKHlAcni7ld
         ZaiGGWKqa1ebaNZG0ABVDL5cQOtIPzgXtCgELOT+vQ+qqEG6I4XHbnLmfXlYADPL9dc1
         9VRmGpad9DWryq4u0PS47SiDLjL80U568ZSrlNgi4Vfuc7cB1M5N9U1+kZ+98OFsyW43
         9bcg==
X-Forwarded-Encrypted: i=1; AJvYcCVRZyb/DXQg3gn/QahpHGSZM++hkTVn5z8o0G/6zkjvuw+H8PT3gqsCkfdEgH3PQHIekHMDckA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbrv6Q8UKcX3HlenrR+nObrORULTJinkfJRGVaJXfD9Kmtnjoy
	ziXzc1Ol16jfEOr1A3dlk78aqhwyePzeD1MUovnxzHjDnLbNMxB0mmXrJ5qLYJPZxw0bIC1TNLn
	7Rcz07FhzVdqYdvgxnDnv2LT8HBixJsW0Blt9b8eqPPMy4awmQB36YmyPWPHQw2kO
X-Gm-Gg: ASbGnctojG0FIFcAHfyWyhV50ehuzAUAnE1xllge+FClLSMI+OJ1rMSoOqQWa/zW4lX
	1pDlo2rX3vMBFG6zd8VKuImeS/d/1VrioSC5uk/w3Yq9WXp3g7vZKPfTYrk/JngGm+z+8R9Y/Xc
	Sg8emvkcepo+iumva1CiaGiwGG4lUnp9cNHF0ItG9z9HACAuP7JvNxLqQEVHFd5j3dPrhB8mTyT
	RuRkYzJa7Eq0oUvas3bMwJW6qkGgZ9cazbdHV+rj6CEwZ/8bqsx6aCbnNyVRHdN/R4MB1b9FA+K
	fEFkdx279vM7pocU+Kk=
X-Received: by 2002:a05:6000:2088:b0:391:158f:3d59 with SMTP id ffacd0b85a97d-3a0ac0d9677mr2845774f8f.15.1746539634484;
        Tue, 06 May 2025 06:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERNkkEZ1YZO8UUeB8eWmn9YMDglheLIo0HlsBm7ofvZQ1M5dC+wSsDFMe03Ll69zv/fiASgA==
X-Received: by 2002:a05:6000:2088:b0:391:158f:3d59 with SMTP id ffacd0b85a97d-3a0ac0d9677mr2845747f8f.15.1746539634052;
        Tue, 06 May 2025 06:53:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010::f39? ([2a0d:3344:2706:e010::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffb1sm13727733f8f.73.2025.05.06.06.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:53:53 -0700 (PDT)
Message-ID: <39fd697c-bff1-4d09-8979-c2a43a749c25@redhat.com>
Date: Tue, 6 May 2025 15:53:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 07/15] net: homa: create homa_interest.h and
 homa_interest.
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-8-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250502233729.64220-8-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/25 1:37 AM, John Ousterhout wrote:
> +/**
> + * homa_interest_init_shared() - Initialize an interest and queue it up on a socket.

What is an 'interest'? An event like input avail or unblocking output
possible? If so, 'event' could be a possible/more idiomatic name.

> + * @interest:  Interest to initialize
> + * @hsk:       Socket on which the interests should be queued. Must be locked
> + *             by caller.
> + */
> +void homa_interest_init_shared(struct homa_interest *interest,
> +			       struct homa_sock *hsk)
> +	__must_hold(&hsk->lock)
> +{
> +	interest->rpc = NULL;
> +	atomic_set(&interest->ready, 0);
> +	interest->core = raw_smp_processor_id();

I don't see this 'core' field used later on in this series. If so,
please avoid introducing it until it's really used.

/P


