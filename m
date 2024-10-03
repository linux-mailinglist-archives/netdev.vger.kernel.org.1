Return-Path: <netdev+bounces-131697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCE498F4AA
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9698A2833B1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7959C1A707E;
	Thu,  3 Oct 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmbBsp4j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77361A7046
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974666; cv=none; b=ChLhcMVBq0/moxpB6dXFDNpkzQHHB7waA7JZiFFe70OyxIh7Vx7xFAKS7eYf/3yrmiw/heTUbzDbeAKo10OL7C9RJ5060v0AFHYSxzr45Z1/kLRR4x1JE5BrZ5zV7/ZyZ9oUXCnCJfLXd9A5r7TMdcobalbJ6AqwUKHRPrxPYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974666; c=relaxed/simple;
	bh=JvdhOGhiuWeMW1sM5EqAU3cyecnPdBAoR+asPWUN62E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPCPnLjaGJGT/cenpbhGOq3vmO6ODdHsUg+pGwn5hYgGvStRQrwVO44Jmda6LaDYlWtAoUHprgaHeuSS6uhUyAldRgpfvtCB6Kf75t08igMRxvlhl+KlRRCA+mZyGv4iCmxxjvaUomZFuXROXCVv+wd7vB/VrLnAgH2TFa2UouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmbBsp4j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so1202750b3a.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974664; x=1728579464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uPk/ZTOSSK+Ctlhj4ZjXZk9RbhAckhuFmGK+eLFkqcE=;
        b=HmbBsp4jGs6uJQEdxI15T3pctZKJBLycxD15e/OPYdpToPZIIm4fc0lowGcGKTvzwh
         OBNrdON7EWquDAezNlUFOMtOmSSZHLhBf6VUhCCCFdfn1aT8y2XSKo54OWsQGFueqhdB
         EvCFpLbay73DRyb2O/IWQ3psMZdCcU0RRf1zAzYuCJfzQ0O/L8G2lpz4Z1vCU5lhR1dP
         ldfj/H8liUgImWgUa3xZ/uSBtTqhtCazOxKmdZF2l8mlEi8twdksZThXcQNrZW2pRb/R
         AZ6MiQ61FNQ1m/fmhTy/UYZawtYgBJ1n479bLQaX+u3iYnDu85BSxaoVoWmxXvLr44Bc
         WdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974664; x=1728579464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPk/ZTOSSK+Ctlhj4ZjXZk9RbhAckhuFmGK+eLFkqcE=;
        b=q8Ut/7se92/xUtlBcJSkCSDIEFx4J4Z0A22zR7YPpfL2MNd71hRWedTwzEjG1FXzeB
         o4e4KGM1hsDd8HlsdMO8eLvqe2Z13tkeKZv8vVbfEZ3PoinqhSK/c1KQWcfrWygYbuw7
         GJeFsJbDus01hKSA1kB4+jN6Gai/YOZ4DUtI5B0RFOwSI1gaJ7dqQJxowru6TumjFONb
         UZzHdTJqPNFpk1+er0yRxpIebos+YASvoWTr9T4PtybUIY9dc+XI44bC6lXm7py84EdX
         vQQoDnZItCDDhi9m0duO1BsbTMdTHAj9E2c5S87lNY3XF6H3VLR73jeE9CCEZcE8RNCE
         OUuw==
X-Forwarded-Encrypted: i=1; AJvYcCVV2KcHIikJUCuHvgUztU6WdAH/uyYReXkvDkdx0vtu+wTSrSsdhqfzp/1O59odtlUDOBXh+iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfCAJSYmkBxTbnoGYtPYSli/DlCJ3b360fYBOPYYOwyw3OSmxP
	5k/4y3qwIOWelWdwXEx9HYZO3nMzBBSaPhJsyF4FuaG9w4+OfFE=
X-Google-Smtp-Source: AGHT+IGW6AzlQup9Nv0G8jkdbQcY+SoERRciNSHR0VQUmWI5Rh6cUMhrD42rXWB/x2W5fWYvMG9IHw==
X-Received: by 2002:a05:6a20:9d92:b0:1d2:e1cc:649c with SMTP id adf61e73a8af0-1d5db12a6ffmr10462417637.15.1727974664033;
        Thu, 03 Oct 2024 09:57:44 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9dee18fsm1625057b3a.141.2024.10.03.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:57:43 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:57:42 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 08/12] selftests: ncdevmem: Use YNL to enable
 TCP header split
