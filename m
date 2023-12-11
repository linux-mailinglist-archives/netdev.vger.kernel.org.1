Return-Path: <netdev+bounces-56131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45E380DF40
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6F0B20E34
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAB356456;
	Mon, 11 Dec 2023 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drMCmUSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946D59A
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:03:16 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so29916055ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335796; x=1702940596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRHr+GeeGSivlm01DD+1YOjZ4rLh7MZioLEs9gOc1lk=;
        b=drMCmUSbFqUteqnA+Emnn01vrPoqBp1FOTuGj30ZMokNWW2t85n61bmo0rVgRWwJ2i
         Zao/BcFlwDKzM1i9M7w96KmraeIS5zOOGW9F+yWtSCtieh1Rzr+6T0pMN/pkM+jW/s9w
         V5iP20NqujxP7Bd6wcJwea26yX+aT5UnqDy5q+HSlXxA6H08Ol2D725xFUiIgs2O8Qsv
         kZgFA1Ka5F6zh640KBwUH9uhENx1IDugKnI77tVFHUWkqFHCRXm96jRH750Z4X46xrIJ
         PR1/iwzhSettTs0sUbiv6uTMUaLif9EzF1UHS0B/KInQKJpyPLpqfsY4x1vxBZ4/9NnD
         cPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335796; x=1702940596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRHr+GeeGSivlm01DD+1YOjZ4rLh7MZioLEs9gOc1lk=;
        b=OfFu/mtjNaf23NXg4lNEhMjFMOTgQucBhAIeCMTrwwP+LqAVCDoA3HFfOUN4alXL9m
         ENcUw8itdTL1m0OQQckVgiHJsIbqWigf11CwP58uHwMIdYtg1NoKFFmHK6pessVML5T7
         nUCHg5Zek8JCggH+8ejIFDJ9cHmi5nUkjaveYUev2rN3rsgRXdqhzyDCOuDPtr5vXMjf
         wNTzEIm3ClMLeZ/LgO+/noiRl6a5THTGkr66OljrYdXvwqP1a9zr4haWtAcCGEZwwS8o
         KG8xxPSLHX+kOZSBFKOFkHTAeybDNwEgZMs2IUbd30WV2EjFer2Un6guKaRSEobVslId
         H35g==
X-Gm-Message-State: AOJu0Yz2K7UwozPSixUNCirJLpXn6sI2/uwvJ6lHKtxr2HWeLLzp4smn
	KpItiNjG7IXDJ+zOi9lzCf0=
X-Google-Smtp-Source: AGHT+IHGSRXK70Nq3qLKjBuce4qK85+egYHSsaak9lz7OgCXTREXD48t1PEmmeHZeJRcaY56KjyNLQ==
X-Received: by 2002:a17:902:e802:b0:1d0:8285:a1fe with SMTP id u2-20020a170902e80200b001d08285a1femr2943294plg.37.1702335795606;
        Mon, 11 Dec 2023 15:03:15 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n2-20020a170902d2c200b001cfcf3dd317sm7224203plc.61.2023.12.11.15.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 15:03:14 -0800 (PST)
Message-ID: <aeac0d23-26e3-4415-9a77-f649d3d48536@gmail.com>
Date: Mon, 11 Dec 2023 15:03:11 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 6/8] net: dsa: mv88e6xxx: Limit histogram
 counters to ingress traffic
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-7-tobias@waldekranz.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211223346.2497157-7-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 14:33, Tobias Waldekranz wrote:
> Chips in this family only has one set of histogram counters, which can
> be used to count ingressing and/or egressing traffic. mv88e6xxx has,
> up until this point, kept the hardware default of counting both
> directions.

s/has/have/

> 
> In the mean time, standard counter group support has been added to
> ethtool. Via that interface, drivers may report ingress-only and
> egress-only histograms separately - but not combined.
> 
> In order for mv88e6xxx to maximalize amount of diagnostic information
> that can be exported via standard interfaces, we opt to limit the
> histogram counters to ingress traffic only. Which will allow us to
> export them via the standard "rmon" group in an upcoming commit.

s/maximalize/maximize/

> 
> The reason for choosing ingress-only over egress-only, is to be
> compatible with RFC2819 (RMON MIB).
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Out of curiosity: does this commit and the next one need to be swapped 
in order to surprises if someone happened to be bisecting across this 
patch series?

Unless there is something else that needs to be addressed, please 
address the two typos above, regardless:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


