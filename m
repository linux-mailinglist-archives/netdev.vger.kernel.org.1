Return-Path: <netdev+bounces-224889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B78B6B8B3ED
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC34E04A9
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE1229BDAD;
	Fri, 19 Sep 2025 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+hpFB4y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7E223702
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315185; cv=none; b=mGogs2h/QJjgpjVYQ//uCuZQ3u4OOreePSnIw68jY/0wiTDWix1rAxtT9eaBN2ss+1N94WiPeS4C9+L53naQqFiQb0GHnN+StzbLoS64Elv/6nYORju+e0ZhmmheCY+3Fb5FkHPhgkym1r+AiAXuDRDZZxgGZ2w/Y+Yf3iql0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315185; c=relaxed/simple;
	bh=q8RHcAxWcv/XmGLJtb46lwNxQK4upRzfYuxA18Xvy4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfJLJuSrXGddqBFXTHFunBZA7nM8O8qb+2A69ppWFOHpnxHcXb2Upk4m+M2FavrMzArI3T/PeZRC1L8QeYF3m064MoEJQUcR4lMWTBDSgHm1ojZAwEwPtXuCcetaaxPXSrIzLFDuFEt82sWumZwhU5cFOSKKJ/3kJFFP8mwG5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+hpFB4y; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b61161c32eso37484731cf.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758315183; x=1758919983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8RHcAxWcv/XmGLJtb46lwNxQK4upRzfYuxA18Xvy4I=;
        b=H+hpFB4yBPoWE9JJW6dVqBU3vHxPZM5aylKfldKBV8mMJqCYaM9h0CXWcFmZtKtVmZ
         qz5bBc/84PNnP+FBedT6JWKnu1bQDlwLwocc+WPGw3s1hU0hRKH1O/iaEV78f2EmoMBn
         YhJJSSa1kHOxMqpJFORp1X9XoykJyp+8P1bdPW+EKXhSMPPWEwKKmXWcH7SVUJfNpXaP
         GJRxHKVskWieWNJiBx2LJpffEfy08Giprzrz8ynLtLqgoli7Ud42as1CHb6ob2h7DIaO
         AaIBlbDno64H7ePnd1M5ddLtnQLpfwPdOHcgsUYVU1aaHIx+lMDXPlKGWcKw5fVvx/mH
         EWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758315183; x=1758919983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8RHcAxWcv/XmGLJtb46lwNxQK4upRzfYuxA18Xvy4I=;
        b=wTgJDAu0aIVNVj/ynA7INYD7w7HNxB/47Pw6UuAf+nTiWXI+ab1oB8fBiwgYx8EVSd
         Yvs9jSS4hK8BoXdIc5wT8VHPqPtLafSNdVzVw0zgneHoH7GTvWp4o+QjbfKWJfMie5ht
         DP49Z4HcNNfpy/um80yeYyzJIdNhLrLicWg8Zr/Q5L72ym/4J6CMAjxwTYUWiMZTj2An
         JJYjFntEkAVvnEyBll+kuIJFTnLEZ098XRTbTcOdmCRnGgVV4jTtB1fZh0KMQGFv4QHS
         rgvx1qPUaNP/sBQpE7N/esGOLUYfHYSKlqZDtv65oZ8k7+4QCH5SaHhaqzorEBV2DyfB
         xiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6l2aXGLudXyB4/948+NH2ZpC1jGWiRSEk9Ofh1ejQtJEaXqYEmxK+OSgR13rtIZpAk1XP1h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2R3Y6VS7kz+UBz3gCViWllymDOCVsQXVzkLjhDq62Id6E5giW
	QvuWqfd4+WIQauXwTRFpAWrWDjgU9FCkPfytWz+xWu2QSRkdlWOkuo+h/VtbNM8kg0UpiH8RO23
	rOMP+ILaIADjuFESsN3ezELS+ShyVDKbyniQ20A8f
X-Gm-Gg: ASbGncsgTY/cRuiNgD2aND0nFEuk8305G5TCZetiswXaFl1JMcTgPOkDBHtqnJ42lZR
	KxWlR1zIBNon9RQOPEB2EM6AjMwCv9gf3tZem1Lvqn47g/11NhcK5I/kpvY+msE+a1kpZdAEOIa
	RyqOswRy6WeQt2k8SwtZeBcIoAmrMYNTwMLsIFhdMHssyoBUC3Czvda4GZjf4tmegW1J96P9IOv
	Pg3Ew==
X-Google-Smtp-Source: AGHT+IFKZlMCXaGU7Bo853BctBzU4QWZKlPsa+OhIoLjuZxYQzfhyhjbJVVcJus39q+Hr9mEWppomRl9OGad1zKTdWk=
X-Received: by 2002:ac8:5994:0:b0:4b4:9169:455e with SMTP id
 d75a77b69052e-4c06f738c26mr52552061cf.34.1758315182462; Fri, 19 Sep 2025
 13:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919083706.1863217-1-kuniyu@google.com> <20250919083706.1863217-3-kuniyu@google.com>
In-Reply-To: <20250919083706.1863217-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Sep 2025 13:52:51 -0700
X-Gm-Features: AS18NWDH5bV5VLK8z46IBe3kRmhzkNe5fiF9M1CVL2geZYNXkwvU-jkaRjP2DQk
Message-ID: <CANn89iLzfu_rxbD20PjjmsGW38D=M=Epua5yAB+S6tMMf30Bxw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/3] tcp: Remove inet6_hash().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Xuanqiang Luo <xuanqiang.luo@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:37=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> inet_hash() and inet6_hash() are exactly the same.
>
> Also, we do not need to export inet6_hash().
>
> Let's consolidate the two into __inet_hash() and rename it to inet_hash()=
.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

