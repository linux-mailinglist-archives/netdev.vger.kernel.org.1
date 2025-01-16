Return-Path: <netdev+bounces-158701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C392A13034
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C43A4163
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 00:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69764125B9;
	Thu, 16 Jan 2025 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vXa+2Abz"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC2F9EC
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736988717; cv=none; b=Pe5hL5haIXgdeXdmOrMV/vdT/Kuxbn0XnrVA8og0E3/0oik3/O4krKaHjUbJkXv3eoutV9WxPqA2Vt5XN3FdHHEHH8tExiYG8CgqWD19+08xJR2fAilaX83cCrqqxys9Pu6gl69GPPea8BkvoRScegAqqVuQv/SbzrDio5r9Dtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736988717; c=relaxed/simple;
	bh=HE5JoBc8zx/gID60XJNS2lb23zOAE00FQRaBua1E7qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1KAzJLL1XktTbm6k3eO3oAXsLGGYV8lGqY5x74c0midlodsNRYN0Ov08VPdAseMorufPzMe1lKCm3lrKbcJqnRpCyz7XdzO5FOE1F/qEM+vCDgldp2PP4BcGUHqUzVWpWSWFyXhdhpeGnpljKL08MPUiAzRpQaFuYk0eHK2om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vXa+2Abz; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba353503-bfd3-4de0-bb99-9c7e865e8a73@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736988698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5hPi+QdxYusOIz+tRgOLLQRPuhLTdgVBUh5K3J4tCo=;
	b=vXa+2Abz5m55EwzHH1rGwpaji3bI9HEeVwcFeNRZKSesE/A8LyY0fBoh7qb3ysuD72mSdW
	SfEqdUs5RVhIsyygPLpzs9N3rYp1LBRQyf6Zie252v+vm1ynaExkuO4aVgpaIj+7lhnqwG
	RjlnYd8rfiOlt0EV26F312P8LLy5q5k=
Date: Wed, 15 Jan 2025 16:51:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 03/15] bpf: introduce timestamp_used to allow
 UDP socket fetched in bpf prog
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-4-kerneljasonxing@gmail.com>
 <02031003-872e-49bf-a658-c22bc7e1a954@linux.dev>
 <CAL+tcoD6MqBfbpM+ESkiNoRwsQqWsxMwMb4b0qvO=Cf8s52JyA@mail.gmail.com>
 <CAL+tcoDS6H4SMDRs9r+cOM_2bdbNRFRQpuYmpVFyxoMcQJDXLQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoDS6H4SMDRs9r+cOM_2bdbNRFRQpuYmpVFyxoMcQJDXLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/14/25 6:54 PM, Jason Xing wrote:
> I construct my thoughts here according to our previous discussion:
> 1. not limiting the use of is_fullsock, so in patch 2, I will use the
> follow codes:
> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
> +{
> +       struct bpf_sock_ops_kern sock_ops;
> +
> +       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +       sock_ops.op = op;
> +       sock_ops.is_fullsock = 1;
> +       sock_ops.sk = sk;

lgtm.

> +       BPF_CGROUP_RUN_PROG_SOCK_OPS(sk, &sock_ops, CGROUP_SOCK_OPS);

After looking through the set and looking again at how sk is used in 
__skb_tstamp_tx(), I think the sk must be fullsock here, so using 
__cgroup_bpf_run_filter_sock_ops() as in patch 2 is good. It will be useful to 
have a comment here to explain it must be a fullsock.

> +}
> 
> 2. introduce the allow_direct_access flag which is used to test if the
> socket is allowed to access tcp socket or not.

yeah, right now is only tcp_sock, but future will have UDP TS support.

May be the "allow_direct_access" naming is not obvious to mean the existing 
tcp_sock support. May be "allow_tcp_access"?

I was thinking to set the allow_direct_access for the "existing" sockops 
callback which must be tcp_sock and must have the sk locked.

> On the basis of the above bpf_skops_tx_timestamping() function, I
> would add one check there:
> + if (sk_is_tcp(sk))
> +       sock_ops. allow_direct_access = 1;

so don't set this in the new TS callback from bpf_skops_tx_timestamping 
regardless it is tcp or not.

> 
> Also, I need to set allow_direct_access to one as long as there is
> "sock_ops.is_fullsock = 1;" in the existing callbacks.

Only set allow_direct_access when the sk is fullsock in the "existing" sockops 
callback.

After thinking a bit more today, I think this should work. Please give it a try 
and check if some cases may be missed in sock_ops_convert_ctx_access().

> 
> 3. I will replace is_fullsock with allow_direct_access in
> SOCK_OPS_GET/SET_FIELD() instead of SOCK_OPS_GET_SK().

Yep.

> 
> Then the udp socket can freely access the socket with the helper
> SOCK_OPS_GET_SK() because it is a fullsock. And udp socket cannot
> access struct tcp_sock because in the timestamping callback, there is
> no place where setting allow_direct_access for udp use.

__sk_buff->sk? yes.

