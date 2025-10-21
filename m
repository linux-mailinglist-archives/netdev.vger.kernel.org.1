Return-Path: <netdev+bounces-231096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4DBF4E50
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73373467D4C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DEB274B5A;
	Tue, 21 Oct 2025 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aN8EIQ72"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AC27466D
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030889; cv=none; b=lVcu0LiuQ+Dfe4kyscqpg2lL7Ol9A4O2vuDNmTYeDQc97m05ApXKPzY/ZHPuEjebHOaDgDB5C6ZHqduKBc5P+ACdxSjogsRjnwlXbFB1BVp3SoYUF8qt9TyI3vemIirKxqoufGhaHHOM1e3W5qb8fPjEQ5HpvAEXoXaOBlmpTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030889; c=relaxed/simple;
	bh=+B2pxE/i3SpbGCZgmKAbV6E4BQeWooWjeCR64E75cc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPvx7VmK9bJn6HSrvCNGdVdnXxD6konyCbBPtr4Ks1eEcO7TEiem4LaH9Avo7gdPvySlIWqtY4+4/EHcvM+1A6X9/+gpWCU+1MEuXtH5fq9Rxg6R+6wGXcPSj7A2lMGG1TmV5SnzZHJdsNXxuqo1oF8ww1Kkv15u1bjXui5W6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aN8EIQ72; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761030886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3VpVCv3g+Sg2rw7HqhbXAeRhRk3VZinAbv22WqGX9s=;
	b=aN8EIQ72jM1JBH7LuRGkCk6AE/rt0NjnBZI1UJy/4Dxy62/D29Du0cJY2macei2NJOU7J4
	NEdxO6xHG7rq1zg9ForjtcIZknjdO0bW9wr9tzaszybIvwgt2f3qfqeVO8Dqtti2tVOlTr
	D8KITpl3XIe8lWWukpj5xFWnLp1KqT4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-AXDhg5npM5-1YWCCEa7T-w-1; Tue, 21 Oct 2025 03:14:44 -0400
X-MC-Unique: AXDhg5npM5-1YWCCEa7T-w-1
X-Mimecast-MFC-AGG-ID: AXDhg5npM5-1YWCCEa7T-w_1761030881
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so28293095e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030880; x=1761635680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3VpVCv3g+Sg2rw7HqhbXAeRhRk3VZinAbv22WqGX9s=;
        b=fW93rf5yCm8sJlzMbjn28qpZkRPdyMii8zjAvfxa6Qz/2tZZS1Pt/LtqOKflKmx6vr
         A4xcK3ooRVUzfLMeh2FMmESsISBSXiuAR8/KcoZX7AITFgX9fsf+2oSzhMarzmg3yUMa
         KrxtbPct+2Hw8hNNDUyp58fe3ifRvQS4ZaH4pfl8YD98E95jgeqefHhxihkmqPf3wxX6
         91ALoMk/iJSgMEnNXUdoR27/1hSH4QLa19Ekvg0P6xcP/rLGJrBSv70173sa3lgc7L1A
         GoGQ6+Ectrg4HCuoyVyHSbHmqa6FgUjW+QORE72eNjOywg+9H/9+6Apesv5L0q8edMwL
         bxVg==
X-Forwarded-Encrypted: i=1; AJvYcCXk58SYenGPaxVN2KXnfEbnmmCOVNGeRyUYPQzoPs0cWqYmwdKXRJqJxz3XWevXKud+EzmOkDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2MwXGtvIsEgnNQ5X8KH4jQVrG8yrtvENOcgJ7Exai5uWS9Xe/
	6CVHchltrHn4iuOiVSSazVmWJYRCl/bCp464lNS+lnqbC43AhsLb8DUBqPxwqt5Yg147NiRzsy1
	1nXlxRfeqrJtKdnSXtq+/T0eTNTUWgi1GEIa8DTb3g2b57ImPiSRsfPrODw==
X-Gm-Gg: ASbGncuvLpBVmx/Vw9AzyWsf7xy/lco13dxHjcHVBp2Dd9oHssnL42/ds9j2nTZY4q1
	58m/xggs4uWvz6vDg7IgZlgrD5ZNUlswwbiXvsdBjGSeH+azgbyER8B4YwRnO6v0BGryAkIayJ8
	p2nR6+zmTndrlk0kpQfN319yvZjmfAYikvPitvcXdgWBe2JYBm8Vmspv6xPzVXMCyq4taGNvqwB
	OPOlWs4n0N1eIDH3zyrWbWIVM8J2JenLrt7cWhE2Mj2BHIEyAsXA+Jy/9VxAOo8YKDF7nQ2Ymbz
	Kb8ef6IpzOuj5f6X1L0ISPLk857LHfxJLPFEmL+Av0rAHNqcXuuq8YIRgDAavp/uluzCpb/2ogo
	5qzvIDMq19E8jbhbvhhr5MMebpnKb8sBlXF6xbQOEM7UKSdE=
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr122888375e9.33.1761030880619;
        Tue, 21 Oct 2025 00:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAbONMD+QOMnDrNKO8RV6QYb7ZpSXAEjBfkQuhDaa4d7qoOlbgykLKNXPsi+4U3b+ujGw+cQ==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr122888225e9.33.1761030880241;
        Tue, 21 Oct 2025 00:14:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f9dsm18907741f8f.39.2025.10.21.00.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:14:39 -0700 (PDT)
Message-ID: <be03d7a5-8839-4c84-9e16-b96e52f6983a@redhat.com>
Date: Tue, 21 Oct 2025 09:14:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net: enetc: Add i.MX94 ENETC support
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, Frank.Li@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 richardcochran@gmail.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 12:20 PM, Wei Fang wrote:
> i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
> can be used as a standalone network port. The other one is an internal
> ENETC, it connects to the CPU port of NETC switch through the pseudo
> MAC. Also, i.MX94 have multiple PTP Timers, which is different from
> i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
> the IERB ETBCR registers. Currently, this patch only add ENETC support
> and Timer support for i.MX94. The switch will be added by a separate
> patch set.
> 
> ---
> Note that the DTS patch (patch 8/8) is just for referenece, it will be
> removed from this patch set when the dt-bindings patches have been
> reviewed. It will be sent for review by another thread in the future.

Note that such patch is (AFAICS) breaking Robert's tests. Including it
in this series will possibly/likely prevent (or at least slow down) acks
on the initial dst patches. I suggest omitting such patch in the next
iteration.

Thanks,

Paolo


