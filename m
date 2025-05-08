Return-Path: <netdev+bounces-188990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F106EAAFC63
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96C617982B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4612528E7;
	Thu,  8 May 2025 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE4vv4tI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21727F477;
	Thu,  8 May 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713209; cv=none; b=jaPYAuZRIxdK33gzVlwiJmhBVJDeUpf95yWimfI9edhMiHmO42QiMTK4SOz2B04m2134c3wL+Kl2lDGdnF/2qhdCSZ/HFy6FZWd4JkE+IHRIZxcf3bxyvbAXTrjS/A3G5CHNAxOO7jpHCpGQKAcXxPKnWwYjHoxNSgfeYGAXI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713209; c=relaxed/simple;
	bh=0P4ARVM+mJA2ufEze0dYV1uwKusuRBU2kQY+6ZzS2Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opTtaFShyHaLVzlzMT6yDC9d8AwSC7zWI251p5AxwSYu/zTndIUWJzpCGfRbrtP4RQYRukJt4UzFkPgph5NI/jDYhhrdbsY6Fggq9maaRTKkZ6OkmrjLHJwC/22y58opSPA0Aw5cn8kdlaGIaNQCZ1ioOiAO1VJWpdYVl+/7P+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE4vv4tI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso8775441fa.3;
        Thu, 08 May 2025 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746713205; x=1747318005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJK268rmkJso6a1jWD9YIWVDNe9zhtKe75WSd4eq3u8=;
        b=TE4vv4tIplc1vCAMVqJmsGcNpLfWxp9YYyNrM9BGuH5hY1OV/BLKNi7Rt6FLXKz5gh
         FMV99ijQJ5/ezUC9y6iac18gKAoV8OjKsJks6+fnmEySlUj4+lEPrcPi/fQ+g5X9N0JE
         4We6PLQfNA7Xmk+Riy27+2yi46ZRxBGiSpEW0GjogtTdWvIpHqEvhrW2pyItz4besXs8
         06pgMdLDJtpzjWkOZ11834+Fxa22uoIgp0VMhadwjZmOsdmhlW8PCmTcHvBXn9frTK68
         UszqjmAI4bJcii5DKItj+m4EHmRe7+uuFZdxEmvgQ0oWSwSdCXl5gR6VseeeEa/Jfm1H
         zf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746713205; x=1747318005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJK268rmkJso6a1jWD9YIWVDNe9zhtKe75WSd4eq3u8=;
        b=UWRpWH/M++JN2xPVjVFE2BMCijvCn7w3Jmvq3naqK1Jmb5eBVxnGOSZgOUgT5eFNZa
         gF0dLmMTkKeB7hN2Otkc7Q0IjoGbgCsLmsQgoHovQGXXZ4Q2h+xk8bVrIW+8uvUJ+je1
         l0qdr1NgzRm701FWkgfUtmWPCSlsHR3+Q67iLUDd9rpXhpcaRFZPfwHDmNTk6vYgkjho
         HKh3jHKh10beuYzqNMaryTGwYaZ79NgQVCCyclP84PgTsrrBcghweFJpBZ09CNgLPp13
         7VJrI7Cbhbz9sQ9m0mGAQBwOK+eC8LcqdwUq3UOIYTaJNThgbtyeUUhcsZ7BP79wn+z/
         Mybg==
X-Forwarded-Encrypted: i=1; AJvYcCW/s8aND56OF8TFPJQzDbVqpMLVN+lY2b4ZlhPyufUXuius5QCY+7na4YwG4AC7Qu4pk/zS7IsO0f8OgquiKoo=@vger.kernel.org, AJvYcCX3iS1DUllc1lSt+yruZYDOMVzAw5+s7a4sAH2p5qFLAANXa43osVpHkXH/GG6TS1radU+tLa1r@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjXvN4/Eli/XBi9n6YO8AkNe5CWOqdfe5NG3mkg9Q3m/okUdn
	i6h1bv6al2PVPrr+tLRaw9tzBWR8N33Q26eRi0hD/+dVF/83CeyKPnVg0dvgpnMT86QlW1mn7mf
	LxSaVOfiLkAuhryZNen81r9s0NwSKId3v
X-Gm-Gg: ASbGncvMN6zNl/FEHQoZZAGUK8vL4VuTqKnQtTGSVt9D4E6UsSegZHPW1r3psynL3W1
	Ai9gdr+H0g0SrQBXPX6f8wIbyzyNlNXjQIdC4SjHVXGOd41V10NuPMbt5tNkGcFI6sbAGrgjpwg
	IWVv7ICQFqoRokr0dkd+sL
X-Google-Smtp-Source: AGHT+IEN1P4l2lG3nFFui6REIKcEwgEbKqNEGtrgst6/VEmn4R1zdwW7A7PgUeVHFHJhiy2QYLpDKVjzgAvyVO+fVlA=
X-Received: by 2002:a05:651c:1473:b0:30d:e104:b67b with SMTP id
 38308e7fff4ca-326b88e9feemr12326601fa.38.1746713204568; Thu, 08 May 2025
 07:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507170320.277453-1-luiz.dentz@gmail.com> <20250507175500.2d725b00@kernel.org>
In-Reply-To: <20250507175500.2d725b00@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 May 2025 10:06:32 -0400
X-Gm-Features: ATxdqUGZUIK5rbE9Bm7Ujlui3l8VBEM3bmSQRSwZbAlcoWBXr9fjjyiJ8zs9YHk
Message-ID: <CABBYNZLOCXeKbTj1ZRAt-jPubSxCzJx2699VGzcuOHnN23waQQ@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-05-07
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Wed, May 7, 2025 at 8:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  7 May 2025 13:03:20 -0400 Luiz Augusto von Dentz wrote:
> > bluetooth pull request for net:
> >
> >  - MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags
> >  - hci_event: Fix not using key encryption size when its known
>
> Looks like we have a tatty Fixes tag in here:
>
> Commit: 9840f8ecc910 ("Bluetooth: hci_event: Fix not using key encryption=
 size when its known") Fixes tag: Fixes: 50c1241e6a8a ("Bluetooth: l2cap: C=
heck encryption key size on incoming connection")
>         Has these problem(s):
>                 - Target SHA1 does not exist

Oh weird, let me fix that, btw I noticed the verify_fixes.sh was
catching a lot of problems though, maybe I need to update it or
something.

--=20
Luiz Augusto von Dentz

