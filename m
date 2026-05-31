Return-Path: <netdev+bounces-293470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DlcN7KIHGqQPAkAu9opvQ
	(envelope-from <netdev+bounces-293470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 21:14:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4675D6179D2
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 21:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58ACB3024A4D
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A264331A7B;
	Sun, 31 May 2026 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="NdfRqoUM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D12343BE
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780254894; cv=none; b=SFc47q3dGkjDuH6xjym2qqxAhDfkvxlbzWxgphn+mQ1E1WiGMfywDvT2wocabSMgNf5DLeDEDFWTdWfNYmQbWfOwsp9Z4mmN2P5OtfwQDuePJgQePcV6mAud0D6Aj8yqRG3ml/0kzFEegOP5BHjlVJDyMvjsOqv5fRy7GkC8XhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780254894; c=relaxed/simple;
	bh=DAHy8J54jxDA6vvUkqeHi0uN69mIZwRZPtr4XANXSCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0jRTBtNC4Wjii9SDeTikbIKn5G/WsdnRfE3DoV2pcJuagPpzYAcTzvJdAMUT/V5XOfHy0G56KPeYDu9JekcKC9tChqMZlBzeXEsT6mghe+Qg+8+xdvVruMiFxibj7sJFkGSZWyeTvuCjyhc7Ckp6SzgHq6Yt5VqFPCQjSfqZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=NdfRqoUM; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1363fe80fe8so11084021c88.0
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1780254892; x=1780859692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VLIr2839yosGYrgg+bhtZudSWU2zqH+9k+4w7AMccw=;
        b=NdfRqoUMWIl+2yP1hR2+A58fAmT7EJjKoORI3q0Jrxac+UK2aesKARW+/gozLeB8qc
         QSwMls1rhd2hCPo5M5pWikfl3gV2eDZNPw4QFxwGnadE4cOF7kGXPNH00Sdj7VEKyKUS
         pa4e/Ij28iE6z8np95Qtq//aXnH3u+t7kRkP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780254892; x=1780859692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VLIr2839yosGYrgg+bhtZudSWU2zqH+9k+4w7AMccw=;
        b=gR98oetyZ95o/c9QP/SABTLCfs4I8i4SEXT7kUaIeRaNodYAoW36VeZ/wpgNpKuUbp
         iLQJFclJkLRpGaKFjm0JkipQU6Smt0SMQiA218ATozc8NsMiuLqMBMRsxiAO61PlllnU
         DOXAIgI+z2VaviZUvKJh/WDzXXdJHEQYNXiVrrrB/g60nVxZTg/JPo2H8Oez0zuCjqi6
         xJUtXy1FRKrGZUaPqxAEY3zBtR45kuKZxUZy57Ji16bP8OOVyF5q8cO1BhUFPrl44qTQ
         FynOZHrp8xvbwCNNj3hEBftw9XD2SH9AejQUY8Ik3MwtCtIVFWEAtdwboXQFotZIUJpW
         9XCA==
X-Gm-Message-State: AOJu0YzE8xZAdKbzVA9K8fTnHKsZ2lUIf1D2M7cgg4pc6p2afvVLBOdL
	Ah8LfGV/trc/Uv6d0LJgWlVzAFUqU1ls8XZOX1LBnaMihrsqFctHAzOr+HRTbhEFbwsEz1Nd98J
	c3eA23DibIWt3
X-Gm-Gg: Acq92OFZ87Uitz194ckXCsnTg7hlMsC8hx/sfbcH7xAoA01li5wLt8dm2YMyGwXGsdm
	lsaEeaeGVA3cE+rgjPkVt6Mq6qQXCtJ1dWrKP3DSnIiZQaN+Tn88KZe4c5ieV2UGGsg9hSXa4mG
	/F1Q0UnXF3FzMjrA1s6qhMKojyqqeiCGE4aQEzwlgYiZFOUD9YX+LJomxXq5jvKfqhrEWSLmYDl
	BSf9GL16IpYAXiVig9Z47CrtepWMx7kg2a5atFtpGzU741qkYeUuFausIymuc7EGtDyeJh6NOMy
	aVakXW0ZT8SCECN2d2Iwzki0+HujI8Ey1S+HR1Pf0tfSlRXljddWuOcVgnBEdEKD01G4cxBexoN
	sWnqXrP3u6+COnv0HKUbc7Vw8VbQKb+03jCEAqcVF/cH7Tu40iJBNQBLpy/sxnRixxh9jnJ237z
	fCKXGg4qWikLZV5V7oVGRuSfV9gtZK7uDJ8MzBne4Anp11tQVJTFGnsb2GRlVtc6ZIMzweTKh7h
	2Ys1lupkM+TUvAQ9Q==
X-Received: by 2002:a05:7022:527:b0:136:b45a:4f66 with SMTP id a92af1059eb24-137d3f0f124mr3347405c88.16.1780254892110;
        Sun, 31 May 2026 12:14:52 -0700 (PDT)
Received: from com-75606 ([104.241.0.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b2d04287sm6959990c88.0.2026.05.31.12.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 12:14:51 -0700 (PDT)
Date: Sun, 31 May 2026 12:14:49 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	victor@mojatatu.com, jiri@resnulli.us, vladbu@nvidia.com,
	linux-kernel@vger.kernel.org, security@kernel.org,
	stable@kernel.org, syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 1/1] net/sched: act_api: use RCU with deferred
 freeing for action lifecycle
Message-ID: <ahyIqbpH204OLuDp@com-75606>
References: <20260531160812.68020-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531160812.68020-1-jhs@mojatatu.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293470-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 4675D6179D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 12:08:12PM -0400, Jamal Hadi Salim wrote:
> When NEWTFILTER and DELFILTER are run concurrently it is possible to create a
> race with an associated action.
> 
> Let's illustrate with CPU0 running NEWTFILTER and CPU1 running DELFILTER:
> 
>  0: mutex_lock() <-- holds the idr lock
>  0: rcu_read_lock()
>  0: p = idr_find(idr, index) <-- action p is valid (RCU protects IDR)
>  0: mutex_unlock() <-- releases the idr lock
>  1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
>  1: idr_remove(idr, index) <-- Action removed from IDR
>  1: mutex_unlock() <-- mutex released allowing us to delete the action
>  1: tcf_action_cleanup(p); kfree(p) <-- Kfrees p immediately, no deferral
>  0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- ouch, UAF p points to freed memory
> 
> This patch fixes the race condition between NEWTFILTER and DELFILTER by
> adding struct rcu_head to tc_action used in the deferral and introducing a
> call_rcu() in the delete path to defer the final kfree().
> 
> Note: this is a revert of commit d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
> but also modernization/simplification to directly use kfree_rcu().
> 
> Let's illustrate the new restored code path:
> 
>  0: rcu_read_lock()
>  1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
>  1: idr_remove(idr, index)
>  1: mutex_unlock()
>  1: call_rcu(&p->tcfa_rcu, tcf_action_rcu_free) <-- defer kfree after grace period
>  0: p = idr_find(idr, index)
>  0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- fails, refcnt already 0
>  1: rcu_read_unlock() <-- release so freeing can run after grace period
> 
> After CPU1 calls idr_remove(), the object is no longer reachable through the IDR.
> CPU0's subsequent idr_find() will return NULL, and even if it still held a
> stale pointer, the immediate kfree() is now deferred until after the RCU grace
> period, so no UAF can occur.
> 
> Fixes: d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Tested-by: Kyle Zeng <kylebot@openai.com>

Best,
Kyle

