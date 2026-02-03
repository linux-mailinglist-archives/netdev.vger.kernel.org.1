Return-Path: <netdev+bounces-256112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPvjEkxxgWl9GQMAu9opvQ
	(envelope-from <netdev+bounces-256112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:53:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F69D43AD
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5D0C3007899
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79A730EF69;
	Tue,  3 Feb 2026 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/UIDVMu"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEF2773D3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770090822; cv=none; b=Mtle2R9K8ddyXkO+nMKunU8emlEBYUe2xpBjIr7jdKInW/iZ4M8DV/ZnPV3RgDkPFJnwJo6ILlMD/usVciOm0FHo7PJJ4ouZBFWGJo+UaIO2F0VPeFyTs8arZDwk3WbSXtgBLfjg5tsjCfIZoO5LlZbj9EEMnrT1/ilCQNzty2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770090822; c=relaxed/simple;
	bh=/QdirBqH01e+R56tuG0CRglKlnNLc2IU1d3Qfjfv9nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lq2U8FKOsj1TrbHikE1kuB0O0aZipjSr7F7BJdrkicpo/PHQVr1FwiCsLA/3cuIqSiZoMvy/skZp2w1dPNlsd5O4+AxeV0GH3tzU85OGN2X65rUVNgh6S4jJ/4NaOFkS/WCuL+rBbBnnZUJX+8gxMbbgcObYNyAxIcdofQK7NbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/UIDVMu; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6de6f1bf-c8ee-4dfb-9b8c-f89185946630@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770090809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEfhLzilj+zuoWEbJFfe5YutaKh7xj1E7i6hGBHvYBg=;
	b=P/UIDVMukq1agKL/sg/WgshpY1NyVrVhwlaDyeUWNC+PxjScKbj1Y4+SNl6fWmsCktaKc0
	jUlftRPXxl/MkkrPlCxlsZsimoHPjzgvIHhj/eA9AyKo7lDEQJKGPV2dgfQ8IfptWRrg30
	YU+pYjlefRbic0gxVjFivjK9oua0Opk=
Date: Mon, 2 Feb 2026 19:53:20 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
 <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev>
 <3362017f-9c3d-46cd-b3ce-cb750b565d5b@rbox.co>
 <612a9446-252f-4b14-8605-ae1af000cc41@linux.dev>
 <CAAVpQUAc3S+Ebx2qp-Pbg9qH-Zc=yHdzVJbchCu++V_4XF3DLg@mail.gmail.com>
 <b98a40e8-1be2-47f0-8238-92dee8f5a204@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <b98a40e8-1be2-47f0-8238-92dee8f5a204@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256112-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3F69D43AD
X-Rspamd-Action: no action

On 2/2/26 7:10 AM, Michal Luczaj wrote:
>>> Other than update_elem, do other lock_sock() usages in sock_map have a
>>> similar issue for af_unix?
> As for the sockmap, I think that would be it.

Thanks for checking.

> 
> In related news, looks like bpf_iter_unix_seq_show() is missing
> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). E.g.
> bpf iterator can grab unix_sock::peer as it is being released.

If the concern is the bpf iterator prog may use a released unix_peer(sk) 
pointer, it should be fine. The unix_peer(sk) pointer is not a trusted 
pointer to the bpf prog, so nothing bad will happen other than 
potentially reading incorrect values.

However, yeah, the bpf_iter_(tcp|udp)_seq_show is better in the sense 
that the correct lock is used.

For tcp_sock that has many stats, I think it will be particularly useful 
to read them in a consistent state. I don't have a strong opinion on 
af_unix.

Unlike the sock_map where the lock_sock is not useful for af_unix. The 
bpf iterator can do bpf_setsockopt, so a lock_sock_fast() is still 
needed in bpf_iter_unix_seq_show and I think it is the reason 
lock_sock_fast() is used here.


