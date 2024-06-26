Return-Path: <netdev+bounces-106755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688AE917894
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E21B21846
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321C14A4C1;
	Wed, 26 Jun 2024 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Q3kVmAqq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8338D
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382306; cv=none; b=XvwDNW7CQWSgpAIdwZjFPYQclNp3b7mO6qT3WKV+OFReLrJmPjB+g+A8JsHPGFTomxCsiqDeGQAIhVMkBGHqw6PIFlG8qv1Yo0vRSYwM2E4VNGxgikqw9yIqve/EVupXQ6R8jGVqLJVmL7E0SIwG0+rTXgYl/o71wVeYXIUHG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382306; c=relaxed/simple;
	bh=0+zm80564UnKGq1HyHVizC0AbKdTolRp3A82QApIsm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zm11wmpLuB7b0uRX/76pxXTKVdPVsQaVQ+wp5PRnCriYjEpC86Jt0heLE9xoxijtMMC0IKOy29fMovwmqOqM5CGmq+6dGqPpAsZBX6NepnZ4vsCzmWaNQJS2WPIDTXCOsFLvqq0nRw7dQ1Pg57oIfuwq40n22Bed1tw7N0vCAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Q3kVmAqq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a72517e6225so413013466b.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719382303; x=1719987103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLKE2RE1MbPAv0a5Cs9QfOmeDk0TDfpGAaiqzH/9Guc=;
        b=Q3kVmAqqShXENMNXZWyr0TBlm0K5JhP8lV6Qi+7ukf66MgaDAWa/XLgXQoBkYsHXr0
         +bemB7dy04A832Z2bCAqkqfWT29ClmrO2DGlXIOMzXr8oOuSLDC99VmC6iEtfew2WBAx
         /Osb/FWXN3OlC0ta0kgDYMkHQrVzFSMyysykVkhfmwUto5WDOlMfr6SgdO1tYVhVm4HA
         5ASyuQwTCu0QLnypz/EEFqeeYt5lQ5DGLclSietpX1QHgn8DbglUiwZ6n8tVfIUc6M+A
         EQec9BqQ32hdJnHiprNFKOkfnVNVa1J4MBAeMG9UKSLOstmTdT99hrrAKiZTdp/1pSv/
         SQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719382303; x=1719987103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLKE2RE1MbPAv0a5Cs9QfOmeDk0TDfpGAaiqzH/9Guc=;
        b=s3WDR3hjkrpBBrvIg8C+EMlSrbQfAVEo5HN1VtIuZaK1UAtcGyfVw+Pbo8XbcuS9BR
         4c/uJhKDUxH5DwZPWn//RtOo5NVCt7z7ZEPWeCuGtcqQu0JIObz/Zq7HHusEgGt4ok2Y
         Cyli0UBDOLePDEtvdE3ppCxDL0Y2kNKRBb2+NYcfM82Wyp7c9/NZjDCaScGL1l5n8rej
         Ic6UsZFQ1vG4Q4a2keWKUwDmqvn8IFMJgrZYfTS8xBrCBbvuMh4RYlTZxDO3ByMsCChb
         bKbLt7JWNnhjXDOUnqU2zgP64Nj2XUa/XYRuSQ2QSYTQBP3KtFcxP9xDXoGNtgp4GbXM
         tZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCXLYVYmpcFMY7fcGo1zwppvKzOjkVrrBAAYZZ5RyjkN0dkrtHYzUhDTWSrUrp3m1CmT359OAZwVSwz/Bk88NegVT3bBPDFt
X-Gm-Message-State: AOJu0Yx9l+L2fCTWx2IH9mwwAT4HoiHu9GvlQvSxN3rrH3Ozz96JKyZ0
	IoJzmNs12jf7qSTSat+7NvEbFAfc5a3jkqK/LsT1ebnaOVXRblxfM0wRSzNcjqE=
X-Google-Smtp-Source: AGHT+IEST9ofFl5I+wiKtwJO8tae2Qn+fLupxhLkGtN+5HcEg8NKala2rJ3I60E7qbu1AlX6gizHnw==
X-Received: by 2002:a17:906:f1ca:b0:a6f:493d:5ba2 with SMTP id a640c23a62f3a-a715f9797damr605681266b.41.1719382302601;
        Tue, 25 Jun 2024 23:11:42 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a71ddbd3479sm422032566b.189.2024.06.25.23.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:11:42 -0700 (PDT)
Message-ID: <14415e23-a478-4385-b556-851395717142@blackwall.org>
Date: Wed, 26 Jun 2024 09:11:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2 0/3] Multiple Spanning Tree (MST) Support
To: Tobias Waldekranz <tobias@waldekranz.com>, stephen@networkplumber.org,
 dsahern@kernel.org
Cc: liuhangbin@gmail.com, netdev@vger.kernel.org
References: <20240624130035.3689606-1-tobias@waldekranz.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240624130035.3689606-1-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/06/2024 16:00, Tobias Waldekranz wrote:
> This series adds support for:
> 
> - Enabling MST on a bridge:
> 
>       ip link set dev <BR> type bridge mst_enable 1
> 
> - (Re)associating VLANs with an MSTI:
> 
>       bridge vlan global set dev <BR> vid <X> msti <Y>
> 
> - Setting the port state in a given MSTI:
> 
>       bridge mst set dev <PORT> msti <Y> state <Z>
> 
> - Listing the current port MST states:
> 
>       bridge mst show
> 
> NOTE: Multiple spanning tree support was added to Linux a couple of
> years ago[1], but the corresponding iproute2 patches were never
> posted. Mea culpa. Yesterday this was brought to my attention[2],
> which is why you are seeing them today.
> 
> [1]: https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/
> [2]: https://lore.kernel.org/netdev/Zmsc54cVKF1wpzj7@Laptop-X1/
> 
> v1 -> v2:
> - Require exact match for "mst_enabled" bridge option (Liu)
> 
> Tobias Waldekranz (3):
>   ip: bridge: add support for mst_enabled
>   bridge: vlan: Add support for setting a VLANs MSTI
>   bridge: mst: Add get/set support for MST states
> 
>  bridge/Makefile       |   2 +-
>  bridge/br_common.h    |   1 +
>  bridge/bridge.c       |   3 +-
>  bridge/mst.c          | 262 ++++++++++++++++++++++++++++++++++++++++++
>  bridge/vlan.c         |  13 +++
>  ip/iplink_bridge.c    |  19 +++
>  man/man8/bridge.8     |  66 ++++++++++-
>  man/man8/ip-link.8.in |  14 +++
>  8 files changed, 377 insertions(+), 3 deletions(-)
>  create mode 100644 bridge/mst.c
> 

Thanks for posting these, I was also wondering what happened with iproute2 support.
I had to do quick hacks to test my recent mst fixes and I almost missed this set,
please CC bridge maintainers on such changes as well. 

Cheers,
 Nik


