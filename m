Return-Path: <netdev+bounces-228675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81828BD1DC2
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E19E1348B53
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 07:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679662E7198;
	Mon, 13 Oct 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kqqd6UKJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697C19E7D1
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341524; cv=none; b=YuaqwzGyTYUF1RoO9sRAncuvTjXMyzzCwyA9OYNy+vDeBpCG4idduK1+02Zh4ipMRya+kmno3WvqAFK1zDxxfE8rxqMezzfP3U5FNrxXStqke/XjkJlnLtbXPCaZ+zOHXVDL+XPlPnw4R8dg7dVoCpzftaxjTKRso/0vkipPIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341524; c=relaxed/simple;
	bh=sOhNTef1u0jnxsOMdh8ImIfGl8VK05dxLH9K9vu6f5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X12qZyPlpJJl48LPJ+sB5QYZOTJ0+94mBEFGReIrT2bY/6mz7xqkJmMpE9Klh73lwjYkpoNcvv0CTfeJU3PPJU8yiTxnd7M9DB/pGibXN3lVVKmnjAIDsO5E66JTclZavUDC93D/cKa3zZ2qeEdjyH9tOagS4KJjlME30NDU1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kqqd6UKJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760341521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur65eEd55dB9RggfL3/sh+6isU9r0DsyqCzTWHBfqII=;
	b=Kqqd6UKJX6QWr/egfWWsJwE8HKMByAi9w/mVQi+tMedu5Wn/KCya16myuWJ/ZGj0zo2MkX
	b05xZ1+ows3oTppyd6Orxi5H3n5vnr/fYn8VmdjKsRUD/kX5EPLjh+NGivYdrRoW9+K8ng
	LrsOvatghsT6pC6q1Sm7zzkBts3YnfM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-WwsrIS3vO0a-n97VaF4d1Q-1; Mon, 13 Oct 2025 03:45:19 -0400
X-MC-Unique: WwsrIS3vO0a-n97VaF4d1Q-1
X-Mimecast-MFC-AGG-ID: WwsrIS3vO0a-n97VaF4d1Q_1760341518
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-426c4d733c4so1838855f8f.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 00:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760341518; x=1760946318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ur65eEd55dB9RggfL3/sh+6isU9r0DsyqCzTWHBfqII=;
        b=TIb16yM2x15LTDshgPHQfL8mwjJhURZy1v+tbFR4XXWoAXojdUJE0UYK5hb3D6JNeH
         hbiw6cE/b/JObUoR9If9je1g4EUz74sHhKUWZZhBeQPMXnlgjh0PJQoHvBmFfuLd6z/6
         +iIjQPJ381yOc7O5w1Us7HWv5gd18NQz8evwD3Fswp9SPc2zAVhDPC1RmeP9EQeBKlTI
         zKt6bQLs1rgWgszAgoQi6I2bAvk7j/S/Woq/Ocpv3ypOObidm4SqEz/r5mLsvkf5FtZV
         YWC8f7chBLIqMUv/aeQ6WGrpLBvkbFlTOg6n7JBo8yDkI74PUIpUSrrA/VZJfCU8YeTG
         vY0g==
X-Forwarded-Encrypted: i=1; AJvYcCXVcYmVCLZRNgU5UcHtPqGvNaerTUexBkqZPQB5PaMmFGAoEU7oANYYA2sPyp2LMkbsStmGnuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypy1FYKddBFzy+smfdjcyCIfLHR9G1JC4VJVrMXoL2eaK6sky7
	BHXuyTO6JAYnIbY9OD0F7XID50kPInGoVRS2hRFA1wUNf/7osihQVmQ7MTP5b58ruOWoNFY/hg3
	QoKMl2WRwCNyAUb2BTs5XVVfkWIhKlfJzaMg7HNjr664WPo5t1txZAjS+AQ==
