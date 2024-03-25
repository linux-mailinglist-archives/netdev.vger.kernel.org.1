Return-Path: <netdev+bounces-81625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6D88A850
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E83343285
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AC130A7D;
	Mon, 25 Mar 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ItB557KN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3466FE10
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374737; cv=none; b=IQopdt9yyvQ1FKo7Q+MRkUL7e+6L0SHA7IB7SX8fILVJyQHF2sCStbYipvTHL84hsRD8p2NhVu/kRrag213iLhkttnpuI6xmIKwrY5Hv2JWVsKx3iY0JZTEAAb0qisEb+BAqA3CuJeAfRnxfU4fSNSaCTGd7mpIU7a1P/T5/clI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374737; c=relaxed/simple;
	bh=svPkrUsWc31u5PxOeTcURerKjA9TBu7K7e3w1kgsNqo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ce+i+75ISuJwS56ZyluR418HoTSoXRqKF+Nxk+xItqjG4v4DQoH5GdHR9VWTLZfNHpENKAFnNJgRMkGmMYvZ9VDvINOtUfphc0TgF/4SZKsZ5oSM6vMN5AYVLAbJIkn7GUOEhfp3KngJf+7GC0aQcB1GNCkK4zo0pvtOKN5URyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ItB557KN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c01c2e124so1983565a12.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711374734; x=1711979534; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=svPkrUsWc31u5PxOeTcURerKjA9TBu7K7e3w1kgsNqo=;
        b=ItB557KNcARm08KdTuyx10BNBt5q+1kn7Rn2lWbeemwIQBzkaWDPLCPNzm/cCgAaaj
         IAGr0TS7y7XYQvcDUpk9Znl0/ez4l4ZNLjKX3J0tALTQ4UAO1Mtf2RCuPoDNgKLrTPUF
         5E5JnAVLaLlF+MzdAVTzwZ4UtI6xfPUI+qZdM/ymwbvQe8h6OvrpkNXZY2gLH0NrxWkf
         23tV+yUqmwOSKbGJEfSj2CxR6ETP0FIU5eLTRzT5jhM7CEQpBK9csY65hmramFPP7Hp1
         iWb6KoK4x1sgEdJhV45B5HVjmbZ2Rzug6hrnJpQ+L5k1srqWKlqv1prrLhVzFC8zcJfR
         PEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374734; x=1711979534;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svPkrUsWc31u5PxOeTcURerKjA9TBu7K7e3w1kgsNqo=;
        b=eMv6BS9cnaFw785PGL9OgSgAk0QLWYdk/nm0Ju+aabPZqbyQeiWHG8rGCpYLDs6K7v
         PzlSCJVoEmh3v+84i4SaWw6UlaHV0YBVKZO8aFzqE+031KU7LbFXs/Ath3s/QJHNTZFQ
         jHDuO3UZPFh05+BE4FPFGB6mwWfDkCnDHh9zaSNk+ykZU1LxXemNsONxKREHYbylGsA2
         cIPQJTwu4gFoAchYPM8iwTJYN25jdg6LPDboqB148Cso3tKhliBCBQStZEBqgQcXMyFI
         WRMgWNFhWRpDN8JzGwrLdBXOTWoflneN+yHJId1cgHCKi2qMtG+KcaSEdOMIQylMc5ZF
         1uiw==
X-Forwarded-Encrypted: i=1; AJvYcCWX9RPFLTu37Uwd9akp4ssLCRwQPveKFVBhoeyl2w0R8GoWqwYxk+x3JGxOeju7jB3ranTVjCH6+Eg89UZ098FIKiFrZsVD
X-Gm-Message-State: AOJu0YyoUEebEUdodKHrkcHImY6rVFiqOXrHP39uYXwdFn1J6EOrPSRf
	LMpzcwIuOXuXQDFvbEtBpFVQEQ+msSEYaJEE3tH2+JE+/oP75/QC2dVaFbuXciQ=
X-Google-Smtp-Source: AGHT+IGmFzRBxjkHf31z6d3Lq36FFy7Enc6jBbimLiq65p2x3hU5JphLJecADC001IRmMLuW5xDSbw==
X-Received: by 2002:a17:906:3b09:b0:a46:ba19:2e99 with SMTP id g9-20020a1709063b0900b00a46ba192e99mr4763483ejf.26.1711374733929;
        Mon, 25 Mar 2024 06:52:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a6])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906090f00b00a46d9966ff8sm3114614ejd.147.2024.03.25.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:52:13 -0700 (PDT)
References: <000000000000dc9aca0613ec855c@google.com>
 <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
 <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
 <87y1a6biie.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Edward Adam Davis
 <eadavis@qq.com>, John Fastabend <john.fastabend@gmail.com>
Cc: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com,
 42.hyeyoo@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, namhyung@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, peterz@infradead.org, songliubraving@fb.com,
 syzkaller-bugs@googlegroups.com, yhs@fb.com
Subject: Re: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
Date: Mon, 25 Mar 2024 14:49:19 +0100
In-reply-to: <87y1a6biie.fsf@cloudflare.com>
Message-ID: <87ttkuber7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 25, 2024 at 01:23 PM +01, Jakub Sitnicki wrote:

[...]

> But we also need to cover sock_map_unref->sock_sock_map_del_link called
> from sock_hash_delete_elem. It also grabs a spin lock.

On second look, no need to disable interrupts in
sock_map_unref->sock_sock_map_del_link. Call is enclosed in the critical
section in sock_hash_delete_elem that has been updated.

I have a question, though, why are we patching sock_hash_free? It
doesn't get called unless there are no more existing users of the BPF
map. So nothing can mutate it from interrupt context.

[...]