Message-ID: <Zv7NBlVAck9v0Shd@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-9-sdf@fomichev.me>
 <CAHS8izMm8kibMU912thkhB9WC=z6SrkfqAkvXeW6Tj9UsGrQSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMm8kibMU912thkhB9WC=z6SrkfqAkvXeW6Tj9UsGrQSg@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > In the next patch the hard-coded queue numbers are gonna be removed.
> > So introduce some initial support for ethtool YNL and use
> > it to enable header split.
> >
> > Also, tcp-data-split requires latest ethtool which is unlikely
> > to be present in the distros right now.
> >
> > (ideally, we should not shell out to ethtool at all).
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/Makefile   |  2 +-
> >  tools/testing/selftests/net/ncdevmem.c | 43 ++++++++++++++++++++++++--
> >  2 files changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > index 649f1fe0dc46..9c970e96ed33 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -112,7 +112,7 @@ TEST_INCLUDES := forwarding/lib.sh
> >  include ../lib.mk
> >
> >  # YNL build
> > -YNL_GENS := netdev
> > +YNL_GENS := ethtool netdev
> >  include ynl.mk
> >
> >  $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 48cbf057fde7..a1fa818c8229 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -28,10 +28,12 @@
> >  #include <linux/netlink.h>
> >  #include <linux/genetlink.h>
> >  #include <linux/netdev.h>
> > +#include <linux/ethtool_netlink.h>
> >  #include <time.h>
> >  #include <net/if.h>
> >
> >  #include "netdev-user.h"
> > +#include "ethtool-user.h"
> >  #include <ynl.h>
> >
> >  #define PAGE_SHIFT 12
> > @@ -217,8 +219,42 @@ static int reset_flow_steering(void)
> >
> >  static int configure_headersplit(bool on)
> >  {
> > -       return run_command("sudo ethtool -G %s tcp-data-split %s >&2", ifname,
> > -                          on ? "on" : "off");
> > +       struct ethtool_rings_set_req *req;
> > +       struct ynl_error yerr;
> > +       struct ynl_sock *ys;
> > +       int ret;
> > +
> > +       ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
> > +       if (!ys) {
> > +               fprintf(stderr, "YNL: %s\n", yerr.msg);
> > +               return -1;
> > +       }
> > +
> > +       req = ethtool_rings_set_req_alloc();
> > +       ethtool_rings_set_req_set_header_dev_index(req, ifindex);
> > +       ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
> 
> I'm guessing 2 is explicit on? 1 being auto probably? A comment would
> be nice, but that's just a nit.

Sure, will add.

> > +       ret = ethtool_rings_set(ys, req);
> > +       if (ret < 0)
> > +               fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
> 
> Don't you wanna return ret; here on error?

Good point. Will add 'if (ret == 0)' to the get request.

> > +       ethtool_rings_set_req_free(req);
> > +
> > +       {
> > +               struct ethtool_rings_get_req *req;
> > +               struct ethtool_rings_get_rsp *rsp;
> > +
> 
> I'm guessing you're creating a new scope to re-declare req/rsp? To be
> honest it's a bit weird style I haven't seen anywhere else. I would
> prefer get_req and get_rsp instead, but this is a nit.

SG.

> > +               req = ethtool_rings_get_req_alloc();
> > +               ethtool_rings_get_req_set_header_dev_index(req, ifindex);
> > +               rsp = ethtool_rings_get(ys, req);
> > +               ethtool_rings_get_req_free(req);
> > +               if (rsp)
> > +                       fprintf(stderr, "TCP header split: %d\n",
> > +                               rsp->tcp_data_split);
> 
> I would prefer to cehck that rsp->tcp_data_split == 2 for 'on' and ==
> 0 for 'off' instead of just printing and relying on the user to notice
> the mismatch in the logs.

Will do, thanks!
 
> Consider addressing the feedback, but mostly nits/improvements that
> can be done later, so:
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

