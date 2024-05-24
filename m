Return-Path: <netdev+bounces-97979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542BE8CE6B8
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 16:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B79E3B20C31
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45E12C46D;
	Fri, 24 May 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="L9hdbzvv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB986146
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559921; cv=none; b=YxoldzyXgVeddmrb/iJD6N73IDsoHxbov9wElkPUPFvVrHkI07Tn+WcI49nEiad6ZQQ+lMQsjviWBv8c5RqhKA3N4rp1wn0jkOgJyZLV1fJZStv8XY53lipgHOxnF1WRZBOFqKUSoyCse0zWBq3bZnh3H5DWicybmHuJRL4Lzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559921; c=relaxed/simple;
	bh=IabFXdK1At6rAlruejf2EGb8m7U53NAFeZqP3ULay4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGlxjVTSaUdbtj81twx0L58T+BOUGUou6ankUWjUU11HYpYuO7GOweGEpvJMvFTN0hglY056SfBeZ4ZYZjrOqnL4IWI2FXmbqKYmdJN4+7lyfM8RF9Gou/WXdn+F4GS++lj5yt7rPeg+OCqf709+BSTQ0dkkC8214cDtoRGKBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=L9hdbzvv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57857e0f462so793027a12.0
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1716559917; x=1717164717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsACPan+7+fDxhlVELR38Uhnge7xZ0aAXq4rQh82pOI=;
        b=L9hdbzvvsyGxb8z0azsYQzGCW4Zo9LlnApovCtJXBFmtNGtQ4qaqvL31doRd/NTQFU
         va3ApQjdV4Zzhn7xgLMGyfkgP3/V57EtTly42jftUKMfiB7Owik5oTgsIYwcLOBgG0qn
         1aoHuziMVyKW54M+qeoJ2gSRBLn7VHdcfuztl76qi1B2rJvu3fsW53rWAk4lwFvkaedw
         lIyr2GsaVjPE8SBtq4UZecZZZKTB1BbwqEkgS3cIRY+bC7SK9S3kgaIJkq7GKj010SDP
         MjKHIc0y011n5X4ivQuWu3NBnZ3ihR6tU25t9aUCWTZMEqx2OEyn/609K6SYbJZZZPtp
         avhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559917; x=1717164717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsACPan+7+fDxhlVELR38Uhnge7xZ0aAXq4rQh82pOI=;
        b=TljhN09OAP2ykEgQW8pnYcjAxVLeEigC+1lNKqRfPsxukxy9neKTv2U3W8ZpWMg0t4
         1LzT8ZC2YbUWgBitPDAg1DvHzOdhoZtQooh7WLSXTpGUFtCOgoLRJa1ez5/SIsPtBESz
         1aO4FjvvMkBD+1TgDxG4gIErBHxbzynVVHEPe26BpeehtveaVtp3XIbcld4u3agNMOLk
         yDXGJHEH34YYRpv0TSJjMblJKOmab12W8kO42i4ZEERFwTs/qp7paJZpGy5CJOVOCPIk
         YNvsrpkeW6zvNkMbtEPTzvTPzgQn2aCMXGfTbLDaxYZK2dpZrjd8LXfN/5nezgbqDZ64
         Xdpw==
X-Forwarded-Encrypted: i=1; AJvYcCV9YMsDeMeFgf8v3ojpiljgBOqVEoNOHrWQN66jjnanSoMfK15CXSJud3dbYzV3zOYTnRNxyk4RBIxtxhZTNanUZgXZTwP0
X-Gm-Message-State: AOJu0YxkgUH8El4WAbEdx6ROaHqNgWxxtSD4llVlsk/TKDQnwxZ00fV8
	orXrNS8uVc+e8UlQdFwRVa++kTjCkCgHYSXSij3+Iwb8n81IxlToNAjY42rfyJvca3NZPYsoceD
	Wihw=
X-Google-Smtp-Source: AGHT+IFKYKCsLX0YcetJZsmUugX6A1EiLE5b8aIZsssDksU0f7onCfJsLs85xFAQG4d/F3dt8oW8kA==
X-Received: by 2002:a17:906:2961:b0:a62:2e8b:2ca9 with SMTP id a640c23a62f3a-a626536c040mr136947366b.67.1716559917159;
        Fri, 24 May 2024 07:11:57 -0700 (PDT)
Received: from [172.20.4.8] (92-64-183-131.biz.kpn.net. [92.64.183.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c97a429sm137597466b.97.2024.05.24.07.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:11:56 -0700 (PDT)
Message-ID: <4635a45e-7e49-4ffb-a769-8a5dd8095ae6@blackwall.org>
Date: Fri, 24 May 2024 17:11:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/5] netkit: Fix pkt_type override upon netkit pass
 verdict
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240524130115.9854-1-daniel@iogearbox.net>
 <20240524130115.9854-2-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240524130115.9854-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/24/24 16:01, Daniel Borkmann wrote:
> When running Cilium connectivity test suite with netkit in L2 mode, we
> found that compared to tcx a few tests were failing which pushed traffic
> into an L7 proxy sitting in host namespace. The problem in particular is
> around the invocation of eth_type_trans() in netkit.
> 
> In case of tcx, this is run before the tcx ingress is triggered inside
> host namespace and thus if the BPF program uses the bpf_skb_change_type()
> helper the newly set type is retained. However, in case of netkit, the
> late eth_type_trans() invocation overrides the earlier decision from the
> BPF program which eventually leads to the test failure.
> 
> Instead of eth_type_trans(), split out the relevant parts, meaning, reset
> of mac header and call to eth_skb_pkt_type() before the BPF program is run
> in order to have the same behavior as with tcx, and refactor a small helper
> called eth_skb_pull_mac() which is run in case it's passed up the stack
> where the mac header must be pulled. With this all connectivity tests pass.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/netkit.c        | 4 +++-
>  include/linux/etherdevice.h | 8 ++++++++
>  net/ethernet/eth.c          | 4 +---
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 

Interesting find, looks good to me. :)
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



