Return-Path: <netdev+bounces-178895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D47A796BF
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 22:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0707A55B0
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B01F3BA9;
	Wed,  2 Apr 2025 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="G5N9J/ao"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712CC1F30A9
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626796; cv=none; b=h5+0q2DauTzNwbUeSpOtVFkbaab1HMO56XIPUDuLRp3Q53myW6qGwO8ETgY7W4iRBG8icsiNiFAujNyDMl2fKco3FhwQa4No+FgfOC7UCzeu/Xp/tf2Po44/OxOhE+rQSc09qu8bCTCi6WuzF1FcSGBxpUYbRYZJX20Djv9rWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626796; c=relaxed/simple;
	bh=Z6VGfryL+DXhRvEzoDwFshgf+Bq2wOzL73N/iVKq/zY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6sfOgduloR8Q6VrZRuIRe94ivcqVwC/vWXBrCkZWCdVFGtwozQPdzHw7uchQhXCnndsmBnV8OwCNjHX/b+lTaoryyFINeuE/kz8/v+E2DpBWpdfHNodFztA4eu5IgHICLmewBwBsXEBSwF8kWfMUe98IelB08KXzQaVzhd7RIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=G5N9J/ao; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af9065f0fc0so171006a12.2
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743626793; x=1744231593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYWx+i7p/0sR+VEtIUymF7YgwTfDU8eIqUYc1GEpg1c=;
        b=G5N9J/aopIKYdo+sMdUFG2nI1TR3absavUvt1OtSNCl321wt6b7EefsVG+I9W7qstG
         IyJETzvAnFdLSil+W+/0hZfDC0xzb0GG/0oV6yJ9GJO66YdXWHHcoaIDw/fWlb7QEDq5
         6vD7KEgemgQcFZQjPs0b7Fb4jtyxalwpfFgmpdHThp62WjZpu7rPL8DsBfMHgkhHcGYO
         pd07FQqhm/TmxODJRw4hpO6udNKUEyRfKgaO6979XPDaatKgPNC5boAA2nrfFl3Lx8jM
         9LbPg8ZPfxxwO/hCQCDGqHLoQYTMSyhipps8BfFSBBkToVuEtr8KODzTSyZogCjwrXMm
         +65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743626793; x=1744231593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYWx+i7p/0sR+VEtIUymF7YgwTfDU8eIqUYc1GEpg1c=;
        b=tE+D1Z7ZjbQW6eJSqIAJN22i5t4NUh7OoIHOBdD7Kvrcui24pegAvMe9+Z42ZJzpxo
         62kC2itUbbDhtufMXw+cCDa+HHxXUXCoeWh5dIsE5CYkEuZBYSQ14FC6lHgLNFiQYv2O
         /n9A2KN9oSxAJkVBd2PFUYkZ/dbLrjQgNHrqT3OZhUgBDlZwIUBAJScTDaXwQ5/HEjdS
         hHWrTNUF6s+bIlpxniyIl/XtUmMXb7UiN9EM2nNsVRJY4SDUVbdx8w+1KmkGjvhVs672
         3SQYMOU07z3bYAGpRXr0PalE9mR2nwDUhB6QvCUJf1E+uU2+b3q9YyjYIcfiA9z7d8/+
         ZU4A==
X-Forwarded-Encrypted: i=1; AJvYcCUX7mC3OwiioYm8sKKq8Rx4JWG31BVVd16GvFBrANn2nZ5RUvHqNtpZPPgCKiA+yJUj9qb13u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhY//BjC+/Q6VZ96RAgIpDq93ueoZvoUZWh2aNjixXVXyCy1RZ
	oEynCQPwl1MVBzw0X3g2pGqZ5p1CAkl1xc76YDMwCf30RljLb1QPBDW2uWacYJs=
X-Gm-Gg: ASbGncsv2mZbaOp7dGGbNXE3zaJMohJXo2QmTHwKiJmLv2JSJk9RKeV9FnUBhc7hgxt
	C4C5IvTanmymcyKp2SA4yTA79PKci1orJQ9b1phkBps784AB8EidQu50xzsi7IaJAXAw3A6FERY
	ZcY3wju9bvV3PTyyLR1zQuqOcAahKzG+z5+W8pgObtNVT8RfkqW1EJbwIFIaD56J0YMdKpE7VxH
	ZtBNjxMU/zXCf5Sw7sbtURh8I29mzrLR357D2yHw75ab062838wRqBfU9hH6rSYuNzffrQvAkS9
	64+qUwQJdWxiRO9K/IrQIjjlpRtU6bRQB4nM438ChxKVx6znXzQ1AqB7kfVth2UF5QtFRaJWzHO
	Jhy1W9ETEuCMe7XdotLnN
X-Google-Smtp-Source: AGHT+IE2IlcG36tD6ac4xnnI3ezFBh9fd2IwtdxGG1TNb6l19jnIZfsYC2vcDFMoteFnTSE92h8Htg==
X-Received: by 2002:a17:90a:dfcd:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-3057cb34876mr220395a91.11.1743626793575;
        Wed, 02 Apr 2025 13:46:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3056f80ee73sm2179684a91.6.2025.04.02.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 13:46:33 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:46:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Octavian Purdila <tavip@google.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net_sched: sch_sfq: use a temporary work
 area for validating configuration
Message-ID: <20250402134631.5af060dc@hermes.local>
In-Reply-To: <20250402162750.1671155-2-tavip@google.com>
References: <20250402162750.1671155-1-tavip@google.com>
	<20250402162750.1671155-2-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Apr 2025 09:27:48 -0700
Octavian Purdila <tavip@google.com> wrote:

> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> index 65d5b59da583..1af06cd5034a 100644
> --- a/net/sched/sch_sfq.c
> +++ b/net/sched/sch_sfq.c
> @@ -631,6 +631,16 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
>  	struct red_parms *p = NULL;
>  	struct sk_buff *to_free = NULL;
>  	struct sk_buff *tail = NULL;
> +	/* work area for validating changes before committing them */
Unnecessary comment.
> +	int limit;
> +	unsigned int divisor;
> +	unsigned int maxflows;
> +	int perturb_period;
> +	unsigned int quantum;
> +	u8 headdrop;
> +	u8 maxdepth;
> +	u8 flags;
> +

Network code prefers reverse christmas tree style declaration order.

+	/* copy configuration to work area */
+	limit = q->limit;
+	divisor = q->divisor;
+	headdrop = q->headdrop;
+	maxdepth = q->maxdepth;
+	maxflows = q->maxflows;
+	perturb_period = q->perturb_period;
+	quantum = q->quantum;
+	flags = q->flags;

Comment is unneeded. Rather than doing individual fields, why not just use
a whole temporary structure?

