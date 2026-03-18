Return-Path: <netdev+bounces-269187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC2GOggZu2nLfAIAu9opvQ
	(envelope-from <netdev+bounces-269187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:28:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEA22C2F9F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A43D30692C2
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441337B035;
	Wed, 18 Mar 2026 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9KuRg/9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhrLhGFD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541537B417
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869277; cv=none; b=IHUb+JFGD5VcjvykqOyy6df/lTW54cYDGtyumH4oijKIYTpqKtqIIUcWUE3WvOO1ZtEDs8lcW39WJjqKCuB8/H6FUFJsThOi9+rHyr+pVFzZX7RGw70XXxjn77F8OMl6eIhqfEFBHNmequYnEpqeKToF7GYnzO/zNV/qXusL998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869277; c=relaxed/simple;
	bh=YgjTjzim5DQCK/B9p0xNDkAjovH4rTxfWA70MEVloLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B/KSLNmMb3gaXfDmu0hbcO4FTJc34/r6nOgstxmcqGqoxRMNHkYH7oNs8ekjP22IC232kmd2JxdV1o5oPP9W6CG9FcsqJREFQCuckV77J/QDtZbsPrCznD1qslwJQ0keprawA8+lTa7Te/+XLteltuJNtFpLkbJwZlIEnnQDnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9KuRg/9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhrLhGFD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773869275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jrnydhjCX2n9qZspnsidoy2e60uVHKDh295FAK0AoyI=;
	b=S9KuRg/9iD2WnmH7mo18TbnPXMH/+K/64TpeD/JB1jo6YT2SAfhBDQqZ1yqlee4J3tMXYw
	eAlC5F+3EnwwgR2y9FRGI9Ip9FcXJOfHGEV+r+NiARwG2VFvm5dAUU6SZzbG/IeMsMa2ED
	0r/WpRxcFI2gAW7/t9AGER9wtvK69RE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-6nQGPd-4OcWXQpuZLaCmwA-1; Wed, 18 Mar 2026 17:27:53 -0400
X-MC-Unique: 6nQGPd-4OcWXQpuZLaCmwA-1
X-Mimecast-MFC-AGG-ID: 6nQGPd-4OcWXQpuZLaCmwA_1773869272
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-485c45885e6so6334285e9.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773869272; x=1774474072; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrnydhjCX2n9qZspnsidoy2e60uVHKDh295FAK0AoyI=;
        b=IhrLhGFDGIpED6xfp0d7p0ywaVz2kkRpaFW41nxMV/qdwxrZmvtG1jvyu94eL50Kgz
         9y/2SBW/Udz5oDcDzgmBnie3UMWLXwcIdTaVitg0549k7aHGVQ09cx+q+djPp0ICWf2/
         0JJ+1WWRNVr0WHnQpsPSc6oGTRlAkW6Td8WH5uxMZiS1NcHv5KcX9MfhYlk6m933LWq2
         aTsZVRhKNgZoPTtffoJ+LaJWAdHSCDisH1qp/18PfwSI6L8LOZHO1KRXj6dBpKeqslKM
         4o2NadbY4kh4MPZHl0qafMHoIDwL2qMcJnXlf/zRWsQRlPCBdYAdgsS5Zzxmm7cQWbDW
         h3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773869272; x=1774474072;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrnydhjCX2n9qZspnsidoy2e60uVHKDh295FAK0AoyI=;
        b=ad0KwGwLNuvz46o3zr6ftj9W+j2zTCen1gMnajvhOe9usVWuo5ydMK1HWVpdv/+1ck
         EPVH9Dro07SzSgwtM8CfQs12CYWIWxhcZ9aqhfwQKfA2ufIoUxGYQ+gs66akPiHxxaB/
         IAoYIV6INYpHg5/BI8l6Yx90/V+9WCpBHM2hWdvvprVtYNmlDXwKA1DSrg8eI7uOlfsv
         XH1wP51JHCx3iWpIxOkE43/Nld+33rcOZqoMZC/Nm2hMvGcAkT/oifzF3hIZMKS3+lbx
         OnCOM0VsyNSYi9uT3qqt/CiYQ6WapER60Qcq9rZfETmP036FwcJYy67TLD4zHlEMkxr3
         /8aQ==
X-Gm-Message-State: AOJu0YzkASV0pyoBUToidqWvrdp/kYWRXrIjcSeoBXqYb5GtZPRg5pDS
	Zz7H2wKYu7HWc2DPt631Xgy9LSm+XqBqTJNXsarrIOUeUfFei4rgFY63QCl8XvX6ucorvrjjDKY
	DI5BSAzoGN4cLRG15wMmV4IDfyulalnZIMzRwMa3X6AR8v4FyY7Pw3C6GRw==
X-Gm-Gg: ATEYQzybdzk8FusLmVHQvTUpRlEBrNH0sF8xv0CkpAniSLWnfCm6+bmSGfFntnX+lUc
	AhdsmnvjsnG6D5C0ZUdiMpnSCY1qIsNEA/hMYGjMW+1hNnSkbdxZz9DVFuryVetblBEQmw8qZ5F
	zDeRS8GV47W4Uwrltgr3lMG37axS0jGAmIkmc0Qp+v/lQNdgRbMVAvhe5SbHCtrcQTP8Ir0non/
	I1FPHTf25PkPhDzEyL76Gqh7cc+AQPaV6PaQxPXy2q+pRQ1hl5DCNO3wKp0wv14jSuAV8Zdo1SH
	0yvGE78VKYt4n8VeJSCgxgHmxYpcEFukj/wJLAMBPB2J+W12j1XPAgVT3XS9l+b8zYBxdQmWhDF
	tbTPwkpurfKJ2Nqfze6Kc7yOslCIHzyiLQbSxyW9g8JqcfXUgF2xGeA==
X-Received: by 2002:a05:600c:1992:b0:486:fad0:b166 with SMTP id 5b1f17b1804b1-486fad0b2c8mr1146615e9.17.1773869272179;
        Wed, 18 Mar 2026 14:27:52 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:486:fad0:b166 with SMTP id 5b1f17b1804b1-486fad0b2c8mr1146305e9.17.1773869271694;
        Wed, 18 Mar 2026 14:27:51 -0700 (PDT)
Received: from localhost (net-2-39-43-132.cust.vodafonedsl.it. [2.39.43.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f5e1ab8esm24843235e9.35.2026.03.18.14.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:27:51 -0700 (PDT)
From: Paolo Valerio <pvalerio@redhat.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?utf-8?Q?Th=C3=A9o?=
 Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 4/8] net: macb: use the current queue number
 for stats
In-Reply-To: <500d698680fb51285f78fa68b6e41875@tipi-net.de>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
 <20260313201433.2346119-5-pvalerio@redhat.com>
 <500d698680fb51285f78fa68b6e41875@tipi-net.de>
Date: Wed, 18 Mar 2026 22:27:43 +0100
Message-ID: <87zf443k1c.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269187-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email]
X-Rspamd-Queue-Id: 5AEA22C2F9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nicolai,

thanks for the reviews.

On 16 Mar 2026 at 05:30:48 PM, Nicolai Buchwitz <nb@tipi-net.de> wrote:

> On 13.3.2026 21:14, Paolo Valerio wrote:
>> gem_get_ethtool_stats calculates the size of the statistics
>> data to copy always considering maximum number of queues.
>> 
>> The patch makes sure the statistics are copied only for the
>> active queues as returned in the string set count op.
>> 
>> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 06ad8c8ec036..fbeaa85b4a9c 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -3528,7 +3528,7 @@ static void gem_get_ethtool_stats(struct 
>> net_device *dev,
>>  	spin_lock_irq(&bp->stats_lock);
>>  	gem_update_stats(bp);
>>  	memcpy(data, &bp->ethtool_stats, sizeof(u64)
>> -			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
>> +			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
>
> This is an out-of-bounds write, not just a cosmetic change.

yes, the commit message is not perfectly phrased (and as you
noted it lacks the Fixes tag), but this was not intended as a cosmetic
change. I noticed the problem while adding page pool statistics to
ethtool (later removed) and they were corrupted because of this.

> gem_get_sset_count() returns GEM_STATS_LEN + QUEUE_STATS_LEN *
> bp->num_queues, and ethtool allocates the data buffer based on that 
> count.
> The old memcpy with MACB_MAX_QUEUES (8) writes past the end of the
> buffer on any GEM instance with fewer than 8 hardware queues.
>
> KASAN confirms on RP1 (1 queue) without this patch applied:
>
>    BUG: KASAN: vmalloc-out-of-bounds in gem_get_ethtool_stats+0x50/0x78
>    Write of size 760 at addr ffffffc0822e7000 by task ethtool/922
>
> The overflow stays within the vzalloc page slack, so the practical
> impact is low - but it's still an out-of-bounds write that exists in
> the current upstream code. Might be worth splitting this out as a
> standalone fix targeting net with a Fixes: tag, and updating the commit
> message accordingly?
>

makes sense. Will do.

Thanks!

>>  	spin_unlock_irq(&bp->stats_lock);
>>  }
>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
>
> Thanks
> Nicolai


