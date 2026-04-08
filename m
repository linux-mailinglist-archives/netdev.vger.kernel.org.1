Return-Path: <netdev+bounces-276675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB0IIe2a1mmyGggAu9opvQ
	(envelope-from <netdev+bounces-276675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:14:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F28263C03C1
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0266301A72E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193F93D8918;
	Wed,  8 Apr 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fpqPtzxi"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2F1E5724
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672007; cv=none; b=gh0bb2xGmZJHuvtmHywmavbqMasGF2ZAc1l0O4l4Nhf9Li3WrXGa6w5SMOBzWtzbly9oTYR06lTOA8r8lPE1nRGsXCWaBiABu/VF+wsH66NQrMsXsQGuSajPOpYtXbxV8FOzaunlP+QMKttGyDcfikTfUmq1veS6J71VVCrS6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672007; c=relaxed/simple;
	bh=eERDK8MrgRVFpt8EPs6mScv+NPAcz47BRTMWRwRaxO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkhsxnYpPwycDbShmS/RxaTktNEM/Jp8satPMB0VrdKq5pp1vaKHygVAjk3Nxc65EVkB6XFwQ7z9/7kdSRcXM2V8wToLdj10JPCafLS6WY2IwgKGrO3GQtjlytKZaIoylYQt7vRP5wTVcOZ+lyL0n3p7RjeyYTD8CUFXQXrTLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fpqPtzxi; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 8 Apr 2026 11:12:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775672003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvj5h4HHK3avmY1kaN9kSeAcx7M966IB/bsppq/wjeY=;
	b=fpqPtzxiBAcO1LzeEqfVrmmPD1WZRWqf1D0cXahjB9nqdlirSLXRI2Ys4YaAnqzXLbr1Th
	0h+Lzl0ZfAXzRyZDCXh4brASljnAAp1N0LGKGI61+84B+R3Q1hg+onnZ2O91Tz+baLn1UD
	XqGfeuybvA2UDxCObG5jwffCDo3sm8c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, martin.lau@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb
 when wait_for_space occurs
Message-ID: <20264818422.Ya8u.martin.lau@linux.dev>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com>
 <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
 <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
 <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
 <willemdebruijn.kernel.1b49845d3acc7@gmail.com>
 <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
 <willemdebruijn.kernel.257654f9a3f23@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.257654f9a3f23@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276675-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: F28263C03C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 11:15:09AM -0400, Willem de Bruijn wrote:
> > Avoiding adding a new one makes the whole work extremely hard. I'm
> > wondering since we have hwtstamp in shared info, why not add a
> > software one for timestamping use? Then, we would support more
> > different protocols in more different stages in a finer grain, which
> > is a big coarse picture in my mind.
> 
> I don't understand the need to store more data in the skb for BPF.

Adding a field specific to bpf timestamping is not scalable.
There will always be other bpf use cases that need to store
something in a skb.

There have been discussions about storing metadata for a skb which should
solve the general bpf use cases.

https://msgid.link/20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com/
https://msgid.link/20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com/

> 
> With BPF hooks, the bpf program can record the relevant data directly
> in a BPF map.

