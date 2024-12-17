Return-Path: <netdev+bounces-152501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EBE9F4532
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8AC7A42BD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E718DF62;
	Tue, 17 Dec 2024 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNXcsza1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8617ADF7;
	Tue, 17 Dec 2024 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420850; cv=none; b=l61jHleFR5gvoIHkKH+0L30GBjJdruq0TGSxMRRuIapwTn7EQjrYn5isHY3Nldl2PKvWVtxhufZkdfa1hEzBZYUOXfFdWi14Xx9fWWR+RwuoMw2+KKwYDj0yc+Z6KU/Ou3hz8+GE+3ED3QXgp1QoaPZVb/fuulMZFqsQmu51eLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420850; c=relaxed/simple;
	bh=olhZcYuW1fDR1PgFTpJ/iorAxH2BivEa2uczQcr8Y14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f73aWX8kVZxLwFIxJfFdUZvdWTCfxwA78ryuzfLwBSX5V+4WKIg8e/ftAMmPBmR//9BAHuATRNg3ta9VWJq6D69xLOtUAW7V/MdK4NWmr32mKHJ6kgpJc2zYhbeuaikf7Xh4epwH1R1/KIG90wETPGB+2Kk0wPURFzFmzRzLblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNXcsza1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e396c98af22so3319113276.1;
        Mon, 16 Dec 2024 23:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734420848; x=1735025648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE1gTGlDwVj2Fc5IMtaDZ/2I6EVudmGb6w5pRZ8XO6U=;
        b=HNXcsza1KJ/zDyLm2DZCS3g0Z17z+Ir89kNV2i+WVISRW8Dm0cCPAD5NQGjXvb+Nu0
         i0lLw73WuhXyXUlTGoVww73xaw8zegWNzhri6J+ZS9GjyUGHZJfKg/25mQAk40/klu9O
         VhJ2yFQAmVU1yldb10YGpfHYnylcRqLioHJr6NYeCI2fldQj0I42DdWoXYbI/l5SMUDR
         Iv+l7BG8iJY9r8B8gKctLBBrHVHB9ZxUEw54klWzHIMFz0gMKk6aKd6RkxWw02mFGn0N
         aq6s2ha/535MGajuklI+Fos2F9uuLlriRwpqskfZJMLxqzY0DTMa6ZIN7AmnrB3t4Gq6
         loBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734420848; x=1735025648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nE1gTGlDwVj2Fc5IMtaDZ/2I6EVudmGb6w5pRZ8XO6U=;
        b=PNw7krO6K1yi2YWlNVfSOCezqDJwm/O4BtHXe7gW+9zg9v5TqXNJsyKJ1i1FJFe3qw
         3mOcUkJt7ZssTklixn0VBcQgYvW7UlBcZG9FyLlQtb8aFwddnbL6K90nfjn3LehixMyN
         JL0q0DB8Lwlh2DRgcEL33BdAqYeXqW2GvP2r5t8ranfWytpKCc9xIPDYWtCFa9BzKVev
         vV1yEi85Lwhsv4vnKgaTxrUFXPxpmEsMl/SBawYblaSb+1loI3wvMJWuYAIFNmG0tRfT
         XBBIGCHzS29m4Z54Mgcf4BRLSElrFLeG0qO0KYyi39COAJ4yAr5MamW4cwzJXcYtKuHq
         cBcw==
X-Forwarded-Encrypted: i=1; AJvYcCX+zJyBDIHlYZrCL3rzfT+jCGQ0EX0Tz8BF8g2uFn5vheLwE37OcXuAD0ZnSwP0MzxbRtk9LsY9@vger.kernel.org, AJvYcCXxYtd4EE/yyvCc1GDMJpStYIQPLG1aY+kAAwT8Z4dQOEgVulaYReAM7841fY7TiV1I/nX2akgJwwIy71E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpj5oJwTTXgrDsZz45lvvIc3dhBv5wJE0/FYl+wO46YkpQK10
	//aOqYWpJC26wWD44O0ggALP4bTvKc/CUXuxLrHgJaeP6rWFVx5Cx7S95Q2o38CN/2BcZfpyDXL
	Q10s0NUN7ZwQz5DUCx/QS/R2zURQ=
X-Gm-Gg: ASbGncs+qdfQW/DHrMnKI25eK+cxHJ4Vi873f4UkDIJtt8q536JGupx8R2VJoyHVlN3
	ya7hunzj+AwSo4MURLE5XrUnRyrVa6L8iPif//DROySnTg400VK5oRhTQH5HjLakDl81hH0dI
X-Google-Smtp-Source: AGHT+IGQxqH+HY7+nwZQpPpULPyNKLJLVP9E2/dz9fO4AbrbDCgdbGcHjIus2Ds235CvFghvkLh7gScJGbOR4Sn49PQ=
X-Received: by 2002:a05:6902:220b:b0:e4e:4337:68e9 with SMTP id
 3f1490d57ef6-e4e43377198mr5061233276.4.1734420848134; Mon, 16 Dec 2024
 23:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217071411.3863379-1-buaajxlj@163.com>
In-Reply-To: <20241217071411.3863379-1-buaajxlj@163.com>
From: ericnetdev dumazet <erdnetdev@gmail.com>
Date: Tue, 17 Dec 2024 08:33:57 +0100
Message-ID: <CAHTyZGwAit_FSHJDSPn4QpCfim321aB478YDuC=uUhvBgPfKGA@mail.gmail.com>
Subject: Re: [PATCH] net: Refine key_len calculations in rhashtable_params
To: Liang Jie <buaajxlj@163.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liang Jie <liangjie@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 17 d=C3=A9c. 2024 =C3=A0 08:16, Liang Jie <buaajxlj@163.com> a =C3=
=A9crit :
>
> From: Liang Jie <liangjie@lixiang.com>
>
> This patch improves the calculation of key_len in the rhashtable_params
> structures across the net driver modules by replacing hardcoded sizes
> and previous calculations with appropriate macros like sizeof_field()
> and offsetofend().
>
> Previously, key_len was set using hardcoded sizes like sizeof(u32) or
> sizeof(unsigned long), or using offsetof() calculations. This patch
> replaces these with sizeof_field() and correct use of offsetofend(),
> making the code more robust, maintainable, and improving readability.
>
> Using sizeof_field() and offsetofend() provides several advantages:
> - They explicitly specify the size of the field or the end offset of a
>   member being used as a key.
> - They ensure that the key_len is accurate even if the structs change in
>   the future.
> - They improve code readability by clearly indicating which fields are us=
ed
>   and how their sizes are determined, making the code easier to understan=
d
>   and maintain.
>
> For example, instead of:
>     .key_len    =3D sizeof(u32),
> we now use:
>     .key_len    =3D sizeof_field(struct mae_mport_desc, mport_id),
>
> And instead of:
>     .key_len    =3D offsetof(struct efx_tc_encap_match, linkage),
> we now use:
>     .key_len    =3D offsetofend(struct efx_tc_encap_match, ip_tos_mask),
>
> These changes eliminate the risk of including unintended padding or extra
> data in the key, ensuring the rhashtable functions correctly.

I do not see how this patch can eliminate padding.

If keys include holes or padding, something still needs to clear the
holes/padding in objects and lookup keys.

struct key {
   u8 first_component;
   u32 second_component;
};

