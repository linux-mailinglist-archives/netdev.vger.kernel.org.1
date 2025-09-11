Return-Path: <netdev+bounces-222045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7484EB52E2B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCFC3AE9AB
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24F30E832;
	Thu, 11 Sep 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zd/CHr04"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639D23BD02
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585911; cv=none; b=PnIS9Q5otRdS2brhXgbrDGFwnpFP9ggBpyBm2fGMvLaGMYZ+VOgtJgsZq8Eis1Te0hXPw/5cdqHnuT/4g+W+g46uMsRcGPPpYzPtRY9PWRBIdyf+D/ViE4HFo5b4LgxoBjzZDUluckcXRBEviMH5v4jYSzDVkuax7E2u4LcFedA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585911; c=relaxed/simple;
	bh=b8kOCoUNiju/FWlmhh2Efh6jL8KK7YKRK8N0sSL+ihY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQJ9pW1BFLIOyW1irlQK4LnUGUnGrn7FTgSI+KKZ73Ae0CULbKLLtewTEprwheYH/k7sVQxCQjXhP4KR7UHeFRLwkIrm5OS3Y0IkdIsFgbzEWsQNuj1b1svnjKmuVz3rhA4i2SPQ7JenOmVei3NhrP5q98yTZSqRijtKLYjh1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zd/CHr04; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b3d3f6360cso5962681cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757585909; x=1758190709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8kOCoUNiju/FWlmhh2Efh6jL8KK7YKRK8N0sSL+ihY=;
        b=Zd/CHr04NiV8NK/uaWUmoo6yfow/Cm0ZQqeugNK/LjKfDLdzQSmpFAYY9SDXNibLYe
         IHyaFVfLCp0VKbQZ+lsvYirwfOp6F5tBBVsAsjb/3lrtPf9W2Vc++e19PWYXIrS7v3eP
         psh6KU0eZsU5vQ698A5+vN9NAkA6YdzJwTqvolvRWF8TI/3OC1lbSHrQGkqvrLvRpRIR
         5LrWSTomqCnvN8BOPQn9yW1VYHfGRf2+uJs++Kg/o73obEGTwlg8keD793Z8OG11Ot8w
         jjkqgYFTCmoQwkBoUXGSi9ffUqopG843/7ZrdJXLqVup9U8qQlF8mZXUdslGaeR+H5FT
         p+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757585909; x=1758190709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8kOCoUNiju/FWlmhh2Efh6jL8KK7YKRK8N0sSL+ihY=;
        b=Bt26V35RfOiJOB7Izq3g2JAMOh/jCtjtKZZD8tv7O0AxXg3PwibLflpHJpVimvWLsM
         ZDLEc2vkdPxvzdHjosMA/MmbUVkGNJJuLC6AIuSl2XhGr3dmSta1N+erwtCbDwslARoE
         FvZqnZycZEwgvLubd7JyfFD5qD4YwjRodN3ItNbB546N5BZIL7CjW6jxBaVj4WhkRHGv
         Iw8mDsJGPyH8SIe2A/AykaBV/c3WnQRkcB311QcR4a+JMeORWxCBpIwPmQPf5uCSEoa7
         N1tSmDj8Xa6mqjtL+eIqMrK9ShxrvhIrCUQTQ5UkK0Fo5WhH40H0CTnfnJypK4POjOkR
         wh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUd0+jRkzbQ8DvRKeTpwfGBHoCGgOCgQxTwO9KMQjIY29Q2QG03KQgUjAT98bsX8punzUhhDhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDO49lQK7dcYxSQ8JKRizSk/858PA8o4ChUDELJDFlSigV/pZO
	qQm0DVqIePvMV3kLaMYMPwbXnZFFs7hQ5XwMKyb/OSRDck/L9lxdzzvYCdzcqQT2wI8dpWV9Fci
	eVRqAQahiff0H3p8sPl24KM1+XaYEuG1EQgPIFgYN
X-Gm-Gg: ASbGnctm5yeA9DbZKgoRAyT4rAEZdkeUGEmq0AwoUUeva3tLK57nl6QJxJQY7lBqg2n
	6v7oy9g7AZKbYXIwiFMPfz4bv9SRWX6mmK3Aa33nWqhLwgK8LHURGEeUd2cpmpzVbdqyxqitBj/
	tZmuvc1TnaNfagq+IU3Pa/oR7hJnyRluLM0VVwDOsMbS3UHD0SX7avvsT9Rin7dXMGhbPV6tjRg
	GDWqLXSw/QwU85pwMFWJoHKFmkTdRZvm/k=
X-Google-Smtp-Source: AGHT+IEqQMhkVh/lYGalDwkpiYZ6f35/G1vtOQ2l6IDxuZ/NsAD8i3LfdKsGnA8/soxwk9WffOfYsUldgmrLaRipwNs=
X-Received: by 2002:ac8:5e49:0:b0:4b5:e822:36e0 with SMTP id
 d75a77b69052e-4b5f839047fmr204347991cf.12.1757585908196; Thu, 11 Sep 2025
 03:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:18:17 -0700
X-Gm-Features: Ac12FXyMpCAA7q3vBOdalZhfapQxJhqhSZEIpQwkhEKdjvw-ONLg3xPKC40oLaw
Message-ID: <CANn89i+2=bNkkf89RysrYxb9DW0Vw9+jSg7FotqtaHZa7tmerA@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 08/14] tcp: accecn: AccECN needs to know
 delivered bytes
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> AccECN byte counter estimation requires delivered bytes
> which can be calculated while processing SACK blocks and
> cumulative ACK. The delivered bytes will be used to estimate
> the byte counters between AccECN option (on ACKs w/o the
> option).
>
> Accurate ECN does not depend on SACK to function; however,
> the calculation would be more accurate if SACK were there.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

