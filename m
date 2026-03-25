Return-Path: <netdev+bounces-271342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ApsOaM9w2nspQQAu9opvQ
	(envelope-from <netdev+bounces-271342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 02:42:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E201B31E5D6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 02:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB79B30274BF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED96D272E6D;
	Wed, 25 Mar 2026 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h4ilSWka"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52669270EDF
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402973; cv=none; b=Jab1QaDfgQBABcr3QZtsPXyAorQxCNqPp+TyD4p62ycaDFgKgfEIamQ+5CDBVb0ADnVNiK/FSHTG0XTsySHUrMwL4+nC0MY/DlOe1PMSjQ+w2dCo0cCJlITQ3Bq+THRyvMRrn8JFXEiUET8prZ3bgMfyGM3VSJfeksj7jmzqACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402973; c=relaxed/simple;
	bh=poc8RQKZHV6IyOZIlkXBpoaLWdoilvRbScnWqgIzwkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPem/+BG6TlJdfyPXAJBdHN/9sYewi3Uoar8UXqWZOT/CE+pmO7V/xymgtNp0JZHyw0l3IqTU8ddboBN6vmduoA6EAbzu3Nly7vbxsaKSIaE04Ph8sVf5NUukf5z0COkVW4XTMJBz4akzFEvvj9MzGzUrFA4JXbe/+6NEsZN/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h4ilSWka; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <401134e3-2a2f-4c23-8ba0-3a4cc901d6a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774402960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYZezwn0ZMtB7MrRH2625PaWZJBlv5I3izmJUNinHpU=;
	b=h4ilSWkafyyuwUX/2VlnmemnQoV//SuMV1p7ZUAymmYa9O79QdPScsrxWS0EsavENGU0Fg
	GM7UcmvzaWMc/d9DebK2+QIJgUQT8DCm+wwgieK2UEHLzNIqougGu2yvyez4VQcxRzl2aX
	sojrqgVxAcULluq70GxWejoMEnE6xzE=
Date: Wed, 25 Mar 2026 09:42:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-2-leon.hwang@linux.dev> <87ecl9mc9d.fsf@toke.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <87ecl9mc9d.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-271342-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,vger.kernel.org,fb.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: E201B31E5D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25/3/26 00:18, Toke Høiland-Jørgensen wrote:
> Leon Hwang <leon.hwang@linux.dev> writes:
> 
>> xdp_has_frags was introduced by the commit
>> c2f2cdbeffda ("bpf: introduce BPF_F_XDP_HAS_FRAGS flag in prog_flags loading the ebpf program").
>>
>> The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
>> was to ensure backwards compatibility against tail calls. However, it
>> missed that XDP progs can be extended by freplace progs, which could break
>> the backwards compatibility, e.g. xdp_has_frags=true freplace progs are
>> allowed to attach to xdp_has_frags=false XDP progs.
>>
>> To avoid breaking the backwards compatibility via freplace, disallow
>> freplace on XDP programs with different xdp_has_frags values.
> 
> The problem you describe is not actually a problem, though? A
> frags-aware program can run on a non-frags interface just fine.
> 
> You're messing with long-standing behaviour (since 5.18!) to solve a
> non-existent problem. In a way that completely breaks the frags handling
> in libxdp[0]:
> 
>     Running tests from ./test-libxdp.sh
>      [test_link_so]                PASS
>      [test_link_a]                 PASS
>      [test_old_dispatcher]         PASS
>      [test_xdp_devbound]           PASS
>      [test_xdp_frags]              FAIL
>           Kernel supports XDP programs with frags
>           check_load_frags:	FAILED
>           check_load_nofrags_success:	PASSED
>           check_load_nofrags_fail:	PASSED
>           check_load_frags_multi:	FAILED
>           check_load_mix_big:	FAILED
>           check_load_mix_small:	FAILED
>           Test test_xdp_frags exited with return code: 1
> 
> 
> Please don't do that.
> 
> -Toke
> 
> [0] Run 'make test' here: https://github.com/xdp-project/xdp-tools
> 

Indeed, it failed to 'make test'.

Will drop this patch in v2, as it wasn't an issue.

Thanks,
Leon


