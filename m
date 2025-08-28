Return-Path: <netdev+bounces-217520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A03B38F96
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477067C1D49
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30EFCA4E;
	Thu, 28 Aug 2025 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v9ZDs7zk"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5CB665
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339618; cv=none; b=lb8QDsvJFRdo3OIfSzDtRAwHfNk5U/0yms94rAR0tsjdyND/DXy7Y6J+uLVk961AWS8ijGwMaoEm8RuDPspLzPdTWOGDY2WP/fyr+dOJ++ENhaymeoGVrvfLDj2LmeZSAMXdzoJxG+iBFs9ZAlcEO4iICjGbMR7lSNx/TuPdnPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339618; c=relaxed/simple;
	bh=/BH+2LaqqrXTlr6Er7h9zOFOcR6chXoGcn1omObe0Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZH+7bYiYUyXAdJ0TQAowsPP0/vwgxYux+NSznLAmcO9EIwo+00/sMR3VRRb/VDS+FFIHjj8NruE+0s5igSebcU6/mempXD0FbAwm8BskZsmLvEYMkajCMIIoycC8s6CK7+ffYi3vVQdY6dwnSrxPA3OnvgmBZ3rmQ4+w/gb2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v9ZDs7zk; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e1ec7d14-ec50-45a1-b67b-f63ba75699a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756339605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqJPbr5uTMudwBOyBnBf81tu086UZwu8xK2Zx9ec5IQ=;
	b=v9ZDs7zkqx2zjHhRyZQM+rowHDQHVhS2x+WrvS7sdxbibcF+OMOlvMzHQH5T776w+N1GPl
	2WsbJyoy54vPwQXHL/zulP9dxCeNlpJRe8ja2zaxf4HKVDYqNtuVwpq1kiMG0VIkA9g/fW
	GuMDOhki4/NWUPx6XAOVXLhA+qauUFc=
Date: Wed, 27 Aug 2025 17:06:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for
 BPF_CGROUP_INET_SOCK_CREATE.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250826183940.3310118-1-kuniyu@google.com>
 <20250826183940.3310118-3-kuniyu@google.com>
 <aaf5eeb5-2336-4a20-9b8f-0cdd3c274ff0@linux.dev>
 <CAAVpQUCpoN4mA52g_DushJT--Fpi5b8GaB0EVgt1Eu3O+6GUrw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUCpoN4mA52g_DushJT--Fpi5b8GaB0EVgt1Eu3O+6GUrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/27/25 3:49 PM, Kuniyuki Iwashima wrote:
> BTW, I'm thinking I should inherit flags from the listener
> in sk_clone_lock() and disallow other bpf hooks.

Agree and I think in general this flag should be inherited to the child. It is 
less surprising to the user.

> 
> Given the listener's flag and bpf hooks come from the
> same cgroup, there is no point having other hooks.
iiuc, this will narrow down the use case to the create hook only? Sure, it can 
start with the create hook if there is no use case for sock_ops. sock_ops can do 
setsockopt differently based on the ip/port but I don't have a use case for now.



