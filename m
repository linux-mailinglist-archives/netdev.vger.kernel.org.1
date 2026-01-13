Return-Path: <netdev+bounces-249300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D058ED1688D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CF4A300766E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AECC2E0B59;
	Tue, 13 Jan 2026 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwCRcZA/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D153126A7
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275786; cv=none; b=KEGVx48hcOoIFkmwmuzG+VA413FmFsoyhBhe7EzID6hQ5RtdxKJVdTFWH0F5wh1zkZazBOsjuxlnc/R0POAULMgicJoQM8Eh/klsy51WY+um+0FkidYSxS2B67i3g0Cj6XRxLy0cCxPOgcn+feGr35vza0kyRIHtK5jXGEzEof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275786; c=relaxed/simple;
	bh=a6C15aul2VTAVyxbrXh8hfPYzqYzmLnb1LqsbR+WIkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdpUqMA25UZCkvzXpAnH2UTK0xli8XOqjX7uCy1au6WoJCbPSWDmurBhq5BIdDoBZlBbekgl69LNAdF0fqgzbhJmQfcuf02XpI7+3jEKBjvpC02ITqsVp7CbaAsrqMN6ywnXdPS+sk7oWbtbCblCun/mDaY07FO2D8J0COtK4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwCRcZA/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ffbc2b861eso62807151cf.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 19:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768275784; x=1768880584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kejy3FjrZxPPKkiaAxc+XWc8CesUVW6VuFAoQf9XpzE=;
        b=RwCRcZA/Ha8ysg4DF+PWj1rmcKUhpRgo0yU50K7t6pYaX0QaKWZw7TJkcOXrdF8COf
         eDHPHcQeILEnU26ECTFhvlS32IPTC1Hgqtr7bjlEYtTR3s5QeaY+yW9/4oFiLir7k90y
         04FnY6a83v/Yhrjh21aFa1SugpKQnSejq+208+1WJOIhOS8n16vhqipJeOADIYs2iunJ
         5XWqtfAmvFwOVgeLX3tltg/kABULtd01aejPWQDpuSaczpxTfXFTuBsiR1HgvGlm5oRs
         Oa7yGD2QUBlmXi6Goqv0RTV15pRQqhgH4pqNGB6nD362I2rcoHgNInEWMivlGZy/HMSW
         uByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768275784; x=1768880584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kejy3FjrZxPPKkiaAxc+XWc8CesUVW6VuFAoQf9XpzE=;
        b=MbrGhsSde+Ln4vzzbOlkvIWbAV/ZPI6uyeYlW+GgyK9D2TRYKRBIrb0ev1AT2K4AJr
         oLdetJalXeK59VxAeKC9RMoPTE7D/ZHnxZ08Q1z4Xs5k0n3EKIBTmVE9NQ7/fgkm4lfV
         He4yQd3fxWkgsfprzIGHFXKwxzGYzt8i2V5uZRi731OygNyENTmkvDRNKcxZejDiHcfX
         TIuGxqmQOhX1Af88bHMZ3h9/8Y/zicwQz26SdmFvzzgNdt/YwfCH5iKlc6MCGWJInz8U
         SrWXm0y/ygER1XUZhRYLvPcFwPUO+7PQypvXChXL4Yeh0yH4ksni7n38c+BJgQ3stQhk
         nIzw==
X-Forwarded-Encrypted: i=1; AJvYcCURGw7+DLSzo2xsNY+DTTZ6RreiC0EpjxKDClhyMCpF1lZxVcBRUaJiUZn82AfM7UXLH6/VyyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyV0DlqqexEh/sh2K20JdCZiJmKJ190WdzqsG6OT/RV68GbucY
	XwHRjxlBi+MG5UfAC/M3Ye2sHnc4g+J3FOqpUnWozqdN3e1ktAIxFM30unuMy5UbsTIecNYabA8
	CoAMBPA+/G1tlperNjphoWVG7TtdFCtg=
X-Gm-Gg: AY/fxX4l9Xc9MRgtHTWLCDnEFMdRfQ8srrN2XwpOBUTyInIqBXVu0wyfPfu5ft8dIoA
	Ew4vhm34JOHJ8IKBiOH+Ezpu02SQ9FqdGHzrVK2WidQqpxQ7sCAd8lgSo/zpLMHFqtzOjUhKy4c
	DkPF5odUuvo08V7qSSLNxYnYsfFIsJjznrcXA9HuAgl9uscIN0dYvllHhg4QD9/VvW0eaTT4uI2
	4ia2Qt01hgWcaUo3KmfrqRlUEnO8YEUFYJr0ccx64B4IVsOdIQjwAmLkkeu0LhzZKfPfBjQiPbc
	XqpfhWCo
X-Google-Smtp-Source: AGHT+IEjkBSig7NIGfX7CIHVcyboDzTupBPaG9X5uFNpNmWvuo/xKjELwZ/T10BzubQMTTfSS7yepNUhdecRJuwAk1Q=
X-Received: by 2002:a05:622a:8cf:b0:4ec:ee04:8831 with SMTP id
 d75a77b69052e-4ffb4a6add9mr269028201cf.57.1768275783643; Mon, 12 Jan 2026
 19:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112044147.2844-1-always.starving0@gmail.com>
In-Reply-To: <20260112044147.2844-1-always.starving0@gmail.com>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Tue, 13 Jan 2026 12:42:53 +0900
X-Gm-Features: AZwV_QjqEyhVbkUnzi4FLFJ7h-ywrLWeKWkuFGFYiNbxZIgw7EVUGbwCKietNOM
Message-ID: <CAAjsZQypRdK2xk7ZJdvQ+0oiNxwgecn57tEd2SoMcshKP1QwYw@mail.gmail.com>
Subject: Re: [PATCH] net: sxgbe: fix typo in comment
To: Jinseok Kim <always.starving0@gmail.com>
Cc: bh74.an@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 1:42=E2=80=AFPM Jinseok Kim <always.starving0@gmail=
.com> wrote:
>
> Fix a misspelling in the sxgbe_mtl_init() function comment.
> "Algorith" should be spelled as "Algorithm".
>
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>

Please include the target tree prefix in the patch subject line (e.g.
net: or net-next:),
as described here:
https://docs.kernel.org/process/maintainer-netdev.html#indicating-target-tr=
ee

    Yeounsu Moon

