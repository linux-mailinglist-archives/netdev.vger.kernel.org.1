Return-Path: <netdev+bounces-303759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F0gDDgs9RWpz9AoAu9opvQ
	(envelope-from <netdev+bounces-303759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:15:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 864046EF9BD
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:15:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NhFFDJxG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303759-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303759-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C3A23056A92
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21627495522;
	Wed,  1 Jul 2026 16:09:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C8492532
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:09:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922146; cv=none; b=UHJ14a0dJUfPumTpjTWetSjCzEmwz8uCsEsgdX8sTuiA6RRySy+7wmTOOJ/CGCs/bTL9hFolI5p2MZROMEciolOiphB6LTE9sr6Ak76BUtgMqvZITqeX3evXs39mafMiyrr056dXxuMHh0owaEOxlPWzAHdZtGzriws9TRqRahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922146; c=relaxed/simple;
	bh=QI6/1jl+FwxwLNBhZZLYlzz42SxxurAYoSgW8BhCBSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SC4xfg/y1bci4GBOmVb6zaRpOh24X54BYiDg5kYLfjoRZpd9bLmFkbyJjJl1gk/bWTfnAv77mCXHfSEtOVC7tYrTsEG/yPFNWr4ciY2zuFtr6/o19i2D2A6TkkmPSQlTzXOuPmTJNxTbUGyjF+LRglH8BxieQuAGv3WEMnqG5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhFFDJxG; arc=none smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-804e46366d7so11480187b3.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782922141; x=1783526941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI6/1jl+FwxwLNBhZZLYlzz42SxxurAYoSgW8BhCBSU=;
        b=NhFFDJxGrbfu8ORIh5ZCTDSO7HWovTDCcIe4MF1BM/paJptFSkkY57zxRyE4pZsPsU
         oPlENLc8miTKXOdue0J36h8cOBwS+1+ld81Ww7cSyTaI1Kivb8NrJcFRaThQw8OCt8Hd
         27cZKUi76JSyuVo6lSR1mglBrq8Nddx/YjO56Ww00GIZW7hr+OjFTdlNNXgT3UnYEtA1
         ruKLSBvnbo4P/EHWstHbn4gMIv0IUsxgMdPyLcYmz7msxlA/2U0pEXsd5Z05zMMAvUuv
         pFOwwXZ2e/hakMMvccnjwekZLclNol0oudPs1QvQCJQGTI+vZsmdKqypyHdalqK1ykNQ
         OgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782922141; x=1783526941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QI6/1jl+FwxwLNBhZZLYlzz42SxxurAYoSgW8BhCBSU=;
        b=MA6lZQw7IkmPnJyyomuKFFBNG5dpC6mZ10UWb/EUCBqK+DOQh76UX2/lxLrnQzUgAv
         YmM1LB0XPzM3L8PATBQtDU7Z/EbxxpXxfz38Sliz4ugYsG2Np85nKyoh8ehBVjDoizTG
         TzYrwLNMHgVZoxCXOQg0jq0Ur6MQRMnJ4lqoAVRj+6Z8JDsHcMtCRlrN0KvYUAkfBINs
         ePOF6JHWZ/lojrLm1wctsyRen716COB0zsqj6ZCPcd9kck1bHNhqcuc6DlA1HZy5HvYT
         wNyqgqkOoJzYFqX2zdEotR09gBm835ncNEwXvjvMXRb0l7Vqlx0S7bajSbeFMVzWzhPU
         xmNg==
X-Forwarded-Encrypted: i=1; AHgh+RoULNpyhrTGynQkqNhR7zmCNH3rPxz/svdfYebvSjL811GZnBoba7ULbWEo4/l2FsWFAvmo/ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcEAYXdxZHDMgn4lP37pEfllnkk6Te21gGY6avSssyjla+X13
	Nzy7On25JB1FDefyBa9/O9wnmBjfZlpKw9yy+fVqMDx4piZFndr3yije
X-Gm-Gg: AfdE7clGvVThgOuIheRd4TTiLKejtyaoihCrTsB++ifJvRUr5mbxFbNl7uCvpPm8kgx
	71z7oPnyO5CfjOOlwkDpVsHCXeiMMWC1QejMtG09bAJkbsieMGD3otrD/CLUVT+gqWaTRy/Iyn5
	186CKMYSg7RehDfpZ2SqwPQwevx20MAVAQrLWWqiG7ZFyoaB5fG8li3/aCwctwdfuqb6DQdNMJT
	W4zarIRP7Qi/21wKVMTucUpN2JsHsU56yR+mBOXa/KbIpfWjONfzBHBwWaxL6xw0pvfgnQB1Hza
	uAX8OuvjgLM4QW6D+/tynbkTKuYJn4cmzTEGDZjzmrDA48u47kTgSXJ9NWdFvVCVc+7+dh3k50g
	FwfsZzvc3UehTxVaTHPkJS+q37umNslC0no2u19xIiQCcMc9voMc+uhS28Q0v2x2dxDDb2IZVgJ
	Ud83ngx2fn68dpaHEGZq9s09amL//3gdmmh7CtCvCNMd90dndBqIW+Z/9r6FoG
X-Received: by 2002:a05:690c:c506:b0:809:fd83:a88b with SMTP id 00721157ae682-812e8dfc9dcmr24185557b3.3.1782922140430;
        Wed, 01 Jul 2026 09:09:00 -0700 (PDT)
Received: from AMD.home.local (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144af50fa5sm1682067b3.27.2026.07.01.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:09:00 -0700 (PDT)
From: Enzo Adriano <enzo.adriano.code@gmail.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andre Przywara <andre.przywara@arm.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] clk: sunxi-ng: Add support for Allwinner A733 CCU and PRCM
Date: Wed,  1 Jul 2026 12:07:44 -0400
Message-ID: <20260701160055.320000-a733-ccu-status-enzo.adriano.code@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
References: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:junhui.liu@pigmoral.tech,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:p.zabel@pengutronix.de,m:andre.przywara@arm.com,m:jbrunet@baylibre.com,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[enzoadrianocode@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,sholland.org,pengutronix.de,arm.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enzoadrianocode@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 864046EF9BD

Hi Junhui,

Thanks for the A733 CCU/PRCM RFC v1. I've been reading through the
series and the review feedback, including the NSI clock/reset handling,
the binding naming and ordering comments, the SDM macro cleanup, and the
question around modeled but otherwise-unused clocks such as the GIC clock.

I do not see a v2 on the list yet, so I wanted to check in: are you still
planning to take this series forward? No rush at all, and I am happy to
leave it entirely with you if so.

If you have moved on to other things, I would be glad to help carry the
series forward and address the review comments, keeping your authorship
and prior work intact. I have A733 hardware here and can help test the
changes.

Either way, please let me know what works best for you.

Thanks,
Enzo

