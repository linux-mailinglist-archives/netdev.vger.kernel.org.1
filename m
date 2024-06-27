Return-Path: <netdev+bounces-107135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70A091A095
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B31F21BFB
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F656440;
	Thu, 27 Jun 2024 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BIC1aFC0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820DA52F6F
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474055; cv=none; b=dJQi688ZImIE9QsJiuFzt26rtmQno9yMmSvs2fy/aS1Dj+NfoATa3bzOvFY0C62HYSMvyqj13/OoWb/sXELUYCiave2yedVDXsxQHxmAO5kkLbORRa+5LuNEEY/UNTOyNx0T86ssty5Iw+yr/iK6mi3dbGLMINOBtV9Nkifc1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474055; c=relaxed/simple;
	bh=fWi95vLzhBSHmDDtMRbXtxf30DNoW53vGhyYuVrzqMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C+y8NIuleyoNkj4/Kjj8jeO9K7pdibA6Q1rTqbv/P0cAStiaJNs17yn7C7NmHJ8lljrENLkjr9itNpaewQatiXMMTOm8pxc51UcpEx/5ciVKmtFSYse7IP7wY1mOzJ+xfyLLCbAXp972+4urovuLHWFVFjo0fgc8lh0mjd6XmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BIC1aFC0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7252bfe773so517630766b.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719474051; x=1720078851; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2hT4LmI/8tJjnOS+3rgKNA17YV3O1jshhzhEN4RaqWU=;
        b=BIC1aFC0AnIN5qsjIpDg2zuK4+lzoTX0HAa/oJlbhHyVHwkH4IygbZdAHp9oQlirlK
         j4ws2NO4uCg0BkRFCbGsS7X4BuijZ8uIzy2v0NPDTOZag/gV7JpPkld5L1GB8smksU4b
         Xfq7zthesYjsO+yA08F8HECwfZWBbFm2t3ZBH5JT17f03Hxs2DKLEactzORjpjbTD4Zm
         LhGuMVoEp7rV0fajtauAQqfRs83ca0vrUDdMhIDOQyV/IwYRD7CprBkG0YqN+BKR/N+L
         rZIqHPQPBx9ZsGDbg3RV44tXvDY52ETI+5G09RKVFun1j7A+1/Fmz2AmmEkpR/SJENNR
         Q2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474051; x=1720078851;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hT4LmI/8tJjnOS+3rgKNA17YV3O1jshhzhEN4RaqWU=;
        b=tOx3F4+eXntiAdjHLGNOk5FDhDRzMzsl88s5AjxIuybQtOhsWJ456pmSGZUG8rSqHx
         LfTO8dV3ItKgkDrIvBIl4+o1ZMMJfM1zIUzGN5n7Jj4xuh9fqmS3ZnEvnpWEsJ/ivrsi
         SAShzUpjae+gVNLU9qDL53vO5u7bCdluBVMtN5+EsbipUHNNgJgeJGXunjgVUa8JPkEF
         miIg3IQRWnxnfAyIcShLRVDzEZLnOgOWQGylcrIggau12lar4BAogCHN5AGYe7wLoF8G
         QpEfsBHYOOG3XbxDXwjjFVXBoICjSYKRR2oNld/IckFEDXEg5YVnO9GQE/GxvTeXf0is
         2YlQ==
X-Gm-Message-State: AOJu0Yyr8l/3Evje/L/JdU40Oull/lvBe01oI8MY0MbgeKNQVtThUoBn
	XeOe4bcXjsoPwgYT7U+NpX6BBr5xHSDzHtXHYgTDeLGexw542t2gsYgRpYbYeJg=
X-Google-Smtp-Source: AGHT+IGI8TG73XctrF2opGHfZrWfmfVMAAQxhW8CeCW7tqsWehdRASaQu23QBB/rR3HGrPERp08cxA==
X-Received: by 2002:a17:906:9c93:b0:a72:6375:5fa7 with SMTP id a640c23a62f3a-a7263756132mr704259866b.64.1719474050883;
        Thu, 27 Jun 2024 00:40:50 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d71f250sm33200066b.58.2024.06.27.00.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:40:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH bpf v2] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
In-Reply-To: <2301f9fb-dab5-4db7-8e69-309e7c7186b7@rbox.co> (Michal Luczaj's
	message of "Wed, 26 Jun 2024 12:19:01 +0200")
References: <20240622223324.3337956-1-mhal@rbox.co>
	<874j9ijuju.fsf@cloudflare.com>
	<2301f9fb-dab5-4db7-8e69-309e7c7186b7@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Thu, 27 Jun 2024 09:40:48 +0200
Message-ID: <87tthej0jj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 26, 2024 at 12:19 PM +02, Michal Luczaj wrote:
> On 6/24/24 16:15, Jakub Sitnicki wrote:
>> On Sun, Jun 23, 2024 at 12:25 AM +02, Michal Luczaj wrote:
>>> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
>>> with an `oob_skb` pointer. BPF redirecting does not account for that: when
>>> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
>>> results in a single skb that may be accessed from two different sockets.
>>>
>>> Take the easy way out: silently drop MSG_OOB data targeting any socket that
>>> is in a sockmap or a sockhash. Note that such silent drop is akin to the
>>> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
>>>
>>> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
>>>
>>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>> 
>> [+CC Cong who authored ->read_skb]
>> 
>> I'm guessing you have a test program that you're developing the fix
>> against. Would you like to extend the test case for sockmap redirect
>> from unix stream [1] to incorporate it?
>> 
>> Sadly unix_inet_redir_to_connected needs a fix first because it
>> hardcodes sotype to SOCK_DGRAM.
>
> Ugh, my last two replies got silently dropped by vger. Is there any way to
> tell what went wrong?

Not sure if it was vger or lore archive. Your reply hit my inbox but is
nowhere to be found in the archive:

https://lore.kernel.org/r/4bac0a8a-eeaa-48ef-aeba-2a6e73c0b982@rbox.co

I think we can reach out to Konstantin Ryabitsev at
konstantin@linuxfoundation.org. AFAIK he maintains the lore.kernel.org
archive.

> So, again, sure, I'll extend the sockmap redirect test.

Appreciate the help with adding a regression test, if time allows.
Fixes are of course very welcome even without them.

> And regarding Rao's comment, I took a look and I think sockmap'ed TCP OOB
> does indeed act the same way. I'll try to add that into selftest as well.n

Right, it does sound like we're not clearing the offset kept in
tcp_sock::urg_data when skb is redirected.





