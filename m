Return-Path: <netdev+bounces-249530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160EED1A828
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE69730CAC03
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24C6350282;
	Tue, 13 Jan 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="arPqkIoj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881E288522
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323506; cv=none; b=VlfZAXPQ5nWtPOh+3eFfR9Y/Av9AAwq8HVM4f7HgJbTESGcdZmcO/yfOUqaDyd87Sk+HHmBhzrhVe8CRvflLowbPLnn2ioQQA3OyJZtxAN+aTpVqPZFtHkYVGzyDjaAllAJNxJsghJ/GI/j42ZlLZ9Nsw2OQ3FYYv12wWsrx6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323506; c=relaxed/simple;
	bh=6Qy9RFFnU7FhdGhT3OFG5W3FiZMln0ipNVP7RahSUfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZx4EcFeHqQHd4+cTjwgOGMr8hiWew6VwfcaNX5bH38zFf+vKgEWiWrI/9QNmSJ2rGWp2VBXYjUujrPXse9RJlK1fJXEXkyTF6y+/dCf8NEt6v8wDsfOhslcflCOvhXNlcsiObgyDw1ujhFw+v/1Oq7ppJgO+3NRL87F2iJsBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=arPqkIoj; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ae53df0be7so12700776eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768323502; x=1768928302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n77cGqLpADKbmUH705Nn9XH804i7piONdOwkUPIPb3g=;
        b=arPqkIojm3BzWuNVp2unot0Dq1MnPVId9dYHXNjLMCDQTh+ob4APFE2WwP4l9Om5Jx
         Oeng1DFBi0Ez33Y7YL7r4w8QGzhhxrO8fbjZeblQPMaI+yLDl2L+MA2fSz5Np/aPayzV
         Zop8flHOiBM+7ypmlUG96uCWIPgxQWOU6NJcqPeKC4T8OuTq034w+p5nsu6YGjBaKC+d
         6M4uPLGr4bpd8wSTX+ArhjLM9zfDrV5N8wYyLjMWNvJhkQR8IrPNFyzu/njerrJNsn9V
         hGL98ph8uXRqGQCMNpaXenCJo2kHSPSrKkC2jIbBBEt22xrxJ6JRVvyzD6xWpcjOVFst
         n+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323502; x=1768928302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n77cGqLpADKbmUH705Nn9XH804i7piONdOwkUPIPb3g=;
        b=EmobKXtAexoaeN+oKNWmm2mc9Gv0/3WUOJX47J5+m/63zDbo6yk5W4mCibfUzY2dOi
         4plDZDJDZr9PFtS4l2x2Af99cgkE98GfcsZhIWwB983hmn9+BVs245FIqV6Woo0KyEaN
         H7lovgWeRufyV+EPkN5gBegCj6Q4ldWE1CvJEcQAEtTk9wRLFcj1gIgehaEbISb8RJD/
         z9XrbKxlBdpoIxCYS+LirWqxVbPNmfba1mQUvWqi7mWAdELaWKn1vhhNqDTck3JfZ63D
         SkcQCCXh/v8El1Bu4JpoEOUlAVYIP2TmDsD9u6qUzTryVNVTps25wN7fEUjCDQUj7Tbd
         rUvg==
X-Gm-Message-State: AOJu0YxYZ74Rcign08C+9daXLPydIc7nl4cGb7+i9S74MA9xG93tg3H9
	KVkPwoH8i5LEu/8eAw7VRHSjRN6qDQfPvLNCtQPXcjAZTo49rXBbsNt+N1sx624Jbmw=
X-Gm-Gg: AY/fxX6BBkeEYkPy6/5UjxWmUzroBrLwcAAFXvHDY43/BNHVHX9RuwguI29vzOFxP+G
	Kd2he1PCRjaiKg+mB3o6fMnGZ3wSddMvCHPJWP6PsLNxkQnIacPkIWWmrBgU8+Ty31Obqg1UW6U
	XQ8XfSTrA7t0fKTYh4kofII+vrTfajQlvGdSPxfgH1kU/wWtGCjD/N4cPbv1BpDciJr6tvpaA8g
	u5bjolQZj9rExz+5qc+OXpL2/a+yLoceCZMgXU9ehwsyWM99WWZTbzBKfa5Ld49C8adxAMIV5Qh
	fROifj1aD39w1Q4xso8M4ikdfQcgxoA3gTBucqITY2p6D+TcDBjf/R8EntAfMWN05fsJ3u2S6n+
	6gtkq/PHV3oiCYLDZPIe3Cnd1jmpsmb/6eHLwnku61VWdd3sTLktYNrbEJFueM8Nm67/lrGusVp
	msllOnWr3S6XQ763ZzVJ0/Yw0OUK4qay4EgtcB+lqtcWvx5QzfVTh6eebbqR0P4myoJxcQmZBgD
	KYHFAU+1KM00JE3Q3a/
X-Google-Smtp-Source: AGHT+IFPbxTriagZU/H3z0UHuDj2NqhqlCDbpNot88w6o+ZauEKhsAYhZNwxljY/4wB3cG8nkebtwQ==
X-Received: by 2002:a05:7300:5415:b0:2a4:3593:6453 with SMTP id 5a478bee46e88-2b17d2294f6mr23252353eec.3.1768323501600;
        Tue, 13 Jan 2026 08:58:21 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7ecc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d57aasm17121126eec.30.2026.01.13.08.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:58:21 -0800 (PST)
Message-ID: <745cf43b-05f5-4129-abea-117fe1c53a70@davidwei.uk>
Date: Tue, 13 Jan 2026 08:58:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260109212632.146920-1-daniel@iogearbox.net>
 <20260109212632.146920-16-daniel@iogearbox.net>
 <20260112195915.5af68b2d@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260112195915.5af68b2d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-12 19:59, Jakub Kicinski wrote:
> On Fri,  9 Jan 2026 22:26:31 +0100 Daniel Borkmann wrote:
>> -from lib.py import cmd, ethtool, ip, CmdExitFailure, bpftool
>> +from lib.py import cmd, defer, ethtool, ip, CmdExitFailure, bpftool
> 
> tools/testing/selftests/drivers/net/lib/py/env.py:10: [F401] `lib.py.defer` imported but unused

Will remove.

