Return-Path: <netdev+bounces-129931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1807987126
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86932836D2
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763D31ABEBC;
	Thu, 26 Sep 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ifS/7Q9y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1135647F
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345975; cv=none; b=hp5gnAMtjsriswwB4OIBhFq8uC9RhrPCirb30kDw51R9p4Yj6bm8VRsSG+pVoPtFJs0e+bG9l0/tg5RXDIC8Hj7z9Iwq06mS6oOX0KEirBn/PRk48g626FMVlaJTuqB2X6PFDbbaTRS2LhRYYZ1a/h9nlnWEHkm+wNRw23qtAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345975; c=relaxed/simple;
	bh=XqWP6jiPfw2E7M63/W1WeldxvOSVEdP6Hnjf5CBb5+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOspZhU3s88GlbGi31ppbFsW4aw0INuci/ULTFU96LNwntDbtuh5pHV7tB/DcKGJ9oHnHmQY1fQmKsgw8i2SBy7rgxw1nD6/EbPpJLaOqf47W1gBS1gxA/qsxkIz1szlSF3itYn3q+QuMuZc7QDcmy5zMIG+0BqVNFkAFM8+fB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ifS/7Q9y; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374d1dd1e75so45972f8f.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 03:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1727345972; x=1727950772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=spZQdWS8XVsyY9M+JooQQPY5DbVkW7GJ1jFhF4UJcPg=;
        b=ifS/7Q9y1xekQIZeeQVRpeUwOVMqNJJeGUaTuQpOXcaiRMc4KbsBDsP6FMh8p2Nusd
         DNsDEMJ5541N4VCxX7r6T4/HkECin18gNiRR7em2jdayY9BJGTwYyHgt768WOvMorzOB
         tUOYk/k3DYLfG1QxJO61jii5MgQuGayzTDBNPARbVRBS8L25miyvXou9JbA9gIbamNGA
         WFGLBf9VnxUz2NaDDjgpSKH1cXVIVNFN4hIfXaXQ5a6b67FgGrJZSp/TBAOgJeiu7klx
         GyvnyC4Blcnradr4sipSEcBH14y+fL3/TQz4soLcRBrfYFadJJMEw4bqLKRVgvkLLqvz
         9WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727345972; x=1727950772;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spZQdWS8XVsyY9M+JooQQPY5DbVkW7GJ1jFhF4UJcPg=;
        b=jdXuSe9Mqjd/351K9esivCgcFGNz1gYE5OrXXnjziAa0jVMtrD7CCb+uAH/T/PatzL
         5J6IVc5O8M2a1AQ2WWVoIkscsanHcXo7lnsOlOuZ15+2bWrUiabdV9jrPbokZY3x1nXQ
         A+zil3lFjyh+Ie7pKGPxStU4W2VCNvpZLdXiYj3uqEvLRs5vldygHxY0JxvP2U1JrfH8
         N1qSoW9fUKcQTnpQze42otUFxqzrtymlT6qB//ORiQVqu2N4IPP81wclW5mHZPCCQe+5
         pFuqi6LPhdGs7NwjPiGzS8JWUe4+5pu0fLma9CBau15K3pUcFTZ4Q285aFPgtk3OEA8t
         YRZw==
X-Forwarded-Encrypted: i=1; AJvYcCVqfT09/tVXuc6dqIrNIMy09/sSZuFmBDmpNV6VuEL325sL/YvEkgRQmIF/qK5/KP+5VkxU7H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHG03+ODDqBxMlvgf0XDOhBGmeYwhtA1TF7SXPdKwoLqICDly
	ZhWVQdvycWFCBBKVXYSvAVpqctGB/60SNcupdMOAOyiw4S/CiXM/jSIcdCDZai8=
X-Google-Smtp-Source: AGHT+IHB7wCRFaYLDNbuqbUOcU+fwSTMuK4M+T1cl1M9qDTKrk3ziuKOQLT46j+VO2Cu3mOcAZLEUQ==
X-Received: by 2002:a5d:64e4:0:b0:374:c7a3:2d33 with SMTP id ffacd0b85a97d-37ccdd3d1c0mr914156f8f.9.1727345971610;
        Thu, 26 Sep 2024 03:19:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:5572:265:5f6a:36f1? ([2a01:e0a:b41:c160:5572:265:5f6a:36f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f9786sm6087119f8f.74.2024.09.26.03.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 03:19:30 -0700 (PDT)
Message-ID: <a942c0b0-4dfb-4725-a38b-e93d5650f9fb@6wind.com>
Date: Thu, 26 Sep 2024 12:19:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv4: avoid quadratic behavior in FIB insertion
 of common address
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, edumazet@google.com
Cc: alexandre.ferrieux@orange.com, netdev@vger.kernel.org
References: <20240926100807.3790287-1-alexandre.ferrieux@orange.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240926100807.3790287-1-alexandre.ferrieux@orange.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 26/09/2024 à 12:08, Alexandre Ferrieux a écrit :
> Mix netns into all IPv4 FIB hashes to avoid massive collision
> when inserting the same address in many netns.
> 
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> ---
Please, wait 24 hours before send the v2:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n394

Also, update the commit title with the version number, for example ([PATCH
net-next v2]).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n666

And add a log explaining the changes.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n723


Regards,
Nicolas

