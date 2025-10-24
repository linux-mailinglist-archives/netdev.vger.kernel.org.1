Return-Path: <netdev+bounces-232617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11080C074C0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B78F188B407
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F119303A2D;
	Fri, 24 Oct 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="s6EO4x4j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8386322DA3
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323189; cv=none; b=gMerUjyuc5c5+KmbAKdIdWxzl1iEOlTv0aMDFwY82evXHBRaHEazIGRa20gkydtJSfANBUiv1CjqnHQY6fo0+sjNnbpcP8hVJp9I2x31iI2nyvtsU7BqWYIDXhDUR4GcaeiPYZ2nPoP5OWg1qb9Vr8ufxf7HCoQKHGyK8MVCiR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323189; c=relaxed/simple;
	bh=ecInPHC0wUQfdAj1+Aml3TmylK9rw1fgXDqTWyPeUAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0H/HHXXyf+v/QoBjK6q9S/zw1zo0OE4aW9OzmQTK+QRkUPMZb7Vxzxji4BKjcVZxtWe6dRPl49Im/uwhmy0gAeZcKG+crvUMiEpy7N5sCNTeEmUM0olWK8p3hgCTK+KGA1eNJG+L5rWxxJMIMrwrRp6p+IKQUJMae6EDjOxNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=s6EO4x4j; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso1790505b3a.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761323187; x=1761927987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQNmBJKrgqnV2GDalafHB8yTsnhVI8fnPtxF6o45OcM=;
        b=s6EO4x4jQ8zrAph8eLb7FS7IyCb88Fhua6JYN4fjdDsRoL/74/2Ia/sVoyC2Afa0BV
         p1ij28Vkm7hk/+TEjKUTAbCAf0wNEgwI0hvpIwmLOiC2o1LkOQHmphHLjdxY7Su/OVZk
         5YsySZMOmmNo59wKRzlR1xfmTg6jg/f0h+wFo9APdGmIzBIMO3+VYc8riEZjJG0WFNiE
         wo24sMwZOZ8bv0A2UCHT1RUq6OmALLqFT7JJ1vDaXogVJ78I74BG38l13nlTLpv0oE1W
         6ngeDR/+jwdrAm5Pf0QMqDdNhhIDiLvOunXGkJZ/Q7F9Qgc0fWo+CdW4MeCn21Zmjl5T
         jQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761323187; x=1761927987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQNmBJKrgqnV2GDalafHB8yTsnhVI8fnPtxF6o45OcM=;
        b=bDzRAU1iCoPZxvOUUfpC1uhByPsnTzRm20lORaQmb1iKsDCmUZUlISw9E7H16+JFxw
         ZUR28JJxR8SGkYoZsvO2dOxnqwQD+5kfA3gVj213SFyI1mGN2czzdxTPhiwuPwVZAqsU
         YoUqpEqn5yYxB4D4B5ccvbmjnUW4yUWPKuN1lIos+efMDhP1xwo7Q06NffowGtSupIbI
         wlULsuAuhpD/XalQKO18DWoTA1sm+/DVxdPGANanGAcoCd6ADKa5Z981DSW5pioclgEB
         H22jMfc0ldwuW3ZDpieEjqLPzYPcqDhjJaE13w3f0mlgBOz9gSzZPdTnB96hWA5OuMia
         0F1w==
X-Forwarded-Encrypted: i=1; AJvYcCWJgp1w9JtBHxZc7xRW8vFz+p7au3SQQgEOFiRekerFSExe7ppEomRrcpIG/kZJa4NrkLMRPt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb75fSdDDl7kLxItALwg+JM+eP8F15w3QDYwnez9S7xeGzp3aZ
	j2rUUTHyqjfcQJk7j2L7x61CRNIacaq25/XjpPyKMgz0JDG3X53xIpPrBqp0UqBh9rk=
X-Gm-Gg: ASbGncsOIdB9DSL1q4DhpnBvtNE6sIEs/E4BwDSVsH/zI/uIAz32GoPP9DGwrWRrvIa
	/5Cy78VQZCjcZuTcMUiziXWWMVDcd8Rqg/wUNCaBGgAhuAh8BJlmBlCvqpjVN/htZtXo6BmmH3Y
	GdidELmkuMOvbcEL4wKQzOHeYoIBbPm8iBVJAj+EtiaXktQ4BoOCghfgFEoWrfNkApKma2ddOwa
	+X1dQIdz9A/6r98cz216+zUOIAlAk9/8UxKUdgJR9qeAaOL+02CJeAyC/tvle7myu/s1uPlObRp
	ABresfzUhrBZQjWsUzv+/7GL6dviwFusnO2lzmoN7xRQNWq4uGI4C8fpvP0HiaEx0vv2wuyq3YL
	MTwzfbhilzelxdLJZFoReqnuXTha2NRHK++5dcpHtACfdFIrwOHcy6JJxqZ7497OmyUTa/HEC6v
	xb+voHX15VcjaEbfsSiKdbUFwPwg4kAiJJrbDwljY0yaBu/vAGLyQ=
X-Google-Smtp-Source: AGHT+IG25uKtkX2XgtWt9a+YmK+QRuGxwozTTl2DG8wGGJSWmTDiGBrI2+2T8ffa1LMhQHK4QCenbg==
X-Received: by 2002:a05:6a00:21ca:b0:781:16de:cc15 with SMTP id d2e1a72fcca58-7a220a98d8bmr37441588b3a.15.1761323187026;
        Fri, 24 Oct 2025 09:26:27 -0700 (PDT)
Received: from [172.23.28.72] ([104.220.226.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b27fsm6498782b3a.48.2025.10.24.09.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 09:26:26 -0700 (PDT)
Message-ID: <faa65705-0901-47c1-a5b4-b54192e2e2f9@davidwei.uk>
Date: Fri, 24 Oct 2025 09:26:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] io_uring zcrx: allow sharing of ifqs with other
 instances
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
References: <20251023213922.3451751-1-dw@davidwei.uk>
 <e3c4b0c5-72e1-4a2d-a9bf-2e57b1e191ae@kernel.dk>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <e3c4b0c5-72e1-4a2d-a9bf-2e57b1e191ae@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-24 06:01, Jens Axboe wrote:
> On 10/23/25 3:39 PM, David Wei wrote:
[...]
> 
> I think this would be a lot easier to review, if you split out a few
> things. Like:

You got it, I'll split it up in v2. Sorry I was recently traumatised
that I was splitting up a patchset into useless patches, so that's why I
sent this as one.

