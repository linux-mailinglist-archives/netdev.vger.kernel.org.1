Return-Path: <netdev+bounces-259564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLloJDFZl2lPxAIAu9opvQ
	(envelope-from <netdev+bounces-259564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:40:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CCB161BFC
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3E3C300B87A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2BB2EC0A5;
	Thu, 19 Feb 2026 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1Lv24s5w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51B2F39C2
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526441; cv=none; b=hmZR9z+M/fVLoEiKUWT88dXYxoWOOyU5aCfU5QMnYFVYhihpx9YpWr9WmiLw7VoP9yCCwld1NEAWQoKdY9VcDEtquzDx83UmkZHN75+fpH2NJ8RYG6+WsGXsOxpDkzmRAULFEAzL3fsR5g+Ja2gXJTcwaacggIp69GdzvghqvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526441; c=relaxed/simple;
	bh=fU3lA7VpwFCxes0Dr9aFEjsRGOPizP4mVR4Z4GdX+xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmEZpa3V9fBqU1/JiAnNRKY7VK9DXLLvozOdCLFy8Xf+TkgfAVAu9OdUGdxoJ+VjTEUq51MPz4yXUGr81zMq7yPx9hJL25KKfmrXn983krjXsPpyPpnZutfP81HKiCLlU1e/EKJgq2Wd0c2rFEt/K2Zv3sMFwoytTIzM0P14Erc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1Lv24s5w; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4152698e745so447728fac.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771526436; x=1772131236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IWO5m5WHHqRoC8lS5ugD/MQKoBV1QdUD735Fcl1Kkk=;
        b=1Lv24s5whiUBlRS9jgCs/OjRSA/nC2s6UI48x4AQjiU0IYdsYgEHQ+6wCN6FRZiojR
         SM9JGUvPbH0YHuGtuzzH2I//6t9n8Vc0StttnhNEyhf0c0mSBjU9GT8iqX+aSEHCWq7H
         P7K8VMtw414/a2qoJ4SDmCxOewzU3t/WEIwReuxifW8KLUcUH84sfwAl4PBuDgMQX0Wn
         06q8Ooxn2sPW6i+okso04nfH29TxpDV24U46QYhhMaPL/xFBTqe09jv8XcANyI7tzMfG
         p+UJeMlfTT0LFHEgNrkU2fFIq5rZYuCKxPTI+MwUAHdCl8G1FLm17UbEIPXKtLxTNg6s
         FjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771526436; x=1772131236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IWO5m5WHHqRoC8lS5ugD/MQKoBV1QdUD735Fcl1Kkk=;
        b=giSCdyKKAaA7MEhkhyeggQ9c17xArJTvT/R5BvWBWPndfoBbGiK4LpPHG/R/ymbk2H
         DqkH/HuGsX6kGLWWCI5q8hAFKMhWuWT1hXtQ/g/Diu9eo+x6yyKkK0IOy0kdzgsdbCWc
         eYkWQBAV7a9fNBX7vbW+kvSVols6dNEp5PbqLUWfXNlTzT/6J+oXMMGxW0ADtTagQMNE
         TYdAy3nciFabgb4/2VWucbXzDk2iXBk+Et7KEDV5wBmoZxHL5en3fPnB81cGiBv4Zo+R
         idYi4i47g8lkMRa3HomH3UzM96D1u25IKleMVkl7Jg20/i/Rk8+nPbiqZ5GMFBOqmtXI
         SqIg==
X-Forwarded-Encrypted: i=1; AJvYcCVGjnqJOkR2vQ2L8YkuLM4DrKh3h91eKu6R+UNH/menDezr76PlSYbP8VfWnpZ0wCHQXmvvTbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2kvIiiSclyNzlBA2yIpzssvDNDSFuu2VU6k6NEk4CnfbNy0vU
	Ulzsc9MIFnAGpJJo3KMVi83HRHubaKPZDCsVRYsWQgCu1JrqOXvo9gpnPhU6JUFnAu0=
X-Gm-Gg: AZuq6aLnuvBJAxbBIprhqpRDVqMGRTpcFqxHJYbHlsIMKwAtE6/ivsdnQg+6tM2Phn6
	jnIp2T5eVVgF7tFMuJXhoY17Fe51rts0jfL1213gHK/ZxAqwrBK+2DJn0ixVqbuPZT2VYVuq6uk
	yKO3fFnh2E7xPcPE3j/RX2Sm0uL4LIASXkVRTKk9aMd1uvPa66xpzCaZ2yQtm26xdcPVmZjId5N
	A2RKC/9QEWP5yC6wP2KLYq4kDbCJNeHOmGTz+cy/44xzpzwBp4I6l3Vx54leczkeBDi7YcRi7s1
	/HtRQnVJrAmahkUQXEJ0t6lIAGPLTewBzvhHYoJqG1YdFnZq2Cuw9SPSq2tBr1BFT8OfxkKJCUX
	dpZU36y4eHyIOMxUlB/r6Cq2Rz8VBwRTWXvJSQlBam3v2z4znBkV7okgjlCbgOtaiFHrelleG9X
	jNHdF3rM/OlhxONTseAeaPWx1b2Jd6pRTLGLXa4DnMluANNbyE0ruvyiOqjfp5FUmX1ebb0nH0r
	CeONVr/
X-Received: by 2002:a05:6870:1587:b0:409:a121:19d9 with SMTP id 586e51a60fabf-40f0d9b194dmr9062080fac.47.1771526436041;
        Thu, 19 Feb 2026 10:40:36 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d4c1:bce:26a1:c903? ([2600:8803:e7e4:500:d4c1:bce:26a1:c903])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40ee62b6f61sm21460634fac.10.2026.02.19.10.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 10:40:34 -0800 (PST)
Message-ID: <751d82d2-0d03-48ed-a917-dbb0cc8a3418@baylibre.com>
Date: Thu, 19 Feb 2026 12:40:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/18] clk: mediatek: Add MT8189 vlpcfg clock support
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Miles Chen <miles.chen@mediatek.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20260202062840.342707-1-irving-ch.lin@mediatek.com>
 <20260202062840.342707-7-irving-ch.lin@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202062840.342707-7-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6CCB161BFC
X-Rspamd-Action: no action

On 2/2/26 12:28 AM, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add support for the MT8189 vlpcfg clock controller,
> which provides clock gate control for vlp domain IPs.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---

...

> +static const struct of_device_id of_match_clk_mt8189_vlpcfg[] = {
> +	{ .compatible = "mediatek,mt8189-vlp-ao", .data = &vlpcfg_ao_reg_mcd },
> +	{ .compatible = "mediatek,mt8189-vlpcfg-ao", .data = &vlpcfg_reg_mcd },

These names are a bit confusing to me. I would expect vlpcfg_ao_reg_mcd
to match "mediatek,mt8189-vlpcfg-ao" since they both contain "vlpcfg" and
"ao" in the name.

In other words, this is the naming I would expect to avoid confusion:

	{ .compatible = "mediatek,mt8189-vlp-ao", .data = &vlp_ao_reg_mcd },
	{ .compatible = "mediatek,mt8189-vlpcfg-ao", .data = &vlpcfg_ao_reg_mcd },

I suspect that the same improvement could be made in the other patches in
this series as well.

> +	{ /* sentinel */ }
> +};
> +

