Return-Path: <netdev+bounces-215055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0D9B2CF01
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C70F7264DB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B23277B9;
	Tue, 19 Aug 2025 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/KduMwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3A327790
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640679; cv=none; b=MUqPDHXYfsMtOSmOBfHeJy4UwENHqbKZX7HdQhDC71yJ6hrzSaPAAIDueQjewflOTkrxom2yf9ReAlWyMxWc+MwZer4YJzGxp7e+7FPWELW+xyn6RZ50xirH82ATwYpao369UaNgl/Xu5aF5cKoKYHEnYcXP3zcNZsIzByKBRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640679; c=relaxed/simple;
	bh=CvJtxLbc27on48vID65kXKtMHxJ5HMnLMk4STwfZJ9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLgrzSQ1PchybLD7gD7xFbyNY8rDoXlEKih+fTN1b/0Q3ni/Vtgy1BjDqH835ofaUIJfnwx453KH3tK8cUYQ3Mcd2bHOmaQSMsJkNcY9aT+PWPkEzeuihTTjmtW0RU8oOtunYL+AKv5V6oGP7o8rxPHg+YyPUHooYCBV9OQkoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/KduMwC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55cef2f624fso651e87.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640674; x=1756245474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvJtxLbc27on48vID65kXKtMHxJ5HMnLMk4STwfZJ9A=;
        b=n/KduMwCc9rjzThjM4rt7oiPlGe25BI86/yktxRQuzW19y5MEbUQsBwjTAckCACiGP
         UbrMx1DPZsDwWWmbMoJUwWLnjlGp2Td5gU3gTiCncXOx0ddTZ1Eb54BmhuPCmCIZkcDA
         QIUP3WgNJY9y2taXuQmQyd3wcQp9UDI/2dRu3h1qdCqgPqWvZmp+pqh+0IfXKL9XU6at
         pBBv3KEqEtflpsB5CzHbRnLF6vcF7M0oJJ9Qm8wWXcQ2TIAm/LPq1EMCbZZ6Q6nVCM2g
         58eCD3PSxSluZFV8EEEMoSk3zfNtckJiTFlO0fj9xRW5fHs6eIlNOhfzBz5bq8RyEn3D
         NTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640674; x=1756245474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvJtxLbc27on48vID65kXKtMHxJ5HMnLMk4STwfZJ9A=;
        b=QoVo5ZByBkE8noHPYB4pRlqW9h0QevqpYtzhGyztgk/NWPqo+J0dviNESxZ/j4Zh7n
         HIg58XvAR8U9METMM/YU/a8q8ucp/hMeZILM/8+zWLdJiV2sZsQ9k1c0mar+Ngwk9Hlo
         VLM4bmpDxX5soru94qZtXgX+T3+xsXWuFtwYAA7X+fWxmVfy3fO7h19s8KdeTMSluU8F
         iTF1sTi49s9Xe22McJB/jb+ViGpr6KiVQn8QJMo4gXYXvQOraS5UWtB52iMNAVJoyNXK
         DA4HEFOTP1BvzfaBeeyhaodyZI2c5KJTZ+ur7XhYNnyMhaiVxAV4NJXkFzmuM0pvGl/v
         7IOw==
X-Forwarded-Encrypted: i=1; AJvYcCVTQDnTtbQsy6DwPWurLx5jqPiqHpUvlYRuVIsVq84FAmxyTpwqJyC0htlv0zov9aK6R0OCp/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zSXvueKVQLruHg9yAayTosht+2EArz8+hdM8JEe4Y+K+XlrE
	E4hcv6dYjPh7tw7LqwFipgZinLZ8ABDOUjrElGzwRBIQwTevHFU7+oJHB9AIwz7RWNYoNMffnby
	PqTOCkT273mFyx5RVBF3AodFuojSMhXHOx3DF154h
X-Gm-Gg: ASbGnctZBM+Y3ZeZhxyU0oueBnyiFcAkwpEkGe9UHz946EpQ+8IXgFxyYuncFPCaEju
	gC8CoiOw9MnRXwVtQQlyw5ivIVsHpZTMZetgyrdrsz6tq8ew3+hQGI0AaCykyPyRTdUDwLf3gGO
	lJ0pnpxalfXmrjsw77xgxugmbhLFIjQhKemFI6iXAwzMSxIskTQyIs8v+PBMLEa4SmXoRnRrTg/
	wWVwaCKEX+3Cy9RNoMcDqZTwWZnJ/qqWVZUWBriejMtKsvRBJJTogc=
X-Google-Smtp-Source: AGHT+IFjnm783G9/tzKiECTrCe8fFRAJeZ3G/drDLRd9Ku7K+BYBH4Eh6bxrOn+3eJeQcD9yP73r6e7X+DEQbcuDRLk=
X-Received: by 2002:ac2:5e36:0:b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55e06752de0mr73920e87.2.1755640674063; Tue, 19 Aug 2025
 14:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <63cfaa6b723410ec24c1f7b865ca66fc94fe9cce.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <63cfaa6b723410ec24c1f7b865ca66fc94fe9cce.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 14:57:42 -0700
X-Gm-Features: Ac12FXwUdfa4vW85A0T9LBksUrTPzJOsMtQHo15Ay6MIOEBEQOu6vZwDcE8HLDY
Message-ID: <CAHS8izPM4QdvdQurnO1RYaHcW8Xq5yK21c0g4uuqbLJPdjTpNg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 15/23] eth: bnxt: always set the queue mgmt ops
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Core provides a centralized callback for validating per-queue settings
> but the callback is part of the queue management ops. Having the ops
> conditionally set complicates the parts of the driver which could
> otherwise lean on the core to feed it the correct settings.
>

On first look, tbh doing this feels like adding boiler plate code
where core could treat !dev->queue_mgmt_ops as the same thing as
(dev->queue_mgmt_ops &&
!dev->queue_mgmt_ops->ndo_queue_config_validate).

But if this is direction you want to go, patch itself looks fine to me:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

