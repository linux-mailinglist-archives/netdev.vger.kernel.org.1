Return-Path: <netdev+bounces-250166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40759D2473B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3F35300AFC8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC79396D0B;
	Thu, 15 Jan 2026 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AavSW8zD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623537418B
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479892; cv=none; b=tCZuP+ADAWDw3vBGVY5SpVRWoIzY4jxLkQVhd4PQlc4lkHXoKeXb3Te8Gmxbo1SqJyffl3vqoUNXlunK9wQ+ndTn7o0X0SpylOvqlp9v/muXZt1kvSGAEdIHYvpfrdlUO2cEd/9vPP+oGtqKqqHV5K/f8I6bkW8HwWGqlsmQS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479892; c=relaxed/simple;
	bh=L1TTyH0HQfm7i7n+eqeYhrSGiuwmELmvtw7QQ3GNH2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5KDSZEgGmcqXKEdUYKMcWRyC6OEEbJVGtLWpci+YLnH+en1s4J9zqd2ODz5LCqi/ZUfzRx31DVc3tOePMtmtStaub/7LLMVf4miHmaKZR4zI2dyuIz0LS0yo3VRTKYBaa/WXNxffrcWFmWBUbSi4c/welYx1+FcK7sxl76ibzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AavSW8zD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f57cd471so530319f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479883; x=1769084683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=AavSW8zDa7wyUQOrKCsE5mEiLhCbCgtNLUJDLiygsCIz5MtcNfL5qg5hmiFSH/hnLF
         dY1NM5kxU9pSW9DgohxUfSzAVt+iLYuHkRY/WkdFE1XVmgvI8pljiAwerID8UL6g7PU/
         eolJwYFX6Yj0B7yZch1EvVk8qqbK6y7rtIhghbakTGjeNT0IeZm0hOjwyUU0ncWi7Ohd
         fORx/nYcwlXu0aeT6z2nysNJs2vxMwjVnQi03RkyIvPvmebQbr0uJa/GOMbQXodXURQ6
         +ZErOfCH6CKBneuJM1DXIQJeb7qxioDN+X5ZyEYo1486PL/QTstgRmV32S5n4c6fMV9G
         3dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479883; x=1769084683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=rDU/HDkLqcpIs4W82cTZpuLw0w8e6eZZY9N+CekFo8IyTUcJgxdBxdRU5fRKo21F0l
         oo1B8NlMJdUA89n1amzeGGuOUuAPs/SrwocrKVFCrdSYk7fUmGzdkThHsZPTCBb3y+U3
         f/AHiGmJ3ZOt90Jewn6n1Sfm/TESHLN3nuPSnKVWGfTSqsKXe2XYPknSsjqF4ypXmfK4
         tzrBNU4Dg0Ctnw7T06S6KXLYz4aHMLn7uHTwhLaUe0y36ykrPmlTf2RlPWseAo4Ln6A5
         VjmVvzXFPH7w1T+z6pSUTK2+zyaIhqOpeHy1O5Q6QX1B5Vnr8TvbivTLapl+yq0KY/7u
         pyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW10NEzWhsus6omVBuv4Hzww9kp3q/GFzKO+AW4+ivCoHgcmMdoKUGLhaKKBAYwgoR+gOELAtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtMYf1Lf5Uc4q1S2tJTutThl1BvnXVJfHx3n1nrJ+XcAKiWgx
	Noh4/L0WjhkCWAAlOj9lNi2dra6cvisswfmrS8uMnQhi39OSxKnS9eiIhqlwoDr7fGk=
X-Gm-Gg: AY/fxX4sgSMMEuSXbKgmblONh3gqZAcJ98HUk1XCECPS1Dftr5Mz6BZJHbX8FkjsOMx
	x9zBkVwIsp9F7egfU/aqVNWfwe/QDBF8wZ1HzfTZXw68GMsJP7MZFdrNbHryL1Tk2SIPlCb18/1
	WcdpyDx8rDHN8LWso4Qtb+PxEQy1BhImFk6mkJ2nyFZgk1IG80AKXvVrdiDWeDy0B6lsyOwdhEx
	9GwL1MIi2ZMo47tvhepORvQw6V0Q+XRHb+kAmfDjf3PtTcfcg34lg49l2TgEdD0Gf2d2nRYtrNX
	pXooixILdHrGrtlVab2LFbR1kIzRPLzfKg0X1xO1tuorSLzPh5UDz58oxGl06pB9nyZmIRI7IHR
	DrmWJj90lk4fVO4HpGohUz6AJIMmQnfBFcnuoxQGeKILa+9BlrcY/x6l4yxvrKXVs1vEPm44kuu
	6jt9ZppDf7ILftuA==
X-Received: by 2002:a05:6000:1789:b0:432:5c43:64 with SMTP id ffacd0b85a97d-4342c547aa9mr7495008f8f.41.1768479882771;
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a650sm5653238f8f.4.2026.01.15.04.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Date: Thu, 15 Jan 2026 13:24:39 +0100
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
Subject: Re: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Message-ID: <aWjch-EcYm7tkF0t@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:20, Marcos Paulo de Souza wrote:
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

