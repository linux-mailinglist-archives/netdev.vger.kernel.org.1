Return-Path: <netdev+bounces-163537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D7A2AA06
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D19918880C4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0FB1EA7C0;
	Thu,  6 Feb 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/c8ihz8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7E1EA7E2
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848757; cv=none; b=AGkLoFUywSJAPi/YGoVXIn0Z3WF0ghNHQjz5FqpbHPZmapjyJT6eUGm3/EokE2nKHKzzz7uOK2GQ1PyFsLs8oc1r9WV4NQErSkLU2xknkF+ThT+RSUDNeKZsy8nDZUqDT0I8gRv/nmKU8+mg95TsPSO1SPvHT5qa3YKU1Ffkc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848757; c=relaxed/simple;
	bh=YXEh+QTuU35Ix8ip06YwfIpmDJ5yv14VZlFiVZF0jUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFOu/xyXDDnTgkkFoPKrGCkjX7HnBbdffFqiRvWUduKbdEk9S52vOfu1jY87zhCbdh6s+Jj2mPwIT7uGD6FVepUXfTZ5u77UeRlyWR4J4Q0H5Ub/7MWhi1mAHnYWCftMrpn05LtGsn3K7BTHsAhFs1L4vbBt5j9cHDBzISjIntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/c8ihz8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dcf0de81ebso1412533a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 05:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738848753; x=1739453553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXEh+QTuU35Ix8ip06YwfIpmDJ5yv14VZlFiVZF0jUY=;
        b=e/c8ihz87AsPIDxalSUtPMqs69oZbUyCZ3/EONZ61t3+rYH0rDa2Pr5snmHgM4rNwv
         x0fm4TrQSsPmbFy/2JAmiFBmujVkCaFQNDJl855OWncijMDulmlDYWlfMOPuLqhXxFsw
         RxTps/CRj+kcU8YunPFsNNPWAtaBp/iJXxbRQ4MA3Z2A4fXyvgzNki3k0SqqsCLmYHZM
         F4BOkOzE449/sE0jIL+i6zguBnkfkXTRCyKHaD4Vyh+ae23O5/sqWFL8jN+70FOSCKFF
         h5YvH33Xt1pP0sPZxeKGysq6Upy12RN9ACKg8RTzloTRPdXMXdPSqc6uo9EAqPoddPai
         M1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738848753; x=1739453553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXEh+QTuU35Ix8ip06YwfIpmDJ5yv14VZlFiVZF0jUY=;
        b=oh/TIsKWCORhTV83/O9ffOXVMYgC8u962G1mnhiONVXtk4Gw8bFoH2LYICzGz4R/Aj
         bMrCelic36RVl4Qvio0HbJ7eh9giuPPwwHm1J/T7vOLKsXFc+8PXbOtBZ8BbAKdsfLWK
         eAxFYS+vxeTw8oBC73esBr4GB6g3YIqQOGPNKSefBw/VoOfCyXmAbAraTnac9GK+f2EC
         VcZkHBISEGRSNtnp1nroahh0eB/XQp5w3aIK6RkWoyuI4Qe/6fAFRSHPpNc7HCHXC0+h
         LtTNnPXYmvW2ZoVcLiDXgMjKJHPpiNG9n32hZdsGMExNIhbDZBNT24B3I/2d6BRJ07Lc
         MeVw==
X-Forwarded-Encrypted: i=1; AJvYcCW6jc/p50OBljrDBQPCEHkpnAuJj6XOveJ47CCS+wDyibVNgXDJFC2kTHAvwfF/RnfSoXeH1DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8qc1V9cRbb3/nB/FXxLGg3ItAzDQX6OikTXG4+KNL6ZKu7Ap
	LtdvdTpHFSEIQ2zMnJxjB3B/tvHCw7nn0+PXvmwNXTc7rhh9zJRtNsiZKMgA4PpJbTwk1yypNeB
	Cf1sM7pHN1QCcj9APBA3LfR1Tlp4jYpZbaTRV
X-Gm-Gg: ASbGncsdBFstpxaHby41QTxlFCZfern+al7dRPFNOZFULwiAuH2j/F3eB7Nasj6YdJp
	Nwi+ecTuc2K79oHVAK7o8JyDGLSse3PbRqaAb7yW872yHIdDc1ounMCtYqpe4iOYo/rxmvQlygw
	==
X-Google-Smtp-Source: AGHT+IE/lCL4Or5xFxqNFyUi5JqP/s8vrEYwSjb2BhdaVIv6OPGjj3dehhX3xlLe7Kv6L3S+ySBtjLfokfRtYcQJ+JY=
X-Received: by 2002:a05:6402:4499:b0:5dc:cf9b:b048 with SMTP id
 4fb4d7f45d1cf-5dcdb70023dmr6675337a12.1.1738848753441; Thu, 06 Feb 2025
 05:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5ae45813.3235.194db3d35f5.Coremail.stitch@zju.edu.cn>
 <CANn89i+dsbTvY3tKhTGAEKUtHqThya2vELVTTDfrUSppMLt3SA@mail.gmail.com> <19e24c6b.30cc.194db6ce8be.Coremail.stitch@zju.edu.cn>
In-Reply-To: <19e24c6b.30cc.194db6ce8be.Coremail.stitch@zju.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Feb 2025 14:32:22 +0100
X-Gm-Features: AWEUYZkh5Zcb7NIEdXOyisy1t5i72Nc6dt49Am5Xx4pyCgeg73o-lTT_B2doalQ
Message-ID: <CANn89i+7_yf2U_bEin9iGAE1DifZ0F1=bRdnjZwq+_UNp3VB0w@mail.gmail.com>
Subject: Re: Re: [BUG] KASAN: slab-use-after-free in slip_open
To: Jiacheng Xu <stitch@zju.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, wolffd@comp.nus.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:22=E2=80=AFPM Jiacheng Xu <stitch@zju.edu.cn> wrot=
e:
>
> Hi Eric,
>
> We are a bit confused by your response. Could you please clarify whether =
you think this is simply a false positive report or if you are suggesting t=
hat the patch is ineffective?
>

Your patch is not correct, because we are not allowed to call
dev_close() under rcu_read_lock()

This might work for the particular repro and .config you were using,
but will trigger other syzbot reports quite fast.

