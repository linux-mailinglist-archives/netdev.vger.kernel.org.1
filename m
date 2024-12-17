Return-Path: <netdev+bounces-152544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AAA9F48BD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1EF188D650
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91061E1041;
	Tue, 17 Dec 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1vdaU21"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C31E0DFE
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430756; cv=none; b=kjEUGZONNWY2pDSQ2Ii6Bda4VLCBa02yRhadWk5pslrcjATM1V6WtNijrr4bV7xnMlnHtQpir1DfCjg81/E4DaUcfRz03mACkvC7/3L1HE0x1F9MI8lxCC2wt+R6Mi1P+JDPORbVI11oaxBXifqwxdD5Dh9p5EyfCeUZZzILc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430756; c=relaxed/simple;
	bh=Z18WrDXPOK8sdE5XwIMLKVLdTqqEpVfwiIQqP8kH+eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atV73KUJ8oYrqTYmEA/3WxtZ7BPe8boW+4mDqV3lmWx97lVVJLX+ypqBotmHB0dFohIYgq581tqTY89YZ6KhUihZS+C7wZmiY5dEqkOvit2KgHBgEkVxpbn8DxUCNZY59r2dOfJMMcndzLsQ0MgxpKOT/NFp4Oyl2iIoockk7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1vdaU21; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so6760218a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734430753; x=1735035553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z18WrDXPOK8sdE5XwIMLKVLdTqqEpVfwiIQqP8kH+eE=;
        b=r1vdaU21inwCY9q0n9XLAqHZFvAtz/cUnpwEIV0YB0xuaAUKF+moVls77El5WcO41y
         QhR1kHyhBt8LC655s/xoehYcH/JEzpi25twPKC7s5/e7TX8zqkxwW1FxctecMURP0oMz
         +QzL1FgcVrwQV0p1GKw1d9rk5RDtrylhjAZnS5czeoHfV6TeXd3Y9t3fhyTjV/9fYXX1
         vaEarSlPcqFQN347mvE2Wkfet/p+CTzxvLmI8/IFaaoD9qRTm85g8/8Fy0xBrQflyvym
         My3ik5Y8QuvsFISJJGRho+VCBJIVogNMZQVG0Y1/RoepYH2e5Fw+SfEr29fR6m2QQo+T
         lfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734430753; x=1735035553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z18WrDXPOK8sdE5XwIMLKVLdTqqEpVfwiIQqP8kH+eE=;
        b=PV6wgKE7tBhAbQDdMLz6V5D3K9B6TLOcorQZtMDVPZKJlfzMhiyR7dTwNQzxzns4ll
         JXQU1RFDV9gHmpKe3y/38d+4NYkMtF7YcWEJZn1lITRqEaW/vEH2tOu4wP3Rg7xpb741
         UZHGaZ6d3lgAWhrkqj9WwlnO/ucQbHQt/kTD9RnZ0E2vo5TwRripmuuAN4lxNYPGx2KA
         EOmx2h7lkZHKLdlMz9Q32OmyPxSdHBMsvfJ3Bg/CVI+WNg/fuRIs8P/Cixcwk0ClnCLG
         OpiFi0sHPY1LYPsWzvCKK16xcAF69djXK/ZEnTd7OBYBh0s1PCVrHwoVcJGtVUxtP2iy
         9zFw==
X-Forwarded-Encrypted: i=1; AJvYcCX6frdYLfcwt7xrTb2dzYOyCgOtwRGk/gEBcVJUjp/5ZLJysx/3awlTy/HgShFwYlzSaHcm8Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKstrsx9PToOjcm0aDoH7licMBVdrwHRs3LdtMCBBenhYgFCRm
	JersSpbEgt7p8hFCY1q7Rj9zls5N79HWjjeUrgYsp4nm9gah8jhl7XFBVuPIyhscr06AX3tOkrG
	YbheG57dLhRYi5KyJEa4GQsO0OluikZcZtJlA
X-Gm-Gg: ASbGncuqBmDfAw+zH4BLfToASK8+QjQ4SCHzMFX/riy55Z2xTu4BzPqoZUJUYeHa5Pg
	kxi0Db82TnuMfRNaGm7QHRK1urINHQmFiJv6+8zk8fQsM+uIgBYDSE8CJQkNY6h2QV306b9Rj
X-Google-Smtp-Source: AGHT+IGwfOu6ANJJ05jZ+YL/Ec3h75SVW9OIju7Dy/3tpNuFA3NKeaexTVuBR8DEViYivjcF4eZBsHCVbeTz8Hx3SJo=
X-Received: by 2002:a05:6402:34c7:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d63c407452mr36501089a12.32.1734430753272; Tue, 17 Dec 2024
 02:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217094608.4149466-1-buaajxlj@163.com>
In-Reply-To: <20241217094608.4149466-1-buaajxlj@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 11:19:02 +0100
Message-ID: <CANn89iL077dDhKwWA8Uqhco-uK=UdjZMy7+UABBT8h5Lq4UF+g@mail.gmail.com>
Subject: Re: [PATCH v2] net: Refine key_len calculations in rhashtable_params
To: Liang Jie <buaajxlj@163.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Liang Jie <liangjie@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:46=E2=80=AFAM Liang Jie <buaajxlj@163.com> wrote=
:
>
> From: Liang Jie <liangjie@lixiang.com>
>
> This patch improves the calculation of key_len in the rhashtable_params
> structures across the net driver modules by replacing hardcoded sizes
> and previous calculations with appropriate macros like sizeof_field()
> and offsetofend().

Please wait at least 24 hours before sending new versions of a
networking patch,
because we are flooded with patches.

Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Make sure you address all the feedback in your new posting. Do not post a n=
ew
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.

The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include a link
to the previous posting (see :ref:`Changes requested`).

Thank you.

