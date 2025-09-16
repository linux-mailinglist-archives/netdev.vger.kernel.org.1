Return-Path: <netdev+bounces-223425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95701B591B7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33891323D45
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B229B204;
	Tue, 16 Sep 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtrWpn52"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F13299ABF
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013414; cv=none; b=XWWC2e0uzNxyxV6aKRx29D8saRlDFC2dELi5oNDBtzF3fKckVpjLludbcCd8QxP+EBpd6Pxow88dS/hLkLX3ku6ZUKOkoNLSyTvKZR9VCwA9SJ9LuT9LZqPp2PUPOhSwfT1ouck0UVaajAZjlcDESvwUQ4RR6ykwerEyysti+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013414; c=relaxed/simple;
	bh=QCCv0LV8POFfDA7TK/FPvnv4Z3lZsD53ON7yCBFBt3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM94hNEiyqjuH2haiPTYBgspxnGuDPvBGJDO+tEuSToyoiKJEyWjsWnLtSf/R/Kl3fr1Sax353eltpVwYGMgfZBg1rdmXalRoCreh/DSY2xOF+dWmAZ20c8lejfRzUABTYBMb0WEG8eyvQYZS2x9WqM0jCSaLgoCjP0rxEOeMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtrWpn52; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dec4289f0so2755285e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758013411; x=1758618211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYckLEEDZyq+ncfKckIIe5cXZHBpLuIcopMNV7Km2PM=;
        b=ZtrWpn52nhvElcvERgL4pUWJUc3Ram0NPx9YpLMmKJ5qWi/iqL6tYQUcqWsybmTtfR
         OOpKzHZKuQNhCI5S6B5dir/3ncZopasQFE1XFdUnAc7u1CTGDO1t/xDbWr6Fg5R/nK/g
         ZcKa/Pgk3Gpz09cLFhxys8LeO77nTvvcKq5TPPcoatAPr8MNssF+FZ46dFHqwKylEfg6
         036ueItYyhsVkQxqu+6xlKnpJfFHlAEvMp5OaqvBgCqSKoH+q0trh83wpmpiX6DVHm/U
         uxeuBYYdvv3AvXTsoQWe66RNeupYdFOJEU119IshQG/Hfpl9O9i4/nF5jFg3QsIY/K9X
         Laqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013411; x=1758618211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYckLEEDZyq+ncfKckIIe5cXZHBpLuIcopMNV7Km2PM=;
        b=npOjeG7Lc6G8XBRN+ZyMS67XMzIEK5ZbaaHRMCI6GjkWY56u5qRloeWVOhmlY78U5H
         oKovvBDlxWO8rP8cGAV+YtqaQa8WovwnrZiRU5R/pCNcK/1pzuI0W4wcNoLiTfO3HBTm
         6M2+d0Bk5aqm/AMIx5PuJv39feMqXn+X0HC6XZLBVsJPiGRW8B4T60tAzsyHnDdcIQ5J
         N4FBmWNKiSDu7HzW3hk+4ntdHUtgW7whjC9u8NYDRNSgMR6RPT6rmzUNAqPAhCaWmdRM
         x3fqMVDr+/XctenigSH7VOjI1G0p9QMqHcU9S5gbCwX7MKiKjxadXQU/weBwSz9yyH7R
         kFZg==
X-Forwarded-Encrypted: i=1; AJvYcCWdEU1HCrls4plV9m8LC+FoOM9edJJvoS0fjDtdy2q5mr6DuwgUOnVFS66R5RdioiTOkwRXKuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfkNS2gxmyREDOM2xpNQSm3D+DKGO6bOQbTdHYmHk4qWHkJykI
	ZlEavDX6X8jRY3bbn3KV7i57zTUfDfcU0VvmpnAbeHq9DfwJ8zw2xU3I
X-Gm-Gg: ASbGncssQwj57oq9h2mNh/XlhzI03gJXNtiPFwLZW16/pOe7EEElhq262LvmC4kxj1s
	fXn8LMatC71O4WuG75lEIfTuyWKrT9zaLsjr9hs1rs3BCgE95i9sQ84Pq8l1z8IZ9cjKxKV74gG
	HFj+agaHxos49ihZ0/AOxijSqrSSUhwV2t/lePQM5mJREb+AnTmrgMxF5eUf9QrCkDMjDYN1u4T
	PoTU3X+nqpKpoAyYpC6s+LFy7Ol9Z3ZZMgEB6KQeUvtssKu/KHwSqbJztlIa3kA/BfeC3lX6lNc
	u5qsT9y2rDmYgCViUUEh8Yu+6hgHLMXW+2/0+va3uWMiVARM1DFwfb+yHA/yS3Yr1cnPjW9hOlA
	fyXwtUe2URY1ciD0=
X-Google-Smtp-Source: AGHT+IFXs89u7QNzxZJhjJQOrAmR+vpxo52kVfaMeilOG21DxHGBgdaAnHAGiEj7H+GDfRKPqPVFJg==
X-Received: by 2002:a05:6000:4027:b0:3e5:1d05:156c with SMTP id ffacd0b85a97d-3e7659f59e0mr5671302f8f.7.1758013410781;
        Tue, 16 Sep 2025 02:03:30 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2310:283e:a4d5:639c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e86602a7d5sm13436268f8f.62.2025.09.16.02.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:03:30 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:03:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 5/5] net: dsa: mv88e6xxx: move
 mv88e6xxx_hwtstamp_work() prototype
Message-ID: <20250916090327.lrlzljecozhblix6@skbuf>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uh-00000005cFT-40x8@rmk-PC.armlinux.org.uk>
 <20250916080903.24vbpv7hevhrzl4g@skbuf>
 <aMkhevTsmtsFtONe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMkhevTsmtsFtONe@shell.armlinux.org.uk>

On Tue, Sep 16, 2025 at 09:36:10AM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 16, 2025 at 11:09:03AM +0300, Vladimir Oltean wrote:
> > On Mon, Sep 15, 2025 at 02:06:35PM +0100, Russell King (Oracle) wrote:
> > > Since mv88e6xxx_hwtstamp_work() is defined in hwtstamp.c, its
> > > prototype should be in hwtstamp.h, so move it there.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > 
> > This leaves the shim definition (for when CONFIG_NET_DSA_MV88E6XXX_PTP
> > is not defined) in ptp.h. It creates an inconsistency and potential
> > problem - the same header should provide all definitions of the same
> > function.
> 
> The only caller of mv88e6xxx_hwtstamp_work() is from ptp.c, and both
> hwtstamp.c which provides this function and ptp.c are only built if
> CONFIG_NET_DSA_MV88E6XXX_PTP is set. So, this shim serves no useful
> purpose.

Ok, in the same situation we have:
- mv88e6352_hwtstamp_port_enable()
- mv88e6352_hwtstamp_port_disable()
- mv88e6165_global_enable()
- mv88e6165_global_disable()

which have no shim definition in hwtstamp.h. So I agree that the
mv88e6xxx_hwtstamp_work() shim can be removed. The remaining functions
are called by chip.c, so they need the shim.

