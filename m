Return-Path: <netdev+bounces-305675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2J9nELEGTmp2BwIAu9opvQ
	(envelope-from <netdev+bounces-305675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:13:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E16272304E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:13:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=tESaesU1;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305675-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305675-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B50243067051
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E2F3FE650;
	Wed,  8 Jul 2026 08:04:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7473FD140
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 08:04:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497892; cv=none; b=pYpV6V1+jdCJcrSIVu9j56VQOTZVROof3MBpcS5yZ7b+Kw9KIAa+i8qLo3FDQXS4E8pw7M/srr8Ltz+Jzzc+ImCJ011jnFZ39ZT2UtOCpAjHtMOt8JnRsNGXYlcP6pjgei9Kt6AO4YVx5BFe9tLk+o2aPwmM+/LHL0JEGNKz/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497892; c=relaxed/simple;
	bh=lhKSffhkWzsZ0/8rfDC7YE2ivqQOUh/Jm8bDdf9qJW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjB1jYEzgGK3DhkSvv32SkehR3EaBo6/QuyIDNke6rZjqcui0vBoffVBgflxCRqPkZqDMkC8m6OeurvuIBP7tA9DRkuyofRMejfZIsz0SC6yZPbARICYOjkYFss3p6jUZWBDv3VxawPt7FoAE0e/FuhFFgkSXPNzLX1wjr6eV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tESaesU1; arc=none smtp.client-ip=209.85.215.172
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso244389a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783497885; x=1784102685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhKSffhkWzsZ0/8rfDC7YE2ivqQOUh/Jm8bDdf9qJW4=;
        b=tESaesU1raCpuNWf2JvAnEeXLHI8sUQcmt9PGuNv5NbzcwZYHvL6troiP83gF6gWI8
         NYcUj2N80mkAuGimeoTMcot4YlSmdqA/N3BFU9ofrgtB/fhL7J/uDmglEPxZhRzdWuYL
         dD9p/b+0lfeCjxAPW1AT5JEkQH1vz6xiKjxv7q+OuszVamrdoxraPLmEpV/MB+MAMK2g
         nilJV/I+veph0rnnV92UMTinF73W1/iObmDdTSH1dZJWQwUhjf+/9CssPM5pDC91+lNT
         XUhvu42LseRDdw8rw7xhxoTK9w4S7MNCPbmRPMt817MXLVUXDc0DfnkqsfeUnytQAq5k
         BMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497885; x=1784102685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhKSffhkWzsZ0/8rfDC7YE2ivqQOUh/Jm8bDdf9qJW4=;
        b=NOeqatSDzyh/qYRjP2OzyOlKT1shfFUECEUA5o8EX+rNuKfyPKXqEhVT79c2Npy/h5
         SZiFQZlSGd5eA3hWRnIW1dGe/6KK4tHZyO4Vjeit3y/AkdyPSRikH6zujWJbAR+YQHFH
         tLIMmTTeX5RkTZy9ZGbW8TKjN22rWoN6hm8hgPhI8cYmrg9nXka+FXriIngYuem8idRq
         1LfblI830hw9swn7nyn0Z7bXHuJUZICvUsF8N3HV5/nt5HSQp4YFcQyj9/G0+rmg8Mzr
         dzF2DJsT2SQQRv9xzOl8bKVkDNwaDdI7meRuW9rdnTori/puosM0YLwAGkc6G66vykcU
         jnwg==
X-Forwarded-Encrypted: i=1; AHgh+RpIn3Cg6W7PplNCXVS3ZgSXm7Af27nV0apO1mS/rJFIuUyOpBHG/HFgYuzDtV+w9fJpTYkOwZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7xUdA5GyZJUvLmXS4XiWqBubKVm4EhZSh8feKOoggnnvDwmJ
	HWFuSGXTrdxRFe7pMgAFleRJSFYc7c45VYaeZVi7+/1rrxYhg1qgEIOB
X-Gm-Gg: AfdE7ckdzeL+Zne7Rn0K4P/gIgmRbqV8DAnuSfpxTcbjVm1VXyYQMY9yHR0FQSk0/rA
	7qraFkLMn/BhhDaRVWFuTGw4VACXnXzA7mXRIea5EeSBAgIJjyOD2pw1/IbgVoc6IyG/Qsaj2dv
	7v/LtijV5L/6h8fj/TT4ZOD/E00KOQpDMQODVEqYy4cbz8mFKZ9T2JMo9LIjtTpi7OVsOEGjJBo
	3oJac73VOIwkNzkY++NxwWMs/Kqoi9K1WrDmd72zu4nHqAqwfToWMuq81RUHB02rxvo/Q5vcwGr
	SswZqdEoFMJBZuY6WF1UpFMNvLbK7eL4fTRkqmrgKsflld1tm4GXhb2MuDfmsx0HPQIruPHy5wZ
	Mi1Qc59NhTCVDQeTf6mPOE1d8dmd2DKi3gv2wGDefG9U20D+eBsgW6OU5CLjYTaLokplaczLKWb
	6lWa1diTN7yMQcuRwrjmuEgi6CPFQbDJLm23zz7elf8pIpeEJThbEm1rC8QGFD
X-Received: by 2002:a05:6a20:1587:b0:3b2:86cb:929e with SMTP id adf61e73a8af0-3c0bd206b59mr1755177637.46.1783497885553;
        Wed, 08 Jul 2026 01:04:45 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311950eb930sm2220581eec.8.2026.07.08.01.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:04:45 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: toke@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	eddyz87@gmail.com,
	edumazet@google.com,
	emil@etsalapatis.com,
	eyal.birger@gmail.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rongtao@cestc.cn,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yatsenko@meta.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Wed,  8 Jul 2026 13:34:34 +0530
Message-ID: <20260708080434.732503-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704092159.1256823-2-avinash.duduskar@gmail.com>
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com> <20260704092159.1256823-2-avinash.duduskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305675-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:toke@redhat.com,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:eyal.birger@gmail.com,m:hawk@kernel.org,m:horms@kernel.org,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kpsingh@kernel.org,m:kuba@kernel.org,m:leon.hwang@linux.dev,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rongtao@cestc.cn,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:yatsenko@meta.com,m:yonghong.song@linux.dev,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com,etsalapatis.com,linux.dev,redhat.com,cestc.cn,fomichev.me,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E16272304E

The bpf ci bot flagged the VLAN_FAILURE re-issue advice in the uapi doc
here, and the finding is real. By the time the lookup fails,
params->tbid is gone (the h_vlan fields it shares storage with are
zeroed on entry to bpf_fib_set_fwd_params()) and params->mark is gone
on the resolved-neighbour path (overwritten by the smac output). A
program that follows the advice with the same struct and DIRECT|TBID or
MARK set runs the second lookup with a zero tbid or a garbage mark. The
selftests did not catch it because every arm re-initializes params,
which is the safe pattern.

Toke, the re-issue recovery came from
https://lore.kernel.org/all/87jyrwf9g1.fsf@toke.dk/, so before I
respin: my preference is to keep the mechanics and fix the sentence,
"repeat the lookup without the flag, re-initializing *params* first;
output fields overwrite the inputs they share storage with".
Overwriting inputs on the way out is the helper's existing behaviour on
every path (rt_metric lands on top of tos/flowinfo even on NO_NEIGH),
so one rule, re-initialize before any reuse, seems better than making
VLAN_FAILURE the only return code that preserves inputs. If you would
rather VLAN_FAILURE restore tbid and mark the way it already restores
ifindex, or lose the advice sentence entirely, I will do that instead.

Avi

