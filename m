Return-Path: <netdev+bounces-72759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC52859838
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761C22814E8
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5996EB6F;
	Sun, 18 Feb 2024 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiEigJOp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40E376EE
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277949; cv=none; b=JHe8paZFdBwA3aK9t45K3V8+mtqJsALGTmdN2l3UmV8xHD/oGOkTjwZ6C9KMBxwBzFtOvw0diMxUzZTcggYTJLsjfxa9xs28HVtLh3B7Wf+6Ob4QPKz11lJP38vjxEtpsKICEs/YuDUNAqWpFYpfvhscXwQj/le6vHYccfdwLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277949; c=relaxed/simple;
	bh=NJmE+OO3UE44kHTRpoNsTV1MmfXjalZhL+xnN22Dbrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvjesH9A1y7pCI1IabiB9zL8Sd1OY2jm8VruCqzhUG8Pzj1E5YHcLl6UnFWaRGY2gtbWF6Qr3QRjd+keNulg4EZY+YI0Tej74j3vOYbcK00/W7fS+vf1vQiWsyKw7zhus5LixoMx34znuLVZ3HHdDPS94iYpIYOalM5R2DZRrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiEigJOp; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c029beb8efso108541939f.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 09:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708277947; x=1708882747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+ml1xvD68Mu5DbFch5BOWWGVi0NVuYNVDYCtJppUKs=;
        b=EiEigJOpUgOsvI4XP0i9fvE7qbYg16AnXKByWor4XSrCk2BfJ5T4G4D7YH0S99krGZ
         zKwklz32f5RZK0QUDwtpm5T2r4Xgw9nfW5N86Z2W1SAPQwmQ+VboyHuPsLoERgsPJsZ9
         HU5WJ7HB6bQXW6AC1MHXuwQtdbHuPbFjXIGy3dQIoADa4hOsRG9Pvw1rWYb+IYKy+utN
         26xvPZ3XkL8LVwV6309xXGeJu4gpdoI9nPK+z1s0PXHBUckC1NLjejpTgRq3HIrN0a0q
         CLCnvJ7www+wxnxGzTG97Zf/VpshdQuIVdcmNCQx/hh6cybdglOmGsx0tMTBDRkeXQun
         iPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708277947; x=1708882747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+ml1xvD68Mu5DbFch5BOWWGVi0NVuYNVDYCtJppUKs=;
        b=DW+CE3ioSUOAhO5Y1MgYwaxPFUO4SaNnkXXWmZv2pv83J1PvgWUtIXsfJTwm/AawQw
         am3IhAT+Rc8bF0rF5591HyD5tQaI4sNB7yjiYiMr2M2QXZccK7IbdXhdrXGCQeYuUOFo
         mUcfjrXkznUp7WWmyXD/Bd240yoCGDYTgTwNuQIq7dI8ZLQ6fYrD7k2RuwQ8Y8EtW2nV
         Ia+4VIU8Q5JG29TTl71Gp0ATcxGyEnfUfxP7q9xKEirdid9GOjTsfOeDA5073pi90YSB
         B4LEc03uZQ5tT6JoeI0YHxIPm198O3xUAQs5ppFkmQHA9X1Q8k1WBp3ZEsVlIHEq3unv
         I/fw==
X-Forwarded-Encrypted: i=1; AJvYcCXojoYPcOLWUZwQ3MAdUjdE+J2sfilvHstX+f9EpPjF9hmF+QAij99Sb1tgpPYrK00sR61ztkcjPMACPnOnSRgEatK5f0Eg
X-Gm-Message-State: AOJu0YxWdPnLGbBOkR+yYhopYByQ7A8zUbjsSboYKbl64P7lPjvTKtgO
	wBGbH9xl1ERBg5NCT5Z7lnRcZ0t2nMLyRWKlm9QdUQlX+PrInoV/
X-Google-Smtp-Source: AGHT+IEUxCf6iWth0YSHQDnPnUvf6r0sHLVlaDhV7mOflRCknkOlfLISFtqtZeydjvAeEpdEJMLnSg==
X-Received: by 2002:a5d:9c11:0:b0:7bf:e57f:3ecf with SMTP id 17-20020a5d9c11000000b007bfe57f3ecfmr10192515ioe.0.1708277946850;
        Sun, 18 Feb 2024 09:39:06 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:309e:ba0d:4ee:72ff? ([2601:282:1e82:2350:309e:ba0d:4ee:72ff])
        by smtp.googlemail.com with ESMTPSA id x99-20020a0294ec000000b004740d29b120sm982581jah.111.2024.02.18.09.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 09:39:06 -0800 (PST)
Message-ID: <576ebc9e-4307-4e01-9b41-12aaac83b14a@gmail.com>
Date: Sun, 18 Feb 2024 10:39:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v8 1/3] ss: add support for BPF socket-local
 storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, kernel-team@meta.com,
 Matthieu Baerts <matttbe@kernel.org>
References: <20240214084235.25618-1-qde@naccy.de>
 <20240214084235.25618-2-qde@naccy.de>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240214084235.25618-2-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/14/24 1:42 AM, Quentin Deslandes wrote:
> +	if (info.type != BPF_MAP_TYPE_SK_STORAGE) {
> +		fprintf(stderr, "ss: BPF map with ID %s has type '%s', expecting 'sk_storage'\n",
> +			optarg, libbpf_bpf_map_type_str(info.type));
> +		close(fd);
> +		return -1;
> +	}

ss.c: In function ‘bpf_map_opts_load_info’:
ss.c:3448:33: warning: implicit declaration of function
‘libbpf_bpf_map_type_str’ [-Wimplicit-function-declaration]
 3448 |                         optarg, libbpf_bpf_map_type_str(info.type));
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~
ss.c:3447:68: warning: format ‘%s’ expects argument of type ‘char *’,
but argument 4 has type ‘int’ [-Wformat=]
 3447 |                 fprintf(stderr, "ss: BPF map with ID %s has type
'%s', expecting 'sk_storage'\n",
      |                                                                   ~^
      |                                                                    |
      |
  char *
      |                                                                   %d
 3448 |                         optarg, libbpf_bpf_map_type_str(info.type));
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                 |
      |                                 int
    CC       lnstat_util.o
    LINK     lnstat
    LINK     ss
/usr/bin/ld: ss.o: in function `main':


Ubuntu 22.04 has libbpf-0.5 installed. I suspect version hook is needed.
e.g., something like this (but with the relevant version numbers):

#if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)

