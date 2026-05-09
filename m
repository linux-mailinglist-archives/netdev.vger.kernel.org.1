Return-Path: <netdev+bounces-286219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCJ5Igai/2mw8gAAu9opvQ
	(envelope-from <netdev+bounces-286219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 23:07:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E323C5016DB
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 23:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23F47300A8E6
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F0383C6C;
	Sat,  9 May 2026 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byAsD0d6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47F34F479
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778360835; cv=none; b=qo6SmjU/u39RuXBWYnhsikWcE0lMw6mvznNTyYpEJkHH/hVikvrRBeTzCFKOOwrtofTl+UPW3Az9xUCMpAn5KjcAso74RCJUKaw3MtvyOnin+bm55rKP9Fya5gVrbe9VKQi3V5G3mn1umLskZTwXzu3xTd/7x35KuA1wJKN3XqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778360835; c=relaxed/simple;
	bh=O2iMQMku/uThSPkCYna+5mUj6KQSiDJiBMLY28Hrp9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0rd9WNCgRWJsg2NZKW01FH9LQm5S4HSP/4GEEBXYaRBU7z636bbdgQHA3pP+R3VuyTsKvDczJ8S1fttVz8VOeEnpQYiCejW1lLeKZj7IbS8S6G0FBqgKfkIZavDxnGu2OShBK+vrtmD16xvWHhtco5VKp/tL7GCkzi6lg9U9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byAsD0d6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d73422431so2423990f8f.2
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778360832; x=1778965632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKVIrDb2f0B70UBcuwE2Fw73npcPR9XEbE9y6JlsQxc=;
        b=byAsD0d6tHqz/+8c5sQbV5fT6qkU8b7sYhC5ia3RDhOPFtasWPGpThB5+hdgOmvBGE
         zcDjfcnWaKUW9wkosqxR0k+rRiEbB2ut2FPTSs1df3eClXsk7l9RxGnwiGvR1Fx5GifE
         bem+br3umjdIZuRsHLtdwWn17jzeKECbxXJkznRsL3bKPOsV/58oG6Z8Z2m8Yojc9y28
         ZBw8WO8r3GDdR/H60jBJ4TsngplQ2jPY17Nga5TQFmkJxM/PKF8J69HnP0xOfq5LbNAB
         /XXysLw1hVxsF4vwQXU26D+aA0iz1WLwD3s8sEZCuwO+MvtYo+DI6V4v3u6rC1CX437h
         IjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778360832; x=1778965632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKVIrDb2f0B70UBcuwE2Fw73npcPR9XEbE9y6JlsQxc=;
        b=Jb5dYcz/YtMdT1MIxxBeN9NSBdYYvRgqHEivxmCRyw5iRoGAOzsj052LX1meRHA/p2
         Rms0NsJ1WM0lOMIkXVXeLrItb8o5ONYgFrm0PZeCrFaRinnaSbP/JpnYfUadffkP/O8+
         ApL073KOXACBRwvFa/lNVc3wtIGb3gqGqMSBzaytnxUURSIIBP8LKZjK9G9JXOKUMdnv
         bC/OnmJOFpWOXfaCNdNZCPW0rg67hUaYalFPkyEzputMIDdSTLI+P/9JjtJWrboUY79U
         QTuaFLVH8I7Jpc0gcePPgG0ElmJhRyID4HBglUyn40Kucr1IrmeJHnZGZ4Y8yhCVzT6F
         1WJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IlTCv73QZ2zzt+Vv0HanR5x28PoPuXzFxEoYL4tpfwZpJWIJbT3Y73BHyrYRkynuW8Gb4Dt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIkqmDKV8b81lElrNWj9lLWZhuG+Dvu/HaOpHNqiTQ7rW7dQk
	sZLnOASR47IbxEryi/CUi91/HuPpdyrUBWEGKI+evxq2Q4AXvemM2sCDtr/V0seE
X-Gm-Gg: Acq92OE/mpGcz/FNE/K+XWXo7Fnk3d0GTtyegBpoX3rCDEl+ZPSOLt0LiWvPaeEjt8k
	303TSzQvr1GDsMLiDDnMqiHlelqZoHkOr9pxKYifNDPlqj4MlMt8gHbI8NE8zhtGC1F/F4Pv7B8
	kc/xiDN4Q4wSQhDSC4aCcEf72gdSb5s7ZWqMvgat8+ILuDjP/s7gph+/OTwTLqEYVNEBes/Lv8p
	it8eLzGmKycDMHQNq1BWd7xGw0korgv459ABy10Ft/uiqic7MrxHHAFNGXGjI4WHYw8ic8tt1Xr
	oqH9ak32HLpJQk1WQlGwKonOjXBglgO3KpsYqINoyJ3YAGLFGeAaYlD5vxlzTjHEdEoJp7zXDm4
	N3qavYFGatT0Uw90SvEjqpJZrrY6TrJPG+bJ1PMxgxR3jCVLgIePURW8P/e9+Eq7OVgBwni48d/
	zBjJ25mnBBGyakBB3rI6E/KUW0wX1GOb+Cg8VQQdOuEkyoqNLKMeanipZm/t6LieLh
X-Received: by 2002:a5d:64e7:0:b0:44a:9b52:8891 with SMTP id ffacd0b85a97d-4515b42fbc4mr27251402f8f.11.1778360832327;
        Sat, 09 May 2026 14:07:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm14120942f8f.33.2026.05.09.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:07:11 -0700 (PDT)
Date: Sat, 9 May 2026 22:07:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Adrien Reynard <reynard.adrien.08@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] docs: fix repeated word 'in' in networking
 documentation
Message-ID: <20260509220710.05e78cfe@pumpkin>
In-Reply-To: <20260509143103.16558-1-reynard.adrien.08@gmail.com>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
	<20260509143103.16558-1-reynard.adrien.08@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E323C5016DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286219-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat,  9 May 2026 16:31:03 +0200
Adrien Reynard <reynard.adrien.08@gmail.com> wrote:

> Remove duplicated word 'in' in networking/switchdev.rst.

Nak


> 
> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> ---
>  Documentation/networking/switchdev.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> index 2966b7122f05..948bce44ca9b 100644
> --- a/Documentation/networking/switchdev.rst
> +++ b/Documentation/networking/switchdev.rst
> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>  monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>  bond will see its upper master change.  If that bond is moved into a bridge,
>  the bond's upper master will change.  And so on.  The driver will track such
> -movements to know what position a port is in in the overall topology by
> +movements to know what position a port is in the overall topology by
>  registering for netdevice events and acting on NETDEV_CHANGEUPPER.
>  
>  L2 Forwarding Offload


