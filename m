Return-Path: <netdev+bounces-157328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0255A09F9C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944F5162D60
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8A946C;
	Sat, 11 Jan 2025 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GtV6AaI0"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC624B22A
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556309; cv=none; b=rkMBLS0RjNSOnsSgsgL5B3I0PppRotc5GcWxp+4mdWo3jTRGu6VR/VG6lUrlIsaMlk+lPR2WpHiQWIEaAD5MgOjza2E7GOpPEPqHEi+LrHV9nvEsk5VBLUzlMvb58YxQGGGbb9QAv/7BNRywL119CrmS4gkhuDDuIq/YporPVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556309; c=relaxed/simple;
	bh=2ZPNOo/CjUEM4HIQ9PpOP5qwGakBy8OHBdk40Oknmh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGTWSQJ6lMFZenu1McaT8b1SU8q5N+yNJZCP+CSR/2XgE49y2gMFzQV988fpL831HIQLfQgNzdQcxVDJFqi5oNWKICMEAmZyYS23vg+sQTzYc9l8cDj+yi41NkFnUynoIN1fgcTyE+NZAw3LWJn53gY4p3C423vfkCuhayP6Vd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GtV6AaI0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c11d669a-ebe8-4afe-9fc4-b8bc6cdf10b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736556299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQkHQJIFEQ5Y/qZGoa0YTq4nC0p5J3GzJb8Pg4WHHIk=;
	b=GtV6AaI0MUsEA9Stjjcv2zVsBev12JihwudHq5qh8nYG/bpKJrw53VEzYMJopdfCSymvNS
	IOD5RXM7A2dAJIjDhC+PzXfhz6Hmkt+Zj3IPBx2q8CTi7blnHgxPW+b0XhyNIRjW9qV+7b
	FDRJ2U+KlxaIdup/v3RhYTf2zprF6dA=
Date: Fri, 10 Jan 2025 16:44:51 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix bpf_sk_select_reuseport() memory leak
To: Michal Luczaj <mhal@rbox.co>, Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250110-reuseport-memleak-v1-1-fa1ddab0adfe@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250110-reuseport-memleak-v1-1-fa1ddab0adfe@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/10/25 5:21 AM, Michal Luczaj wrote:
> As pointed out in the original comment, lookup in sockmap can return a TCP
> ESTABLISHED socket. Such TCP socket may have had SO_ATTACH_REUSEPORT_EBPF
> set before it was ESTABLISHED. In other words, a non-NULL sk_reuseport_cb
> does not imply a non-refcounted socket.
> 
> Drop sk's reference in both error paths.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, can you directly take this to the net tree? Thanks!

