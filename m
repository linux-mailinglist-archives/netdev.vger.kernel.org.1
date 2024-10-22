Return-Path: <netdev+bounces-137834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD59AA02B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DC71F235FB
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D719ABAA;
	Tue, 22 Oct 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qcbyc3md"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE12199FC2
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593485; cv=none; b=KGv14MbwEnKR5ynRu6oG0FC4CJIbSDA/Z6Dcq0/7yinJ3UiVIfpDk7D+56bywhzSk+/MNzr8F/nqohtKUffhXmNgOVkz9SQkLj/Iv1CESQosQ7UQvuiEEFMXuXXnknSY3dn3pPMz4Z+RbP12senvK0QO/sVsl4Mrsz6Xa5Yggio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593485; c=relaxed/simple;
	bh=ffFIq/gaiGrXB3V8+8QiuT3BPvz/9MKGdcuUtNI5Sac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QjOPSzGQXohK5ukV6OcWrhF+MdyvL0XREO4wSwfHWt4Gs2huAWIo6Y6zKGFjcceUsYxy7sssiLFJH3eyYRsI1Gco5BBiMzHqJAGVDbarMWJLWpqiDL9FFeDP5YbI4y17/X5A4hCNpjwLsGya9gUPXxUQs6JVdFh9HECPqMgTm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qcbyc3md; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729593482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffFIq/gaiGrXB3V8+8QiuT3BPvz/9MKGdcuUtNI5Sac=;
	b=Qcbyc3md7TPzU/5xYYyaNbp7Hv9oBxIm1teNdupi/Cgf5ecdj4EyB1W9az08cSGO6+AuRM
	SymSMIJZ1NQcyee4a3PS9NEeeAVwmsQNhls2rTeWMkKLTzz3RwmAbtVbq3Ko6N520+Hnwg
	BCA939VIhYFsIlBOUPpqfeqMeqRBP6g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-X82kYXskPYmbTCvqR-cIBQ-1; Tue, 22 Oct 2024 06:38:00 -0400
X-MC-Unique: X82kYXskPYmbTCvqR-cIBQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a0d8baa2cso602541966b.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 03:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593479; x=1730198279;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffFIq/gaiGrXB3V8+8QiuT3BPvz/9MKGdcuUtNI5Sac=;
        b=HYSI2xlyyi2FAFQcUWevW8aO0OpdHWCidZ6RNgMfBHFTGMlCmHbCIk+KkVCOTtqgKp
         zFjw9tvcEe1B6a7nBCMkHmr+AaRc07xc4B8bVwqOY1l5t286z1r7ZwaKpYuvYoG2rh9y
         DFuPjqnzFb1Jm3Lve+eGZ+oecuZkb0sjL8CxBjEWxSlWgzCoz+Z/kNtyPOKfHUjdFVWm
         3APh2e8BNwWudRHPcLg+p5LJ1JcH3J5R7UM0UryuEr3BcK30kd6xx9VKipeUy4rvIO4U
         W3s319YbBwgJ+8jrNi0Os679PEsVrYaVftpqC1smmjbg/y/0n1ND4DrL/Zbzldxup2Mz
         vZRA==
X-Forwarded-Encrypted: i=1; AJvYcCVNwE+BAtgajCqvRMkkzRGDGTdUi8xMmqqPKpF51LJEodxtqzRP0dMTd3Gwtetwtv2IjF616HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxrKGcyU6D9ufvc0a1IbsVbmCHQ6Mllyr2PUVwR+jVSLjtoaO
	XSiAEKcQNr/GFdgit0+OAMVgwqMee96CTwtrBLnCUJBaCxZtN0gQMRalUebxIkizgyv370RqseP
	ExXMwJopel31X8I4eVECWkDBLTtS3P6yhepApKjoyKUh0CTN9fZ0bOQ==
X-Received: by 2002:a17:907:2cc7:b0:a9a:170d:67b2 with SMTP id a640c23a62f3a-a9aaa5d907fmr283641666b.29.1729593478883;
        Tue, 22 Oct 2024 03:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEripPrAITA/WLQwqo9WurNo58xCXU6eZjF2PPYNfcl+DENvnVnrciJi0HPoUTYPFfXpqprVw==
X-Received: by 2002:a17:907:2cc7:b0:a9a:170d:67b2 with SMTP id a640c23a62f3a-a9aaa5d907fmr283637166b.29.1729593478361;
        Tue, 22 Oct 2024 03:37:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9157363asm323363266b.173.2024.10.22.03.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:37:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4B16E160B2E6; Tue, 22 Oct 2024 12:37:57 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Jussi Maki
 <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
 <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Nikolay Aleksandrov <razor@blackwall.org>, Simon
 Horman <horms@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Hangbin Liu
 <liuhangbin@gmail.com>
Subject: Re: [PATCHv3 net-next 2/2] Documentation: bonding: add XDP support
 explanation
In-Reply-To: <20241021031211.814-3-liuhangbin@gmail.com>
References: <20241021031211.814-1-liuhangbin@gmail.com>
 <20241021031211.814-3-liuhangbin@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Oct 2024 12:37:57 +0200
Message-ID: <87sesoh18a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hangbin Liu <liuhangbin@gmail.com> writes:

> Add document about which modes have native XDP support.
>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


