Return-Path: <netdev+bounces-159509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DD0A15AD6
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11002167BEB
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AD710A3E;
	Sat, 18 Jan 2025 01:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK6CMXGc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4BCA4B;
	Sat, 18 Jan 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737163601; cv=none; b=PmE1kohj0pgPk7Ru0Y7rOzap08aUXJL7258MhaZTuAxxrouXc5K4HoxbyLDee7iuDMtFUagYpYLhjvipvniQC3iwxb5pmRNQvAtikzKjg5u3M3N2qoak9KiE42GGfY7Fb2Ho4rqwvOpC256+Wj4O5kpxN9awtE8p0YL0+n7Ti8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737163601; c=relaxed/simple;
	bh=ad4sT/I7YkV1Wrd+SVCUJ3VhVJj4ciAMqB/q1BvjgSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=armHWfNiOOSjDDA6fqlAm01sltVtweEztPqNLs/Ss97AMLNi57NvUPKrojcnYX2A1Ctov3nuHc88X6uhgIgCtHAf+C+yKFDlfwPX8J2qy8KxxWepj90GVe22vy7hvhlMqFsvGoZ+dsoYXdgyBamy3RDEkUHbusR3carUFA4yJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK6CMXGc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436246b1f9bso3689295e9.1;
        Fri, 17 Jan 2025 17:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737163597; x=1737768397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vIx7gP9hc2HBxuCqGllXjbI55JK7GtGHo8z0p2dE71U=;
        b=EK6CMXGcgastApzlORKbsG6oM+9XYQlQgynYYf3+P4OKx5zhKs+lKqS0UqfNiyDvgo
         AkCHdU/jTB0A7VflZ6tkyMtt42obXQOKKT+rzBPGJs5XFXp1Hz30PWR36o4V9NtwzguJ
         DHEOp4xmfac+TOprHM5sGetlretAyrwTLa5znW9H+qzrIeaZ0YbawpfZrIbd3wkdCvlz
         CO/N/PxxJzBJU2hKFfzZZRObWIN0KMLf3IlNFUVggzCpuue87brHg1PVWmgPsHmgFamW
         HBL/+fj8GY+0jqjM+/LODQSuR6+vpSUpl7EiSw8II9/KmlSx99cYbkrTiiYAkTi8cYrF
         ILyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737163597; x=1737768397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIx7gP9hc2HBxuCqGllXjbI55JK7GtGHo8z0p2dE71U=;
        b=KswPEXAPv1REQ75uh8FTSKRNDn1jIj4BKrMEqoxXzIc64UNixCBg5vh953PCuF/VvB
         NwsjS8MTMCYIBhLqUCEMUooTh7WQhL2ggmNqOsEu6TwLkWDa/4aVpd61GHH+BM/xKVyg
         O87+EsvWAh977aHG2LzGp1nPzGEhEULs0BY06hrvRkthcuId8KYR9H4HSkBzNUfVwUrU
         owwPaYYiIPhSmlPMbXeDtwp8kcHG9BWAeW2WpL3Q/ioyFohNUQOed+buIrc1E9o+zGPo
         5tnzOdGuNmx6CZdIB8lqN4U4oBlvl4bNuYmpgEVNAi/8qGk1DOqcy9dKKlQDyhoeVwEq
         O4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVICVetw3o6rYDxhdDK35cC89k+AqWPYbW5v1nlLPjuGx9/1VHD1ZI6xDHgaTRDjNjB9/bCetbABRXYr8c=@vger.kernel.org, AJvYcCWqtIDTRqZJ9qsD3MbMHIN5KAQdeQmAJeCKYd2zg5eqmfopdmE/DnbGtDT2VE9SzgKXvUd4JXlA@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3hv+srmEdcxVLT3tt1D8DWnkp+O23KvTcFIZ8RzZiPjPrxPP
	fBG3TR5EUFRedkuBq1eXaeKHJsfNvpN3MDMfjFukQksePsIpzpbt
X-Gm-Gg: ASbGnctXsJvBmauxbyJPwuCHEyUr10aoHJUE7g+0ntLEc3veJPOEot6K3ay+9J/SRwc
	8KK2MaqLrrUz2ffJDwXnqmnO91zTgvGO4hfvqyV+ttoQVKzuU0RWY1cxfVlOLrqEMudeNMM7maK
	R8ljIt8phSj19HIDycz3raQArNubIIAFgvKglqOPGWcUJIml1lBQfEhWZ5lOFuvAnvy4/lww6Zr
	bgAltg5CCBA99x01yKvUFfStxQyVoASKAFB4rbJ+QZ0reYFuTxzoQdYGA==
X-Google-Smtp-Source: AGHT+IFedecNIV2vCDXCDuVN3fZflYZeIVCdpVYngxaXzF4F2UsKxuPuLDOjXOQqEXG4nC1xvtbjzg==
X-Received: by 2002:a05:600c:1d97:b0:436:1902:23b5 with SMTP id 5b1f17b1804b1-4389141d30dmr17887345e9.4.1737163597373;
        Fri, 17 Jan 2025 17:26:37 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389046c59csm51469565e9.40.2025.01.17.17.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 17:26:36 -0800 (PST)
Date: Sat, 18 Jan 2025 03:26:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: andrew@lunn.ch, maxime.chevallier@bootlin.com,
	Woojung.Huh@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <20250118012632.qf4jmwz2bry43qqe@skbuf>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf>
 <20250115111042.2bf22b61@fedora.home>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <91b52099-20de-4b6e-8b05-661e598a3ef3@lunn.ch>
 <DM3PR11MB873695894DC7B99A15357CCBECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB873695894DC7B99A15357CCBECE52@DM3PR11MB8736.namprd11.prod.outlook.com>

On Sat, Jan 18, 2025 at 12:59:25AM +0000, Tristram.Ha@microchip.com wrote:
> Some of the register definitions are not present in the XPCS driver so I
> need to add them.

Not a problem.

> Some register bits programmed by the XPCS driver do not have effect.

Like what?

> Actually KSZ9477 has a bug in SGMII implementation and needs a software
> workaround.  I am not sure if the generic XCPS driver can cover that.

What kind of bug? In the integration or in the IP itself? Anyway,
SJA1105 had what you could call an integration bug too, and that's why
nxp_sja1105_sgmii_pma_config() exists. I am not sure either until you
are more specific.

It is a widespread hardware IP. I don't think it's unreasonable to have
a central driver for it with many quirks, as long as they're well documented
and clearly understood.

