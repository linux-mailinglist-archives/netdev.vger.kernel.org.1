Return-Path: <netdev+bounces-249038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE57D130B7
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7598E3014BDF
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A252DF132;
	Mon, 12 Jan 2026 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPvC5HOy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOz4tqAT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5F239E9D
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227309; cv=none; b=Lb0VS+7rzU3xQa3TvJnQpRei4NgrtLfbLpBowkUVzCwxK4S7t5h/rxijlwOGIR7qbcjqGUtbxmH08mvNtJBFa5h/AOsYl/q1KQYSk14kHHMhj7Hh1IdxAs7fKjdlFXFpGRL+Rei5Pu+HFl2dg/lfH+Ud+CXPgkuoAzSltB7AYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227309; c=relaxed/simple;
	bh=dLg3OpAGmul/To2C5LRXdXf7ZNa/H/LqMzTbuoBWK1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bH6IT3neGzYeLMQEWFhHAgWciSMDOQkTldw+Q2DbA1X2So/PzPnQzcQ8GP6K1NmPvPA16tMTySzJaAfKOL4F6uMc+sszN2O0fSfx5IHAqjaYS4hC0vYegq5BCMfBJPXEaBrqq886kK0zy0We5gl+MC99paf6CcYnOUsUltUWVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPvC5HOy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOz4tqAT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768227307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtegIXVuMjOvcTte7gKCU1ovVtkkfM1NfzdJy4Mh1TI=;
	b=dPvC5HOydaX/XM82dcbdyOV2tVP8CG6MaTH62mzl0KLABvqMHLv4FbpjlRnWoa3c6z2O6k
	6P7VZsVSUCQBps7D5CIXHjt3v8EkTwUTgopuY6yb2aXQkGZ9zxxscSVIJEE/8fSYEWZjq+
	FyrlJuqm254IXmhzv8d6Q4NZOwXSHYM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-CNB1wPYvNFCp_LlmthSNew-1; Mon, 12 Jan 2026 09:15:06 -0500
X-MC-Unique: CNB1wPYvNFCp_LlmthSNew-1
X-Mimecast-MFC-AGG-ID: CNB1wPYvNFCp_LlmthSNew_1768227305
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477771366cbso50043035e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768227304; x=1768832104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtegIXVuMjOvcTte7gKCU1ovVtkkfM1NfzdJy4Mh1TI=;
        b=NOz4tqATuRR7kplqlJKXHpKdh5hm7y43Xf/960AIE4/OHoZr9/8u1dWvQ5dPjzHXnI
         iwU9NNwDrE61jsTJogcetg2H+NvqsYSM1y+3RJ4Polv7FBCU58SF+DgqEV9o60kFjFql
         qZOa5w+jdc2np6jzKH1kdIl0NbMR0Td/2oCb7Sa/w+SXIAfQ6WB+CBKEqSO83wnmM/M/
         18+UoBjnYcpdN2ueiWGke+x5s52tcoDPF+lF7g+42VKytX3kWAnd+w4I0844qiuDHrPh
         3zEOQZ8VUVfAHyfXmAIlS6ZBogvajwuEknU6neiJGj2qnxhtS0J6Uv3wEfm2Aasw61OQ
         PduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227304; x=1768832104;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NtegIXVuMjOvcTte7gKCU1ovVtkkfM1NfzdJy4Mh1TI=;
        b=JMAHjkqd1tMgN0ul51mwjnTzPkYmo1rlwX0EZnoK3qTpg/K9YJDx+5JyrKJ787GGHL
         MS3yTN9RjAnsShC4S33N6Bw1oeAzBYXOOM/Zi41H8dJZz/X/m5zNPa5dQoAffwNtl+H1
         mMR0nCLt7sts6vYsZkgFTjQFFs/FeHC3x4aF5scRe0k3YSZHJsTaKCnysfFSy1lguKKm
         zgXiOn1nQKR3PrKOqk1kJRWkgLsC0DoW1Cpu3ImXO6xcz1GXzHfNHprgRVjzeV/O4ctt
         9nJi7tdor7I+Lf8YWZL5BPpYS3IhtfT4yxKFdX/WS7e0UvFDdukBUrQh2I+PxWaRD5dH
         0oZg==
