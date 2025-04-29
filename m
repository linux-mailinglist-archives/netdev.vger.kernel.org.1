Return-Path: <netdev+bounces-186666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC46AA0443
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4141B639F7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63026F47F;
	Tue, 29 Apr 2025 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MhpWzX8G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE9276028
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911354; cv=none; b=pJIuT/G7nFPfiG0MYbfeXcKXNrwg8fCTlBoV2lFeAdAGibeXdqL6SVthJ0KwNuRo+H91m3gk14Vt1vi6fyczZz5UDgVr/oSqWl61KcLw4+1I+CgpARQF2PuQ2kp8PZUBoAKjrjlIBsjI7kIoiFRgTD5AbSXyCpPvfavNe7vd86o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911354; c=relaxed/simple;
	bh=5jgYIag01F1yrBElkPV8J4+N6kc8KaJRZ54SOgKVcpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWk3Jnhm799scgTeZ9uAYiCuljTBWgPxGJYXScSvuiUU1STuJAvDmhHVzqODrZ80HjxEDFYZ9bsPbjVHm/6bynVxRJaCZ9n/l+ulQzilhT1qUABOTDzGqNqi6h120GZiI+3bhtV6wH0ZwfBH0mfGMoAYuTiwiuvGRtGkl+KDHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MhpWzX8G; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a064a3e143so2840863f8f.3
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745911351; x=1746516151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DE+ZZwi8ZZrhc7Bfug1do48IXKytzcdLLJ9EtDstdGQ=;
        b=MhpWzX8GKjHyYSbe4MZdIVD1j97oh9lOp+0SD4Xavk8LumzcwFrflGEadIXOCMxKSo
         SrLT6YqIfWDEOg1EzfbiBeYNWiAZ/zneh+YyGnXfpoRcw3QG5i4pyZSx3rLakjfqZq59
         RE9eVfe13JWgcWEE72s0mtdA/EvthAGLxMUfXyox7rilitN8mCUyQMnkl5gfI1dGYrzD
         vJjsildIzUfgHcfz6nzwo/4RuLhJqJY8PVf6ck2iQAA1SLd9sxFpeU75mbPKx35+sc5p
         /JneEdhvV57p5lf7W53VxZ/ODhhFt3e7iZ1yAq3B3si+gTzAEH4/GPWdkMVvipGtVMfS
         ONvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745911351; x=1746516151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DE+ZZwi8ZZrhc7Bfug1do48IXKytzcdLLJ9EtDstdGQ=;
        b=rBaRSpA38xGNUdTgnnKVEvswUa5falngsE3D8BxhfMRM6EvwscSTx3+JxwsofuwQYb
         E8epPdFJEJygb4sJnZIARqxXENqeYGNbrLvsK1u6S79M6lL3v0MX8C9NTPfINOBjR3/k
         7i/K3sc7vh7R2BQrX6388gbKgfwvDo4qPyk34O9gUWij/4spSXhUpCKnLn3CZ1NdpP3+
         xh56XvyO3KcR/XFgbPbsv3nw0/G3APjPokBApvq66jvcrfeay4CVScqtGb/AVTCPTteu
         Gb4BKRZ1vIEU0BfeE6UZriAiENDh+ac9HEZpl7uLZYuC2IXecmLO6AHJ7yuklqqfyPtd
         LAPg==
X-Forwarded-Encrypted: i=1; AJvYcCV2xtFO7RDaFhGUOFh+psptnYSXD2FuHznbdQazTdu6oddMb3tiL8N1D1P05s/VmnevllT7Ge0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXT2F5YGaTXQWnm/7utmY912cr+eAqU45ej86pf3eS+L2QN/ol
	SvHlOcVuPwTMFVFmBrbaeVk8l3K7O40x/9tiAQ8OJ/u2N2OwEY3ZQamczNklB+U=
X-Gm-Gg: ASbGncvB3XV/I+/TQ3zFoVt2GPuh43oiTLwLqH8xSUOgUN7y9G269JGByUGe/FCR4I3
	hVDzp82kMhc4Icc3ZBRRs7HTdSEn2GdnG8MOqSGXdDZva+P+7ldw9TZJ9ysUZ4Cw6ooIl0G6hXH
	GilTtJihmBcHk1A1Bl6ZlTl0r69EbqDbry0zvHT4SNVELi/B49GN054GbkxypQKPOHdpmkLa4Jb
	cXiZAl3lIwz8yMULdtKmeddrKq8eVIuVJAE6QaGcDK5rScTfAm9o+KhtXL8POr28ZxxnYyfIYs+
	rCue6I4zuS7VqEtbGfTKj9pykdx9+NS2XJmfVidWh6F5rLFE
X-Google-Smtp-Source: AGHT+IG6f2WyGSZ7WS08MtDoTcRvrkelQ14nBFjxhuTum36TKN1UESdXQUfC0EmRBpRwi0ydV8vvMQ==
X-Received: by 2002:adf:fb45:0:b0:3a0:85aa:cc4e with SMTP id ffacd0b85a97d-3a08949fe80mr1603781f8f.44.1745911351307;
        Tue, 29 Apr 2025 00:22:31 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbf04dsm13331457f8f.52.2025.04.29.00.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 00:22:30 -0700 (PDT)
Date: Tue, 29 Apr 2025 09:22:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 01/15] tools: ynl-gen: allow noncontiguous
 enums
Message-ID: <eeyl5eri5dqeir5at4fpcbb3zsanrbfbx7janiz6ntf6ffk5m7@q5ensvdqfvrl>
References: <20250425214808.507732-1-saeed@kernel.org>
 <20250425214808.507732-2-saeed@kernel.org>
 <20250428160611.226e3e61@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428160611.226e3e61@kernel.org>

Tue, Apr 29, 2025 at 01:06:11AM +0200, kuba@kernel.org wrote:
>On Fri, 25 Apr 2025 14:47:54 -0700 Saeed Mahameed wrote:
>> In case the enum has holes, instead of hard stop, avoid the policy value
>> checking and it to the code.
>
>We guarantee that YNL generates full type validation for enum types.
>IOW that the policy will reject values outside of the enum.
>We need to preserve this guarantee.
>Best we can do for sparse enums is probably to generate a function
>callback that does the checking.

Okay, will do that.


>We could add something like a bitmap validation for small sparse values
>(treat the mask in the policy as mask of allowed values).
>But hard to justify the complexity with just a single case of the
>problem. (actually classic netlink has a similar problem for AF_*
>values, but there "->mask as a bitmap" validation don't do, since 
>the elements of the enum go up to 256).
>

