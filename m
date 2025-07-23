Return-Path: <netdev+bounces-209281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C98B0EE31
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D890568549
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC45286881;
	Wed, 23 Jul 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrPjcOkq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48104285C8C
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262213; cv=none; b=FFE3vmzGJjNE0iNrDvFiMzoV6M9n2nAysQi5qsB9hqRHnON1qvbA9wEwRbJks4TVcmDB0A1QYzJJg3vvLY/7PAp3ENZmxfjaTJt57vUSi1dQcRkEfmY6ikYi8gqAboRI2m+rYvrq7tU6paC2LycNJKypfTVyogmGYsSM6qqEtL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262213; c=relaxed/simple;
	bh=H2BNf5Y5uuCCMCMObzAj3YltF4GdXLPf3RclMeTe/Zk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=C70/zxVOngK0VuMZrTOMFhXmcgn8ObWo/gUcjDnHcJHg7hlhHN9rCZeG2EBtjupH9Bud+IMMTY83urGWXLhNyJ7DC135SHjcYiZumUUVEDReLCWYuyROgXqNex+sUgeMXaPHWyLQDSzw5k2xdHstVF156i0869fuBjRgd5c1uq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrPjcOkq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d7b50815so48761285e9.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753262210; x=1753867010; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/BBaMS1j5ATUviYrmEB8vJyo66orVWQCLaLlvtMv/PE=;
        b=KrPjcOkqPp2c3la2moGyfUIIj6nwU7sj1wRVBvSe4aicvgLF3kvuZQPMDKhFJS8VGB
         DT0fMn+3QuV/ircKBIxd0rjt0v1ACuNhrh5YgBQFhdxQNcdXZOGD9KycfP45ZkZFyzal
         XXyIz/z56bhyu9ZOVOO/VY/erOGhhVnCYWV9J0JUS1ii+B0/C2L8A6W/9XK6pGsTf8dX
         jFHbApNU2vHo7+JJfZVlyap03xBVfLoXr3lrnO1ryPyb4/vN6ZxMrfATAI2MSbqsDoil
         1DhTE8TSf/dFeTXDm4GySkUkirAL9mlHwBjXizZ+VeXKUeUi3oT+9Wp33upWvukyEv50
         sa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753262210; x=1753867010;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BBaMS1j5ATUviYrmEB8vJyo66orVWQCLaLlvtMv/PE=;
        b=TSi1pm9gd+4fP0dsrrUuJGZ3Tjoyzfig+phyAEQp3pTjss1DEoP6xWQkpeonPs8lhb
         AWfE793XsAEXRpmnZ478gR45WYWsEUXZTbbR1cebDHgM6ARz68hDmv36BM2rRaGbhO+N
         d8yhhZRA1HjmF8jkKWRFFtmCLmJ9nX8C+fUX0lR3Bh815wlx70XPLf3q1C9A0vC8OGnL
         DAXO/NgFC7uLvGhWBxGWc7XOejG60QFFsSJQwzL0C6bO28vz8Xb0vCRYo9D1lm/NwBze
         ESVwG7lGV2W3ugYnBUfwJwd1dSYurfIZa+LjElOrRSbxtQZuu1F6Z+g+BwkLz5UbXO1j
         b+iw==
X-Forwarded-Encrypted: i=1; AJvYcCXHW59uNCzRohDA0Sfv5PcH9Bm6lUULtSPpsxlN1DYLAx24V7UXHLnZIv2vfM1YST4nWhTBzaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRjtJnAO1B9WJRFX6VPuEc9Ix2cROIV1UE+3g00EHwJMG0UOr
	IwbdIGxHvY220sPD8Kao6JyT65otdkAZrpdOZ/xRbkXFM3fO3fDcLZcM
X-Gm-Gg: ASbGncsjQs7fhAEYGFgjol1MpnB0w5fPQUS1ff53V51kb4aNT4JsX5G4uf/LybsqpLi
	HKSvyTOlTRXAYN/hZu2AgD/nqojf7Ffj4N26BMAFMRijmlBFvFzWgnuWSRBNxkFHF8AIlD9d2+P
	9708LTq5cve0eaHfIE32iLxRbRQINAYfsSQm6L8ON/Q6WQ6jHCwXm7qFH+9HaL8KjxxlNKPnD5r
	fmN0vszWTEzsWbp/mhZgFvCJwJUUGjpM682BrSwbiVeiWCusrwtoS1QeoXf4Zf0D9nVwULzEBCF
	NCpf5fLICG6nEIBzWM8JSVHc8IixZyfhSLo0b5KSgCFFYzb8brZYLx1JtPBa70STtFBOgOSiFQx
	js8tidq+yPAFl+hR075zN7ZyEMKs+E3XFdYk2SAMxt3pr
X-Google-Smtp-Source: AGHT+IHgbw+fEb+VtAoYqIxGrVSbC+2a/HD4oq3nmC8izdKmyE4mLfnDCzYCv324Yui+3gHKCGi6lQ==
X-Received: by 2002:a05:6000:2505:b0:3b5:e2c9:fa05 with SMTP id ffacd0b85a97d-3b768cb1908mr1329691f8f.18.1753262210351;
        Wed, 23 Jul 2025 02:16:50 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b8c1:6477:3a30:7fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48719sm15929925f8f.47.2025.07.23.02.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:16:49 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  almasrymina@google.com,  sdf@fomichev.me
Subject: Re: [PATCH net-next 4/5] tools: ynl-gen: print setters for
 multi-val attrs
In-Reply-To: <20250722161927.3489203-5-kuba@kernel.org>
Date: Wed, 23 Jul 2025 10:15:19 +0100
Message-ID: <m2h5z39sk8.fsf@gmail.com>
References: <20250722161927.3489203-1-kuba@kernel.org>
	<20250722161927.3489203-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> For basic types we "flatten" setters. If a request "a" has a simple
> nest "b" with value "val" we print helpers like:
>
>  req_set_a_b(struct a *req, int val)
>  {
>    req->_present.a = 1;
>    req->b._present.val = 1;
>    req->b.val = ...
>  }
>
> This is not possible for multi-attr because they have to be allocated
> dynamically by the user. Print "object level" setters so that user
> preparing the object doesn't have to futz with the presence bits
> and other YNL internals.
>
> Add the ability to pass in the variable name to generated setters.
> Using "req" here doesn't feel right, while the attr is part of a request
> it's not the request itself, so it seems cleaner to call it "obj".
>
> Example:
>
>  static inline void
>  netdev_queue_id_set_id(struct netdev_queue_id *obj, __u32 id)
>  {
> 	obj->_present.id = 1;
> 	obj->id = id;
>  }
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

