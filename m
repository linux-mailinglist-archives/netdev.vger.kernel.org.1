Return-Path: <netdev+bounces-227980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29948BBE80A
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BC2188D4FA
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A712D8399;
	Mon,  6 Oct 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOJkXcpc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA742D8370
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764969; cv=none; b=GwKCWWEd0iCqyS0LIHrR5J/Rko8fwjBHXgf4Y/pLuQoiUW1B1TfiIdCoPVzFfSpCpclw+Fq7zkRaPjsrS694skPjiPtLZkco9Dy1V+C4WFPrwljsl8xuvUeSxYOrX8eEPaEi92cV9fCjpbPlDHs5/xPYlF43OFpCAbt6vxZTGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764969; c=relaxed/simple;
	bh=p2fSqWZIPh8dmKXPDPJRAzI75Zc5SZVu3PCdpm2uXj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZU+Zaa0VOzMNNrRedlVh8zOg//foFb0h2JVmxHwQPbtea2IAw6lHVq+zkb5kscsc9A5VrfK4qiGIf/e7Nqaa878UucLdqr07qepf5LMu8GsY3eweatxw7Iq18+FZg68tx5svLU8fJurA+ghjwXvrLlvcDkxGky8g5QnWKXctis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XOJkXcpc; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4de66881569so888271cf.0
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759764966; x=1760369766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2fSqWZIPh8dmKXPDPJRAzI75Zc5SZVu3PCdpm2uXj8=;
        b=XOJkXcpcekPgpDlUKQtXfIkb0SnxWEtUafcu2NB8NhiC+9smRiXxEcXMPkuJ6HmS42
         z0uIdCR6UPoLK5rfxzqguB2WTNmdtWxN/9TcjlUqcabs7YmklQ2JgYJkFIcMqjRpgESJ
         Jp7I3+wu7Ro3h/yW1mwlwZAUi5SFC7Y0LKS0nwYy7+ij/3CGERzdnubTGOCPDWEksM6n
         Rh8hcacy/uTWyZwAuVVWEWh2ry2RTY8a5wZm4B2CSOwsqRz4v5KZI8Qy/A/FzlKyIglr
         biSkAw0mELOguW7C1mf95NnB3wxaps8Gb+jjMwk7drhmEStlCWLmfWRTKoIDp0Jhg55d
         HxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759764966; x=1760369766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2fSqWZIPh8dmKXPDPJRAzI75Zc5SZVu3PCdpm2uXj8=;
        b=REKe92xBvZW+5UO/y9hIlvF5jdN0XzP9ZITGomjSQvfSWy3DFrlytAnh50hjqieTny
         YWaAXW/tgahSbYKkkoDD/+ToY/at8aahGyrdhMlNuP2fZxN1sR92rgJ3cXPrVwNgL7qh
         C0hGnlD5gypRz8xFgcYKPRno2fRZ/W2QFsWblaU1GXFwKx1Hg003geW69LXo9bjXRs3L
         mPhtm4VAalFgRn+oUWL5+8QQVypIvac9ad9afX6HVUtFamyn6cdLSdZ1kNsRh1eTn4X9
         gkQEb9rMxhY7xNfOepwrt+SlDvx0o2BK++/8Nvn7AlUaYi0rv0dYPCUV61zdwZyKbHFu
         04ow==
X-Forwarded-Encrypted: i=1; AJvYcCXO5SBgr+xpYFLSr/HbAfddmF8f7pyl0tVPWrv90FG7AKgHqhdZXAjW+BZY436OW1TBt1TLajU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEKx3RtQFLYdEDhPSd6iLXSMaRIpAYd5bmw329jvpCJwpBC63
	/JlLd7JHX7neVlzzODioCGRqqCrPIJZtAZC7+BuBwntkNISJ/JnGMC3fCORrsiF7POU7sOw/qsa
	ihwKjsqMzUdCyjheAoMcQ550kTEXiP3WXyqk5b9NM
X-Gm-Gg: ASbGncunCF8mRnT82xdHfTs8ZqOSbav2hyvA/C+kOmk/ip+eyfNVT17Rat6Bx8BDGQ2
	6CgjEfZU/I/rllIrCd+S2ipi8b1u3RDn706+tcdxCoWzKaP+eoz2wSw8kl3GHlE9hA67CXW0dcI
	RCMhBVrkfhh1oonxSFClCe+5ReDtGCVwk9/dsjDxrvBRkL3AyBnXfJzaEdPO5A3/EBhXlxLEzeH
	yh/CFwrl2FUQcVr5G56kmXG1jchJmNrsRC78xLki2qivwEBlBhYmwxXVgk1XJpwCMvWKy0=
X-Google-Smtp-Source: AGHT+IE5f2CLljAspvr2c4oA1iPFW0XY6LvqTaybHdyjx/IKtiyHqkTHW+Y97JPq4qm0N3pIU+V1WaDly6WhI+e04sY=
X-Received: by 2002:a05:622a:1a93:b0:4b7:94d7:8b4c with SMTP id
 d75a77b69052e-4e5891fb0f5mr6886851cf.0.1759764965714; Mon, 06 Oct 2025
 08:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003184119.2526655-1-edumazet@google.com>
In-Reply-To: <20251003184119.2526655-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 6 Oct 2025 11:35:47 -0400
X-Gm-Features: AS18NWAdY0CZ27avC2kZLn6ZWgFaOOp03nXNCoGvsBkA3NNBPFaDS0jw92KxGHI
Message-ID: <CADVnQyng=yAF8emm4BQzqMgFkY-pJT-YGSeN6hMr2BaLLnXPaA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: take care of zero tp->window_clamp in tcp_set_rcvlowat()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 2:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Some applications (like selftests/net/tcp_mmap.c) call SO_RCVLOWAT
> on their listener, before accept().
>
> This has an unfortunate effect on wscale selection in
> tcp_select_initial_window() during 3WHS.
>
> For instance, tcp_mmap was negotiating wscale 4, regardless
> of tcp_rmem[2] and sysctl_rmem_max.
>
> Do not change tp->window_clamp if it is zero
> or bigger than our computed value.
>
> Zero value is special, it allows tcp_select_initial_window()
> to enable autotuning.
>
> Note that SO_RCVLOWAT use on listener is probably not wise,
> because tp->scaling_ratio has a default value, possibly wrong.
>
> Fixes: d1361840f8c5 ("tcp: fix SO_RCVLOWAT and RCVBUF autotuning")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

