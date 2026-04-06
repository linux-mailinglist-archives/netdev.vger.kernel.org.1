Return-Path: <netdev+bounces-275527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D3nIpE802mugAcAu9opvQ
	(envelope-from <netdev+bounces-275527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 06:54:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351613A180D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 06:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF602300575A
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 04:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6FE302742;
	Mon,  6 Apr 2026 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eH6SWGcH"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA601427A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775451279; cv=none; b=QUA+KIHDOnGGFzTUkjJ9HqM+CmIXU+m2tCshQ/4+uTLY3ToqmdJD+RfWMsXFHKHSyytf8cvjwmRWfXAmpPQ50cf8MgTnb9MOk/2S2zxawwjJKFlxgfIhr8E3Xdhnh9FUx+KK7vaiBzpe2Hh9oHmJyY/0Ps0gtwZN+NLHXcxnbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775451279; c=relaxed/simple;
	bh=i/M/U1Rs0FJn+opFy02cwva2q+VoShzETD0zYZFGZcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gv75a2Dd14MWh4JA5WM0SSzUsC6Yn5jYwv4Kp0GGWZJX5AlZsidLdQuijKRyD9QS0v/HhjyMtkLsZn8U8osxMMISOpQ0+weLYI1/lEBNAtyk33ht43pgRK7u76t/BftCycaATr3SD798Ta5eA1AfyE/QeDpeHJxTYEZJbc8X6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eH6SWGcH; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <739cdd1f-1838-457d-9b71-f47c3eadb0fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775451266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNbb8FX4JBbRHJzrlKceD/p+eg1E4vsexHkNHXJOTVg=;
	b=eH6SWGcHg/XM9mk09g5me7tLM3qVV1qLzSSCdcCvmV3nCl4LqFDVfcMLm4clqMs6K7WZNk
	d/qcdLWiTG+Hr41tmwrrx8Ta2SLTtwU4vpGQ3wRe7Wb8dNmiH7nkXeuhL2Q2r5KhIRNVil
	7vKND561a5c5lVMyHwL7UGkhePEg/fM=
Date: Mon, 6 Apr 2026 12:54:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix same-register dst/src OOB read and
 pointer leak in sock_ops
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: 2022090917019@std.uestc.edu.cn, dddddd@hust.edu.cn,
 M202472210@hust.edu.cn, dzm91@hust.edu.cn, emil@etsalapatis.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
 <913274772cd62d8d93e6cfb2c251c2388b73f24f90d05be3c9994207ac7048bf@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <913274772cd62d8d93e6cfb2c251c2388b73f24f90d05be3c9994207ac7048bf@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[std.uestc.edu.cn,hust.edu.cn,etsalapatis.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,davemloft.net,google.com,redhat.com,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-275527-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 351613A180D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/6/26 11:47 AM, bot+bpf-ci@kernel.org wrote:
> This Fixes: tag covers the SOCK_OPS_GET_SK() portion of the fix,
> since 84f44df664e9 introduced that macro. However, the identical
> bug in SOCK_OPS_GET_FIELD() was introduced by an earlier commit:
>
>    fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")
>
> That commit added the dst_reg == src_reg handling to
> SOCK_OPS_GET_FIELD() with the same missing zeroing in the
> !fullsock path. Should this also carry:
>
>    Fixes: fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")
>
> Without it, kernels that have fd09af010788 but not 84f44df664e9
> would not receive the SOCK_OPS_GET_FIELD() fix via stable backport.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary:https://github.com/kernel-patches/bpf/actions/runs/24017481706
Well, it's true. However, fd09af010788 and 84f44df664e9 are from the
same patchset (same author, same minute), so any stable branch carrying
one will have both. That's why I only included a single Fixes tag.

But if you prefer carrying both explicitly, I'm happy to add it in next 
version.