X-Gm-Gg: ASbGncupUvYUTUv8K0iZUi0Nc+2zvwr2BjK5NwES3p/lS3T6ORE8X+E7yxhByYKgMPU
	dPbz007QtcohFTB7eTNgQoycTonVgt2lzlZ4UN/misjVXmpzGBd8G+8SyX7OQPJ8rv3eeHVoOOQ
	LFHoF/tuZiTe+O+7PDDlz4ZmWsyZY2P3f+b21D1vrnnfip+ar9q7jnNSGSfvTQS6iHVvVPrgMNg
	phfjQLNmHzZoTBJFI5N4FcF8KjcOQkTS/NAZzFKY6ZrzC2PewfDLo83xDu/nTVJHaT7M/JKKcfi
	mGj/LhtmtrRkTwJ91/PoSjPHaOXVwQDEBEwivOpcWT0c
X-Received: by 2002:a5d:5f54:0:b0:3ee:1586:6c73 with SMTP id ffacd0b85a97d-42667177de1mr12606762f8f.19.1760341518384;
        Mon, 13 Oct 2025 00:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtb37bcPre9Fc9HRabr8igTDi6CLps4767TQS+Vx64K8K0qOvj8JJ+LGDmG9AoeyFVPoV8Ag==
X-Received: by 2002:a5d:5f54:0:b0:3ee:1586:6c73 with SMTP id ffacd0b85a97d-42667177de1mr12606742f8f.19.1760341518006;
        Mon, 13 Oct 2025 00:45:18 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.153.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e6c0fab7sm1445345f8f.43.2025.10.13.00.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 00:45:17 -0700 (PDT)
Message-ID: <1157f3fe-f88b-449f-a4c2-aac9d27c95ea@redhat.com>
Date: Mon, 13 Oct 2025 09:45:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 9/9] can: add Transmitter Delay Compensation (TDC)
 documentation
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20251012142836.285370-1-mkl@pengutronix.de>
 <20251012142836.285370-10-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251012142836.285370-10-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ni,

On 10/12/25 4:20 PM, Marc Kleine-Budde wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
> 
> Back in 2021, support for CAN TDC was added to the kernel in series [1]
> and in iproute2 in series [2]. However, the documentation was never
> updated.
> 
> Add a new sub-section under CAN-FD driver support to document how to
> configure the TDC using the "ip tool".
> 
> [1] add the netlink interface for CAN-FD Transmitter Delay Compensation (TDC)
> Link: https://lore.kernel.org/all/20210918095637.20108-1-mailhol.vincent@wanadoo.fr/
> 
> [2] iplink_can: cleaning, fixes and adding TDC support
> Link: https://lore.kernel.org/all/20211103164428.692722-1-mailhol.vincent@wanadoo.fr/
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> Link: https://patch.msgid.link/20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/networking/can.rst | 60 ++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index ccd321d29a8a..402fefae0c2f 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -1464,6 +1464,66 @@ Example when 'fd-non-iso on' is added on this switchable CAN FD adapter::
>     can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>  
>  
> +Transmitter Delay Compensation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +At high bit rates, the propagation delay from the TX pin to the RX pin of
> +the transceiver might become greater than the actual bit time causing
> +measurement errors: the RX pin would still be measuring the previous bit.
> +
> +The Transmitter Delay Compensation (thereafter, TDC) resolves this problem
> +by introducing a Secondary Sample Point (SSP) equal to the distance, in
> +minimum time quantum, from the start of the bit time on the TX pin to the
> +actual measurement on the RX pin. The SSP is calculated as the sum of two
> +configurable values: the TDC Value (TDCV) and the TDC offset (TDCO).
> +
> +TDC, if supported by the device, can be configured together with CAN-FD
> +using the ip tool's "tdc-mode" argument as follow::
> +
> +- **omitted**: when no "tdc-mode" option is provided, the kernel will
> +  automatically decide whether TDC should be turned on, in which case it

The above apparently makes htmldoc unhappy:

New errors added
--- /tmp/tmp.ZsYbmUst3Y	2025-10-12 14:23:45.746737362 -0700
+++ /tmp/tmp.8o1xOCQtDp	2025-10-12 14:58:29.920405220 -0700
@@ -15,0 +16 @@
+/home/doc-build/testing/Documentation/networking/can.rst:1484: ERROR:
Unexpected indentation.

Could you please address the above and send a v2?

Thanks,

Paolo


