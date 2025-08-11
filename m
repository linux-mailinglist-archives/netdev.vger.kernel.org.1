Return-Path: <netdev+bounces-212565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 992D8B213C1
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB8C188C838
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3984E2D47F3;
	Mon, 11 Aug 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNm9i29F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C829BD8E
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935106; cv=none; b=joI0CI8EGkD2hVxsFcjOASZmCr11XFJKLMJS3faiNDYJ7vxPYKCvz9iswXz2GGEDOfpbrxf2fLWCX8qHQx/2uLd5O3kKaUYl5QIlREpez7jt6t52MxEXdBD2jtalvgkVtz80jSRUceZHlMhdqxU9oOoLhhyJjezi63RTIGtN8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935106; c=relaxed/simple;
	bh=HNQmaSgFMVsok2X4cUTga1SX+kDtjR7sq7Fnu5ndg7A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TfZBlqgbLBpLDLoDwmSPbCaWGz6WY/8jgz227adMO4+12DVPUgNmPA2WJftdwPBfBaaoTC7FpOvAenTfyPBS2wrOrdOqBzUqGfO8jHAaONzPh0n+CCpDhipti0kkrGEXSLDEqphLBQouuHQwWojqR5auB+wOkhF4EjQ/fLADKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNm9i29F; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b0c5d57713so27329691cf.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754935103; x=1755539903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SxEXq25hmUxXJoOXMaEuP57SGoUzMi4Sc7B6HeImLg=;
        b=nNm9i29FA62EfVBPFowGOBX7w4qQmpQQzHDG3oicUMIm5HMtIuc6NwVmKt9EPmqGVW
         AwzgZ5pDBauHc3uM5O03n+Tl9FGX0ed7T71AeE+EIV1CWF4GGP73xx+3bT9GpJs8ewYh
         mNGOFK6h0m3Ju4eLJ3rTQ0QDcM/dzxZeMFZLflHjTKCrbco9Y/H50zhlXWeA7e8Z9yay
         Ubx/DikjZY2f3pFqhcr22OKiOXtTXahFcaA0rCu4qu/dzemaCiEAuUg4NPANMs/RlmEh
         JMSKvcmvCx4PJeM7dtIymYJL6bT2TMbckygbJaPEVpXQwrRqZPW/5bkBIGUrFix8WWXF
         JwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754935103; x=1755539903;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7SxEXq25hmUxXJoOXMaEuP57SGoUzMi4Sc7B6HeImLg=;
        b=NgWysec9vF+7v6l0A/cu+1XlRBFAWH+0o6vfkaNb+PMAeLrSGttIMyqOtJ7n1Gp30g
         Wmy0BK6UosCA0DyaB1IOc68rtGpnHnSGJUIgSuQAmoyusKANCyrmYzasSbWidmeXOmc6
         gcOGPbDNvGY99pkbWR7UI3n7aEC9+HZ6KYcsDY/OOoxg8aRYRQsCgXDkDNT3/k4Sauv7
         RaiIunCuDBrCPO3ld/iPIROAd48jo9PP4ESngRb3csYb8yvs0Ns2yhXgYfCGsR9f5que
         RaTFh8RZGHcjJC82Xl3AJXxpSbAnaMaHkQcdp8O3iseBQ+ycUuEg/q/Jy7zuq5FWpl2n
         qf6w==
X-Forwarded-Encrypted: i=1; AJvYcCWrJkHhGncAkh2XHBTI/9brPVuEsh7uqDP/vJ5lV3hhmomIl+058b2bXMhFjydU0NzijZ2GH3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqhWwvUQPNU5tiAJT4a0HwpsqsbOWyIBD0d9AXvN1UGFAeWliq
	rv1ffPyGRXtQMPeCWGk3mthXCHc1Mq3zNiH67dlPML2EavR6ZIDVxFpf
X-Gm-Gg: ASbGncsz7eNYTG8Y5kqm7Bpuqw2H6YtbLB7p9kve+mw6Q6T+ho8q+LAqKEqaCB23sX0
	RiTRqTdursoaR2pa+TmXGta66MQY/2hYHlwLMmg0szPUb8LQgZhrlhADtnqr7mtERV3rkLBxAvl
	AMSe7eudBlwjUVGECjUhkkK1Z/9MeiIe4oNzg7RuUIHT0h+9rhuKyziJcjQIJaMlfPP3lVjZS+V
	ImhJcHP44I+yTscLWvD2kcBEs8eOHXWVMhYa54/oMnM9s3kTb3sCLlt19WdDcAWGLGjE9cB10bu
	5dSduugGj3tkTQc/viMm14eSNbkfD6TDBy3Y7M/GUfKz3fOvDT/dFqnqK3h+JB/WtwmEfalHW8j
	jGCLLIqiewgSqXMfeLlxAId7ESHQ+5job+2iA+DpquwYaap9ghR+WAWO/SFBKPcWdFN8Dvg==
