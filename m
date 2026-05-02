Return-Path: <netdev+bounces-283380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCuJCz6U9Wm8MgIAu9opvQ
	(envelope-from <netdev+bounces-283380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:05:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6364B11A7
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555C8301ECD8
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5BC2ED870;
	Sat,  2 May 2026 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="gYykFdUD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA682DF13E
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701945; cv=none; b=RZ7hwJu0ze43lr/4IuWAnpQl4tX3s81g6ej7cNr3Jozb7aD8TUmoFSoW1ewvOFI5up5Gh29ZRRD2AqhsaEMpiWD72BY5HP8DjnVCeX6jkcNUCwhcz5nRGAQlsdkBcuahu+Onbg7wThISt1A3tlN0GvdUfSicoObt8zS3IfPbifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701945; c=relaxed/simple;
	bh=X/hZCb0jhWMLtO0yzfJTyu1aVwl+6kQirfxui/Burbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUZykWGdUHGAlUGJecmlR6kqud14HHfG1diWw0ORtJ2VaG77Y/xmEaOHuXfDQCB7KKE9AHtBLj+irB2K3gWct77mIHW8Ur8YLKA4oNcIJszJbBZFZMXRyM4lTeI4AhODTiph6kJID5viEmFMBjP/TG0iSmg1c6/WEeFAp7gmhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=gYykFdUD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so19714875e9.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701942; x=1778306742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hb311y/HjKGqfYjiqwo0iWKOc8y7rqDPGTnOkcrspE8=;
        b=gYykFdUDDi2ROI6LbXOHU3TdkfVmdZjcslOVXt4bIBdCYVFtWJYrdomHd/mX4aUjMZ
         Q9X+z3BvUJ00AfUCNWiSm616pj8jk63wDt0Su3i4xwcN3AqhLQXTCj60lx0bwOzk3iYd
         TNADnzqemOfQqzQ4dk9M/nsouo37c/M2qqMoczwEzm0gYasP+Sz5phgxUZPGKN11gi72
         aJdVcUtDgFa+aQbSApjtC27j8lrmjKaVY/93e7HwbM+tis6xRJJagWtEHoSlEw9aML3I
         rGrgQZFzzUZu9nhPC9KSS02X+VYaWv8FIKs7eP+wGy0lJWKiFFCQqtPQ8LDG61MPGVkO
         Ju+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701942; x=1778306742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb311y/HjKGqfYjiqwo0iWKOc8y7rqDPGTnOkcrspE8=;
        b=Ikoj8Xp3iifVlRFjPqfGHoIH0ORjmnpoVQNXaRTTDa+MQFPccne5U9jrKqJc6D4NQH
         fggvYk/hII6akBEHH4UqjQuOxrDXcuLl0oc1ARJMwzrLUAYL3q1xB6wsZbXzLwNTgy2j
         um+2D9pYshqN4MgJgcln8WY4PahjXVAD3u9Gg1b4KbxALtwhpiIswzok7deD/qlQfOUq
         oVYUFSHE+SQ7mnFdnZ/GuEkJUYmqF/41bj7eWntyUnReky9IkWCNbPLA1cgBGme2Q/sj
         MB4lxMwFpeMfAUTpF8cwhzNM4TNMkvSLtw8CdjUDoNlgA5IexIOBA6jlBsUTzdfQA7uG
         s1pg==
X-Forwarded-Encrypted: i=1; AFNElJ/zydP6eORv9aubYFP+1qgr2vmwtDeGiYaaJ3qnddNE5K/W1tBFdmLR/KFpZ6Ao0GTF5c0heSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6VeO7CjZwjK+ag+Rx04KQw2jcTUZ34EyyffgtXSJWj+1PK/gD
	ejSyNiXsdrYbd57/uiXAq3a4MFe5JEg+EwVfIMKS5copSCiswmV/tmWaFj5vmIIqIB0=
X-Gm-Gg: AeBDiesITBlalepN0gH6dorHKaJQiuVoeW6Jfz7Z7l2aZ1NeXm3A03cwQe1C/JPX4lv
	Awtz5jbkqMZd6eSuMtPVuw7KPDzFqIACmdL3neJZUc2a7yiSx/SLFgM44LUEsoe7xMtxIygrJfR
	GzSszFs7JqLd0TMMQaBwdp9k33nmzlagdDTnbX4Hv7+5BlzuCWqpY/xXLfmp+L/eAlzKiydbIJ0
	ZcfcZvyKtLp8roT6czCSdjvpZr9usAMRQNIKhtxmsVcSuKfWMqKNAAzMmJAoWnRc/SlRAQMCXAX
	7368NYc9MOFhPUs7CSeVrPKZBovtEWz4g/TW9rCdym3k8wFmF0y1HbJT8od5sH8Am6WGlBuB2bJ
	QQTHIUzVDsK+q0IF4FD/RSG1OgP4baIqQzIyoG1k3R5g7hcSc93pYDdzK0qa9HGZKaP6Picafbk
	hIus3bAbaTcQ5LipFJTThXr6dgc7ut7nd+j10bfwtB+xGAGiUfMWdNNFM12NSVpx5E
X-Received: by 2002:a05:600c:4f13:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48a970fda7bmr29905755e9.12.1777701942442;
        Fri, 01 May 2026 23:05:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822c3422sm157004635e9.8.2026.05.01.23.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:05:41 -0700 (PDT)
Message-ID: <60fd2cc4-1c04-4db6-97cd-bc3bb9710a04@blackwall.org>
Date: Sat, 2 May 2026 09:05:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] ipv6: mld: encode multicast exponential
 fields
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
 <20260501173130.3486-5-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-5-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A6364B11A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283380-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid,nvidia.com:email]

On 01/05/2026 20:31, Ujjal Roy wrote:
> In MLD, MRC and QQIC fields are not correctly encoded when
> generating query packets. Since the receiver of the query
> interprets these fields using the MLDv2 floating-point
> decoding logic, any value that exceeds the linear threshold
> is incorrectly parsed as an exponential value, leading to
> an incorrect interval calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures MRC (16-bit) and QQIC (8-bit) fields are
> properly encoded when transmitting query packets with
> intervals that exceed their respective linear thresholds
> (32768 for MRD; 128 for QQI).
> 
> RFC3810: If Maximum Response Code >= 32768, the Maximum
> Response Code field represents a floating-point value as
> follows:
>       0 1 2 3 4 5 6 7 8 9 A B C D E F
>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>      |1| exp |          mant         |
>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> 
> RFC3810: If QQIC >= 128, the QQIC field represents a
> floating-point value as follows:
>       0 1 2 3 4 5 6 7
>      +-+-+-+-+-+-+-+-+
>      |1| exp | mant  |
>      +-+-+-+-+-+-+-+-+
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/net/mld.h         | 119 ++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_multicast.c |   4 +-
>   2 files changed, 121 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


