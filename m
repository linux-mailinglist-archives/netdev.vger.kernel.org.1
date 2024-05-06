Return-Path: <netdev+bounces-93773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE88BD2C5
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197F0280FD9
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6015665D;
	Mon,  6 May 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f+j3JvGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E9156249
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012870; cv=none; b=kcItZyHLSm2X54CIckPWol/xtQSbcMBGWqJ77dcmy2UbS4SagVSjXazgBmCaVRRgWs9ESZvIpi9MAK7wfrkgV6vChzP0gJF4wkcGA621wxYNRunSqht+o2ryNuB7BEjYFbW+rMPftyTcySi/U4IHdIf8TdsrsmI21LJLDFjFSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012870; c=relaxed/simple;
	bh=BIZlorch0tOfWgLcDNbvKqrhtK4P+bKgxAxpz0AQEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grZlb7CpMIvEhYtcAZ5OLUbj1NLthJqj7NuTEzZQw3hYKFgSCvjbScjhA40FOh3bKHfcCN8JdpnyASs+H0rMcB0LiaE/HeJ8a0xXgENRgsdVbbjfZ9bWVBqzn9KQV5lQ18lusvLXNDCxL41uwDE8cMrz32c206K6/vJNMxxEsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f+j3JvGf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f44dc475f4so1309399b3a.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715012867; x=1715617667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odqzrPs//hj8WC38Rhd4Ch2SctDBzFte4EXtwtCBz3k=;
        b=f+j3JvGf9+SLwdCCRoh/z+fBVTIciFD5uSUUmWj75mZrNrDttntkSwcWRBdvK3WIlq
         TOlkOc06ETMXZzPvHfZHq/LThTBcKQC0gs6QEyjPuAkS5sT3HWfTEW4q5ZVuKhzQDU4e
         Vljfnhf+8twqOwCv/OVQSAa9xBsqSCKxEBIRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012867; x=1715617667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odqzrPs//hj8WC38Rhd4Ch2SctDBzFte4EXtwtCBz3k=;
        b=vqDsVBABQhKl8NryP43Bk25ydJdilPgsRDHoZUZEQDKou5avBe0D7nz7ryVvx5Aa2J
         g01baZWbLcOlOeF9DYsUcMK2UAOIqvz64Ksxh3/2UrDpaJ0OzlMrVnXOp0AwmlNOhZ1m
         0KCiLFtRMIebn0HCKm8HONp5kfgG9Drd3Ct93bxMXdn1IQzCkFbul4xa29jjTKwkNExU
         WJOC//vMmjzVp0BtAdYqqSIgZk8jIEo7ZhOU6RAqBnx0iny24aBBMpCA8J5HJe8eHPLu
         B7pRIY3qq5qU5WJ65DpVPR4a+VPFIjoauxBp0OIUtZwb3dLU7RKjccp0BFWa3aYIO2qN
         lOEw==
X-Forwarded-Encrypted: i=1; AJvYcCUnIZMB0P1zk58Mp7YVGEClCe8J5+jgYDOJuBL1lJIF6F93DRlWXXNF4uPpuGoG0GvhYIsS/xuoCsYcqOAi2DpPvMcWgGAV
X-Gm-Message-State: AOJu0YxdRkcVWpOYAbI3RXfUbi3ESukH3mVLGAeyiVdnXwZ3su5gHDJx
	WpDkdC+WrvQ5KGxpzD4ijsNqZQTXHZxkJmN9tC8EqgSzgHJqtoqMFwxBt+incQ==
X-Google-Smtp-Source: AGHT+IFx5A8ojwQhkf5tzPyoBV+wXS8DrLII4KW7i+NfXJRNfcIe8ljx+OJPW04VragyCU8v5vFkvw==
X-Received: by 2002:a05:6a00:2342:b0:6f3:ea4b:d1c1 with SMTP id j2-20020a056a00234200b006f3ea4bd1c1mr12045012pfj.1.1715012867078;
        Mon, 06 May 2024 09:27:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ls30-20020a056a00741e00b006f4123491d2sm7951997pfb.108.2024.05.06.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:27:46 -0700 (PDT)
Date: Mon, 6 May 2024 09:27:46 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Sven Eckelmann <sven@narfation.org>,
	Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	"David S.  Miller" <davem@davemloft.net>,
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
Message-ID: <202405060924.4001F77D@keescook>
References: <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <3932737.ElGaqSPkdT@sven-l14>
 <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, May 04, 2024 at 07:08:39PM +0200, Erick Archer wrote:
> Hi Sven,
> 
> On Sat, May 04, 2024 at 11:35:38AM +0200, Sven Eckelmann wrote:
> > On Wednesday, 1 May 2024 17:02:42 CEST Erick Archer wrote:
> > > diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> > > index 6e25753015df..dfbe30536995 100644
> > > --- a/include/uapi/linux/batadv_packet.h
> > > +++ b/include/uapi/linux/batadv_packet.h
> > [...]
> > > +/**
> > > + * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
> > > + * @flags: translation table flags (see batadv_tt_data_flags)
> > > + * @ttvn: translation table version number
> > > + * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
> > > + *  one batadv_tvlv_tt_vlan_data object per announced vlan
> > > + * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
> > > + */
> > > +struct batadv_tvlv_tt_data {
> > > +       __u8   flags;
> > > +       __u8   ttvn;
> > > +       __be16 num_vlan;
> > > +       struct batadv_tvlv_tt_vlan_data vlan_data[] __counted_by_be(num_vlan);
> > > +};
> > 
> > Thanks for the updates. But I can't accept this at the moment because 
> > __counted_by_be is used in an uapi header without it being defined
> > include/uapi/linux/stddef.h (and this file is also not included in this 
> > header).
> > 
> > See commit c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and 
> > identifier expansion") as an example for the similar __counted_by macro.
> 
> If I understand correctly, the following changes are also needed because
> the annotated struct is defined in a "uapi" header. Sorry if it's a stupid
> question, but I'm new to these topics.
> 
> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> index 6e25753015df..41f39d7661c9 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -9,6 +9,7 @@
> 
>  #include <asm/byteorder.h>
>  #include <linux/if_ether.h>
> +#include <linux/stddef.h>
>  #include <linux/types.h>
> 
>  /**
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 2ec6f35cda32..58154117d9b0 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -55,4 +55,12 @@
>  #define __counted_by(m)
>  #endif
> 
> +#ifndef __counted_by_le
> +#define __counted_by_le(m)
> +#endif
> +
> +#ifndef __counted_by_be
> +#define __counted_by_be(m)
> +#endif
> +
>  #endif /* _UAPI_LINUX_STDDEF_H */

Yup, this is needed for UAPI as you have it. Thanks! I should have noticed
the need for this when I reviewed commit ca7e324e8ad3 ("compiler_types:
add Endianness-dependent __counted_by_{le,be}").

> If this is the right path, can these changes be merged into a
> single patch or is it better to add a previous patch to define
> __counted_by{le,be}?

We're almost on top of the merge window, so how about this: send me a
patch for just the UAPI addition, and I'll include it in this coming (next
week expected) merge window. Once -rc2 is out, re-send this batman-adv
patch since then netdev will be merged with -rc2 and the UAPI change
will be there.

-Kees

-- 
Kees Cook