X-Google-Smtp-Source: AGHT+IGATRjjo92uZ4K+Z5mkj5AggVdD8pMDsbNf9VgPHG6Qeka/1O44sGc6iow/YKnBd4KaLEiqaQ==
X-Received: by 2002:a05:622a:8588:b0:4b0:71e9:1f99 with SMTP id d75a77b69052e-4b0ecc514c4mr4459451cf.30.1754935102797;
        Mon, 11 Aug 2025 10:58:22 -0700 (PDT)
Received: from localhost (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b081827d0csm92551371cf.11.2025.08.11.10.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:58:22 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:58:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Ramaseuski <jramaseu@redhat.com>, 
 willemdebruijn.kernel@gmail.com
Cc: horms@kernel.org, 
 jramaseu@redhat.com, 
 kuba@kernel.org, 
 mschmidt@redhat.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 tizhao@redhat.com
Message-ID: <689a2f3db6c9a_631932945d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250811153315.856048-1-jramaseu@redhat.com>
References: <689512a45dabb_217ac1294e6@willemb.c.googlers.com.notmuch>
 <20250811153315.856048-1-jramaseu@redhat.com>
Subject: Re: Re: [PATCH net v2] net: mask NETIF_F_IPV6_CSUM flag on irregular
 packet header size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Ramaseuski wrote:
> Thanks for the feedback, Willem de Bruijn asked:
> > If you go to 04c20a9356f283da~1, does this traffic work?
> That is a good question, prior to this conversation I checked the results
> on 6.11.0-27 (which is prior to that commit), with reverting 04c20a9356f283da
> and 68e068cabd2c6c53 on v6.16, but not on 04c20a9356f283da~1. Here are the
> iperf3 results for:
> - git checkout 04c20a9356f283da~1
>  Connecting to host 2023::11, port 5201
>  [  5] local 2023::12 port 47768 connected to 2023::11 port 5201
>  [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
>  [  5]   0.00-1.00   sec  1.88 GBytes  16.2 Gbits/sec   79   2.14 MBytes       
>  [  5]   1.00-2.00   sec  1.96 GBytes  16.8 Gbits/sec   11   1.89 MBytes       
>  [  5]   2.00-3.00   sec  1.96 GBytes  16.8 Gbits/sec    0   2.53 MBytes       
>  [  5]   3.00-4.00   sec  1.96 GBytes  16.9 Gbits/sec    1   2.35 MBytes       
>  [  5]   4.00-5.00   sec  1.95 GBytes  16.7 Gbits/sec    5   2.13 MBytes       
>  [  5]   5.00-6.00   sec  1.97 GBytes  16.9 Gbits/sec    0   2.72 MBytes       
>  [  5]   6.00-7.00   sec  1.96 GBytes  16.8 Gbits/sec    6   2.49 MBytes       
>  [  5]   7.00-8.00   sec  1.99 GBytes  17.1 Gbits/sec    2   2.26 MBytes       
>  [  5]   8.00-9.00   sec  1.97 GBytes  16.9 Gbits/sec    3   2.06 MBytes       
>  [  5]   9.00-10.00  sec  1.98 GBytes  17.0 Gbits/sec    0   2.66 MBytes       
>  - - - - - - - - - - - - - - - - - - - - - - - - -
>  [ ID] Interval           Transfer     Bitrate         Retr
>  [  5]   0.00-10.00  sec  19.6 GBytes  16.8 Gbits/sec  107             sender
>  [  5]   0.00-10.00  sec  19.6 GBytes  16.8 Gbits/sec                  receiver
> 
> - git checkout 04c20a9356f283da
>  Connecting to host 2023::11, port 5201
>  [  5] local 2023::12 port 44762 connected to 2023::11 port 5201
>  [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
>  [  5]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec    0   13.4 KBytes       
>  [  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    3   2.69 KBytes       
>  [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    8   5.38 KBytes       
>  [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    5   2.69 KBytes       
>  [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   2.69 KBytes       
>  [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    2   5.38 KBytes       
>  [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   6.72 KBytes       
>  [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    6   5.38 KBytes       
>  [  5]   8.00-9.00   sec   128 KBytes  1.05 Mbits/sec    2   5.38 KBytes       
>  [  5]   9.00-11.29  sec  0.00 Bytes  0.00 bits/sec    2   5.38 KBytes       
>  - - - - - - - - - - - - - - - - - - - - - - - - -
>  [ ID] Interval           Transfer     Bitrate         Retr
>  [  5]   0.00-11.29  sec   128 KBytes  92.9 Kbits/sec   28             sender
>  [  5]   0.00-11.46  sec  92.7 KBytes  66.3 Kbits/sec                  receiver
> 
> - git checkout v6.16 + this patch
>  Connecting to host 2023::11, port 5201
>  [  5] local 2023::12 port 60108 connected to 2023::11 port 5201
>  [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
>  [  5]   0.00-1.00   sec   807 MBytes  6.77 Gbits/sec    0   1.74 MBytes       
>  [  5]   1.00-2.00   sec   852 MBytes  7.14 Gbits/sec    0   1.74 MBytes       
>  [  5]   2.00-3.00   sec   851 MBytes  7.14 Gbits/sec    0   1.83 MBytes       
>  [  5]   3.00-4.00   sec   837 MBytes  7.02 Gbits/sec    0   1.92 MBytes       
>  [  5]   4.00-5.00   sec   846 MBytes  7.10 Gbits/sec    0   1.92 MBytes       
>  [  5]   5.00-6.00   sec   852 MBytes  7.14 Gbits/sec    0   1.92 MBytes       
>  [  5]   6.00-7.00   sec   849 MBytes  7.12 Gbits/sec    0   1.92 MBytes       
>  [  5]   7.00-8.00   sec   849 MBytes  7.12 Gbits/sec    0   1.92 MBytes       
>  [  5]   8.00-9.00   sec   798 MBytes  6.69 Gbits/sec    0   1.92 MBytes       
>  [  5]   9.00-10.00  sec   805 MBytes  6.75 Gbits/sec    0   1.92 MBytes       
>  - - - - - - - - - - - - - - - - - - - - - - - - -
>  [ ID] Interval           Transfer     Bitrate         Retr
>  [  5]   0.00-10.00  sec  8.15 GBytes  7.00 Gbits/sec    0             sender
>  [  5]   0.00-10.00  sec  8.15 GBytes  7.00 Gbits/sec                  receiver
> 
> Where ip addr shows:
> 
> 1: lo: <LOOPBACK,UP,LOWER_UP> ...
>     ...
> ...
> 8: enp65s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
>     ...
>     inet6 2011::12/64 scope global 
>        valid_lft forever preferred_lft forever
> ...
> 12: ip6tnl0@NONE: <NOARP,UP,LOWER_UP> mtu 1452 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/tunnel6 :: brd :: permaddr 1257:d9c1:e829::
>     inet6 fe80::1057:d9ff:fec1:e829/64 scope link proto kernel_ll 
>        valid_lft forever preferred_lft forever
> 13: ip6gre0@NONE: <NOARP,UP,LOWER_UP> mtu 1448 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/gre6 :: brd :: permaddr cab1:6316:aa70::
>     inet6 fe80::c8b1:63ff:fe16:aa70/64 scope link proto kernel_ll 
>        valid_lft forever preferred_lft forever
> 14: gre1@enp65s0f0np0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1448 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/gre6 2011::12 peer 2011::11 permaddr ded7:5b97:9098::
>     ...
>     inet6 2023::12/64 scope global 
>        valid_lft forever preferred_lft forever
>     ...
> 
> with 2023::11 being the other side of that GRE tunnel
> and ethtool -i enp65s0f0np0 shows that NIC uses ice driver.
> 
> Even though this commit fixes 04c20a9356f283da, the throughput is still
> 50 % of its original rate. This leads me to the following question: since
> the original commit affects throughput on NICs with the bnxt_en or ice
> drivers, is it possible that in
> 
> net/core/dev.c: skb_csum_hwoffload_help()
> 
> the check
> ...
> if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
>     skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
>     !ipv6_has_hopopt_jumbo(skb))
>         goto sw_checksum;
> ...
> should have another condition or flag before jumping to sw_checksum?
> Any insights would be greatly appreciated.

I would not know what.

Things might work before the blamed commit if the hardware is
capable of checksum offload with IPv6 extension headers. Even when
NETIF_F_IPV6 does not guarantee that and there is no more exact flag
that covers that scenario.

In which case the patch is correct, fixing checksum offload when
no segmentation offload is enabled. And your patch extends it to the
case where segmentation offload is also enabled.




