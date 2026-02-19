Return-Path: <netdev+bounces-259589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCknHlZ3l2nVywIAu9opvQ
	(envelope-from <netdev+bounces-259589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:49:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D1D1626CF
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DD5D301E995
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601130DD1F;
	Thu, 19 Feb 2026 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OnxGDHIE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20013957E
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534161; cv=none; b=smjTYtYG0tRAcGJDGUY9qCE4vQgEMhn7dgVDdz+DjxJKMobpaCk65snhiTag5shzl51m1tGQJUkPUASsKl0RX9UjS95UbWx9aPKtcIjNwOs2qDLWynUz1GBt2c9E9MDLzKuAWK8X3XRez7FoIP3T0vMS+GOPF8qc2XOy3pzfMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534161; c=relaxed/simple;
	bh=w9oLg1R0wW4uMVOKbUTIgtKGy4OR4ye6n/7fMiajz5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALf8hvffCFBL6HkiZBnlRvugt7WpqjKl1ESG3MzHzgopVmclmd+ypHBmuKpKI7Q7QKhOKSZKXti/EBib1C1ADSALSjU0a+vSGwelr6wMpZwcNOmOryjveFTImEetjZYdd7lN1ck3iv1llAYVzTDdGxG/eW6YMZlTLZhYETJpEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OnxGDHIE; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-46391e91e16so821356b6e.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 12:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771534158; x=1772138958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtgTLfGOcjGDe5PL0CHRRM4ZPGAPDgJhQWgABhxIwOI=;
        b=OnxGDHIEpSgwydxSo+Ox0VIZVoezIpwv0gPA9dVBHDoIXE+cFEhYjiudytjBVTJLi0
         haAJDy4WNEAh0KMiVylCLsKeVZGR/1j5Niy8TNxNd2jNxpWrCZbkSejWOQxzcE4epwua
         9NVQdpdK6BjwN5k9nO+opyGACXpSaK+GxRNKCh0okr6pTCLiWn1Zixw5HIe6WTQF9ABt
         aLdvpQjgYbeHSgSWCRIGsbNhXfj+ZoGdSP9PDQKFH5nGFpvOqAtCz08TpneJBdUPmqba
         FQodCMNIHSTG63bQkGY9N8/2WdA2ZhECvS9MABFC9RyqQddQ81zeKOKpsaKKWefmh3l+
         X1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771534158; x=1772138958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtgTLfGOcjGDe5PL0CHRRM4ZPGAPDgJhQWgABhxIwOI=;
        b=oNtOrR80u/HVaDcKz5wKjWdY4YHEVtUQbJlDwwHvMlNuRVue6jy/5D6K6fYiK+G+Fu
         MAEhtBl2DRuDM5t15xm1KSEz/dae4G5BzzsD3AHiaWfn47RRjMPN5jGfoz9d1T9Yy0dh
         CDWCsCfmAVT9IivIwjRnnnGFjCxBp3ujfSrxWj3+SfWbHUiVpbuDX5h07iNHoWxaambf
         R/Xuw7HM7wJN/LqQicf+yhNYZslyFP0bMPi0cmYhFbb2ULlpY4BEwG/jCPDrMEyt910p
         wdxf5KJCkNfPsMZfHiO9XONDpCiOXzAAIvrb1MjXx/74igsyHb3PUeXcCwmvaDl1H1Qz
         CnSw==
X-Forwarded-Encrypted: i=1; AJvYcCUFOth6boJnTlgBr7kZqSm5X9WhXGrtcuxgna/XlsKB6BCKLDQHW+RLm4pc0HtJfpuB9v1Qdi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4DGqK9nnD+vhb4BU6WrJvHXdA2Anie1aHlJ+fGhB+l4QMv/d
	XWSxSLejEREZiEJkQI0x7Ep1Z5QuCXBKfsyryp9O5Iv/A05j4y3dBOOSIENSqmFdDZc=
X-Gm-Gg: AZuq6aLhLSY7348d6n1R8T/g8G5p48GCwPfjYwQfPl1ZVI5SK+GSecEegBpq5fG9Q8j
	1qv6njoyel6EL5wJwKMAC/1lDPamy/cpkTrjmJGjcrecJDK1FfWZzJzmfvmOUwgdhRQNOORYO0j
	Xm7Z97RE6c6xKWTVtsVkXKbnUpLSuP77TS7UOehLoqT53xkHIG7sop0gomiUEvlsV6XK5KwbkaC
	LSPbh1xz14qLiH8IwbnU2vftLPmGQr6ImNKw0mgOHXmWopMwHsR6n6XQZdBye/hXr7tOCn/7TGw
	ZMfloanJLRnXPBLL8SHu7gWtWRQsU3VOIynML28QqAwZpcaKD0lhOWm1OChy3Nhhyf1C780WSnQ
	tWOyCPoVqV/xtiqr6NoxmRUBTU2AgNraqNoKFk6axKKkZI762/cSc0ZJ6SNRkM1p/F8NBuSSDc6
	SDeSSn8DKPkY9n3GzBnNR2ElwgNJZKpyuajEnUgGwRZoIQR8qPNTucYL0q4ndB5h6Z86vNhKaRS
	NW+DFyU
X-Received: by 2002:a05:6808:1448:b0:459:b569:702f with SMTP id 5614622812f47-46410b94689mr3904867b6e.15.1771534158258;
        Thu, 19 Feb 2026 12:49:18 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d4c1:bce:26a1:c903? ([2600:8803:e7e4:500:d4c1:bce:26a1:c903])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-463a4ede045sm13618351b6e.9.2026.02.19.12.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 12:49:17 -0800 (PST)
Message-ID: <4b22e998-b38e-4452-82ce-1389d7086a04@baylibre.com>
Date: Thu, 19 Feb 2026 14:49:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/18] clk: mediatek: Add MT8189 vlpckgen clock support
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
 <20260202062840.342707-6-irving-ch.lin@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202062840.342707-6-irving-ch.lin@mediatek.com>
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
	TAGGED_FROM(0.00)[bounces-259589-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:mid]
X-Rspamd-Queue-Id: 20D1D1626CF
X-Rspamd-Action: no action

On 2/2/26 12:28 AM, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add support for the MT8189 vlpckgen clock controller, which provides
> muxes and dividers for clock selection in vlp domain for other IP blocks.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---

...

> +static const struct mtk_gate vlp_ck_clks[] = {
> +	GATE_VLP_CK(CLK_VLP_CK_VADSYS_VLP_26M_EN, "vlp_vadsys_vlp_26m", "clk26m", 1),
> +	GATE_VLP_CK_FLAGS(CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN, "VLP_fmipi_csi_up26m",

Should "VLP_fmipi_csi_up26m" be all lower-case to match the style of all of
the other clock names? i.e. "vlp_fmipi_csi_up26m"

> +			  "osc_d10", 11, CLK_IS_CRITICAL),
> +};
> +

