Return-Path: <netdev+bounces-250097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC6D23EE2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 498FA3020811
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708A5362159;
	Thu, 15 Jan 2026 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J/1izd82"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B4326937
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472791; cv=none; b=ORhBjVl7gq74hDixC/jnPJGt8DpCBE0haLs99T+dqkEmMf3tveHtfTHYwks6k4G1lWPZyl7xB2ZbNmV3C4r/NEs0X35O1svlr+34IUOP5jJFyTh7dJFY+QtzBZ4XP94VIpzf1vR27kU7FgT5d9JhEZJuwoeIC6bJMXNqwwuh2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472791; c=relaxed/simple;
	bh=cTvHKPGvKDvdv3CW2phXagRp3ofYcYf6SwlYtKmyZc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJpTrbLWG6b1zogpKIA6A1Df7hOlsAorWqEmM1DZoR0+7SlAKnkvtOUC8CJy1ZcyQqxPaXzYQxG2rBC66r4+lZ2QaJHQyJ2ErEL8ekGftTG70DLkkynmc6oucTWtvuz39qhdS/tSxMn1r31xs+qpZzV32y8qf5i9XJCSKpc/Dt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J/1izd82; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480142406b3so2386405e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472787; x=1769077587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLly7CGERK95lIS5prsdJ95HAbwiiwFAFGJDvTd/YQs=;
        b=J/1izd8202qGaEeoRfsgTbdNxGufyL/cwhFUjAPYTm0bu9tQpJGJoov2DY7UW3yv+k
         Ypk2IyteZoLy0Ofn43OPQzcJVdgCeFDdQROt5G/Ewr6MOecTqVDBDgQ+mtU9x0UAGyP2
         K+Hc/kMSUrrtITjz1+pKJas3OsP96nR2f7CQ/7VW/vygG1IugjSJNRCp1bJNrtx1XBNd
         lPade4Vb8ZX+T5T70bvoHGBQisN85xX4JdzqvTH7CqfVIah5867/eoV1gJgMA1WWNRti
         0RHH0X8T51pG7D9cK58LNI7ZdVv4wubDbEgPodpVF47rKp4sEj9URWJac9sTSlOjNXYS
         C4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472787; x=1769077587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLly7CGERK95lIS5prsdJ95HAbwiiwFAFGJDvTd/YQs=;
        b=vo9wsUDWFBNBlNUnFxwQPReuNXB0wl9nFD78C7jBw2u1Z3798SHHIqHBNW4acXIuo+
         WhA1TLtzsUP+GOcJG3xdbQ6DmvDR6q4m3xh9XbwEINjjS6ehQ1pmdF28w4H0eV7rz3uV
         2t4bpTzruKn1uBuHDIrTs4uPZw3VUQgvzTXOInqdDgTftVhFeWJS88N+axNtz7/uggWZ
         DCD92Kzjz/Baw1gcD4WAPrRoQG9vyANRNm700waV1Pc6EKKyLcndBIEKdzAobG/zw9BL
         whGHwAmbPOvEKvK51qNBkjdrkxesrxUfO+53UYKzPxX8bxFdFJu9ZkBEmM7mW6/WIGZJ
         ZoAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwb5fNYsYTsAaYbUpYfEDXJ1cSnBU51UhdBQpP05O9Xom/YXfzH0In7S4abGQ7Jy/hZ/ra+lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkwA19zY0VEVBPmvo+5f5FYgdwdjJ8Wy4naZswkzdUVMd44ab9
	336Nx2+1jj6vWiRnxQkKYjuBSnpkSWxL583Wj8AjXlNeH4baRwbvSwhAgfJ049fyimc=
X-Gm-Gg: AY/fxX48q3ard7aMC6IFg9bNYkgF4qt2oxyBnhzkL6ZWr6SHIja+KMfjdlc8SksA13y
	N3gig0VdJ2Iif/0rRo1is6j2NIo3otVPyS+NGRDb7LAfyoO02wbNYjCZ5MKOlMyDvnffJwfCmhg
	bmxHjaaFyqmTldSO0qUlxguO1P3u1fVMrw7D5FBniJoXS9CVIbcFwxSTC2yNjMB8rq7dJWyZuq1
	8NF0vJg+AwkqveOWdsz7zmEXIX7Ce1QZZYohYEyf2n1Hkg381XpSvh5zvwZJm0rbzG1FWUhNV2n
	/wAjyAh+s0cC8Ky23JagYJrV+2lBqn8Q5V4J5XHZfMzRreqrtsUAyq8lxCVti79O704Evbb/DmJ
	Y647bzM2cAKSaiLjghvLGeUeDaR932Dh523COP/CoIbir0Ox1HMlxasu4pgaXBKVUZP/VK8H0/u
	L9/AbfzRlLtj0gTQ==
X-Received: by 2002:a05:600c:8b77:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-47ee4819d6emr64067955e9.21.1768472787399;
        Thu, 15 Jan 2026 02:26:27 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d90aasm4935338f8f.29.2026.01.15.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:26:26 -0800 (PST)
Date: Thu, 15 Jan 2026 11:26:18 +0100
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
Subject: Re: [PATCH 09/19] m68k: emu: nfcon.c: Migrate to
 register_console_force helper
Message-ID: <aWjAysWXHUOHSisl@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:16, Marcos Paulo de Souza wrote:
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

