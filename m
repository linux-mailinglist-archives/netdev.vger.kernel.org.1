Return-Path: <netdev+bounces-57383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64580812FB0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D7E1F22169
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1059141238;
	Thu, 14 Dec 2023 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+IsgY/0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF95B9
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702555703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1y2cmvWY5gvPwPDpJLMmtv3/ZlJBxa88AApdah1hxWA=;
	b=N+IsgY/0nHpPLyWXMf88LOW4mj1fVnEFW/gYTTDpm7MjXX16jFPwJ+vSraOtWarZ0gvKWC
	10gvbn9UnRqD0492z+nZzsuQuBDxmiGFZOJgkmkDGWN9AvignyFU9Xk3kqAWPmLVy9LK4w
	N1b/w5Pijm1B5WiJUmbiTq67orw6Mp8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-QVpiSyhZMZqyHn_zZHhYGA-1; Thu, 14 Dec 2023 07:08:22 -0500
X-MC-Unique: QVpiSyhZMZqyHn_zZHhYGA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1fae8cca5bso87314666b.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 04:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555701; x=1703160501;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1y2cmvWY5gvPwPDpJLMmtv3/ZlJBxa88AApdah1hxWA=;
        b=GaOpqAPUhJabJ1aklN+AZFQ0vCTLo/242yUtmzOfSS+qILqGbXBYPGXec1tUsN02j2
         wS3tOVcWIEeACbuLPJL82i4erCmsEIVqmkCvgzjtKwX2sc5piqMzaDitzo7ZYrQAm1Jz
         j0AbLdd/hdvrcIJnkqmOC1nMxON1xCbP9sIAwBnY0DL2nRFM7+IaIAW42AEyU7LzL5UO
         gAf/0hoM2DCh6BD76HDP9IBJ2VezSaSg1NA40Ws3LfCHtZpIqltuGIJOMo+FLr9VNPGZ
         4Us3DYC5hNGWaeK9KYlKQbiMR+wSqsGhnwIqfSytQZcFbDjJI+QiQXsbCnxGNllGuzlT
         UMDQ==
X-Gm-Message-State: AOJu0YzMlgGvUmUEv2znTemcSTeMdN70hyKNT4T0nIVaqhw5odsk4bPW
	prhuZaObtj0mGftS/LRHKhLb0ZWmm1Z0Zg7ofV1V7cEl+IbRWRkyxABPptfolI7Xm2lMBXbWxBP
	KuZQG/I84tBA4TBBtelgVBZ2X
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11068355ejc.5.1702555701366;
        Thu, 14 Dec 2023 04:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER93kqIZMl/9SIkh3e/L0WU7al8sQEVUM46FFqeX9HwlX60gab5ecN6wfToYqOaCErUHb7mw==
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11068339ejc.5.1702555700997;
        Thu, 14 Dec 2023 04:08:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id re14-20020a170907a2ce00b00a1f751d2ba4sm8615825ejc.99.2023.12.14.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:08:20 -0800 (PST)
Message-ID: <ddb0d6217b333c3f025760b5b704342a989f2094.camel@redhat.com>
Subject: Re: pull-request: wireless-2023-12-14
From: Paolo Abeni <pabeni@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 14 Dec 2023 13:08:19 +0100
In-Reply-To: <20231214111515.60626-3-johannes@sipsolutions.net>
References: <20231214111515.60626-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 12:13 +0100, Johannes Berg wrote:
> So more stragglers than I'd like, perhaps, but here we are.
> A bunch of these escaped Intel's vault late though, and we're
> now rewriting our tooling so should get better at that...
>=20
> Please pull and let us know if there's any problem.

whoops, this will not enter today's PR, as I'm finalizing it right now.

Unless you scream very hard, very soon, for good reasons, and I'll
restart my work from scratch ;) (well not really all the PR work, but
some ...)

Please let me know!

Cheers,

Paolo


