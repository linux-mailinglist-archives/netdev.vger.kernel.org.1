Return-Path: <netdev+bounces-272387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJPSJGsnxmnQGwUAu9opvQ
	(envelope-from <netdev+bounces-272387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:44:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C800C33FF99
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04BDB303104F
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F639E193;
	Fri, 27 Mar 2026 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BMHLiTTQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B33BED3C
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593767; cv=none; b=WL+ZAvB/tKpC3HrZmacng34pT6sjHq81MCaaljYB+xxKwxAKSmfmmaCppqamY0LSJ+yaQxAi/HPUp4cT1GsnmUi0X/jjcbFd9Juy/5wjAOaadnsfUM0Ro6Q6rBNkuY44fjlNMBoMFxms3jcau4YvDep8HhVHwVWzphHJ5/iaGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593767; c=relaxed/simple;
	bh=wFXmO27wKvV6/Kr+vvz+qry41MFFNZPIOZqFd6mwDpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQmTjRcam/R+LBQWHB1Cwlzlmk0fpbNgQYqC/pu8dEVSznQ4H6v2noMXmfBKDf72MNfVBXiy+ymHVnu7sLOkMUdkHXIcnGQnsuwG7HvJvOOgInlAT6yqa929Tuq3ckNGVZm8enaE8f2amMmf5YB3mEmuW6zuBvsHqLbcYixSObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BMHLiTTQ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <785e0b04-91e4-457f-8d6c-e0a911c0fd88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774593754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b59W3l9WpyzX2iAsGdXQno8uo7jmzlLBBhaOtXWpNvk=;
	b=BMHLiTTQOLBNNQJP1khgYmCgNFAUY7dhRkrLHCZixLoDngy+y9oGHvb+X/htRg5tAnrzYL
	qjUTh78zj/13+gL/g6zuuaUcknueSbo/k9tL8No+U7yYTPc/n6xr65yrih1eE9EWSBHKov
	kZH7LA0auDo3Rmb8p0JFYlNF0BYBsEM=
Date: Fri, 27 Mar 2026 14:42:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-2-leon.hwang@linux.dev>
 <20260326124205.1a3bb825@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260326124205.1a3bb825@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272387-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: C800C33FF99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/3/26 03:42, Jakub Kicinski wrote:
> On Tue, 24 Mar 2026 23:04:42 +0800 Leon Hwang wrote:
>> The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
>> was to ensure backwards compatibility against tail calls. However, it
>> missed that XDP progs can be extended by freplace progs, which could break
>> the backwards compatibility, e.g. xdp_has_frags=true freplace progs are
>> allowed to attach to xdp_has_frags=false XDP progs.
>>
>> To avoid breaking the backwards compatibility via freplace, disallow
>> freplace on XDP programs with different xdp_has_frags values.
> 
> It may be worth adding a selftest to
> tools/testing/selftests/drivers/net/xdp.py
> which sets MTU to 9k, tries to attach a non-frag-capable prog
> if that fails attaches a frag-capable prog and then checks if
> replacing the capable prog with non-capable fails.
> Drivers may be buggy in this regard.

Do you mean adding these two tests to xdp.py?

1. Verify the failure of attaching non-frag-capable prog to mtu=9k
   driver.
2. Verify the failure of updating frag-capable prog with non-frag-
   capable prog via libbpf.c::bpf_link__update_program().

As for test #2, it may require a helper to attach prog then update prog
using libbpf's APIs.

Thanks,
Leon


