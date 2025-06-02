Return-Path: <netdev+bounces-194570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC67ACAB59
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3903BC06B
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B161DF75C;
	Mon,  2 Jun 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LPUN2xMY"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00330BE6C
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748856479; cv=none; b=nCSQn3a8FSXbePhC47XStSoWZow9EBM52NS8M/+9lq4xPIxCEyfgZf9I0lFxRY/MCJ0BnEzaTwZn0iMcP2qLcl6QxZobWJpsTMZVEfyxdTrFAW6pOqEEVjAi0rc805i2kVZ6+JVc+VLCkeinmaBjX/SR1sgrbjDIGPnmDe0DquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748856479; c=relaxed/simple;
	bh=/uRonHDMgAb0wFA9zPFFRECao/tvSKnkaJBJMuh/T+0=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=ULA1ZQN/N8ffkO54Rc11u8pM0bPZwJlexStwXmhDHBfTueFg+e/NZ/NWT6mxFKZtmY+9M0Fm+KTLrl68HcSdXzucEt4G2CTmCG8kYLt4MsftBo2YZc9QiVTzBVhRrjwrN51pxYxTidvdfsX1hg3XkErD9I9beQptCn9edpnSRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LPUN2xMY; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250602092754euoutp01e64573957f793cb9eec37768a0b20e5f~FL7K6opVf0793807938euoutp01H
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 09:27:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250602092754euoutp01e64573957f793cb9eec37768a0b20e5f~FL7K6opVf0793807938euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748856475;
	bh=ori1WjGvSN+iMz/nFdzMcGCHXG5z5JaYTLC/dZ9ojao=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=LPUN2xMYDz9QC76uehJ3cR4u7RMeRsByhJQbONHsKkF7mCeTnn32z57L7jbt/rTxU
	 Entdr6W/XhhXPfv9PcnyHH34Jc3lFf8jhSDq56UB/FoLex73Tf89aMY40DOdHLDPy6
	 irwyRVhJfUUppx7hCy5U9Nq1IlBIWTgGyYn54cLM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Reply-To: e.kubanski@partner.samsung.com
Sender: Eryk Kubanski <e.kubanski@partner.samsung.com>
From: Eryk Kubanski <e.kubanski@partner.samsung.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>, "magnus.karlsson@intel.com"
	<magnus.karlsson@intel.com>, "maciej.fijalkowski@intel.com"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <aDnX3FVPZ3AIZDGg@mini-arch>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
Date: Mon, 02 Jun 2025 11:27:54 +0200
X-CMS-MailID: 20250602092754eucms1p1b99e467d1483531491c5b43b23495e14
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
X-EPHeader: Mail
X-ConfirmMail: N,general
X-CMS-RootMailID: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
References: <aDnX3FVPZ3AIZDGg@mini-arch>
	<20250530103456.53564-1-e.kubanski@partner.samsung.com>
	<CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p1>

> I'm not sure I understand what's the issue here. If you're using the
> same XSK from different CPUs, you should take care of the ordering
> yourself on the userspace side?

It's not a problem with user-space Completion Queue READER side.
Im talking exclusively about kernel-space Completion Queue WRITE side.

This problem can occur when multiple sockets are bound to the same
umem, device, queue id. In this situation Completion Queue is shared.
This means it can be accessed by multiple threads on kernel-side.
Any use is indeed protected by spinlock, however any write sequence
(Acquire write slot as writer, write to slot, submit write slot to reader)
isn't atomic in any way and it's possible to submit not-yet-sent packet
descriptors back to user-space as TX completed.

Up untill now, all write-back operations had two phases, each phase
locks the spinlock and unlocks it:
1) Acquire slot + Write descriptor (increase cached-writer by N + write values)
2) Submit slot to the reader (increase writer by N)

Slot submission was solely based on the timing. Let's consider situation,
where two different threads issue a syscall for two different AF_XDP sockets
that are bound to the same umem, dev, queue-id.

AF_XDP setup:
                                                            
                             kernel-space                   
                                                            
           Write   Read                                     
            +--+   +--+                                     
            |  |   |  |                                     
            |  |   |  |                                     
            |  |   |  |                                     
 Completion |  |   |  | Fill                                
 Queue      |  |   |  | Queue                               
            |  |   |  |                                     
            |  |   |  |                                     
            |  |   |  |                                     
            |  |   |  |                                     
            +--+   +--+                                     
            Read   Write                                    
                             user-space                     
                                                            
                                                            
   +--------+         +--------+                            
   | AF_XDP |         | AF_XDP |                            
   +--------+         +--------+                            
                                                            
                                                            
                                                            
                                                            

Possible out-of-order scenario:
                                                                                                                                       
                                                                                                                                       
                              writer         cached_writer1                      cached_writer2                                        
                                 |                 |                                   |                                               
                                 |                 |                                   |                                               
                                 |                 |                                   |                                               
                                 |                 |                                   |                                               
                  +--------------|--------|--------|--------|--------|--------|--------|----------------------------------------------+
                  |              |        |        |        |        |        |        |                                              |
 Completion Queue |              |        |        |        |        |        |        |                                              |
                  |              |        |        |        |        |        |        |                                              |
                  +--------------|--------|--------|--------|--------|--------|--------|----------------------------------------------+
                                 |                 |                                   |                                               
                                 |                 |                                   |                                               
                                 |-----------------|                                   |                                               
                                  A) T1 syscall    |                                   |                                               
                                  writes 2         |                                   |                                               
                                  descriptors      |-----------------------------------|                                               
                                                    B) T2 syscall writes 4 descriptors                                                 
                                                                                                                                       
                                                                                                                                       
                                                                                                                                       
                                                                                                                                       
                 Notes:                                                                                                                
                 1) T1 and T2 AF_XDP sockets are two different sockets,                                                                
                    __xsk_generic_xmit will obtain two different mutexes.                                                              
                 2) T1 and T2 can be executed simultaneously, there is no                                                              
                    critical section whatsoever between them.                                                                          
                 3) T1 and T2 will obtain Completion Queue Lock for acquire + write,                                                   
                    only slot acquire + write are under lock.                                                                          
                 4) T1 and T2 completion (skb destructor)                                                                              
                    doesn't need to be the same order as A) and B).                                                                    
                 5) What if T1 fails after T2 acquires slots?                                                                          
                    cached_writer will be decreased by 2, T2 will                                                                      
                    submit failed descriptors of T1 (they shall be
                    retransmitted in next TX).                                                                                   
                    Submission of writer will move writer by 4 slots                                                                   
                    2 of these slots have failed T1 values. Last two
                    slots of T2 will be missing, descriptor leak.                                                                            
                 6) What if T2 completes before T1? writer will be                                                                     
                    moved by 4 slots. 2 of them are slots filled by T1.                                                                
                    T2 will complete 2 own slots and 2 slots of T1, It's bad.                                                          
                    T1 will complete last 2 slots of T2, also bad.                                                                     

This out-of-order completion can effectively cause User-space <-> Kernel-space
data race. This patch solves that, by only acquiring cached_writer first and
do the completion (sumission (write + increase writer)) after. This is the only
way to make that bulletproof for multithreaded access, failures and
out-of-order skb completions.

> This is definitely a no-go (sk_buff and skb_shared_info space is
> precious).

Okay so where should I store It? Can you give me some advice?

I left that there, because there is every information related to
skb desctruction. Additionally this is the only place in skb related
code that defines anything related to xsk: metadata, number of descriptors.
SKBUFF doesn't. I need to hold this information somewhere, and skbuff or
skb_shared_info are the only place I can store it. This need to be invariant
across all skb fragments, and be released after skb completes.

