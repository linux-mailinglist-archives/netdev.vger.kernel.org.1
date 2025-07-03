Return-Path: <netdev+bounces-203666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0471DAF6B7C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1436F4E3C04
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520CE2989B2;
	Thu,  3 Jul 2025 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rX9IdXXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1802980A3
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527566; cv=none; b=km/qe08BNkV61tdndL7oWRMkz9Y1FlLRm1NOJCEqbxCKjpxpptIYrnGQmHJBAvmHllRqtrIxTF1hsC+DLBLAozfY0kqXapIfOZOvJpVyv6fAnyqY/tXTqDbZoIJXui+ppBt5ClnTgVYZ8LKgz49Lp56vbmnVTX6qoQ+I3UNhWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527566; c=relaxed/simple;
	bh=Pw31JZeDXI7i8TQJKGuvOQzyl346KQ+6dpe3rHsz+zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcD7lbrNnsBn8P0QD6kGpJngAQ2nlKrOXYD9ld36Jr830BcyOhlX/cm8s0n2yfxx+jmxo5wFlnZjKsk/Xg2opn+g53xzdTPPAVa+uuAAvaoP7QNO8U8tm9lFwHHb9zfWaSqf4TpBjH3evLnr0+yxu7UXQoh2JLAJ77bNnxIXWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rX9IdXXh; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a52d82adcaso70028741cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751527562; x=1752132362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw31JZeDXI7i8TQJKGuvOQzyl346KQ+6dpe3rHsz+zA=;
        b=rX9IdXXh/3l/sUO6dz8gtwkZ4ODVfUmPYPzbGkSkOEHOFZBTPvw1pXsONcg+x7vR8+
         SsdMzzpP56gFlPJUBRu4ZM+rGBjgls7iRIcaFAPl4SzYMse49TKUbiGvuuEu5TFg0nTk
         FU+gB4nrIrqPRVenyZ/NVqPDA/MFfnmDLC1a2NqvtN+D00XzzQ85sLbXziH6xE1JYUNS
         fBAAFWE7DUwnD5CTVyrekwHwIkUzuBA3p60IAMQjOOuKVGIY8674/+rPLizZl8auOM7q
         X/CnJp5A9TJavLGowM/xUNSvcURDSV1EhyU5lrQ+IMchmjLgF7iYbtxvvsSxd1Sbea/w
         lzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751527562; x=1752132362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw31JZeDXI7i8TQJKGuvOQzyl346KQ+6dpe3rHsz+zA=;
        b=fB/d2+j4CmLppYsJQV7lMLGXIiaiHVfS7dk3cMoikb3fbwUYGHK2hpw1N+Dn7LREGg
         mSOwDioU+DaM/qu4DlAB8Y9YupKBxz0jklt9mHChX0CPuMvbyoRQwYq8amoZhZU84Aeu
         OsR5dptJNyFfwwuxmp5Tinibuprh69dFoYNEMZzx4WvS/xBRmBhX1jGsZtpeD1dq/JqU
         eELMSwdQ5f1d175T37V3wR/V9Fa2mldLfCnRD4l4Je7Gbxm0yl/xG2enMPqXZ6p8UrWS
         UjpGy0inUPLut80XWX3WFBpHl9Ctmdrb5HoRACxlqT5Bmo2yB92KM5ERJmaeL5p4jsQs
         6Gsw==
X-Forwarded-Encrypted: i=1; AJvYcCUpnjBtwXIrfZP0Hc8cR2ZdKLLlZM6tNj9rHWFpjjCy59mriw72SFQBLyr5hd2VZnvuXbGbOvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPjx7m/a89SdLg+Oyxwy9jcWIvARtpnh7pmOWcnguJCYDcGPX
	YrLLUenEJfc0fVKCBQmiYoqM4M/MPcnThNFOXA1Or43SApbCWCbVET/yee+8KiNCfepZFNaiXFq
	3dtlvdRHPgKn0UZ/Npo3zmRGMdLxmBsxGZ8fAoLOG
X-Gm-Gg: ASbGncuercsV1aZIUiauAOKtTo7iEiubCIkEHH3ark42Oef9iw0CAD65CCHb9exX1Ud
	kHH4x5tNf92nib1j0d2yz6+YRNU9wgmIOjhe9s/xtto60IRfPQyKROyHlcLTXoX7mTsrDMX0b7r
	5ZKx+1JEs0jlmnj0ytNsa7HoP0iXIZ2sMh0B0C08zgE6M=
X-Google-Smtp-Source: AGHT+IEuqvyifZQ95ledQ2Zqyj/UqAGtkQ1/Nb7Y4igLtCG0N4oU8JoghRVIbDVmyl9BeH39prji81lzXXtS79xGsX8=
X-Received: by 2002:ac8:59c5:0:b0:4a5:98c2:34b9 with SMTP id
 d75a77b69052e-4a9769755ddmr112144941cf.34.1751527561709; Thu, 03 Jul 2025
 00:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702230210.3115355-1-kuni1840@gmail.com> <20250702230210.3115355-2-kuni1840@gmail.com>
In-Reply-To: <20250702230210.3115355-2-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Jul 2025 00:25:50 -0700
X-Gm-Features: Ac12FXxuiIeEj8NGLHqnte1YsvtJfcuk-JcAiLOb9c8WlycgEYNfIRvZKqjtekM
Message-ID: <CANn89iKCZdvMWHVaa6xBikE_5BO=-NvW+eEwpPmt8Gp7GpNX9w@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 01/15] ipv6: ndisc: Remove __in6_dev_get() in pndisc_{constructor,destructor}().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:02=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.co=
m> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> ipv6_dev_mc_{inc,dec}() has the same check.
>
> Let's remove __in6_dev_get() from pndisc_constructor() and
> pndisc_destructor().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

