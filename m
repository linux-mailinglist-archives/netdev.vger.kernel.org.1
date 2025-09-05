Return-Path: <netdev+bounces-220298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75BB4555A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6A15A701E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C483176E1;
	Fri,  5 Sep 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I++wg3Ly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCC312802;
	Fri,  5 Sep 2025 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069644; cv=none; b=ll3L1Fllhf63KPZUhbPnU39oZwJCu9jAfVRvquZQviSwJtKquyD5j4WhXCaamxHb3bs5dDmakBCvVvDj0ST2xAwfsn5dWoObxVbHXd30iu5iTbpjCFfK9kYgHQLBiY23ayqf8ksbP8+gN73JVt+1c8UL4SkmdLzziWTBNd41QaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069644; c=relaxed/simple;
	bh=YacDwhjXx3hY8tZ2N+ln/+pHs9D2/60NzOdZt7FS4Nc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CJkMZBRSap3CZl2hf1TD+3OkjqZNu8pfK7Bpj9Rog+5TdZUWqvxlOpcvkvMBaFrTJpZvOcc/khCHRl7E58pDy3X0y/bymoN4ooGS3gpiHt72bzuGMPrRl10rHEXQTOcB6Zd2wDZT1dcxScKBabtHfE6bf168YMdX6IVsccwfqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I++wg3Ly; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3d19699240dso1849434f8f.1;
        Fri, 05 Sep 2025 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069641; x=1757674441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3PE2H9c4PU9mZ+3SQGTV677ZdVh4m7lyinNpMQnj4Uo=;
        b=I++wg3Ly6ISio7B2JSFRaQjgHLmeJbNb/Ot3X8yJOj6HjGoaYWyi7g+oqnpBvHUUOf
         YcQzjckczjXcKD5sL8O9DUkSZbVZEJKuuRIwD5Z78QiAIOTCGX0yn5LI8bzHq4DrSet8
         AsS7E8thSvOuviddWb8HSxJJJBw9OlzHlIvH2Wyo2beZDlLBEslLrqS82YUKsjK76523
         ipylVbFfX/PgZ7xWVQajwYTGe4JTJmty99LuPl7B4kn2IfiB7E36y6Ta5g6cQxbpxgqV
         qwNO14kcDNROr6jVXCO8rJJwxq+hfinpMueyXYC6sqUmIOdjjcmVxHFnfFpw0wxR3koX
         9yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069641; x=1757674441;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PE2H9c4PU9mZ+3SQGTV677ZdVh4m7lyinNpMQnj4Uo=;
        b=U0jP/eqcDG1o6JIUh8xEiMOoP33Mlp+gIEKMZMW1K7Vc36VZyfWfpHuPJffhGViYOK
         XK104BkVKMjJ0ccvhvLF92fRinlcBEI8nxtcPXMmn/enWm8QM/i5N4AhPtUTOD8+68BN
         lQnSgFDZE8Q+Cytr6zMj0QbSKO+fXyPAB2gZ9jWFPSiWYJJycW9gmAQD676E6JKT2YE7
         okY3+IPdIxrsjg02ctwV4J/Vb4LqFyKJ5DRlX/V80+13LuPg9UGRsH5wyslsXV/llpT5
         WtQR5BHxEVQyafDlnhKZA+cEOJjq95N6sE96Q2Bfuca2ciWO3baVtI9SCIwY2Qp8kHY5
         nykg==
X-Forwarded-Encrypted: i=1; AJvYcCUMuc5SlDJyZaAiBmGbuFttScHCf0Xc39hmcfKxL/oOxp1qa9bFVeBxOspU8SeQbItAsgXI4WemDEHz40U=@vger.kernel.org, AJvYcCVPyY7jjCV5Ya/eXR1Vush1kW6QzWVQC8VG7tv3vJPYl6h2aED/tNGNhHAI20Kxw8VJ/N2P3Iwa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1ykcrcfYIsDA4KJmESELdZjeo4Dn9276qTmqBT0Wkt//3ZFp
	Z4XP3fRgv12oKuW6ihdFDQ6Q8CNCrnGE8Pq0FYzbdL/OTShF4n1DkHqdq14lEouG
X-Gm-Gg: ASbGncvTQuQmdx8VkrNREiee9mDay5uRYtaSYHU3et6qLbIdDusarSBhpaEGnRa5a7q
	fpnaV4SVRk0hnX+ACsU5fqjrzy3RkLMVIIVx5h8hAHDR7ZgX3HEpyCgXYD4zd9K4uUcpSRj6Yum
	PhBiuM2+aiNcvMlTzUMSWgiUdzcdOeHHetuFdqHpgu3Dkm00Y/xl0HBf5hYzYTAoYS5uY9e3Ysq
	0mAcX4CkFHdgMUhyvRYrmglN9NlOJ27GXT5ugBpY3yXJUZds8WX/IwAmFb5aPCVqEa9PRjNS+6I
	1nMJCLd5+49e0wPI7XkDIIyq20CDsnpjmSTbcsMFPmOFolq5Naq3lsV7jZW8As7GEcY8iK3oie6
	v1s7fzvKySCcVvychE3mBAG2c+ZktD/K7ktXNZczp+IZfsw==
X-Google-Smtp-Source: AGHT+IGH0k2jiW81eo+bdHP+jTd9GYQqAP7UqoTgWM33icxIe688vEVyRB0t11dPEBCY6nUUQ6kJ1A==
X-Received: by 2002:a05:6000:22c4:b0:3ce:7673:bb30 with SMTP id ffacd0b85a97d-3e3048266c8mr2409575f8f.14.1757069640448;
        Fri, 05 Sep 2025 03:54:00 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab14esm355347405e9.21.2025.09.05.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:54:00 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/11] tools: ynl-gen: define count iterator in
 print_dump()
In-Reply-To: <20250904220156.1006541-4-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:37:58 +0100
Message-ID: <m23491yyk9.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-4-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> In wireguard_get_device_dump(), as generated by print_dump(),
> it didn't generate a declaration of `unsigned int i`:
>
> $ make -C tools/net/ynl/generated wireguard-user.o
> -e      CC wireguard-user.o
> wireguard-user.c: In function =E2=80=98wireguard_get_device_dump=E2=80=99:
> wireguard-user.c:502:22: error: =E2=80=98i=E2=80=99 undeclared (first use=
 in this fn)
>   502 |                 for (i =3D 0; i < req->_count.peers; i++)
>       |                      ^
>
> Copy the logic from print_req() as it correctly generated the
> iterator in wireguard_set_device().
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

