Return-Path: <netdev+bounces-251016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00CD3A238
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDA3B301BCFE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C31350A2F;
	Mon, 19 Jan 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jREKgKp9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D583502B7
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812962; cv=none; b=gfdopHiQX8YnqN+qZhqjDyH7rxqP0l5AVnumYlZ4yVFS6laAZqrTeB2uO5gaZ0MjXhCDfP1uaSr+wJYBTfxswhnZ5tfvE0aWbAgIUv/xjpIJj4rlOA0czgqsOvD/R14f9dnBbDK4H0TToLydqZSt6geoN3b8fW1wzR17i0/mCtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812962; c=relaxed/simple;
	bh=yuzk4HCkmCLSzrI3p4aqbiLdRuxIs3CtoWGhU33hNLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6sNhi0NiMh+zg789ShRawyR9K6EHpsNEg8zKhiKOsJiaGCntkuwvoAYr9/glYDIlrJcFBjAz3J9JjVo0R0MjXiWVAQALSeHKWFRZc86AS46PpP5o6E/l3U5V5Sc+HzTCw6qFduMCpcYqsoftJqJP9RqpoHwOIIxecyX+sGzRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jREKgKp9; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so1845244f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 00:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768812959; x=1769417759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltjz/smMzvjpsohpXR7hQ21/EDxVXQBbnheqC1Ei6f0=;
        b=jREKgKp9y4zTiFW8cccqbZNoPIVQvJhR25Pszp4fDzBSkaMiB21jnwH7P9FiTGyWNm
         bZ46rld7gHxo/V2TZoHi7UEY6PnLLNY1WcjF+UIQco6zCr2XiD9kzyUfidq26isC6C5k
         SL9yP4KtbHkUSqsl4Yxu/W9CzoAWE7IbyoV6GZN4F6S6TJ0WOkYBUYBNvyqE1WyjIH7f
         orIrq7B5apQjM4eNVW232WP6uQZkF09H64VSwSf2J9GRFYCHDKCltXPVy4Nt337YfIt/
         JurLeGEszWUkjuNhkEoP5Knol62Ok8XAmDnaZ/p7MC2YzIFB1v8GbGQ9T6qkwaQTl0NI
         bQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768812959; x=1769417759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ltjz/smMzvjpsohpXR7hQ21/EDxVXQBbnheqC1Ei6f0=;
        b=b5jq36B2YE6E3cwDpudlvkWu/jVSgGqqLLrvG77IX80ZrGF7VaZjp0pyWse78Cwt8m
         KO6sCQvQJ3Db6+sOoLLxQVVUZ8/OKaCnmKNT5B+KNlW7hySpvIrLPmuxzRfkOumrU34Z
         HoyLJHjF5A/qU1p56LKHM+jaNP73l8bVEB0DuQL7r4GlpsPQ2fWSSh3l0CAX/qw6oL54
         azDn73Ue31os0aAIi6gm7Ce9zCHKyYZfihkToWAw1DT9kju+4CVaA8mzsrOojWfoIQsi
         E7QNnmV77XIhe1AWr9ub/R5zITdONZ+NJM9UrtWgZPT0YSDPC74Bro21kZ38hP5dK9aG
         4JRg==
X-Forwarded-Encrypted: i=1; AJvYcCX+HkPae/wlrvJh059BObHgpvHElgOF/39WOwABV2BisEChymyPtquS0y6GPnvFL34BP1K8Gcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnIKS1voS1kuJMTSa2lwl5PKhqEJ9Qj2T7I7BOk6ducpAe609
	VjpCQabRfu8+D0L8O+0J3CIoYIP3JyFiLW4+xwzZgn/IVIjwhVqMjZx63Ekvhx289VA=
X-Gm-Gg: AZuq6aJo39wde790SZecIBhw/e/JeQytZff1UrzJX0tneVLo/CTGTOHZjuzN9WRMZB5
	Oag6jqWPNXZmkD4MUSPfHeWlYc7HvQ2Y4waYL5KT8SijiUWARpr9gXWziFnreeFm7zjYItF73cV
	aBKHtzcVUqgImD460DLuWjgyeSnLmkFbj1c7vElmfDMnE9DBEuD073rzbniMXyUsP6W+az3cQdy
	7o3Pc0JGnSSImIGW6gjsWh6ro7hJbu05X71dlyYQ+fpmM9EEYhfjNlC0HJdpCEZAQm9dvMyw0Oi
	ukkzlw0ZWntuJk3gO2LUbyyJ9ZtbCsmQfVXFhz3s+a4PcWkBezq+EoXWePfcIbD9oZm8IPV0p06
	61Z4y9f9m4aaqHGcym77z8/sEl5mdIJ/1q0ukZH709L1/z0f20E+hzvkKp8CxN+L2c8XQwyuRZe
	qVs66eO5rthNhzKurL
X-Received: by 2002:a05:6000:2505:b0:42f:f627:3aa7 with SMTP id ffacd0b85a97d-4356a0298d8mr13122462f8f.16.1768812959229;
        Mon, 19 Jan 2026 00:55:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996e2d8sm21807525f8f.28.2026.01.19.00.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 00:55:58 -0800 (PST)
Date: Mon, 19 Jan 2026 11:55:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Antony Antony <antony@phenome.org>
Cc: oe-kbuild@lists.linux.dev, Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v2 4/4] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aW3xmwA9tTsWImwr@stanley.mountain>
References: <951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony@secunet.com>
 <202601190605.ZVkgcUYl-lkp@intel.com>
 <aW3pnybMNWNlIRH7@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW3pnybMNWNlIRH7@Antony2201.local>

On Mon, Jan 19, 2026 at 09:21:51AM +0100, Antony Antony wrote:
> Hi Dan,
> 
> On Mon, Jan 19, 2026 at 08:27:25AM +0300, Dan Carpenter via Devel wrote:
> > Hi Antony,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Antony-Antony/xfrm-remove-redundant-assignments/20260118-041031
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
> > patch link:    https://lore.kernel.org/r/951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony%40secunet.com
> > patch subject: [PATCH ipsec-next v2 4/4] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
> > config: hexagon-randconfig-r072-20260118 (https://download.01.org/0day-ci/archive/20260119/202601190605.ZVkgcUYl-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
> > smatch version: v0.5.0-8985-g2614ff1a
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202601190605.ZVkgcUYl-lkp@intel.com/
> > 
> > New smatch warnings:
> > net/xfrm/xfrm_user.c:3299 xfrm_do_migrate_state() warn: missing error code? 'err'
> 
> Looking at this more closely, xfrm_user_state_lookup() always sets *errp 
> when it returns NULL.
> 
> > Old smatch warnings:
> > net/xfrm/xfrm_user.c:1024 xfrm_add_sa() warn: missing error code? 'err'
> > net/xfrm/xfrm_user.c:2248 xfrm_add_policy() warn: missing error code? 'err'
> > net/xfrm/xfrm_user.c:3018 xfrm_add_acquire() warn: missing error code 'err'
> 
> Also, as the "Old smatch warnings" show, this same pattern exists elsewhere
> in the file, most of the calls to xfrm_user_state_lookup().
> 
> I'm inclined to leave it as is rather than change a pattern that's 
> consistent throughout the file. Does smatch follow the code doing
> cross-function analysis? In this case, look into xfrm_user_state_lookup()
> and further down to see that *errp is set when NULL is returned?
> 

Ah, right.  Sorry about that.  Yes, of course, it shouldn't be
changed.

The zero day bot can't do cross function analysis because it doesn't
scale for the number of trees the bot tests...

regards,
dan carpenter



