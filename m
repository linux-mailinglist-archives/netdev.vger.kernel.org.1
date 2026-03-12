Return-Path: <netdev+bounces-267199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ps2DAAes2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:11:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB3278931
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82B7C316F0E9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED38402446;
	Thu, 12 Mar 2026 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hkLUX7Ae"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF48401A2B
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346031; cv=none; b=Y6hHpWnPiSGHotozaziMYJkr4kgo+zPIcsuy7SetfLHROrEdNbEC7doFw45jcgmfbdskl4pyR65JG33cd187NE+jcsTdaM4Miax2xVT6PE+SnvXTJmd73o4yZCQqbO+rY5BcnyjQC2IQ9CdKWpiYjSZ1w0Lq3WHpLq4eKPmSZ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346031; c=relaxed/simple;
	bh=tkQxE/WaHOTyLw9z/sp813AJR6zA4pd2NdpV7fP6+0M=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Y7R3lOZlNaLsjsRynuFwyEfWfDthN5QfsZUSPFB1/qUD+b6s0SaBMfN1gM5DsWL7qy8BDtC2r9JQnURxxR6omSa6PeRkAzAv5lJCDwHg9OLgNTy281fHvL2kY+sx+CDp1+2XtbZgiOARRHy7Kd6V99kAMFooeL3PF6czj17hpIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hkLUX7Ae; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40ea36b56b7so1097480fac.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773346029; x=1773950829; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrfqSRvy369yVc6mkzBE9cxk9/iWVTONTSjcJTlQJR0=;
        b=hkLUX7AezApsn2UftlxCJ8GJ/vrCumzYXlseIeyLMluuINpCxDzs/Ae7ugqMbIeoKj
         1nV5oXdDSpWXjLTvht+TRjhEfYBJF9luuw5agujzRoLdCK0QWQJlMJ23rB4AuXWsrMSf
         ZVEO7KxxLrdwK0isqrQHjDA8cGDM2CARAuusAco8/1bErafCg86zlOZVjbJnKvZdyetB
         75GiscdohhYZ8q+sT/wO1DUpdnMXzqxmdG9He93qeC5KRomW/d+9m4ahhDp1Op7WDV0Y
         pyJsmT3TtTBOSfSdSYOsSL8KHAF8oI/eWrPveWjg2QgibaeW5YWu5/FfgalOZ3omS2TW
         k4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346029; x=1773950829;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrfqSRvy369yVc6mkzBE9cxk9/iWVTONTSjcJTlQJR0=;
        b=Wx8EkwxMW5scVSfNoqvGaHOFC+ZCyNq2IjOU6s/mI63cZq1bsQOpRh4TTNKC4fpK77
         xk3wctxN66KeGOU1/aH36RGvtflhp8csGkBHKnVJ9DTChWYio/eVwUopGyjDh9o5Atcv
         Mib+vy0icx2bahU735PzSka27QYJwpXvxZQsIH+05dd22wa79p6UQYzVcALi+Ec87F9f
         xGYdG6jsyHEVZj7HIVmqg/OcvemZ+3oDXOkLER9TnVDXB8RYTCR+Tw3IEnXtdlntMOMr
         KGVy9L4WNZOqGleEw87M4iY0l3ijZrHUFAyPXNXQFZEJT1+P8McqqbF/0YI+essi2lCB
         DGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQelDNKcFF/lZBaIxdlMd6Xx41q6VIdnkAN/+gYFDGFddZzSTkoJrPRnNOuKrWbH+gMpq8WDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkaFM8ONiZvxeomIZV531SN1jcc0Pbn3YiHwVIQCz9j08adUKy
	4dIJiUkfmqmuG+Rnz4GVKWCwAa2QZwLRhRaTEA6ZyQr0Ti+TaDsQPhafw5J9qDCshcA=
