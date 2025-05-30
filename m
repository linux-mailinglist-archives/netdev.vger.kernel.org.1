Return-Path: <netdev+bounces-194419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD754AC95E2
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5061C214DF
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E97D27702A;
	Fri, 30 May 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2ytXwcq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF69143736;
	Fri, 30 May 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748631602; cv=none; b=lCc5cxnQ9cJz2/WB0fzwwnHayy51CoDn3pHZxcO8Z7jtFF0AZKPlbKSX6s9eyQqo09axK8CT8x67nBOgli7q4dxXL39mItB5PUmhWiCV+ZewTUG93N5WTpBs8K0Nl/ir0Q4V6AnzwvGIjTse4Vccvwi1/ooLyYL9/b3NUSHrHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748631602; c=relaxed/simple;
	bh=R/1ttUhwWL20tO3Oj72nIul8lSsN8Vi4gj6eFjy4uvk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VWN7Cf+cLlc65i28LEuC+X+gGmInwCe6J+YXIR4xqPW7zSkYuy+n9tO2YHYfkZleWU0s7rcICjH86KyS4ufFVHx5g1s6Ts/Scz/WtMfK+l+QcKWULYz2UoVTxwBbE0mUnU0SiQX18yzErWK9zkzK8fCn12e9xTQziCctsazGag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2ytXwcq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f0ad74483fso24461356d6.1;
        Fri, 30 May 2025 12:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748631599; x=1749236399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlSkcnxW3G6p+It/B2UidZpyAR61Usu9SZ3iGbjjQoo=;
        b=U2ytXwcqz7iPQjluGDB7eizWTatHauLU5BGvGegwzIrp0QvN6Lyqrns7ClW52y1wqr
         U288xA3nPjcb8NwWnU/zn+MB9hQoo6ZmpoQYTnGq8eT4ZCcca3NCQPU7awMHYxHwer2a
         BZs8R3CLBb9W+wnziHLwbwDN7uH8V5Uzq2KMiqwt1E4XB2iPIGTyyeuv3NPeyXh1e2si
         bEtNuJR3JeHcwaXIVKwrkqcD1LYISP3YZAo6QpbfheXkInU4BtxKElzpjG5bl2OtOjLG
         Yze6iL2wygrCHeUwbLk3xF3dL3gjSrCzDSaI6r88GPcg0kOTosDtrTeOX1Lb9eL7aPOl
         jK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748631599; x=1749236399;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VlSkcnxW3G6p+It/B2UidZpyAR61Usu9SZ3iGbjjQoo=;
        b=d9bWqsQxUbhjryUB2OcaN79S0RSxsnTijo+WJiG9MbhrvW0j8MXmCMuSyIiiGw2yBf
         Ae4UQ+VSv3tDMG923+g3M0lBhHkgHfJoTZe9fz0N6WvDp2DTcl0F/hC2RJdGascs+kF6
         GVOeu/RpwFxD9hPsS6rkXDhO5wBOGFu8BLrUvQ4x0D8zsf9txjF6mTldXqByRwkVC3/D
         zEVRFyvPu2PtAJEaYMMUX0W/ACgtaCHuFj26J5YA6htHd3uWHL6wWZiK99xK544pOJ7a
         X02GmSeDfkUSCYOGXgSvHGah/0x3HfZf/pKGsdo3qIeThj9FhNzERTjkiFBNWDDDmGZS
         F/cg==
X-Forwarded-Encrypted: i=1; AJvYcCUPfH+qdPKCTHo29pFYeukWdXTNSybWI0fGeFkTiK20E8ap5NFeHPYhUwO9WQ8wUHQgXpi6roe3UAD7tOo=@vger.kernel.org, AJvYcCWFK6Ma14GaQppdT+cOXl2sw1lG0+KWnOnfPxEeom1iHr49VuD3RTGy04PCJxqxAsYHStuu7UJ7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu/s/9ml4m8DCYDTD0IlKY4/oqYEu2q1frS2kvMyoT9O3OIdOF
	B2TL0QyeRlraZJ3NYKE1giSF/hnULOae92kAqeiixIzbDTGBmStQ+4Hq
X-Gm-Gg: ASbGnctmvaTjr7H9I6qXomiIcr2xYaCouKFViRxNNthkXtraKgkJqf42hG1ycVe1XSX
	pDaQjMa6sfIrlxm+Zgzfvi86utbbKS8JVFBzvCFBNlkMYEbpJoF8baBxNMkQ8PyH/oP1kCGehy6
	pEqHPoOOdfR0u3ilHdIp4apykv3rUYPNUlLQb4CQ3n0bvBTlYPTDtMl3+6VZxOT+3ZTWWMpVS0t
	8cE+epmIAtb836hmPy49bZ6NACLH1HS0zw2lq0qnOyoKyJw4xWkdBAr0oOwO3mEpN08uHKz+Xx6
	QUvP5TTkGL8EpvpveMe+T/HnsM5J+b9FLz5eJyMin/BU0nt8rSLKsb5xW2WCteNZPrVA66OYwZk
	KvI0MhAlJpT+Q4ejSpy6Rvpw=
