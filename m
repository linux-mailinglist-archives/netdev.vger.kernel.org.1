Return-Path: <netdev+bounces-92429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D48B7486
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 13:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF681C23437
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B817C12D769;
	Tue, 30 Apr 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ovy3tA4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC212D1FC
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476699; cv=none; b=ZEa0ZrYMAz50fxQLEgzUqqMzgKmQh5O9EhPWfMbuvSU2OJlRA76qJ5IvwKwpL2u8vmDljGtWxduColEGBXrmKZIiANLwAK9qfNCRcB2s5KrtW4LmZChTHzdwltXYYP6pyRS0UOaCRI97vmPAzOV/fxbADBqqWiRD+yt1uEghkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476699; c=relaxed/simple;
	bh=yUIj4+FkYMEG1DEHNAUghGWkLxVUu3cILbv8A0YQeVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUh8g5XKK4tS3+IYuSzKDoa3Io0ORJ7p5f9gVep2jkhakVeoUBR84SbIbVMIZjiG1CK6xvZBORgcKktt8MIUezHQNFLOj19X3hh7oLQCgC0IQ/IBPWa0/ZOdvJHcsqqDEG2in1y0Rp5bHSTK7Z4xg6xpuC/NBWVnbD+3JzV/WEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ovy3tA4L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b48daaaf4so46645e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714476696; x=1715081496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUIj4+FkYMEG1DEHNAUghGWkLxVUu3cILbv8A0YQeVU=;
        b=Ovy3tA4L9+QP3L4K3+g2c/RtCV3QqZ9TPLFsooCAeZYNTQmuSJBiyfIWdxv9pBEFhP
         cmOkpzrBvC88mY6L5vishllQvGubhs8kv6XGRKTCFxmz/ZWIFOc7RNfRzt2gJLG6oFZN
         qNADq4exrCvSIVFeKY5XbRegPmQjdeIUJlyfn+h7zzyHVq4XOgmXWnvr6haMVa/JI5gj
         TTue32WNhTEKK6r/yQGYkrz4Eor5dC2UcSzZ1kydDvYtohEQOsYMTxLvzSDxJyLDuJn6
         8ih5KndArM896GpGQsycCwC5+Xl2puaXFp7MU5dBGpAmTYc7kqhGJ2jLpDXod98vHJzR
         VvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714476696; x=1715081496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUIj4+FkYMEG1DEHNAUghGWkLxVUu3cILbv8A0YQeVU=;
        b=UwHVuxK8xcFosQKk+F5pgMVgUmEZBzjuB5F9uwSqSXVArbTXhORxl6qrDfid5hgZz5
         nZT2Is08wgE2RdaoRBKkWWpOraGIQDBlGahXL8ficIyEHS4beLOnAcLmUTe2c4oj64Hw
         RVqgEjitNO2cPkJUbELHZrkk3fCLU8qMCI3fMfZOiZYnQbVvEPmaLhHrPbHp5r6hDwBV
         GPQMI+bRpvdSiuJIapdeoWSWgKIIEitTe6hrB56OWqWEh0d+nTXWAbGun4qgJBDZw7Lg
         H2orW0OPKH47h5gJqGBVEbMTEWS2aTJ9SZYYXJX8K+CbrfbkxHFhcxDYysC1JgXLh+Vu
         8SAw==
X-Gm-Message-State: AOJu0YwHImxjWKomuAsR9jJ48tJ73EfiN8iARVUwm1TRyp/AlZSBAkjC
	JyLGjF/dMzt1JfYlOPgjRO1BKUQqlThvHAFMHsc9R9MZ4RFkWijsU4UzACscYxUhglD9bQmiFRp
	laqh3pd8DI8oeF9PKuzS5Zgsmm4qjlhnBVgL7
X-Google-Smtp-Source: AGHT+IEZq+my3yJo4Codkqnr73ObIgvGdkvuSMgijj2W/0iEJpAGKjWPpu49gTHc+sAbFKv+yXyQLhkOgeUQcBKjn4s=
X-Received: by 2002:a05:600c:4754:b0:419:f1b4:b426 with SMTP id
 w20-20020a05600c475400b00419f1b4b426mr171453wmo.2.1714476696227; Tue, 30 Apr
 2024 04:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427182305.24461-1-nbd@nbd.name> <20240427182305.24461-3-nbd@nbd.name>
In-Reply-To: <20240427182305.24461-3-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 13:31:25 +0200
Message-ID: <CANn89i+-uWYYhxjnsqtxhDD_kjoiMBo+PO-5ZAtYVdh=njje-w@mail.gmail.com>
Subject: Re: [PATCH v4 net-next v4 2/6] net: add support for segmenting TCP
 fraglist GSO packets
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 8:23=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> Preparation for adding TCP fraglist GRO support. It expects packets to be
> combined in a similar way as UDP fraglist GSO packets.
> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

