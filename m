Return-Path: <netdev+bounces-250183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 100E5D24810
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABAF4302DC9B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93044399A6D;
	Thu, 15 Jan 2026 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWoqPUwR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DD28469A
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480185; cv=none; b=uausEYmkymRpRb8KcmzbxR4I3puF2xgtvULOJ5+y5YfqC8Q3MltLxlh91BwhL1hYNEk91Yr1umdTPIITNTDx2NEopqxfqDlPPef/LlIKQmHF2JBUPeOVlXtmnV0sT/Dx05Y0DTeVoL+Z/PlbMAbtoNFN55Gu9bv1KIT2q4ZX/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480185; c=relaxed/simple;
	bh=vYsdvT7Esg+O4+yVXNphLK0YKxhLuEHhcRTW8Mb/9K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSJsIEKoG8fhNss0Bzuyrohq2Dg1X74hwzRFzZKCrIxvjPtYdmf+swm6KqK8UyTUl8irIr5NbgzmQYLd87XTvD3nsa+vMKoEUKGB+o9eXoEC+pBcSIthh4LDZEOzKxRO2wGsDyPWEUUxm5APF+cHmOBxDWx4LyHf0pGaWl1uBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWoqPUwR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so8025355e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768480181; x=1769084981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=YWoqPUwRhFjDNetwPJSdKBHF/sh7S1EgP7tlt+wR//RGEkO9N4XmFTkKsELsXCN+Wh
         tAaa3ENOSjTUpPILgZg/y++6goGL+uSgamekIXw8LmEugXqkm+977/byxDPFL1eoqlch
         cGOXGBs3zphBNNZNyLq/ZN0EehjhFZAUYOQqw+DHgPeteIljG+U4TPt1rzkLOeMvmZ27
         1O7Yw5joixwU3lRrqJFdpDK0eX4HermI+x+n3JLmTrJSvtJqL+AZ+HvmrKi9QhTt/+v6
         TP50tRwd+Z2mmYQDTI3Bo6Q51iA8Biw9ePX1ylXoopdCQ6oTxMlph+beE7QlfFLDppB4
         0k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768480181; x=1769084981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=vhSnFxtXkh0s6znK7ORwO0ZP0kB6hFuOxyPk5+D3L8KRfKqs+EMtlItQN57dm5lfes
         9kGy29oFFm+gol7mTJZdw7xvHS+K9yCDdFuf4+O/2dJwHf4o5mppJKquNry8JTonTgBv
         7GBv/Nli6hf965piQSAO+ZHfGoPeEJ6OTkt571gum6VfAzJ+5LkllCV/HeLVW4ywtEx5
         1KAu8wE0xDWXmO7ojvnWtN0sg7arI6UVWYixBtnlKN4SnhrZbGRwm/qHww5w49vWPmbX
         gxU9ImGWZoW5shCWE068vim92Fz2gXnxQqCeqnzNRDmg6Nt0bkwI1ldy/fYGau085/Fq
         o5zw==
X-Forwarded-Encrypted: i=1; AJvYcCV6AT0AX8xIBKGzlvBdwtQmSfKLpZ1U1gv+/hEjPQFRZPojCtPpWfOofKsTf04GssTHjj5d9bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3MQWCZaCuI6l0BartG+XbI8YfIFCaeYRpJpjk7BXhK3fjo7d
	+vnFYsXpbse5lR41R6VSvYgdeWX1HfNpw73YzmcRwYbLN4nVWhUvlquhAXiVPZFA3us=
X-Gm-Gg: AY/fxX77CGNC4ra/I7SfprjiZTX1tiVYoLTFkoV9D1TtNxKlqdLJLDQxGroxrvvHJsN
	E5XXB7PCUp/JvFr5aCUg8f/95asZJW4vuhtszps3cyA5l05H8KdgeZplBGuE6xH325TOsPz1VRE
	pvwMb88i0tkQ7vcuLol5oqSigwBiTwPzvBHa/N/shM/cJqcoKgXIt/liYe5UqLINbxFhAX4IINz
	kwOb/xwQCScNo0lWB1UnjI6WY9rErclGmktImz7KQST3PKIVApmluCoyPdVGNvuraMmPJpSgiUz
	BINAQmKSn3WuaEexoNBjQqug4OBbphTtcD1IABtGdaYCTsifbGzYIADmcQ7W5zeoxbZjx0Zdulz
	zUmuKsnIp/kLyjJXYZzedchxawg0+SOdpPgpT8a40UUsbXvp5ExSy+z5NQ394rfGcUw9oRRcCwF
	1U3qfPXCvJSzzbAg==
X-Received: by 2002:a05:6000:420a:b0:42f:f627:3a88 with SMTP id ffacd0b85a97d-434ce7324b4mr3823468f8f.4.1768480180633;
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653576sm5965022f8f.17.2026.01.15.04.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Date: Thu, 15 Jan 2026 13:29:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
Message-ID: <aWjdsbYev_5zfKEC@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:21, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

