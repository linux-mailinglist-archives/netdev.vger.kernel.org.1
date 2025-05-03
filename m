Return-Path: <netdev+bounces-187588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9EBAA7E80
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 06:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0555A5F31
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388C817B506;
	Sat,  3 May 2025 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="cJ2OMijK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5F191484
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746247791; cv=none; b=Fjl0Q6F9Bjqp84+4t4L9aVLi1fRX4ZoJgYOdvH7HzfAfgsIfZ/NzUDHTGJoewiat+KZApebgtuK01lQqzAuFsBUwdi5yfU1QQsZPMq+I+pPSQ10UMvXS/pGWTy/2wscO/Mb2vNr5RAeTPoDVVIW37glAukiBUt87fZ7cI/Xhi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746247791; c=relaxed/simple;
	bh=qINhvPGtkjwbD1XO9IedTb3hhyXkB8xiUTTzbJgKbAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOhkKJlnbPiPJ5ZdtwGZVLJOSba4QtdYeem04StziIYX+gdJBOOdrrFCPfoclkECzVnuU8fWPCKeRPeSRP03Mic8hr/TOkX6QsLwBoWRh3SR2SZXMwMRNbVXrUmyKfV0TU9hTLF+EKIhU5ZOSa++XXrKrgVGQ2Do3ohW6vB6psw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=cJ2OMijK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ae727e87c26so1741742a12.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746247787; x=1746852587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wl5agjkb1P+kav+Vmwr0UdlPpR+PcrKakR6MDznA3nI=;
        b=cJ2OMijKZalh4jMw2mGKEmftxTmfLHmcD3nFsksSSm4hIovdGe8+bRd1QLO3DUWANv
         lyIG8gQNvOCkGDepWjPgfeRfaXNL+sRqGCjDx5kaR2LYw8qAselkiB0iYrhfZ4HURX2x
         bqSZ2oitFUKhlJcOQVxczwijbz16f6IcwqQjpzNpqqzl6CC4+WkZblrFrWosEaXov4kr
         B+6ytvvbNqikOlSLiDE8cspEWYNNu+twH3oclZkoqhQdHBD7on64w+8PWXgvttHsSDfp
         AfkZ4BN1B169UQQKQqNROpxq/tS7Nkf1WlnDKxpabOSl2NXhM0c/85NPBjb8UW477Gnx
         V4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746247787; x=1746852587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wl5agjkb1P+kav+Vmwr0UdlPpR+PcrKakR6MDznA3nI=;
        b=uA4DsIwf8Un2Ruf4smp/v3wGCVL1hPTlTQGOm2aADgSLxwY5BlAD+VXkO/nlYtmtFX
         AmE//r++5w0aefjVtv1x4IXbFclB+bu3dGqi7/Zi9rY5w2si4p1n9Pi3JxaA5/ehj5BS
         paUxkZZTyJvYZhWEFLTpoHmWovCaLmi+/rMvIU/8opSKfkc5limUJSVNWEyoxuYw/rIa
         HLsStkvRw81bq0T4t6CcEQ6TKl9VFEiHNZb3nfXtPEX+X3isPVnGzd1hPsjjU7o5TCVu
         1rvrLmBmKuV7NfXYAZNOYAusTrD04LOZ2Vhtmp4L7BeGIN8Y40je/reqkkTp4m8ff+WC
         UYqg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Vr0Mp+XPZPJEUjq1vpRWJP7fiH7J6kpl/6pCCPLzp3pV2ZsJ0X7AOXeklcpamS4DC/AAV10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNz+6Z329bL3w6Mar7aWYA5dsPK6gv2abBMcPGby1yStuoEwo
	vp5ymAI3SY9LtDMVnDl3nBh886CeQvTc8P/tQZS3MNe0eqXCv5WK7/ZrDBhRu30nAvLkBq49Vjv
	zKEk=
X-Gm-Gg: ASbGncurn9SXolhN9ZjJKiZcHGbgc/qTXFa7cRMY/i1L7GnpelPNtB0nQzzxDP6mEwd
	+W283uJhAG0C9Hae/vppCIgawLaRR4X1BDtMkKcyCw7bPeXLZeyXxuubtaqjAWtGCoDHuVdzqwA
	oTeCDQStS2WXSYtroOoNZVL6sRKaN1HemDbrISdJbeoNuTVVxADj/4Eeo+iZIDURDHee2narX3m
	rsclvt/MbwfTAAo/7u+IvNMPnYtkffKBPzKohDCOGKUPdN+voxTzhH5ZavsAy462bc4H2gPv5Sd
	dwRDAjJ5xTTcqKSHEFAL5S7Kdk7ab/niaUvsJjctiDwDiSg=
X-Google-Smtp-Source: AGHT+IEIzIAeqtdis6UacAFn64Fv8eM8Hzn7Knzhq5lJqvY9BqLX+h7uHFxCni/M+uWzqyRsBEN3Sg==
X-Received: by 2002:a17:90a:c88f:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-30a4e5c1f10mr8128638a91.15.1746247787424;
        Fri, 02 May 2025 21:49:47 -0700 (PDT)
Received: from [192.168.1.21] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4b21514fsm3802943a91.14.2025.05.02.21.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 21:49:47 -0700 (PDT)
Message-ID: <9f944c15-5f61-403f-95cd-540fa9c0b783@davidwei.uk>
Date: Fri, 2 May 2025 21:49:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] selftests: drv: net: fix test failure on ipv6 sys
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 ap420073@gmail.com, linux-kselftest@vger.kernel.org
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
 <20250503013518.1722913-2-mohsin.bashr@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250503013518.1722913-2-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 18:35, Mohsin Bashir wrote:
> The `get_interface_info` call has ip version hard-coded which leads to
> failures on an IPV6 system. The NetDrvEnv class already gathers
> information about remote interface, so instead of fixing the local
> implementation switch to using cfg.remote_ifname.
> 
> Before:
> ./drivers/net/ping.py
> Traceback (most recent call last):
>    File "/new_tests/./drivers/net/ping.py", line 217, in <module>
>      main()
>    File "/new_tests/./drivers/net/ping.py", line 204, in main
>      get_interface_info(cfg)
>    File "/new_tests/./drivers/net/ping.py", line 128, in get_interface_info
>      raise KsftFailEx('Can not get remote interface')
> net.lib.py.ksft.KsftFailEx: Can not get remote interface
> 
> After:
> ./drivers/net/ping.py
> TAP version 13
> 1..6
> ok 1 ping.test_default # SKIP Test requires IPv4 connectivity
> ok 2 ping.test_xdp_generic_sb # SKIP Test requires IPv4 connectivity
> ok 3 ping.test_xdp_generic_mb # SKIP Test requires IPv4 connectivity
> ok 4 ping.test_xdp_native_sb # SKIP Test requires IPv4 connectivity
> ok 5 ping.test_xdp_native_mb # SKIP Test requires IPv4 connectivity
> ok 6 ping.test_xdp_offload # SKIP device does not support offloaded XDP
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:6 error:0
> 
> Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Unrelated to this patch, but there is an ip() helper already. Can it be
used instead of cmd() with shell=True?

Reviewed-by: David Wei <dw@davidwei.uk>

