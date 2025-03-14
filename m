Return-Path: <netdev+bounces-174966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D3A61AF8
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F0E42033A
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC02046B5;
	Fri, 14 Mar 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UvzerCY9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251015886C;
	Fri, 14 Mar 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981678; cv=none; b=gc2Thj5PqGl8VKfZJdtwHpE5eq2n94oz6FfiRIJxJ7NoXYqFy10yJnvK0AB16i3JKKdesrgHUGWbVm6OOGGHO/1JFE5/6FJvg7yewbdWeQnSKNZmIjEsEBigZ+UOQAUqCBcXt5Kx5ETxkFQWpdr2ZYVoswIIiuKADh0CdT6zwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981678; c=relaxed/simple;
	bh=e0CwORnXr4qlDZ4UPA0Jyl9ZuqiX4PNHCH37wQKEyzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE4SZYXqN3i39G72kKEZ3DnoIU/ek+yzf5ZlrNRqeaxQfxdpxjFeJYSf9gtIABe+g3cpGKXBH/Nrn8qN2BcR88q1pGU4M9Q0ddAklK8iOCFSmHsPBLtS5Eubqq8rpn1WRREeuFPqRj8YgmOgJHGQq0UgM2pkn8avtazdjQ8w25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UvzerCY9; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741981678; x=1773517678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m2mKGks0B6xSoyRCe2ik+5vMJ4EmQFjEvSLXFHmgLiM=;
  b=UvzerCY9NQcAw8lVR9FIhQcYjfC/cOiFgcATm5X2Bh/GO2rAk2/Z/UwC
   Z6HeQA82Zh5FliQopscQAMAqEDaO39PhU4LjJIG9fHcsSHpRRb70viZKP
   MiFHDXbVMp1DIOCc6MHVpFG6irFzC9Ko5So1RG/1ql5pc+UvTOCjHtEPE
   E=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; 
   d="scan'208";a="726905138"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 19:47:54 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:4676]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.235:2525] with esmtp (Farcaster)
 id ab966b34-71ec-46db-84fb-89cf4aea1a1e; Fri, 14 Mar 2025 19:47:53 +0000 (UTC)
X-Farcaster-Flow-ID: ab966b34-71ec-46db-84fb-89cf4aea1a1e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 19:47:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.227.109) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 19:47:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <annaemesenyiri@gmail.com>
CC: <aleksandr.mikhalitsyn@canonical.com>, <alexander@mihalicyn.com>,
	<edumazet@google.com>, <kerneljasonxing@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>, <willemb@google.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h with the kernel sources
Date: Fri, 14 Mar 2025 12:45:23 -0700
Message-ID: <20250314194742.32960-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAKm6_RsfA_Ygn4aZQdUxfBujxxgdB=PvgymChDtWSVHhhp6WZQ@mail.gmail.com>
References: <CAKm6_RsfA_Ygn4aZQdUxfBujxxgdB=PvgymChDtWSVHhhp6WZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Fri, 14 Mar 2025 14:31:34 +0100
> Alexander Mikhalitsyn <alexander@mihalicyn.com> ezt írta (időpont:
> 2025. márc. 10., H, 9:22):
> >
> > Am Mo., 10. März 2025 um 06:33 Uhr schrieb Jason Xing
> > <kerneljasonxing@gmail.com>:
> > >
> > > On Sun, Mar 9, 2025 at 1:15 PM Alexander Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > >
> > > > This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
> > > >
> > > > Accidentally found while working on another patchset.
> > > >
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: netdev@vger.kernel.org
> > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > > Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > > > Cc: Willem de Bruijn <willemb@google.com>
> > > > Cc: Jason Xing <kerneljasonxing@gmail.com>
> > > > Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > > > Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> > > > Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > >
> >
> > Hi Jason,
> >
> > Thanks for looking into this!
> >
> > > I'm not sure if it's a bug. As you may notice, in
> > > arch/parisc/include/uapi/asm/socket.h, it has its own management of
> > > definitions.
> > >
> > > I'm worried that since this file is uapi, is it allowed to adjust the
> > > number like this patch does if it's not a bug.

The uAPI number definions are different between arch, but strictly,
files under tools/ are not the source of truth.


> >
> > My understanding is that this file (tools/include/uapi/asm-generic/socket.h) is
> > a mirror copy of the actual UAPI file (uapi/asm-generic/socket.h),
> > and definitions need to be in sync with it.

Right.


> 
> I don’t completely understand this either—if the definitions need to
> be in sync, why is there a discrepancy?
> 
> Specifically, I am referring to the ones that caused the shift in
> numbering in uapi/asm-generic/socket.h:
> #define SO_DEVMEM_LINEAR 78
> #define SCM_DEVMEM_LINEAR SO_DEVMEM_LINEAR
> #define SO_DEVMEM_DMABUF 79
> #define SCM_DEVMEM_DMABUF SO_DEVMEM_DMABUF
> #define SO_DEVMEM_DONTNEED 80
> 
> In the case of SO_RCVPRIORITY, I simply continued the numbering
> sequence as it was

This should've followed include/uapi/asm-generic/socket.h.

Otherwise, a program compiled with tools/include/uapi/asm-generic/socket.h
does not work on kernel compiled with include/uapi/asm-generic/socket.h,
and the prog will invoke syscall with an unintentional number.

So, tools/include/uapi must be synced with include/uapi and fixing
up wrong definitions under tools/include/uapi is totally fine, and
this does not cause uAPI breakage, rather it's been broken.

