Return-Path: <netdev+bounces-153878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F219F9F03
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A89116B94B
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8FA1DF986;
	Sat, 21 Dec 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FY1rdupN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC21AAA3D
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765734; cv=none; b=FrWyLc1l8ynkUVu9CYTEJTHKROvSFdV8blUqjoMNpaITnvAmzaU7lVDD9Fs+tc/3CchE8F5DZxr48QlafB3XdsLttE9E/FJ9+LdyPm67aEc6x0zkGEQgoGj644YIKXWVtllSGg4P62T9lqWzoULyNSiCloDCi7vS4XDgi8kzcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765734; c=relaxed/simple;
	bh=VdYgoyIugbj+71Cae8f7b/3XNaXG1CuIVgxK69uZCTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjJXFu23QOZ/uaCPhqj12JT2eUeu6Ckt1Zpko+rVKbT7A0+LmniyECEUJT3KUdZRKrnbykOGjQNur2HkpbCMbBeBBGsHSBnpNls8y+CEE4ssaf5hIYtBcsHVxPOiK7UBq2jG+j+Rg+8pzBs4TbwBYoqz97xNKfBkHHmDKAMF0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FY1rdupN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361f796586so28092345e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 23:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765731; x=1735370531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDfqCZrNP8M56R6K06iXL2WlA0atYz/trKoVRKTWAZM=;
        b=FY1rdupN5Wu84zkmu9gNp391xx/aitkUYeVqoYAO7QJzf+LUyb0WVQAxPdSpBjO07f
         oh1yyPc5J3jXALZnFDAkzsAKNSND+5jZTA1lkZtCFpKMWj3vdb4tNN+l7nv/XKMrY780
         33ImwfR24j0tlxfhe+XpRstb49X1L5GCPKwSIAH5fhnzj5b9j/GogEvO/I0tklyVieXk
         cxgRo7gP9hddLhkBKTiAfcbEyaS5YYnBjT2SidRZr+Xgv6KDtW3m1twRaQy37STghU5V
         MDOobpWUQOFMsGvzJ0/dY9DNQPsVVHTB6RT8nZv444LyIX8K40V++nVPbwN+szZxAkjs
         Lxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765731; x=1735370531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDfqCZrNP8M56R6K06iXL2WlA0atYz/trKoVRKTWAZM=;
        b=vyDioPQFfXeuS/rdH2HAoSXuHFRHFUSuF5TznaBfeZRw2GBjEEg9ZpImE+HCtqL+1g
         iabDRnGaa3PklSi/4m8MCXrRwyNoCI0O/hWBvXsNmf0Gf9lTDAjKf1OBGrf/oRw4pHMT
         Opgl1+bt4ajGv4/uDreDF43zG0tg9o4i4Iy4cLjoEt66gJu72geS4M69anREfL3io2kL
         BLEFJpWxkUvqc0cl1zij9AIa5XKYEMEu03Ge1x9wB9oIS/pOLX+bZTqU5v04YNK+H2Wk
         KYpWCPTzlur0h86YX6zTlNLEU0Ic/T6JdU+T3l7dGVqMRGTZ23II+Sc8hdR2unF9Wa+6
         WRxA==
X-Forwarded-Encrypted: i=1; AJvYcCX+FyOjDYn2KA5at3Zd7LF0gPTdB2AW+REqLkAWR4barxlwziA9kRuMJQHZb35sYl9xSzM/yPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSn8F6Cl3QVwEtb77vVTq1BrI8kTyD0TwqnNM0Hupe1B8Xo1gE
	4LRni6hj5MdZ3ESJfKiydelIrRWJq7ZNO5btzv73HJ10vVwsbUjAeviSpmDCLRo=
X-Gm-Gg: ASbGncsrFA99VZePP/K1KFQBt34pyZv3qm+NTxmYloQIdCleRaaVD/S936/dkGGcm28
	++EZHMHHgq1O2eqVzZIagOn7Wb69aMx/v9pJjUuW4nZ8HsPXAvkFDJR7TF95vuscAR0GbhtUarK
	DqzrlSI52WGUkDcY+pgMwb3xdKkJ6YQeTSPP6jSr6yalkKuRR7ij6IjUus3SSAyTBDFlMtSpVgD
	MagHuMiLDJZ7+9prJkABA3CYKOWdFHwqSJjANnCmZIOagtu4rdLGsvO1kh7+wHd3vV9yblArWw/
	hV/A0d5X6bH9
X-Google-Smtp-Source: AGHT+IG9GgzCc7c19ajzoMiNbxsVpjcaCnOwHoxuB+nszKyInY0ZdFm38wO5hbiuDOtZGERyjVA/Vw==
X-Received: by 2002:a05:600c:4586:b0:431:5c3d:1700 with SMTP id 5b1f17b1804b1-43668a3a3c4mr45392495e9.21.1734765731030;
        Fri, 20 Dec 2024 23:22:11 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b287sm100799385e9.29.2024.12.20.23.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:22:10 -0800 (PST)
Message-ID: <26e95063-4737-42f1-91e2-74aae0e71941@blackwall.org>
Date: Sat, 21 Dec 2024 09:22:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] netkit: Allow for configuring
 needed_{head,tail}room
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241219173928.464437-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219173928.464437-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 19:39, Daniel Borkmann wrote:
> Allow the user to configure needed_{head,tail}room for both netkit
> devices. The idea is similar to 163e529200af ("veth: implement
> ndo_set_rx_headroom") with the difference that the two parameters
> can be specified upon device creation. By default the current behavior
> stays as is which is needed_{head,tail}room is 0.
> 
> In case of Cilium, for example, the netkit devices are not enslaved
> into a bridge or openvswitch device (rather, BPF-based redirection
> is used out of tcx), and as such these parameters are not propagated
> into the Pod's netns via peer device.
> 
> Given Cilium can run in vxlan/geneve tunneling mode (needed_headroom)
> and/or be used in combination with WireGuard (needed_{head,tail}room),
> allow the Cilium CNI plugin to specify these two upon netkit device
> creation.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  drivers/net/netkit.c               | 66 +++++++++++++++++++-----------
>  include/uapi/linux/if_link.h       |  2 +
>  tools/include/uapi/linux/if_link.h |  2 +
>  3 files changed, 47 insertions(+), 23 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


