Return-Path: <netdev+bounces-215035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4CB2CD10
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 21:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D0524E324F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DC13376AF;
	Tue, 19 Aug 2025 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxeatVFY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BC287246
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632294; cv=none; b=OguSAKGdaF5PW1peheB0AUHCj8edZnaUq0CrnEQvggRpE9/9BJlTdfC/iP20pg+1m6tg1btCbkcVL+pj/V4wsRqFXF0RCgt7jHJVBb1X+nENb/WH2jfkhPau6HQ+mygCudnEPXHgSoqMoixYfB7119fsD1cY5ckSkYRqlzkvQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632294; c=relaxed/simple;
	bh=KyBUNB2sq09QvdnxFRddWehNMcaYqyV73YsWqTqEkSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8aXYA6QCiX5zwPpoVF8KU8JQrcOM3jxrnQE0LUmJne+/uYZ/D400gqMfPjvS/aJ6cB30Y5NqBDJtgCskPy/P2yvk0JZMY4giytdHHiVIPSav0ZG51gLR7GnhYa/4TVrPBkxxKDE2Qi3cnU5ctLKro4GMGYAnu+spmch6tbysTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxeatVFY; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0bf08551cso101391cf.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755632291; x=1756237091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyBUNB2sq09QvdnxFRddWehNMcaYqyV73YsWqTqEkSQ=;
        b=BxeatVFYwJ0DeTiGmhhmBYqyBFhikIt81fy2+Ff1GvRp79lzzGu1mbPpGJo61+VkFC
         ZdvMQpRJesWHpwqk+RroPOrAeIT31K1mmGO0cyA0Co/Fu7qGImHHd0KDJHBwc4gbQPKN
         9mxiWdJIV3MWZGoj+2pHUXagAIFE210LOSz4dVYSYkdJSIdHlEFCAWgW5MciycAmvdwJ
         BM84s7S8Y4cvEnc5whvRBWbuRIxoHWl8Au41Tae5d3Mpfz9pSE6yPqmS1/ESeUFIw0ia
         vli+xZB6Gp9t92RJO8J1FZrEMMkAjeWqspmpt47m+6wS8eaB3I/JixMp6BXQuxXMeBBf
         4IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755632291; x=1756237091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyBUNB2sq09QvdnxFRddWehNMcaYqyV73YsWqTqEkSQ=;
        b=jsDudsGhq4IBIIrOcZiX8t3w/LojsHVbsNB41prwnrCk8VG3BhfU2nK44pPBXZSDVD
         s0MmMVSihizeSJNk+N4XE9LIdOf2wEaUbOfwnz7ER+cxlT6PtUqwpwnNBQQbn4d80g6r
         m7izgVKbd0oLquYbOYDWWD2gaxU71HnW7DGQ0MxTs5vlCtlunbDY+axfzcJL8H4JYW0H
         jB3FmxZe+w93xxW8FntILV/NiJ2mR2LRT5Ubx2nirfOKtvPRsGMGd6iZ6M5USRPiq/Ai
         eFbKBS4e+pqGI8Y0ndQrQCztkK9IEOgUBcd7bg/RA6/dBowODVAffyDpYsJEnnvafb0c
         OfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZv127l0vGfEI5GYJHYWqSicqRJMb3m6vYAygkVf127HuaL1CwgPepAOKEL6ErpPlUef3IpOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYomw+HY7cC2P1Vb85Dy1Td6R4xfXSWyTUheOGpXdBSVkvwvDA
	kLyljDWFK+M8DjvTG5Zjx01VSrd2Q+gY+7V8z6W1rgcJL8vjs5qhUZUSjnRpMaqGqZUGCvmiPZ4
	LGB21PTsSY3PqqiFP5M6wCp/tTZ7uAeMGs2fzssY/
X-Gm-Gg: ASbGncuahLBJuY99+PMFqXogbEp+MFrH+ufuYdQqHr9KlvwZRhFVbWOxtqK9TGGroWP
	eCd06AkvUPCbkWizwwQs6kA0QlXDHDX42xU0Fe0t8Y7Kn0eyHkp2MRAXpitfftLEVJWrrb1fIG5
	FZ+wHs/JbmIe8LrY3BoVlejAAvTsxVNUv8frvGdK285eTqZD+C5iQ/PC0mEl4mgrbifryXRA45c
	YS41Ij4GirzwRIxQJa0uKZSIX2HK/kH1eo5RfN8bppoJgf6cRuOFdfAYf7HhxwALA==
X-Google-Smtp-Source: AGHT+IFR2/iMkStKZ0a8zzBrBpy7PAaXOuE6GtKGvb6nOuL663qM4JQSRroZMOV/Sebi5i5ZULUxa18gYqkX5fMTTAE=
X-Received: by 2002:ac8:5fd3:0:b0:476:f1a6:d8e8 with SMTP id
 d75a77b69052e-4b291b9c1efmr693801cf.11.1755632291072; Tue, 19 Aug 2025
 12:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <43a256bdc70e9a0201f25e60305516aed6b1e97c.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <43a256bdc70e9a0201f25e60305516aed6b1e97c.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 12:37:57 -0700
X-Gm-Features: Ac12FXzh-xPyuuuSr3t5QlnJu8i5ZGtJ2KSJsIVV1_FY-w1P3-CyOqXsgUqFpw4
Message-ID: <CAHS8izNq8wKXwiZs8SeuYhsknR=wAwWPEnBOxUgcMhCoObQ=xA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/23] eth: bnxt: read the page size from the
 adapter struct
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
> Switch from using a constant to storing the BNXT_RX_PAGE_SIZE
> inside struct bnxt. This will allow configuring the page size
> at runtime in subsequent patches.
>
> The MSS size calculation for older chip continues to use the constant.
> I'm intending to support the configuration only on more recent HW,
> looks like on older chips setting this per queue won't work,
> and that's the ultimate goal.
>
> This patch should not change the current behavior as value
> read from the struct will always be BNXT_RX_PAGE_SIZE at this stage.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

nit: AFAIU BNXT_RX_PAGE_SIZE should be unused after this? You could
delete the definition in bnxt.h if so.

--=20
Thanks,
Mina

