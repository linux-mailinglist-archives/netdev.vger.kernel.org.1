Return-Path: <netdev+bounces-156033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A364EA04B5A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0370E165915
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967191DE3C3;
	Tue,  7 Jan 2025 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrR1KFK7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7018C035
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283914; cv=none; b=KI3ZZJO3P0wgIxQfDrFXIitpp5IK1MyJVqypzBVLJpZcM/9KGMH9+XpQJM3WxnIkqbfm/AJRsyYlFQFoIJC1UxhRVQCNc6wbZFbSxHdGoRIWCQCFKHWvxs/3uOaL6nGlhg7tMNYS8pBLwofrNKXYKRVeQBKic279wUpMboiCY1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283914; c=relaxed/simple;
	bh=Ys6rK27OvhXGl6NJf7bqF9tLSF9DGiQcRcO8njnhQcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnKu3Sj048pqAcgGI8N5Jsn9zKH1fWtX1pnSOrqbirK3j/pGon0jcMwtyhNGveWjTin/Y8qUylznYDDJ2pPmvw+tuUgcuqN4rwMpDomlW0SPeJNQlxw3bLIwqQ747qOCGbFiYqpKm7Rky1SpCKXultic0jzq4PxI2tmuHwq3TbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WrR1KFK7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679b5c66d0so8691cf.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 13:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736283912; x=1736888712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ys6rK27OvhXGl6NJf7bqF9tLSF9DGiQcRcO8njnhQcA=;
        b=WrR1KFK7h5fsl5lV6s948X7cvRvFo6D7a9Pz0QzmDyNDLIa0ji+uH6ip5wqiPx7HUV
         wvlrDQecZVVCVcbxDGbrEOv5Dp8EGdGk/kAt5IoxMqp2H5mgqNfahcSMuuTx2fWEWJc0
         QOHiPKL4RFKiS/edR6lCd2twBR5sNCLr+QhYRNpHgFrPcZBrp98pI4MXET9jbYBr/iaF
         1r959UMvyAjQQgO2ApyyV/VYFWhoIZmNW6AnhEb8xo5siuRTIUiVkxrhbc4CeyjXfJaf
         TABgLNbO7HnAUg8s249hp5J5mgGI5cRsHyh18lYtefYbeJMNEaehYnrq+24Jhv5qyHRq
         6/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736283912; x=1736888712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ys6rK27OvhXGl6NJf7bqF9tLSF9DGiQcRcO8njnhQcA=;
        b=OjR0+oO1ZDcpkgtoFam/62T7ckj1WDMzsdnBZ5E0CGTJYJ4v1tHuYwrhUf8dc31uxd
         z/+/iqFdaxUUdY8RRmwBqEAFOqvc3mJc+qrRRFV/aBRKtXTGMp0r0UDJztGhtbGtKweh
         S+3sqpsav+88k/A1m2/GR28ACh0+RFnAQP7twJ0BCpTFIoFl5Jspy0x0KzNGJGJTzLLq
         JC7sDd1JXkbM08m0dr19sEBA2NfEGySR19HFM+x/y4fHOEP3wRpKq6IK3yq071iYJvek
         tJh5lBGuamEjV0zZFRq0s1EAg4LJjx/mUPxYRKr1O/kw6cJnidVdA08PnqEDhg+PPGKq
         odwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr5pPxyjdDGh26bIXwZzVDZfA+c6dNOU5oGjmRnGpf8L25YJRI3woCRkrpk0ubjNMWYYR7NoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNr6JgIXKDExXnHztNChGuo6OiPYz6b4raeMS/bLrACLUB9iz
	r1rfXqafkiNFMcbo9raQFQfXxH4K4kpOJG1zoMGSM71/XUcwDWxqIzP2tWVAPvfJQJULny0a2UH
	73N+4615p4LuzisdaUcqoUr/dCNdAcCKQvsB+
X-Gm-Gg: ASbGncuk027SjkbSkRF9X4ZSn/CJEpZEDd8dkR6cuagRBdYKTzzCvW9cVnRHJwjFoIk
	e0lUw3nVFEnkify6tfxmMM3bfp2KOVa6+SAWxTIb1jKpDNtJE7TT+ugLBtUJKgK56zsM=
X-Google-Smtp-Source: AGHT+IEI9xdlihIK2Wu2kQ0IqKHj2ERg/lhp2RfpvoMVktOWUG1PlxsVuXisdtXBR24WMWZqpZJI/zsJbMUT/vXLU1k=
X-Received: by 2002:a05:622a:156:b0:466:8c23:823a with SMTP id
 d75a77b69052e-46c70e9bdcamr573641cf.17.1736283911702; Tue, 07 Jan 2025
 13:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103185954.1236510-1-kuba@kernel.org> <20250103185954.1236510-3-kuba@kernel.org>
In-Reply-To: <20250103185954.1236510-3-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Jan 2025 13:04:59 -0800
Message-ID: <CAHS8izNH32B7JeZU9MFZ33cqLFWG6KNhg=f1hVASeojmUr53Hw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/8] netdev: define NETDEV_INTERNAL
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, dw@davidwei.uk, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 11:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Linus suggested during one of past maintainer summits (in context of
> a DMA_BUF discussion) that symbol namespaces can be used to prevent
> unwelcome but in-tree code from using all exported functions.
> Create a namespace for netdev.
>
> Export netdev_rx_queue_restart(), drivers may want to use it since
> it gives them a simple and safe way to restart a queue to apply
> config changes. But it's both too low level and too actively developed
> to be used outside netdev.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

