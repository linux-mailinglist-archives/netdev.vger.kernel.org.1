Return-Path: <netdev+bounces-200553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EABAE6145
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0287D18958C3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94EC23C512;
	Tue, 24 Jun 2025 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLEFHcoV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FAD2580D2
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758520; cv=none; b=D8LsCpMRDEVmyHR2TsgggFiakkzMjIATrLzy66uaR6Xu/lXx4CgVVm+9Bj+805S0NBJekO6shYsRNlwp8GZpjU3zpRR7dknVVqFdWb53gTTm0jpL0bE0m9N/IBXgssVo36h9K/UbS703nbUHZgnYo9yhsxJxnlJcoWluHRTuQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758520; c=relaxed/simple;
	bh=23TpECU5tynvP7T6iEGzG6aLrvVV7gzw9uy4LUoxbys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3M/5Xp1fNgob8fhONlFBAsDB57VAlredrDmp9zKuA6aYtPCMFI3hWLrEvIOt5IqezhyGDcgZwpAD5iaf9S9zQfCTXveP+1RCEq2u0hhHJKnbZ5M+UsGMsyR5JHq2vZwY2o7Gb8O2iyZ0xpFoyt00rG5PBNBqzARPQr4LMDCCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLEFHcoV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750758517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+s/38bmfrKUgR691mJEWuNgTDqg+4vEShmznsL1cQE=;
	b=gLEFHcoVQKN0IlNE7Jw0wZLP6S5yc3PeCb5spRqO8FiQqVG11OaBXrkztQYa/YK38PqZWC
	wsPqg/hVt67ZXynf5os2yodutKGKCUfKuWuPDDVqcauKPlCKPcKzlV6VfTDLU019yOzzOl
	5x6+cInkmUF4aU32Ox8e7dHMMpam+KI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-Zj5MNY-INMyKt5NWjyOa_A-1; Tue, 24 Jun 2025 05:48:35 -0400
X-MC-Unique: Zj5MNY-INMyKt5NWjyOa_A-1
X-Mimecast-MFC-AGG-ID: Zj5MNY-INMyKt5NWjyOa_A_1750758514
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso2208811f8f.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 02:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750758514; x=1751363314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+s/38bmfrKUgR691mJEWuNgTDqg+4vEShmznsL1cQE=;
        b=H93xRlvl++QIFr7jbSp37gH1JMTdvPQ3tJlAHlwb7YCV+5dcQXjbkQQ9nCTqlCcKml
         dhgCXA11cuNBKVkU034jMYxT0GhMbu+86OqwRqPkWvOoTOrYRhlIsfQi1q8DW1Vuf/bz
         mUb5vVBdxzm2nPTpcp16EZAbqwPudZuYD3OrH5O4+asHv+6LyBRyHEr8W8UjHtbYA+42
         +Zin3e9uXnzcknJnTtk219uW7qgMX4B5wXWbhBxS66uToPkhkDxI+djov1ua3mPJXdws
         BQXrYvtYpHeYXJwoXYs2FvquJ8d1/1KxUI+U3b32E/S4gZPKJbzCaRTIiE/ecsLVOiMN
         XvAw==
X-Forwarded-Encrypted: i=1; AJvYcCW+Y3uxvGBzrXeePflARmbMe/TDsSMujqolLLGeWTyaeMtaRhGUtlvUAyQJql4QRyz5cE7kzHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ObGRhDhX+esiTWpDQ3nBv/8/Qfji9ECpwSPyDqwr0aiDCRWx
	IeObH/8uhF8SegWMAtY7NjMIoYqu4r5Lu507EyEeivU2wO+jT9biJnMfmr6RzxkqKTavI2iL3W+
	QDbBAyddu4Rq5cmaW5YIQQ8WNSo1NS2WO4xxsjO6zeuSYpYrDyOxZOz4QDlJO5DPN2Ga+
X-Gm-Gg: ASbGncuBTQeOFOIgbB/H9/oICLj4BySqg1n/igVAanKuGAHWXVSUpIhE8fe9qPbRd1e
	sWqOEsBvCx5oVR1pD/ZFmpXSzZxSl8PaOOFl8alky5hV+uN4rBYpAp4V+ROzmDqi7qQQjI86JB+
	QIoPKZOFaa4vWf2MFrtNrZTorFSRIekwrdOpMJJnwW66OcigeZuzTqLQlEufr/tNGWRxzTx4yT7
	TWpSdjMzlCnNIM5yCsGSGRfvPzX4HtT05dn0MM8yOLYoK/AcfxXYMaZNx5Ru3yiHU96ywDKLdY/
	lZqeonXAsoWHfqFbHku5k90zUjDEcw==
X-Received: by 2002:a05:6000:178f:b0:3a5:3a3b:6a3a with SMTP id ffacd0b85a97d-3a6d1319045mr14327742f8f.54.1750758513864;
        Tue, 24 Jun 2025 02:48:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc4+gXT6eeJIpAuc/btHMsFkS2IAKmVrYVCuTgdqHkkmTRT4msNaypU5mlZaABoATTTkh/IQ==
X-Received: by 2002:a05:6000:178f:b0:3a5:3a3b:6a3a with SMTP id ffacd0b85a97d-3a6d1319045mr14327718f8f.54.1750758513473;
        Tue, 24 Jun 2025 02:48:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f22e2sm1524751f8f.55.2025.06.24.02.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 02:48:32 -0700 (PDT)
Message-ID: <287fc833-a643-40d3-b663-72446e1344f5@redhat.com>
Date: Tue, 24 Jun 2025 11:48:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 13/13] ptp: Convert ptp_open/read() to __free()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.533741574@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250620131944.533741574@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 3:24 PM, Thomas Gleixner wrote:
>  	scoped_guard(spinlock_irq, &queue->lock) {
> -		size_t qcnt = queue_cnt(queue);
> -
> -		if (cnt > qcnt)
> -			cnt = qcnt;
> +		size_t qcnt = min((size_t)queue_cnt(queue), cnt / sizeof(*event));
>  
> -		for (size_t i = 0; i < cnt; i++) {
> +		for (size_t i = 0; i < qcnt; i++) {
>  			event[i] = queue->buf[queue->head];
>  			/* Paired with READ_ONCE() in queue_cnt() */
>  			WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
>  		}
>  	}
>  
> -	cnt = cnt * sizeof(struct ptp_extts_event);
> -
> -	result = cnt;
> -	if (copy_to_user(buf, event, cnt)) {
> -		result = -EFAULT;
> -		goto free_event;
> -	}
> -
> -free_event:
> -	kfree(event);
> -exit:
> -	return result;
> +	return copy_to_user(buf, event, cnt) ? -EFAULT : cnt;
>  }

I'm likely low on coffee, but it looks like the above code is now
returning the original amount of provided events, while the existing
code returns the value bounded to the number of queue events.

Cheers,

Paolo

	




