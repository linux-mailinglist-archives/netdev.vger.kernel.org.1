Return-Path: <netdev+bounces-128548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C50397A46F
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D192810BA
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F293158523;
	Mon, 16 Sep 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmALsNfg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2B15748E
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498164; cv=none; b=bdTSXJQbFH02Vv/B9PXF1wZ9jwijuqoHCliFu9qnku3CHDUr9FIrRynZcikMrO4YaZQWU19HPdyaKKUsPSkoKMpS/AbJuMVj4bIjpMybm5FSw2y3Hop9G9IB0jQ7W93SUWxcfmmsF5MZ5lztxCVKmteCCphCXJCUu6E6mt6yBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498164; c=relaxed/simple;
	bh=8gc7jRbFljRiei4ZFyXApkTdd/FDenJMtMZivhjc88Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myFjrKl8fPHGCXy1tbHznHA6UM88Dgq+Su2KUIL/mXBNg5hYF30E59xPF1Tx4wuwEPXwJGOGl8/A9l/D1CJXqpKMnI2LIUbhWgbIY+to7Nu8fbJCM0EWFi+RrScBwhaWhloUwS6UJd2yGHeQ0dVLzsH+H51FmOjnlcAFM6FYwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmALsNfg; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4582fa01090so661961cf.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726498161; x=1727102961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMelMzTkoJmecj8Ec280QAFHRxkxEeMzZsfbZtByo7k=;
        b=TmALsNfgcokBj4u/1P6m853j75zO9RwHTxyKQkfft+n7nUGN7pRrRpnaY+GJLhJSMq
         pT3nHPkZvqk7yXGipf/r+SPNxD+/aySyjq8dTzaPHPysmivho3tLRSuPUIQHmGz9aH4c
         bFUkUXedWjXZeQ0PbegXvDo/YfZEPPer0hacOyl98KXljYZTXLWao6srBcoaG/fMlZFo
         SqB86Ncjr8XB9rkrDmFahgXIfZlyHGu/XiB84N8xOC21IHAIb2AdCnbSaMQRLwixMWaB
         63i3/pn1MUC9sm+MPH7oKCCvODxRJ+RPO/6uJlWLtkwj0z0qH/cTnjwz5g3ocffv9hx9
         8r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726498161; x=1727102961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMelMzTkoJmecj8Ec280QAFHRxkxEeMzZsfbZtByo7k=;
        b=QipxuzCY1wMSZgBtgMxXuXFzJAwRUer1uxKWlg78/WADEmO4Rs3s/VPdzbMN6tyJgc
         VFAqIJTghpyvX7T1elE5j5M2Z8C5zi9Ko7TS5WfTmq5SgKj+C3fP6Kw+kD1hLLs/83Vx
         iaRBCwZ99O7JxUHP9pMahSmYH46ThH+NMFJp+ggXdzq+lS1DBHCWCqO9HWnYToErJLlg
         4ZXBKnSuyIJwxzLxywY5Kd+4rTDLgZdDe2iFjaYRxZkBzRbe/k40aZPU+hSM1ONceUvE
         zElqVKOK0FBru3uQWNwKFMTw7u0qAKwyBPoPE8q616zCF6/b8Nx+rH//LJfOy/11PwyJ
         pr6g==
X-Forwarded-Encrypted: i=1; AJvYcCWXchzhkQX6PkzrC9LZ+z5xxUbpZ6UZuN8vsVcrlthbvxowlHOFRJSxNhE8YzSNMLVVlKknt4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgGVQNnyy7E5+sKwFvwi/B2N/mFVieZO9LwFhD+k1SAzAK7mQe
	SJBNkk1O7d8C1mScSzxb2tpebj7JAezMU9+OdU+So4D81Gs6+YWbHDJ/KsxxfScFsf9Md1kSNkg
	dwc69/VLGmnl8M6pXt6QnhLFq38hX4EEePnzqutIRzirVPv/rXp+S
X-Google-Smtp-Source: AGHT+IGG1zTJv0c5bKWcBL6ppyd+R0pFs7s6AY9gInCgYJM1VZD4gWzAvaBlLTTRQ29SZSznByKAx07pm4J3HlYVrNA=
X-Received: by 2002:a05:622a:413:b0:456:77a8:ea2d with SMTP id
 d75a77b69052e-458644f9fd7mr12223071cf.17.1726498160849; Mon, 16 Sep 2024
 07:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916120510.2017749-1-mpe@ellerman.id.au>
In-Reply-To: <20240916120510.2017749-1-mpe@ellerman.id.au>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 16 Sep 2024 07:49:09 -0700
Message-ID: <CAHS8izM-3DSw+hvFasu=xge5st9cE9MrwJ3FOOHpYHsj5r0Ydg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/atomic: Use YZ constraints for DS-form instructions
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, 
	segher@kernel.crashing.org, sfr@canb.auug.org.au, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 5:05=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> The 'ld' and 'std' instructions require a 4-byte aligned displacement
> because they are DS-form instructions. But the "m" asm constraint
> doesn't enforce that.
>
> That can lead to build errors if the compiler chooses a non-aligned
> displacement, as seen with GCC 14:
>
>   /tmp/ccuSzwiR.s: Assembler messages:
>   /tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is not a multipl=
e of 4)
>   make[5]: *** [scripts/Makefile.build:229: net/core/page_pool.o] Error 1
>
> Dumping the generated assembler shows:
>
>   ld 8,39(8)       # MEM[(const struct atomic64_t *)_29].counter, t
>
> Use the YZ constraints to tell the compiler either to generate a DS-form
> displacement, or use an X-form instruction, either of which prevents the
> build error.
>
> See commit 2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with
> GCC 13/14") for more details on the constraint letters.
>
> Fixes: 9f0cbea0d8cc ("[POWERPC] Implement atomic{, 64}_{read, write}() wi=
thout volatile")
> Cc: stable@vger.kernel.org # v2.6.24+
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20240913125302.0a06b4c7@canb.auug.org=
.au
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

I'm not familiar enough with the code around the changes, but I have
been able to confirm cherry-picking this resolves the build issue I'm
seeing on net-next, so, FWIW,

Tested-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

