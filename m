Return-Path: <netdev+bounces-163864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F335A2BDE1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D83D7A26B0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C41A9B2A;
	Fri,  7 Feb 2025 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwilwGu0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6261A5B99
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738916882; cv=none; b=flmiQKX+hJ3933NrFQtsbMxsMYpQ7+CwV/bkDSIgOF0raiJfbmSdquzrF2sVdFBHMOZ3cFlF+5CZosUTGrUyLlyTXd12V9vy6tkOXyyeB3vEKMdbS1dATV+unz7wrH1yHGI0CmlVhxboHiLieagTHu7MGs6GAfUvUMooVndwbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738916882; c=relaxed/simple;
	bh=Qi5NpsVqPgaOApaIyh0zKPkUnwhp3Owz1trYulmqFCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IO+lRDOd7Bdncie9lQ9fAVMbnwAS7mD9owf89A77QABsYm6p2pPfE++JJM1RQrbdZ0QMandlgP2ZwE+8cy2dOxqEdbzcvBE8o8XRbQ6V3Gr77f6Z7CtULoOZ+ga8tL0l4X3Vv6BSfbGSRg7/ICjYGqP9spPvxzAYIOEYyMNqgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwilwGu0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de4a8b4f86so538861a12.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 00:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738916879; x=1739521679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi5NpsVqPgaOApaIyh0zKPkUnwhp3Owz1trYulmqFCo=;
        b=AwilwGu0lgQHJ494h/xHwSNJO4aajFP85xCWaiZW5Gt8jRkHv5PZqM0VMbfMD7C5zA
         8jjI3Qu94TmPe2gV9P2uGKYEGWNtL6Z+upa3/VQ8Qza2KM7LQfoxaiJHlQzmaf0gMlYw
         GWAuAA7wxF6KdVEmyQm4MmObkCCRNxOUk6sZhou07Hg519NlWN7BPNtE+Ct+4+OIyYqb
         h+ZEreKWb3NsfDij8FMqivodIHQoThIw3cpApPaDqeAhJSuBTAWOILAcmcwl5AVociJy
         fLrQHeynQHM8MdR4gjDFcBxQ/pTotpTzE0Xt+d0LuFrbdtpUbUuF8lXxQEygmtejBEhz
         Cs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738916879; x=1739521679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi5NpsVqPgaOApaIyh0zKPkUnwhp3Owz1trYulmqFCo=;
        b=oD4/1mKlwSfPsyvIG5SOwho3qCNjNLRyj9HTuA9lwBEJmiqxGo5Dz8F0Nghimw4XDR
         riO1LOhSvLnPswh6ZxGR0Baqw9tFhmiyhczmT0+RRtxPfFtofZBeBHxnOFMwmzqD8xIk
         l0NagHqtFE1XmsFYB/mv39vqcz3PmO66oiyMdQGuUut5WSkkAl3rDgAleDWqmg5tpE3x
         ylGB0DGsmTPVYYor6jXEuxwaFZ/bcflMqemWfdOmstzU6ZLceMl93UFZSf0pKfxiKEba
         goTldiGcmL7hlvxvwVWD8GetN0QV49qxJRQV1WA2olKzGXTr7r5L+oNkICpepIH0yv+Q
         FM+w==
X-Forwarded-Encrypted: i=1; AJvYcCVCjOI04mJXJD88AKYVday83YTXPW16rU2s8kzq6XLx5anD5J7FtqPgmjfF0ulZdaj6iuni4qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5+ArgxQHah/hm3bWvwzemIbkTm98UDAtt6lC7FnOobVuQeE1
	TcHPvwPnym4CTPcde1wEj2sRjzV/JUGHUB7mM7xdhLQwFCoA3+H5Lxc2Pl81CPPqG2OZCdr7HBa
	/wOcdAY2i5V0fjlQzXfVsIUfOCoYLxbX+34+Z
X-Gm-Gg: ASbGncsVn9QTTBAlqJsD5C8roTT30HFELBPH477uzysD1sGweKKUwlJGUb1tNG8PSgA
	DKx2zTXjfxlTZ7ueqaWHmi5JziSCAut/DrtIgmUBJDd6ldBKRwffEMLInNpYY0J14fZagK9RY
X-Google-Smtp-Source: AGHT+IH+y9I+9dCfPkmf56SL2QK/b+ugU1eXw/bnplOBw648LM/DlL9SmYrFh4fbGGTn7gpFS1ddE0NZLtKS/6VJ+Ms=
X-Received: by 2002:a05:6402:2801:b0:5dc:d31a:398d with SMTP id
 4fb4d7f45d1cf-5de450059cbmr2877302a12.10.1738916879230; Fri, 07 Feb 2025
 00:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207072502.87775-1-kuniyu@amazon.com> <20250207072502.87775-2-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 09:27:47 +0100
X-Gm-Features: AWEUYZkqGmzb20tlsCEvRr35aOomnlp5RcGNUcEcPpm8lz_whdiLynM9dLvgrv0
Message-ID: <CANn89iJWXUQ3iVkePuBuQtW6CnTZXiskX+GS4ziXeO_AuzMCsw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/8] net: fib_rules: Don't check net in
 rule_exists() and rule_find().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:25=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> fib_nl_newrule() / fib_nl_delrule() looks up struct fib_rules_ops
> in sock_net(skb->sk) and calls rule_exists() / rule_find() respectively.
>
> fib_nl_newrule() creates a new rule and links it to the found ops, so
> struct fib_rule never belongs to a different netns's ops->rules_list.
>
> Let's remove redundant netns check in rule_exists() and rule_find().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

