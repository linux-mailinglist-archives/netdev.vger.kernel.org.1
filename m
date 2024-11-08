Return-Path: <netdev+bounces-143315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46C9C1F96
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F21281A7F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982201EE02C;
	Fri,  8 Nov 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAtIeWz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821812E7E
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077223; cv=none; b=asmB8X21+1weLb+yeel6uEEZNGJ50b7ORcxCHnNHUq+DRcpiN0FsT4HWwceNisUdqI/aslWT7x769XRuV3zv65FH6EJAR/Il04W/9kuGDCNfhTkW5GUcLIMORDoBDzsyanoMYDJBfup4RXPtRL7ksQ/v0f5Gx+i70YAj83LNOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077223; c=relaxed/simple;
	bh=Zm0YJUb0gIY4IP7rhmEVzTtDx5We5PbhepTmvSV0FVM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p/buqBj4qXmeUVy2rwioQW7xppe3eUYG6wFbPVUgHZ8POmUNpNb4uIG0qXvFRp0bnxxPLKHjKZicQ76JlhZ3+N2xOm8VWD/Ip8U9oIEuIMO2gCGmS45fodmfj2pPTOdQ4fKzAFIfmsWv1cd2mJ9gppY3inaROyJn4OOjB5+QOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAtIeWz1; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15d7b7a32so155378385a.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 06:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731077221; x=1731682021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Nr6R7UmtfJ4G7u1h5RDSuMHF4ID8VTK3r8Bs1eJJGs=;
        b=VAtIeWz1iR2n5Z5nf7Q5FwNja5WszSIfrRSboS+1RBxYsoXRahHNEXc0/FM9gugg8u
         dS5M7SDFp/sx0UM2Ow8sXbE2nlQKrcC0ulH8M7RoeGW+vJos+GM1x3FUD9c89WGauFty
         ofjFelD4U2GHujEiVD2kwnsraFhx2LrMn4pJ1o0uky7dkqhG0+1bLffV1crFUrDuISjl
         fQ0M7wvRlH33buF/uS41saQBNqH83oOLPQaXSJwW59RKFuzMzwf6JdpejdgK4o0OvSLS
         tcypXoZ7392VEH/RXK3mFW0a7iQBqsqUozgT9krk+PSQ7PXq+ZOAfIi5oMeUoo14Hajo
         hziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731077221; x=1731682021;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Nr6R7UmtfJ4G7u1h5RDSuMHF4ID8VTK3r8Bs1eJJGs=;
        b=MfkcffjW20gsDS9QLAoi923oSbExzGdJykw3fT5+c3GtDKi9UhUxfvz19dZ3Ow1w7V
         E1w+H6NDopJsJ/Yi5FWZM0JfARNAhEHEaafH7ZcCQ0MfrfvC98aN0WTsaHn1wcMCQrLH
         HPyYEBKikzPCfcIFtoCAgTFy0bQQ94Q1v+jqEPeMQlb3xC5g4exIYrYVpHgtCEusMPcb
         EAvnAmY40BVZJzR/3et4kiTLq3pMXopbX3tnxEVNjVYkPwYOubpiKfTJLdP8m7YhFw3h
         uxnpdH0HS+EuJK7XF43xj+j2aMLtvHjO9n1LXSfF/SRTfcziZdM/VwxO6CnvtBcp1GZO
         FfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR7nDPDCBeCGPeqfu9l4HMmS43oA0xXARrcYes7cGSDT2LQrzUqUXJKp1j14aIe4QsudvvYwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAkWwigaSoMTGtSFil/6m3kPJcxHpPYMfcI8tTxvnrpUxwvoO
	TDheSCQ3RQvYDGrilxBS8CNiMwy3SWn/VUPPGoA54VNpo3FVx9vX
X-Google-Smtp-Source: AGHT+IEz2dtPdM0DoGdzKDno5oPJPuYQGhGpXmd2f57REp+yQDRjKH3Fdrwo1ynr1iWQsAK6MNfZEA==
X-Received: by 2002:a05:620a:2684:b0:7b1:45ac:86aa with SMTP id af79cd13be357-7b331f259a4mr320737085a.58.1731077220832;
        Fri, 08 Nov 2024 06:47:00 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acb30d0sm166320285a.94.2024.11.08.06.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 06:47:00 -0800 (PST)
Date: Fri, 08 Nov 2024 09:46:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 annaemesenyiri@gmail.com, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 Ido Schimmel <idosch@idosch.org>
Message-ID: <672e246394d26_2a4cd22945d@willemb.c.googlers.com.notmuch>
In-Reply-To: <672cf752e2014_1f26762945a@willemb.c.googlers.com.notmuch>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
 <20241107132231.9271-4-annaemesenyiri@gmail.com>
 <672cf752e2014_1f26762945a@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next v3 3/3] selftest: net: test SO_PRIORITY ancillary
 data with cmsg_sender
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Anna Emese Nyiri wrote:
> > Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> > ancillary data.
> > 
> > Add the `cmsg_so_priority.sh` script, which sets up two network  
> > namespaces (red and green) and uses the `cmsg_sender.c` program to  
> > send messages between them. The script sets packet priorities both  
> > via `setsockopt` and control messages (cmsg) and verifies whether  
> > packets are routed to the same queue based on priority settings.
> 
> qdisc. queue is a more generic term, generally referring to hw queues.
>  
> > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > ---
> >  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
> >  .../testing/selftests/net/cmsg_so_priority.sh | 115 ++++++++++++++++++
> >  2 files changed, 125 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh
>  
> > diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/testing/selftests/net/cmsg_so_priority.sh
> > new file mode 100755
> > index 000000000000..706d29b251e9
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> > @@ -0,0 +1,115 @@
> > +#!/bin/bash
> 
> SPDX header
> 
> > +
> > +source lib.sh
> > +
> > +IP4=192.168.0.2/16
> > +TGT4=192.168.0.3/16
> > +TGT4_NO_MASK=192.168.0.3
> > +IP6=2001:db8::2/64
> > +TGT6=2001:db8::3/64
> > +TGT6_NO_MASK=2001:db8::3
> > +IP4BR=192.168.0.1/16
> > +IP6BR=2001:db8::1/64
> > +PORT=8080
> > +DELAY=400000
> > +QUEUE_NUM=4
> > +
> > +
> > +cleanup() {
> > +    ip netns del red 2>/dev/null
> > +    ip netns del green 2>/dev/null
> > +    ip link del br0 2>/dev/null
> > +    ip link del vethcab0 2>/dev/null
> > +    ip link del vethcab1 2>/dev/null
> > +}
> > +
> > +trap cleanup EXIT
> > +
> > +priority_values=($(seq 0 $((QUEUE_NUM - 1))))
> > +
> > +queue_config=""
> > +for ((i=0; i<$QUEUE_NUM; i++)); do
> > +    queue_config+=" 1@$i"
> > +done
> > +
> > +map_config=$(seq 0 $((QUEUE_NUM - 1)) | tr '\n' ' ')
> > +
> > +ip netns add red
> > +ip netns add green
> > +ip link add br0 type bridge
> > +ip link set br0 up
> 
> Is this bridge needed? Can this just use a veth pair as is.
> 
> More importantly, it would be great if we can deduplicate this kind of
> setup boilerplate across similar tests as much as possible.

As a matter of fact, similar to cmsg_so_mark, this test can probably
use a dummy netdevice, no need for a second namespace and dev.

cmsg_so_mark.sh is probably small enough that it is fine to copy that
and create a duplicate. As trying to extend it to cover both tests
will probably double it in size and will just be harder to follow.

