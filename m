Return-Path: <netdev+bounces-212805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B0DB22142
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7894C2A4C37
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E52E9741;
	Tue, 12 Aug 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="cy/hELhK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46ED2E9731
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987277; cv=none; b=AGmbxrtsHkFvPODl/goABMsKEuJVTb91wayg4UGLLiaVj8sKG9drCaObahtBy2J+saKURzDU+wLsk5TjjD2MBc9UPU0VCvHkZ0qEyViOgX1GQo85W3wtY7/BUE5LZ9hm4ZuYe+c2cn3WQ1spMU64iidXRA9KRQ+zjxCeBz1Bo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987277; c=relaxed/simple;
	bh=PXnGwUuF24xOhbEFOMK21d4w06vFXybiFXeF2Ah/w4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7I+YEHPtD/x2NEy3rX9NQvX8MYKaGXQgQB065NFWVXXr4GygD+hbfjBc5HsK1WPGZ8l7wGf0oX7+T5GSBIh+87Vna+LWwjDd5uV1+FfuX8vSdmwL8dMw1+tS9TT7DMPn39z5cLaiGW3pCeeBalgrK7J41THseSkD1wmD0ArMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=cy/hELhK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af9a25f091fso695902066b.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1754987273; x=1755592073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+inNV5L+26/jdh8SQHKHh0W+Rujj2zhiV+GcfqL4CjE=;
        b=cy/hELhKHmI1t6eJZTJ0s6a0/Eaodx+331l14AJEV9PREOpBji+A+jE8XHPJar8ijK
         SdsgTnqB9RuJb/ThJRIL91tg3NS74FmyyJO58bK+v5/iQ1uKbXO+b4Tiol1QxKJ518nS
         svPKP1bmHAUan0u/fPmLl4NZu14WTWMHlLN2Xw16xlGMZ8BwpMrnQXek+/WbjCvIz2J9
         Z9TA9h+kcyelDCwE5iL5251VJIY35sTEFulLFkfRwYA+FMBHdBUGjfapGsMOCibFCSp3
         2bYmvUR7B/s5KiWRXGmh4jERDPJsQi+vVrNEllBXAnd/i8G1klpjjcU528svHFlZhwm1
         rNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987273; x=1755592073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+inNV5L+26/jdh8SQHKHh0W+Rujj2zhiV+GcfqL4CjE=;
        b=UIqaN44ZoYi0+0Hq8/Topgd57GpcYP8EhQtSC19ceRXnThv7SoyhgJjZGh8onhNnRe
         /aOnrHMCKy3Q9+YswGYk4Pd6wUd+v2CTjSvTSk3i0tGS6mT12BHEo6BWm8emsna3RLm9
         TfldExmTOSXEKh5AqelwcbuL/oxVajqax0OhCAoXejgNa0zFejuRFMNk3+QTl115dagm
         p9pb19eE9fYvoHKIyuljN7snsUsbO2Z6hfAcc617AY+rzHI2ufNFahmV5Hv4WS0kodSG
         7Sn2jmMmEDFZcJHz5jmoi4tky7hgmCJm0MlL2CgIe7gbgzX8UsOIxh/wk2cjv8QnLvAA
         3Qyw==
X-Forwarded-Encrypted: i=1; AJvYcCWMxfYVeIkSL2yYGhf9cjZ/zw43s+mF5XsCLqevAiVdQEsSojJ7yCB6LZYhBm4EkNF2e7lbBrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/N1q1M8NF15c2rHfQ4ZmEUKlbFAxUNoRjG8FqOMyLLu0HNkTS
	VZV9/qGUixkxeO183ulERccn+LidmdOdhlYgjdlJ5Tu7zM81/CmRUznqHZoQhYucm7I=
X-Gm-Gg: ASbGncvf744tyaFqtnzuLyWbrK0Nu+Dmmm2n/6nHk4kOKvfsR1wvJRXhJcZIetAmwjr
	8poVh5xazjL9WyAjQdrlXZ4CB30vkVh0tfms5c2K9FBmVoW7FjphIO8kSA4sAhRJm32CTZkF02Y
	44fyXB2GLRul60R9rbkzfG0rZ/q7vtYn52r+o5ojoeh3Ly+HTnPQp68URh8pjKlMqUxq1NXj2Wg
	kKVhsUat0O8Ps2XwJvxzPXfb0563BPAT8DP704XsaJcDKs3DEb2pzX9521WyZ2LgAlHuyyBVWBr
	mQyGBX1Wi7V75T0yemS03aHox8cr6bShJjmkPF6KZ61cgjtuUW3L67n0Vxni8QeGw6WWsv7Xsut
	eYwszg8NFynTx24C2Tx2Tb3lkmfL7YZGr+FBRzUw=
X-Google-Smtp-Source: AGHT+IHiODXSXqVSNlXTPQ0+KmwM7lX/U2trNNPVHoBVYZOtB9bVUuVfmYGU4RbFOrj0nX/NiG1amA==
X-Received: by 2002:a17:907:9721:b0:ae3:bb0a:1ccd with SMTP id a640c23a62f3a-afa1dfa9174mr222098166b.26.1754987272989;
        Tue, 12 Aug 2025 01:27:52 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.72.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24062esm2160802366b.126.2025.08.12.01.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:27:52 -0700 (PDT)
Message-ID: <3e84e2ea-2b11-4e3d-99e9-4c6ecabe3bc4@blackwall.org>
Date: Tue, 12 Aug 2025 11:27:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] bridge: Redirect to backup port when port is
 administratively down
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org
References: <20250812080213.325298-1-idosch@nvidia.com>
 <20250812080213.325298-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250812080213.325298-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:02, Ido Schimmel wrote:
> If a backup port is configured for a bridge port, the bridge will
> redirect known unicast traffic towards the backup port when the primary
> port is administratively up but without a carrier. This is useful, for
> example, in MLAG configurations where a system is connected to two
> switches and there is a peer link between both switches. The peer link
> serves as the backup port in case one of the switches loses its
> connection to the multi-homed system.
> 
> In order to avoid flooding when the primary port loses its carrier, the
> bridge does not flush dynamic FDB entries pointing to the port upon STP
> disablement, if the port has a backup port.
> 
> The above means that known unicast traffic destined to the primary port
> will be blackholed when the port is put administratively down, until the
> FDB entries pointing to it are aged-out.
> 
> Given that the current behavior is quite weird and unlikely to be
> depended on by anyone, amend the bridge to redirect to the backup port
> also when the primary port is administratively down and not only when it
> does not have a carrier.
> 

hehe I did ask that question long time ago while adding support for backup ports,
at the time wasn't needed for the MLAG case :-)

> The change is motivated by a report from a user who expected traffic to
> be redirected to the backup port when the primary port was put
> administratively down while debugging a network issue.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_forward.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 29097e984b4f..870bdf2e082c 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -148,7 +148,8 @@ void br_forward(const struct net_bridge_port *to,
>   		goto out;
>   
>   	/* redirect to backup link if the destination port is down */
> -	if (rcu_access_pointer(to->backup_port) && !netif_carrier_ok(to->dev)) {
> +	if (rcu_access_pointer(to->backup_port) &&
> +	    (!netif_carrier_ok(to->dev) || !netif_running(to->dev))) {
>   		struct net_bridge_port *backup_port;
>   
>   		backup_port = rcu_dereference(to->backup_port);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


