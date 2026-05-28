Return-Path: <netdev+bounces-292637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKmTCUQQGGoxbggAu9opvQ
	(envelope-from <netdev+bounces-292637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:52:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C25EFF65
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DC4311516C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A83AEF35;
	Thu, 28 May 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pccw+Y3S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJbiZLeq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEAD3AEF21
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961180; cv=none; b=fO8E35XwBB40r/LJFUI7BnBqbVQYW1OXdi9XbQmq8UYS8+ldLf8ckj39FbLkIiXoffA3+IThMlWeOXwiP0rY/QycYMak4yusLbcVGs23Q4NKW8hvKL68o9blLzubORvtOf623+3pp7hA/rLkW9oiXVsp5qwgZgGD8YR1W9DGmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961180; c=relaxed/simple;
	bh=jtJYzuyrPc3icRwf3HhR0qJzXbstw5UEhTcjKq1TpqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyAG2RdrMU7QgsLsPo7z8dLEJgO6fe8kYOW94NeLPm83SJU77sHv8fjeVzzF1YFr4EZsNKTdKo1Gv7lRknQiw/pMZYM3ETmdEx1/p4FH4z0xuN27OGGcGK/cT2KAZNhMqQyvTFLqwPXrv0pisMXFkMjKceLrjt46UObuDbZUANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pccw+Y3S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJbiZLeq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779961177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukG6nahpoo1bFNr/ZIwcZ9cfO0mxhtviRjj1KI13Bi0=;
	b=Pccw+Y3Sd6SEA7Qd8FdG+p8egGabUSfH43swMNEhya3u2TTJ0SFOfLAP6EoCyPAQJuyrXq
	5n3ikCBwwZlNH0b1orMU7kwMLVEc1xQyWqZ2u6uQW4p2ejXackcEQd3PvxydduTEOcnslJ
	NVmEHEPlXgFVE4GavfXQ7yIHSpGY7hk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-6uC_0IzsP_mPWs__FON_aA-1; Thu, 28 May 2026 05:39:35 -0400
X-MC-Unique: 6uC_0IzsP_mPWs__FON_aA-1
X-Mimecast-MFC-AGG-ID: 6uC_0IzsP_mPWs__FON_aA_1779961175
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44dad1b938fso7370775f8f.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779961174; x=1780565974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukG6nahpoo1bFNr/ZIwcZ9cfO0mxhtviRjj1KI13Bi0=;
        b=dJbiZLeq6m0Nfbggp8cKIiwEeVGhKtdUS0mKU7e4gBSI8AoTINd+N+4fAiL8Gfv5n6
         v81vXRPVh85sbDSy+MHL8JQFEuLPiTAF4vXh8rF0vZ5zJNG4IdoS9chh/vLv+mfv052n
         SAI7sCGDDYfLPI2sfOCr3E/N7bI6lMKlmhXKy8tXsc/UikPH+vPWf8g4CCoJT3bZIItI
         PhQGw8YakN6XB7mPPQhkPaJKpqPScxJWCxRYaNyVrPh96CUv97skl/yyiykW9uHdzocf
         IzhcGbVYddABoJ0PzPgjfh9arMbZdh/8KNJ+ZrLYXRyKAxrtxDHwJ+x3awtPSaXaLwYW
         AcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779961174; x=1780565974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukG6nahpoo1bFNr/ZIwcZ9cfO0mxhtviRjj1KI13Bi0=;
        b=krjitUylHV6uLB5CsyV6aap0599B5TTWzInGoLo2IHVdMujyjrGZ3ncM0lhG+o4N5Q
         nDd9NVZgUJfRAu8O4ksABvK9RkUHTW2sUT4V8OzJfPSqXWNEFt6sNcpm+uzF9H+TtPmX
         0+HhpuN7rcYxfm/P/QODWZA7IM7xFBZSI8JNOaoe/LN1jDRq7Gf87fiLVYqczTgV9Aar
         0rrZWoKOsvLB3UQ9NchkAM2cs1MMu5jSZlyZqAnsL2KA1lIkrmFJsAXQauX8fYEsMWu/
         6v6s3tQp7tVWCW9f1VJl/Yv1DrJfTKBMCebADvrCnJh605WR7qgh2ZoPAcYnbaCMG5/k
         TOMg==
X-Forwarded-Encrypted: i=1; AFNElJ/SMBbC+Hmuhqh/YMq5knIWKUAgR0fcw5IexokurpefOnJHPecJqOTTrmdd0v9Fln1usA4XoUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQ5/jyC6A1miyvXTYWAxNf1oh/QbVyuyfm7sUKmnpLolRBNC5
	w84SI4ozSz7QGYkaun0+QyBDxqXdxoULf0wlH4FNIn/2ydy/Lkj1l2I5s3+kBG3Bc4r8hHYzKgO
	lp7goUyVC8rpnvVYjowk5xlVfNc519Qu6gCG2vxkNvRaUNiL1X1JLdOIPNA==
X-Gm-Gg: Acq92OHuit8Ulcrj4X010/k+LB9DQZlrfwBvEKo2DeyAaFAtd3BF4mNt6rUXB6psSF8
	+KjGYZpFHWgeQw6VhX/1cgq6pH9l9W+g3R0Pkivht1dWVAyWIa63ycGTc//EPdwa9o47uublMnI
	c9hlR2q7VBRt3r8ngT8dgPokn4x1h35nDE42oi8xN8N/Z3+Cc6fGkjN8VefM5MqjBJiAPRzp0JP
	z+EHXQrQBWJVN7Lny9od7Gx/dfGZX+e02O/0s8idsr2mVgvpCbXUeXFyLbgdrbhG7sBJjKWldnl
	vbmUWupueaSa/0HRnsibcSTKRewv6qi+AiIGYGXpntbpu66A3GAhRL3GTWqbPOw5Z5X10BXnPqQ
	WZFO4gcx1//0zJBI+w8ByEmDy/GATWV/heJFfB9KFKlC9NEoPL8FXnmRavLroJr0bgQ==
X-Received: by 2002:a05:600c:4510:b0:490:3d2e:b67d with SMTP id 5b1f17b1804b1-490428eb9aamr410389975e9.30.1779961174588;
        Thu, 28 May 2026 02:39:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4510:b0:490:3d2e:b67d with SMTP id 5b1f17b1804b1-490428eb9aamr410389655e9.30.1779961174125;
        Thu, 28 May 2026 02:39:34 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909294cb81sm26263475e9.12.2026.05.28.02.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 02:39:33 -0700 (PDT)
Message-ID: <00d370e4-b697-492a-85d6-04bd6203327f@redhat.com>
Date: Thu, 28 May 2026 11:39:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net: lan743x: ptp: Fix simultaneous PEROUT on
 PCI11x1x
To: Thangaraj Samynathan <thangaraj.s@microchip.com>, netdev@vger.kernel.org
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 richardcochran@gmail.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch, Raju.Lakkaraju@microchip.com
References: <20260525094931.10371-1-thangaraj.s@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260525094931.10371-1-thangaraj.s@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,kernel.org,google.com,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-292637-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 670C25EFF65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 11:49 AM, Thangaraj Samynathan wrote:
> The PCI11x1x hardware supports up to 12 PTP-IO pins as simultaneous
> periodic outputs, but the driver was limited to 2 due to two bugs:
> 
> 1. ptp_io_perout[] was sized by LAN743X_PTP_N_PEROUT (2) and n_per_out
>    was hardcoded to LAN743X_PTP_N_EVENT_CHAN (2), so any perout index
>    above 1 was rejected immediately by the PTP core.
> 
> 2. lan743x_ptp_reserve_event_ch() refused to assign a channel already
>    in use, and lan743x_ptp_release_event_ch() unconditionally tore down
>    the hardware channel on first release — both preventing multiple pins
>    from sharing the same event channel.
> 
> Patch 1 introduces PCI11X1X_PTP_IO_MAX_OUT_PINS (12), resizes the
> arrays, and sets n_per_out conditionally for PCI11x1x devices.
> 
> Patch 2 fixes the channel assignment logic: maps perout indices to
> channels via index % 2, adds refcount-based sharing, and guards
> hardware teardown until the last user releases.

IMHO the above are not fixes, but features and should target net-next.
Also the split is incorrect, as introduces OoB after patch 1. You have
to split the series differently, i.e. introducing support for multiple
pin per channel (without raising the limits) in patch 1 and raising the
pins limit in patch 2, together will all the required buffers adjustment.

Also note that sashiko gemini pointed to a few pre-existing issues that
should be addresses in a separate net series.

/P




