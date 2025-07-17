Return-Path: <netdev+bounces-207794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B39B08944
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5331A6381A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAB428936D;
	Thu, 17 Jul 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+bFbHE3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A71C1ADB
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744469; cv=none; b=cgS9sqVRQlneDcT3RhONuPmL6FEDeSegZeGwzpoC7VlZhYA7IeqsLF0jyg08mXtINOSd7FYtc08AFPfLlp7m8sOQnjk0L3cal8uJYjZkuq5qmsV2NDzieuvAg2BrHJr41IdIchIqlGTZIdLF2NFzEOaHs5AX/ie+R1vd3xfbbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744469; c=relaxed/simple;
	bh=qDEILDyb5zWh1DVBQe6FIn1moCnhq5dYrwzb29hpHLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=df7qSp60PO04ofhXcUoaHzXSPVR3KmlztghTiawpN8xzwJXs7jpo2zmXt3Os0eNivlKSpytnzdrt+N1dg+uAKdpaRAnjUIDob5oDDVJoLZeH42NYzQcufCyD++8UAMdCKndXdBSkTh3YnEV3FjOqZcL9tj7VyxhYmRyoSG352Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+bFbHE3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752744466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRLgXYKvAxIJuur24e56OtYwzMHzQtqWBZbQhqj9MLE=;
	b=Y+bFbHE3/fQYxhZOOHpfdkbmLZKD7eOjk+eQvgOEn3SZ3P5HEnGvD4KQfr+g0hkppUnQ9h
	SRMeuzC5GJfsoDz5MCWas43bIU7o7FI7rcYXOohgu/hxUQn54yTCdiMWk2r/7hOy2N2Z3c
	poue0CRrzQasJM+8+Rq8d5TTD4Ubj6o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-IkNFlgjUMHu84UzpFPSgdA-1; Thu, 17 Jul 2025 05:27:45 -0400
X-MC-Unique: IkNFlgjUMHu84UzpFPSgdA-1
X-Mimecast-MFC-AGG-ID: IkNFlgjUMHu84UzpFPSgdA_1752744464
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-454dee17a91so6007945e9.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744464; x=1753349264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRLgXYKvAxIJuur24e56OtYwzMHzQtqWBZbQhqj9MLE=;
        b=i1re6NGrT0MtPW43jpklxZRq6rA4uTOsEzNckezEsXJ14vTjJZuXP+4rTmIyGGML7r
         g22/yYuvUVbj1/sWg4jYGTdfQN/1HUHtOQhdht4X7xcEue6mnOXYwRGcjxP6OwZHoH94
         dnbUBRc9Go6A5ipXkK1zhnCEamdcIg3NoVclBiDfghzDlzTjAojAEUT9tEas64bRtzrw
         h2A1HWTElJMKhiLOQFzD+pw++ykfIoWMpuXZ2cvExP7fpo2mAjImo6+qc7GF6LmQ9FPk
         9tCBVBEiOuT21ixYHG5oM9anuNN/ArpHWN7Kfr1yxc9XJ66mmIeQXCEsA7f4C011hE+J
         METw==
X-Gm-Message-State: AOJu0YzUghszGce0YEey8mIC4kqPhBNBbzHas+S0VmIDMS+SwRWlEePp
	YYrVO6fkuAWMwnor+axlKgEeH1F8GAo7QBCuIgxTg190XnX4v8BlQJ4tx9HMUpmqwk043SUTQuM
	PvRPTkU7TJGopeEMsQtUtVjkrYt0d62Cf3ZOHBM5sM4AiUeRkRwpw4M3fdQ==
X-Gm-Gg: ASbGnctiy6qGIUqqpiaM9N/SlrtOs1cIfNJ7vdAvQ3HdSW+iPMTxv+21ygCDAXCOALF
	aHXbGUIjRCydSy2Peuks3V4AKE4pHeVNU3xuRtSZdba7S9K2hs6SVtErnfh7fv8h/1JEJwuP5dg
	DfNjQHR6Frcre9BGIh2L6hnvBPE9I7o5yYrfysASnvGNeQSJ7oy9I7ytsq341sWhUfG3S3RFoNk
	4mNZjqgo1EVRdxfSBGchWZFqfms1YMLTt0BOBDWKFbmdFH0mPtSY1ezlmnOd69GsbGUHmOWLc6G
	T/BDh04LlsYcOddR7CotcTIY1ehh9qIssVDXikdYPpYU4mYrzSfBlI6a6lmqAfGc1TuASBGcOsI
	ZOh1adQ5Vza8=
X-Received: by 2002:a05:600c:3491:b0:454:ab1a:8c39 with SMTP id 5b1f17b1804b1-4562e3a3a12mr40950055e9.26.1752744464066;
        Thu, 17 Jul 2025 02:27:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYZlOB4G9Mvi0qvozgjB6FxnV6PvrrDAL8fwtlUft5mSWT4ayNGtNYxGH5+Osd6ys14PpTug==
X-Received: by 2002:a05:600c:3491:b0:454:ab1a:8c39 with SMTP id 5b1f17b1804b1-4562e3a3a12mr40949805e9.26.1752744463627;
        Thu, 17 Jul 2025 02:27:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89bfecsm45219995e9.27.2025.07.17.02.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:27:43 -0700 (PDT)
Message-ID: <4688d857-0cdf-4f39-99de-c3bfc7abd3d6@redhat.com>
Date: Thu, 17 Jul 2025 11:27:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] selftests/net: Cover port sharing
 scenarios with IP_LOCAL_PORT_RANGE
To: Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
 <20250714-connect-port-search-harder-v3-3-b1a41f249865@cloudflare.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250714-connect-port-search-harder-v3-3-b1a41f249865@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 6:03 PM, Jakub Sitnicki wrote:
> diff --git a/tools/testing/selftests/net/ip_local_port_range.sh b/tools/testing/selftests/net/ip_local_port_range.sh
> index 4ff746db1256..3fc151545b2d 100755
> --- a/tools/testing/selftests/net/ip_local_port_range.sh
> +++ b/tools/testing/selftests/net/ip_local_port_range.sh
> @@ -1,7 +1,11 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -./in_netns.sh \
> -  sh -c 'sysctl -q -w net.mptcp.enabled=1 && \
> -         sysctl -q -w net.ipv4.ip_local_port_range="40000 49999" && \
> -         ./ip_local_port_range'
> +./in_netns.sh sh <(cat <<-EOF
> +        sysctl -q -w net.mptcp.enabled=1
> +        sysctl -q -w net.ipv4.ip_local_port_range="40000 49999"
> +        ip -6 addr add dev lo 2001:db8::1/32 nodad
> +        ip -6 addr add dev lo 2001:db8::2/32 nodad
> +        exec ./ip_local_port_range

Minor nit: it looks like you could simply add the additional statements
to the '-c' argument without changing the used shell.

/P


