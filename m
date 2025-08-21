Return-Path: <netdev+bounces-215655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39672B2FD3E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2D6164E3C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9722E2DDE;
	Thu, 21 Aug 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4PRjRlt5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1471EE019
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786502; cv=none; b=sHTO1SO0RAttCBQNftGbTmVR0WfIRixICDi7tZ1ZaM9/DkhAY2Bzh5+JUj3Q4iGX/rI2+oXetUNmINClhZQv79uWTSyeHrYndL8+Za/dwxdYwc2lucJ+L0bWs2mo5ejWMKMPBkZJ5OdPWkiVXMpKJpSVDOVGqJmaNV+D/aWUx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786502; c=relaxed/simple;
	bh=Osw2o2AW9afeK12NE6hse5EtuH8xlV/L/bTy4tw9qAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1IbOyNWpuVq096QpSZ5yXl5hySSJSBqxuAolctrDijB9SEN8xhbIysfdPknQ7PDujDqzCHfzkjv78HbTQcCbTprmX3qDZogIqDBt3Lf5qjQj4+CzPQMkOe+CmuqPx74MdOEFm9mulz/RfbHVu0yXoMGxe3P2gVViWXDJf69K3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4PRjRlt5; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b12b123e48so351971cf.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755786500; x=1756391300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Osw2o2AW9afeK12NE6hse5EtuH8xlV/L/bTy4tw9qAg=;
        b=4PRjRlt5NBhldeXFPh/aLionv9H8dwPioREqfWsEMui9jIynOsnAxgZZmZ2oLT1yd7
         j1CMEwrjn1wCJyg81NnuqK08Exr8hLQD2dpSFqoP4skmUCs9out3c4NRtaR3vsk9NR1X
         DKAWSXghhk0f8M9WbxbxjsMulT8JTG/Tn3QET6vjgCwLg/ZYBQu7bc0pXCOnFs6wqDWt
         JLckGM7cHdwfRgQsdmJeia24QXza5ggMnrLmfL5DBQQMO5IYZybZ/q7/Bvg5c3+qMQbk
         3SLCRbfzbflsRT+EIn0OcI4o3D8PtyniTpISft9aKJUb+rYmPDOOztrIFfEJs56DhxzO
         TT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786500; x=1756391300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Osw2o2AW9afeK12NE6hse5EtuH8xlV/L/bTy4tw9qAg=;
        b=heWEKYAklQkkepp6BmGPz05T6dS010Pp+gt6QID7NwFic9KN6BcqgGOWySeW16maw0
         7k+CwmUyb3dadLn2xv0I8UoE6OyxGDpAQASSQlD1GJf2q0+kwFYbrF/aAXaFvWrL1UJ4
         8mXf3BRs/ZPniX48hDOLGkXXhDDhRXiyLBOBcOxRkAbl2Tz9rdqYDBkRbZoXDHbGCMjX
         FKjyeLl9aPgXnUtCRlPihb5ZoWNEZSWMr4b1pxqLbWHB1FgZSK4gSI8HAqmW+YsQyvoF
         xczTlY9SrJXH9eKJmBW/9eIcHBdPo90R65YP7c223G/xOCxNNvkWcOcyp1rrMAJ0dd1H
         Y3XA==
X-Forwarded-Encrypted: i=1; AJvYcCViirukt+Q4Y8B1PmPQExv6sWoGFTt4M1dNY0qZb2c77NnyiFi81ym85BSs6kGXxeemsl09R80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuzqWHOq+oVlXw4REuf6tJ/c9T8UbuOODMqBD4SW4/H91eiurh
	W89H9TcdHkD42xRGJossSKmyfPe+BqxuyBkJzyqph/DfK7iSiKP3RLq4KPn4y7nrvN604QwmYwh
	XcMP0+8PVkmsHUoQZJrN1RTdZkt3MHXWiqufp0F/F
X-Gm-Gg: ASbGncsklqu9HVRtZ2M4zTxUQUd7/5RleaJ0Zx2DOx54rnXn639YCbO8a33I1tHadIe
	tIvyQKRLh0qc/mMFAdNovkDtELlQleABZgPgy8xYlQgMaorpH/a7D8d/OySp8gxiGxyU5H/Apyr
	L7nqS66t5yN9ZY7PHx8Usb+46oOV77g8usAOHA8bYtvcfkHrCC9EkrbI+sm+mUuIg74Pv0kV1Ro
	pQzIQYTxoL3kUV4eJcdWUOq
X-Google-Smtp-Source: AGHT+IFYKJsKRQOIOdBKtADhkjitGwmqd+HTNnwPRHKvhcgV8AKneDd+pNCCon2r6IF5tdsfvL1Vbz9BIqqO31fE5X8=
X-Received: by 2002:a05:622a:24e:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4b29f779b8dmr4065081cf.6.1755786499808; Thu, 21 Aug 2025
 07:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821141901.18839-1-edumazet@google.com> <20250821141901.18839-2-edumazet@google.com>
In-Reply-To: <20250821141901.18839-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 21 Aug 2025 10:28:03 -0400
X-Gm-Features: Ac12FXwAbRCFiQmDwEzyZOa-J-YUIju9b7ngAD3FVuwS2ZIGhx6qdKVukWl68_k
Message-ID: <CADVnQy=m_mXb8pgcnUX0_H2FCAp58HTmhnESzQg78wXx9swaAw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: annotate data-races around tp->rx_opt.user_mss
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 10:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> This field is already read locklessly for listeners,
> next patch will make setsockopt(TCP_MAXSEG) lockless.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

