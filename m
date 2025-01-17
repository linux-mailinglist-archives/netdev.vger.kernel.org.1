Return-Path: <netdev+bounces-159281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562A6A14F80
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1531683C5
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56F1FF7A9;
	Fri, 17 Jan 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJMM21QM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBEB1FF1DD
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117837; cv=none; b=jpBSvz+oq1boBOBvbGRZXJyp7xwdCd/lx3knH0Y3JKwuiHibq5Fs/y1qeuXSJTFPUm8r+wmPaxuFCi05UdDrhO9bpknr/CGKpU9XL/BGawqmKRCT3rwAi5UTbIc4mHP0zJZ8qkKzHdTZzEqYXQDUid5WK4wK6l7whXt1ltSLegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117837; c=relaxed/simple;
	bh=+zykB88dG5lsQpKBJ0HHZ+LIhLvermH0yDY5HlcO3hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCiuFwQcOS75QML7/Ph04kTTTj9Fk0BeWnouyCrL1q9VS0DPuznM5S9tEaGGtfoZXPdW7w1iPpipd5/VfA0rQwNCY8GxNQbx13DtyIDBZErDI8BBZo5fhyz3XF9l2qtrsyDbBvlFjE1yCZS4HodbYGs5vIyUehsPHTHaeGW2Dhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJMM21QM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737117834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zykB88dG5lsQpKBJ0HHZ+LIhLvermH0yDY5HlcO3hc=;
	b=FJMM21QMUxnwSXJ+jmVcnq8yrHGx80zF2hhoYJpe0B2M+KSS6hqB6wAfKfoCJ60QZW89hW
	0IxqoMujuRd9UKzbaCO1gEgFmgoqF3WrMXJRhvu8kpG5eR9OTFYqntSzgTtiFhjIdZLtLJ
	lpXhhnq9QQj+RGcp9ZVM97lW7/Eu9GI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-QF2KOvfFMfuHziXVSV8GBw-1; Fri, 17 Jan 2025 07:43:53 -0500
X-MC-Unique: QF2KOvfFMfuHziXVSV8GBw-1
X-Mimecast-MFC-AGG-ID: QF2KOvfFMfuHziXVSV8GBw
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d40c0c728aso1950173a12.2
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117832; x=1737722632;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zykB88dG5lsQpKBJ0HHZ+LIhLvermH0yDY5HlcO3hc=;
        b=LloRiZC3OE86U3SjUfGyRzvtPW9rQphksmgdslrItLieLM2+HF9ELOjLlVf6JWXS0I
         LCI65VSfnqXkO7PEueRb9OWG7vGlwgD8ge/xaQU3zITi1AZ5nQgGp5hblPsKKSclXFse
         On5GkRPwQTbPIeKqG91hIrJDNLbqNNFzM1PVzB9SSAstCw0lMm6fxg56TsHiL/td/kAg
         jDqAHONFC4gZwZZcEFOaRcFny3GlC04fW76NLBzptYHNS8mL94M+kKXNauBUJRS6FnXM
         IsrdUD3XTh0jO/pgOAOD69H1+K8DEYXjUZrp60MWzQ8IihWgajl4i732fL3uknbctKuU
         UyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI4Fb7+p5TGSV/+YxGgezZClNqP8AQQDzyIiYovhlUU66PNJ2AQFKu/bSXFdJBwEtD6R/aFcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8qUBgPrJm7JyU+WXYkDsizuQYgcKo4/ZWIBKXeGKOjHhXbh9
	fCI0EofdZYk7+tQmY0szLQeHDryhY1uKrkea5ZDCK87G2imjqb0qhKfOEaqxsfGobzremE//MA4
	9RTepuYDrFN4/q953ihAT2pe13ZSB0SkT6kG7Z1j+2J8Iy2gZm2ru7Q==
X-Gm-Gg: ASbGncuHY2ECMQGZ6tj1mkWaBdRMbkQap+I2TtA4WecoKxwS5eBGbDC9aEE5a5LGmXR
	9sdQfpPFatKADVm6dEQQjHvkkqK7sOVISFtFLAKNVZnS5wJS8gVYqXjIn84keLTtPLbj1doTOsF
	9VJatmop8YUp6LZmwKNOKMduNLfVuH8f1IyScXi4PkyQT6nFPcREsU9HtAN18WIbPEVeMYCkr2c
	qt91QAiKEmJsMYW9AmxR9my0Homa25iaczeI5sv+siYJ9xTersu+Iq0unUfvPwKMDLqJoFQ3JUd
	xyX66g==
X-Received: by 2002:a05:6402:518a:b0:5d3:ba42:e9e3 with SMTP id 4fb4d7f45d1cf-5db7d2f5ec0mr5872116a12.13.1737117832334;
        Fri, 17 Jan 2025 04:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLlw+tf9R7HynsAHI9siG0tNAf70xgcN7yQ8QdeHS81e7hKnmmBmhhrwwYWsYR/zzg31juZQ==
X-Received: by 2002:a05:6402:518a:b0:5d3:ba42:e9e3 with SMTP id 4fb4d7f45d1cf-5db7d2f5ec0mr5872062a12.13.1737117831977;
        Fri, 17 Jan 2025 04:43:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73eb5b9bsm1406605a12.55.2025.01.17.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:43:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 44F1617E7868; Fri, 17 Jan 2025 13:43:49 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] net: gro: expose GRO init/cleanup to
 use outside of NAPI
In-Reply-To: <20250115151901.2063909-3-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-3-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:43:49 +0100
Message-ID: <87frlhobju.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Make GRO init and cleanup functions global to be able to use GRO
> without a NAPI instance. Taking into account already global gro_flush(),
> it's now fully usable standalone.
> New functions are not exported, since they're not supposed to be used
> outside of the kernel core code.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


