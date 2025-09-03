Return-Path: <netdev+bounces-219604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2AB42468
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17131BA0E65
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD5D30CD95;
	Wed,  3 Sep 2025 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyiyvHa4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2D21423C
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912066; cv=none; b=jN1o+OYH8bIP516HU4baTg+EY6QXQc7UHjK6Vk6KtLVXbqleSTAjE09ve975mvLajvIBteUYrZ5s6DFRlB7iTmWxInpNNeLhH4CGN8fjYZCaW2JaA8nWFhKlWyFSLmpCwKTFID6OPxtXsCRFRwy4FJZp3YgaXSimnGsP4852edY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912066; c=relaxed/simple;
	bh=dkXDWvvJw7QxfmkfXoc6nGsyQGVDNL2T5/mSaw32hO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnwYe1gaNqZ/WIF4r83iYIeOm919N0i99GfgcSU0n76Bv/5xOW+SNhtmJfy6+EXSWZWN00IMM6p05791phf5DpRobB7Dbv1aEXsvR6p11k+PxI6J1zvjm3MsIZIMRBCxrGNHKm0hbpSQ7DENlDMlggizABMq3v4hWRcP684HYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QyiyvHa4; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b48fc1d998so317391cf.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756912063; x=1757516863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkXDWvvJw7QxfmkfXoc6nGsyQGVDNL2T5/mSaw32hO0=;
        b=QyiyvHa47HlaulYtlJBfO1pUNPeRncj7H9zWSjVxdcfsclvDplQf5YoPwjwP48VS0G
         jwfWn0f+d9j1azDu8EyeOJVkJZXbQUeYwRnbAe1CC5XVCqjaLJbl4iv8LYLB1L5Jm9cV
         SDROdzY6vPJq35ZFdDrybQASKnNyUEMvP+N/rsHaz0PLpa2xnU883m5/jV5BM4oyUCIV
         xmvr/RNznR27iviTSjRFTY19EJFJ8yBapqARIKYIHL1JUqLTHMjFoloqBPhzgOMpT+z5
         6gkgKMhLwBtIhdU/+kIGWkN5OcSF7QjtLmvsw8UrU/BbfyqNJNAKSxipwMP0Bb8KPP46
         DGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912063; x=1757516863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkXDWvvJw7QxfmkfXoc6nGsyQGVDNL2T5/mSaw32hO0=;
        b=nHp/SH0ud+7KjCY8Tzj+WQ1CGeOMU2MtGfjgUgxl968cBAcRv2YCOatoR1a8JTHJMg
         uWbjKf1WqyYmXx4G1lxPHWaR7iu3rS+QY1fH01swE0Zw0e7TgfDxLTO5XbusREj5PCL7
         jMsyaTz/zWZSITMuDdsQYDy0gO3bQZCepHv4zwOpcXK0jZbd09DJdlmkTiqvgsxnDGLT
         eVEv8MixQvZTf8p167DHGnd0mcfZuGlEVSApIQQJ1FEnwAUklbX+7rTbLm/8UP+5MESV
         V6+AABUIKaZISvl47B9VpTsuvuwXjdzE87Ov3C3G5vXxHaP8gx0E4tD2XGbLAcjiwuEJ
         Hmpg==
X-Forwarded-Encrypted: i=1; AJvYcCXi3Z5RM0j7dbMEZwUB7TQGc919uRU+DLflACC98VED69CGt83ghb6m0BZOYfyfzZyX+1pNw6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqKr07jrvOScKuBM1c84xax+AkHZQJwQgaEPRk1I1UH5PmYk2
	xx7lNdiwjEVyMvi01dvmu2HaKHYR01Z8lhkajOvouCv2tM63s/lsx6F93ddigVvQJ+5KXdjCO2y
	mXrJI+TXXFcrhG9/WSz7p6mu/gBrUOQCmW9T/CQxl
X-Gm-Gg: ASbGnctnHqt0YdhISD1sAnsMqnk84i3gu8nt9bK2RjVO+8uo1K68gKZ+CYO4HtnqDIo
	S1bd8wSdoVVtW8gvKbAeS/3lqpfIuEQjTzRoYLcyx008y3WCMlU7q3Le8A1BWfth5NyFWvy070s
	Jv0wN/wB9lv3/ceA5Lgdz9C0oLe384A3e3xeP3DYlmhZIGI41ieMCvN+st0CkbebAfJl00Vh2yC
	WDTvpoMMavIgTtG57tUPSkUhqZEOCYu8g88fmP6xpwO5D0uEm4scGdU
X-Google-Smtp-Source: AGHT+IEJz2DegyWd1VbqL+QSOJu+Zbs0CwBkxH8+UJGvtP6oJivKjjywt3lHInYP0Z9oPvG+hpJIMVWLMwR2HZmUBoY=
X-Received: by 2002:ac8:5710:0:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4b31b3663d0mr23272101cf.11.1756912063206; Wed, 03 Sep 2025
 08:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-2-edumazet@google.com>
In-Reply-To: <20250903084720.1168904-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 3 Sep 2025 11:07:26 -0400
X-Gm-Features: Ac12FXw6V1pyECLTfAV1AaeGheaiKy69KzBEh2E7x3rL9__MglpQuCDNI59iu2g
Message-ID: <CADVnQykr+OfAHHV_qdPwhYM2psAtRpdKn8cD6=aR1Pz+rZuyhQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: fix __tcp_close() to only send RST when required
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:47=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> If the receive queue contains payload that was already
> received, __tcp_close() can send an unexpected RST.
>
> Refine the code to take tp->copied_seq into account,
> as we already do in tcp recvmsg().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!
neal

