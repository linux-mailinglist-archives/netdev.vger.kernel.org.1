Return-Path: <netdev+bounces-200282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B45AE4589
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E47C17ABE1
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B771B246793;
	Mon, 23 Jun 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsPZFyYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FBF2581;
	Mon, 23 Jun 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686638; cv=none; b=UOMqfh0L+Dp/8SQYeJuWWqjYR6RsXYGgRtlvaOClmoPG5yRgT9S/WJLNeVeFdxjd6sqhNJTDUnQkxsjoi5Ei4SVWEh3/Wsv1Gmk4Fve31PvkHR2NvDSfvC76zMsfATrHPAuk24WJfNTepeQhYYVEw0Wnc199Idm7A/nmnirW844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686638; c=relaxed/simple;
	bh=vFXOM76AVfvtWRF+BsGVPsvQ7eR0S6jfR2Idd/oFAMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+0lTeD95ROaxFh8jqSLJutdLaeQ1PYPdPnvekjoBfvAT3MxGNs+2cxFOfnD2AZsf7iXpyJdlonbtUPZV52GY9dGwFHlq/D7heAzrkcGkdl27LyLkjgfDLMQIHb0rLN25Xsf4/2zBl/eMqmj806JBJHmFxZQqqpTQBBMlgryNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsPZFyYg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-312116d75a6so3269298a91.3;
        Mon, 23 Jun 2025 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750686636; x=1751291436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsFS8jl30UL5UpuTdcmWwJlZ4p5tlapaAOwbw1RqzeM=;
        b=HsPZFyYg8+RaUR2PAC4dP4yB7FaSbNSpYo4FaElsIHkIIpS4+pNLSiX1r7FbpXpoe9
         zY2+teSKNNuhAAX8Ji66ZZ3An+Rn8Kt57ejgJMuhFC/HvX1SkZa4yjM5fnh2tPqrickZ
         8cBCih54Cq0+UVkrTpkxfa4uK9ACOF7dqOZGCYS8I/ucXUZb+IL5gLFcT6SUspRTrMhH
         3ljtZ1/SnUJN8k81xo4XSkLb0g3kFEKuqXJxASYXImFi8CSmm1WDFvnRqDX9oyWA2d5K
         gVXV0cwX4IuWxF4Uzli1C9WKiSFGQtyLIMhiH/++v3ZDCHxU1ER+wAuMnN0lReO/h7Zi
         tdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750686636; x=1751291436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsFS8jl30UL5UpuTdcmWwJlZ4p5tlapaAOwbw1RqzeM=;
        b=rXo0XnYQNBP7eyuKYap4cSgnQA7eNWg6tnkJKwpdutZNeGch/A5azuh6wnMYa7IoyE
         eutfCiynP9EAWSNPEo0X0EQgCJI8ZyY4AZ7cWgqw4EjySY0ucyzGkO8HvTXXag0+jkqM
         Eoi8xFiMD8+TBiwWhfAcAh7tm3GGrHpZMeqFBhmI+l8RYeLFNHTv4fFi6lsp3vzUeVto
         PGgt8nTP9sroPkrUClriCx7fj/7MTt/I4vLOZuBzZopjr5IfSZuDm/uK6Ofo7cv+JjQK
         owmsuhk8JyPvSPxWHejniC9AzyCoD7CfXtBN/8NslhHWtO3MZRw27kfsAcwpegcSV6/u
         sUlw==
X-Forwarded-Encrypted: i=1; AJvYcCUZtbzRge4+gFPH3Tw5zISJQwPK67BuMHVFXkb5HPekAJbAQMokV8kndn86mMB3yIXSygfIqd1n@vger.kernel.org, AJvYcCUyrYj6+Jp8G5MPFayGAB8gcpTednRcfpqCBIUP4sEMil7UPEu/ziArGh/jObjYUkm7sudptsr6rw0sFB+7RD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqrKNhhFrvBwXP7Cks8sr/Gh8PWO6I5XPbkWXAZ9GU6qvh4YdF
	l0pjxeMcB2gWnicFrz2/PsTjLjNehJ8Xq15XCKIC1SheNeRsBV4SofaFWIqcwvmT7fyD8uTk/H0
	oxX1JLebDp7tmIh08Efh9JgT5ZVYBbF5JhQvENZg=
X-Gm-Gg: ASbGncspwOA8f7wM5NWQ/X3yHUScdXxlpnvmDnkPg+xHebpjAQmZ+Wl+XSuCOgmCqY/
	A0M7mWsDWHz+bywh9U0hldnX5HlbbKmLJmshZ58ZEQ+adHkdF1j3s8+3vER9MK0OHj0yDd6lceD
	IOW3t8lZDIBGiaB8lSFHwIcmmK4OIioYvHSbquPQqXUQ==
X-Google-Smtp-Source: AGHT+IE8qfVdKu2S7YMcclZns75iU4id5U88uL7T5mf3qJK15gP6xTEFEPSYsKxrnnaD+3dVopa7Lcd70P6OCCrI0h4=
X-Received: by 2002:a17:90b:3c47:b0:311:b3e7:fb38 with SMTP id
 98e67ed59e1d1-3159d8c80e3mr16930460a91.19.1750686635521; Mon, 23 Jun 2025
 06:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620175748.185061-1-luiz.dentz@gmail.com> <20250621075110.686bbf0f@kernel.org>
In-Reply-To: <20250621075110.686bbf0f@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Jun 2025 09:50:20 -0400
X-Gm-Features: AX0GCFtgGGTPX-FaiJaST-6T1HD2F3Clilq1AZIhUvr5fuDoBa3u_NOH7hZXs7Y
Message-ID: <CABBYNZLQWH5jxKeLAsVyNqBnWNwcGU+Y1hk3XZkBv5chhZ3wxw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-06-20
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 21, 2025 at 10:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 20 Jun 2025 13:57:47 -0400 Luiz Augusto von Dentz wrote:
> > bluetooth pull request for net:
> >
> >  - L2CAP: Fix L2CAP MTU negotiation
> >  - hci_core: Fix use-after-free in vhci_flush()
> >  - btintel_pcie: Fix potential race condition in firmware download
> >  - hci_qca: fix unable to load the BT driver
>
> commit 135c1294c585cf8
>
>         alloc_size =3D sizeof(*hdev);
>         if (sizeof_priv) {
>                 /* Fixme: May need ALIGN-ment? */
>                 alloc_size +=3D sizeof_priv;
>         }
>
>         hdev =3D kzalloc(alloc_size, GFP_KERNEL);
>         if (!hdev)
>                 return NULL;
>
> +       if (init_srcu_struct(&hdev->srcu))
> +               return NULL;
> +
>         hdev->pkt_type  =3D (HCI_DM1 | HCI_DH1 | HCI_HV1);
>
> Isn't this leaking hdev?

Yeah looks like we shall free the hdev before returning NULL, will fix
that and resend.



--=20
Luiz Augusto von Dentz

