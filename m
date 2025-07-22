Return-Path: <netdev+bounces-208772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB39CB0D0A3
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 05:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00C6188C6FD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD328B4EB;
	Tue, 22 Jul 2025 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Je266k/F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2992877DD
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 03:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156273; cv=none; b=onGlDzWVk9E4hypdIUfaHMuMJgtYohWrutmNWpFNx4FUqSp9HjKMiNmCsSAATIIrN6IjZgNhpq1jH3XLoicl47ciQ+b0P5hIXZ5c3v5ng64mlAgWksZpn3ROw+f5JalcsAmQGSDezDBqMfSShB9zjkxodvlvp4kIMjZ6TcPGEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156273; c=relaxed/simple;
	bh=lJDeYXSX/bvDetfHjkTeV2ORKfWv7rgs+Q7ECkeHLK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coXJlPG/pBkJlBG9nOqoG79EBIGNmymWyib65Qp+Itl7YXooPC2ajozQmnUweF51kZsKWnbyMUvoEziWo1QEJEwQApBAqmmLP8b/StVExq7pjc7/73u1E4Bo9fN1wRgG9GyvtYYbTOnDOOv0n7O0cYPu3BIVFynhKzL2QWBT6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Je266k/F; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so5107274a12.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753156270; x=1753761070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJDeYXSX/bvDetfHjkTeV2ORKfWv7rgs+Q7ECkeHLK0=;
        b=Je266k/F/o/W4OSEELSDKY9x8+y7O2WK1BEfFnA3WRHBkpb1FSv+T5VehlPm/GysCK
         VRqxjO1O8u5y4RsFdExyjT3AvRuyyiEJsP8yrDZuzG+ezMubS2qRATWZ9/EVRwNsSz7S
         F0u9O3AFs0Xd9+wtKmYjMt5YOt5xitThgZj3qpGBmZ2CNpnfGqgokHkOg/JCkUDSoc7Y
         wW15tpUsF76us7oVA64S/44+JS9mfqCJvOrPgqrcLfl9W2p5eSZQsz7wLzAzN448tOnk
         4TOyMwbWYeFCw/0qtKTk8mTqjOCjq6inmw/Oh/QqDP5kg09eoQEAYL5bxT5cOp9FM8aI
         jpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156270; x=1753761070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJDeYXSX/bvDetfHjkTeV2ORKfWv7rgs+Q7ECkeHLK0=;
        b=RK2tyWjpm/l6pjt7sjs1gkKQqPRRYJc59HqS0LOReq8e7Kl6qbJ8WVKfxf7xxH5XbZ
         flga8MsbrFicM5Yv5jfBqOpOvy8fWXDp/v7eh+inM/XPIjCUi+0apq4nrfN8Uh5kpv+K
         L8XQCZxd35o3wIFhnrosp7D8HLOTF1CDSZQ5oDoj6/BbH0kTsD5LpBzE3aK7WxS1JzpG
         gr1P5YYP8edhl6U8Xv+U9MdrFwwJEzESKSFDAiSIyHrKj+lGtctFY4pF1eQY2OHYywUM
         5ewSO7/25fX5MAb7l8WLvrzpEgezJZbh5j08oPrZJ01hLd36QhhTlEAY4FZEjybvaCzh
         LxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyDTWwmke5fV8KpiU2yu+G51ihDA0AAhqtJ41iwlYbciFshS717mVDdzp5yawANcZ3OsF0xQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT42PPEasvNRgweSLEFvh23F3qnhQJaVof3l5QIvHWhAgc6eP0
	OUwKxMgJcde55Se1eBAF/TEB0rYjxjNN0qDU76hkg+QbsYvB4ZZ1kch2sM6d1rFn+t2EfRnGZ6L
	i3+vrtXFldqlRpVNQx8LrtOY2bZ8RreIk+r0wpQWr
X-Gm-Gg: ASbGncu1B/cBRMCHkSMlf6WXKVjfIxNu+u7/5WY/h6BHy0yFcIb4TIW5CIvvPNM1hr2
	9hZhKY2GLoTXv4NHlorevtnFsxhi40aOKKPWKabOtD6znuiUuEvOpuVIK+aXWOQm+LRe7aBytDu
	vfIjHxNLv4mh0PmA5GZdqulDxSD37mkFLjpbLFQ91IZqcNOrcOGbcdg/JQssa/q/A8SWIm6r6l5
	EJfmAcoQ5IlhAUedoSzt/DrBpYEZd24D4a4dufq
X-Google-Smtp-Source: AGHT+IHtpgoTus5lwayXM01SpaU4GwH90Y2FHf3kxlp2FjqLuyW/RgCCnGVdY5X+U0jWSMGmt4T9U/mpCcao819S7/E=
X-Received: by 2002:a17:90b:35c7:b0:311:fde5:c4b6 with SMTP id
 98e67ed59e1d1-31c9f3efe45mr33017966a91.6.1753156270321; Mon, 21 Jul 2025
 20:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721171333.6caced4f@kernel.org> <20250722094808945ENOLvzY108YsJFz4CqbaI@zte.com.cn>
In-Reply-To: <20250722094808945ENOLvzY108YsJFz4CqbaI@zte.com.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 21 Jul 2025 20:50:57 -0700
X-Gm-Features: Ac12FXy9v416hau5beJ-VqKZOCQ6TgCXB1FDXzhWQtKR1uiwNtaKySQQ5qbKjRo
Message-ID: <CAAVpQUDaSccbmOC0sgihBYPTdtSE2OsFOJXC6s58QS81a+8nkA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 RESEND] tcp: trace retransmit failures in tcp_retransmit_skb
To: fan.yu9@zte.com.cn
Cc: kuba@kernel.org, edumazet@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yang.yang29@zte.com.cn, 
	xu.xin16@zte.com.cn, tu.qiang35@zte.com.cn, jiang.kun2@zte.com.cn, 
	qiu.yutan@zte.com.cn, wang.yaxin@zte.com.cn, he.peilin@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 6:48=E2=80=AFPM <fan.yu9@zte.com.cn> wrote:
>
> > On Mon, 21 Jul 2025 11:16:07 +0800 (CST) fan.yu9@zte.com.cn wrote:
>
> > > Subject: [PATCH net-next v7 RESEND] tcp: trace retransmit failures in=
 tcp_retransmit_skb
>
> >
>
> > Why did you resend this??
>
>
> Hi Jakub,
>
>
> Thanks for checking! I just wanted to ensure the v7 patch wasn=E2=80=99t =
missed =E2=80=94 it=E2=80=99s identical to the original.

You can check the patch status in patchwork, and actually this v7
marked the previous v7 as Superseded, so you didn't need to resend :)

https://patchwork.kernel.org/project/netdevbpf/list/?submitter=3D217549&sta=
te=3D*


>
> Please let me know if any updates are needed. Appreciate your time!
>
>
> Best regards,
>
> Fan Yu

