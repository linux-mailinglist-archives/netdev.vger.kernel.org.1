Return-Path: <netdev+bounces-74378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DBB861163
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083932867D4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF6B7A71E;
	Fri, 23 Feb 2024 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JT3Zs7o4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F056280B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690981; cv=none; b=mAA9nW0qBBQO9x1t+lL7rvIG+KZtMn0fSp/yWYnH5zHGbtGluwuI7H8NDmmoy0xIo7THf/t/VKCi3G+eqUv+zkMe0xzM+FLNG63YNFAmAD/JLmbUAxunvy8xLWfn4mledJnxBAitp8g7+l9fGF6E/gCEzVdkCCXd91HbuDhRxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690981; c=relaxed/simple;
	bh=FM5O4oBCiizohByOcK9FDB+UzRfYyvl7mtsEDJU5Rt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfPjYPp0esfC5MHC7cpGA3wTpCit4czpEZYGmkpi+6syRfJFT/h1ehvvKxnlZLB6kDEEteHx6pXLJJF794pyyTavjUzKIFK0r8pUEtepXh4ad+/eYly2pyh1CTruDg783qH/Xxmcd18NZoUi1SWcIAvCuu1xqiyBWReIfrNDyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JT3Zs7o4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41297377abeso1157165e9.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 04:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708690976; x=1709295776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hOwG4BnvWAifRiq0tXQaxVN5PO1gr4lAA97u85JFh4I=;
        b=JT3Zs7o4kVAMv5YMdnHD9mKmXeqTsBVi9S0QU5zQrQqFp9LqTm0OFvYyz/50F3ldx6
         7DruihrgxH73RC+sGfwc/vkglgb9Qu+N0+lzsdR4Q+dvMjdsT2M9tTPSQeWz1Ihi29uD
         Q5oXIYzVrr83NisfWQKRw42t0U8cgWhZeFVZWl+QzvugRJY9JmW/uU9Xgoa+bEWUYp89
         1qdE8lsu1nmamCpWk2qGxfm2jaY+8/xznTFG69sTUyLJMZ73MXlU+sbiX7WSelg55uZZ
         wnzSnwdMyU/jAnsmPFiBmqRiEkZI1pdcOMkMJhZKr0gr/KF0BKYMzhLks9XwviwT2sVY
         7Ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690976; x=1709295776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOwG4BnvWAifRiq0tXQaxVN5PO1gr4lAA97u85JFh4I=;
        b=M75XMhtRYU0XPC3mFqbbvodvayg1OUZRyyNX3i5x4s80APhDdil/1jmCuWhxZYwTmb
         jTTzMo5JZBW7YZnnm6bcEAPYF4Noopl1VXWCWkZALSE8oftlelz1aylYC40CUwPFk9An
         dOQ5x+qEMpzVIU3nUvQ422XiO0Ae2PBGwVBwZeDmb1zOu9g9ERRKTg4NG/Bx4HOIVTHA
         FA/ShKq3oE0iTTYplSbyqqmZBX5D09qhWcS8gZksoIh23xswzlH7hKtcWF/4BAAnCdMz
         G34CNx/xbkwUmICU3KZA+wXZwX/E101L+NNs5q1mSHfYWgpHo++G0pDGKIAU9mBiAA5W
         cstQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDRGzjwJ6pwDuCvGR8oYy6xeFt6onf/v2tiVlhFWImupPG854Yo5vvhw0axrP7sSw9TvZzc7nMZ8HB2nWE/aNpQb4FKRAV
X-Gm-Message-State: AOJu0Yya7G+QmjGQeUTiCAG7Fb5zhWcSdIeuFth485MxY9sWuALMdvsT
	weveDBvd6bdYqhLVG0R5yrKA21cHPzb+Jli9KUOdET/bTjvS+1L3jGsZQ9nMNuU=
X-Google-Smtp-Source: AGHT+IFXMLVPtPgMCwFPiUL+Z6Y7K8KnEZW1moBShrb8c7sfH6aqFekAVGYMfTGkuAfZug1ZiRL05A==
X-Received: by 2002:a5d:5007:0:b0:33d:67a1:ba0b with SMTP id e7-20020a5d5007000000b0033d67a1ba0bmr1422011wrt.61.1708690976360;
        Fri, 23 Feb 2024 04:22:56 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id u2-20020a056000038200b0033db0bbc2ccsm974329wrf.3.2024.02.23.04.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:22:55 -0800 (PST)
Date: Fri, 23 Feb 2024 13:22:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, stephen@networkplumber.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	corbet@lwn.net, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	amritha.nambiar@intel.com,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [RFC]: raw packet filtering via tc-flower
Message-ID: <ZdiOHpbYB3Ebwub5@nanopsycho>
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
 <20240222184045.478a8986@kernel.org>
 <ZdhqhKbly60La_4h@nanopsycho>
 <b4ed432e-6e76-8f1b-c5ea-8f19ba610ef3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4ed432e-6e76-8f1b-c5ea-8f19ba610ef3@gmail.com>

Fri, Feb 23, 2024 at 01:07:06PM CET, ecree.xilinx@gmail.com wrote:
>On 23/02/2024 09:51, Jiri Pirko wrote:
>> Hmm, but why flower can't be extended this direction. I mean, it is very
>> convenient to match on well-defined fields.
>
>Flower is intrinsically tied to the flow dissector, both conceptually
> and in implementation.  I'm not sure it's appropriate for it to become
> a dumping ground for random vendor filtering extensions/capabilities.

Nope, the extension of dissector would be clean, one timer. Just add
support for offset+len based dissection. Also, the fact that flower uses
flow_dissector is only because DaveM requested that back in the days I
pushed flower. The original implementation was not using flow_dissector.
The dissection backing should not block flower extension. We can always
replace it if needed and convenient (maybe the criteria is met already).


>
>> U32 is, well, not that convenient.
>
>How about a new classifier that just does this raw matching?

That's u32 basically, isn't it?


>
>> I can imagine that the
>> combination of match on well-defined fields and random chunks together
>> is completely valid use-case.
>
>But is it likely to be something that hardware supports?  (Since the

Yeah, I know couple of ASICs that support this, driver names are mlx5
and mlxsw :)


> motivation for this feature is clearly the hardware offload — otherwise
> there are other mechanisms like BPF for arbitrary packet filtering.)
>
>As the vendor behind this, one hopes Intel can comment on both the
> hardware and the use-case side of this question.

