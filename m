Return-Path: <netdev+bounces-93055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D428B9DB8
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EE61F223A9
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41615B551;
	Thu,  2 May 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A71gIaU9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC3E15574D
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664782; cv=none; b=FgRHg0Jf9FECv/DMrMaZgsdA0H41aUW3ksKJkwrt82JPOADQpuCt/nGAsxc6aUS64ZjXf0LXOiZ8UUbhV/KEDmRHWS25gDo9/bghmw/R3Ftmi8vEaswNA9jEPUu1eZerBRRstbvQH1U1HKo7W4953+GmLDux78A+qZn7BwnRk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664782; c=relaxed/simple;
	bh=7uN4OOziHGa1r5iDXT6m1KcUDk/rJcN7Ch/HEnhJQQQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VjHtvoUGhcM6G+We/FUS4Fz9EcQqXwJ95ioNmEGcn5/8bHwlexgYaxUPYNpfXeev/GmInN0VgH5LAvEhCPJHzArkrRDE/WkWolrCdVcE7gH0U10wVDL3mqSZFk/mdfDRfLxUoSZKwQcsuZVStioJ7+Ik5Q+doyc+zcKf0U9A7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A71gIaU9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7906776e17aso576280185a.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714664779; x=1715269579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsDozxKgWVed1UeDj9N1lGqJXjhBnyBPZbhvl0Ca2bo=;
        b=A71gIaU9eQR1sVbD48ytNyviyRy+MUDUna3XiuRz0FzSL7g69xFDAF6iCz8lgE8/F/
         wGasNqMCr7HX9l35Wr1a9y45rh58Xkyuy37ZQPxFNdhXnLgQaPU2EqEohH/G0g44l5nQ
         NTbyY5G7+PyOlHenKicnNpvM3HfHBQ3gsEvgIc8ADS0UecviqP4UdfGC4EDUyP4XBBHM
         APRdMkFWPVA00xlLs/V1LZHBJwS4H9weCTU8A+fxg0MHjHG2pYV7qoTCBIggEtKS1a00
         8xoTm06UKGmmvVLkghALugD12TfZnYH5emeE1n/PEGjU9nI5Cd8i0YcuoO/zcDotAW5C
         cVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714664779; x=1715269579;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dsDozxKgWVed1UeDj9N1lGqJXjhBnyBPZbhvl0Ca2bo=;
        b=w0Fy8Q3TwWDbAPAnLG9+SeCHS8E+42kQ4LcFmnhXZjS5h+b/ZUBFNRNJ+ekKmm2B5+
         kp6DSXc4aASQpYSTwjsDla8RQg1cdycyd3ZHajB6JfDi7v807AKa6kZDW9zu66eIn8eI
         meIKugWBHPEVkbIwSqWJ95rEGDHisoO283mrbbGHq8LclMURO+NyOnMRwbaqe1fYtwED
         7cc1bdViMgHzAplfpDdmbl0Pc9WFI3/6H04APW630VKX2yq0G753upwDQmyfaCKvEh0Z
         FFgyQhyxRFhJsIVG1kMvC3Wg0z0z+9Ui86aPvi3GFFDisAhqdJAn2JFPdGRAoyKNcrrX
         55Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWFWt3Fqre9ldIxfpi1h5oknMr935IipH0/NhI5vubd5chDAe0NICQENeXUDbgLzvV61xMSuhyEaorZz2jvz4xgdkbrDEFh
X-Gm-Message-State: AOJu0Yx7d+diw0YDxKhWVjo7hYzxZmFZ/XnA7ovTL687DHzKVkbTuCfV
	qSNIpH7uVJ7amjzDBfmmLJa/DvlF5r1qVy9eE+0K49LrJp8C6CDo
X-Google-Smtp-Source: AGHT+IGT18fO0AN+tj5xuYlkE4+IKjECeS1YBw5ttucku0axiVOVTO4ruc9uIIljo1UVjgYfoiL8Bw==
X-Received: by 2002:a05:620a:178d:b0:790:a3a7:7cab with SMTP id ay13-20020a05620a178d00b00790a3a77cabmr7279484qkb.39.1714664779501;
        Thu, 02 May 2024 08:46:19 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id dy29-20020a05620a60dd00b0078ede19b680sm451838qkb.75.2024.05.02.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:46:19 -0700 (PDT)
Date: Thu, 02 May 2024 11:46:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 pabeni@redhat.com, 
 edumazet@google.com
Message-ID: <6633b54ae5c8f_39a1a82941c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240502084450.44009-1-nbd@nbd.name>
References: <20240502084450.44009-1-nbd@nbd.name>
Subject: Re: [PATCH v5 net-next v5 0/6] Add TCP fraglist GRO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
> 
> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
> socket in the same netns as the receiving device. While this may not
> cover all relevant use cases in multi-netns configurations, it should be
> good enough for most configurations that need this.
> 
> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
> 1Gbps.
> 
> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> rx-gro-list on:  770 Mbit/s, CPU 40% idle
> 
> Changes since v4:
>  - add likely() to prefer the non-fraglist path in check
> 
> Changes since v3:
>  - optimize __tcpv4_gso_segment_csum
>  - add unlikely()
>  - reorder dev_net/skb_gro_network_header calls after NETIF_F_GRO_FRAGLIST
>    check
>  - add support for ipv6 nat
>  - drop redundant pskb_may_pull check
> 
> Changes since v2:
>  - create tcp_gro_header_pull helper function to pull tcp header only once
>  - optimize __tcpv4_gso_segment_list_csum, drop obsolete flags check
> 
> Changes since v1:
>  - revert bogus tcp flags overwrite on segmentation
>  - fix kbuild issue with !CONFIG_IPV6
>  - only perform socket lookup for the first skb in the GRO train
> 
> Changes since RFC:
>  - split up patches
>  - handle TCP flags mutations
> 
> Felix Fietkau (6):
>   net: move skb_gro_receive_list from udp to core
>   net: add support for segmenting TCP fraglist GSO packets
>   net: add code for TCP fraglist GRO
>   net: create tcp_gro_lookup helper function
>   net: create tcp_gro_header_pull helper function
>   net: add heuristic for enabling TCP fraglist GRO

Reviewed-by: Willem de Bruijn <willemb@google.com>


