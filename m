Return-Path: <netdev+bounces-288593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AqyMuUVCGqYYgMAu9opvQ
	(envelope-from <netdev+bounces-288593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:59:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C3B55A89C
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AA843011BD6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 06:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24221A682E;
	Sat, 16 May 2026 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b="Q+f5ZRt8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEB26ED40
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778914786; cv=pass; b=XO6gbqXD9yBFE3k9zPn3WVQ1nefhX3n+nJjiLTJeEe9pxFpypgVtmVMCWQeczoyo/Req1zWU4wRt5+J/3E70oo4dYxA06CkG0L1UHRIYeLJS9F7X9faRgKQeZdhLBYJRjVJx3PDZrFZHus1uxxhNF/BVBGYaNElpw+/PhS4HnCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778914786; c=relaxed/simple;
	bh=6yPOMQ8a35f8qXHk5Z5c6XWiYLYhz4cCJ7BZ8FMStn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWQeW74Ix9S2xRIu9CG4uGRlcvmimQDqBAbMPURzeYH1F9eWKyx4M0qlEy7PcIQoS0fscCUeywoP/LANBU9/zzDemyfA+TMD1RdaAm+uJB/gegRDFloib+6ERHWbVGdGwObBAcU7NvF5sZ5bPI8l4w8fEP89DLVjOjYo7T8y6go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com; spf=pass smtp.mailfrom=extrahop.com; dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b=Q+f5ZRt8; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=extrahop.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so1165851a12.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 23:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778914784; cv=none;
        d=google.com; s=arc-20240605;
        b=ArjKouPSJzTExUMCSl6C4fdPUst92nMuYSr9aWqIhi6h4xe151eHXZQnS8zO4vONiB
         jUrQBUreXfz8MkfNvL6kYYsDMU+Xbt7Kyja7IWsUBHNl3eork4MiLLwMNvCgPigZ2/XN
         3jDkyshLYVZ6LgG1AWRE/80EniNYQf6GL7qMcmbW8Yrnyfw9sJ+rp4S/JnpOzBgjKafG
         c+5yxyIIvCp36y4fJ+H8E1EL9gpLJvtFUSB8nfoRua+eedjX+hKZdj/KVpPFxOutEwxH
         39eiSfKIinXdA27esDDPHOh5R/xmtRgBs3iodbODonF3n7jVUCctId2u1BDxFKZ6o6ZL
         ahcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6yPOMQ8a35f8qXHk5Z5c6XWiYLYhz4cCJ7BZ8FMStn0=;
        fh=bTTJ9meEjq06LyFurtYy5KZ8wSyQJ+Bu0R4Z9LP2CXA=;
        b=brVJ7WIqnNZ1qnUJ05rVtDOLCnkga7au/U6zQsbpIhrFaAzhdyGQpkm9BDEQG8qz9f
         hm1wQCreGlYgcxS143qsqHONb98P7QL515VVMLmEqpwLb8RfS7N75NhLLkUeNKXIwMmw
         /XVAh5MKO1jN7OfqBCxox2SLmck+RRS9s2fjLbSnxHgMj3vaR1fH1PDd/e+wHWwGqt4s
         K01eis8iZ5Uem50RK+XoRkTUL+QBF52rinM/6/qJhzDpTkzUdSf36SC9y698ZfQi9Uj7
         LDqtwn8QFfjrFTCRuzErosRI2eIDJMY9R2KT4eamM5zB4DpW88CAiAb4i1+WKnK/8j6P
         Dw3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=extrahop.com; s=google; t=1778914784; x=1779519584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yPOMQ8a35f8qXHk5Z5c6XWiYLYhz4cCJ7BZ8FMStn0=;
        b=Q+f5ZRt8lumGugwoIQqhQmBFJ9ow5bbQR+ubG9stTZngYhUv8OBw9aaK0S2koSzgeI
         QUkdsNpLr7KTuP/vE8pTpUMP34vDRUMKz3fS0sWGyrFvOluliNj7lM+59ZBWWUxxRzZv
         dzw7sE8JjLZGQreXxsY/u/rkTpBocther+Q3iykAnf0m+atkUvTNbtOLvapLAGfafkto
         ej/oxEpiQiicyX2KvTrdxlze6oPlx/p85ThDAc/hKWLQzvwr+j8lmfzEcIJQdo/Uq5Bt
         Z7Plm0//usEGkALlpJwaFrhDNGqqYIpwAO0A2hDSv5YxvfbHoWMGTLxl7SyDhhYfssnq
         i4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778914784; x=1779519584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6yPOMQ8a35f8qXHk5Z5c6XWiYLYhz4cCJ7BZ8FMStn0=;
        b=KzxmmwUMLOqGlCRPhA20CmS5nugAgR9oqqj3P5u9qX9Pjaa4C8MbMBRte+qyzN6iaH
         +93eG6wSafqETa27JnY63bURlTW5GTTrMKw4toogGNM8KqlQdSBX5nZorriJMb9VDE+B
         vP8BeLAAw8ncBFUDbW7WrSm2RefNzdtMOFObLRj10P5T76rXM4ONHqKTGSWDq6SoKp2D
         Ew8Xce0QpkSxbIRtf6JHA12gSn7P3gAulak7/KrLCJf+JuMf8auhw/KzIA4RdpBjSqKX
         d+n5iO+GEreOBE68ZhajnEQzEid6OroAp2R3H+y//MlEgjxwMm12B47usmh5GUBOsm12
         q9vA==
X-Forwarded-Encrypted: i=1; AFNElJ/x1i4gNqwyVXXMBq/eO7hpW4JmA86HmgGplJ5cKF43kKZ6P7CT1RnZa5jbdDaJ0dwpa3kVkxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mpSs4LJE5w8Rn/6P4ElBDNTTIjgN0seYA5maDLI6Q0AriZm/
	OBMsmNrIYtuNuDe3RsZYCSaz6BWiPJtfVpP013++Dpt+6cpR3c9fiDaZnM9JBMkca2EVQmehrwg
	6E21POA6oFu+gEAx87s9eQkSZ/SGJQ+mOImpji5c5K4YCo447kuQ9pRcgkNqguybedN0LVFAw4e
	nzegTW5ifni6UnymGnNhaEuGYEFblohcVFAYtHKfLoKj4j84FR5OtfSuIXJVMZ/Y4oQlovrY8/d
	p8sw1uP6YxJkiazYU9Vdcmowg==
X-Gm-Gg: Acq92OHLBXnM4u73JNIrArrsLKGeUu7ID0fb8GOQIvqVzr72wxYLVY8pp/P6JwiO2n3
	CS4QSiEp/ybFkfL6Lsn6dTEbON4aVA2cRcoDY6l6sfaIo7aVjoVoDFPz20wOn0ESxqxEnT2z9qz
	m6t26qy7xOTG9oqzFEmgq0WoW6b3b77GV10sBNn+XpNtkzYRP/WH5OblmkkXTZsslRKKFuaJyU+
	LyMyLxMWrn6Dykc0NDk6uf6igBKZVGIknlVovF2pIeauusPrNZNtY2W7nnYvtx34Gzqg/qDUY4W
	ZscsdPM=
X-Received: by 2002:a05:6402:1215:b0:676:d8df:f8c1 with SMTP id
 4fb4d7f45d1cf-683bd8873e8mr2468473a12.22.1778914783672; Fri, 15 May 2026
 23:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-b4-mlx5-sensor-fix-v2-1-531fee4fd7fd@extrahop.com> <20260514113257.GO15586@unreal>
In-Reply-To: <20260514113257.GO15586@unreal>
From: Will Mortensen <will@extrahop.com>
Date: Fri, 15 May 2026 23:59:17 -0700
X-Gm-Features: AVHnY4LqVDOtiY4_BI2sqNyrFc3zcnI1GCXk41hW9KuHIgnB2VhvFpKiZfAZrRY
Message-ID: <CAMpnoC78ZquRwdmESp_NtzYsD8DEh2UstFJZomH78pYyVk8Xhw@mail.gmail.com>
Subject: Re: [PATCH v2] net/mlx5: don't printk garbage when transceiver overheats
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	netdev <netdev@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jeremy Royal <jeremyr@extrahop.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 34C3B55A89C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[extrahop.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[extrahop.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-288593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@extrahop.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[extrahop.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 4:33=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> Your Signed-off-by needs to be last.

Sorry, fixed in v3.

> I would take a simpler approach by removing this extra complexity and
> using a static temp_channel_desc[64] array, avoiding any dynamic
> allocation. But this change is acceptable as well.

Well, the sysfs accessors get the hwmon channel index, and they would
still need to map it to the sensor index, but that certainly could be
arranged.

