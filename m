Return-Path: <netdev+bounces-200976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4622AE7994
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F97C4A1003
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD820F076;
	Wed, 25 Jun 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDli5+K8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914F20E315
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838914; cv=none; b=bFsQZTaPB7bh2URfbSwMcUrdrty4Mje1BZIMa+kim1huhbHkiNEhIVF2ePH4ix/oYhCGDMDZfFZ+0+51jXPRhbqGzfV5vrWYHdpPCUdX1rdSwJM0XzXoAti88J7FPnrX4f75ql8FXBb1J/tAC1uYbLwNveJ/VdgAAJqQRXUMQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838914; c=relaxed/simple;
	bh=zpwNDepzoTzzaxm0I9H9fOZHI8MES0vs8xLBUSVMd94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwSas/IObvcWKQTjAYvZxyf6VDCkE+PX7HHZaK10kSL8Uaeun3xui+4VshpvT60mh87MfxL0MCwFm7w7sgJ34nd2YELsgvcjlTcYypkv8ylOezeKfzWKODuqN3yWL/lSBXNKUeN5dFVVl9D6ttEHSdLrJt1xco1ujIjnCJnq5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDli5+K8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a4312b4849so14708461cf.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750838912; x=1751443712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJWUBaRn+NFbAiZsctR9Sk0rJwoQVmEaF8vNrJMha0=;
        b=cDli5+K8H0157CJRrliEULCG1ImmT23LgRW9zs5uWTXWtjR3MYfnR6xfWJFBUKFqa8
         yFuL75yfM5pBJoFxGGO9nwl0kX4KjyCwoQ53xO4uGltcKKPS9APMbI1mzCOx534VLYI2
         RkJUsUYykepxGLVgoyRrglOAao8bxwgILqL5Pwc2BpWyP4FRDXPAoqpOCoH0x/D/swOx
         ZtCgRXV7sRapZwB6/ExxromsmV+tv6EeO7xcw2sbVJ4+8WB1VHecDXDxj/GcZM9YRdi8
         uUa90ntT9APYjRQMWodVc/WSqy4YOF/baC3lEyoxm7GRkywTkVOrpofltvF/KU1Ox7eg
         tEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750838912; x=1751443712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJWUBaRn+NFbAiZsctR9Sk0rJwoQVmEaF8vNrJMha0=;
        b=Xyp87s2IlQvZd7FWkFOzOgPdhrMPFBH8BFlnBQoV1l0g5kd28lbhTojxO4NfF8zc/K
         eBvXuqBDqCYV6xI30bAFm/ThAaJApxxTsoK1ZXUbugl8rBgD7I7ilOYO707y0NDtUr8F
         KpnAjiHd+vxbAZlT61glMgK7y4o+1ERyhtibpBV/KReYKx283rB1n8RsRm3NyAGh8O8j
         Yqyudcp8NswVIRTczLVQTQNAs5Rj6qUNblETI6ru5qWc4d4KzUH1PmADk353kztM68M2
         k2yoiIm2a/Dhe1gEXQXAh5/zDAOk9h92WFx9FiqUMamtrxftZ7GoCzSKT9+kgjYL6sJ7
         LfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM2JPl/nfZa3i3SqnOeVKBAwvkvtFZ++PYkgbwU5LFYLEZXCYPsSp/pY4bOdHxIT5l6es/HZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKECUo3YbLcw/U3Ma4jbheTmWdR64aIfyne3vd/wdGtmMsnlc
	OIszN+3mnh+6p6FchbXC6S05avPOHuKc60lFTRfIhab9/8mmqI1IHDpWRg9wT3sfFpiAK3fGF+x
	vEqqJzItqTFpWUNYnn9iQaMC5px3XLmEGNQwfdBGu
X-Gm-Gg: ASbGncu1egE0oVUok9jxrzMETY61fhEE3qLTx1EmINydmqvV7JlaP6knHqRevw60Pjw
	zG+gZOekL0Izyz+qsC4TVYkG1bae1/Heby60+n1OzxxeBAgEncAARxy+Ev7GTwrP+tnnzv80ZnT
	P0BSLddT29kKhN2Kj8QZUbgKIY6l7qMjBkTmJId3WCsf08BS55N7D8
X-Google-Smtp-Source: AGHT+IH2l04goDte8C6MTfBkwicdcfLuBSPT0rwaeShXKmoGSohwlRGdRNtjkixcZ5WnAvB15y3GdC/wXCD1WKJl+GM=
X-Received: by 2002:ac8:5a55:0:b0:4a4:369c:7635 with SMTP id
 d75a77b69052e-4a7c0699e85mr36557401cf.19.1750838911907; Wed, 25 Jun 2025
 01:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 01:08:21 -0700
X-Gm-Features: AX0GCFtvmPCOCoMB53ZiS7lNiinqU-Ptn3ytwDVPBB0CYTmRz2Bl-m-tFudAibs
Message-ID: <CANn89iLmLeUxBh8kU-RgLZ764QsKUqb_4NiwpwhryPi=7RiZ8w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 08/15] tcp: sack option handling improvements
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:38=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> 1) Don't early return when sack doesn't fit. AccECN code will be
>    placed after this fragment so no early returns please.
>
> 2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
>    tcp_current_mss() does not memset its opts struct to zero.
>    AccECN code checks if SACK option is present and may even
>    alter it to make room for AccECN option when many SACK blocks
>    are present. Thus, num_sack_blocks needs to be always valid.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

