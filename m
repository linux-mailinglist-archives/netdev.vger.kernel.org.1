Return-Path: <netdev+bounces-134889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4299B829
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 05:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C65282B39
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 03:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1547B335D3;
	Sun, 13 Oct 2024 03:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjppBfC6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B001862
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728791271; cv=none; b=OxZK5wYtyNpdCpeVAkiSe1p4CN/tHIRNqGPrkhGvF/ZUNdBcxUnxPZVxBbrn8P1I5QSnp2GiAlIUhq1nbDGrknTwx0vNtqsZcGY9/iruDgJsIYctGrcTyTRhkxszkxKiN5Gm7+qoiFzfUD75nCZEs0ILs0pLdyS1lKFxIGcjZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728791271; c=relaxed/simple;
	bh=plED+xCHktvbXRmKGbrS99mMgO2z4EA4tAZ8g2RAGB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V56Soq5ad+yjavD+sNTbnHOxtqspkf3BWjrNJ+LwJOfcvJo3cLvGwrVaRWquHprhV7ZcMhgzw3rPsWCLl+kHsTJrx7lOaahxcCKYLT6xaM8KdsfOliWIQfz82fYh6HyzTWFbu+fzVlSs/d8YPT3l3LnIW5mlwD84c4RcNIgAPNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjppBfC6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4603d3e0547so222551cf.0
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 20:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728791268; x=1729396068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n0KvzvB9CapIDrVdKAoECRFJHz95I4tKIuKCEKYze8=;
        b=WjppBfC6UdqPV1ZhB003ofssXjkvImncJJ2sVxBq6TNfDuNJDkF5GZn2B56o4d8oxs
         +4DiIuj6oeT2pUqv5LiH/PC+vvCZAHzF8T38cICLKXBza4Ey+pa9PQD9Bg8CGzBcbxNe
         sCJ7N9Ww8Ufru8oi9fET4/gwPbjocqEpMN1XbZnYcLchaGHtrk1VnOlvRUMt5Ckvrqhb
         Wzy34YDbmfUgWHnUtEf7aunaGXadVtkbechm4FriZB77EM6yjjkQKL0DlgIuQjxFE7TM
         oRds5VLWdySYsGl3uP5F7B2kEOc52rK+MT0mnLYT9ykvWixpI9/W6TmT4K1yIozuTLh+
         iaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728791268; x=1729396068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7n0KvzvB9CapIDrVdKAoECRFJHz95I4tKIuKCEKYze8=;
        b=n21730DPrjFflb6fP1ryr1fbqTpHJ37Dcc5PRWQ2QtfIpMUdHtzv3iCoHQGO/fsDTD
         3Ekak2/0wqlE9FQbTbNiDj95SaTqGM1KTFm6gByqxvKabrHYUE12Os2bjb1I/KNA+3Ua
         EcPHlslGMNyISO/djFDZCAFb1b7gylLq2vyPbQODsJN7FtZuV0Qb83SV2wTb2SGQcBPo
         Tg0b1z77myGsOHISB/fA1XeuWFcn9SAefDN6VQ55zYdrumu8EYdx6KDJL9HWu7eVbtLb
         HGoEn/l2NsEtzHyHh0Yk0EWOqzPz7BAI6ZgBcqqqppM3czO3T0B8sX1CbpM/ht3eKIhF
         mNgg==
X-Gm-Message-State: AOJu0Yx4ftMnhTJb+IifAhaNP8oGTCpyeZDwO+U4ysf8jPKQubfOImi+
	IAp2VPejcemmatREXzoVMNRJv00yE2eIp6pGuNS2k5aME6cJze8c9VBWPrv9KM8S7Djc5VXPgL1
	RUNk4KNBaRNgrpSNkVYTuji+8EAMI6cCvP+XQ
X-Google-Smtp-Source: AGHT+IEegumLi7zIKhRDNuipCvvZooP2Kk/YLm97Km4CLU4GcPGmRQrtliNANV8X1S8PU/eajdg6/KIpUAF/SzQSHHI=
X-Received: by 2002:a05:622a:5d13:b0:45f:997:4e5a with SMTP id
 d75a77b69052e-46059c4465bmr1985201cf.11.1728791267980; Sat, 12 Oct 2024
 20:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009171252.2328284-1-sdf@fomichev.me> <20241009171252.2328284-6-sdf@fomichev.me>
In-Reply-To: <20241009171252.2328284-6-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 12 Oct 2024 20:47:32 -0700
Message-ID: <CAHS8izNuNwSjWTkHo545HT8r2JEp_idY34NGPEEyiTj8XmzW3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/12] selftests: ncdevmem: Remove default arguments
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> To make it clear what's required and what's not. Also, some of the
> values don't seem like a good defaults; for example eth1.
>
> Move the invocation comment to the top, add missing -s to the client
> and cleanup the client invocation a bit to make more readable.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 49 ++++++++++++++------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 2ee7b4eb9f71..99ae3a595787 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -1,4 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/*
> + * tcpdevmem netcat. Works similarly to netcat but does device memory TC=
P
> + * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
> + *
> + * Usage:
> + *
> + *     On server:
> + *     ncdevmem -s <server IP> [-c <client IP>] -f eth1 -l -p 5201
> + *
> + *     On client:
> + *     echo -n "hello\nworld" | nc -s <server IP> 5201 -p 5201
> + *

No need to remove the documentation telling users how to do validation
when moving these docs. Please have a secondary section that retains
the docs for the validation:

* Usage:

(what you have)

* Test data validation:

(What I had before)

With that:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

