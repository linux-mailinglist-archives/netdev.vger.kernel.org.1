Return-Path: <netdev+bounces-304236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bS+XIWapRmr6bAsAu9opvQ
	(envelope-from <netdev+bounces-304236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5C16FBDDF
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:09:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aoABn74j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304236-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304236-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEDBE3143651
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580AD340408;
	Thu,  2 Jul 2026 17:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227EA31F98B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:10:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012226; cv=none; b=aPS98is+xSEQzT2aOKOZNZMbwK4KqdaUyeC2ArttW4b3qc4kpzCDeCVnSdl7SkwmJoibWFzku6XlhBr2QS18W5RtE9i7rLxl3KpnA6H8EtDXLdTcL6yuHz3U9xP8Qr5xW7YisoZEAOkVY4t/r1ws5rwsMIYmESXr6ZyhoqOv9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012226; c=relaxed/simple;
	bh=ZACK+Wxf4gf4Bv0H2VF868lUB/6WpdvSpaEj4a+bI0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mcw0mCfZMzWmD2G3QW+bPVgBke5oFuEqKlqxmfRtzk0EM/AvcVPa7VoKpHj6e56U3JVRmswrowxoPt7MAYYoLS4wj1e2FwCQS3Q+jvJxW9ALn+ZRdhZRPYxrTgRMTItsTJSLB23YhzMFZ2JSujPmKwYFrn5bVpXmDCrbaWferq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoABn74j; arc=none smtp.client-ip=74.125.224.41
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664ae993e4bso1673783d50.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783012224; x=1783617024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZACK+Wxf4gf4Bv0H2VF868lUB/6WpdvSpaEj4a+bI0k=;
        b=aoABn74jmc6ri5jbKOTOoCpt9z0X40s/ceqaIhyaC0p9NOqRHV6wNqaz/Iji2dQD7c
         UZepj02NWtBjQSNdaPRJl5QpCjhtBkdztn5f50zSTQrFbnlcOe5lDUpO7CaSPuzCQuKO
         C3FTuWuNpp5oxuvn7kmIkhw6F/uU7E55tLsCC4RMNWk1njx2vA5+6UnhxGpwViOj2/Qz
         ctni57tMsinTf7tEWCnFxDsHdSSuIuDak/geZ8OJfQhLfQJgIaIArsFSEuBvWT2exCHe
         iMWWZCV3LDe9QKbvbtuebSeq/t8mJnJXzHk1SoTJUIWN4hWDYwiSALTcoudINlInuLv4
         R+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012224; x=1783617024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZACK+Wxf4gf4Bv0H2VF868lUB/6WpdvSpaEj4a+bI0k=;
        b=q2n/UPnE61+Ab/9tVX1nmfF7gnmUjeDaECWueEdtq8+qBRjJnQuXdKLhV0o+/86Ik1
         llJfWyVSIhSaPD6Q9fo6EJPcDRfN3TmtkPLactv0VoDgy1/mF33/WIa8qMSwXkrxKyZ4
         rnLBbt4ocq+rWmfpQHHEHG6CwhQtsQ2NeZnVD7/Qda41Wt66AY6hHaekTg/YvyHAjmXD
         2jGouWFsAot4w9Q0yCUs6AeMdW+49xgz7ZkUod5NmoKFbLByYr50AtjzAD3o4lpZqFbq
         eNj9QIwTRLEZ6v3pC2YL2hi2LxqO4xpEaSNIWj3nPPfYYR0yjPgnNmywcHh9olLo+7+3
         WVJg==
X-Forwarded-Encrypted: i=1; AHgh+RqxsYL2Npqidgxq+yrAyYVVN2MV/6+83LPiY4qXLOHCaKt9hJRhBYEHEkUJOhtzOEqUmS1LVPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynPHa8NeCpydd9iC/j0+GeNG6P6SfT+dstVLmW1KMXrQO4sfjW
	qyFXxegiKYK8Q6UrlqaVnBVeQxdmpIhgUmwi62I6Af9q8RY6iP/FLB31
X-Gm-Gg: AfdE7cm7+RKOEc3g2R4zZNMqLs3xzZY1LIo3jiCrVWOuiFsx7deToQikFDdDXJ2lJw1
	nPJ12IAQ4uKm2tBzOvJOGHHMq/YLAXZzpdo3JCL2Qzm0JqcPKyorKmAfecSQGWT+fsz6BzNp826
	ISnDzjxY47vvCKvNDk4fIAHjM79ZaEX3vzSt825prLKonDdDmqG0uaQqS5o7SdkGgc7P22GSeqd
	BTji4vQlU2nTcqpvf4KHkzyfpELQN7XbuQoGfQkUCX1MnSf1rvGx1TY3N4Rp7tuAB0Yx7AmWoUh
	veRhT9t255GsnfupXmfca+iAR+fXZVtL1EXn/p0PbsMzRSxThECuC7AHTaCfkF3iZjMEYasj1Gr
	PVZzcS3DL1sCP30H8rffMp1VargnNnj1FDtrZ9dpn7cbQPbg8xQhr+LHLQ09Fa/Jk1gfIqrSfPC
	gB2ej0TFUxzf/zFZgVDgkky0WodTP09hSyVzTy/KniW0N92ztqDehQhFsTBsYe
X-Received: by 2002:a05:690e:2447:b0:664:f562:1fa5 with SMTP id 956f58d0204a3-66636ba95e5mr448218d50.46.1783012223973;
        Thu, 02 Jul 2026 10:10:23 -0700 (PDT)
Received: from AMD.home.local (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66624021a75sm1354880d50.11.2026.07.02.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:10:23 -0700 (PDT)
From: Enzo Adriano <enzo.adriano.code@gmail.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Brian Masney <bmasney@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] clk: sunxi-ng: a733: Add PLL clocks support
Date: Thu,  2 Jul 2026 13:10:20 -0400
Message-ID: <20260702171020.836546-1-enzo.adriano.code@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310-a733-clk-v1-4-36b4e9b24457@pigmoral.tech>
References: <20260310-a733-clk-v1-4-36b4e9b24457@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304236-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:junhui.liu@pigmoral.tech,m:andre.przywara@arm.com,m:bmasney@redhat.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enzoadrianocode@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,redhat.com,baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enzoadrianocode@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED5C16FBDDF

Hi Junhui,

Register check for the PLLs against the public A733 User Manual V0.92:
13 of the 14 PLL control registers match the manual's offsets
(PLL_DDR 0x0020 through PLL_DE 0x02E0, section 4.1.6.1 onwards).

The one exception is pll-ref at 0x0000: the manual's CCU register list
starts at 0x0020 (PLL_DDR), so the PLL_REF control register is not in
the public V0.92 document. It does match the vendor kernel's CCU
(SUN60IW2_PLL_REF_CTRL_REG 0x0000), so a short provenance note near the
definition might help future readers, same as for the other
vendor-sourced entries discussed in this thread. For what it's worth,
on a Radxa Cubie A7S (26 MHz DCXO) we can confirm at runtime that
pll-ref produces the normalized 24 MHz reference with the hosc-side
clocks reading 26 MHz, so the modeling demonstrably works on hardware.

Thanks,
Enzo

