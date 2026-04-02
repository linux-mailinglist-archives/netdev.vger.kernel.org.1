Return-Path: <netdev+bounces-274429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCrjJ1ErzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:39:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A74083862D6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9C243002D24
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0A63B3884;
	Thu,  2 Apr 2026 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NIBJCsI/"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AE39B962
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119140; cv=none; b=fbPsOEK8cuuSkS/dgnpS6PUpP7RII9l1VlWFUOFGNPb6/dj7b6ZKBu33Gulj7DgFlhKtf+IdVyA6gzgTNcv0dk9rb6TNiAdeSyHDQ3MsyESNuWCkbQ78FyALpLza6FdJwVdpGVPnx9HrNmeJ0qECnZL8rxNaolzB+cIk88ypgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119140; c=relaxed/simple;
	bh=ZsZA9LlXyJ1D27ScN89sB+DLKYnxPqwULA/8jPshz8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0MqaOqlEq8AMoTiLPgXyOTmR2C9JNeA8uSkbokkgvTmL5C7EGnBMXbs4Qfou6SePZippbxv216d4ygxdDDjh40g/4pEuU3XXGoIMnl3MkoHaYpGRvBiY8JaX3TNrzGzHkB5DvlJDir/0HpkG3vZ4fC+EyUefrXlrfMAvUOHBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NIBJCsI/; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f4e3b36-3e9e-4db5-9423-cbf4174e30d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775119127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsZA9LlXyJ1D27ScN89sB+DLKYnxPqwULA/8jPshz8w=;
	b=NIBJCsI/7L25b0KJcba+yOyuuGXK5VaryBSgt3XewtOCrcv8EGGfJUTadJUmauXHs9NDPC
	BcXm+X//DwsO+mvo87Jxw7Pqz4Jl5o1jwvc6QfAHADkCpFN45h3pe182mA/Km/CgE+EhzK
	1pHD230q7Xz5RjqpKSvCBjid8jj/99A=
Date: Thu, 2 Apr 2026 16:38:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>,
 Mina Almasry <almasrymina@google.com>, Eric Biggers <ebiggers@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Soheil Hassas Yeganeh <soheil@google.com>,
 Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260402033138.388574-1-jiayuan.chen@linux.dev>
 <CANn89iLdRZd-qO4tRpSGamHpggh=r5vM4xes5npYCnkwcNG89A@mail.gmail.com>
 <ad90b2a9-0f67-4796-94bc-9dbb76a575af@linux.dev>
 <CANn89iLLwk9G6K8r=hOxsQQ2AsW751E+2pOoud9c-R+R-3i6hg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iLLwk9G6K8r=hOxsQQ2AsW751E+2pOoud9c-R+R-3i6hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274429-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bluedragonsec.com,davemloft.net,kernel.org,redhat.com,gmail.com,google.com,rbox.co,fb.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: A74083862D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/2/26 4:03 PM, Eric Dumazet wrote:
> On Wed, Apr 1, 2026 at 9:15 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> If we no longer care about the cost of accessing a struct page in the
>> free path, which the original commit was trying to avoid, this is
>> indeed the simplest fix — kfree() correctly handles objects via
>> virt_to_slab.
> We only have SLUB in modern kernels, kmem_cache_free() needs to touch it.
>
> Using is_kfence_address() in net/core/skbuff.c is pushing too hard in
> my opinion.
Thanks, I understand.

