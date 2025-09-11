Return-Path: <netdev+bounces-222256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D81DB53B50
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B713B487516
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF68335A2BE;
	Thu, 11 Sep 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1VT2MDp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EE32A802
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614900; cv=none; b=ZMxfTU3ZzJ5k/+FaiLPnyj7BnQFR1AOxA2vFeq2n1i4CqYgfzSAHPiaNF8JSrOS7kdZPe/olkJcNVBN/0AWq3Ka+2l7d3XQF7mCFHnlCsk6YREJJqJBRQb2E57VPGFrYRBy3t7aHpGJKh/tQh4bPIS3ow0uTubwefuh9pAYmUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614900; c=relaxed/simple;
	bh=Jd+yBImYmRBiHzv3m5PabL2jPVEDNQq+gQDaCuyIRFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uq1mQ4liDqe3QOSKTutXnj+J8WzNjm6d7EV1o/K4S5qozVe/vVtCy6lEcIBdm7teWZAqbNNTXDLhzO6dOTDh4ZiU6oo3JAdD7MbEym1wOnDibclfrWCOUDrk+5JS8aLxWDAJx8yXUi5xOat+J/QU1VF/osZ7Y3fJQ2hHVVL1/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1VT2MDp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-560885b40e2so1203e87.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757614897; x=1758219697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me627Z5tFRIjdXPyBuK6dP+9xV8RNbhF9jJs439CQW0=;
        b=Y1VT2MDpN3+vJoypPL5+w0xOq+GhK/IAz68BtVuPz0UKuddXSuoS5uRg63aRPaRevw
         Rz3x29mHjm9hW8751FkvQOpEodSdz/jJnh2E2xhdi+8z+DYsV8rS3igeDTCpnjWoYSDp
         0QejVQVaBzZz3VlGyle585ZOV8P01EeG/Cnk/nx/tKOI5SOLVvmClh/f+NsaH+Mt+9R/
         abCPICGw/bDpGQOOfNVRb1g/BrgDIICQBDZV5xe+KH3DHHhJpC8Ae2CB+v+D1KbqJbX+
         uXZ5+atMqaat0ygagmt196woUME4W3JfGwAvB/KYX1a2SiPB1FZr/h9PM1RNLsq7lcVZ
         CT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757614897; x=1758219697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Me627Z5tFRIjdXPyBuK6dP+9xV8RNbhF9jJs439CQW0=;
        b=s0d8FKLEz2uo9jobr9b1xkWgLdkxm1LsCvsdZ5y6w7HygWpLlfIso8wOw17su65F0w
         JkJQpJZBSz0Rk05Lc+lmBy+SyuoM91BIwTYFv2cfMu3OXLKWnELw3Zw76rA4/VILWA8U
         UNIiXl8mpndKQxrks8GOBl08WFgthF+Sq4+PTBeVGDeki580HBfRZbQPeLc8rzsZ71Li
         TKuzRgoMXpJ1zqzY5ouEnDLrLjN0vBPWvdtmyNOXULkw0n4eN6E7Cmkc9FecYIszjOxG
         YZBiHoGPa5kvGTcNkdMxbkH4EN7knLZafuYef7ClYyRrtrlCLeDmajRPrvvDQP1teaEs
         6P9w==
X-Forwarded-Encrypted: i=1; AJvYcCVhlIKtDcAmevUrK+z68vWqCotVc/8CPDc+eV6/iZaVWjysE9qCD7iy0njO/6TvwO9OJmruCV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzsZPDvJYtiYZq/OctcLK1/HS3fU60r7pOtd3+BUIehZVfs+Bz
	KFaGwQwa0Oql4svBC6sKVkh1m/zfg6Udg3TQEgAGN5FhaFJJ/E5Ym2Uh6YdbcR/dsIxx4StzbyP
	ZwEq7B3tsGmoj/nAWHUGpzqormnyGn5N0hjXao7Vx
X-Gm-Gg: ASbGnctnCYrjTfIHeBZRur/ee7jpYvFlISVhG6I+j5hw14e51b2VleZx0EJkTygHvqm
	3SVccNJX1ATKMR9ouTI6NVY9DluM1ufdNf+Wrinujqrfnfe6pLWqnmavFyZrR0XCqQkdpKdxvII
	nOkcUja5PDi/NMqM49WjySpx3zObUHYkv2UUkXoHZ2WXn9WFWcxq69VkzDVN9+7YoC5GBEj+7Th
	mf9dbaxLSqM2inAYwddQH+R4acZd9QQk0TcaCSxwnG5okhUrWGbooQ=
X-Google-Smtp-Source: AGHT+IHHliBGfbHylygVzksb7a+0fT63+QPDYN2pfiTQHYKdZKJlxke6/Q66YsWbEXxii3rtonP041JiTf4sxs1EYhs=
X-Received: by 2002:a05:6512:108c:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-56b3d403120mr647519e87.3.1757614896510; Thu, 11 Sep 2025
 11:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911144327.1630532-1-kuba@kernel.org>
In-Reply-To: <20250911144327.1630532-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 11 Sep 2025 11:21:24 -0700
X-Gm-Features: Ac12FXyFPo7XyGsAWGFghU6c8_EUB3u70sLxG1wSVRjNUdKgII4yZGLxSxNbPm4
Message-ID: <CAHS8izNHRmcuw=Ya4UC_QdtyJ_z_vYiHEWKRk1f6gQ5hdwXODw@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: fbnic: support devmem Tx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	alexanderduyck@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Support devmem Tx. We already use skb_frag_dma_map(), we just need
> to make sure we don't try to unmap the frags. Check if frag is
> unreadable and mark the ring entry.
>
>   # ./tools/testing/selftests/drivers/net/hw/devmem.py
>   TAP version 13
>   1..3
>   ok 1 devmem.check_rx
>   ok 2 devmem.check_tx
>   ok 3 devmem.check_tx_chunks
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

For most of the netmem stuff we've tried as much as possible to keep
the complexity and type casts out of the driver and in core. I was
hoping the driver can avoid mem-type checking and special handling. In
the case of the tx path, the helpers provided are
netmem_dma_unmap_addr_set & netmem_dma_unmap_page_attrs. If you can
use them, great, or if you can improve them so that we don't have to
have per-driver special handling I think that would be good too.

It seems in your driver you have a special  way to grab fields via
FIELD_GET and that's why you can't use the common helpers.

But this approach is fine too assuming you're ok with a bit extra
complexity and mem-type checks in the driver, so

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

