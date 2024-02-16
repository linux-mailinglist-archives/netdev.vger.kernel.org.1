Return-Path: <netdev+bounces-72319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB685789F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEE8B214CC
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F399C19BBA;
	Fri, 16 Feb 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="DHtEzNBh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD91B812
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075009; cv=none; b=mDlzvgBqSd3nIygDc2O3f1eIV0iq1Tt8Gs+zIXTgh0gAYWQeUjurEhVwwjXIsd808W0dntm0xf4eUw3hZEMZeoQPUlvE1VHe0NDdLv7CO1gy5vcrQNZwDzT2xLQ7yoO4vwcYcYr6324MHyptGwUHb52s5yFQm3xe/b66l4fToEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075009; c=relaxed/simple;
	bh=APZNAGc0uivTLmwDLUTvPqasTZ+7JNU+xOK6MXiCfPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCxGIDeaBYNhxQtQ+KtBEK69LWD+raSNw0VFWMgB2TjVnyFbytqsXXhPL5hS9WgEFr7XkpgTN6U4FUm3NF8sW9q1WyuhpNRxKpSKke5iQxQDRGUfolICo7thLPkVbhLj776yX/VwK27s7ZJoeNA3SNmTWLoVuphyeXRn150P/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=DHtEzNBh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4124907f6fcso2269215e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 01:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708075006; x=1708679806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bsxcgT+5xI7G+RnCsIeu5n9CuaNbEIesjaj/AGQxe7M=;
        b=DHtEzNBh+ue4uC3WQb1zyHrLNDljvKxbY2vLAwUUu77BEkH6rR8qMUOzPJosmedNJ1
         09zmObt8FmYXW/l14STMmzlzQwKWfxkojIq4d34ZljYSDF8/OFmQvr1SW4E14qRkl8xM
         EVfQiJl8I0SCcWhQTDMfffYFJqjFUXbXCE/CiaH8Wf/I/uiQjcbklF2JWlpsg3lYaFXb
         mmHy/IqKvWiHODHnYLAqOE5yP9n31ppEWSi6wR3hHwKsqfx18BhPm5snyU+YCVPXAXBo
         UrmPEmNtgnom0t03RqXrseWgpQhL3DqcnYTUCKRSVVFR1PeyGOMeZztp3QiaKiiWH02r
         X8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708075006; x=1708679806;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsxcgT+5xI7G+RnCsIeu5n9CuaNbEIesjaj/AGQxe7M=;
        b=pdufTsOnBgEgv18VOaq2V4LufE41wOowl7Mf7u71nRY6g+mlCiQYSuDDdwcwvObu6W
         WmTh7l8rGyNxXymTTJHwuz5L2Nhle35oooVW24lheFa2S6XyEtCIf2qXAdp5Crvus8y3
         c7utGLWUysvIiAyAptwUhxfXoVtBeWvbKxZcy4Ub6xdi6jYTEE+wLXz8hqCCH3XfnKMX
         0v4N392AA8egQj+fddq/oPHA88nF5rGvUeKIj+sj5tQoihu8irCw6qNzseCPHos2VQEn
         p8EQk2LK35lYP/GTmYWsdYWqrlV1YrccVTr+NCmb/m2WTxUHcLuFMAghRwD9xLbPXQp5
         K9ww==
X-Forwarded-Encrypted: i=1; AJvYcCXQmWRn/qrGH6MEnsxTcODyF6LLTTXrWBXw2PiLhABfUcAhXTQI/9u5T360XmSNPS2BR0SgPgmQJDHKPrt5RoYcIs+Q8v6o
X-Gm-Message-State: AOJu0Yy0gE+E1jdc882uzw3IhuNVE5SC8hm0azzZJlhAqcLBOZNV0pqq
	/gpcnO97hEisGEp7qw5n3YvSCDfpQ6IaZMGW99AJdVC+3fzWGDjk2fD1Hc7KhKU=
X-Google-Smtp-Source: AGHT+IHn5oLfQ8qkRdnHzDrCLtMxAmPyuBL9TuXdFIyYbusDHab5IlFWfZjZZS3lOK7zhDedTUYrJw==
X-Received: by 2002:a1c:7918:0:b0:411:a802:700f with SMTP id l24-20020a1c7918000000b00411a802700fmr3387240wme.39.1708075005967;
        Fri, 16 Feb 2024 01:16:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:8347:1f2a:aa47:cf48? ([2a01:e0a:b41:c160:8347:1f2a:aa47:cf48])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b00412393ddac2sm1752883wms.6.2024.02.16.01.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 01:16:45 -0800 (PST)
Message-ID: <9cdfdc3a-d6fe-4810-a2d4-f9d8430d56a0@6wind.com>
Date: Fri, 16 Feb 2024 10:16:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/2] ipv4: properly combine dev_base_seq and
 ipv4.dev_addr_genid
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20240215172107.3461054-1-edumazet@google.com>
 <20240215172107.3461054-2-edumazet@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240215172107.3461054-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 15/02/2024 à 18:21, Eric Dumazet a écrit :
> net->dev_base_seq and ipv4.dev_addr_genid are monotonically increasing.
> 
> If we XOR their values, we could miss to detect if both values
> were changed with the same amount.
> 
> Fixes: 0465277f6b3f ("ipv4: provide addr and netconf dump consistency info")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Or if both values are equal :/

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

