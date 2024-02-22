Return-Path: <netdev+bounces-73975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CD485F842
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861D91F24219
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2E512C809;
	Thu, 22 Feb 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muRW72nl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E17CF32
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605178; cv=none; b=cO8kj6OKkqtzarZuTVv3+Uh8eddRdvYDQOw2yPWzqPesZyho20Q5HXdUlhqYq7k507xCHWLhS0Pbs5KodKR6F+Ne+lane/zCSFIq44WOde8ZoPAgLjYqFaLbSrCyadSeGxzVq+7qhHsfVO6Y1783WPRtGx5BaPeNxwoO55keEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605178; c=relaxed/simple;
	bh=9d6nEfXhwvNHm2s27Bi+eNFBLAEPHACv1E1hBdvbTdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLBmledWLJbkHm0T8sDso6EihVxAb/y15MnAF9busmU76RkG0Tys6LBM1ohGUcE4Roaxj53tdUbvDeRgyo8CJF6RU3d/Ebp2kqRm0q6WEBcVVhMS+6TLshmN1bKnujRoWGVtfuquS5THjQyqelivf+WHymV/efPox0RjBpZiXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muRW72nl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso9221a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 04:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708605175; x=1709209975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d6nEfXhwvNHm2s27Bi+eNFBLAEPHACv1E1hBdvbTdA=;
        b=muRW72nl/5LJw94MgKr7gEHSMtUN15P8yM4zaV68fgjjTTHvxIZuEPZNCv9/e7vboO
         cPyKAD7imdgVSrFBc0VSKrbZ5JNvSL2wGlEE2JPYAzDQLmYpzHCvVBkhyl6k+Vs0KrEo
         AHJNsn0VK6b7xlSKzrXcLHI1OVLOQmSxyDxus6VR61J1TDy35PzZFjDhp59OPVTcJ/eX
         IgzmEFxPi3OSvyBuutRoclvTGMhZ5iP4HevevJVyo6Aq5oxUR2I+5NE24sPATk+hXFUu
         cd+0rk+gtIJUquPc1l1h2Oo0aAoNCiNdEL1gsSDTbnsY6m90Ze8IZ6K6y+CF/NXAtgT1
         S50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708605175; x=1709209975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d6nEfXhwvNHm2s27Bi+eNFBLAEPHACv1E1hBdvbTdA=;
        b=mZpG5R9ZlxK0ttAcxJvT7Z7UFeC5fzXkBu60ZXAOCI1YYDymj0cwKV1oZBUpITxBQU
         urHL/x0U2IJxgRVhQQwsguB/iwyhkdDFBZRL6YnSnAObyYfNzglPtX4ThvWNGLn5Dog4
         TM2DGkMZdM2ve/8uChpbKbdR9tm5/I5fP4MXmxBl3D54mGN/jEWW+u827+D+x/9mw36m
         /x+3c2f7672yLysUP4NAzAqM36mIS2GkUduRCM3BOTMhy8wla2Cm6uUuNupaVQR48/GN
         u1dc85rxun39pDUp71nTQe4Ua6gkTIHjzQVpESbE5IlwVB7xvpWvT6x4/WOJc8Sm9xxB
         +zig==
X-Forwarded-Encrypted: i=1; AJvYcCX4pQ8l7bDQ9+Gfo/ChauoeeEcsKyz5/kQcoZMXobJpu5u3G+MRSN4FrOAIbfA7XmzLQkSiYsYAY0kvwCsBrn9rQ8jkfo4u
X-Gm-Message-State: AOJu0Ywe3HQ1pZuEcVlJZdnv3Pdffmp/+//fxTb5qbafw+bZFV+sASrc
	2KM7gkEk8M9KhCPCaqIM/nJ1hzECemclgky1namd/0+QQrN1BrU/ZRZDI1bQKe9/I98po+UyEOj
	R5o1DJBtKswc3kTd91NcU79g776qOCnm3Ayhx2qfxdvpmKRsW54KE
X-Google-Smtp-Source: AGHT+IGTR0z1t+0DSx38+hY9b5dtlC68tLgGv0GNBx9YIZRMspFA6FplV17ihbPs+cHDolCNQF/foggsHxGJCAhCoM4=
X-Received: by 2002:a50:8a8c:0:b0:565:4c2a:c9b6 with SMTP id
 j12-20020a508a8c000000b005654c2ac9b6mr41729edj.0.1708605174684; Thu, 22 Feb
 2024 04:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222113003.67558-1-kerneljasonxing@gmail.com> <20240222113003.67558-11-kerneljasonxing@gmail.com>
In-Reply-To: <20240222113003.67558-11-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 13:32:43 +0100
Message-ID: <CANn89iKE2vYz_6sYd=u3HbqdgiU0BWhdMY9-ivs0Rcht+X+Rfg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 10/10] tcp: make dropreason in
 tcp_child_process() work
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:30=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> It's time to let it work right now. We've already prepared for this:)
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

