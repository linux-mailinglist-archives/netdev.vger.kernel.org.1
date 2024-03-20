Return-Path: <netdev+bounces-80816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5312388129C
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4A8285787
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FBC47F4A;
	Wed, 20 Mar 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNwmPUt4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAEE4596C
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942221; cv=none; b=VfyLTkYU4zdKgYHh/TMctR/lJF8IVxzNfQjpkaQft6uuyNlP/K2HWWmbWlhBqIlvoxhwmWdqEVVN3NCWu+Zq8ACHlBqgDbDh/ObGZzkRHLNYYQYSvloBasrX/frXtIPSDYSxrCnaXniq3CFLFm1CtF4SLn0jgeOPx+UYaZD3IG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942221; c=relaxed/simple;
	bh=xYKvdBLrMCdy1WgNitS9O8mKhVBkzipGCYuwKoYVqcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RObZHacpxDMHyAnByDB7CM3DsK/8+nJriJ7sVSWB27VxqsKn6CU7cnnhXQmk1WOggD97mz4J30hXmP6xF6JOJdc0Hh5iYccGL8AMSEuT9gyAnCaA8ZkJ2DCJEkXmPMvbcEgVjUEjZh4ISRikjNoHXSFz59NDoy64tanhhPG8iJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNwmPUt4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-568c3888ad7so14420a12.0
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710942218; x=1711547018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrVFZA4ng78LSzJE5ZcpP00io6yMT77XJ0fpYFAjOxc=;
        b=qNwmPUt4virXx4SAO2P5iI0Rqa28Ey0/2fwgLWqtMkJtzhTfhCvPW7Pe93Dx9McI2Z
         +i7a+MiJL0pN50hD2rbTbrKFz1UT94A59+cLUUfsCseKoCOdKvLKnVSkOXpOyILCF0ce
         x5freRh2Osd1hPTxpSrdRzXDj8J+jr6g7crFeiDO5QnrQKCbxZ4vIKflnZgJYH3MCf/6
         D2s+MnXw+0Xrt8//GLepcILXgwGt2iiCFPggYhfx7ftwb8B5sMxkZQ57VSxhMO1F+JX6
         qnqt1Uf7gRjITxC4yh+iorMSLTbT3s+KQKnyftERtBLGNVB6NMBhXlakwCjSGo3NzS+n
         81tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710942218; x=1711547018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrVFZA4ng78LSzJE5ZcpP00io6yMT77XJ0fpYFAjOxc=;
        b=BDSfXmN0fk5OuwdxFZSYnhWC7j3IxoBxyyJHXLASf43yxCf0A4cqtJpvW1gzFnsc4+
         Kre3oJbDQq3EdmFnoaJZBUpbaaoZAsNQl5aUDbjBfTQEUDAE/oLMDfKfu9dKOSMGArXl
         RV5KQDL27NIjlKBpIfCnslbxtqmz1grhZXTP65JBy7R7BU1iSJSijidrPoXQLpIprlsg
         PEQYXYHYbnjrYxNekuiRUCCcMW9CxqCKJ96xwRexs0/ed4WMzQcwG6l8lk37VKUgi/iQ
         /7PFOloTywEU0APbA0yyU4o8ilr23VR7GCDKi0qq5Hh8zr27as3MAIykhCP95Q36B7Cc
         0cBw==
X-Forwarded-Encrypted: i=1; AJvYcCUoxSZGAQSqF6ZiwOPEvhgrOAIfnSAaOKw1K8RCof8xAw4iNGRUrz7fWOnC6ACBb84ujMbm5LNMZBOOGmdrFuQHkEWi6tx9
X-Gm-Message-State: AOJu0YwwZ7gqzUsI2dT3OjWqjIFkgGRilSmN+VjinSMdF2jWhGL+N5XT
	RuHKZYAjCUNqkIDoKRMNqPcABZrfqM+bPkr1rNTKYUejlkuSkRCjMNDR4ZA2GVlFA7/IjY5FVHq
	LvzCzqbh/dcaQNyLEvBuT5Z1zYF+9fplD4cEM
X-Google-Smtp-Source: AGHT+IEJKvr7Tzc6RXNtDOkJwcXM/dRpuZJ3OMy+BGhvJTaJQ6ME63/gEo74bq5MIIAJgCibGiGcffcitlwZ1GiiXQk=
X-Received: by 2002:aa7:d5cc:0:b0:568:c280:64e9 with SMTP id
 d12-20020aa7d5cc000000b00568c28064e9mr195623eds.4.1710942217863; Wed, 20 Mar
 2024 06:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320125635.1444-1-abelova@astralinux.ru> <Zfrmv4u0tVcYGS5n@nanopsycho>
In-Reply-To: <Zfrmv4u0tVcYGS5n@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Mar 2024 14:43:22 +0100
Message-ID: <CANn89iLz4ZesK23DQJmMdn5EA2akh_z+8ZLU-oEuRKy3JDEbAw@mail.gmail.com>
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in __skb_flow_dissect
To: Jiri Pirko <jiri@resnulli.us>
Cc: Anastasia Belova <abelova@astralinux.ru>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:38=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
> >skb is an optional parameter, so it may be NULL.
> >Add check defore dereference in eth_hdr.
> >
> >Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Either drop this line which provides no value, or attach a link to the
> actual report.
>
>
> >
> >Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet add=
resses")
>
> This looks incorrect. I believe that this is the offending commit:
> commit 690e36e726d00d2528bc569809048adf61550d80
> Author: David S. Miller <davem@davemloft.net>
> Date:   Sat Aug 23 12:13:41 2014 -0700
>
>     net: Allow raw buffers to be passed into the flow dissector.
>
>
>
> >Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> >---
> > net/core/flow_dissector.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> >index 272f09251343..05db3a8aa771 100644
> >--- a/net/core/flow_dissector.c
> >+++ b/net/core/flow_dissector.c
> >@@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
> >               rcu_read_unlock();
> >       }
> >
> >-      if (dissector_uses_key(flow_dissector,
> >+      if (skb && dissector_uses_key(flow_dissector,
> >                              FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> >               struct ethhdr *eth =3D eth_hdr(skb);
> >               struct flow_dissector_key_eth_addrs *key_eth_addrs;
>
> Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
> FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?
>

It would be nice knowing in which context we could have a NULL skb and
FLOW_DISSECTOR_KEY_ETH_ADDRS
at the same time.

It seems this fix is based on some kind of static analysis, but no real bug=
.

