Return-Path: <netdev+bounces-163865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C5AA2BDE2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10593A27E5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF221A9B3B;
	Fri,  7 Feb 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgCNN+MI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F522094
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738916909; cv=none; b=FRzSsPDplNDkuCwC1PCIuBYyvWhtH84HQ/tn//s040jX+itkM1rM3fA57j3HFYdp7ZwNME4KZyNWELC/6r5uyo6YfGAIucJwb52PKwCa2xj/PEbnHLe+lXQMLo2sHzgacvTOK7QfsyliPFEEJKjpHpju1hLbuKpHDNcKiBiyY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738916909; c=relaxed/simple;
	bh=bM6dW5E+9q5y0arwHrgioPNSAFoGuQ6snbVGVbq1eWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1EwKEeCgH3RPv2bKnyeQPqTcvKE9ZjWsCmJyYwl7decga/ISL8p258QnfbarBvc2xKD9IQjULP1OkEJTm7v3SLmgFDpqyERrSdWxJg022Q4uY6LSNqH2Od3OPaoi1Ow8tRnM5GGpg+TCB8Mattu/JuEII7alA/hz8YD4mq7phw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgCNN+MI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de4f4b0e31so181976a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 00:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738916906; x=1739521706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM6dW5E+9q5y0arwHrgioPNSAFoGuQ6snbVGVbq1eWk=;
        b=mgCNN+MI1MdN4u3Dq3Ugma5DDsp11VZIoZkCgRU+wX4hTI3QykHxfpMtz5AjeRAv+P
         LFOQEe0hvonU0IWb4cFJbdsBQ1FvXHif3o6wfTQtvrZFlCcTQ6ZrHh9IiSK9vF1ZjNp6
         xOnXJSbeRS0TiqTY+32nmIjxxTjjG+Yr0U79xEw22VU2hGq90bk7uVNR7TYFwVNdq9zP
         3cWbqZdNiKnEgSy+SKWhVhdlLK4xgo7vrKlwHhjnj3IRaJ0UUQT1GdpLdebH6MHEdHeX
         An28JnGnb9J29Db8qUS6V5Nl3ZZXCEf+exCQGF72kfCxDIuA8X/GLytIVGEgktXUOZsI
         0m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738916906; x=1739521706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM6dW5E+9q5y0arwHrgioPNSAFoGuQ6snbVGVbq1eWk=;
        b=gnbu3W1PTelNfbLuDMSyuwm/OiC5bNN92Bj3zT+P5gWuXUX8b2ic0vgYupW7Ns7Vnl
         7OGxqFKEPWuKT2oOsMh3w0V7XFGnJcWXGOtvKY3wStoeFLcOm7YuIqRO3Gt9aP8FOu1k
         AgRmYKrHV+HNdg6Sx2x/39RzSI42RxMW6iBHU+DTERBSCsiHxaE+Rg/hQRDbmVLqvEzF
         Xkv5fPHV2FA5qrFubH/VcXgGjZy7CnlZ+WrhJ1361xu8BeEXEPh182cKgN84kampQAFs
         4dZb11jNzEHEuMi4M4Bd+E5VaBYIGUjdSVwrXrz+3nH8BmVMY+CLzxadwI6FQCYNQ1U2
         xoCg==
X-Forwarded-Encrypted: i=1; AJvYcCW9vv8MD591Ccr8CUyVqzt9bO1qNw39+1eWE4eJ1NhkA5z9jhU2kYx0HyBUdATRACkSy+fgq7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxicEdD0iZJfMbW31aOqAGiTsDxNTyuv89y1h9+lo5Wyemmhu/w
	WM7Tx5hb+wFMxOxypEyGQDQoGICKsDmS05jFiaBkMTZdx6ZsL0q9xIYnmheGEwnb57nOUMlpunt
	mmH8X1AIpasx1OLXiCBsyLrsZzD17ZXrp2U5G
X-Gm-Gg: ASbGnct84asqwfVn74dPv7LhHV6dx4IjaOgXwSH6W8N9N83m2jKgb42lbiRvU+daR4w
	Enikll0T8WdQSbkingXKnElkn+3RTdDxnDc299DphXDAYGf7S4R+FC2R5msy6V5vHx4MImPcO
X-Google-Smtp-Source: AGHT+IHvB8Rcap+m9zPCJyx3l86ZytDSaAH2q8sZFOfFG0YvI9rSNBKEw09fkuYm6h3hvXttNPxpB2weZqoy4Pmoc+g=
X-Received: by 2002:a05:6402:42c8:b0:5d9:fc81:e197 with SMTP id
 4fb4d7f45d1cf-5de45002b1emr2164553a12.8.1738916906231; Fri, 07 Feb 2025
 00:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207072502.87775-1-kuniyu@amazon.com> <20250207072502.87775-3-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 09:28:15 +0100
X-Gm-Features: AWEUYZlw6d77Ue6rxHY__XRdIUaRPzglHdz171bWm7T2bd1irIZytgpO4AvSkbw
Message-ID: <CANn89iKKP8Gs475umtj4qoxTe8V2q9V42HC2kEa8PmEu16Y0zA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/8] net: fib_rules: Pass net to fib_nl2rule()
 instead of skb.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:26=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> skb is not used in fib_nl2rule() other than sock_net(skb->sk),
> which is already available in callers, fib_nl_newrule() and
> fib_nl_delrule().
>
> Let's pass net directly to fib_nl2rule().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

