Return-Path: <netdev+bounces-253426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMxSDZ5Jd2mLdwEAu9opvQ
	(envelope-from <netdev+bounces-253426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:01:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A30C787729
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C6E4302A1AA
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279FE331A68;
	Mon, 26 Jan 2026 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fB5oNzGe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7AF33122F
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425191; cv=none; b=cVZq+ZiIYEfpGEspndYiWN272I2nPoVR1JYNR9sH8kSxlmDLD196TPh0cmq3fJYNfudAV9KXlAI/Y8ePTE1EyuIklAugW3BqmKm2W8zjfdEtfD3giEQXl9jiJrR9D4efNjUOMCY1Ynk2L1IQTW35yI2k2nFl4EX8AQU6AUWOKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425191; c=relaxed/simple;
	bh=OafcGQ6mxAgBJ88vByZ9JIl3q/zabfaREQeoOaB55Ms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnZ2fxYW+0u+A4VcoxFuzozdNDHfDMBGcMV0ztNEIfXbVXVZNDZf+FKxbJeCDZUAsVo5zoCqh8jFN61mZWLyicm7ueuUMrJpnTduaM64mapLII6FBqikSrr9z2bASbqZcWu+GjEuiXliWqe8ilH+cqJOVJN3bh27iAxdJ82udiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fB5oNzGe; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b8849dc12f6so645640266b.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 02:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769425187; x=1770029987; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNxfvlw1oB2el4crQ4TvEj6ef2WAE6hpmRaDCbae0ok=;
        b=fB5oNzGeLLdemGhohHO/362WVc0wb3W5YnpSUiy3dJfxJ8SuveE3wdmSfBswxmBPnj
         9FkTK1Xr8bWsFzVSIL2l8a9fLQ1J6Rokjcejs5JpqPXmqBm6G89PeHz8TRYGBm4Ea534
         UW9qymyLQJow8JGU4ajrQ60T2GaCHoIU4o/0jjjCTjx7t750Ljh/CXXeBSRHODJp3k/F
         SVs7pHScgZRgkEZaf1JJrMWSDF5fkdg3aY4uKjeUGBa449e3hX+yCoHhATKmCg4XfkCa
         66M87u3ueqovu2eS2A5TusW7vF7coMcBn8ZgpjyTi9PJKXitqNa1s81ShjPhnsONrK+o
         k/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769425187; x=1770029987;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNxfvlw1oB2el4crQ4TvEj6ef2WAE6hpmRaDCbae0ok=;
        b=lXfEiiV4yYxI4BzL/+md7noMkzm1ijm5v91IfTiPxIDSVvG1s3a3BzUuqOhm6vPejl
         rMXJL4tGN3AUuzL+oTMClWuIK9idKfZN4OKGAM/tFidTPqbfAuddNWtWs4BF4ri9mpBk
         ZZXAJCpyNzCgXSnoobKz0nUEa3TkLO7uoHm5W60IxDTPhzs94miAhGSWhv4NOPS5oqIf
         OnyaQ1mpQ7XnpqAdQHRVrE2K6M3hT5jUCSk1dS6d5KzcOk8Qiyd8I+wx1mmg1cJoBMlU
         K3pUNeeMjAgPXlBsdm/vHbQOfJpWbYCSJj48SZkYdWfPc8YROb+5KhiL57gsaX+ODBXv
         KaUg==
X-Forwarded-Encrypted: i=1; AJvYcCUvmoQRxeuijyNTXjcQ/JrorSuMU1YprFWdgZab0GoKaR9TF1a0B6EFjNj1ThDIAoRJYC2ZF5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0GQQre5pJlXEQNHIBQpHb/bD5ip0EXB31/0h5KHcC1/sP435q
	QtpNMuE8GzYKkMaNNHI2atc2BQS1wlr4+3AGu66ddDl5x2X3cVEGEjQyMDy3olEyup4=
X-Gm-Gg: AZuq6aJ05P1YbhRZO2k96ga104xScPMGr5cAUERuZtYywwJ1qv5TQcav4COEA+aLLCv
	q1gFQtJBtH3h2qXyhp4aMuNHVAtyOw1/YQ6+zOxyrvn7rkWZ2nULRvL89K+JCEnSUAJmiHZ333S
	U1qkxEVdcl5a8UkyUPxdovgGhqbtxltu5Dz+xpaIcMpukwouWuIX83HtgkbHHLk1MmxC3aSmL+q
	RIr+aqBzJ0qTzPSIV61szqIoOEgEPF9vmyMBAbWz9Ktf2WEwdcsmJdtfWzpNdhGPbnimiZ4j09Z
	aM55/7g4m1n2pwA+L2otIUR9nKlvpovmY5p1xH5axCPnUKKUJiEx6E/TqdU5XcJYiKTyDMVBFnY
	K4/aTdCh9jzJHORSwP8vehLNwo3Wwwxd7xD4J1oZm/xQNhJG2Z54QsgdHtMycY5314E6xSa26g/
	i+v8M=
X-Received: by 2002:a17:907:1c2a:b0:b87:7e8:e287 with SMTP id a640c23a62f3a-b8d20e293b1mr307215366b.30.1769425186687;
        Mon, 26 Jan 2026 02:59:46 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b076254sm5237402a12.0.2026.01.26.02.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:59:46 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 3/3] bpf, selftest: Add tests for FIONREAD
 and copied_seq
In-Reply-To: <20260124113314.113584-4-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Sat, 24 Jan 2026 19:32:45 +0800")
References: <20260124113314.113584-1-jiayuan.chen@linux.dev>
	<20260124113314.113584-4-jiayuan.chen@linux.dev>
Date: Mon, 26 Jan 2026 11:59:44 +0100
Message-ID: <87v7goskpr.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253426-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid,syzkaller.appspot.com:url,linux.dev:email]
X-Rspamd-Queue-Id: A30C787729
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 07:32 PM +08, Jiayuan Chen wrote:
> This commit adds two new test functions: one to reproduce the bug reported
> by syzkaller [1], and another to cover the calculation of copied_seq.
>
> The tests primarily involve installing  and uninstalling sockmap on
> sockets, then reading data to verify proper functionality.
>
> Additionally, extend the do_test_sockmap_skb_verdict_fionread() function
> to support UDP FIONREAD testing.
>
> [1] https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

