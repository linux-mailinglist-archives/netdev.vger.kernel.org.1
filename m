Return-Path: <netdev+bounces-132155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C9990976
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4DB1C208D4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E271C82EE;
	Fri,  4 Oct 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Uc/qQ4so"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27561CACD6
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059946; cv=none; b=baGsYrlc0LcNSuQC+3mX+oImMUZP2usPsI0WtTs4/Rh8+aZH0X2acceRWRnbvN79Gih4zRzjpsPRZid5ciqP603NOm1EXYqWIYMOWWrc9KnmR8IVywlLSnrtzqX3ZcBOF2M7q1rQYwtJCfABVlGh8AZm5oa79ueAWwBc1w2WYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059946; c=relaxed/simple;
	bh=KOGBxA9TKiNtFgwxer4DtODPh33GydDwoPWYw+E3pwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s80IMtde2t7soN/WWaE4W21N5GJ4PnlG7e2iRr49VJQVbvXKSqPpMyuP1tb7VYC6sF3vRDWPU2SRvGhaSeksH8Y44j+Q+fGIikAlS3Vk/6CSbacTEWTXZWQKQB+AfNBf8JH2R4qAeyG/P+ueUqrQWoYm6E38kzb/cID6Vs6aNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Uc/qQ4so; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e2d2447181so4859977b3.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728059943; x=1728664743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lLSHt0+nYj7tJq/wFq1Ibo1QSJAO1HOtLTRqFyV92E=;
        b=Uc/qQ4soO03Jdl9rK8E0ONr6Krjkwkxc0kqPs0yTuw4y18MAuEJGxaG53wnCYnR3l5
         QuZ+pn0geKJs+oJhvKwpUCg+u20UdfG3TTXhdTtbSto7Ujwdwgfw/x4kGXy62+LjAju3
         uVG5CTSdIq3kta3LCP4DExm49Od0cMpVeCE2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059943; x=1728664743;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lLSHt0+nYj7tJq/wFq1Ibo1QSJAO1HOtLTRqFyV92E=;
        b=bqNl//oO9MJbgRH6egL4oPPlmJS79VWv7pbVlguZ95WdlDilK35O7GZpFszNxYZdED
         RwZakwULJ84vKHGjAx97z0G5sOLhEflfqZPiTL9Yn8T1ZuP3vTUjh0tASZgpiYL8W0NY
         iNof9kg2Yh4BsYBQ5Fv/qbkiP0b7LGq3BgIojKFD4xBk/foB+aWrByUC3AA63cZ5wMUK
         zllfr0YDt3BdCUIlHDl93tEmJdGDSfg0TPBCzYZnDB8l/K0sTNOj4MHTZ7Ibmbnv47gv
         XKDhH2Ayiya9CssK2kNglHkxee6F30Ex7Ok92V18sP+BnXZFiCurs0tiqGB2REd83BJ8
         Pv2g==
X-Gm-Message-State: AOJu0YxhkG5Qu62L/BmS4Cvk0yXBcDK2gfq6Difv+x/9DBDXIQ3u1w+/
	K4gmtZyqbbs73p6UYGRyEeEnyQ7/UDKL5JPoLQd4RD5XFsHp19KwKgoS/y+Cs4Y=
X-Google-Smtp-Source: AGHT+IFUO9Qec+Fyg4mR5cnhdoa6mE6+lZPxlypX01sjMFc2kbSqtkciKXZVoHeDf3dvsRklzRArRA==
X-Received: by 2002:a05:690c:2e0d:b0:6db:db7b:891c with SMTP id 00721157ae682-6e2c6ff8368mr24030637b3.14.1728059943665;
        Fri, 04 Oct 2024 09:39:03 -0700 (PDT)
Received: from LQ3V64L9R2 ([50.222.228.166])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bd1cf38asm6843927b3.140.2024.10.04.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:39:03 -0700 (PDT)
Date: Fri, 4 Oct 2024 12:39:01 -0400
From: Joe Damato <jdamato@fastly.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
Message-ID: <ZwAaJSKlofFuS1_8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240925162048.16208-1-jdamato@fastly.com>
 <20240925162048.16208-3-jdamato@fastly.com>
 <ZvXrbylj0Qt1ycio@LQ3V64L9R2>
 <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>
 <Zv3VhxJtPL-27p5U@LQ3V64L9R2>
 <CALs4sv0-FeMas=rSy8OHy_HLiQxQ+gZwAfZVAdzwhFbG+tTzCg@mail.gmail.com>
 <Zv700Aoyx_XG6QVd@LQ3V64L9R2>
 <CALs4sv1Ea1ke2CHOZ0U75JVY84uY=NNyaJrW8wVwcytON2ofog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALs4sv1Ea1ke2CHOZ0U75JVY84uY=NNyaJrW8wVwcytON2ofog@mail.gmail.com>

On Fri, Oct 04, 2024 at 09:03:58PM +0530, Pavan Chebbi wrote:

[...]

> > > Thinking out loud, a better way would be to save the tx/rx id inside
> > > their struct tg3_napi in the tg3_request_irq() function.
> >
> > I think that could work, yes. I wasn't sure if you'd be open to such
> > a change.
> >
> > It seems like in that case, though, we'd need to add some state
> > somewhere.
> >
> > It's not super clear to me where the appropriate place for the state
> > would be because tg3_request_irq is called in a couple places (like
> > tg3_test_interrupt).
> >
> > Another option would be to modify tg3_enable_msix and modify:
> >
> >   for (i = 0; i < tp->irq_max; i++)
> >           tp->napi[i].irq_vec = msix_ent[i].vector;
> Hi Joe, not in favor of this change.

OK

[...]

> > I think it's possible, it's just disruptive and it's not clear if
> > it's worth it? Some other code path might break and it might be fine
> > to just rely on the sequential indexing? Not sure.
> >
> I don't have strong opposition to your proposal of using local counters.
> Just that an alternate solution like what I suggested may look less
> arbitrary, imo.

I don't see where the state would be added for tracking the current
rxq_idx and txq_idx, though. And I don't necessarily agree that the
counters are arbitrary?

Unless tg3 is currently rx and tx index somewhere, then just
assuming they are linear seems fine ?

> So if you want to use the local counters you may go ahead unless
> Michael has any other suggestions.

I'll send another RFC and you can see what it looks like before
deciding.

