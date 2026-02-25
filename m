Return-Path: <netdev+bounces-261059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLT4BC5Bn2laZgQAu9opvQ
	(envelope-from <netdev+bounces-261059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:36:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A7619C591
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3B0301F18F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A285374196;
	Wed, 25 Feb 2026 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvAzgEGV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRnI/zxT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387222F1FE2
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044188; cv=none; b=RtQsKl+FGcRHz461rEo6HWhour8S1rUpFAlvJ8QaOmFCK2K8KsOzGWOcFfnKK3BZ+YGOWjDSykGNMYiN1xGpRTim78OrPBXp2HOwjStPl0VbKSWSuD0PhrP1dvx1t2myNw8FwOnQi9MAmtxX7I3t8pAzC+/X42HAtsUT66fC/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044188; c=relaxed/simple;
	bh=EXFlA5wH9D1CUWTahj3slhVcxS9w8bIegSxJkqBxGzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qe7FpW6GQ0+IqjZ7Ui3/SwRA2Q9alfoguz77a4AEpQp+5UN3YRblHk9O5sMwkavNYRd6qq45EKDTAP+m+w6i9sGyK/KXrwe7CBzMmaiZpMbldAfF3gy5O+1eU/EhuFh24P66Nx6dOmFGPDwEAHjyNHrB9nl1rK9vYjvQjBwUqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvAzgEGV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRnI/zxT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772044182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7hWdIifm81MBNyVwTxhC8GNWcQFQJuEHswTxvthk+k=;
	b=SvAzgEGVzl0gLVquiucMPeK5uLy2M4JRYDH6v9cTEki8wL6kqtwsdIkvaNXvQNjSqCtDh9
	uTVM9soPh2nGgZUodKu9yaQHeucllio16ulv9HQk3O99MuYOPTX7F/BZhNbgkljXPAgqVp
	DfQJQaRW/zu+jyOP4IekLUg1jS31v7g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-GSagLpOeNtGcMRQb8yRu7Q-1; Wed, 25 Feb 2026 13:29:41 -0500
X-MC-Unique: GSagLpOeNtGcMRQb8yRu7Q-1
X-Mimecast-MFC-AGG-ID: GSagLpOeNtGcMRQb8yRu7Q_1772044180
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4398c78d7acso9124f8f.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772044180; x=1772648980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7hWdIifm81MBNyVwTxhC8GNWcQFQJuEHswTxvthk+k=;
        b=PRnI/zxTMhLOtuCBKm1Xk/gcDzX5AM2lLMOHwun3BocdQuyuC0kGdWkdnSmq1jocGH
         o1c8tH5mVtjFPRbnQ3+Kwc5YKIiPKBYuXRkQF77+GtuXq79J2TAZu//c7VQq6+Hh2mOS
         4sCCNX3pYKAeMKIk/LHE75R0G8pFBXhMtbhcVm9vmSnUltlmYjVJ5Aw22QgQmiVFHP3F
         PQ7n+4ubBI+h6zgv+Rb+YFdyougEqze8WtLLS8JKOhTCHTt2XHFqX+hAqm5zVI+DEvAG
         H/C1JhA6/bSA80S4Hj8LGmQfcCHCPLjcXP/1bikOuH8o5mV3WBSYV3MIKs8iByrYFroY
         mwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044180; x=1772648980;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p7hWdIifm81MBNyVwTxhC8GNWcQFQJuEHswTxvthk+k=;
        b=pkHwOzp1Wjrz7DE31X5Qpn7VFnH0N1JqJgitajNvKxwhmzEJz2wlp0hzEEIf6zQpUZ
         2c4geci7JrMzpdRjr2kuij4pwzOOzjl5JDofZokvgTAu80n4Hp5MjC67JIGsYmN2YB0U
         4OnYjugYjyfAN/fBTS0xQyYtiPi2H0sRIuokjgLWdQCAHWS1RlCXVYh8iUKTiUzI6xng
         sQ8LCtaAAGxVjF65nqH74xDCP8UdL9mMJoAfTGFhWbPb7SPO5eeuCirw8PgAJE2EFj2H
         HIHKthDgzQm51Ri12+bzu8Eogz5XNDCe6mmqkwcxCIm0WSDp/CCJB1zZwFODrAgIyE6h
         QUFg==
X-Forwarded-Encrypted: i=1; AJvYcCWbVtu5AFt7lV/D4ZOpl7mpbradJFi4WhyayBUZaPY+vCxWrg3YfWqSp9623mAqNdPc3AB/y5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvPqqRnKpBAe0rGtU3ADTdb20bqznUGFun6Rxm8UC1uXx4v+qp
	+JkA3jsWPKFyAOZGjhP2np1J2RoExDIfgmhxjVwtDNY+vd4ons23R3DPBMK1/Ph8D4SBIMeVhrg
	d0Zz+vEdOOvvQcSY/FkaJ7THENVrLoBYZWQrofdWRUAl5/JWMfRTiuXYVpA==
X-Gm-Gg: ATEYQzwfmUKQ4PVcqdiDuWVS+WYe1y32GimzbHUpJsXnBj1w9i1jUNj6tE5/tpmplLg
	cbIU522/YPPhU7EYFsLT/ngxdQrCFKZAIIegrnfu6QvHYp7tJ6M0SOecK8IhXZ6KJU48ZQiHsbo
	QR7vLJxTqHWzA6R55d7A5EQe5nXSpo/1yWeipM38LrrV5jMdQ72HAvt5WO3i3E61SjnG8zOVjO6
	8JKw38J914Cz7gC1Oo5VPiLlJYI6Qa7hHTzu1jjZn/BZMukusjU5Kwj89afOlyDewsy0JMSLCpE
	cqRTAcY5+AdcoaPX9BgNAbI7Zo2znuAYE8OMI+zino4ep6KXmqIRX41TGSH9OJB3LDNvsICSiEQ
	vc3uaU7ytI7F/0+Z42V7jm15k3VYgAppoWBeNMy3AF55vzV1ZP4ogqwbXunk=
X-Received: by 2002:a05:6000:24c1:b0:435:ad52:31e0 with SMTP id ffacd0b85a97d-4396f15b26amr32688634f8f.16.1772044179806;
        Wed, 25 Feb 2026 10:29:39 -0800 (PST)
X-Received: by 2002:a05:6000:24c1:b0:435:ad52:31e0 with SMTP id ffacd0b85a97d-4396f15b26amr32688599f8f.16.1772044179340;
        Wed, 25 Feb 2026 10:29:39 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398bb96b90sm11346991f8f.9.2026.02.25.10.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:29:38 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
 edumazet@google.com, pabeni@redhat.com, theo.lebrun@bootlin.com,
 netdev@vger.kernel.org, lorenzo@kernel.org, andrew+netdev@lunn.ch
Subject: Re: [net-next,v2,1/8] net: macb: move Rx buffers alloc from link up
 to open
In-Reply-To: <20260224000841.140390-1-kuba@kernel.org>
References: <20260223182632.1681809-2-pvalerio@redhat.com>
 <20260224000841.140390-1-kuba@kernel.org>
Date: Wed, 25 Feb 2026 19:29:24 +0100
Message-ID: <87a4wwn0cb.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261059-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 61A7619C591
X-Rspamd-Action: no action

On 23 Feb 2026 at 04:08:32 PM, Jakub Kicinski <kuba@kernel.org> wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net: macb: move Rx buffers alloc from link up to open
>
> This commit moves Rx buffer allocation to macb_open() to enable early
> error propagation, adding a fail_early parameter to control whether ring
> initialization fails fast or continues on error.
>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/=
cadence/macb.h
>> index 87414a2ddf6e..2cb65ec37d44 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -1180,7 +1180,7 @@ struct macb_queue;
>>  struct macb_or_gem_ops {
>>  	int	(*mog_alloc_rx_buffers)(struct macb *bp);
>>  	void	(*mog_free_rx_buffers)(struct macb *bp);
>> -	void	(*mog_init_rings)(struct macb *bp);
>> +	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
>>  	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
>>  			  int budget);
>>  };
>
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 43cd013bb70e..8cc16f2b4024 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
>> @@ -2544,8 +2547,6 @@ static int macb_alloc_consistent(struct macb *bp)
>>  		if (!queue->tx_skb)
>>  			goto out_err;
>>  	}
>> -	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
>> -		goto out_err;
>>
>>  	/* Required for tie off descriptor for PM cases */
>>  	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
>> @@ -2557,6 +2558,11 @@ static int macb_alloc_consistent(struct macb *bp)
>>  			goto out_err;
>>  	}
>>
>> +	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
>> +		goto out_err;
>> +	if (bp->macbgem_ops.mog_init_rings(bp, true))
>> +		goto out_err;
>> +
>>  	return 0;
>>
>>  out_err:
>
> [ ... ]
>
>> @@ -2951,7 +2971,7 @@ static int macb_open(struct net_device *dev)
>>  		goto pm_exit;
>>  	}
>>
>> -	bp->macbgem_ops.mog_init_rings(bp);
>> +	bp->macbgem_ops.mog_init_rings(bp, true);
>>  	macb_init_buffers(bp);
>>
>>  	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) {
>
> Is mog_init_rings() being called twice in the macb_open() path? Looking at
> the code flow:
>
> macb_open()
>   macb_alloc_consistent() at line 2967
>     mog_init_rings(bp, true) at line 2563
>   mog_init_rings(bp, true) at line 2974
>
> The first call inside macb_alloc_consistent() initializes the rings and
> checks the return value. The second call in macb_open() appears to be
> redundant: by the time macb_open() reaches line 2974, gem_init_rings() has
> already refilled all Rx slots via the earlier call.
>
> When gem_init_rings() runs the second time, CIRC_SPACE returns 0 because
> all slots are filled, so gem_rx_refill() effectively does nothing. The
> second call reinitializes head/tail pointers that are already set and runs
> a no-op refill.
>
> Should this second call be removed to avoid the redundancy?
>
> Additionally, the return value from the second mog_init_rings(bp, true)
> call is silently discarded. The stated purpose of this patch is to "fail
> early and loudly rather than init the device with Rx mostly broken," but
> this call site doesn't check for errors while the call in
> macb_alloc_consistent() does.
>
> If the second call is intentional, should its return value be checked?
>
> This was noted in the v2 review by Th=C3=A9o Lebrun (Jan 8, 2026) who poi=
nted
> out that commit 99537d5c476c relocated mog_init_rings() from
> macb_mac_link_up() to macb_open(), making this second call redundant. Pao=
lo
> acknowledged this with "will do" but the duplicate call remains.

yes, this definitely is not intentional. Must have been left/reintroduced
by mistake while rebasing v2, sorry.

> --=20
> pw-bot: cr


