Return-Path: <netdev+bounces-210686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13EB1448E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 01:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4203B992A
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 23:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0458223496F;
	Mon, 28 Jul 2025 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NaBdrsQm"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB71A76BB
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753744112; cv=none; b=GDW7a/NRrkDUnfumQ6rY6a718zVxEIRkl6ZYHFQhOM5s9LdWkXTG1glSCGXIpBMxw6PfUUgVan7FQ8vN5Pd8OQyRu4W/iPaWB4GImLjgslPXHthxLmkAapsfTZXComEakQe12QhPcEY3ag3dkdFnWVRYRUtLn2y/aNHn5q41ISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753744112; c=relaxed/simple;
	bh=hOXb4gtCl1CYW/VGeucW14FVtx4CfkE0DPqvGmwHY2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiWOQSUA3DMr05HGJD2rXtHaK3kCA9OcpZIHsR4xuzKPYVvR+Sj/kwic8xR3TNPAkFSKjv/rXKL/1YEr5u90OxF+qjqHcQNgZx9hhNXsSTdOx4gy96sN9mZ6Pe+kecpsasfi33zogvBKSZKZcqGbG24R2uJMAWfWb5CnqIwxXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NaBdrsQm; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c3c1d6b-8748-4ae4-8e77-70d7d50c5f9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753744109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOXb4gtCl1CYW/VGeucW14FVtx4CfkE0DPqvGmwHY2I=;
	b=NaBdrsQmvVRtk1YgZLusEv7iP351qv60KO2HFE87dsMee+dgCr2mYQMPl4XrVepw8W+d9Q
	Zb0aX9KUPzGHx/DxppkaYU9F5wx46okpUx8Wiui2P1qxeT+lxO//QojdcotB8LQbRAf01X
	FIGUC6a5021fP1kYpCwh1XD32yO22wg=
Date: Mon, 28 Jul 2025 16:08:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: net_sched: Use the correct
 destructor kfunc type
Content-Language: en-GB
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250728202656.559071-6-samitolvanen@google.com>
 <20250728202656.559071-8-samitolvanen@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250728202656.559071-8-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/28/25 1:26 PM, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
> indirect function calls use a function pointer type that matches
> the target function. As bpf_kfree_skb() signature differs from the
> btf_dtor_kfunc_t pointer type used for the destructor calls in
> bpf_obj_free_fields(), add a stub function with the correct type to
> fix the type mismatch.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


