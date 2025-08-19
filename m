Return-Path: <netdev+bounces-214944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF51B2C3BB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8464B169964
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555DC7E110;
	Tue, 19 Aug 2025 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbLyuUmv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8002C11E9
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606625; cv=none; b=ppN/2jWNbNwUviC8y1qp6HWz9UGcv3AywP145QWO10Vbr6VxDPcusiYPSmIxKYPu+HOzmx4WfNkbYFHnsxVk8k5ZDvEm6bEKX/lBepoOXk2Ft2Co6lVkoRp4aKNJTBfYWjc6y7LwrY11TDGFBHOOA1nxxVoLvTIBF1lKv7kbzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606625; c=relaxed/simple;
	bh=CWSQL8dO6Irtz/R8aJ/oNYT/8q3KoQFMMRF7zKsy8Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeaPhxyn30FWnfy1XJgSQbzbOrXxz3OTVONxtXhmN9MfgPzPBHvpbEuXctDUeGFDVSeJV2lSIGPAQpFxzbkz5YnbDlIx5hRlllSI5T9nO6jk5/Nc8uNw6ucWZPsLawCR5QRy9Njbkyh4jkG0VWvIwA2ccJwFI6OpEeOinf+BeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DbLyuUmv; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f9160c2dso40032341fa.2
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606621; x=1756211421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mz3YcatxQz/MAR0tB3sFTU/oRUGeJybwVjI0BMf7mWI=;
        b=DbLyuUmvB0DICJ8vmdA99F99MWxiXR+P9glqTBIR+Qtd48VE0Jz7Vycleg0YA+Roy2
         uavG6aZf2ad97EdiWMVU8ssAV+gEI0NEEt5mOWPTdCC3dOGmCSxJLY/5D9CGhbDx88RK
         mUWnwLDbiZJE8G3y43RH9hJHClgVGe3tY3xHzlyZkUvLs8Km2sb+C5RbsHjZ/09zSlUK
         tW4qO2SYfIxHz3i/DlB7efBLOc3bx+X8ulVWYlnzylyGqw3ljw7y3kR7oR1jH63kNiMV
         srVuXZdJidJrdC3X0v3G/jU2O46xnRgtOxoCwfDrGodCqdx0WzDZcyk2NCd5LftNLd0v
         /2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606621; x=1756211421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz3YcatxQz/MAR0tB3sFTU/oRUGeJybwVjI0BMf7mWI=;
        b=SjqzGyBayKi6v6q6xi0Bch2DAZ6Embkej+O+o3zDBTYZePJMNyNpOl+BWxfYye2c43
         /Xl+0iYIYv4G6S/g+6D9x+uygECbO7mp/IIBr/7gWPkiw+7fyGyjeso+kBOCz7TfJJYU
         cPp9uI+DzuWEPSn0vPEWjugSmAxaty6Jud2/WpYSllhdOfYIhSDeHhXcIm/QUSUoXbHx
         d/LTx8sv51MSLO7a6+qU06Vl5DrHcNy9KRrIGehs0G1UegX9NVcfYNIlTRvfAbszq9mu
         pMMer9l5ujQONIU0blHPPDw5GRLI0IZTv/HXXNy/ZTHFpmoIXaVF0/2nw3DVlf2/VAv1
         iPKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH7UnMMhMwF/Y/46yFyy0Ql/rtgnlqmFbxjBbZwFQQqXfY2fMsKX8MvKiZ7pdo+u3pJMfrSPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdvmtL4Bf7Q2ZQavBhFPjbtdu39AS4ZTVJvVqhHRznOG3MBz0
	nV96yke2HU2XIH38H0Dm7ymRZ9bcIZzoPDkV3bmMqFfEwBJeGYcuTHFFB9aAv7sL7wNZHzRdXoA
	gZbd1qdwti13Ga3ninTjzno52E1KUbduIzbOhV1Ex4w==
X-Gm-Gg: ASbGnctV2DbnCyxuFMPehX4S9JpEYMJmjw/JVzMcQdKrArbNoSjlEr51NECZead8c2S
	A7FfX2kkxaOl6gcxDUqJqmC2Ld8MoUtM21/5n1OVWjMiB+MvhVQYJwmca6vHZ6wnijBcqxQCO67
	yn7m5zXwCL/+SLFnBW7FxnYqCCjRvfF2mf+2g+dBu/ohHAWvGM4jEBxz0ItEEMjd2vFiiZ8ZIPa
	ZuX3xrGT21lcBAn9w==
X-Google-Smtp-Source: AGHT+IGEpafywi9Y83z8eXruXJLvtDo8H+1MMTVlX3ptkeqC3aV+hVoB9EaHaxAd359olnPstxNSpNv7pvXy1Q57aSM=
X-Received: by 2002:a05:651c:20d8:b0:32a:6a85:f294 with SMTP id
 38308e7fff4ca-33530727c9bmr4906291fa.35.1755606621517; Tue, 19 Aug 2025
 05:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
 <20250813-ks8995-to-dsa-v1-4-75c359ede3a5@linaro.org> <3282289c-2cc4-43ac-a187-ca8ab6011015@lunn.ch>
In-Reply-To: <3282289c-2cc4-43ac-a187-ca8ab6011015@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:30:10 +0200
X-Gm-Features: Ac12FXzS3Du6MRgoqV1G0kYWKOFi3949wr_2EHsKsRa-YDo8rgyGrWkO8_p6OLE
Message-ID: <CACRpkdYO=HuGou5OWkyCQH+7Uu98k3eqjfTYiCvEpjFiN+2MCg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: dsa: ks8995: Add basic switch set-up
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 1:12=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:

> > +static enum
> > +dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds,
> > +                                      int port,
> > +                                      enum dsa_tag_protocol mp)
> > +{
> > +     /* This switch actually uses the 6 byte KS8995 protocol */
> > +     return DSA_TAG_PROTO_NONE;
>
> Is this protocol documented somewhere?

Yeah it's in the datasheets, albeit in text and not with proper binary
descriptions and examples of how the special tag should look etc :/

My plan is to implement the custom DSA tag if I can get around to
painstakingly trial-and-error-implement it.

Yours,
Linus Walleij

