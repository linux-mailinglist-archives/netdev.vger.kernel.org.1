Return-Path: <netdev+bounces-256463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HwqB7tzgmnBUgMAu9opvQ
	(envelope-from <netdev+bounces-256463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:16:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B8DF26C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B83F30257EE
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D999358D04;
	Tue,  3 Feb 2026 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CNGGKORq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B21326934
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156982; cv=none; b=KDG1qMZY+5qMIO+ZqAxpSOgJPiYk9lT8FgqrnaCoN9DxhH91fseT/+2Zf5iLHEY3Ip79eLZtGB4bq8Vdj8julW0HPz3ttSMHBXGu2tu1lbaGplRxCKL7tVRqsjJnDKJxhTbXAyh2N8uvSfIio0/JDJkljJJkiN5A0Mi2eHQX8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156982; c=relaxed/simple;
	bh=Is5GYtZerD0NK6E8ZXSCoqOK+wq8akx9no2ZxVMphmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToxQE7tyQy6kC+/fUl7ddMAzOwIS59sYrAUxObczYHw/Jhdurgh26hU4VDNSoMAIurn8aqcSSTlWEXTgQ9CG1G9/vD/6fYrGoGAYVDxxaIvkX3s3VHOV4K33vc1Or1hZ4sDA6Ttd1M2wVkQJtN6Ha/qClz1Wlt5gZjIDFQnrM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CNGGKORq; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662f9b82a36so2410991eaf.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 14:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770156979; x=1770761779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7c0NPTkqLZrpseRrb77cJ9keUj/pZc1R94Glr/7UpBo=;
        b=CNGGKORqtFd3qtxzeCJZhThoKg8Nrfi+14pIM4nFOXok9C6uQOU0kJBh8Z6FQUWnMV
         0CwzPvF6wDiDrqrQDqouK4LFcbWwm6T9ccEXMdohS3+ZVBkjEnp8TFM5nM9U2XwhFneX
         90Dwo+3Kc2vVqXtZ+vzW+Q7AUaPibt/zqeUzKRD0QjxURzBPdpuNqFfuFQKF0NaZK5NR
         9zWveKK5cHluQuRmeuwfqO8fAL6rzDU4AtJdzdxgcRu2Ks45N90CJo+OHE6VH45agw+l
         Z54HKeifdJeU2dKO8cK6pzz8psKCvWPH59Zq+9yIVB1Fo3E2JiZ427bEpljIAWxD6pda
         2opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156979; x=1770761779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7c0NPTkqLZrpseRrb77cJ9keUj/pZc1R94Glr/7UpBo=;
        b=OZK3boqmAVgcqhhNT8msfMuHpLBRUr26g6kbqY8CJ0VL2OjfkpIDvKeFXuTeB5jWzE
         69URktSylaxLP2Tpzn8Zv2LF+OiecPS0PGie8DZIhw+XuRnlAZQ9c88nMberjKdzdZG2
         iIdgAt/3siMQZNOllwYs/Na71Kt0htOr4Ti7nc7/f1p8zBv5F+aIWDpS8efJZPAjrJyi
         gDuGwbd/9G0ZkU/AMBock4Azi0gB7hB7+RtlUsmrYrGR7KOXBdK9kk+sRKRpndX/VE33
         Kimsbk5vWTQrT+yMPRM5/Enu0jCagzs0S1RfJIsf4MkSKkei40q38kcrVp3HCkdEl8XD
         /xpw==
X-Forwarded-Encrypted: i=1; AJvYcCUs8QdaFVI3zVeolpkGcjtMG1tcf2Es7P5DNnyeLd1Ze2UBBItz3LVdcHBcXv9rIVCbkmOYImk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVlGVfgs3Abtu0NCHFUbqcsqXNfVO+hQ0dO+eEbAbOxdTF0zp
	VfbEkP3j8pUaUmYVVxkfnk3PAQZnINKINtrGyFePH9QToU0In568BpvYFb+78tl38uM=
X-Gm-Gg: AZuq6aKj1QPdw8MFaYfw2CMVUV4uVKTF6MFKy1sh1B5l4lkwMppIt6S9Yszy9TD4cky
	EFPS1F66fm4oEPRB+N2MVbXCujDmkZViDfG4mLaAoZnTk/qbIq2mhsDcH38S6XqCqwFD0tTRdna
	ITHDPZ+ADD7L/ConW27wbjOS0c9j7D3OKMjI9UERr7hwIWU+uY54IGk+qxv4hlOXv8RSq3C/ONf
	7S4J1wGLHN6JCYpXrNX2FDuV85e25Yshoc8WK4Mvx7AUhLDVB+6nSPGz8/rUBAxJM//7aDMMoFP
	MdgA10TzD7b6TB9I4Ntu8T80M4aliJvDnFsknhI7xwwhKVh6zg0ckH6NPkmVy4eQU11WN5ncMC3
	45bytABFzNhspyqksMR/xeagVh17OocJZstevjIUfPJMBYiK4Wg7WkEb0uLeG0/tIZAOSpadyUY
	+wVf7GUU3aIbVUMYr+RGvwgeIFQxCO9rPJZgOGRK82huGYU7aTmlBG8M4=
X-Received: by 2002:a05:6820:f09:b0:65f:66c5:c3e with SMTP id 006d021491bc7-66a20d658eemr547793eaf.22.1770156979083;
        Tue, 03 Feb 2026 14:16:19 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e13:880:992:e796? ([2600:8803:e7e4:500:8e13:880:992:e796])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a544e77fdsm481769fac.21.2026.02.03.14.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 14:16:18 -0800 (PST)
Message-ID: <37d5b1a4-93e2-4fde-ab56-186d34f8835b@baylibre.com>
Date: Tue, 3 Feb 2026 16:16:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/18] dt-bindings: clock: Add MediaTek MT8189 clock
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
 <20260202062840.342707-2-irving-ch.lin@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202062840.342707-2-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256463-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: A06B8DF26C
X-Rspamd-Action: no action

On 2/2/26 12:28 AM, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
>
> Add dt schema and IDs for the clocks of MediaTek MT8189 SoC.
> The MT8189 clock IP provide clock control for main system
> (apmixedsys, topcksys and vlpcksys) and
> subsys (eg. peri, mfg, venc/vdec ...).
>

> +#define CLK_TOP_VOWPLL                                  174

This one seems out of place. It is not used in the driver. It is
a fixed 1:1 divider AFAKCT, so should not be included. (And this
line has spaces while the rest of the file uses tabs for indent.)



