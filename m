Return-Path: <netdev+bounces-93001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBB28B9984
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9009F1F21E39
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F335F84F;
	Thu,  2 May 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pq962d+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB254BCF
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647525; cv=none; b=iXofhzz466cd/EIGm/1lGsiAJuX4ZD8k/iw1KXS7K2Cf8RCsA75RRgcFjheLIGG3mfp13DDH66/UmR7Mv+zgDkwkahiVTaTdQtH9c8hkPsAk/iA02UhErCMNq3wOveG5RWjCLJ6+gU2RfaVXAbrKJeIte+UXjG81vESQlIPAbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647525; c=relaxed/simple;
	bh=ti0ouWJHAwbLC+g6TCd2UFHI7N7nD8Gd/HgwX3mScTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVEba1WeYoHrM3cZbpB8mmw7GDbfGVcucUNVUB4Sni9FY8f8xtkRGGhtbAdyk7DzTSvaEQrST+OKgLECxDdCXK5YSwy8CnIdeGe10fja3vCZcX1LOw62X6cW+fRUh/st599xuVd763a/iRZmU0lk1tv+wvnEsjXuwSaLDpNElMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pq962d+e; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572afdee2a8so1324a12.0
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714647522; x=1715252322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti0ouWJHAwbLC+g6TCd2UFHI7N7nD8Gd/HgwX3mScTk=;
        b=pq962d+ewTILyCP2bKQX3Gvm2a+0V1X7IiYPX4MDvDaxXqRv06R7sKL9mq7f8HZ4xD
         MMm3Jazisuie1XxAwv9HMOfBgGraedgKz2Mxm35pCBDB8+TmbtMyK56+Vb6ePQN3d5V9
         HxJ+E0Vg9+CKOhcA26RQ6M3EJtAGsYc2qTADjF33Qi8JH5ppnTGRlHkkFAEjhjJ4vgcy
         2dPeq9vKzph9Kb9SQm12SHt8t82BihQBBNUZ3q1QspXcl0+JEm2Taaie5LUhe7NL5jxD
         cA2Ja6aCELyymNIb4Q2DEz/fstUR7ZhiO3qjJHnfFzLn4PwnwWZkIIDo5cEXAzz1kSrq
         kybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714647522; x=1715252322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti0ouWJHAwbLC+g6TCd2UFHI7N7nD8Gd/HgwX3mScTk=;
        b=r3bjwOzdcL8PKoF72ZJFma6jaydU5MMzujivTp2tqgEMemzhc4oGyD9fAzmjbku4Zj
         fQhjlI+DxUBf28pKFnJZJ8XQQE2uybU6ZhqqSfUKswmY+vn32Exzurr1rCVZRuvMuKWg
         G0nhH5jvtP2UFdU1orL9+/RFqU8pgRfcRsjfjQEpnNNBpctdtuG0dHYlcUnwRLiTZAMo
         7ye8R33H92Hevzkd2lE/0q2BBy3rWQeKxYLDLUOCbnQrTqyxza9hkLEdGJCAIqOyLuSy
         z7su+BkellousMbuQBahFjuMJo1JPFrJAN8VdrXevOIt6gsFzSUu09fcB3Qx0NyI19OL
         gZUw==
X-Gm-Message-State: AOJu0YyNz/Tc9LJuMgCq1jcQ/2bxalQB3PlG83W+BPtH6ARm3gIp2Zzb
	vNTeCZfyRIOnefubwucNsw1pg3wJbhBuZCzj1dtMDXAYIgioeJl/59K8AYgP1KEAd9MPByj3uCf
	BTYxCyswHDximnm2tN6sbpVpadyAgqEEBqMyh
X-Google-Smtp-Source: AGHT+IFRSe4PucIslK+BGM9vZ9APHFpXULwivi+bdtDezpxEzGPf3xkvdjfQ3WN2cF+wpM/yvRzgtwL6OOEjqvLZdls=
X-Received: by 2002:a50:a6ce:0:b0:572:a1b1:1f99 with SMTP id
 4fb4d7f45d1cf-572bdb3ae19mr112653a12.1.1714647522208; Thu, 02 May 2024
 03:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502084450.44009-1-nbd@nbd.name> <20240502084450.44009-4-nbd@nbd.name>
In-Reply-To: <20240502084450.44009-4-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 May 2024 12:58:28 +0200
Message-ID: <CANn89iL_=fn8TuH_LL8u1empT30PV25zoe0+dSaTumAEYF+s3w@mail.gmail.com>
Subject: Re: [PATCH v5 net-next v5 3/6] net: add code for TCP fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 10:44=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> This implements fraglist GRO similar to how it's handled in UDP, however
> no functional changes are added yet. The next change adds a heuristic for
> using fraglist GRO instead of regular GRO.
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Eric Dumazet <edumazet@google.com>

