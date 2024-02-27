Return-Path: <netdev+bounces-75284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C5868F69
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92C9286121
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFFD1386BF;
	Tue, 27 Feb 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jKiBzUg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01913A242
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034575; cv=none; b=AJwgbMaM3SwDy2Bak+B57ByuhePly/IjtemX/De4H6hsRnXraroust7/VW5t26w5JT03ytUmkKvcrwmKNWb4oTAiqeF0zcGCn6bCo3TSGXATDmYE4tEfRBCM4OOK+S2CViMYI//PXJNLKAn1xxBYaNy02fb64yajD/zkoiyAFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034575; c=relaxed/simple;
	bh=VGay/3Ebkxl/9lGJaM3mzIwKZmmlvzEPoFYIh6Kl06Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyGZTg94xVcu5ln6gx6FdzGKP5OhTU21CPLbSm2D9DJxCGbq7zrwnt+avRT5qIWka9PqzgB8FkCY91PKjVei8XnfYJRmp+4xWEi1fvGeg9azok+ZqUgy43XNTptUWsgz97g5MNCB56GIE4kwCMsGLZjCcW0fjOePD0URzvP0vi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jKiBzUg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5664623c311so4120a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709034572; x=1709639372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRbPvz6OZBfIpJwWi8dauFMRjdTG09H8u7qbT+bN9jA=;
        b=3jKiBzUgcAWqTYgoFdTyoIJoO2f2tpkRk8rmK3NSl8+kn3XKOOtUHY+7zH3RK7ohND
         ohPE6Xm9FtRL5TwEB97SIDTXvx/KwTvOxexAbO2Lu7zuY13kv5qvX8we1kasagdyAmFa
         aFcWVLvFJYAGlhbbUxh3Or5ySkwTfDNBMhlsE9hH9XbM14/BlEh6pwU/C4K8O13IhiJn
         ZhE+cMOEVtkDVTl8gdoYrqRUoST6bgt0/r6DwhKwZHy4DXYQ7hKglgnWg+h+BEMaZtV/
         yOtbhb9TwDV+5YrlbX5TgqomC20NtGeP24aMTOTQrg1na7Boa3zDL4vBILL74G1sD8b9
         4VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709034572; x=1709639372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRbPvz6OZBfIpJwWi8dauFMRjdTG09H8u7qbT+bN9jA=;
        b=JgyrJlb+ovsokFlbRZ0jeQ6UXy7BhQKl6K4+G/GJwv1w+Y0shoRWEOxvtYRgkjLmvm
         t1uL3jsKpMGi3IxoR4CZQtNtOWiIgjxN+E7+IW3SpsDL4HAAF3SwgdRvzHpz5HgWsdzs
         sHVNi+2MQrf+6FVd4Qxw/prQ/0HzXvQTpK09g+oNkg8ha6pYA0ZcH8ZkaIktoQdsKy2Y
         /De7xPYjNPAWR2LDRbnZDIjRRlztTsnv34GomWuQqx+UuqRUQEyEkLvyPoyMAFEMcg3q
         lV2/QO5WatoVnlHDVdOfJ/oydmwBLmbWLx/TfFEgiUWlomBDftTPciwJT1OSizhu13QY
         N+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCX0xk9jpBrO4L7q6EfE2kWZhgh8ohuRe8QDSXn0zJokcM+adnOPVWEUi3SYAhgLNB6s4pLE5o1JKWounTMOoUNopPiLZ4v+
X-Gm-Message-State: AOJu0YzOZ5JbINVr6OjjMQODD9YAY8g7jpKAdEZqZgB4nCgUzm/VMSvQ
	6eLPhM0B4b44TPwuS+IXrbpDwanmlHUkvnOVtWbJ3li1zFq1sttlkRadf65G+ZKdPJ36QAeJZmZ
	RhgVMe0XVfj1QXlBUj0yMAtxhrn+yXDZznFvQ
X-Google-Smtp-Source: AGHT+IGrV7PZVg5DnmF/5DvdGvlbEx52cxgv4Gtc8F+rvr5sCV6iO9G7pTwjGmj4tHyazJYVIeCeq0o1Rhu1pNSlF5o=
X-Received: by 2002:a50:8d5c:0:b0:566:306:22b7 with SMTP id
 t28-20020a508d5c000000b00566030622b7mr139597edt.1.1709034571536; Tue, 27 Feb
 2024 03:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com> <20240226155055.1141336-14-edumazet@google.com>
 <ZdzCkxLBi_JybU25@nanopsycho>
In-Reply-To: <ZdzCkxLBi_JybU25@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 12:49:17 +0100
Message-ID: <CANn89iL+2YWzhQ-LEZT4pV+p+5Q=yk-D1mL=P0aDzpTb-8HJdQ@mail.gmail.com>
Subject: Re: [PATCH net-next 13/13] ipv6: use xa_array iterator to implement inet6_netconf_dump_devconf()
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:55=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Feb 26, 2024 at 04:50:55PM CET, edumazet@google.com wrote:
> >1) inet6_netconf_dump_devconf() can run under RCU protection
> >   instead of RTNL.
>

> >+              ctx->all_default++;
> >       }
> >-done:
> >-      cb->args[0] =3D h;
> >-      cb->args[1] =3D idx;
> >-
> >-      return skb->len;
> >+done: if (err < 0 && likely(skb->len))
>
> It is common to not mix label and other statement on the same line,
> could you split?

Sure thing !

>
> Otherwise the patch and the set looks good to me. Thanks!
>
>

