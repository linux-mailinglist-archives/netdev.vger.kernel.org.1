Return-Path: <netdev+bounces-216076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44217B31E4C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AFF1BA59CC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D2307ACD;
	Fri, 22 Aug 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dSYUvsAP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA1227EA4
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875832; cv=none; b=QxCn9ahHjipoLekQaVHivjdPNQjRT4rtds/gZKQLTvoU7wa6rM2BNAttNMtrUFh3hJOybZTDLvDf6Fxu/lqaP56Nsag+0mf+5HJEdQC85CRe/7JxnRkacK4a/RsLAyAdakffBVlcPQulYPKRYk1u8XmxwOItgMwtGb39kaOj+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875832; c=relaxed/simple;
	bh=y24e09Te60oIGgGJpyKrT8gzaOYkUAB6uCKHewL7Pbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W56/KT8WlD5b31QQ+fEYUnZgf9tAsFtCUJ4dcZpbbzM6Imjp2ZElz961tgUE3o275KTtBgwx55Zf8A5n1SIUhAbBx0RdlSsqe4GjWsur9DHTuwdmxSFl6JnWmJjtah9z9EFD2kimTalBapY7OSjZowIOvtvr8mmpzWbid1W3riA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dSYUvsAP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso17107275e9.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755875829; x=1756480629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIKMURTzGnc0o3Eec57Nl0ZpPfL0lnmgxqpSyQAZbI4=;
        b=dSYUvsAPsiAcmzim065bX3bqQE4/9iG6eyy+tqkYqF/DYV6auiTfuPCranA4s9c4kr
         AOUehCA96epnFb0w68GcOHxH/zfIBqlhxtajYiCFJnUfy3+k++CvTFtwQPDsr9Izf4xe
         Tqd1QA0rbRv1XyYzay0Ej3YOIhjvqUGoxJrRx5asJopwtt7jpLxTdLIZbqpEtAVpMtZy
         Ox0kdlmcM8GGRz53T5N14lpwEljM8Ll0hug4yaIobFy5RYalFNwCSDGui6/MAarUlzTe
         r8fAS1aiPtZai/wbJLCiPS6ZJJZ+EBpaiep2/s3v57qUmxHH5HrQVBLBNITieNKptWgg
         oxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755875829; x=1756480629;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIKMURTzGnc0o3Eec57Nl0ZpPfL0lnmgxqpSyQAZbI4=;
        b=BmVBfHfl4vUUyLzx6JcLC/VW37I2K9sxPs2SJof7+Rrs29yE8g0AWM9QMdUJd5LYBe
         FxwldwgFMu1b7BhjkBaY71CVWty1FaTyGf2OblshzqSa/RjOp/P3cWLLbw6bng1MHzVY
         eUmEI/LglB39l9BUcaupDDGyjJ5Z7fESchvB0c0Ack8IvYtrsIcf+tjC8frieAAY8SNh
         Le/brrC1kd6hWpuFGDYye71OPyUt0opUgYCUIvJ7puypYCfs+z0TrA8qG8bnkzmSLfPV
         CAIAZMI/HFksPtTxUz9kODqyDClU4l79w4aq6xEubvSZmuLJBDlDdTSfymr3/kHiVQIB
         k0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcriXej6B2omhgsvQunFRToRujBdKvVEfc+XLXDoIoIWlY8czU5jtJdm7XTg0ndWuXbNLsP+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYb901lICCszcx80iiJ1cdg2NsXudGWljDHRKpA2a5JfUm2jr
	PHqP2ZzRjy/74s71pfjal/o1/qNFXNlmHK4W5VHzMxQW9NxjnOxfU8Gz1S9Dy69nlZY=
X-Gm-Gg: ASbGncud91Uw0BMvSJbJN2jeT0ohuN/thXkKwK0yW3AOa0vkrMcmYP0UW9LE6q+Fl+V
	TbnTQCHkn8yvx6yjug3eDG4BRf1DuqjEKaPPWQqOIAODZZ6+/wU0Nm17KRte20lxG0oxU+klcas
	jaNzdhL21nsvavL8eKodU8SZmu0qaQfl1IvrjrCp4hQx4tHLwZWUZF4+wzoIP/tpB2exebYWru+
	lHP4IG6/mHtPsv+E93QT5JDOpQMlZ3ziuVjPi2sUI17zhm8IxHTqGB13xGe7NWckxpeOudCqm2R
	lFxm5diPWHFXixQPJ5BcAADU7g8EPaMVyQjNbklaR12KRBqw/j9QPvnw3ffyEerYnw3ZUW2KP++
	cr7XGJ6D2ix5BhTk4Xb2B41eBql0BQg==
X-Google-Smtp-Source: AGHT+IFfCxlBLYp46j2up+4x50Ih1kKtjjCCeP9uWttzOiVuvk9BH4ASeoYU65ehdDMkjUePa7z9oA==
X-Received: by 2002:a05:6000:40dd:b0:3b9:10ed:e6eb with SMTP id ffacd0b85a97d-3c5dac17469mr2333176f8f.8.1755875828487;
        Fri, 22 Aug 2025 08:17:08 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c52121313asm5508248f8f.57.2025.08.22.08.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:17:07 -0700 (PDT)
Message-ID: <770e936b-2c4c-4554-a567-6e7b0f688512@tuxon.dev>
Date: Fri, 22 Aug 2025 18:17:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] dt-bindings: net: cdns,macb: Add compatible for
 Raspberry Pi RP1
To: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor.dooley@microchip.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-3-svarbanov@suse.de>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250822093440.53941-3-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22.08.2025 12:34, Stanimir Varbanov wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The Raspberry Pi RP1 chip has the Cadence GEM ethernet
> controller, so add a compatible string for it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>


Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

