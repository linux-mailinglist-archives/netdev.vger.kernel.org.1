Return-Path: <netdev+bounces-100728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C28FBBC6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 20:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F511C234F5
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D814A0AE;
	Tue,  4 Jun 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D+Dn9pjz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070E1487FE
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717526599; cv=none; b=NIzjZA8EFZvFtNmCQRnc/Rb7RX7CP0JuDEFSFpc0yiXVFL1QEdV/Yvod75iVpbEybkpbdf9ZxcqnKWkBxYzPasQ16vL3TpCDhCelhZhRNVyzJtZhmCh/ZE6j5+g39FjKs4jyf+6ektIjQkFTOUbfwYYLCz8X02fW22+wQenD0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717526599; c=relaxed/simple;
	bh=grQASJp14Bt7fZYtPF/BOiWWydFpPjbo/cl/eIyN7Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2zj/Vh97sFRZn1GGl6dfmFYmOL/F1gmFpEBe4luw65azoXoLpjOjVU8mkBjem7pL2xW+vI51mJWAspktae0jgmjhgFhz0/OkToAlpLlcVy+khmPCbp1UhBaV+OguSX8hfWRUD8KSsjtcPCvlgceLo4XOEHW2LNwzZRgH5Y5358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D+Dn9pjz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68cd75b97dso333910466b.3
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717526595; x=1718131395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Iay1wNfKZ5p2yKYQUB8UE9csohQVR6x64V5CAu9ZDo=;
        b=D+Dn9pjzYyPe1Rb7YGr00UzU4jXPUPhzf588Vw3LRrXDtEUrWHMyJFgBFHSzDt9SvD
         4Jb0EebP/31mDzPYeCNS26IGloGjQLhKU3I/uOwmwzdeIvqPQCBNDBsUOqgO7pcUROe7
         gYktqDIa3QoCsBMrLMUc5KPupFSaiN9T4jBVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717526595; x=1718131395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Iay1wNfKZ5p2yKYQUB8UE9csohQVR6x64V5CAu9ZDo=;
        b=wVww1XAqrjJ6wMIcm9YtrnbHU5iuBwr6irE5ERk80XC1VklGNi1+EAelSP4kPLw96x
         AUnUZmu7lv9zKJYl+/LDK/SV0sIWMQKEXQ/TM6q3KBHUrssGeowM5BurQrRKD449Ytyt
         HBIp5fkucMtGB3kaJ2ynWG6M0I1opgpoySdENI0ajwGyFwjqIJ1gLF/Qay1aQxHWDv+v
         yG8jkZO6lcIalbClnTQcaXFwqlnIMENnfX1NuHvJJDkXQkFS8ERTg0/aYbUD3p70aU7q
         WLG1WQMbJ2bzu1QMqrKnXpZeTuDPZeQCJPCbU+iRrw5jEUC5k3wzb6Lpr/i+QqRx+Guw
         ZZAg==
X-Forwarded-Encrypted: i=1; AJvYcCVTnT6ATli5wqK+0OjC/qKil1JHX/HDlviqSCeM/3iEealQFGk+WJIZBTIMQ3gZBGLYV3D0GMD4fvzNP0irvm9MVLm3MOrV
X-Gm-Message-State: AOJu0Yycsr+awyt3N0iYqWyRPqfWYd5oQ7MIWIor3u+x2qJYp+cSqW+J
	qAREZqWwJiKYUMxbb0k9fj85Rv79Jm4/2aFP0cxCuo4WTwbWfWWASdi+bkRkL7AiUbocJAb4fdO
	c83ShTw==
X-Google-Smtp-Source: AGHT+IFentifGkGIMZ64UtltI2Zy0g6DetxHovZBLWlJ7EQtPaHhID/K8pBS7hjzHhrLF0Divz5a9A==
X-Received: by 2002:a17:906:2813:b0:a68:ae1b:edbc with SMTP id a640c23a62f3a-a699fcc9a01mr21111566b.24.1717526595657;
        Tue, 04 Jun 2024 11:43:15 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73fa49esm654012266b.87.2024.06.04.11.43.15
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 11:43:15 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35a264cb831so5398425f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 11:43:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvIubB6akFt3YGuWQWEvE7Ce4hXgHl4722nPAmrLQ7twP/1pplb22GWC+9FFCFcmVHDBW9lXB6FSAwgZEx8vYgzWsBVWEd
X-Received: by 2002:a17:906:54b:b0:a62:2cae:c02 with SMTP id
 a640c23a62f3a-a69a024ce40mr20818866b.61.1717526574326; Tue, 04 Jun 2024
 11:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603211538.289765-1-andriy.shevchenko@linux.intel.com> <Zl9b_Wh_Lx7Aln1q@intel.com>
In-Reply-To: <Zl9b_Wh_Lx7Aln1q@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Jun 2024 11:42:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAnzrovfD8MtpRwfbkVxi-W61CqKxYdX+94r_uJeCT7w@mail.gmail.com>
Message-ID: <CAHk-=whAnzrovfD8MtpRwfbkVxi-W61CqKxYdX+94r_uJeCT7w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] treewide: Align match_string() with sysfs_match_string()
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Corey Minyard <minyard@acm.org>, 
	Allen Pais <apais@linux.microsoft.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Perry Yuan <perry.yuan@amd.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Lee Jones <lee@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Elad Nachman <enachman@marvell.com>, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Johannes Berg <johannes.berg@intel.com>, 
	Gregory Greenman <gregory.greenman@intel.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robert Richter <rrichter@amd.com>, Vinod Koul <vkoul@kernel.org>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Nikita Kravets <teackot@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanley Chang <stanley_chang@realtek.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Abdel Alkuor <abdelalkuor@geotab.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Eric Biggers <ebiggers@google.com>, 
	Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-ide@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, qat-linux@intel.com, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Howells <dhowells@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Heiko Stuebner <heiko@sntech.de>, 
	Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, Jean Delvare <jdelvare@suse.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, JC Kuo <jckuo@nvidia.com>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Helge Deller <deller@gmx.de>, Brian Foster <bfoster@redhat.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 11:25, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
>
> (I believe that the new _match_string(str1, size, str2) deserves a better name,
> but since I'm bad with naming stuff, I don't have any good suggestion)

I hated the enormous cc list, so I didn't reply to all. But clearly
everybody else is just doing so.

Anyway, here's my NAK for this patch with explanation:

    https://lore.kernel.org/all/CAHk-=wg5F99-GZPETsasJd0JB0JGcdmmPeHRxCtT4_i83h8avg@mail.gmail.com/

and part of it was the naming, but there were other oddities there too.

           Linus

