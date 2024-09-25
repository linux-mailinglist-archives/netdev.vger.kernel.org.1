Return-Path: <netdev+bounces-129859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7AC986838
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 23:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310231F2257C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72261465A0;
	Wed, 25 Sep 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4JvlcNf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EF92AE6C
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298980; cv=none; b=e0jhGHQLpiboSdRHfMDgZViYKI4xKhAe5A8qUm6rGU/2cVJrqhb3vW6ZecGaHWQZGisO4YTvt5xNZiVebacmaqdT+18VKexjIRQ8nd+tFHd24myq/fX6cdzSo+ka0rOmbk3wFrID3pWJrToxrl9qY2K9/rh2m2XooR6Nz9oOpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298980; c=relaxed/simple;
	bh=UZu5PGB0MXDtNs8MMK1CwREysqd1Z0Qg1/TE2szW5Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHgMeEoF949jXI3qFGUGMIt0GWD3KtI7L3torIzYjgQMOL0isJAQ7Lpf7cQgeMzDqGSJThDdHnq4c+I5JnnBFmkpZIW8XnWPmCtHHcifRJqsyR1owloG4KZ3mtHbcIMK6FqSewN5gFWdE5PEivP+3kSnUp50eCMfXA5cLZof6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4JvlcNf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cacd90ee4so331145e9.3
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727298977; x=1727903777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hserkp0XoO/xaxszPyfe2XUusNXhdSGovTKNC7GSS08=;
        b=W4JvlcNfCrFBU4ARk8TxAIb1Oi1e7QCQpIuOOCbngD8Ps4DRGlbYdBbEbiZ/YKz8Yh
         SzcZ+v+lw/S47JQDvg0I14NnuQ2Zf8o3sMo64HweC+wu4awo6cb2IeobxKta+JoWFHrp
         Ju1iOFsjCO59wJEO4S8zjg1DoDeieBa3l0r2x/aC2jbamDkkph3l6u3HCY+Sd+aGRKhz
         W6EV4JVqd9byebwjPDXgIz7E1vBibcnaQMCaQ2uMqaGHfNJxqVKl0ecCn1V97sWQhET/
         NzcaHvSTtS5B+wLkBFAFl7rTsh8w4tBuZ6nv24IFd2vGM444ZViXv2FimwEqvmLZBIY9
         zuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727298977; x=1727903777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hserkp0XoO/xaxszPyfe2XUusNXhdSGovTKNC7GSS08=;
        b=N/C0dGNf8WGn7F44QXzuS+dCvrvgJTS3qw1ZLvjNSRR3LsDMjcw3NwEWRAYuiEIkjS
         t4PaABdLtnuD29xTORARoEg9/DLYgpBKuutpcB0Gkj2o8rKER5mJbvD4XhOrLsOviXGa
         a8ub2nZOM0Sg3zjn7FUYbVvEEPctfsIFuTdcmggAH6y/ZT/iiBe+FNP+VGeKqGQe8zCb
         fGXj/KEA9vHaXzJu4dMXpJ7GZxg5iztlSNl0Qt3Q7Jsdp5evOCiCTmVkcLoMLGppY6v9
         syUJ/m9E3j4Z6H5oiGJxp02UTV2rXP+47Oqa0fI5gQH9hL2t6xlH3/x0283TUOWtKByo
         6aOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX9EQ3QMTXjiMVWEWBlVGHypV56KPo6GD2dN8p4GrhrPeVTPW/PjiYa+EXXwCTriUkf+0ylPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLLRcd6bEQo2Rklp1fI8m2juEkcGcQ3aG3FtpenaPYq8eGyX2
	iiHJl85CijAPXLVpmmFl4Z3YSCQoZ8mQEW+VkMTMNZHxbpufhUuY
X-Google-Smtp-Source: AGHT+IHBkP25fB4BC5hSAT45OKJ8Gcfe1I3/jKVfbWU3juyKG2hV4TbANIux7w2Ze32P428dDIwKzg==
X-Received: by 2002:a05:600c:1d25:b0:42c:ba6c:d9a7 with SMTP id 5b1f17b1804b1-42e96144adcmr14013805e9.4.1727298976991;
        Wed, 25 Sep 2024 14:16:16 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c13cesm4876658f8f.29.2024.09.25.14.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:16:16 -0700 (PDT)
Date: Thu, 26 Sep 2024 00:16:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 06/10] net: dsa: sja1105: simplify static
 configuration reload
Message-ID: <20240925211613.lmi2kh6hublkutbb@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcz-005Ns9-D5@rmk-PC.armlinux.org.uk>
 <20240925131517.s562xmc5ekkslkhp@skbuf>
 <ZvRmr3aU1Fz6z0Oc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvRmr3aU1Fz6z0Oc@shell.armlinux.org.uk>

On Wed, Sep 25, 2024 at 08:38:23PM +0100, Russell King (Oracle) wrote:
> > There are 2 more changes which I believe should be made in sja1105_set_port_speed():
> > - since it isn't called from mac_config() anymore but from mac_link_up()
> >   (change which happened quite a while ago), it mustn't handle SPEED_UNKNOWN
> > - we can trust that phylink will not call mac_link_up() with a speed
> >   outside what we provided in mac_capabilities, so we can remove the
> >   -EINVAL "default" speed_mbps case, and make this method return void,
> >   as it can never truly cause an error
> > 
> > But I believe these are incremental changes which should be done after
> > this patch. I've made a note of them and will create 2 patches on top
> > when I have the spare time.
> 
> ... if we were to make those changes prior to this patch, then the
> dev_err() will no longer be there and thus this becomes a non-issue.
> So I'd suggest a patch prior to this one to make the changes you state
> here, thus eliminating the need for this hunk in this patch.

That sounds good. Are you suggesting you will write up such a patch for v2?

