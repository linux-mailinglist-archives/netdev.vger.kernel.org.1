Return-Path: <netdev+bounces-157565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC44A0AD18
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 02:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2245B165C0D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F821A29A;
	Mon, 13 Jan 2025 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3A4bnum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA88125D5
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736730382; cv=none; b=Ni0Sl+1bomF2msZaxvayIT5sNmI9xEFrmeuiKMz8aKEaQ6vdXcuXELWws/kgwSi8QXEc+PcyxAcroTtIWQPYVYnK9OjtEuUfEwxcnZH3AT1VgNVi5/P6goJNDVteMpZ6PzZUS0AYUrf3t5c1L9uOXJbOb5KEuzG4mN8v/qmqYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736730382; c=relaxed/simple;
	bh=BpGq9jeasvfbEQ4rSYiSaC53HE8oynJpeDP9Jk48dFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRB9/Gd/nLCzipCgrT0t71AK4OzbzesQtlbEt4rZqOf1auP0IQ487KPXgF8D9p/9WTnvxryrfWG4OFMhDD6IPrr52hw2MR5YrynIMXDhtTJjkTCUMscnl15DbAfcZy0X/thKh4d77uMMhVWtYEJPQQ4NHTXYPa3CHW9HgYXeU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3A4bnum; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce301bc718so29037725ab.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 17:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736730380; x=1737335180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpGq9jeasvfbEQ4rSYiSaC53HE8oynJpeDP9Jk48dFY=;
        b=h3A4bnumgNxxE+HFY866WALKP3OZfHbZkscneAn/PnPeZh/3QbVsRboAgKDel9Iq3v
         85vniGE4nfqwgd43jXiXNVGUmYo7eXw+O0IRvpwSjCGww7qOKxEu8u7VjOMaz6COAIEF
         y5+uVZ27O1BBd9Nj0tfJZ+Hm7UURqadWpwSQCUeOrPmiayskYisDM12TXoF9RFaY6tdm
         2XLATKm2xL/HmmzkWyLlPdAg8M09bV/fhzSgtCXA0/1/Bx5jQP0wK3SrHhYgiZQW+E6W
         GqgzUiL5QKsw4ktHY8ag2v8KXbKaqXfnAobEivmqqQw3p9WgV97O6NKri85q2UxbcHm5
         uLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736730380; x=1737335180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpGq9jeasvfbEQ4rSYiSaC53HE8oynJpeDP9Jk48dFY=;
        b=EAy+dTnn+JQI4IUTP0nxy3GLn8W4I3Ltf1jJfxo09iQ/QJOHQriu2wOCFD4OZk5Yrz
         yTJe9mJ1HreqczEaETvSUR/pVfkCuXo2wMFtcp5+rlOygLThCDiwN49X810/7HwAWmsO
         B/EA6gh5So+sNhcuMdPRArkKf0vbjuvGsl5cfPU0gVC1zjSJg/H6at401UeY1t3zEQvc
         0XvdZwd4C9Av5xR42tX2xpFv3wDVbuYMerqA0I98AvYmVVSt7bZppRk9jUI9G/XFrYRq
         BSiyCQm+Y/98f+jo3o0nPjybAV7nuPl6jfYcUrslIx6HM0eN0b5PRIKr6kSHpQwlZnKh
         s6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlveO17qbMtweOAb3K4TsHlEONqpFqODrEGW5PEQjmCgFx/xSMNi54Eyi1IPLpDRCOscDN+LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLltNStlZIIpto1KczWV1Xw/myNY8ym8PI2DYvXI3ycCYgdvy4
	+4ZGJF8v046IVld4nmZplQtusR1VFRmW5ucn1XK7ziGwflAt3TjVdaOu2kqIbbmaqAV1ILHj9zx
	G45YE4KOOYGYjydJ82eLA0Fha9Ng=
X-Gm-Gg: ASbGncsA27lIheKF/rB/VTjeMDavwMGC7SSG752WwL9BtzmjnO6elxCc0NPRca+2SUw
	7jh/jVfZsxxDPANK8paKHzavgd2xrGyz4IZ3r
X-Google-Smtp-Source: AGHT+IELSeEbc1aHaUsRB1E33Ba7GGu66fTyr2d2lSPPm2zHK7NxVDr7YiAmrv3NNZS4tuW8QfwWAhA9w+KX7ry5Nl4=
X-Received: by 2002:a05:6e02:1d06:b0:3ce:647f:82c3 with SMTP id
 e9e14a558f8ab-3ce647f8730mr51150245ab.7.1736730380581; Sun, 12 Jan 2025
 17:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com> <20250110143315.571872-2-edumazet@google.com>
In-Reply-To: <20250110143315.571872-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 13 Jan 2025 09:05:44 +0800
X-Gm-Features: AbW1kvYGvSbYUCs7Qr2Cawzgc--XcW6BjDesvJIDZSi1vF1UlomtsdlgUuvK-QQ
Message-ID: <CAL+tcoCifAeP2Eodva8AqA==P3oGZj7ropCmQAOfM4Hc_v4JCQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: add drop_reason support to tcp_disordered_ack()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 10:33=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Following patch is adding a new drop_reason to tcp_validate_incoming().
>
> Change tcp_disordered_ack() to not return a boolean anymore,
> but a drop reason.
>
> Change its name to tcp_disordered_ack_check()
>
> Refactor tcp_validate_incoming() to ease the code
> review of the following patch, and reduce indentation
> level.
>
> This patch is a refactor, with no functional change.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

