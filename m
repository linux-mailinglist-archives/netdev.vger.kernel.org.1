Return-Path: <netdev+bounces-98764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91F8D2606
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E991F25602
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3AF178CF1;
	Tue, 28 May 2024 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjIxWpDp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549D178367
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928721; cv=none; b=A4muAOaZGNLh6CnWl1I2yKGVoEUqp1S0tTLM8K6lP7zpB26Fj3RkpQFBvYVbDZd0GZ4dKLO7jo8pHcIWtq6WL3eyUVM3ZQ+uGcpzefenAuPol0qWrnNGaPX9w2DyOdxxrUR/UMiz1T7XzBtKHhonxyc9/1PpkPkpL4co6RxsMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928721; c=relaxed/simple;
	bh=Dy/hmPW7uwt2VnEw3gfFLbazY1marjh5BXYcgDkN62I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgmYVU/p6LhAus9W49JS2kunKdIS9eUB8DeEXmqcbE1kjCJOtRGb680ztrGE5OjFNk2vmXIUhfjnxDqK8lpFFhLOdPbS9B9FSoQiHxqn0MOhTP6sazD1fn87+7dmE3vjYpG/XwV6zqL1moGQGs+ZEn6fHteVUQtTlTXht9u/AZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjIxWpDp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716928718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRpdUwI14UmmdacQK91qakAY0dMDTYZAAunQ0UfHrdw=;
	b=DjIxWpDpRvuq5qKkHhpwJeJctC5nJxR2kP8hvjIeaww3661H2BqmmbG4aqv+B9PiwE7Fcn
	+9el0D1kDRFT5CbPy1ZJZwNun50y3KPiO1e9c4I7xwcPPq9JuNhc6XFIzeThn5cV91z+ID
	tOhzv5fEBz9E2xM54Tdb6LqbipwJNq4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-WWzHha6BN922rYBMHFx9XQ-1; Tue, 28 May 2024 16:38:37 -0400
X-MC-Unique: WWzHha6BN922rYBMHFx9XQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d1cc7aaef1so1150093b6e.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928716; x=1717533516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRpdUwI14UmmdacQK91qakAY0dMDTYZAAunQ0UfHrdw=;
        b=ryqwpzGatV/O0WtU6oD9bef5h1uEhQZ8nfBq/MSbV4bdXSKvofu8nzYk1YGapP44IC
         27/DUujsBpDHDrC585obbCIF92Ub5EiK5VXRovGbt1AgVl94oLTzEErEDXSvMQmKIm+S
         gOuDwEwrZJEoZjwowzX1NrLo3QJsvgFvYgF5oFdZaCm4TesmDv806XpURFcYgM/YjJI4
         EijmEgtUrJC00RETRWWiwwUy/HnKpp8mf46YZl6Op/LevFukxsOnmABhq/uoKSzIxlJn
         p5jJSxfx5qzHIDT2KyvD11HEQ2jvkou5J8XsiqG3tiYlMraXWwX144R0mbS53Z7yGLm3
         mZPw==
X-Forwarded-Encrypted: i=1; AJvYcCWPgh3+ECbxpnYNF/P0/6Tt2Oi5jNyH9cb/jTJ0suQ41vKigr0uYtLojfP0mm+PV5iQCNK7FuYesBpVaYmeAWiU41FxHiA3
X-Gm-Message-State: AOJu0YzBQnCEl4xGoGTz2bkr1e2BAZq/+syZJ2Td68dm2Mkv9Zf2HYV/
	Rzse3YIE0UcqCj/0pfXhWH+kmeewPkGuWUDpS9M/3Gn+4xcI5m9GjxpcnYll+cMfXIDChPFtmwV
	vvkQJ/AqwVnTxcCBhRDDyimSeGyzwQPUDVKqJIbHvCIYjGLPO9CwHuw==
X-Received: by 2002:a05:6808:2394:b0:3c9:b61d:cda3 with SMTP id 5614622812f47-3d1a538ea6amr15900091b6e.11.1716928715895;
        Tue, 28 May 2024 13:38:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4PTdgzrcNLVwwDKxpgg+x0hKSTH22FDtXIL9zq/DZ6Whmcg5TtRy4tYteh6CDwKTiBC06/w==
X-Received: by 2002:a05:6808:2394:b0:3c9:b61d:cda3 with SMTP id 5614622812f47-3d1a538ea6amr15900065b6e.11.1716928715324;
        Tue, 28 May 2024 13:38:35 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad976e5b2esm7083876d6.105.2024.05.28.13.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:38:34 -0700 (PDT)
Date: Tue, 28 May 2024 15:38:32 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/5] net: stmmac: Drop TBI/RTBI PCS flags
Message-ID: <7albilhaebncfbd4olt2czod75buywv3d6bepm7sjrxaetxrve@45pmtkjtip2r>
References: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
 <E1sBvJl-00EHyQ-QG@rmk-PC.armlinux.org.uk>
 <66lbyxnuhqhng2j2bmnw4ke6bqeknpeb476b2wjhr3xdstr5jw@vlgbxf3ni7nt>
 <ZlXaGye/39hk4iuw@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlXaGye/39hk4iuw@shell.armlinux.org.uk>

On Tue, May 28, 2024 at 02:20:27PM GMT, Russell King (Oracle) wrote:
> On Tue, May 28, 2024 at 03:26:10PM +0300, Serge Semin wrote:
> > On Tue, May 28, 2024 at 12:48:37PM +0100, Russell King wrote:
> > > From: Serge Semin <fancer.lancer@gmail.com>
> > > 
> > > First of all the flags are never set by any of the driver parts. If nobody
> > > have them set then the respective statements will always have the same
> > > result. Thus the statements can be simplified or even dropped with no risk
> > > to break things.
> > > 
> > > Secondly shall any of the TBI or RTBI flag is set the MDIO-bus
> > > registration will be bypassed. Why? It really seems weird. It's perfectly
> > > fine to have a TBI/RTBI-capable PHY configured over the MDIO bus
> > > interface.
> > > 
> > > Based on the notes above the TBI/RTBI PCS flags can be freely dropped thus
> > > simplifying the driver code.
> > 
> > Likely by mistake the vast majority of the original patch content has
> > been missing here:
> > https://lore.kernel.org/netdev/20240524210304.9164-3-fancer.lancer@gmail.com/
> 
> I really can't explain this, other than git doing something weird. There
> is no reason that just one hunk that conflicted from a patch would've
> appeared. Should've been as per the below, which it will be when I post
> v2. Thanks for spotting!
> 
> 8<===
> From: Serge Semin <fancer.lancer@gmail.com>
> Subject: [PATCH net-next] net: stmmac: Drop TBI/RTBI PCS flags
> 
> First of all the flags are never set by any of the driver parts. If nobody
> have them set then the respective statements will always have the same
> result. Thus the statements can be simplified or even dropped with no risk
> to break things.
> 
> Secondly shall any of the TBI or RTBI flag is set the MDIO-bus
> registration will be bypassed. Why? It really seems weird. It's perfectly
> fine to have a TBI/RTBI-capable PHY configured over the MDIO bus
> interface.
> 
> Based on the notes above the TBI/RTBI PCS flags can be freely dropped thus
> simplifying the driver code.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


