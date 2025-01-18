Return-Path: <netdev+bounces-159513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93652A15AE8
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA19C3A8240
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4D024B29;
	Sat, 18 Jan 2025 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eHgDQ/XP"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107EE136E
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737164555; cv=none; b=mqIfQr2wKOCfxf/mOP+DK+zoQYdwPJNerL9C2AIZwRVxENXvCmydCSntqByjQ7nUQcYpvG79SDUjVoLVfZQMGamHEkZU4rzxW4Bm/cZ4xY7UOvekdlIq82hdnDE40slFhJYQt77jzSfFTzSTc+Jy1iSJk+5AWkrj3rM8eaA7i98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737164555; c=relaxed/simple;
	bh=RJOxkQongaIVqruXMDXrgS7k7YR8+IU9MKMWmAy+0L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXdlKQF5U38CE1XevOdh+6klfcNWmDPR9YDlMkMWWXpmXcr+hLWDO85Pp83/wZfyMaT1EVLLPLFOAAxrHEsQNVtCuf5YSuEVkURobueNhDwcilv7zGvmqWe2TfnM/uIW8Zi2vbtsPtU8taDWEOpm3dZGFYPPGXH8eqhv/jqf2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eHgDQ/XP; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <41688754-20fc-4789-879f-60f763b3a9db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737164541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1U57c2FZY0LUjTIrx64euHGzhxciNnYcBVICwV6pgk=;
	b=eHgDQ/XPIDXZQ4/tKept5+L24Lq1uc3ILMr7+Vv4Pn5K2sGYw3PN71Izt5la+xrQdFw3BB
	6oTIeZ0B6KTf4ufyxdMKphsJPNS0SZsezZwDIcSHKoALxCpxRZBqWDchvG5y7rR/c183vz
	QnJpn4uVPXpbgjpNIn7v0xHJfQ1lins=
Date: Fri, 17 Jan 2025 17:42:13 -0800
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
 <ba353503-bfd3-4de0-bb99-9c7e865e8a73@linux.dev>
 <CAL+tcoChGB3vA7LMm0VHb9OjmXHUw0--f6v4Crz5R7U+EPo+cg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoChGB3vA7LMm0VHb9OjmXHUw0--f6v4Crz5R7U+EPo+cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/25 5:12 PM, Jason Xing wrote:
>>> Also, I need to set allow_direct_access to one as long as there is
>>> "sock_ops.is_fullsock = 1;" in the existing callbacks.
>> Only set allow_direct_access when the sk is fullsock in the "existing" sockops
>> callback.
> Only "existing"? Then how can the bpf program access those members of
> the tcp socket structure in the current/new timestamping callbacks?

There is at least one sk write:

	case offsetof(struct bpf_sock_ops, sk_txhash):
		SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
					 struct sock, type);

afaict, the kernel always writes sk->sk_txhash with the sk lock held. The new 
timestamping callbacks cannot write because it does not hold the lock.
Otherwise, it needs another flag in bpf_sock_ops_kern to say read only or not. 
imo, it is too complicated to be worth it.

It is fine for the new timestamping callbacks not able to access the tcp_sock 
fields through the bpf_sock_ops. We are not losing anything. The accessible 
tcp_sock fields through the bpf_sock_ops is limited and the  bpf_sock_ops api is 
pretty much frozen. The bpf prog should use the bpf_core_cast(skops->sk, struct 
tcp_sock). The future UDP timestamping support will likely need to use the 
bpf_core_cast anyway because we are not extending "struct bpf_sock_ops" for the 
udp_sock specific fields.



