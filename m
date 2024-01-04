Return-Path: <netdev+bounces-61430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86C6823A7E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0891E1C24B95
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F21859;
	Thu,  4 Jan 2024 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fntPS757"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F950522A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 02:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2037EC433C7;
	Thu,  4 Jan 2024 02:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704333868;
	bh=3JRjtfFCNYu2klVQ5gHdfv13y9bSGmXlw8CG0behsoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fntPS7572faCpWwa3QMXvqoiEbEpAg+D2BH7UX9jeO2jPYOdvJxJozkvQQcwQsEZe
	 0JuaxpG4Jl2GVoH9XerMuWnkZopAoqQKAIIbOD64cg/YOMWuFvDQsUvmPcUvo8ua8o
	 9o2fkDjP81Brz+j9JhIGjRHKJIPs8SYgDZEhznBIR+p75PgntorTyMG3GbnsvpLLDu
	 PXysKx1moXp6XcZMX7sEWxYgkq/fRHjRjFbfQnaJBn40rYPBYx0dY9RDs6ep83NlYO
	 ULTe5AoPQg9ktFkWPS1TLI6L8kxHENsVerEDcFTg/xvpYE/w8uaAA0HH+Pw0gQEOXI
	 8+AkNAyWmNJOg==
Date: Wed, 3 Jan 2024 18:04:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, pctammela@mojatatu.com, "David
 S. Miller" <davem@davemloft.net>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@meta.com>
Subject: Re: net/sched - kernel crashes when replacing a qdisc node.
Message-ID: <20240103180426.2db116ea@kernel.org>
In-Reply-To: <ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com>
References: <ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 17:41:54 -0800 Kui-Feng Lee wrote:
> The kernel crashes when running selftests/bpf/prog_tests/lwt_reroute.c. 
> We got the error message at end of this post.
> 
> It happens when lwt_reroute.c running the shell command
> 
>    tc qdisc replace dev tun0 root fq limit 5 flow_limit 5
> 
> The kernel crashes at the line
> 
>    block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);

This is the same as
https://lore.kernel.org/all/20231231172320.245375-1-victor@mojatatu.com/#r
right?

