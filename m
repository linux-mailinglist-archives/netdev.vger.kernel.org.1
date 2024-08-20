Return-Path: <netdev+bounces-120150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55301958723
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0089E1F22C98
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C9B19049A;
	Tue, 20 Aug 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3d4kR2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162F19046D;
	Tue, 20 Aug 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157463; cv=none; b=IkhdRpHhitzz/adw/OXsijRAF7Lu9gEIAV6HKE3bnEltQ0c8LcbuimpNM7VKGqOABPK71M4YxVTEWMwQb7zys9ikmVW3wodU6uXPwmzH9IO4/INQR8Rl3t6GuFr2HtEPfuixG0EhWQB1BuaAw0UQFtY99fEUOXCLUUpzPWQcavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157463; c=relaxed/simple;
	bh=8bshFx2eyWZ5uG1VE+ul+rV/TtW021V3dgf/hPg73/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5McG4ukaROaKV7iafd6+iTdxKcO9LWmHYhStgIM4i09jzjrjqQC8fPLiZ0RW92k7UDvtMMY7jv41uUCSAlwwc7onwTRhb4GbQIdXGlEjxPRilg1HKIcbJkIqwF+VzaoQ/1g2MJfjTaTsnwn/bETKMSARr63B0z31hCupIHAto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3d4kR2v; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a8caef11fso640822966b.0;
        Tue, 20 Aug 2024 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724157460; x=1724762260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2jK4yPx4+3xmhvpK4yijnOCWRTycZTzx5NwT7STrrQ=;
        b=C3d4kR2v2UDBrKtcYDVzHLkjGpDB7O8gqmYGLSZBs2k0ab5ASKtJOafeRjG3SWrr9M
         DdBi2oW6/qEPEWrPGd/UcXtN/UxrTwCYZQwaOWMVrRdCx3wgo/eqIGkNNar2qz33yERZ
         kRC3cHLec7MKEAEE4/z/k+76045/tgy39ESnhxDNUT93jOGiW2F/00UgAyEvP9UJSyGJ
         Bk7JJMYmdvk9hHe0am8PjSvj/F11p9jVTGBMa6cpwRd2dJ+WM2VMUxJ4W0S3wlKkJpET
         NXlswD8I2C17T4q2hFrQOkXWA166bsvj01fUZAVZXyfAarmLEXeqMXpW6ExJXmIgLTmy
         FsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724157460; x=1724762260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2jK4yPx4+3xmhvpK4yijnOCWRTycZTzx5NwT7STrrQ=;
        b=one4XUJgbT8NYGfsDx0Dnic4o5PPTr7yl2+my9KfQGeZ5bKGJdXOhn++twYHrofmTe
         hVQNZ77zUQvCQXyNHiTKf7DUF038OLUaE9xl54hI+Slvhqk3Wm6hci0umMpFeerb6uwf
         /PzV/OFVKZLmcToEYZRjUOK+6XsnRcBgLZxv+3YtZhlItDgOQIuLLXFUfJAPqn3g96Zx
         ZZpB4MlcFA+MyysOfRSBm514x9HarjKlEN2AvXVNX0OlrHV0RKbiZeRPHelVJwllC6O5
         2RBaA49yIRTc8hcTkbVV7IxA5bDSk/eu/j2qV8ZTJwn0tfB63fulDSGwsXpqenP5ivP3
         XddQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGEiJC8Jns1Rsvudu8LerJT8U6+pe1VTL+mPyY+wcW4jHAwfFKSsVOhGxn6JEWTLeVLoI0S5G16HbdR17IUQHhyvQNrlyaHm96t4/EoiQCBL9N6Krl5gSVpIehBzRcNFaab6jS
X-Gm-Message-State: AOJu0Ywx7B62jYV/f9VGYn3SskkMiH2yBM6CFtLhMr+lIFyioYMxJkFb
	i2haM9m2tiePF8+xsjlKlYgsusQqscBDWt5ykIKcfAy+5cQ4+bcL
X-Google-Smtp-Source: AGHT+IEnFLaRCBdXyPNV3Gh/d/fIvJ4GLVS182SUvRH2sa8DDTUCqoFD2e3s6tHxCNrIcyWJR2snGQ==
X-Received: by 2002:a17:907:948d:b0:a77:c0f5:69cc with SMTP id a640c23a62f3a-a8392a46c63mr817589366b.61.1724157459917;
        Tue, 20 Aug 2024 05:37:39 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947187sm752949366b.166.2024.08.20.05.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 05:37:39 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:37:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com
Subject: Re: [PATCH net-next v5 0/7] net: stmmac: FPE via ethtool + tc
Message-ID: <20240820123736.hkkzg4ijd6u2rtfi@skbuf>
References: <cover.1724152528.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724152528.git.0x1207@gmail.com>

On Tue, Aug 20, 2024 at 07:20:34PM +0800, Furong Xu wrote:
> Move the Frame Preemption(FPE) over to the new standard API which uses
> ethtool-mm/tc-mqprio/tc-taprio.
> 
> Changes in v5:
>   1. fix typo in commit message
>   2. drop FPE capability check in tc-mqprio/tc-taprio

omg, I didn't even finish reviewing v4, and I haven't been doing anything
else since you posted it :-/

In Documentation/process/maintainer-netdev.rst there's a recommendation
to allow for 24 hours between patch submissions. Please observe that, to
avoid situations like these. Thank you.

