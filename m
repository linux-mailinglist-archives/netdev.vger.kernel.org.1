Return-Path: <netdev+bounces-85099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C79189974B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 09:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1B01C2185F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCF5142E66;
	Fri,  5 Apr 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VySqWDoh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77DF12F36F
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303934; cv=none; b=Jtv467SIagHyaKb4Z3/Mqi8zIzz9xblzpQxtlFLS1gsQozcb63mMyGGwFbWk3J9Hv2mWll+Q17MuTQHR0ktBz/CkL0VTBbBuh2QWOkJJG3hRwi4+0LW4FXb+AZjSzlhDsuNmVnIdy1kh+q2uJpVwDEGuG12odRVK7AXyV1nYFIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303934; c=relaxed/simple;
	bh=8h0LF290BNLlM/vHBnVhqXt+ajZXc03kBGpM0QpctDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnXlwnPfvDEuKbw9LdHkGtFe1YreP8rqfhreMWGh7MqqWG5khutOKzqpsoUz72pMkI9NoK7kXdjQDIqOm1eMD+jXcJ4pFEwgovs73pPEeRTBQKnz2X6zfIOJ37B4XBSQLuO/DODigwrotBw5dHMG9vZo/47TLhPfVnGq5Ixiw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VySqWDoh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51a1c8d931so60484766b.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712303931; x=1712908731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h0LF290BNLlM/vHBnVhqXt+ajZXc03kBGpM0QpctDY=;
        b=VySqWDohj3XgRE01IV11uD1j1FjT4UE05mA3i5K04Rk4LGt/Oz7iv9u/QliXaVEHIU
         fc0gJLwvcmWugLIEjwvj+ceEaqCJjY1sxNQPLt6k7vhvXU2ZygKdYlsTbeafaV/bGf0z
         UKPY02CVBDJTIGuEkrqXAp2armLppc402vdb9gC2yld3v2WnTkcqWPLCOR8osbHevpF9
         XT6Cj750BuG6glLoty3+ZT3ona0nU4fyObsjosE8TobkVnNlx26oQuRh7ljmTON8Jm7X
         jmAlCjjg3JDTDmCfDtsSqvkD6dDEgZ0NCWbhPPpB79aP6WVtfVShoohuWf9JEg59MZtl
         yFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712303931; x=1712908731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h0LF290BNLlM/vHBnVhqXt+ajZXc03kBGpM0QpctDY=;
        b=J1B2/LTQ5PAQOvJHY1jn52jPE99ezAcrYKCYBuKdxbBW0ZAka+JL7NWaVf6SWWEZ8G
         JbmadLsXbedX05buN2rlMjdFZ+l8lq235frGbZ9I1MXf/auV4Jl19b9NMWh4CmUmhHbP
         pjLRl8zchoAa9ZiApG51yAoo6BoEWzius8U10A42wpKdVSFBLqTCY6bjQAKWQpXOLMPd
         MLz5M4iVPVF8wa+xkvNftV8vK5lf4DafBcqSi+JFXyAtivSLKmE+Oo1kFF4rYitQu2LY
         qfD8703ZDifp4Id/EfO3gq7ZoKWGpvPCPZE9GsSulge2U0eY6VRgLfaPugLLXFm1JciG
         l8lg==
X-Forwarded-Encrypted: i=1; AJvYcCWpBH6NF35taBEFoEcVx4Z/cb3fOuyY3js2PKf+wa34UBRtxsp93xx+jQaId9akZJqrK0/UavZElNBcW9w9+MNrki7PZXVZ
X-Gm-Message-State: AOJu0YyzMnE3pL/c6+u3T6DJgIQOX555quTZe9DVmMXyKpQXPCFwX2w3
	SHBMkbljHs/UBafZPWAseOnBIuFLqtYfuPoskdgJeMw+cRANiVIlHxrCY2e45eKDSuMHoCiQj7E
	RLuL2kj0luqnzuHZzE5Lec4hGUxE=
X-Google-Smtp-Source: AGHT+IFlgSGUCoSNpI6/sL6qIdfGOBZm6KSwh9vJ/RBw+3NQXkumQUgnJ0ic8zrXoo5FghWTYvxMogW31UHSZh8JY+s=
X-Received: by 2002:a17:907:7792:b0:a47:20c3:7c51 with SMTP id
 ky18-20020a170907779200b00a4720c37c51mr419089ejc.71.1712303931066; Fri, 05
 Apr 2024 00:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
 <20240405023914.54872-2-kerneljasonxing@gmail.com> <a0e75cbda948d9911425d8464ea47c92ab2eee3b.camel@redhat.com>
In-Reply-To: <a0e75cbda948d9911425d8464ea47c92ab2eee3b.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 15:58:14 +0800
Message-ID: <CAL+tcoBEkK-ncB6zdJrq7kkd3MEdyT7_ONOyB=0cVVR_oj-4yA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mptcp: don't need to check SKB_EXT_MPTCP in mptcp_reset_option()
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paolo,

On Fri, Apr 5, 2024 at 3:47=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Fri, 2024-04-05 at 10:39 +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Before this, what mptcp_reset_option() checks is totally the same as
> > mptcp_get_ext() does, so we could skip it.
>
> Note that the somewhat duplicate test is (a possibly not great)
> optimization to avoid jumping in the mptcp code (possible icache
> misses) for plain TCP sockets.
>
> I guess we want to maintain it.

Okay, I just read code and found the duplication but may I ask why it
has something to do with icache misses?

Thanks,
Jason

>
> Cheers,
>
> Paolo
>

