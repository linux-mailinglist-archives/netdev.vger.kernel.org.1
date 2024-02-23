Return-Path: <netdev+bounces-74442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF6F86156A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B4F1C20F1B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BCC823BD;
	Fri, 23 Feb 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Y5+VfFr+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96681ACB
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701629; cv=none; b=oCTRKb5GIFdM8mYrsSeQSJLWPmWsj3Xa5H6u9xoZJtxSdYq4NXKmRlqe0f89k8/y/6WRA7wOtQR8OEITlxcig8KOFVFyYqkm3FtLKszOrkGQAUh7o2DsRghsW2K6aOuLaaw0Qw6Bv3uoWPq2osxTFBjs6KzbtNw0bcHdGooIYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701629; c=relaxed/simple;
	bh=r0Goj9O4vvTip+UrmWC6ys/6wXJXzVVvFPhCqiiL6+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9uKoEFEYyRN9bBDmlyDQgIjkB9acO3SazsFSt0qH8Y5EI7ELXNEtL2KOvV4m9bUALeqq4qShC9pHssGFVKwBi5wdqt1sYs1Mq6YrJrsujZFJN5wM9U/qHB1d6Lg2QhbZneCW1E7e1jFmDcNCQe7ZDnIOl37ud4bpLluuAAj9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Y5+VfFr+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4125e435b38so3429035e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708701626; x=1709306426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w5NQyF2wYuGZDSoxAOClYkvGlgEgduaormC9ba9oqfQ=;
        b=Y5+VfFr+MERIe783kynB5nO1Y/w66OqO/pdzxCbuQRrWy3jVccHN9LUlxvy/zYQ8Su
         JJkcFDIp/v3ygKYc5HhBdMCAXOsZajgPhoI39OdaIB2rvdcV42QjtceGC07n+qeRntRi
         +lxej1MwgBjwBit/I+Iut8wZaYQqj5QYO4XKRtnbqCn2uZznZkwXHOyP5n6Hy4AadMZr
         Jp0FYMjHI54AlZnwowWqFB4//kTk7qUgAyzTWSllpqnU8Sw7rP2agxKIwR4hYIudUv19
         ZRRug7lOWkMuNUa6/PCiSGXF+P50Omgav17G0nXTk4GTRAeVCe8a9t8wYdVk3dsAhp4k
         Woeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701626; x=1709306426;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5NQyF2wYuGZDSoxAOClYkvGlgEgduaormC9ba9oqfQ=;
        b=gOvvjIqbs517BN0aDNfQHHecWNN6VTuV1R1H4AYi9DGrUFmMKDSQjU0XCUy7fx4CCF
         faKDcq+zvSc6cdb0DROi6R7zrximf1FC6liyaYafsuYDKP4yIBgkFQo0BBu0eh8F1qBy
         PMZTCFb1oY4bsA1CxxEmvi9UGj/89nCalP02Em64H4h4AbzdSdaFwE3fg3lHRUzvmT0m
         7fju830D1D2m6wRO9N6z93TkhTPWj9z+UShpqJV5x1h5jFzVPtPU6pJfaDI1psYiHr7L
         JzrNvTAOPJrZ5yh0ppuwH30ERPZ6GAlgB2ceeMuZ8xOpI+qi2hNX+qPXt/he8gNIShws
         rekw==
X-Gm-Message-State: AOJu0Yw3ibFYn/TtHHa0qYG8v6al8hJLD/g/JiCTTNU8kSDJg1HBm19h
	AB+rdnaGLp5L5+d1YxpSpgv6uXpN3x5nrpB2HBEpFvRRSxYLkdRlI7oF7sfazls=
X-Google-Smtp-Source: AGHT+IG1srBk5qESZUt0LO/+aY7X2a51outKVv+n+H8CZeU6oBkUkRKIuusnvr4FN3QcqWojLOlq/Q==
X-Received: by 2002:a05:600c:1ca7:b0:40e:5933:e2c2 with SMTP id k39-20020a05600c1ca700b0040e5933e2c2mr87321wms.19.1708701626024;
        Fri, 23 Feb 2024 07:20:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c190f00b0041298352a95sm326244wmq.9.2024.02.23.07.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:20:25 -0800 (PST)
Message-ID: <7f1024b5-8c08-4fab-929e-138831054bc3@6wind.com>
Date: Fri, 23 Feb 2024 16:20:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 04/15] tools: ynl: create local nlmsg access
 helpers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-5-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> Create helpers for accessing payloads of struct nlmsg.
> Use them instead of the libmnl ones.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

