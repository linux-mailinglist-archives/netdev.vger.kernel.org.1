Return-Path: <netdev+bounces-217740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40BB39A93
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D391BA2E33
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EA8266581;
	Thu, 28 Aug 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PefCaikX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D4EEA6
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377995; cv=none; b=V8KlalU6qJbuVw3h9mxuszFPk7Eop0kXDTXC1Fo1pGxD8wE+wPRLTG0nVDPH5yNe5v6ztfCxI1qiMmyUdVKN8jDUbP7y6sp13YJzvVHRO0+w7xwUbwDVHyIbt1U+QQRiIbh1Bi0O7FEKsF3NWIU0yifzNC4OAmpbP7y6tM+K+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377995; c=relaxed/simple;
	bh=6TQUX0foPoMnCixlgsFdXrAtS7w/nwXNgJL1sCJB4zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIZhRrmUBvyiuE6uPkqcPzSQX70MxnCR2ALOSqPdMXTdEZc+PGiVh/dj4ori+Z3djVmexxyOAg/6hSUuM9qMvxiY1muXEpAYihfEgbmiygB5RV8iIkKAoEUAsHgRLN1Q3UGR/IcRz5dtjGz/6+JPrqHp9wyRnw1gGKfMeaROG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PefCaikX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756377991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LSG0JxESefWqU6BHUXedZPmf/7usuTnrCA7l5i15Sc=;
	b=PefCaikXMyeSWYPgy6C7iq7TVs2tPRa5tr6s7kcB7etaSil0uv7vdxt0ZiEzgccrE5PQrw
	+ehQ8hWurfG/9mOIxUGEJo0IbwZnPRJVTRElJW+9YFzOqUp7RFL8S77O3dWjzMZMPk1pBz
	YYnMfoCDp4ao+ratyL90R9s851I6xfs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-SBFw07qeNvi_UT627BL_NQ-1; Thu, 28 Aug 2025 06:46:30 -0400
X-MC-Unique: SBFw07qeNvi_UT627BL_NQ-1
X-Mimecast-MFC-AGG-ID: SBFw07qeNvi_UT627BL_NQ_1756377990
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7fa717ff667so89998085a.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377990; x=1756982790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LSG0JxESefWqU6BHUXedZPmf/7usuTnrCA7l5i15Sc=;
        b=sWvxfFWDMWbZo/PboiD6BmR76OKkR+tS/nUMYRHJIOF3J+vl/MP8/5NOSF4KO4Lk2D
         A9CISgNXWjyxMk4G0WVzxEje+abZEHb+GaUuphEN382dq3ue6acH8OYcHmM5bupfKMI7
         9g7iF+Uj8XJexMrPgDpL+FtH3DC6roQp1IHcbgxlZEbUs86tCVeLQYlA+9TNBSK9pHJz
         0IWj/8AaA41E5FPyJJfzsa+Ulo99sVczhXNiFkXrnIndOOW2e+sQda/ZzZUsb/FS2UZk
         T/Fzho6rriQsVDtZAluMNeq9tT+h3/Z7zW9c/nNSmjyVghun4uPf0nHoxRPTBvdhC36h
         lNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfjKaIAHf1woE9fs6vsLWFPy6Rul/YT2NgMx6bQMpKUW9CM0M1gF2qOuCfCrb1mjFjAIaLJYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUrbcmpx2DYXu/qGq6WVAUYkp4l/mQJxKX8jzS0nhtKl2qRpW
	cSMt6kBAAlK0POrlKMoh7Es3LQFbojNfrUnKx/RLvanG4rAwNneqSfq87FhL2vf/ahZttSRVUhh
	f1fG4bXjTy9kE0TsnQtLv52uLSQve3YTofkCmR3x3Sj/QEym3cgrN3ccofw==
X-Gm-Gg: ASbGnct07ayaHRsUaf+qC8FTkLjV2XWK9INFfonWyHEABdFuER6seJAUdTeHf2gzlX5
	1ZL4q1hpp3en111honAth5cnklHa6ei3OFUFQaK1UAVo+XLRfl+0THsqSBGPDDPFJvNcS77Z30u
	GciEK3VUNYfBr052mGXAr4NP8qFP7PdJaY4eloBghYnXD7yDOfdCQWf5JodMzd1cK4uHNFKZoE8
	BJ/4yfgEh3UoxzyBC7XWfXvpwlKPQj8JdXRqUBFn83W6SaizAFVw24vuOwCCIuxLofKAgdidV9r
	G6vI/DsySrn73rKaROiS2TUoOvJ0ffxV+7RHSNa323sRYFmrNqSEDkVsjrnl/gyJqkfXyY1NzOi
	a6IC7hDLUhNw=
