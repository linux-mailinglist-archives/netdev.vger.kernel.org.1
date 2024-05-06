Return-Path: <netdev+bounces-93776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058298BD2D0
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F961C2186F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB715697B;
	Mon,  6 May 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WjJNqIgl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6B156657
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012985; cv=none; b=KTlF4iivzEgX0QgLPhgBOfjyEX5ra5Nue1SdKh8KRJgJ13/Fkg2c2WREuFKgLg01XvHF5bmvH+JpmaVkXYrZhbmJjtUjxp+rsuG2TkCHUztlSuSNhTdqp1Ta2kY/Mn8tuLhiLDtdbudsIxvwx08f14p/K54rJpqGs14OENVnbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012985; c=relaxed/simple;
	bh=djIR0MvTC9on7MEXMWdmMMuXY59ptlBzgD64Z//dn/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hus9u0H7ZpibKz4jkwn88OEzt8ZWwBMI8mbW4akc5MIw9KFRTSAtGLor/cBPl5Qz2MuXoWjRhYOb39ds3TRNH4cqMd1j/BBxi1UWDfN/1y6Xxba9GKk8x5GJ1Uy7UzmuGfGqMfDuCET9pS8wSt8qZKCwEfScEYPhFJiiNZ2Eytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WjJNqIgl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso14867145ad.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715012983; x=1715617783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FGZV4xevlS61uYYoN9aqvtjUqiITrQIdhJ8KhnBQtc=;
        b=WjJNqIgl/xNbc0Z4JSdktZBtLsYGZn377nBuoOB4l0GFDbUP0GTt8cVZFWQeUJ/GXK
         xP04so7EhkVihMbyWxtEA9IyqxoifoHgEdFdqO5mUfC164yZI+w38tlZoXi+XuitH0Lc
         4pRQm2v9U17DJUa95lkE1fr5tWbR1TduUiDHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012983; x=1715617783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FGZV4xevlS61uYYoN9aqvtjUqiITrQIdhJ8KhnBQtc=;
        b=k1DjhlpxnoWeUnKF4FEgwZMgEVc0WzoJEeAlGwDpZa+ZOH4G7Vc+nD5MXZzaqiIkGb
         U/tXoMLr500TSH3MQspntvEEeVq4Ry8lP95e/obkP3PuXI52Y9wsd9Pq3PkMR90fAxmu
         j/dGVIF/XFAhit+g9IZJYNqltbv6Kw0ezXPi9KelgpFudSVg3DGIMhSE5aX4JkYWIrD1
         W1V7P+lg+Gg5rny6/t12CysHCcs28rJK7CgukndGwxSp7/wGP5+Gh1srZnorkK7IQmDy
         aue/Faz99P4TR60hvMnHmkeuQ3VgaGwEfVbimBBQd2Bd1u7DOw7WOsCf5p6YBxa7dipw
         Qujw==
X-Forwarded-Encrypted: i=1; AJvYcCV0E394Z+7jOSsGGcZtdEkW/tvYmpjYXXwRiD66qW9yggLJt0MIgWBubrWCQhW4ZPWawFVKG3iffdmLLQGXOKgqi3lbAWmv
X-Gm-Message-State: AOJu0YwstXk2oLTF16AKd6xeaj/I2uxIJ6/WNQy/U4sr0hNWOhKF6nIi
	FBMw+4oUJH9RUi9dc44i8oJB3Ne8DazuWbMvfFcxzPtQT7tHpoMCi4FpDGEyxQ==
X-Google-Smtp-Source: AGHT+IFbFO7WG3T0AZk4k9Vs5NN+nUuBbULzCcUX9OeVRvDR9+EhwfFkTTZglRWvChOo6sF8QSal5A==
X-Received: by 2002:a17:902:c40c:b0:1eb:dae:bd98 with SMTP id k12-20020a170902c40c00b001eb0daebd98mr13243215plk.51.1715012983437;
        Mon, 06 May 2024 09:29:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im16-20020a170902bb1000b001ed33493868sm6958248plb.243.2024.05.06.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:29:43 -0700 (PDT)
Date: Mon, 6 May 2024 09:29:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: <202405060928.272B235@keescook>
References: <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <3932737.ElGaqSPkdT@sven-l14>
 <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <9977759.T7Z3S40VBb@sven-l14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9977759.T7Z3S40VBb@sven-l14>

On Sun, May 05, 2024 at 05:22:10PM +0200, Sven Eckelmann wrote:
> On Saturday, 4 May 2024 19:08:39 CEST Erick Archer wrote:
> [...]
> > > Thanks for the updates. But I can't accept this at the moment because 
> > > __counted_by_be is used in an uapi header without it being defined
> > > include/uapi/linux/stddef.h (and this file is also not included in this 
> > > header).
> > > 
> > > See commit c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and 
> > > identifier expansion") as an example for the similar __counted_by macro.
> > 
> > If I understand correctly, the following changes are also needed because
> > the annotated struct is defined in a "uapi" header. Sorry if it's a stupid
> > question, but I'm new to these topics.
> 
> No, it is absolutely no stupid question.
> 
> > diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> > index 6e25753015df..41f39d7661c9 100644
> > --- a/include/uapi/linux/batadv_packet.h
> > +++ b/include/uapi/linux/batadv_packet.h
> > @@ -9,6 +9,7 @@
> > 
> >  #include <asm/byteorder.h>
> >  #include <linux/if_ether.h>
> > +#include <linux/stddef.h>
> >  #include <linux/types.h>
> > 
> >  /**
> 
> This must definitely go into your "original" patch
> 
> > diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> > index 2ec6f35cda32..58154117d9b0 100644
> > --- a/include/uapi/linux/stddef.h
> > +++ b/include/uapi/linux/stddef.h
> > @@ -55,4 +55,12 @@
> >  #define __counted_by(m)
> >  #endif
> > 
> > +#ifndef __counted_by_le
> > +#define __counted_by_le(m)
> > +#endif
> 
> If you want to add this (for completeness) then please put it in an extra 
> patch. It is simply not used by batman-adv and I would not be able to find any 
> justification why it should be part of the batman-adv patch.
> 
> > +
> > +#ifndef __counted_by_be
> > +#define __counted_by_be(m)
> > +#endif
> > +
> 
> This part can be either:
> 
> * in the batman-adv patch
> * or together with the __counted_by_le change in an additional patch which is 
>   "in front" of the batman-adv patch (in the patch series).
> 
> From my perspective, it is for you to decide - but of course, other 
> maintainers might have a different opinion about it.
> 
> >  #endif /* _UAPI_LINUX_STDDEF_H */
> > 
> > If this is the right path, can these changes be merged into a
> > single patch or is it better to add a previous patch to define
> > __counted_by{le,be}?
> 
> I don't have a perfect answer here. See the comments above. The file 
> include/uapi/linux/stddef.h doesn't have a specific maintainer (according to 
> ./scripts/get_maintainer.pl) - so it should be fine to get modified through 
> the net-next tree.
> 
> But maybe Kees Cook has a different opinion about it. At least there are a lot 
> of Signed-off-bys for this file by Kees.

FWIW, I'm also fine with the UAPI going in via netdev. It's the most
likely place to use the be/le variants. Is netdev still open for
patches? Whatever the path, we should get it into this coming merge
window so we can use it elsewhere too if we need it.

-- 
Kees Cook

