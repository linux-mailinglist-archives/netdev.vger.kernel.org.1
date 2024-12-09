Return-Path: <netdev+bounces-150318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB339E9D9A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3370E283270
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C81B042B;
	Mon,  9 Dec 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbFXusl9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A31ACECC
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766792; cv=none; b=gSXCwmmHIDudEJNuqRl0dnpm1QPP/gYXG3H2UJCAdqa98JAauroQ5mfwEZchyvUPQc1dZKf4EZ/ntMbWiD6hxILxw3BprkpyyIk44jDcDNt0Objn8XN18rzI/uEM2FzSwM3XvT+x/RrkCtEDBnsHZJWew/HQOkfbOT080t810gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766792; c=relaxed/simple;
	bh=aVUnsz64ejWmdnGcCpaM1dalStXg33ZxABoCKyq87UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYQXIKKk7uKSALpBWkeKD5NPHQkZlIHlg1Ic0Uy7HQiPhPucfY81mOA0CR5T4RWoIu73TEwLwEV5lftp/nPv0qRF3mxQDrnm2lirvUN//cqLJIQWUR0q7M+9nOAxHBaZo50r+5taPiFk3IerLDdp9At/epZxcyyUYb2OWWcrgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbFXusl9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4674a47b7e4so665171cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 09:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733766789; x=1734371589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/K41QGjgWHbPiJSZ5FkrX6YIRP/Q1Ebmrn4ea8wj/g=;
        b=vbFXusl93vLsibN+U0ckf0Yb7hDpWgbgqYJQtE9xEwInJFhJrVIQBz+MLWaCSHWJRc
         S0frX0X11AlyQ2P3R+rOafjlxDx1Bk+bVbllcFXzV0tF5g72eQB7UtUrILDfDZqJUA9U
         sSwig8B2Mw8D/CiOg3kEcAs8uJH22JZjMOcJoM5ftUUGzNFX+J/aro6AH+L9yLc4Pya/
         TMP5s3UJB1AlhW16nJkRN7TqpL6ThYvnJwg3lZsMicqQ6zfRxN2eoUV9t9G58y9JqGRz
         SpTLGZgSpCzwovz0cKyw/jo1flAMoilSzbvTOB6KEwcKwCW+56FmJ5uh3yUcPRzb/VhR
         K4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766789; x=1734371589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/K41QGjgWHbPiJSZ5FkrX6YIRP/Q1Ebmrn4ea8wj/g=;
        b=VAmptnaPyotZTa/e9+EmEzAuXMKTltuWkbPmohdiHxezLOVGxzs2PDQm9ENts/gr1A
         4yNXdLglxyhhIEU+zSk5dnXpi1WWC5PyqZi+InG0HzxduEFYc3YCsdNfsYq2M3vzInyK
         RgLEO+w2IcKbqwBCrYMrrP5SK2/e72tbOihKT1rKCjbhHL9PyjicQX8KJe65DmNJYKzB
         4TO3Z4j2le/UmNX4A7yZROl8C3O4bniG8l1XKg5+ZTPb6+NtNfHlj9uZfFgIDQLE1LRU
         MzwWGV5zGiNfXSxyeI3OXaoq9T0b9CKK9dlwSpZeV0nnSJ+I8d/z13yJm5y7ydVPMwBW
         QqCw==
X-Forwarded-Encrypted: i=1; AJvYcCVvyPwQWzbTDiWZUSVQ0kPF3DEZwv//HhMFLkb/A6cM5iOI1bBRKzbpCuz/4nLi7Up8niM6bJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUxHmUi98a7c5qR9HnPLceGAp9lWvZ6U7brJ+mRQgCC/z85JB
	FWFTg0ggznViy++gO43/p3vnU7GZ9OxpWSpWpz3xaGSPv5C17nH41zsgqAdu4GEPPobhRGbXYtJ
	BtWfBZZl6m9psVU2/cZiG7vvdDPLQ5ZPM1lv5KQTNOIQ/5qWjiZZNIRQ=
X-Gm-Gg: ASbGncsa5PfEVccow2vdG6Zabo+EFL51RB1IZOj1RHAVbcA4E1+CHfogxjseMV0QK7w
	GZtFAtm/8lAO7rUtL8QhEIEkw3vw3TbtlthMmStx1cPpudYDWELu951KuyC3t2SOaXQ==
X-Google-Smtp-Source: AGHT+IGaidcoZ4uYqPGCi6fGz9pxTP5I9zilcU0jStvziyAiRK/W0dGdLo5BXdwvYDUBcNU7UMtTvaM2nwVzifrYIns=
X-Received: by 2002:a05:622a:4c88:b0:466:8356:8b71 with SMTP id
 d75a77b69052e-4674c96cfd1mr9418031cf.19.1733766789391; Mon, 09 Dec 2024
 09:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204172204.4180482-1-dw@davidwei.uk> <20241204172204.4180482-17-dw@davidwei.uk>
In-Reply-To: <20241204172204.4180482-17-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 9 Dec 2024 09:52:56 -0800
Message-ID: <CAHS8izO29gnvrqtj2jA9m1mNQK2UC9yCHd=Gtn+fA1Mv0+Vthw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 16/17] net: add documentation for io_uring zcrx
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 9:23=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> Add documentation for io_uring zero copy Rx that explains requirements
> and the user API.
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  Documentation/networking/iou-zcrx.rst | 201 ++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
>  create mode 100644 Documentation/networking/iou-zcrx.rst
>
> diff --git a/Documentation/networking/iou-zcrx.rst b/Documentation/networ=
king/iou-zcrx.rst

I think you need a link to Documentation/networking/index.rst to point
to your new docs.

....

> +Testing
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +See ``tools/testing/selftests/net/iou-zcrx.c``

Link is wrong I think. The path in this series is
tools/testing/selftests/drivers/net/hw/iou-zcrx.c.


--=20
Thanks,
Mina