X-Received: by 2002:a05:620a:46a9:b0:7f1:df7b:f058 with SMTP id af79cd13be357-7f1df7c0119mr1577448785a.16.1756377990024;
        Thu, 28 Aug 2025 03:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOrT0pooan9nSnIgyyuJ0FusRKeeycB/6xWy6gMnEgMtNrqvORe6KG+x6zWdCmM9gExmEXTg==
X-Received: by 2002:a05:620a:46a9:b0:7f1:df7b:f058 with SMTP id af79cd13be357-7f1df7c0119mr1577445785a.16.1756377989602;
        Thu, 28 Aug 2025 03:46:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7f0929c268asm804449685a.35.2025.08.28.03.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:46:29 -0700 (PDT)
Message-ID: <bc846535-a5f5-4e24-9325-22f9d8b887f9@redhat.com>
Date: Thu, 28 Aug 2025 12:46:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 0/4] fbnic: Synchronize address handling with BMC
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 davem@davemloft.net
References: <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 9:44 PM, Alexander Duyck wrote:
> The fbnic driver needs to communicate with the BMC if it is operating on
> the RMII-based transport (RBT) of the same port the host is on. To enable
> this we need to add rules that will route BMC traffic to the RBT/BMC and
> the BMC and firmware need to configure rules on the RBT side of the
> interface to route traffic from the BMC to the host instead of the MAC.
> 
> To enable that this patch set addresses two issues. First it will cause the
> TCAM to be reconfigured in the event that the BMC was not previously
> present when the driver was loaded, but the FW sends a notification that
> the FW capabilities have changed and a BMC w/ various MAC addresses is now
> present. Second it adds support for sending a message to the firmware so
> that if the host adds additional MAC addresses the FW can be made aware and
> route traffic for those addresses from the RBT to the host instead of the
> MAC.

The CI is observing a few possible leaks on top of this series:

unreferenced object 0xffff888011146040 (size 216):
  comm "napi/enp1s0-0", pid 4116, jiffies 4295559830
  hex dump (first 32 bytes):
    c0 bc a0 08 80 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 40 02 08 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
  backtrace (crc d10d3409):
    kmem_cache_alloc_bulk_noprof+0x115/0x160
    napi_skb_cache_get+0x423/0x750
    napi_build_skb+0x19/0x210
    xdp_build_skb_from_buff+0xda/0x820
    fbnic_run_xdp+0x36c/0x550
    fbnic_clean_rcq+0x540/0x1790
    fbnic_poll+0x142/0x290
    __napi_poll.constprop.0+0x9f/0x460
    napi_threaded_poll_loop+0x44d/0x610
    napi_threaded_poll+0x17/0x30
    kthread+0x37b/0x5f0
    ret_from_fork+0x240/0x320
    ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888008a0bcc0 (size 216):
  comm "napi/enp1s0-0", pid 4116, jiffies 4295560865
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 40 02 08 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
  backtrace (crc d69e2bd9):
    kmem_cache_alloc_node_noprof+0x289/0x330
    __alloc_skb+0x20f/0x2e0
    __tcp_send_ack.part.0+0x68/0x6b0
    tcp_rcv_established+0x69c/0x2340
    tcp_v6_do_rcv+0x9b4/0x1370
    tcp_v6_rcv+0x1bc5/0x2f90
    ip6_protocol_deliver_rcu+0x112/0x1140
    ip6_input+0x201/0x5e0
    ip6_sublist_rcv_finish+0x91/0x260
    ip6_list_rcv_finish.constprop.0+0x55b/0xa10
    ipv6_list_rcv+0x318/0x4b0
    __netif_receive_skb_list_core+0x4c6/0x980
    netif_receive_skb_list_internal+0x63c/0xe50
    gro_complete.constprop.0+0x54d/0x750
    __gro_flush+0x14a/0x490
    __napi_poll.constprop.0+0x319/0x460

But AFAICS they don't look related to the changes in this series, even
if I'm not able to spot real suspects in the changes tested in the
relevant batch:

https://netdev.bots.linux.dev/static/nipa/branch_deltas/net-next-hw-2025-08-28--08-00.html

Some feeling towards the RPS patches, but they look safe to me.

/P


