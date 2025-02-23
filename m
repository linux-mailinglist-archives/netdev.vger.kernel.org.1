Return-Path: <netdev+bounces-168810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EBDA40E0A
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 11:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C27189801E
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309F204685;
	Sun, 23 Feb 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dejo+nlk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EC335BA
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306091; cv=none; b=L5SdJQXmY0R/r1tEqIZni++11TV5OgKP+gl3v4RKcSoSOSljL7Yyzu9U9IYkU218yEgCpw4YbjkDtCODeeGCNvLWq1pX/y5vH4MvvVLMzdycgn3pSljdPd143ZrWutmTohqlTXWgsUymgl7sHwJO5AUoW9YboOyC+UR5i9njFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306091; c=relaxed/simple;
	bh=/bxfSrUOURWj32mv9Nd0r62CA8Ts9Mz5b5TOmHtaMOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZgaeUdL6mWjxSo7D2fyoLtLu20wm1EJwlrk+iNcTGABBWT0966PFFGxDmykJS9srDMjDl6bzbb7sClznB/pmwS60QhPtRJ5N+/b8XnlR+7P4Ox2FEi3HvIkcpKhigHkSlhxMj+NuvNDUsaaLhYLELO2LZL5psWgUOcH6cl7HCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dejo+nlk; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ce76b8d5bcso33187125ab.0
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 02:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740306088; x=1740910888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bxfSrUOURWj32mv9Nd0r62CA8Ts9Mz5b5TOmHtaMOk=;
        b=Dejo+nlkvCc9mRGBID+vOx79sH9xDIIx/bT5Wmmi4zqGFuI4WfqSn3po940QC+FuZc
         /2Bq3wG1HU08r93dZ1XekdfdPTtnqtiVP3U93j5mMNyvbl2RXsF7+FUKHvB6T7tFGB6B
         G/16GRA/dNijL4FpoHGsLKtdUkTI0mbF/dBcsuD9mA9TJbe9QJw43xhrc+3vh166cNb6
         CObzXjvqB2ZeDnuLH6soufrcLdNJfz1HtOJDLIfCFLj8c90enZTkVc8bJ+xVIO4barWx
         JdKP/4AHNJadIdpjQi4kq6WSuDtTGBPtEyXzh/J1K2cGnWnIA+uJVjSh7LEny1ZcUZ8H
         Gf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740306088; x=1740910888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bxfSrUOURWj32mv9Nd0r62CA8Ts9Mz5b5TOmHtaMOk=;
        b=HUhu5Wnk8+4+CpfK/jEi+5ZlZlzI/1Lalq1OeXkD1qPrRQI5Humfy1nzeXO5j5zAW/
         KbJKe9kSPl5FXyqNIq0Oq2mdKcZhc3mAF0Spkiw5ZTjEhMwfn3kK/yR7oti0QZ1NEzYo
         2IP7xWTlZB3/M+Ezm8stnX9Lpqy/UscgjCgoLeExcX0g+JlMpT04PBbGJFgbvTdaUy4f
         pJMnVOTS6s8Z+qxOhaX9Cl6QBKTpKsj4DGbn4I/QR9lOaLWPV/33ZIC0kqxyECnmRyKS
         uDT7vBD1I6ma2sFrjH092ROqRhUChiWfoWjzR1QWc2XbarFm8/RUry43LLnwaOAv8MWO
         7sCw==
X-Gm-Message-State: AOJu0YxH7r1ayqoGHI7olxHgQaPlaH69i/T166ssgovlK1NDUQYQROxn
	2+nvDQSmwYm66X0j0NfU+Jfggm+jlL4gYk5rSQEy9U5OKSFLhuS2I8nWLQltIrUtfGyf6ybUrkL
	dUo7HipY9FkTVdCIVgOdBTXoz6RI=
X-Gm-Gg: ASbGncuixy8DiRGgg1wZ5I/Xo27tWKTKxYA5/uVzGPxBeDDUxoPXEZoP/fClNT2D30u
	NeeY1uhcRwPCFhwqGdVYhnX6cbZg+Nkdw9nGALVNJ5aPILAaofMXPHpnLeG+eaK3VdWYV7IX+h9
	6NskYSDA==
X-Google-Smtp-Source: AGHT+IE//QxN+GIZK6aAx2hg42/eIF2H8btpcPOWPgray+5NJqiWstSEhLgDF6YsrfA4rBKYc7ISGEfsB0MmdF2aPUc=
X-Received: by 2002:a05:6e02:1aa4:b0:3d1:9cee:3d1d with SMTP id
 e9e14a558f8ab-3d2caf09719mr87109485ab.19.1740306088517; Sun, 23 Feb 2025
 02:21:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222172839.642079-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250222172839.642079-1-willemdebruijn.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 23 Feb 2025 18:20:52 +0800
X-Gm-Features: AWEUYZmJkJ3lIBLyxFY8x6rCB_vjJRpfArluHRUgZ2ZdbTOjczT3Oc3KuFYftMU
Message-ID: <CAL+tcoAf=6dwcKY+YYYg57umA=0Vo7gVa5ckObZb2CPevx2-XQ@mail.gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: socket timestamping: add Jason Xing as reviewer
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	kernelxing@tencent.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 1:28=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Jason has been helping as reviewer for this area already, and has
> contributed various features directly, notably BPF timestamping.
>
> Also extend coverage to all timestamping tests, including those new
> with BPF timestamping.
>
> Link: https://lore.kernel.org/netdev/20250220072940.99994-1-kerneljasonxi=
ng@gmail.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thank you!

