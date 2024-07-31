Return-Path: <netdev+bounces-114431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B968E94293F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA91B1C20B72
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78861A7F86;
	Wed, 31 Jul 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkskTveO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B01A7F64
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414822; cv=none; b=PKWZ8rXJm/7q76LvLxzdeT3/unCxRTAnQ5PBxUHb0/lrdUbNPu7Bc0wDoSJEL0M85UtWI6KoEX35ikXNyaTWbjDQQkGH2+Ag/Fx3eypnwBuMWGtqnTML0SNKD9Mm7iiVHh08+z1WUEXCE+XRfyDM92sldk6d4mKW99E+3BydMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414822; c=relaxed/simple;
	bh=BnZlSJDT13BF/AQaE8D41cQwd2ylQWg/2e7Wx+5OkfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hf0agiz6BWoJsBDeYorZuVQ+5j+IGsEK5ZVvT1SkJ6uaXo2yI8uH7+CQo/1clTFgZnoNmkFXTB6qinzJD+88ZV31Y5AZ4gr/zHKO/Xb1D7wy2HZr96a6LEOrlrTY+zKRcz1CSLBf9OlEz3t4ri77QghGwmZ2N/kk+wCsOVB0x/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SkskTveO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-369cb9f086aso2961521f8f.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722414819; x=1723019619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnZlSJDT13BF/AQaE8D41cQwd2ylQWg/2e7Wx+5OkfY=;
        b=SkskTveOUHZ6NHngkBr2S4zZs2T8YRSdd1GP4ir7SIL1sNy0O2+O8ncaa5lo2Ygz4d
         r6bccViMYtWWwZ+a6LcKp7otom/7JSjAg9xY4kFWZWhukZC1puTLIusJXHaco/oHWQLu
         6rzd+SlxdKZoTkBrv6wTyg715o3JCmDlohJfT8EAPLjvWvLuRECCCGwT5GprQPOoHLLv
         KocM/38zgXKtTJ4uvHP4NzlHqmw/dCt8jsuItlmsCX3Qh9tadYTKX4TKjZKH9wP3Afrg
         LJFXTrg87Qj6Xoe0cb+Ij4ak+4iyV37hYDWhpcReplz1UDTqEW3Z3onH0/RlpSt3TcaD
         DjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722414819; x=1723019619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnZlSJDT13BF/AQaE8D41cQwd2ylQWg/2e7Wx+5OkfY=;
        b=m0lx5bwHz+NkcyyQZ9Evzg+6PpMtcfQNJBrWezjXB+2Ss1JiJRmEjyFonqxSQbH+6L
         3r08CNWLcU634w0akTk2YA+rrbvv5CDr2TCUiLjMh4+o5N2wSnS43Qwp6GyECocQLslD
         ALKAfkeyMVnYONs8gv+ZNNr1v2cdLJLQVEi9P8Zx7atRYYAYLJdh2EZvjWxiyxMg9DYu
         dhJmDJTIkeQ8YWwNFwzVD5MSxz2XsxjXBp3+83wzYaDCnUg/znPdN334+zHZNCy3Zc6e
         haJb1wLu49/EkhMoKWKdhZReZvCyYYAGStsm6DJkD2i3UDJ1luX7fU4daSYz21Wynf44
         KGcg==
X-Gm-Message-State: AOJu0YzfnAAQVwPm/K/U2zPUShTOn/7W+q2gKaOLXR+2gFtyFUBSu5Rv
	JA46G87WnCUGlnfTaLYO5JfdK4TCs7QMH1V6oRBbeEtju2OnBTN/4I3FH2GomS31M5QHLCw1oHT
	wjYcZqUwLZy/hOApOsQdj2iGeXalsby3oyOA3
X-Google-Smtp-Source: AGHT+IEOPSFZehJ4N+U9mXeYBFSf/90MywPIzf/okvTbG8RbnfAdjDHuC2bUBAJGaeMoFbbkP9pPL4jBpOu5oUPMs/c=
X-Received: by 2002:a05:6000:18ae:b0:367:8a2f:a6dc with SMTP id
 ffacd0b85a97d-36b5d353adbmr10926566f8f.44.1722414819015; Wed, 31 Jul 2024
 01:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731042136.201327-1-fujita.tomonori@gmail.com> <20240731042136.201327-2-fujita.tomonori@gmail.com>
In-Reply-To: <20240731042136.201327-2-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 31 Jul 2024 10:33:23 +0200
Message-ID: <CAH5fLgjvGQiwTPvCiC9MsgKKHh+Xeyp=VvGyp_MykbLnor4tMA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] rust: sizes: add commonly used constants
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:22=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add rust equivalent to include/linux/sizes.h, makes code more
> readable. This adds only SZ_*K, which mostly used.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

