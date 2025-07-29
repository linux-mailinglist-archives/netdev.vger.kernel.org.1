Return-Path: <netdev+bounces-210831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AAAB1503A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEC73B3236
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB427293C71;
	Tue, 29 Jul 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWtGnmGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D8293C60
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803372; cv=none; b=GNq0VwMwUThF4wBP9CKk2gF8PIyZRy0O3G7Jbn1XTYm2jwAavBDDc8Ikr3fpU+rzUyFWugaVlI/DIumihT9r/XD49mLTEla/SW6JliLdsD2dduofOXemvbej8FgyfNF0ngXFufP/KvCZzARq/NaKockCmKTp69AB620xqu0ofVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803372; c=relaxed/simple;
	bh=5wduhGljbre2Yt9oPZs4+A80kEKdKOiR1YUtmgLhiFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFobiM+BgU9KzxqSGlV2OjYXihQyB69QPlU42lLvluE4KAstou5QBPQnM1fy5FGOqzdJtKSsLA18cPS0oU7vdwZDWsKUsPUdLMRWXXO5U2IJbNBE3yl8VOS2wyYXtWs2PAums/Kixid2Bf1EEbMQve1rCboRMr/5meAyUytRw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BWtGnmGk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24070dd87e4so110845ad.0
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753803371; x=1754408171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8/hmqbN/GBW8ukvStLSmZmzIq7CbBo8JDmoAI3fxd8=;
        b=BWtGnmGkxcsarlvmsPrLKFKWbyU5L6HVKNe1AXlw5U8QoBs64m62fBvxlz39V1xR/Q
         saBHG2FxKc4xPH22Gw5IzoxHyC0dhWfwDXywpUOeGl5A9ru0HJwCZe1mrD7IG26V9wJ6
         YwjPUbpWyqDKRN6/Mz5Lc8FOPEYsUNLdrXA4dBi2QGMT7kXN8euq4q6QH3r/mRZBA2uV
         /wPFcExX9bpiY8EMtQ8el4/BBBNT6zCDrN7EA8QnQga048uZqaUXNPiaYnydyuMTeBUi
         7rZCUDrIodt0ckz33AKiJ1GOlTBOudMRftnu1x3qZ9fJh+Rs8k33yoWrOT4aqqnOYTR7
         UZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753803371; x=1754408171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8/hmqbN/GBW8ukvStLSmZmzIq7CbBo8JDmoAI3fxd8=;
        b=K8jsZNwYBgxUL+UUDeWNzcFMlMYt6XCuqJwTobaeZUPmvx9S6kUIVTZSXcFcN/ERox
         KxQPVgVFymoSJ/NvKzc32371tPyt098ORI5fvABxM/Q1PB+kl/JTPS6qxqca/7aihrDa
         9oXZ4Yuba3Q0cZDvEiTQQfKIjdBIMd8XzWd5v+3LgqM8jSgnALpaDGXqhiQsj6CORbUL
         3pPjKmCS7KeBjMYhIGBy+h6fvSJFdGbuT8aaFBLOb8ljnVEBeZJX9oBx24FfusxqWTLt
         dCh0GUwT6l/7rxBk+VJUXf8fXbxWffMYv4QoZfVJMPHA9rKHMo7heElDr8jP/gTcrSG1
         bFIQ==
X-Gm-Message-State: AOJu0Yw+f8Zx7USTlBs3jm7R/640tje7FNTA5+cYyfD1jgKSPOq0cUoW
	ISib/p63yZnaWurWmEqn6azYSpR3uwjCi++/xob8f6njmG+i9hSzCGO5XXL3UktebpHSIGL6AJK
	LB++yQS+Ed2ugbIB5oj+83LUd4kSiJgemDx/uhglH
X-Gm-Gg: ASbGncsg0bWuXI3DXMcNga0vvIJq9JT23S6SG2yx8seuCgLYHEl4nw2XthUPpS5VVTr
	tCe6aeJDSCoiVK+MtlDzx8ToMVMvCEsodTFzzP9kbi8pm/bWvWpXAJye5ZsRvqFIFRMA7/Pzm1E
	F6vF+o0ubCaVSEAy11IhS0+uODWipTLh4YHY0TOB6NlWSTItkPgAbycMMM/SJHxXy/QRnQOteJb
	OxDVUa6
X-Google-Smtp-Source: AGHT+IGIu+susF+7hiCrTHXE3TP50hiAGrBcGKU+mzfzf3q3nYpspnf34goaWoO824Nb/GlJV8bte55ulYe7nFFO2kk=
X-Received: by 2002:a17:903:1983:b0:23d:eb0f:f49 with SMTP id
 d9443c01a7336-240679824c5mr3546425ad.14.1753803369375; Tue, 29 Jul 2025
 08:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729104158.14975-1-byungchul@sk.com>
In-Reply-To: <20250729104158.14975-1-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 29 Jul 2025 08:35:56 -0700
X-Gm-Features: Ac12FXx68rwygXHJ6QoCP-sZ6Qf0MW3SVGVkhhf8cIue2-rPEB6ie-D_dohd1c8
Message-ID: <CAHS8izPonS7WbDF4BpX=CQ8kFfqjfSnXMsrrS6ivyPQpQqqs7Q@mail.gmail.com>
Subject: Re: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, 
	toke@redhat.com, asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 3:42=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Changes from RFC:
>         1. Optimize the implementation of netmem_to_nmdesc to use less
>            instructions (feedbacked by Pavel)
>
> ---8<---
> From 6a0dbaecbf9a2425afe73565914eaa762c5d15c8 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Tue, 29 Jul 2025 19:34:12 +0900
> Subject: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with netm=
em_to_nmdesc()
>
> Now that we have struct netmem_desc, it'd better access the pp fields
> via struct netmem_desc rather than struct net_iov.
>
> Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
>
> While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> used instead.
>
> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks for cleaning this up. This bit of tech debt was bothering me!

--=20
Thanks,
Mina

