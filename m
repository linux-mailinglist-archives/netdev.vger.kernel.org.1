Return-Path: <netdev+bounces-210682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3762B1446C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 00:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14191892648
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 22:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530022A7E0;
	Mon, 28 Jul 2025 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0LTMk3mw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93421348
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742052; cv=none; b=RH8w1H9b3gMUAxPnHwmR8ssSCTr+cZ/WgJ0xjC7E5mfy8+jJ9qvVSWBkbj+ikB5Fy4EMkah75EN2n3T84gUI/d9apN2RhxBku2phzLTtTnYHWLTrfysgBTrC+0pP2HEUMCX7NeijVTiYLBw+hk4jvxH6b0e5lBJbqYp1j8eTDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742052; c=relaxed/simple;
	bh=3UCrbmM4TUe5jNsd3OB7q3gxg7zx3lB2FyqhXts2q4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5bM0iBYXTNfvrnjwmvihVrueGTJfITVaDxajSCXhskxydCN4a875p2HY+zH/NQyrlA74jT1PRzL5T5tS7zk6JDis1ibT7B+ZwC8KnrETnmruwqHehcjdWxeJsFqncZTdn2+p6k68PvC9BXG2QpPaeMlciLN0LSI3oTkq7pcLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0LTMk3mw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23dd9ae5aacso30625ad.1
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753742051; x=1754346851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UCrbmM4TUe5jNsd3OB7q3gxg7zx3lB2FyqhXts2q4A=;
        b=0LTMk3mwc8OZ3txTRkz8FJYGIXPW1dDwnfr8XrGeIQ/IpYF+zQumoGK9aAsptY2Mgq
         yNXM4I/AiN1G/iuAfFrFxHNZxC0rCM2UQ2me3FSeiOnceawmwud0h3d6z6n0F5OZt6CN
         cqaBzKV4HfUcihFo1pXPYmHx0VzWfs4hON+LHLisIpz0Bz/4AZxO8h8Vcqwokc4q/mB+
         DVBNi+rlxjhQAdUMNcJ5UMqmdS9U24/Rw1LxRFXMiY4RXKre0POtVmXyvt1niZkbh6E1
         0mV5L1UbHGD463PX+sp/HTNurSrtS9PhHjvbrpjs/Wc9hplZKJIcdb3MnL5tt0DL9IZv
         I6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753742051; x=1754346851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UCrbmM4TUe5jNsd3OB7q3gxg7zx3lB2FyqhXts2q4A=;
        b=enYFHy9ylWIH0lj0xbZHmNNU5grk7H8azOWWfAXH+B2xb/E7k9szp9y7vmT59AlP0s
         PNqcnFaElJp+Q9aCM2ohF4BkrABTD4B06sagLA9LU+aNQ+CcfCZP+3Z+k+YaI+ZIpf1j
         6KZkBk5CV917rqKAxDn/U6DazIUYPScPfxAcHjx+kujo8xBSYV/fedq81kLdW/H9VVwk
         QXXPmflal1HyLM5nieiB7IbrRdokPejz6CaERMSCZarP1R/c51Wlwr8N997TeOTaXjGm
         3nmtnYyfVpEROdwArBV46Ez9SRnb4U6yGCYpN/j7GoJCemKRqhBVu2zVKN+ZqF6oJLQk
         8K5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQlbNEma53vJ81jcrWbFz/oVcPOXEOgGvvgHevUdyFxcvYzOBh5sVItyIQApRKYDZtyCFfFwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRf7/BsctcrJvsPOQKILck/y00w4aBlQRFvaP+JT1dF/icOO6h
	Li3jWBszit54276KqkASLzS9weMack6yqmU+0Wq4a9NAbZARr8OW585d0nrqCVcAJ2F7/Ayex+V
	2+NIAIGR0kujHHBshW45m1BhRBZ1vPypzLA27YXh0
X-Gm-Gg: ASbGncvntPDuctb9q3gQ84HaYKX3Jv1CWy6bXhL+1TBA6GyqC0nryOwdr4QtACQ/X/n
	YENujogw6lsaw8SdZD1H8GaxnK9PtDVOl0NUq4UQDqDh1qIdCkBjub4/W6vmc4BoHbkrxHn6N5x
	c0NP7ZEHr6lrd9ZrfbCmXs/pQj7Y3QxKUSdFzvW/uosZNv7id57tKzPIRad4nXWXWz1FUGf8PUI
	tdWrCerSDK+QgQkcp9S7C/90qCsr/4sdplEng==
X-Google-Smtp-Source: AGHT+IEAXAUwoTkzWcguXCPpeCJknoeSxf6WSVJcrpemivAZuZn2dLYX+Id7YooQkRji8cvKSzxfT2H6Go7mECX9ow4=
X-Received: by 2002:a17:902:e890:b0:240:3c64:8638 with SMTP id
 d9443c01a7336-2406789b433mr1218905ad.6.1753742050476; Mon, 28 Jul 2025
 15:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com> <be233e78a68e67e5dac6124788e1738eae692407.1753694914.git.asml.silence@gmail.com>
In-Reply-To: <be233e78a68e67e5dac6124788e1738eae692407.1753694914.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 28 Jul 2025 15:33:55 -0700
X-Gm-Features: Ac12FXytRXnslMV_ruTnL6but-O-GUrAFJf66XeC7Rn8cCz4NROrnnjw16MuHEc
Message-ID: <CAHS8izPZE752dfZVD6OzGJ7z_tmh2n2tvJK_0yd5mP51FCSKmw@mail.gmail.com>
Subject: Re: [RFC v1 15/22] eth: bnxt: store the rx buf size per queue
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, io-uring@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 4:03=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> In normal operation only a subset of queues is configured for
> zero-copy. Since zero-copy is the main use for larger buffer
> sizes we need to configure the sizes per queue.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

I wonder if this is necessary for some reason, or is it better to
expect the driver to refer to the netdev->qcfgs directly?

By my count the configs can now live in 4 places: the core netdev
config, the core per-queue config, the driver netdev config, and the
driver per-queue config.

I honestly I'm not sure about duplicating settings between the netdev
configs and the per-queue configs in the first place (seems like
configs should be either driver wide or per-queue to me, and not
both), and I'm less sure about again duplicating the settings between
core structs and in-driver structs. Seems like the same information
duplicated in many places and a nightmare to keep it all in sync.
--=20
Thanks,
Mina

