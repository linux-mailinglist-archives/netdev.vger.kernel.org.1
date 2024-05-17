Return-Path: <netdev+bounces-96856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BC08C80C1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AF61F21479
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 05:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B461118D;
	Fri, 17 May 2024 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="JEjYnpL7"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74413AC5
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715925592; cv=none; b=cs3k+hyFtXznVPo1JMAB9w4eSAcr4CQTeNxZhxPL2+BIQ83vqXQ8pFNb8iPV3giwcdMHjODiyO3HBNTqbaK2u4EXWwk/kjcKH2CdfZyg6yWGVFBknKymlnzQLmhudVcB+5sdl0ztpWRgtZzBxfYlWdIbl3CYDsXkMzOChdvTzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715925592; c=relaxed/simple;
	bh=DPM6VFpVQ8ouz24TF1UVE+4yRBEKbz3V/D/TgB9ijwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDpjF2Gh8OEQsojOGcwRSbqKFajxyy8DlECpNCfdUsaWjsfEfVtjEXNWveGklQvcwW5UbnkQBxGkQW9Vm3KNDKquQwh7cN9xDiWvvhsVLWiaCYTxqRZv7dzA68PJUD3dgM0i924qMxBlWaroiTbXXv8NgP2EslORIwwRTlVpIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=JEjYnpL7; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7qd1-004kuG-6L; Fri, 17 May 2024 07:59:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=GfzglJlYlciWbxuYO7od6iZDt2abNzo1gKWwJNAJEiU=; b=JEjYnpL7WcrZUCzsXJ7rBX+Rfj
	/J78XZ2K0/k5EBt4EjIi0qOBWlEkZ/tBocwpXefgvRWSSa2pwhMXYjZSp/xt6YKim5LLA/nCar/lr
	A2lccONy0bIlqKhDb9himptIUTlzz+NnqFaDBXSUkpLEGhcbqCAU7d8M93lFKXY9JsJvSSVTMSmyl
	wv9tNyOfrKeANCb48VyjF5qTTUm3A33pdK9iWUQjgs/j3LmajIRuRct0bh+NKp/IoFc4ROmI26+wI
	XgreV9aAJgbGGEoiubcp7SApiWKTg7gQE5tJXPgda0bt3j75PNgZxXbP+WwE1Ogfmjpup8djQ5maP
	MZANRM4Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7qcz-0000Pt-Rh; Fri, 17 May 2024 07:59:37 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7qcg-004R6s-5I; Fri, 17 May 2024 07:59:18 +0200
Message-ID: <734273bc-2415-43b7-9873-26416aab8900@rbox.co>
Date: Fri, 17 May 2024 07:59:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] af_unix: Fix garbage collection of embryos
 carrying OOB with SCM_RIGHTS
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org
References: <20240516145457.1206847-2-mhal@rbox.co>
 <20240517014529.94140-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240517014529.94140-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/24 03:45, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Thu, 16 May 2024 16:50:09 +0200
>> GC attempts to explicitly drop oob_skb before purging the hit list.
> 
> Sorry for not catching these in v1,
> 
> nit: s/oob_skb/oob_skb's reference/

Argh, sorry, I've copy-pasted my own misformulation.

>> The problem is with embryos: kfree_skb(u->oob_skb) is never called on an
>> embryo socket, as those sockets are not directly stacked by the SCC walk.
> 
> ", as ..." is not correct and can be just removed.  Here we walk
> through embryos as written in the next paragraph but we forget
> dropping oob_skb's refcnt.

Oh, I agree we walk through embryos. I wrote that embryos are not _stacked_
by the SCC walk, i.e. embryos don't appear on the `vertex_stack`. But I
think you're right, such comment of mine would be incorrect anyway. So,
removing and resending.

>> The python script below [0] sends a listener's fd to its embryo as OOB
>> data.  While GC does collect the embryo's queue, it fails to drop the OOB
>> skb's refcount.  The skb which was in embryo's receive queue stays as
>> unix_sk(sk)->oob_skb and keeps the listener's refcount [1].
>>
>> Tell GC to dispose embryo's oob_skb.
>>
>> [0]:
>> from array import array
>> from socket import *
>>
>> addr = '\x00unix-oob'
>> lis = socket(AF_UNIX, SOCK_STREAM)
>> lis.bind(addr)
>> lis.listen(1)
>>
>> s = socket(AF_UNIX, SOCK_STREAM)
>> s.connect(addr)
>> scm = (SOL_SOCKET, SCM_RIGHTS, array('i', [lis.fileno()]))
>> s.sendmsg([b'x'], [scm], MSG_OOB)
>> lis.close()
>>
>> [1]
>> $ grep unix-oob /proc/net/unix
>> $ ./unix-oob.py
>> $ grep unix-oob /proc/net/unix
>> 0000000000000000: 00000002 00000000 00000000 0001 02     0 @unix-oob
>> 0000000000000000: 00000002 00000000 00010000 0001 01  6072 @unix-oob
>>
>> Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> with the above corrected, you can add
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> Thanks!

All right, thank you.

One question: git send-email automatically adds my Signed-off-by to your
patch (patch 2/2 in this series). Should I leave it that way?

>> ...