X-Forwarded-Encrypted: i=1; AJvYcCWMVeCxI/pU7IbAr9q3vA3/10bJlmW885i8Lw+ctBHZbmPHHRPgTV6WYl5Q8Rn3jqu/XrRnyGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyELfqf6VEFdgR1Diu/R62OATmNaaXm3NjujS1aMoZN2pRvJzFB
	+6845LinVmEMV3tGkmE2eW8aFsIVYAHDVkURkWdDxkp+oczNfgnF7NstDZkMCoFGsBbUXpZ9Uyw
	0O58vBliCM12CAkLyp6wsP65DX6lYRgWJjHjO9k1v78Boe4wrEmgcpJlmSi20XNbEfw==
X-Gm-Gg: AY/fxX7IDnaYTopDW8pYWw0NeFdn3fZIsQOVu3KXed5DsXeZqQKQcscMQQl5iYmnHew
	zYvPxyA5750+wCZbuj2dFraVbxbP8uCQbOIY7j/xS1N5EzS/M1R5rL19qhy8+8pLKLdq5wTgwAQ
	Uz3vXkg5SgwYjI2X1Bju31VvwRaMDzZC6MQLBslQ46EFy+7w+KWTerMg3W3Ef6lpnMMfpctXlpk
	SkOHY12H4qCLsNxkE1RNRD3cfZnKAYdyCKSQ2oHaOkUZNMSyNfkEMg0MUzjbGIEtoFIuiQP6qsL
	oUKYHGqcb3bh9tKdJybdFo/UmslWDZXp3kpInip0HwrMllO6QMYmrAxwqCR+9zCEafN2ptHyfyQ
	MAFtC/YMJtOCUnUdDu737hv5Ekh21rjfbHg5QYMnBtAJnIRQ=
X-Received: by 2002:a05:600c:c10f:b0:47e:d6ee:7dd1 with SMTP id 5b1f17b1804b1-47ed6ee7dfbmr6321145e9.2.1768227304514;
        Mon, 12 Jan 2026 06:15:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAUKfsGNu+VpJfpAW4ubaTD4klPtxj9uf65p3UK2zS3xNi0xX/odKToH6Ra6ekWM2+Fo66dA==
X-Received: by 2002:a05:600c:c10f:b0:47e:d6ee:7dd1 with SMTP id 5b1f17b1804b1-47ed6ee7dfbmr6320785e9.2.1768227304120;
        Mon, 12 Jan 2026 06:15:04 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8660a7bdsm129071865e9.4.2026.01.12.06.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:15:03 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 1/8] net: macb: move Rx buffers alloc
 from link up to open
In-Reply-To: <DFJB8LYO40ZD.394UQ8NLOQ9WP@bootlin.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-2-pvalerio@redhat.com>
 <DFJB8LYO40ZD.394UQ8NLOQ9WP@bootlin.com>
Date: Mon, 12 Jan 2026 15:14:51 +0100
Message-ID: <87ldi2or38.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08 Jan 2026 at 04:24:32 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> Hello Paolo,
>
> Nothing major in this review. Mostly nits.
>

Thanks for the feedback!

> On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
>> From: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>>
>> mog_alloc_rx_buffers(), getting called at open, does not do rx buffer
>> alloc on GEM. The bulk of the work is done by gem_rx_refill() filling
>> up all slots with valid buffers.
>>
>> gem_rx_refill() is called at link up by
>> gem_init_rings() =3D=3D bp->macbgem_ops.mog_init_rings().
>>
>> Move operation to macb_open(), mostly to allow it to fail early and
>> loudly rather than init the device with Rx mostly broken.
>>
>> About `bool fail_early`:
>>  - When called from macb_open(), ring init fails as soon as a queue
>>    cannot be refilled.
>>  - When called from macb_hresp_error_task(), we do our best to reinit
>>    the device: we still iterate over all queues and try refilling all
>>    even if a previous queue failed.
>
> About [PATCH 1/8], it conflicts with a patch that landed on v6.19-rc4:
> 99537d5c476c ("net: macb: Relocate mog_init_rings() callback from
> macb_mac_link_up() to macb_open()").
>
> I don't get a merge conflict but the
>    bp->macbgem_ops.mog_init_rings(bp);
> call must be dropped from macb_open() in [1/8]. It doesn't build anyway
> because that call passes a single argument.
>

sure, will do.

> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


