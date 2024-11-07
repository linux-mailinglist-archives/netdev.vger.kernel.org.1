Return-Path: <netdev+bounces-142732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBB79C023F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236A61F22783
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185871EF934;
	Thu,  7 Nov 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0QyFQdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4DC1EF0A4
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975011; cv=none; b=RxB2Hu5iEfZlh51mJMxsDG4UNYQgU6henkUqpfpZ6GnHoSRaIL6Xn0P3zASJLsSHswAN9QZhfY62h6n9xhxm9J1SHPfxUTCue8Y8Lk/nCXnRTgqgmYSfbNL5CGEtjfHoAkbgUdluOIA7pNOQG/6pm8NTgBdt2+82YgnO/oEkiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975011; c=relaxed/simple;
	bh=7ZtzEE3cX7LI8cG8C0aJCAqfGdnEG0uEG1GW0zfufec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzZAQxl5T0rgo0eXiw46DaeUkSQr6Gox8i67OoSWoeICKlnPJY+RHwaujO6qbjTr1ZtKoJdNB5toYePLmsCEMJ6AxeHSJME9JXWNUgcQzuGWqfaajjtggxTM1rcwWhtpts8H0BERzWqaBz2DkVJPHHMzxkLFenp8/ijeTnka+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e0QyFQdj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so1425068a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 02:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730975008; x=1731579808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZtzEE3cX7LI8cG8C0aJCAqfGdnEG0uEG1GW0zfufec=;
        b=e0QyFQdjAletkQTWsUI3DCaQig4SKm//Wy4tUdSgyUPAH+fjI7SijN4LlD5SAX/Ze/
         9cEhMK8tyK8XKuAH/2WE3deE3nLphlmQY2uh0x1oNthygoPAd5PCL/UIiUy1k/kISE6n
         YO/98conYEjhVw17WmTIgp59mYURek0e6Ru4SrXK1doKgkwKHjT0YTMlbA3LfNhl6RiV
         kHxpIYqM/2r/T7Eb7UYGJ/NrP4nl9oTMh05xLFfV2vuiwanMgQfiFTpI5oTY2ueHQqmT
         8wuFwzD2VXXX1suZU0PbvepPB5hulnti0D9YYUxDo/segarbZRh/bEF8KS4eaZaW1TQe
         MCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975008; x=1731579808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZtzEE3cX7LI8cG8C0aJCAqfGdnEG0uEG1GW0zfufec=;
        b=fqsBsedt84W71PIGrnUaGk0G1vAnLRZzpkB0kuzvTLx8EpBN6b5wzBCTRRLHcISXmZ
         +x94g2Em3NjKDJCIrcDa1ttyUxxOceWey7u5IMlf6qfUHAmFwLJErGUmhQD6ulPQFGbg
         qsRx9fT8vTrCai3LLor0e7yCUHdhEm8KaTMKLrcdyT4mhOJIGKlBthNhmDS4Ygph9ii5
         /li8C7gUdIsvyC7phFKV1EYVkjj96KlrAxJDsnc09kSgyxas/UUrlAa5i2xASStkyFWC
         A/WtwqX78IaGP7eZSjov8Q0YwGZusD7YyLKDOhJRTbSdQKbF3XgFQGDxNCybU2mrHlJX
         6zuw==
X-Gm-Message-State: AOJu0Yw8AvPG6MbmJfQDZGnbbKZ1bS7CrrrVuSKnWXR7ZhV/TItIQhTv
	XS+0WHjfdOIBHy04rm+Kb9efizWlnbzoQjWOTygmGo3lZKgiWdGOTCv9Sdyn6yJIxwNn4O7oOMz
	ufBT1TftvA1A1jfnYb++HgahIR2n2t7BxGezS
X-Google-Smtp-Source: AGHT+IEjPlnFJBkIXr+gYq+0XbuErwY+eFjj9KQZR7oaUbTB4s1CmRvF6yWvRP/fnciWUVqcWyd4dNYHdLh/nvchRtE=
X-Received: by 2002:a05:6402:348e:b0:5ce:de0f:e59b with SMTP id
 4fb4d7f45d1cf-5cf06732c58mr679270a12.1.1730975004033; Thu, 07 Nov 2024
 02:23:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-5-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-5-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 11:23:12 +0100
Message-ID: <CANn89iKvpMANAsAtZzCa=udur+Q+5Ae6z8YrcjybiB+W68Z+Mw@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 04/13] tcp: extend TCP flags to allow AE
 bit/ACE field
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> With AccECN, there's one additional TCP flag to be used (AE)
> and ACE field that overloads the definition of AE, CWR, and
> ECE flags. As tcp_flags was previously only 1 byte, the
> byte-order stuff needs to be added to it's handling.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

