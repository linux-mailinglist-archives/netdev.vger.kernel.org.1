Return-Path: <netdev+bounces-128743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825AB97B56E
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 23:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A94D1F21C1C
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 21:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63A18D655;
	Tue, 17 Sep 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBARKmXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7FB185B52;
	Tue, 17 Sep 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726610340; cv=none; b=NZaUPlXaWLUSnQvFNcil5ctxAsOJUxBn723IKJei827uznJnK8+xiAtpDmXLL4bUspWTzKlS0Dg7BAYNWy/mMptIdzdRvkAqzRK8QPjGdetUSPwZXvLSWELfQnFuXa7dJMQdsNElXVJtITjUTxXCabj34wK0h0rOyeRMH9n7D6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726610340; c=relaxed/simple;
	bh=9cJOgFiiGLtoUPdlTMqYLkOa1EueiXDWSF9NdCOIfcg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=o+PgoBneDxbyEYdR2o4b/R1aa+s2UzrmmKAY9a6tG6lU3+bUnNwfU3txREyyOHm2OkmcnmlnB0ZMiZyCclDHS/PsUR0zWLOgpHLYaNDOfd1v5hOGUP64XvMWUWrpJ+Z388qeQRDfShwRsPwFs3j0FJf/tE8fSlF3+wZUV1w1CfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBARKmXK; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1cf1a4865aso4018894276.2;
        Tue, 17 Sep 2024 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726610338; x=1727215138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPAORv4t7TTerB08d7touufvRut9iJ3lMHKLBeBa2+g=;
        b=nBARKmXK5W5t6Du5LTJ7MsjVhLcQAvnivOZvr+qYhTK+0hc5oDtzl25JV9zbyW3rZh
         HeszSNJZWcGclntrW9Ln6b+4OAOPcEnMPSlHknyxrLyZ8y0aHz29ZioREI2qsCFACePI
         lI8WA2hFgw7mssmnvn99vmqbu5DzCn0iSW6DgkE8Te5jPvGji8C9uBNJjTUtO2ZSgpWP
         IU+luh7kwL+oZ8OetPmen+7tbnTLGW1/+mFyof/prG5wtmQ8qD5JL2nv/0hZ2PMP/sqs
         OdoENVSHPsSVaURVvmBdZTuSi/RDPsijkei2ZSuHNArR/SGSfbAmsna1NsPRPBPPGAIQ
         SrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726610338; x=1727215138;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPAORv4t7TTerB08d7touufvRut9iJ3lMHKLBeBa2+g=;
        b=Tx3d0mG/FF1EjI1YUXtWHjPFAdDRTZNYD7CASjRk0z5FPPlDRJgygNjW2m5+w6yB7F
         KZ/2xTKZ+IzA1hH1o27qc8t4gHTLTaDg3/OM0eOyZyZJqea3qvlv+TXoAOrV6wux7n/b
         HjF8LDk50c3cyPD3EcfNORUNPADiKuZ+D1Avx0uUFh5RahuD0DeZr1jQ6hzVX0eZ/A/T
         D6ehdVGacT6sqTN1Isdjo7mmKZesRhLgRCNaICDTcqhrRlzlBnc1LLvmFJdU1oMbq/+i
         ZlGgNwHKT9pR0dW7+E8vGimrUQIUtZkgy7bqIj9jjCBL6LABgUC3eUhTRs6fW4fpVqro
         uSPg==
X-Forwarded-Encrypted: i=1; AJvYcCXHDhU5W4Xm13LgI0cCrqlTA/R2v/MKN75/HP+sCH5N7sPGAJdGAuLthmBiuDmUDnb62YZX9wR8@vger.kernel.org, AJvYcCXoJEq0BdAwLdfHwckDchXoXie5e0s2cByB1U5jBp7toG87/LISsaWmCa7aZJyVH/pvcarfJ9RJdHE381g=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfM7+3JwExQZqLLEnwwkg+t91apis41XpIQmt4OTHLlenT/qU
	soKfGDHk5PRfW5SVc0eQ36RDI4Qfm06oimZs509zOtSEyUXcEvH5
X-Google-Smtp-Source: AGHT+IGZiE6rprx/ozNbO4PXmKS5X/VgE19RKCBfFWy/Bw456VC4tsvhC59fNIimCHCqaFHtwdBcbw==
X-Received: by 2002:a05:6902:1a44:b0:e13:df00:2830 with SMTP id 3f1490d57ef6-e1db00ec289mr10287356276.30.1726610338209;
        Tue, 17 Sep 2024 14:58:58 -0700 (PDT)
Received: from [10.0.1.200] (c-71-56-174-87.hsd1.va.comcast.net. [71.56.174.87])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1dc139b147sm1669985276.56.2024.09.17.14.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 14:58:57 -0700 (PDT)
Message-ID: <aa2b8eb7-a60c-43cf-ae70-9569dd7b9e85@gmail.com>
Date: Tue, 17 Sep 2024 17:58:57 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
Cc: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org,
 dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 schnelle@linux.ibm.com, srikarananta01@gmail.com,
 syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
References: <00000000000055b6570622575dba@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
Content-Language: en-US
From: Ananta Srikar Puranam <srikarananta01@gmail.com>
In-Reply-To: <00000000000055b6570622575dba@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
2f27fce67173bbb05d5a0ee03dae5c021202c912

Fixed the circular lock dependency reported by syzkaller.

Signed-off-by: Ananta Srikar <srikarananta01@gmail.com>
Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
Fixes: d2bafcf224f3 ("Merge tag 'cgroup-for-6.11-rc4-fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup")
---
  net/ipv4/ip_sockglue.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..a8f46d1ba62b 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1073,9 +1073,11 @@ int do_ip_setsockopt(struct sock *sk, int level, 
int optname,
      }

      err = 0;
+
+    sockopt_lock_sock(sk);
+
      if (needs_rtnl)
          rtnl_lock();
-    sockopt_lock_sock(sk);

      switch (optname) {
      case IP_OPTIONS:
-- 
2.43.0

