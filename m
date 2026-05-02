Return-Path: <netdev+bounces-283377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDWEBYGT9Wm8MgIAu9opvQ
	(envelope-from <netdev+bounces-283377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:02:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC974B1158
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4BCF30137A8
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 06:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA42E54A3;
	Sat,  2 May 2026 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="R45Of2hP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D031AE877
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701758; cv=none; b=mxaVgBeF0BgtjtPmobvd0WEFRXvZsTHBxY4eQWgxbDCc/8A3YxKE0PA6nuV72ca5uQPkNKb64fUs4T6FazMrTWw/R3MY02eELwwQuxJy1hLzIGjGv45LKim5FgSiAx2rEa5vitMp8dCxoTC4i2xrshw0LKP3LBrY2LfeQ3sQ7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701758; c=relaxed/simple;
	bh=zuZtarl0HDSmqW/AZV+7RjZzgS4L7RDu6mlYvcegPuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8GN71ZDjBFkXbLbkJvvvqJ2fhJgqaMi8cRUAkTloMDRDtTdhT1xsjaGHnkyosWryCJyHYbs8DOYzIWiL/cpJQMK4IDxRD+i+lbRrGlC9ZCbdCf70QKSB8CVZExHeaYoA2+lFgAyjmwL+dvkF3mAnXbsgc3apVVlBi+nytn7Rd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=R45Of2hP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso19688755e9.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701755; x=1778306555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMTwyw43NAPsBdN0lEvEHduQcIRfAv5+dGrM1lniOAQ=;
        b=R45Of2hPC0UElpUVYuhMuiYB4F08dAHHNGnWQ+u45o8KHJzcvTSE1a/R5wtVKrIH3h
         6BdnldcY7PDQF0juLRdJ3fUepUmIMHRMjQbTn7Uk4DGhkrV/HjVcRXOTeZ1/pvRE/CTU
         W43IntF62RFcgZv0uRp5MSEj9rs0vr9ajSg2aI0qP+PsEJ7x0Wm0KGd1KhEicGtxcXnJ
         NlaBGInrmjPywgyUh43imJ5juJcJO9ZMnrHgBl31aGH8s0L9VhPfbQ12TLUgNDI+irTG
         fYeVvrBBYE2SmZR/8hjlZftxHJ/9bp7KvkIoKLSJMOGricYt8YuQs80QeH5jLz3KGp0a
         9LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701755; x=1778306555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMTwyw43NAPsBdN0lEvEHduQcIRfAv5+dGrM1lniOAQ=;
        b=P1wgDqh2LwuFyM6OSh+tZbW87utJ31ZrmcZ5SCxhwrikh/fE2UOseX6r/MI5daRNYk
         x9ZaF5oEyzWoNmSYEWBiqDlCfj/Vz4SyK19+BRnmxC7VCFxpc6scEBGTudfqh7TmLklq
         uJYV7Sr7AaoPwQWPXYzYdCBObFjpTCAR4XZkkCf4VkP12H2AGwwX2TF+Qv0/JNswqZQA
         k2Bb5SqZc6OTiHxDOn8YgDD0ntDGP042P+xpWSJ7hcb2NDl6Jd1bm2AsuZ8S4jh12el1
         t4sQKyHVBTbdkdAxAMPBEt6cKNr0GtA07T0I4Nnyw1WqhUuq6ejlUCG/dyx3gqQ9r9oC
         kUkw==
X-Forwarded-Encrypted: i=1; AFNElJ/GrBNKHiqjk60tOW+xh4VmLWOCoBbP+Wz9D7nRFl0pnf58jAEXOynHSDeszQth35dw53HQPcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFESF+dcm7vWlDYEH6RE55IRuIJRSirmNGfUJEPssMLIWajj1u
	L473SfSk6q/vmD52VaLryH3266KjF/TkAq3/RJYy16P9IyVmma6kjnG5iX/2gQFTgmQ=
X-Gm-Gg: AeBDietFu+bTlmR37aasN8YtgRnKj4OlkSbGr50kDkqz8KZna2+ZPKbfw38QV4CC0ZY
	hjcG04T1LhmaoxklcO9Qu+szOXHmgw/SSgLlijAZKPXisHnXAEmuKybjz2gxLWIrMCrCWseYeSM
	Ib4qfWt8VmygRldJhA7K9ou844k4s5dmXZY+J21TiX6qW85A36fDI11E9dOEL4Gs5Ejv/gg98No
	DmVS995jaEzZ25z1VGOTdhuY/0SWUe+m3y62UrnOLxp9EaaEVJkvk28ChbQc+UrG+h3xjpi74cs
	xR21BtJb/euMckS0CHR08bvCmjhXdu4/+mIR8Utn0qjiNQTZkfS+xhsBEQhtKlsTLVjOwhY1g3D
	Cg4axtWf2bFuT13yK+Pq4cI9f4JDYuq5/Cww35rTakdU46sD2Si/jrUF+7xb8MiIvCVG4Fx7jTT
	KGeABPEYF97UGR4X4744R3KfsMRKWwqnvfLcsV4SjFXlUYlI7jwOSrUkG/+KhHtOOi
X-Received: by 2002:a05:600c:c058:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48a9866a998mr20975615e9.21.1777701754546;
        Fri, 01 May 2026 23:02:34 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aac01sm9113763f8f.31.2026.05.01.23.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:02:34 -0700 (PDT)
Message-ID: <dc11bf91-dace-4235-9055-223042067a23@blackwall.org>
Date: Sat, 2 May 2026 09:02:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC}
 and simplify calculation
Content-Language: en-US, bg
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
 Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260501173130.3486-1-royujjal@gmail.com>
 <20260501173130.3486-2-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-2-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5CC974B1158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283377-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

On 01/05/2026 20:31, Ujjal Roy wrote:
> Get rid of the IGMPV3_MRC macro and use the igmpv3_mrt() API to
> calculate the Max Resp Time from the Maximum Response Code.
> 
> Similarly, for IGMPV3_QQIC, use the igmpv3_qqi() API to calculate
> the Querier's Query Interval from the QQIC field.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/linux/igmp.h      | 80 +++++++++++++++++++++++++++++++++++----
>   net/bridge/br_multicast.c |  2 +-
>   net/ipv4/igmp.c           |  6 +--
>   3 files changed, 76 insertions(+), 12 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


