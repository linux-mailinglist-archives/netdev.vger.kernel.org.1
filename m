Return-Path: <netdev+bounces-154680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D79FF6BD
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49343A243C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9671925BA;
	Thu,  2 Jan 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OC2Zlqlj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1635191F66
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735805649; cv=none; b=mIaMICf13yTSb7FyZoCev7+N7Vj9B5pZbBs5qJic1D4KfQWBpGX2qNqt1UwcjESol9leZbwzATz29tEuKC5aovsecA591YRNtVN8MXVmwz8PuH7ufdB/TxT+TGML9/Oqe7S4arHTuv3Fm3/Nv2Kik86XUtaIECqflufAynFS4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735805649; c=relaxed/simple;
	bh=xPJbpRaiMjc0Oa+Gubi6s+vVtftAnhxPSymniwtFyRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/hBHOhCMLZfSfUBXsaCndd007Jt8Y1dBnCSfYLxTrNyrVVViaEUPZUNJ/R9uh+Z3zN/V3WDZcgNW/2+Zpeu418m1Z3R5fYHJg+VbvLugPl3Vh+l2tcVdOvycO0q3TzmeJNbBcriJ93G4onQAIVxeQvMTO9hQeuvNqtnMqdXHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OC2Zlqlj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso22737712a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 00:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735805646; x=1736410446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVaRFbKIvCBVY0RM8+DTZ2OsOdfugoCkLUSO+EfBesM=;
        b=OC2Zlqljk8D/zvF5q7S59TF3AZKi9HuSb90BpE/yfBmEdnMKX7FiLZLXpAxP16R3N7
         P1Gnxo/UR1o5AIBH3nzDJQzHqK5fxv6t0gmS3tVNAI0wP6m8U/KwcFaIHsxj66edhYrl
         idrIYbQgyuyYmlWEQt+ILCYuZudl7nolAxYAXYe5dNz6g8UipCGXwjW7/Aj8f5pTxDms
         7adH+ukmJStUYiX2CZDUwhf6PXevgP0+JpbrZysfGHDhyTui6uqIoje/WbQxQW9HH8f/
         +XE/ZutQdHS3uQzxrM+mGlRrlGmF2FZTWqDdWl9Kh7YaD48S86G5dXduzwHNh6zSnenj
         T1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735805646; x=1736410446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVaRFbKIvCBVY0RM8+DTZ2OsOdfugoCkLUSO+EfBesM=;
        b=fFfVg2NtA7wGMnlAsyNHYv5mmXWkixDNoZqw+tQWBbenbGgSRWIEpVD7xNPBwOP2eT
         T17y3qcdl4bKXrjGofil4enuxYysKGlyY4LTa913gbp476ueEDFImcXg+YpR4cM+kTqj
         ONIrXgZCE7clr8MOwoyXiuAjuQPqI0NBWpKgTVKOFaeUyTL889pGq0b7m+waQ+PtmFbp
         lWTKK9QOL44pReBEJ75pruJcr9BigJMVCiJko10vgrX1PrbZM0Za2ZwRH0zkWuWPMuf+
         QBIgv4xvL9pCu+8SQpp6sPLRSDyABqOX9Bw7f6uZFLJohLJOj1wR4inlOw63L4Z5Vmsu
         JNag==
X-Forwarded-Encrypted: i=1; AJvYcCVkHppS33fBDxY+NKgytdKPuXIx5EX+2WpHUJKAAggBxYdEB5WIMzT1rIVD0wf4m+JKMk9bLjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2voy2Izhzfsk6Fkgq16W7X0+u2AJqEv1YSaE17jGreu4W/EPU
	8s4bguz8VnadFxkweglj14rllGRVLam0qiVOMKUC8xbEC3wcT1XRifmmAjBn4kTL6MmJmujU2JE
	lp7x+KD43DkkSookRvDdrVLMXMBQEBP8+k5mG
X-Gm-Gg: ASbGncssFj5d3iyD9lle9QJdrtV34P1zqe0QFxoiqwEhNvVHs34QPVzSRSn3mQBThfi
	uYzpnSVIMKFJFfgyzYk/FZnyttlyDyM1fbcY=
X-Google-Smtp-Source: AGHT+IEL/TvzCN5Wa0v2XQl/gWTEplAAJBXyu9cyVK1GACcJoqjV7pTlzGg344xuk0PfsrtNvSdypZk6R0jRhyvhKDA=
X-Received: by 2002:a17:907:1b18:b0:aae:ece4:6007 with SMTP id
 a640c23a62f3a-aaeece4611amr2972621266b.59.1735805646064; Thu, 02 Jan 2025
 00:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
In-Reply-To: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Jan 2025 09:13:55 +0100
Message-ID: <CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	", Przemek Kitszel" <przemyslaw.kitszel@intel.com>, ", David S. Miller" <davem@davemloft.net>, 
	", Jakub Kicinski" <kuba@kernel.org>, ", Paolo Abeni" <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 4:53=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com> w=
rote:
>
> Hi masters,
>
>         We use the Intel Corporation 82599ES NIC in our production enviro=
nment. And it has 63 rx queues, every rx queue interrupt is processed by a =
single cpu.
>         The RSS configuration can be seen as follow:
>
>         RX flow hash indirection table for eno5 with 63 RX ring(s):
>         0:      0     1     2     3     4     5     6     7
>         8:      8     9    10    11    12    13    14    15
>         16:      0     1     2     3     4     5     6     7
>         24:      8     9    10    11    12    13    14    15
>         32:      0     1     2     3     4     5     6     7
>         40:      8     9    10    11    12    13    14    15
>         48:      0     1     2     3     4     5     6     7
>         56:      8     9    10    11    12    13    14    15
>         64:      0     1     2     3     4     5     6     7
>         72:      8     9    10    11    12    13    14    15
>         80:      0     1     2     3     4     5     6     7
>         88:      8     9    10    11    12    13    14    15
>         96:      0     1     2     3     4     5     6     7
>         104:      8     9    10    11    12    13    14    15
>         112:      0     1     2     3     4     5     6     7
>         120:      8     9    10    11    12    13    14    15
>
>         The maximum number of RSS queues is 16. So I have some questions =
about this. Will other cpus except 0~15 receive the rx interrupts?
>
>         In our production environment, cpu 16~62 also receive the rx inte=
rrupts. Was our RSS misconfigured?

It really depends on which cpus are assigned to each IRQ.

Look at /proc/irq/{IRQ_NUM}/smp_affinity

Also you can have some details in Documentation/networking/scaling.rst