X-Gm-Gg: ATEYQzxREMXLUJwCIilZaSbEh4mOCzr2L07s2wRbiRpoFb6fsfybcVbFB5EX0h9Escd
	dd5MQPAXZRwp9/+BtCbiVVcpljidn2XW4ZGRSnjaJxQTIs/pG0UaH9Sf0phb4juWuShATIpEh91
	clRilVx7tnnXZAB7QsGoep0YDrTiY+3yjMRR1f3Dz6CcaBGXnAppCCxhBzoa1+o1ygGCarXK/PG
	E7yrzQOznwLW6JHIdTJ+eAcyJvo1y4VvZrhr7NrKxc5od+qVW1GnOxYd4/gU09yNryRifIM1xs3
	7AJRJsYU3TGFzhR0AFXYzeWwt/mh0pM1ax1bFKw82EpNCqKA6djgJKV/rKLiha3mNBDHRRAY/9H
	mdgzj5I9Ih5qBm+rFDX7iDwjAlxMmTsG2WziKwH9u2TAp0TH0hUQPYm6AzTMMm1XJE/DcBdm9dP
	ksC8kijABgEGLimg0idzvtPHnU/DhYLHNMHQHVe7U=
X-Received: by 2002:a05:6871:5292:b0:417:482c:5c0e with SMTP id 586e51a60fabf-417b93fd827mr366324fac.43.1773346029164;
        Thu, 12 Mar 2026 13:07:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1f95:f82e:8747:8137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6c7885sm5600081fac.17.2026.03.12.13.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/18] dt-bindings: clock: Add MediaTek MT8189 clock
From: David Lechner <dlechner@baylibre.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
 Miles Chen <miles.chen@mediatek.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com, 
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
In-Reply-To: <20260309120512.3624804-2-irving-ch.lin@mediatek.com>
References: <20260309120512.3624804-1-irving-ch.lin@mediatek.com>
 <20260309120512.3624804-2-irving-ch.lin@mediatek.com>
Date: Thu, 12 Mar 2026 15:06:36 -0500
Message-Id: <177334599652.4124794.9130759829438828661@freyr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=520; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=tkQxE/WaHOTyLw9z/sp813AJR6zA4pd2NdpV7fP6+0M=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpsxzWwLcwCiJ8Z4K49ki7iVfChNgBVHE7qCgpm
 Y/2/Iw4lzGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabMc1gAKCRDCzCAB/wGP
 wC7SB/0fcJl+IqsMtJ0KbpayFuuIWaEoKx2Y+kspgWFvDk3ZZN5eiVoAGyzSde4TNg8/MKEDTzR
 zssxuG27VwnhdKRK5hXY3KyVuHfvUo+Q+l1vWWM6d47IkLLuJIESKy+aV6ajhGZD5ExQkBpqLUf
 /vCSyDwGMkE9rkFHUQ9p6WuFUFifDb0HOWvcvuM9MQ36kTfp9Ub0ufAYs4MbrMujowXIBE5YR5K
 5KfOPmbBOw6gtvbrhPFp8Jcwft/caJjstn4wz3XNF9+w6So2N7A2xaO+U+M3NrKjgHLBAscD6wX
 SU78NqGacCN8wXbg9BmNJJebWwHSdHSmXbCCXImCwsfnHKTq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267199-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,mediatek.com:email,baylibre-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAEB3278931
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 09 Mar 2026 20:04:43 +0800, irving.ch.lin <irving-ch.lin@mediatek.com> wrote:
> Add dt schema and IDs for the clocks of MediaTek MT8189 SoC.
> The MT8189 clock IP provide clock control for main system
> (apmixedsys, topcksys and vlpcksys) and
> subsys (eg. peri, mfg, venc/vdec ...).
> 

...

> +#define CLK_TOP_DRAMULP_CK_EN				205

This one does not appear to be referenced anywhere.

Should it be added to `static const struct mtk_gate top_clks[]`?

-- 
David Lechner <dlechner@baylibre.com>

