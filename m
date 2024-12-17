Return-Path: <netdev+bounces-152726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1AB9F589F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4F31881A7B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4871A1FA158;
	Tue, 17 Dec 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GvSCmQKZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEA1F9EAA
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470074; cv=none; b=gXf2PzMjxB0xiPLkb2/jGOZW3wmdoXML5VgQBTBsyRtBWNtUdbEDfiaKVn5pMjS7u/5Ao5MWQyR550pkQ4wKUtZ6xK3AID4beWYwvwDPm6NW921DwOWnBFeE96eRVsIP64aWv6chUdfMH29q8ekrE8LwEuWiCTIMw/BdemZAYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470074; c=relaxed/simple;
	bh=Fv/uXbGyGhC9bLPcVm+yw+rf/bMmIUHQtekgDuuPXus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNjFebuY+r/rjY8YrshH6p04HxnIOKE5XHerYyY6v5LrwK6WYrmvaQX9xsK1Mu1KmMZUGI9NxlSqvalRQf9G8YwmQpoy+KsSL6jC1uQvOodTBzf3SnRMY9gsBAOUIIhrdMSNLhPM986pGPW60opMq5gSvnEGrtF/JXMTHJKcBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GvSCmQKZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725abf74334so5074774b3a.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 13:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1734470070; x=1735074870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv/uXbGyGhC9bLPcVm+yw+rf/bMmIUHQtekgDuuPXus=;
        b=GvSCmQKZIMEbg8ngMrJco6I/L5iXkv/EdPyq38nTOR3QtCcrY90cELddQ1WoTohaPl
         OZrW2ELNhYEGevndF3UiHkvj0I0FWCVuKPZwEhPXwOkgyz3B/7BdaG7Xf97D9ZwDPJYE
         Ixg72vmz/+IrH0VI3MXmAUw+jYjO95uu0ygY5Lf7UFuzSF5WVhYoeV/1LUzXmylyiogq
         czi1sykpo9msF405XdDPUpd+YDUzvjel8tkg8fi2oLZsRBR9zYa7TknWDC7UXOE5ds3t
         oAGo9b4qy+GCpGv1bSlKtd/PtPIbH7zmJ0hOT3KlZj01DrNjbJWHqloguo+RpO61tNbf
         tn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734470070; x=1735074870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fv/uXbGyGhC9bLPcVm+yw+rf/bMmIUHQtekgDuuPXus=;
        b=nTDkaC23A41xXEwkFLmaeYlXag4e+3nk8WPz6dQHx+OeEUBbSQHAPeRTqKUQM4D1qE
         BRAG0x4UsXKkl7BDaa7F0YszDD5c00wQY31JUXRBBwAx8QC19rXFVI/EOZTclpUDjdbc
         vsTUK+PM1yKanQB8dGBt92wUjjjCmZH42glM2FnuVNbUSg/D6QUXqpQFW3iZ18udollv
         NBuS3yaoB7LugHqpd2piiOkAkCtBHTJEut32vKC1Km9qW0VAxuS7yTIuus/B0hJ7CBho
         UMU8ocWsjcW0qAoWaLie00jBN1zO6CKnD7eUgOzvDqVpirfx5o8eWngJHh0D53dGD87a
         JdSw==
X-Gm-Message-State: AOJu0YxQCL3pRISll8/OyOUhTbXtCDet2DyhTszI4Mam/7mL5SY2X3Je
	90CS5wmkJnFiRwtcVSwK+tItVxSPKvjmcafHNQ3die3khdK3Cpv4is1xV7QYts9aQ9WWT5unrSM
	dNEw/+bUXudI8sBvj8gIxC12P6S+RloXSOWP4T0Ow3FElwCk=
X-Gm-Gg: ASbGncvv47klZSMSHNMlqOPWNGtxfWGwrj3BxUlqU/ku5HMOPNBt4NfNGQ5XHnMjPYW
	U7EvzYqlfGyNulgH7UbRQ9Ed+fkU/eiYKdqr/
X-Google-Smtp-Source: AGHT+IEBMZ2amxqM0oK/pK8bCESErSAz7swnLQNfFPSCP6Lx4tZ5d+M0iqfAi4GeQPfBR5RQY5ucjxmrHH5NYdDmGzE=
X-Received: by 2002:a05:6a21:9011:b0:1e0:c6c0:1e1f with SMTP id
 adf61e73a8af0-1e5b487e5b5mr853334637.36.1734470070573; Tue, 17 Dec 2024
 13:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217184800.36581-1-jhs@mojatatu.com> <CAHS8izM5+WEbB_Cv+pE4oE64Bs2rL3FU2xTxL3m0g5asHJR91A@mail.gmail.com>
In-Reply-To: <CAHS8izM5+WEbB_Cv+pE4oE64Bs2rL3FU2xTxL3m0g5asHJR91A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 17 Dec 2024 16:14:19 -0500
Message-ID: <CAM0EoMnYR7=gfeWyKUECmbbnxbJGGDhCMpQB5BMcWDVfbTCEHw@mail.gmail.com>
Subject: Fwd: [PATCH net-next 1/1] selftests: net: remove redundant ncdevmem print
To: Linux Kernel Network Developers <netdev@vger.kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Mina - apologies, did not cc the list..

cheers,
jamal

---------- Forwarded message ---------
From: Mina Almasry <almasrymina@google.com>
Date: Tue, Dec 17, 2024 at 3:00=E2=80=AFPM
Subject: Re: [PATCH net-next 1/1] selftests: net: remove redundant
ncdevmem print
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
<pabeni@redhat.com>, <sdf@fomichev.me>


On Tue, Dec 17, 2024 at 10:48=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> Remove extrenous fprintf
>
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Looks identical to the line above it indeed. Sorry we missed this.

Reviewed-by: Mina Almasry <almasrymina@google.com>


--
Thanks,
Mina

