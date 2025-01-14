Return-Path: <netdev+bounces-158089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31F2A10714
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CEB1886ADE
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4E236A85;
	Tue, 14 Jan 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4O7Q2bR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E7236A6D
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859040; cv=none; b=FJAaVYKn15Y1WH7daf9F1DWLk7sQsA5nldwV2ABhXVFpnfo0US6Ho+vaUoqYKxOfdLqdNusPWt0VSsabBB8SlWQYYqljSSmfnRQ24OQW/hxUdNGA3vrLgozXwSDfmN49mi//1pBcY003P9wmbSIub86InHMN8+JNs7uHrKRps+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859040; c=relaxed/simple;
	bh=8yV2djqU9qw17t4pFmsvjclk+CtUGHBErb91Z2cUiCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuIyBHGcNXIMCo4+zgg5xL0b+f0tZGYuIOnEWlUhqO4ESXi89OvPhOd1dEtsus/j/aRezwNAQXPPk2NbBLf0ihvPW8YqAhAc98re8R95/FYUb4eIreg0BMdzrDZpst6DjcxKFBqZyPE/148Hve85MJB7UeVwnaU+LxOfTTh36UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4O7Q2bR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so9244873a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 04:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736859037; x=1737463837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yV2djqU9qw17t4pFmsvjclk+CtUGHBErb91Z2cUiCk=;
        b=R4O7Q2bR48Pp2f1flihdN5j7M3EjzaJuDURt/4oTf6XY9Je9jGfzaVhctuVJrznPfZ
         vohR3te2M9QWxxjMrRl5LbjpEw4QWuP81xYGAFKfBct/ARVZ5eJ9iKpgX/vk2cqYzdQ3
         P5UKGm6MjoDDlaDlUC8+nwNVZtmmfYrGoTZMLp3G0NS4PK2MfcGKeqrnxQesBQ7SczzP
         qbeTDnSKn80UTWSNPBuVD1QZhz9jh2C91RWADL5QlzJvOJl/1txzlY/F7oENT5AaWb07
         002yz1Zz7HGSTA/zg3M6/tQoStTakq0P99s5rcyCaPN++FHPIJd0ULvxKhgnzTnvlO0n
         VaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736859037; x=1737463837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yV2djqU9qw17t4pFmsvjclk+CtUGHBErb91Z2cUiCk=;
        b=REgt29ByQlHz2fPvW9SS15C17hTGv+2qV8fCyGyYEHkKzSuIF1rROOH5WTFgRcXcLh
         GeXECnF04RCV/LvZs+fY1qUUggs0X6jax+GHHLHm64XDjzWdO1vGrS34d72NuQUojyAX
         V80S1YHZG50C7l3mQh8CSGmuYNXCRlKZ1FJLjdN06HLEOl9kEpYLmIIP+k9uFGYISY4Y
         LHTwhm9cCWkoxOVPkevdMZXLxMp1UOotB+GLpfATWqh2QfjIoLJVqexj6i4th5wrYLN2
         CAHVLztCJVrxOna1w7sNjQKdQ3gVonnmyz1Ho1Co9tVo9tJxariSaZMCyjdm37vy2+aJ
         Ya+g==
X-Forwarded-Encrypted: i=1; AJvYcCUvdp4c+eEW7DZPZr40//An8nDGlPqbr+5JCqXSwaANmvi4+A2ny+KFZfD1DdEHWd5Spc4M7oU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zvM9Pt6CvP393eG+Qspz0aD5R8qvp5DVGjr9XicEFH8SlBvq
	vk801deywDJmLrNgizhubCQ8NxBIECb8ogmOGqq1HyB9ByKFQZ8dLp8ZAaGOFj6yA1xueSYvpb2
	DbA4ptgW+sJcLWKO2yaRm8zjZxCQ/PWjwON/X
X-Gm-Gg: ASbGncukQ0hIjmlSqCytSAb95qldu8jSfSRYYdWWufVwI7qWy6Pdk6yjNMST4UBsgci
	Xe8/Tp13NyfZxTyx2GKIG0OCkT7Mi6tYLy2CEKA==
X-Google-Smtp-Source: AGHT+IGYyAbBOlnb7zIb4T64sA/ACDrhCmZcPRgXJP2AU9qaPLn0jOyb72soXGCgDfV8qiDBIAmKCpoDrQow5zFX6aU=
X-Received: by 2002:a17:907:60d3:b0:aa6:81dc:6638 with SMTP id
 a640c23a62f3a-ab2ab6fe4f4mr2157378566b.16.1736859036988; Tue, 14 Jan 2025
 04:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-2-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 13:50:26 +0100
X-Gm-Features: AbW1kvZlH9JTJXksVqSuQcWjkHsdTdB6fVFAjbB7Owenq6Su1nxYrFj9JV2pal8
Message-ID: <CANn89iKUMkWZQHspZ2r26_ft9zp0wy_yZs96kn2fWFVcNuocdA@mail.gmail.com>
Subject: Re: [PATCH net-next 01/11] net: add netdev_lock() / netdev_unlock() helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Add helpers for locking the netdev instance and use it in drivers
> and the shaper code. This will make grepping for the lock usage
> much easier, as we extend the lock to cover more fields.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: anthony.l.nguyen@intel.com
> CC: przemyslaw.kitszel@intel.com
> CC: jiri@resnulli.us
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

