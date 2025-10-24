Return-Path: <netdev+bounces-232602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB720C06F81
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1C8D4F439D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B55326D53;
	Fri, 24 Oct 2025 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIqDjPxl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0987326D68
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319670; cv=none; b=DNpjINuKg7fgpp70dRRgycJ57XQM5Jq1qGwRJ1ouzZynvit6nTDHU77n3BCLvc2rtpphuiKjt1iZ1fjZgOlw1lD9A/S0X9KqRLYPAztPKNcau9osG3fYdKnVtqZtHZY/v9vRaCIeYM3m7d3buQ458ineKKtMC4GOJ+YNFmEgoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319670; c=relaxed/simple;
	bh=mZUwLoRhzQZCFpDyDkkPff1q32CTDK5uaQBs2fNy31U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tgp+hQ3YXPfGjjavDu5YwP4Cs6THUT1vKs43/YnEFsotFbjuQsESee/UnqciesHw+dMKh3S06caJ5h0FhZu6agBS53t4q/afL6fFTP+7w2uz7vwoCxxrC5p8aPBDFyaebTuF59k23EKOIptLqv+Vihr2S1Rw+SG//UI/wvfcSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIqDjPxl; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5db2dc4e42dso2124262137.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761319668; x=1761924468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZUwLoRhzQZCFpDyDkkPff1q32CTDK5uaQBs2fNy31U=;
        b=nIqDjPxlztsCVIzTHKFW7I1d+Lu1FIuTO9PwrAOlL1FEn3kBilNjzNBf09utzFHPJl
         BczbPz+YhczmefI52dYWmOASq+yB8bXjPPtWJIrhqtXJOc02iyVEwxLQOtWKPobsBPYG
         ClbOj6shMp8wcY9nf4yHp5h2agUsxU0Remq2PI0yzYq0mBZujVybdIExJAm7h9GfzAjk
         I85XHPYue8U2AJ9hlBISZwSi8WH8XJuedfDBjpLzllisXcFnkHD35uGQC3OtrPAfnfsl
         J/72yiZaUt6bLLvMPFkn/RpM6ZxLBgOD7iMiPIAAPXBSWhB5fv4sxCvw7A79TnDLgFb9
         DdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319668; x=1761924468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZUwLoRhzQZCFpDyDkkPff1q32CTDK5uaQBs2fNy31U=;
        b=DboXWytksYPR6vGHwn/lLvuG5RUBq3xFlLfdK0v9TsKmk27gKpa26K7TULHumTuLri
         V2q1Twhah8e+BDTUaskra1Qe5IZaW8rgIg4sX1OSGrimtyBCAzYYDFvPtdMhYyDErKdN
         bsRn5Y8C9fJIJyExq3d1l0RPPgfb4FsLnSHHhZeFnLUnqZ/dl3ExA3+xiGZ+66QZUOLJ
         ycafnZfEVS7EES26j5atICvMd+vxwiU7VEYRBOjPjZckhKXVlkewAQgZIn0mXJ+slZnW
         kGNn/1RyXMKcAaSCrz/83d3sApswBr0K9svCFHOvpcLbiJcdp32S5zOvtgtcR6D0+q2x
         uYRA==
X-Forwarded-Encrypted: i=1; AJvYcCUJDKINPfNGnBqqSH8OAj6Tan0sPWy5ejmgtogPsX9o707ZZj3JfHJlMJIFkZf6rX3ElL1UQzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0AbOVLH+VexT3QLIFXKqpieT60hhP/YR9UJm4vHNktK0NV4v
	QF4l0Z3oLVU98fOU014aVwXSWt6bVGkhY2EZb/3WbKX0ijnJJjoxElMUy52XWYc7aV86BKgbEZ5
	92cj1kNdBxzhX3z6LftDvRF+8JPehVeE=
X-Gm-Gg: ASbGncvWGbsWcMYcOODjLFFwnSks7kABXWHKVhaz/moAGIcddhg+eBm92SMN4qzgUAI
	87uCEL4ye3+rZyt065ens9L3kh8lGOtRqi6Ymc6YG0KJzgKa4kEteUchAukwTkPmwl4Q8oGtOTe
	L46ZxeB8kSOXWOasRmuS5bM5XP73Pzcn5zEqXmZJ/tgUtB8CJ9iLLh+qHBrnJw0RVPbAJr69RIC
	rA8VlmdYNfpPTDpUka2MGWQRhTSrcLHxqnReI8QNLB+eTRz9PbGWK/gx8I6B0fDI0yAG3o5pA==
X-Google-Smtp-Source: AGHT+IHO6jbdwKewZ+aopol3D/t0siB5pKFXflfKqanP1Lzne19T0FSC237EONrcwcBGE1+D2XZVqHChOX/PZGHrpDM=
X-Received: by 2002:a05:6102:4412:b0:5d5:f6ae:3914 with SMTP id
 ada2fe7eead31-5db3e1edb23mr1087557137.22.1761319667779; Fri, 24 Oct 2025
 08:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-9-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-9-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 11:27:35 -0400
X-Gm-Features: AWmQ_bna7aWrX9MYc169qOTlnpqj03VGgvqTIlz7J2pxgV8dC1npZp8UKxvl4Dc
Message-ID: <CADvbK_c_xQL2RpOog7sA9QK7uRL=3gWEUtvCaxYaCoKHyT1XJg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 8/8] sctp: Remove sctp_copy_sock() and sctp_copy_descendant().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Now, sctp_accept() and sctp_do_peeloff() use sk_clone(), and
> we no longer need sctp_copy_sock() and sctp_copy_descendant().
>
> Let's remove them.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

