Return-Path: <netdev+bounces-88887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A68A8EF4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 00:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB091C20B76
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A547E58F;
	Wed, 17 Apr 2024 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2xfxFNB"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A81F8004A
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394151; cv=none; b=DJFiflQQleWRbLKqN4USFfx0rDFEEwrOCEZNt2XzutdwMNT1IlGMVgoh5//a7R/dBEjpIkvBkiROO0jpaHp6hE+DzZMHNRhF/Pvf7u2sG4YubSt/yOuAUVXCBMmdarW+f777rJDEhEx/kkriBPzETXGlUq0GQWgHb3KRcAb27iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394151; c=relaxed/simple;
	bh=CU4SUV/tAacMmxINxQPyDkH06nmMCSP9U+W+vrpSaZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWTB650Qwu37878aWWR8rDSnP7EXXLcZ8tpJZhdMfKooOrl+aHyyMbctfXrnioJWbjf908EovxnV9v+2f+3x8eoUfThAS80MKsgLJp4ORGAxr7w10m4lIMrqNEPO12R+Dvq6FeN64s/mcdVv0DFhDBQCtrdUhMQxEXcbphDNDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2xfxFNB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <152f00e2-8f60-4f39-8ab4-fdab1b0bc01a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713394147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bucH0Erc8Q5A/z6/UWqfD8pwxfQz7cToeD3wwtpAcrs=;
	b=q2xfxFNBtP+SY+acb0XsxDrmxuCY0OM2oDFFE/GMBRJSPLecC/31LRN7DugtTKRsHDkZS4
	zTNAH9Bq0M4B02DbZ7GqNePYzZ6HnnRyjyqw35nOHH4uPVyYIMKaebB8L+fpaHPMj1wQ51
	9uoh8Bbgg1qcH9jcJv7TU9oF7pctXlM=
Date: Wed, 17 Apr 2024 15:48:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: add sacked flag in BPF_SOCK_OPS_RETRANS_CB
To: Eric Dumazet <edumazet@google.com>, Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 laoar.shao@gmail.com, xuanzhuo@linux.alibaba.com, fred.cc@alibaba-inc.com
References: <20240417124622.35333-1-lulie@linux.alibaba.com>
 <CANn89iLWMhAOq0R7N3utrXdro_zTmp=9cs8a7_eviNcTK-_5+w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CANn89iLWMhAOq0R7N3utrXdro_zTmp=9cs8a7_eviNcTK-_5+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/17/24 6:11 AM, Eric Dumazet wrote:
> On Wed, Apr 17, 2024 at 2:46 PM Philo Lu <lulie@linux.alibaba.com> wrote:
>>
>> Add TCP_SKB_CB(skb)->sacked as the 4th arg of sockops passed to bpf
>> program. Then we can get the retransmission efficiency by counting skbs
>> w/ and w/o TCPCB_EVER_RETRANS mark. And for this purpose, sacked
>> updating is moved after the BPF_SOCK_OPS_RETRANS_CB hook.
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> 
> This might be a naive question, but how the bpf program know what is the meaning
> of each bit ?
> 
> Are they exposed already, and how future changes in TCP stack could
> break old bpf programs ?
> 
> #define TCPCB_SACKED_ACKED 0x01 /* SKB ACK'd by a SACK block */
> #define TCPCB_SACKED_RETRANS 0x02 /* SKB retransmitted */
> #define TCPCB_LOST 0x04 /* SKB is lost */
> #define TCPCB_TAGBITS 0x07 /* All tag bits */
> #define TCPCB_REPAIRED 0x10 /* SKB repaired (no skb_mstamp_ns) */
> #define TCPCB_EVER_RETRANS 0x80 /* Ever retransmitted frame */
> #define TCPCB_RETRANS (TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
> TCPCB_REPAIRED)

I think it is the best to use the trace_tcp_retransmit_skb() tracepoint instead.

iiuc the use case, moving the "TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;" 
after the tracepoint should have similar effect.

If the TCPCB_* is moved to a enum, it will be included in the "vmlinux.h" that 
the bpf prog can use and no need to expose them in uapi.


