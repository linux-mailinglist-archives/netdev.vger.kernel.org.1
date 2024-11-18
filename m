Return-Path: <netdev+bounces-146016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FC9D1AC2
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492E7B23922
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D44D1E6DC7;
	Mon, 18 Nov 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqMB9SSN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6E199252;
	Mon, 18 Nov 2024 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966316; cv=none; b=d6CyJqWEQcPbnmYpfyKHSBOh6s96lArjEtRwjOjPlIasAsebLWCrUZXSUU0rJfrwHcQnqQZ6nyMMGO1QcIA8enGBDBInpcLRfzQHyWtM8/kEsziU5FQPsWGkPsQnKbQux1cs6Iv6qvV1K0pPYybC77zmxppX9vQahvOrXvj9PRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966316; c=relaxed/simple;
	bh=EV8vlfIA5KkDrhtRabLYONVdNTwjCWGsjLBhtwrXy5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iKkAq5/m1f4/WJDXze6Tdin6NJ6WTISGgXHtaMP44tqM0HgwYftwdMiR5Cba25JS8i18Z4YISl5M8cz3zFFOHbL7DL9mcxa4NEpk5ph/dv6cpO3WMqY+NdA6lZI+88+0/pdbrrgqg8k86Xm1+BMlta1YB1xzI833JIsO1o18Lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqMB9SSN; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ee7a400647so4212207b3.1;
        Mon, 18 Nov 2024 13:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731966314; x=1732571114; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV8vlfIA5KkDrhtRabLYONVdNTwjCWGsjLBhtwrXy5o=;
        b=hqMB9SSNwBdmm1nQUfpzahyklELVUdNIdr4R79BqN+ueNPCUfOmYBzqtaHlSv+UZ5S
         MzBx5jLUibmoLVAkLy4Nr0wE94nVvO0HlWS1UgiPZ2a3ikj1ZKe0yJS1xPnkFbSkE8Dh
         c2/luyybb7/j6K1fTiXkoSTguzAeAIvaMy5rHB/Ro72gZ9bLQ9NbtapQz2MuRf12UjIZ
         kuasQLdmn6pG8brl6JqsNYzgIU8KTZU3nfxTdULmyEbcRxu3F8j8gZmumaUEX4OS828e
         D5FKCIwpptiFr6SXghtbTiQVhlovaXcGZ3QKMbylIvn+0QsQY/taIU2TrL0rE5PpXUa1
         6Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731966314; x=1732571114;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EV8vlfIA5KkDrhtRabLYONVdNTwjCWGsjLBhtwrXy5o=;
        b=YaBtoSWKDihh9wv/SKFkscO1Yt4biW86Hu4/HpiKKsSLPV9EU+5GbasTD7mSjR4MSe
         aGPxBDSGDoaCgV6egy//dyj/ShwvkceaHnWrDKu6UsnSZW5NMHk5Q2NZCO7aNZHynnL2
         WbSVsMwmr+leGJomTNzhogc7FNNQoAyyN4KrxQ7Je8wtCyFiW4n7cUB2oA0QzaVURHOW
         2IfC1q+vrkzVzDtGICEQaJ9/4ZrdZpMqsCU3RprB49dCqYcrYaauVq27TwU3wuDUY9eS
         btL+4joWbptvbcwm8DJEXEKI9j0UZd5s9fKcLwwQOZvns3IY4z4IpAoWsKengA+BqqNq
         jfnA==
X-Forwarded-Encrypted: i=1; AJvYcCVvNyXWcYfY9OMt6aCFLs/EioKlPnS5TzbbPNPLJksIX00BuOIZvz7UX9nRQVf8H8XdjpeHxPz3lFiMI/o=@vger.kernel.org, AJvYcCWEYy8MvzseqgnM1y8pXWeDqt2fTYwhdO3J0ViBBqCwVoAVPzdpaYnsdCALeXkYIa0DveOkinlE@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZ4L6S5VuQI1VM2EuHXQ5J3W6Py2VRk9eJtg50f0pEohv2CTL
	qf3ibyinkZJlz4kfONXawn/GXV+Aq/UYyeK4aOWJk21dD922lTgfT+aFI83hsG9rRWmA2Dv+InW
	DSO4a5yjD3Nwbuw7NedDhiRxFtsY=
X-Google-Smtp-Source: AGHT+IFNLY46jblZ0/qsv731XSKOLKE0byRJUbFupsSH2S+mwDvNFgqOARyehQ7zBQd7ZO2OqZXA9uBLHVjV9ozJN0U=
X-Received: by 2002:a05:690c:6b86:b0:6e2:c13e:20e9 with SMTP id
 00721157ae682-6ee55cf369cmr127289547b3.38.1731966314096; Mon, 18 Nov 2024
 13:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118212715.10808-1-rosenp@gmail.com> <Zzu0jj6oQT6oOVot@LQ3V64L9R2>
In-Reply-To: <Zzu0jj6oQT6oOVot@LQ3V64L9R2>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 18 Nov 2024 13:45:03 -0800
Message-ID: <CAKxU2N8FHWNf9O6-az4ioJOYNPTtp+Ds_z6Eg68E35mt1m_DFQ@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 0/6] gianfar cleanups
To: Joe Damato <jdamato@fastly.com>, Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, maxime.chevallier@bootlin.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 1:41=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Mon, Nov 18, 2024 at 01:27:09PM -0800, Rosen Penev wrote:
> > Mostly devm adjustments and bugfixes along the way.
> >
> > This was tested on a WatchGuard T10.
>
> FYI net-next is closed
>
> https://lore.kernel.org/netdev/20241118071654.695bb1a2@kernel.org/
>
> So this series can be submit as an RFC or re-submit in a couple
> weeks.
Ah missed. it. Will resend eventually.

