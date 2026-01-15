Return-Path: <netdev+bounces-250094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 453C3D23E88
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28C9530963DD
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E335502E;
	Thu, 15 Jan 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="POOTpyf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D935EDAB
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472407; cv=none; b=bkzGja4kHYeauNx/0p5t9ndB59Tfu+w+TMTk7u5eIgWc8UzC+wWvTC+zm77LaEdslHks3wdHip9ruDVoWJ/RlqxegdpZpXZyV2G7NwHWuVO36FfA8GYMdqon2LS1go5NCnMrnWm9k67XSf4FYjTGR6tPfnQ50IJAXXAmnlZzGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472407; c=relaxed/simple;
	bh=mwoYamMX+C4LOG3qk2bHenfle0rpDp5AHcC+7a69BvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5gTMo30B/qOJ3mIcMH2RHYl/ymQh15wTwabFEPQkrni/vEe4hLamoB7qDVeUY4odCKlLdI3utnm5UR5dt8WCHCJP/m2IJocK+Jelcw7SEKXdXZMqQ+/+TbG8fVnqNzvH32VK+YBxpOXDlm8CnhvtHYVbMMzs9AKqxuslyhFOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=POOTpyf2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso387783f8f.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472404; x=1769077204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=POOTpyf2E8LQhfgcWoVnmGcwTv9cjx7t9nOoTBipWSoduSQDl2DtDEX5jXOGnGpHug
         /vEr3bRycNEF9KDphpixHf8pjEFI6ZYVF8QXfo2/p/K4igsaUNuTuTAXBRonG0hkEw3y
         zjPwl0nXJwH8C//iA7KkpuUuefoo6u/aeL1FN/9mZaiJHPN2asi8Bnj10GOb/8yZxglx
         Mo+8uDhw7wpooLcni7m/NfXXLd+GFxPn8auytjzx3hOMHRSxcVVJJnn1AEDU7nQEhSnb
         pM9pvUeivyUXXZdwnM+CoENtMt4wf2UWt/Iei7G0hU36UOd88kWLwxHkhYgi5FI9j7DC
         cpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472404; x=1769077204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=JGWl3JgaFVp5zyBlgrK9cpcwQ4b04itTjemDBut7XH6UxH646oOjwp3obyZcRPaefy
         HLjtiTVdmGw5gDfqyIVlCej6TsOJh2ABDqBWuFspKnqg3okRwY0BTdK7CxLGkRwEc00n
         g4T6iIDbQCCB9NnHu07aHDGLQ1xuFY3L3U+NN42uaZbZruV2kMJGPV89mKPwBCXu/BmM
         s2hd00x4fB62XQsxRzaZ6QHXvtplkIO9PpyyP1+E+LMX//Y0zcqif19jf8h5OMCH3tkM
         FzUmk9rgcID5Dsqpmh3dn2vge/m0e9XRdkZZqaSlUfpmbuShpi9Jfys5dq/X3d+NG8vV
         MAww==
X-Forwarded-Encrypted: i=1; AJvYcCXWhc50eAuUDyrqKWxWN628aDuQoGFFmDbX72d0j9NHFFaIokKCuCgyDTN6yHqat3cNRD++SEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4R946M4ZTcsOQRwSev6GNQur0Awsi/VG58TmqW9PRGOAeez5k
	jMtU3R5RY82dKeDobMWChaZuMLKv7V6Yztrlu6UkFxhtGprD+mCxwFYL5tyeBguaQDM=
X-Gm-Gg: AY/fxX6E2s9iTO/9loCi6Z3iEWaJDDXodLIuB/8LfduExDZlwtu7u/fuylLyHx8kZX9
	PtayopndF9LP19/nq2zz46rQNz7dAbs7GCDy8lb1GU6hzgn/G0KmY6COfrKXPVhGcDDsJslM1Ng
	8JuqMSvLEnYAadY77IYtsaxkLYE/6McG1xF+GRC+q9dlvcfNIYVZaP5qQV17QDyGCTsATcoRIzH
	pbcsjbAQAUAHyOzPORdlAgyrQgk8cVaFF9UZnDp33LGezzaQMMI85SWP4mTg6pAy+3dn4Pc7AeM
	LEpJEAb0Jbb10ZaysKvX88Ez7cxTrrT7AFH81uO+lo3pSkUAOzoXLmUxw2WfXLV1J7Cnw3a6tes
	c9TTrLfeodZvsdbu6TX3ubTGzMgZfcoqXQOEul2CMPYwoApk15fTnF8ElLvp0awbQ5yx7UqzYm0
	inn7Iut30P01sGng==
X-Received: by 2002:a5d:6b41:0:b0:432:a9db:f99d with SMTP id ffacd0b85a97d-4342c535db3mr5505744f8f.36.1768472403629;
        Thu, 15 Jan 2026 02:20:03 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653632sm5139931f8f.11.2026.01.15.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:20:02 -0800 (PST)
Date: Thu, 15 Jan 2026 11:20:00 +0100
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
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/19] debug: debug_core: Migrate to
 register_console_force helper
Message-ID: <aWi_UJcrphO9Esxw@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:15, Marcos Paulo de Souza wrote:
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