X-Google-Smtp-Source: AGHT+IFx8IyTKo5TZ833fVfIeZTnexMvd1NFwxQvRRS1nv0eUFRm+lGvfllz96odl8pQhvtQnBlihg==
X-Received: by 2002:a05:6214:d02:b0:6fa:c5be:dac7 with SMTP id 6a1803df08f44-6facebcf4bdmr90062106d6.18.1748631599419;
        Fri, 30 May 2025 11:59:59 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fac6d5b144sm27523856d6.55.2025.05.30.11.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 11:59:58 -0700 (PDT)
Date: Fri, 30 May 2025 14:59:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Shiming Cheng <shiming.cheng@mediatek.com>, 
 willemb@google.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 lena.wang@mediatek.com
Message-ID: <683a002e73efd_14767f294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250530183706.GV1484967@horms.kernel.org>
References: <20250530012622.7888-1-shiming.cheng@mediatek.com>
 <6839a707f1b14_1003de2943b@willemb.c.googlers.com.notmuch>
 <20250530183706.GV1484967@horms.kernel.org>
Subject: Re: [PATCH net v6] net: fix udp gso skb_segment after pull from
 frag_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Horman wrote:
> On Fri, May 30, 2025 at 08:39:35AM -0400, Willem de Bruijn wrote:
> > Shiming Cheng wrote:
> > > Commit a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after
> > > pull from frag_list") detected invalid geometry in frag_list skbs and
> > > redirects them from skb_segment_list to more robust skb_segment. But some
> > > packets with modified geometry can also hit bugs in that code. We don't
> > > know how many such cases exist. Addressing each one by one also requires
> > > touching the complex skb_segment code, which risks introducing bugs for
> > > other types of skbs. Instead, linearize all these packets that fail the
> > > basic invariants on gso fraglist skbs. That is more robust.
> > > 
> > > If only part of the fraglist payload is pulled into head_skb, it will
> > > always cause exception when splitting skbs by skb_segment. For detailed
> > > call stack information, see below.
> > > 
> > > Valid SKB_GSO_FRAGLIST skbs
> > > - consist of two or more segments
> > > - the head_skb holds the protocol headers plus first gso_size
> > > - one or more frag_list skbs hold exactly one segment
> > > - all but the last must be gso_size
> > > 
> > > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> > > modify fraglist skbs, breaking these invariants.
> > > 
> > > In extreme cases they pull one part of data into skb linear. For UDP,
> > > this  causes three payloads with lengths of (11,11,10) bytes were
> > > pulled tail to become (12,10,10) bytes.
> > > 
> > > The skbs no longer meets the above SKB_GSO_FRAGLIST conditions because
> > > payload was pulled into head_skb, it needs to be linearized before pass
> > > to regular skb_segment.
> > > 
> > >     skb_segment+0xcd0/0xd14
> > >     __udp_gso_segment+0x334/0x5f4
> > >     udp4_ufo_fragment+0x118/0x15c
> > >     inet_gso_segment+0x164/0x338
> > >     skb_mac_gso_segment+0xc4/0x13c
> > >     __skb_gso_segment+0xc4/0x124
> > >     validate_xmit_skb+0x9c/0x2c0
> > >     validate_xmit_skb_list+0x4c/0x80
> > >     sch_direct_xmit+0x70/0x404
> > >     __dev_queue_xmit+0x64c/0xe5c
> > >     neigh_resolve_output+0x178/0x1c4
> > >     ip_finish_output2+0x37c/0x47c
> > >     __ip_finish_output+0x194/0x240
> > >     ip_finish_output+0x20/0xf4
> > >     ip_output+0x100/0x1a0
> > >     NF_HOOK+0xc4/0x16c
> > >     ip_forward+0x314/0x32c
> > >     ip_rcv+0x90/0x118
> > >     __netif_receive_skb+0x74/0x124
> > >     process_backlog+0xe8/0x1a4
> > >     __napi_poll+0x5c/0x1f8
> > >     net_rx_action+0x154/0x314
> > >     handle_softirqs+0x154/0x4b8
> > > 
> > >     [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at net/core/skbuff.c:4278!
> > >     [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > >     [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
> > >     [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
> > >     [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
> > >     [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
> > >     [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
> > >     [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp : ffffffc008013770
> > > 
> > > Fixes: a1e40ac5b5e9 ("gso: fix udp gso fraglist segmentation after pull from frag_list")
> > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> > 
> > Is this effectively a repost of v5?
> > 
> > I think Simon suggested changing the subject line from starting with
> > "net:" to starting with "gso:", but this revision does not make such
> > a change.
> 
> FTR, my suggestion was to correct the subject embedded in the Fixes tag.
> And that appears to be addressed in this revision (v6).

Oh, your comment was on the Fixes tag. I misunderstood. Good catch, thanks.


