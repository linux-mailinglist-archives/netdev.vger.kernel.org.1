Return-Path: <netdev+bounces-196061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B3AD35F4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC897AA3FA
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A020728FAB8;
	Tue, 10 Jun 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="PI9xuf7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F828FAB6
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558036; cv=none; b=qyfBAjB6RSWqCP+Pts9ExTlz06TVIHJrkT9d0Q7AaE+ZnbyPhg4HBFyNFut0zLcqeCnmjGbpeDx1ZDBq3qE0nLh7sFH1qVq97epla6zY7a/pkujgkVld0zIGHosUtJABuuupIhn5PUecf3cE5Gg/XW02Oxmb8ijDVt+OyfkYqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558036; c=relaxed/simple;
	bh=GxAzovlHgLGnYrZU1ySFi76vhcQRxNyPfdNwRBun9e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0j2bkGhEnxAxDltcJ3nBU4NT9GX2WG/1Cjq1BLQxLzrXzJ/fgUxQ/x24EdP12m9bDVAUM3REOWuxcLzCK+5c6X1idP7yRIAj8IukXJlX86f3dVL5ovmwipm9StXyCUP6PvDAlEEkCgSKbHoCWKWn36BZWTOoRcDlQQNQarwx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=PI9xuf7W; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5532f9ac219so6222476e87.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749558033; x=1750162833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/yj1cI+THStCgol0p5dxqSrifx2yS1OsxMik6/kECg=;
        b=PI9xuf7Wiunjfwc2+tx9Z29olaOMy6XfNMWLLqRQlP2wMc4eimKTRjyl4k+6oMAwxT
         f5XNT9gh+/+xFJSFmWPqBFSpM69iRj5ej5iXeBUKrztSqjir7YQC+Cv95k1OcyCqyvDk
         EVrRcOnAyyR47Sx1Gxdkd4l9KA+2h3EKuRSRX7ONj35M5U4K1jW4uLllJmQPFvCAF7/x
         aM7pteY1XIERSyx86ouUrfLmLGSfhigZu0Qq/gT2dOeVeySlBq5M9JwQGf9kTK0WX4Au
         aio/vf/mdpXkL/um+QFFDcM7xlku8PCxe5NWgAbk4+QXFygzFgqNFYTgKJt4kaFXOwhw
         EcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558033; x=1750162833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/yj1cI+THStCgol0p5dxqSrifx2yS1OsxMik6/kECg=;
        b=q6c8bxhrovnJDsTMXx2tdQ1UR8adxiTPYXVNZwkKJ963ONDh6rSluDpbHiAI20SRO3
         HvIguyeNdl2eKKnYPhPKx4r4EQIqERX4PvPvxgY99OcxitYyjd+2HoD8D0rftJKRMySi
         V3i4jkISqhP/zT5RS5lbMKvKh1pVgyEeHPZvbgr/pLrcHX5o6il4YaXbIVBYItuDtnfm
         NqvxXvmGd87NwqYmpGNxWRYaYSCLlqJYYwUC7X2ihUQBPXR4/l73YmPV5g5hhtQ79ly2
         Bn6pDLlia1LwxQHYyonmttUN60xEQ/b8DMBIkRin6+p7qzCFOw9xc902TsC0OiXPrr5s
         jKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7rsU8Fq105VfvUtRmyWDHWIHZR8QJHPQq8dzxXQdxy+HHNeXos5vB7HZOJGWU5MA9KvnplfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdW8KaJ4//IY+WA6tYF2OHbgv1wJ3H6dFAsAl/TeNpnsGWGTK
	C6bfPXR8OPGBx6cB3d8qSWGUmeoEzuZV0k6QCNnkJBXZoGGZW0xyFf+mHvay6dALldCQmjQDt5D
	w0x/f
X-Gm-Gg: ASbGnct8/+7bT3UgBiNjMqvNLeWr4ADPUOwToyjKlyk9675py6pEWnAyCqqWRvRJ5g2
	UXAU4i4arwt8CeB2hDKuFLtxv0f+iXpEVuMg+bmye9CWP9le0kpCi5XTdBAKxo8sIL369iZGLG5
	R0O2CBsgRer/mfpbLXsW+PvD+wQv/3CTieZ+zy6vTZ/yA0Qk6QPDR23DdgWJCQzXJlWs3a0+Pzi
	XRWrpxeHNOzql2v1D71Trd3Ao167mXGrZsjgEzN2bBIj/LlzSO7e8QN5tOtTqAO2mat2xtsxEQN
	DK5h5u8XgdQxFafJHOY/cj+23T/aGTAF9xZHnTeiMY5PC0S1CtB4syW6Zt7tzX8R3qz7EwYxt7y
	atY/j4bmgNkxfFXmd9bvxpAroXNp7d/0=
X-Google-Smtp-Source: AGHT+IEl1JdeQusLwp3zre1k9d82StLthBpTHKOhic5o5TqIO+6zKIQSHxAEW6Ax+/UcbkiOXIeGvA==
X-Received: by 2002:ac2:4e0a:0:b0:553:65eb:319b with SMTP id 2adb3069b0e04-5539475e453mr745771e87.22.1749558032370;
        Tue, 10 Jun 2025 05:20:32 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5536772254dsm1525207e87.111.2025.06.10.05.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 05:20:31 -0700 (PDT)
Message-ID: <5a6798b9-5e6a-47fc-8217-d7907e0f8720@blackwall.org>
Date: Tue, 10 Jun 2025 15:20:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 1/4] ip: ipstats: Iterate all xstats
 attributes
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org
References: <cover.1749484902.git.petrm@nvidia.com>
 <e8834ec759b3e7f94545fe07a219ca592e84e402.1749484902.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e8834ec759b3e7f94545fe07a219ca592e84e402.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 19:05, Petr Machata wrote:
> ipstats_stat_desc_show_xstats() operates by first parsing the attribute
> stream into a type-indexed table, and then accessing the right attribute.
> But bridge VLAN stats are given as several BRIDGE_XSTATS_VLAN attributes,
> one per VLAN. With the above approach to parsing, only one of these
> attributes would be shown. Instead, iterate the stream of attributes and
> call the show_cb for each one with a matching type.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      - Use rtattr_for_each_nested
>      - Drop #include <alloca.h>, it's not used anymore
> 
>   ip/ipstats.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


