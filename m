Return-Path: <netdev+bounces-163139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2806A29687
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D3D7A164A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884371DD87D;
	Wed,  5 Feb 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhZl2/Ok"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38341DC9B3
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773820; cv=none; b=VKZ2ou7U25+7yVMm0IfEIROBh7m1P/2uBp6EAFt9sgmepxTnLfq5h2vrlqGGzxeZWHp9bNW3z0I+ve1DJ0GnhN1hUAD2Agnua3TovN8jugUnhZq16GeKK1TIqVTUnIPR1ZTBTngIq608nMEIWCisL+RTbsdByk+XDMC3ieX0oYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773820; c=relaxed/simple;
	bh=1lcEPj4mfazLPKYktUs5yWwM7eINxzSJwM9n75nebf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsytV+6NSAPJBQOqN5yem0jx867aRe177SVPoJqaNDKndNt5S7fC/5YjD17hce4wy2b8Fgi5IxvxzOQTyLobhOllYd1U3ltts8kaTTOoRiISBK4LeK6wPaObc9qoOV9WodAJe1buKESyJX1nG02bteV1PLHkeacoUxv87tyBYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhZl2/Ok; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so52122975ab.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 08:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738773818; x=1739378618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lcEPj4mfazLPKYktUs5yWwM7eINxzSJwM9n75nebf4=;
        b=KhZl2/OkHX5k6fTREFZK3Z+mVz5aFvwDvTnP1YLae/Pvmix2Jp0i/Zfb3Vlzd/hzml
         riaaebu76w9k035jgVa4MvbckRsvqTxbEVHGDq5Te8p8eDEctDgwabbMAT9g3FiVi08U
         c9ett0fnyLwBspK89ST0HLG5rZQxsIM0oNOLClhQ6RAkjjoD6YUeewMO2B+pDyRRt4Pc
         IrrhIGE0LSCQyOmsdSneet3RS8+G0M26XgTWvCcPuJJ6Pr7b/HcX8RM/nfY7fdcNW1r5
         4Orj3ZxcdcB4L5SG6H+prX5BbGRw8Aa31N+BtNNftnHjke6h2wirpNIQ8gPAA9X2hTW1
         1VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738773818; x=1739378618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lcEPj4mfazLPKYktUs5yWwM7eINxzSJwM9n75nebf4=;
        b=L0pz87Du+l7S1giuq3s9zdRm45veMCUESwU8jrpn1KB23DNc7w7vj/djzPkIMnI/xE
         4GiOembmmN4fjk8Tlv8b1PsCofZjIkVI7fKcE0OMbgFjCAOzoKGI49tMHAW9U1fYdyam
         1Q1pw9pJGFjNi54kQh8RZYSEj2sKDE5nK3H3KOs2NzpHNH9V80LLkrR8llqCTlEe554+
         hrWI9G1PkfyHWZOAIJjTK9CR0ew019Z1TOs3DGdlDGoTWucsUNY05/hokV0bTHZhegvq
         6m5jSVtLlKRWfhLacQ79tZLwr3AuUiTsBGnwC/dyww7411tls11uNsoTPxv09zu9uMtD
         OHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqnGI8GJ4e9QedR/yryMPFO0Bq6jB7v+m7q0QdGG1fjuKDaZKFTrvMgyBxdBm597nDsCTyBOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHK5jEi0ilRtpCLNFwzFO8Cp9wRO05pnehkHtB9E+Q32JswSa
	qnMCst7Z//vjULhhbYCtJYu7mYb5ayDleLRmgYDwSUpIMyw+Zkp9VtBgNwiMvDomqyIa+qHiqgL
	4o2wgc2hGkBqpjkrPL1DzWpg9w/eN/SEek0pkuExd
X-Gm-Gg: ASbGncu4QlwloIGJnFwaKit40mb99uFT/HlRi29uIY2wpdPUMo0EZs0oVh4m4o8M9ED
	x2U60fvZElXgQYBkrtvDPFSPiGjQvMjHPVpYlubXNgG6kc9LItMn0a5kkDpLMZrgUdjCm1OI=
X-Google-Smtp-Source: AGHT+IFYjVdE80VF8gOnAqNj0iY33BTLBuVa7we+S2knIV3nA76hWkWy1ZlaUOZPIyurqA92NtOjOckr12DAL7RueaY=
X-Received: by 2002:a05:6e02:20c8:b0:3d0:147a:b5da with SMTP id
 e9e14a558f8ab-3d04f3f7654mr32233145ab.5.1738773818107; Wed, 05 Feb 2025
 08:43:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204144825.316785-1-edumazet@google.com>
In-Reply-To: <20250204144825.316785-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 00:43:02 +0800
X-Gm-Features: AWEUYZlNruO5nNS9MoCHeNCLj6sDlrreF15M9xBEn1a_OMpiWwBaXIsHl40n-bA
Message-ID: <CAL+tcoB=jtXbH9LA_aa6MBHtYpsty=HqCG=cSYNgoHTJDwrnaw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: flush_backlog() small changes
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Add READ_ONCE() around reads of skb->dev->reg_state, because
> this field can be changed from other threads/cpus.
>
> Instead of calling dev_kfree_skb_irq() and kfree_skb()
> while interrupts are masked and locks held,
> use a temporary list and use __skb_queue_purge_reason()
>
> Use SKB_DROP_REASON_DEV_READY drop reason to better
> describe why these skbs are dropped.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks for the optimization!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

