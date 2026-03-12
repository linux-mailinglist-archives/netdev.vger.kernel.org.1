Return-Path: <netdev+bounces-267198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMwLH/Ids2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:11:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A22278912
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 579A03151E65
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A20402427;
	Thu, 12 Mar 2026 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MbG9nDAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EBB401A2D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346031; cv=none; b=rjprgusesbeYocrjOVLh85A8yAnzcbM2WKbwypghLW1mzt86uFT1zF9fZOEoT53/6agubq3htobGovDe4wu/fwd4BWnWcAyRAJc5XEDB3PanGzcRAW2HzGcFETCfubP4vFtUzmeLN9IJlyXWK3wkZbgVgUw3ST0oym8CzZy0MBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346031; c=relaxed/simple;
	bh=lKJ2mS8qshYtbORsyK0ngNUDnpsbzs9HMnnIPPn7MQw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YyTWJFUf6G4Qd9DqbL7ykrwTseoBM111y67DXjtPoDlEaKJO5uijivkpNOnYVslWjQi9MR2itQKggesmOvjNgAdrjavXN28FrO2pwEROOz7Emo21dl+rEKeXkecYV2kwlRA9G5FuW3SMq4nnfHNypZOYbzEfpggy7OeuTpsVFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MbG9nDAJ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4043b27ddeaso951799fac.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773346028; x=1773950828; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+y1WK9bKYEMzE5cM7mHmluwniDdPir3jTdVAfeucGs=;
        b=MbG9nDAJG8oXVSVU8t/6DSIZFv7mTU2fUcI5uV5nA9/sa7PdWx7kcMNZDg1kPYzS6e
         1NWXFt74kSIqAU1QrJ/C7q2k+ZPTioNZHDXu4XYborZ/1HK17MKWCJjnKm+oQ2DtAHL8
         swpCIQEM2o8hOD3u9K7jWdIvHEZVVvwXw7KdsDjqLERZFiZKXGX2pu2IQP4V0RxbHghh
         S2cI6nb8clmayty3SLl4XZflwpd3YjiUC4fvn3giwjua4pDYAtjH0RpK8aaSMp5vGXVL
         dGYTKYzofzEpthE3kXGR1FnIG1EmLRNqYgax7mtvM1x7Q8+gpJOsn9DTJq93ESUmy7ZA
         lI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346028; x=1773950828;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+y1WK9bKYEMzE5cM7mHmluwniDdPir3jTdVAfeucGs=;
        b=hFVmg934EMIx9Z11MxmauxVmFBbHPPnDe35Lg7mTVAwNO+hMLec93/k6xtNamFB5/d
         GguFn+AoUPiBNMbzU63lbqOjkD98BaTMSTSye+R1DtNTCbGFFaHZQemXVjOdLyCtV7Fj
         C4DkZbr7tL6D9pyrt8NHCouZk7Po1Heyeoha60WN36iTVD2PFA/Ht7gQKVAofyavxk0S
         xZTOyADu0H21UeiAQECE74QLdJFIs2KpJfBZrzYSitRq6pj+1l8hOpX5/i5jjTOApJfL
         PDzXfQvkpYVVwxSMSDXnSr6eloNEiiB8/rAstX+ohGI1g5gUvHKDQri9fho2p+8i7t4i
         HBrw==
X-Forwarded-Encrypted: i=1; AJvYcCVjBUHaQmauOw0je/k8Py3H/WNdCdJ++CJmI1qRtVl7cCDkfaixSSiYAakkLItFizxgOgl+l0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUjz3RwMa4r5H80MUPfmz2UwKbcEYkn0LWDPlPEmk6Mt8/GSv
	RPLKnzUCQ0FdjJYvj8AFkS2GVB3YbkMSPkIjzUstHTCumi//EFbPdueoUxtOWCgmwrU=
X-Gm-Gg: ATEYQzxMY7XnS0CEwymSpymMdGxNCqeZlRAiD6YNOuv2DqsqcasT+jfJwoRcIyaDRU3
	JoQUnaHQZAI0pdWhpCJaE/2cD9ozRwoZj9l0j+zBoZsSFmPu6rfOPCxvbTL7Oqj9gbXcZI/6wc5
	Z1llX7iApFVkUB2xtx5MkBJ5+a8ojcYAxGk8v1p1rXi7O4goo6AXyYcyY5a4UKwAeix9cMLHFrl
	zBu1N6AF3HXXGNIKj2qrV8u1+hV2jOX4X3Qk+7a36ai83Ohs+/E7UAKPPa1Vna/sfCLte2LfiS6
	TLkcX3Sj/wZJ/A4kAOkLz5AiTBwh4b39kWRag6c6nXm+Se1AlTQ483M2MBVppUrVb1JlOOGw6tG
	J340xLfsz2GrXXh31xIU+I3Mxtfmno4n9f/Wkm9YcTDsbBV+A1HoOZ2xx/lR9rKFgdPOI74DDhj
	YU/JYCRq9ufm6fO6K4uwKqKdZFKu5J
X-Received: by 2002:a05:6871:3864:b0:409:7a01:6e2f with SMTP id 586e51a60fabf-417b906d7e5mr406126fac.11.1773346028068;
        Thu, 12 Mar 2026 13:07:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1f95:f82e:8747:8137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6c7885sm5600081fac.17.2026.03.12.13.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 00/18] Add support for MT8189 clock controller
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
In-Reply-To: <20260309120512.3624804-1-irving-ch.lin@mediatek.com>
References: <20260309120512.3624804-1-irving-ch.lin@mediatek.com>
Date: Thu, 12 Mar 2026 15:06:36 -0500
Message-Id: <177334599652.4124794.2284323207748123029@freyr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=515; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=lKJ2mS8qshYtbORsyK0ngNUDnpsbzs9HMnnIPPn7MQw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpsxzPi+0zWeulMgYec/oNHyb8sbOm7PTreogHt
 ekbB22puQqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabMczwAKCRDCzCAB/wGP
 wDfIB/91n7afDNKVMM1YVnaRi8vpX9xoS/2fQLT+wzZC/3m9wr58g42+Hy7F1+SywRjBf8f8CWn
 BlwpL0zR+GBEnDlPiWeCojMa/oNotD6CWbl2gXYC33sllryI2rkGy18PxfunAxpNBAm06vWz6Lr
 YvsvuBJ7kEUcqf8+DH+bgCKLL/2fWxaI6Cpj/rggJGywF1rJMvK/5qwFPiuIUVDAV3xRL09Firz
 uDocVTpeY9TqTi2Nq1MU2MfD+UH2EKd/SzRjDlgDoyOmTefufsLWnJCeARld89Zvg/NIOTGWdkC
 WVTaGeyWsXb+6V8GO7rcJ8/3R5W+W5sdRGFjjE3ewiwYd1Gd
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
	TAGGED_FROM(0.00)[bounces-267198-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 26A22278912
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 09 Mar 2026 20:04:42 +0800, irving.ch.lin <irving-ch.lin@mediatek.com> wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Changes since v6:

So this should have been [PATCH v7]?

> - vowpll/aud_adc_ext are fixed clocks in dts, remove from bindings.
> - Remove unused clocks (clk_vlp_sej_13m, clk_vlp_sej_26m)
> - Fix confused naming: vlpcfg and vlpcfg-ao
> - Correct naming in vlp-clk driver: vlp_fmipi_csi_up26m, vlp_pwrap_ulposc_sel
>

-- 
David Lechner <dlechner@baylibre.com>

