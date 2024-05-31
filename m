Return-Path: <netdev+bounces-99657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8B8D5ABD
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A851F24D13
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB3628DA0;
	Fri, 31 May 2024 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="m9Zktthj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F97BB0C
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138141; cv=none; b=fI6EPUFwo1RW41DMdqMSz3YwMB7XQbgbv7s5E1nIVYRb061D+9EtE75Rxtyj7fo31xkBLcWS+DUBXf3CNEzYpWJJ2Jn3rOd6DA0F0cTg2ba4pQSAwPdDYlP2laRM06VVQ6KqohEmexsWMnIgrgvJPWra3FcNa7nNuALyp58CM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138141; c=relaxed/simple;
	bh=vJ5QSe/GmKqSf962lGoIY80yoXTVRVCTvCocvZuiMK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZvsnd0W7PqJ30ooYVPlXbs9d+88N3bG7ns1avkjcebIXyB0zsiwrjEknqvRgv+KvAkuBoFExhthOUL/I+xa2vvFgqlD4/quN8Wl3YWH59rY9PurWIDCX7pHdRZBQAPMCY5pY5IRIXIPldu0yyRd2rU2OFkJeweNHZsi4HjgA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=m9Zktthj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6265d47c61so53468766b.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1717138138; x=1717742938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMq6SD6aBiKxC2vs9a0Gg7Nmr+dWK0Vp9kiP1h5wxBE=;
        b=m9ZktthjgvK/b733CRsLGUTDCKRnAHdCMWwW9+sHMSroY9caKaTvNzvTgv3WjR4FA3
         51xCEJvxeJc5zjgb9NzK0jH6La+sifEpmReLyBm37rYDaUdw50k5bT55D9s/Pke+FpnP
         JDWPyulk+9U6DyQ+OCGbFaqbPR2zAWITrBNgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138138; x=1717742938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMq6SD6aBiKxC2vs9a0Gg7Nmr+dWK0Vp9kiP1h5wxBE=;
        b=ZRk/WDQSoeeKyRpmpLmnRmFJaaRBLETA+Yyr732tuyp88L+bllkyHOsK73sDu+8PuY
         xGyS+Uby1zlsTJVAVC7D7pxVfN0RfDwU6dSMR0p3vWUTVTXT2FcZpqvXvkgvVR/lkKFJ
         6joxWkqmQuIyFZQQvlvC7XacNKcGUIJfHsYpWg00fvLQi8Jd+70J6S5ggv+cNNb6XtmN
         t2dIkc+s9PvUSEGb8HcFLG99sv3x9pKIczGgojAr16z4SYaLJCLqamM5zGBh7JWeGMXZ
         Vesy2i0meiTpCBf/TfvQoaghcHRsrHswfKz8TP2Ko2b97FU+MRUK/2/E0j6KCtSO7Mh6
         w4hQ==
X-Gm-Message-State: AOJu0Yy+S1l03rahNGUQR8dNb2Yr/l31FCHaAX+y18PRUGYZpSjhTXFh
	qx0sAnOgr56VpErZdlkoIdJJdnSK2bycX7VSfF4Be5SMdu6ZO6GlHhguUld0nrhtsTtllSVADB3
	VESwKvubo2axcV3HMym7xcZgiF2YU7tHHfVE6
X-Google-Smtp-Source: AGHT+IH1AwmOeAG9xWo4dTYat4Hp+ETXDAKG3qHEZNQLfS36GvxnAYodkBvYqzkuloPcWs7+Yu56VZZHgeKKJTwFW5E=
X-Received: by 2002:a17:906:6b02:b0:a63:4703:14b1 with SMTP id
 a640c23a62f3a-a682022ca1amr61124966b.22.1717138137804; Thu, 30 May 2024
 23:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
 <20240530173324.378acb1f@kernel.org>
In-Reply-To: <20240530173324.378acb1f@kernel.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Fri, 31 May 2024 08:48:31 +0200
Message-ID: <CAK8fFZ6nEFcfr8VpBJTo_cRwk6UX0Kr97xuq6NhxyvfYFZ1Awg@mail.gmail.com>
Subject: Re: [regresion] Dell's OMSA Systems Management Data Engine stuck
 after update from 6.8.y to 6.9.y (with bisecting)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, 30 May 2024 09:52:38 +0200 Jaroslav Pulchart wrote:
> > However, reverting just the "use xarray iterator to implement
> > rtnl_dump_ifinfo" change did not resolve the issue. Do you have any
> > suggestions on what to try next and how to fix it?
>
> The daemon must have rolled its own netlink parsing.
>
> Could you try this?
>
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 96accde527da..5fd06473ddd9 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -1912,6 +1912,8 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
>                         goto done;
>         }
>  done:
> +       if (err == -EMSGSIZE && likely(skb->len))
> +               err = skb->len;
>         if (fillargs.netnsid >= 0)
>                 put_net(tgt_net);
>         rcu_read_unlock();

I tried it and it did not help, the issue is still there.

