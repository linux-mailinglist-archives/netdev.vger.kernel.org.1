Return-Path: <netdev+bounces-164294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5807A2D41B
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 06:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A2F188DB0E
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5AC155A52;
	Sat,  8 Feb 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5LAMwOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70017BA6
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738992782; cv=none; b=GXv+DqoAye8BY2XuQEuYlBADAfw7sbRNWSInt3QZg2aTPqogwRQr940ycTr4tG5SeFYkFGElb/FB6/05C8hAnXWyGnuQFLUWOG467L8YoBiiASISBTY13TN3leMH+JRR1N/6xkPmm0g+wNtudKEluQ4YVBAXwjqfuzC2yVoyhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738992782; c=relaxed/simple;
	bh=AUZVShsJDI60YDAm9rsEXMD962wdaworZB/gJ0ghkXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oK9CAhViKhTmmDKBE017KrijT3XViC8xIj1XGhd+uzC8mG/fgZxlSsNls1h2BwoNcJ9kGzDWSHPFCnZDfpHbpnlSv2lv6b1kkclJqrtImg2SDtyaFPm1amakZ/YPaC4KKxd1jPNFt8TYu6by6JjVGQH7WQgyvlgAvC6FSJ6SkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5LAMwOb; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d13e4dd0f2so11866695ab.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 21:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738992780; x=1739597580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ubxtTFkK//oTlnY4r5hIsFvDmokSz63VEkbV/n276o=;
        b=X5LAMwObpvxRb9PJ0tYIr5hbLy7QnFiiS5jYLuJXw33c+ViyDg+YMrQEmIdMbfKiW3
         s0WCg3A9SZsc9Zh+hQWn1ayTefeIUr8jv9wQp+jp64zS4mE4roOyWxInG/+HtZGBAbUW
         ha8jjWYgu5+FQDTe1m0TuvjJusGxxpiJWMtcGnQaRth3FXLFpNig1wSbF0YHVmPMcvcy
         dIGEwU2jMF37+h2c6qYFb0TT80fQ1/e5sZVP1X9GgdNTyabdOsuNLRDWRWtfoGZss96g
         dZ9YYZmfub7yyjnx3PNqFt8VWXcrFLnkpkpflLMC0n/71ou2JYZ3CYxw0zPFeYlVK0Bn
         xEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738992780; x=1739597580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ubxtTFkK//oTlnY4r5hIsFvDmokSz63VEkbV/n276o=;
        b=ZU/Tgus34yEmZWaPMx50hPfIdtSxD2hzVk/mFHyVXyG2siBkBsRA/2bPwwVF5a2llp
         cp7VMKG3Gw8Pb9enl/WuGsTtCV/qf9ts8kWa5/sxOee6X/KGfBnNe6bW9xkcsBrYbBlI
         l5eIR9zQheghvHoK4YKJRpzWkDGjkfEzqW8zo+/NTRhHzMc7HxLjTUC1B2jn0z43cFh0
         10mB19UvsBLdLmnB/t4Ns5Jv6wAunDOqsdog7NwnlYB7MV4lSRjeFVJGQ7YRjGVWvu1W
         xP6TsRzrN8kN8vTUI4PS6uHSpQydSe6ng/fMBxqi3bpb/61xeGa3vpQ2SXCWSgNedIGE
         BPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGKDczcUZVD6Trc5Fe5cRhyBBO7fe7hbXU6VqkqcYE3jIdsyIdWt7ImYLMMVtYJrosQlWKYoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rZABo0mBLEumElYyZKmyVylGgtyr01sy6kq74HsGuPSjAag/
	yagEs8gDHlrAv9JpWJsdz8QiNTOuRTXaE+xlyzPSlg9p1nJRrt3O/PIwEyjm4vHE8t0RN7Aj1ir
	tcMBi6IrjAXw4/kXWNfgsY5dQ9dE=
X-Gm-Gg: ASbGnctA/F1k1z7j9VAr+EOILbMkxCDOVtOkVLejJx3VLakKMbO1uPqscKdOA+o+ing
	0tQ5XJihMr/NyFDnWmDhZGTSQn+bqy0JOC4ZKgpzpLg/qSlsg9E2K9TVFBC4IQ40n/xmJafQ=
X-Google-Smtp-Source: AGHT+IH9H4J/qn8WJXT9XEgj1NV72yTFHi0gwps7C/Zk8OR9Am5yBB181BGOp+pfiB5r8Sek7X0BS9fjhqvrg5En9j8=
X-Received: by 2002:a05:6e02:20c9:b0:3cf:cdb8:78fb with SMTP id
 e9e14a558f8ab-3d13df0fb5fmr53044705ab.16.1738992779860; Fri, 07 Feb 2025
 21:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-4-edumazet@google.com>
In-Reply-To: <20250207152830.2527578-4-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Feb 2025 13:32:23 +0800
X-Gm-Features: AWEUYZki5LHWaPhjSPsNGil0vKAabjedKxyzJoigAEn3VavDJwqpSmxzTv9jPFM
Message-ID: <CAL+tcoAKqYMWQZrVReZ_LB4mFqAh_nwtk0AfyYV2BSNNY6pgdw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] tcp: use tcp_reset_xmit_timer()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In order to reduce TCP_RTO_MAX occurrences, replace:
>
>     inet_csk_reset_xmit_timer(sk, what, when, TCP_RTO_MAX)
>
> With:
>
>     tcp_reset_xmit_timer(sk, what, when, false);
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

