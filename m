Return-Path: <netdev+bounces-151472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBF9EF8CC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B21E189D308
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4654F2210F1;
	Thu, 12 Dec 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rgW3kF9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C9222D6A
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025099; cv=none; b=U+4O1LMsjui9hiinZQNMPfvCHUHrJ2rIKh9DblRfXJK6Rm+Y9Gjf7w33mczC4eZ42DzUdeDqosjUjpouWtOLQ3Rhu+T0t7BMtfHfPXVK9ffrggQ8xedEMEWOp3emjuEMSLAka7jlJmYrcT1Nr0vwpBCLW2cl96glgVZDJnWKfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025099; c=relaxed/simple;
	bh=aWTVrxmG5W3tIhT6neWuRFNEJ1LBgRdw+hgIKFCMjK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOfR3Ddd+o0aUkyB81vSOHdtjwFaqYPPR6iMuNAINwWBMAWGYtSYuq/+bT/WT9XbV2YQorGFLGK4IDw4SDw+nYGCOj1duUUOOIZ0mzVF5s1sX+SFIg6mea0eYys5spSV4y+ms0VhersFhe05mN4T3Au+EK1WamPpn5UK/kc6ZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rgW3kF9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3a90336eso959242e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734025095; x=1734629895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWTVrxmG5W3tIhT6neWuRFNEJ1LBgRdw+hgIKFCMjK8=;
        b=4rgW3kF9468wmzu5vD3JP2gqmc4PdmJAWEx2DVd80dOtBAnwJwaaxmm/DAHJO3bYIY
         dQWCVSDktLwQ7VY7erI49aRt1NVP9Nb8iMD1j9Crza7t+fvbyyFizPyhloGYOoiVmJ3c
         ovIboTYbmYkTrK0uh2L3wuTGWqPvaAuGUf+d4VhxkefASUIIvl6HFQ8lLUc5zj8c+UOQ
         ZQA9obp/zn2gqu7MkONKg9YGFMOCf9MGc75qK5wYbjo2pRCPS6QRmRYbxzz4/OdM7Ybo
         W417cELTTjvLWTl56/QqSTvb3EVIQ4+Pmk1q76lMX+90km/kwUu0PzVhXFoNnPRk/QNb
         43vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025095; x=1734629895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWTVrxmG5W3tIhT6neWuRFNEJ1LBgRdw+hgIKFCMjK8=;
        b=P1AdFG8sBmcg+rDpqUqQ8PgRsZsXW5G9UL314030lHLVqpPlj7EVfQeHI7IEGI7odM
         Fu8vO75mCV/CAZ5d9i/d5TXTO8RW8k8nCwG8K2evE014hMZhuX9P9Ka6VfAJM0Ad5aZY
         ldS0LZAQFcxY+Dtazw8Kx5cwC9M+HOtEln6D2HilkRAxXMn6/yUMG9E1KtURnCP9XbA2
         F2DT2CXgznps0lmYLp7vypumHkvkoiTy8t/JhKJkuS0A/SkeCh+G8JWCEI9nIv7xiN3C
         Eh0J816Ucohb5yRPInJJIiuTepXKpUHndkma0Iqqm0d4zIPwuL9go+SQGmzwd6L+EHQ4
         Q1qA==
X-Forwarded-Encrypted: i=1; AJvYcCVuFwvtCRaokvDQ5QKmsX0J1pxPc9ehU4ab3MW4cjOegaccPy2H3x2E9rMVmVCKhjj0wwxsnzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhfvDRyilhQS8x79A0jf+Yzflo6IM1LzYnLYkgBLw/EsRjM8n+
	KMQGJNW3qeUUft3Epm5LBexsAs4ZOA8zrMChu9328EQjdWi+Fk0HHA/gtnPshampo9daTL7SwFB
	BJg/PRbs9vf/+14FxjQHnxStEHxceWND4gNa9
X-Gm-Gg: ASbGnctWZPtGbUoD30DxG3Yp37EmZEvI2mridpqOHceCP0Uvw0eE2nStZy1rqcZHjOX
	jOZmHOGK58DIcaFu1CKBVmJ/OLaCHybTGhx3yMA==
X-Google-Smtp-Source: AGHT+IH015phUurBpWFmQa3s3RBwJ8PNrtRSaF1ujp3Q451/4hYQAF7Ccw77Ht0ZKlUC+7RE7PoqmmdadfJXIZMtLLU=
X-Received: by 2002:a05:6512:124f:b0:540:1e51:b919 with SMTP id
 2adb3069b0e04-54034112534mr504071e87.31.1734025095447; Thu, 12 Dec 2024
 09:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
 <20241212-netdev-converge-secs-to-jiffies-v4-1-6dac97a6d6ab@linux.microsoft.com>
In-Reply-To: <20241212-netdev-converge-secs-to-jiffies-v4-1-6dac97a6d6ab@linux.microsoft.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Thu, 12 Dec 2024 09:38:03 -0800
Message-ID: <CA+f9V1OK39b5hNoVZqu6AfPJqGsB4_5iyAK24Oit-tjmxrk7jA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] gve: Convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:33=E2=80=AFAM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies(). As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication=
.
>
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci wit=
h
> the following Coccinelle rules:
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>

