Return-Path: <netdev+bounces-164602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D86A2E75D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB23188B5E2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3661DF756;
	Mon, 10 Feb 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2htDOrI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE391C5D56
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739178502; cv=none; b=bOMZISGEo0tHqwXkyqd3g0Yt9uf8xgD1hdAsRxZmQln2SvI2C/m9Zun010h6zvsqSkkxuZFzl0dwps+3KF64TjChjKwpNm6vIzwsIHs2BRgF0V1YL7JkzrixJ9SEejg/YEHDk0scbueg++0SqPcdFi11hhe3n3m/Rx9KBe2azBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739178502; c=relaxed/simple;
	bh=rTzP73EAtAPD+gT8uNsrDQK06aQHVpn2UBYpmalWoQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbLaCz9uOEm05AW9rH+nDAsh4DW2r4/OlXnvYesosrkfeDQ9z1uCUMb9NVojibrIkggvTbnjgCGhAxHuzxouBppQCdvW9ks1lqK20B7a/e1XW19hKj7HRRLEX0/WB87dhuqSMRSFsslHv4TmL/xNhlMsDr5FNwBBzdhkZNornWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2htDOrI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so2843065a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739178499; x=1739783299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgx0aq4YsGeIiVyqY+VQhA53zvtStll/9h6lpKXslqA=;
        b=R2htDOrId4ChNgS+XFLx5J4EXuDCIRgGXSasffFJUNEokHlGtHsibf78Do6KaRcQJQ
         7GIfZNM2qYXrQJgY6YWkQfFNJK3zWDDHAWgxKv76BvScDDNZBVX2g5iuCimYpYOSXAa8
         esra+T1Tr58r0a+VbeVHt5eiO4wdRzoW+YJ1r/0i0O+hKkVoOV14DF6DO7sgHeq2FEEV
         nlLfSy6MAwynFFTd3ZZZER/0cDbNm5n7/+yYmyy+a2hx3JGTXzkJBLdrG1HEMepwad1Q
         +LVUG0tNahM2MnS6mCb5Hc+NUAT4YfAaZJ65F/zmwGtVny+ZHZB90p4oJ4AZM6M/4Olz
         0e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739178499; x=1739783299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgx0aq4YsGeIiVyqY+VQhA53zvtStll/9h6lpKXslqA=;
        b=BfpyV59n99TUdDCKt1mZENaTFyDfF7H9jiIFaNFj9DNwapQjWtCYS/R9ZSv707qayO
         iFdMiuXdUbJaxQ/TvQGF3LvV5x9lBcq4EPbSpajmxvrgzxotVOvGzzptXH/MxaXlhjlO
         uYqhWQg7FtTVkqfFDFORgoVli9+DmdgTdHKqLCuf/OdcIMfv7gb4LYGSDK3+G/+dYx5g
         x6DegBXkA01W2o5pggC5PSI4XS5DS+maMWfUbPK2aVcdDwWDsnAzBcddmDV0XHfPAb5f
         +j9yXew01L7H2o3lblCZispBXPRDNuaB/Yv5wkiWdO9hr2vg/DVn+ef7Hl1G36PGnV2J
         vtsw==
X-Forwarded-Encrypted: i=1; AJvYcCWqeVYK89cZ8/yShgu/XzzNQNgtabmWqafc17rCk0NQ/6HkrDKNL9l3f4p53TKKt+QH3lDS5og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcDO0FymT58bRzWI61aeTlxKwG6a7OX/jCcpF2N9Hkzx7osFl
	m4RqFL3KpwxrUuYwhTpcUt5zoHC+dmrvC9qhoxYIID3JghYaADLSI3EkAVP/qkdnkwJqH32xysV
	3/rkB3T+yL7IZ6xaVqPI4b42t2xSLocr8/DyeuWiNk4DyuXY0AYlm
X-Gm-Gg: ASbGncvAiYzu2eC4r2PlGIRE8AeWUh69hcGenAxtEp1LN9zGhqqvp8cID6GixpVNVNv
	vqs1iRjIn8rR12fyrIjccDN7JA+Zx7u4lN+t2s5u5rBaFx4on6YXw+hWQ7em979T/Vk/daNJZ
X-Google-Smtp-Source: AGHT+IGclx9hMgngPXK31ShR3FnOU09EEySqHAwOeG45zag+1x1XYM0RYZEGF7JSnAi/XD0aSHFByagZyiIBdRJGb7M=
X-Received: by 2002:a05:6402:3883:b0:5dc:7425:ea9b with SMTP id
 4fb4d7f45d1cf-5de45072303mr11405131a12.25.1739178497563; Mon, 10 Feb 2025
 01:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com> <20250210082805.465241-4-edumazet@google.com>
 <31325da6-d74b-4c9c-ada8-67100bd50310@intel.com>
In-Reply-To: <31325da6-d74b-4c9c-ada8-67100bd50310@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 10:08:06 +0100
X-Gm-Features: AWEUYZns84NSX6AfaV-J9oT7KH35WjzF879_2IGR1LxcCmXo3gMY9BAe2pEsWRo
Message-ID: <CANn89i+WfwMQnYRRe8greWXTYR8CpUGz-pZF-YW-1B_fM7oXrg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 9:41=E2=80=AFAM Mateusz Polchlopek
<mateusz.polchlopek@intel.com> wrote:
>
>
>
> On 2/10/2025 9:28 AM, Eric Dumazet wrote:
> > Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
> > to be exported unless CONFIG_IPV6=3Dm
> >
> > tcp_hashinfo is no longer used from any module anyway.
>
> You also removed EXPORT for tcp_openreq_init_rwin function. Quick
> grep shows that it is also not used anymore by any module, so probably
> you forgot to add this info to commit message? Do you think it is worth
> to add?

I forgot to add this in the commit message.

Not sure if this worth a v2, because IPv6 no longer calls this
function after this old commit

commit 1fb6f159fd21c640a28eb65fbd62ce8c9f6a777e
Author: Octavian Purdila <octavian.purdila@intel.com>
Date:   Wed Jun 25 17:10:02 2014 +0300

    tcp: add tcp_conn_request


>
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
>
> [...]
>
> > @@ -457,7 +457,6 @@ void tcp_openreq_init_rwin(struct request_sock *req=
,
> >               rcv_wnd);
> >       ireq->rcv_wscale =3D rcv_wscale;
> >   }
> > -EXPORT_SYMBOL(tcp_openreq_init_rwin);
>
> Exactly here

Yes, thanks.

