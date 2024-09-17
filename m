Return-Path: <netdev+bounces-128741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C5897B555
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 23:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A21E1F2224E
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DF815E5CA;
	Tue, 17 Sep 2024 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwE9//Wf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A430F510;
	Tue, 17 Sep 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726609625; cv=none; b=qpJ65hkLkCQM1sA1wdbqjlREGWju+Ov7IpYtrDYIWqnzvsIVcMvXLld1flYp+ehPNlcR2awjY1NhuVgKz0MKBC0e8rN7/nAXnMtZ0nZauPb6dkeevQydQSGA+ONydDOc26+affmbnBHbotMxCwBsnwB1/t1CwoEydN+GXDFG94o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726609625; c=relaxed/simple;
	bh=G7gK2T3EmoVjjiPn+qgHcsxC8R9MHMyB9N15fSvrltA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=AW++bWXH56TYtRhcfX41CqNRXo0TG7na0wnkltyVnsyhzwiyzGvo0fhaxVvN5ChOzhOFrWQ90XUSZ2EYhGbclATvgeVrbuhO+NSTDhKF4tmjAud10VuWxm/yakcVDP+u9vLSbhZgQTU44AvH+Zy+H4DETTNKkUaaMzbhjO3BsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwE9//Wf; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ddcce88701so27470877b3.1;
        Tue, 17 Sep 2024 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726609622; x=1727214422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wggJuHRouFqN+/iKYz5c/+8KGpdjWJleBCPMf+Wamhw=;
        b=IwE9//Wfkzfqgd1ZAnLZZSXNQwJ0HYGHdwfVRGiZNLTxK+wNX7a6chfySgqrovpv5d
         ljd28rOd5ShOxJ4ZM3p+GMD4XriXr73uhRCOWC0SVzuP23cVX0vUGt2jyaP+7r1LFWCu
         7g+XTnY88jK6XW7A1Am4v1RmjaKdMUeNS+7e0PWUX6fAdQMWskh44DrABd7vf4n38cBx
         pbksBULdEEJwsvxwxfyhBZzgGIT5zMP2a2mzZyazEO72QzdI2G50ZXAFwUgL7+uGqqOF
         /Pdb0NHSNRZyIMgs/TeYF1gcpxLOjXi8ZI/kn0syQrTVdzx32RleXtNHGlDoB+6jwnIm
         XsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726609622; x=1727214422;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wggJuHRouFqN+/iKYz5c/+8KGpdjWJleBCPMf+Wamhw=;
        b=ll2jKkiS1INj576hFaEQ+t1As03wSjjaSUdMkTEyAC457IlE2btjYXuxNfaBktQ4o+
         EfY6+eTIQsgbPaG4yJf4vdawFDKjjU56pyta/Jd4aKqiqDix++9xQCet6RLu9odnwUx6
         JOtqMzlju/MKIpGwtg5WZynJXZfEnyYwLh/dih62esGqz0SD/ie1nePefnZFB3GqLDr7
         W+/5jHZyr63RnTLPCBoQCYP2J0OG+KUz6v+24odhWOZjcN7H7qitNJ34y9v8bO6hRu6v
         703E3CO0KZzLdg7j7UZG671Y9TPoD6pxc1jyYdRWYG8o7jwzyI98iFT8Zw9k/HR5KfX/
         yTng==
X-Forwarded-Encrypted: i=1; AJvYcCVkmbpUpohSF/XXdlnOSShjlBqVtuUIPbEX5mBYlsdwsJgmO65rQvvYgCy3txa7JU6T7ZE+nc1F@vger.kernel.org, AJvYcCVppItkJM+EI5QGp3RJtEFGJtK1oifspeRF7Om+6ezcWKJPAkSIWuW6E6Y8ZWSSXXCTDJmJEeI9Z64TZlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5hZBmPDysWqokxk8Bxfm6BzZYpbc7436Q5GTG6j+A1BjtFLk
	K3R7iq7i2LvS2stjQgEakdtrqPTXpRKdNFYmgWMmKXpTOhPpeXED
X-Google-Smtp-Source: AGHT+IHNaWVYrxtjZ5lvDYrz0RPKTv0ukliUfwcc3LZhc2nP81tdkcLEMtd1aCipbVXt0OJv3G//pg==
X-Received: by 2002:a05:690c:6408:b0:6ae:ff16:795a with SMTP id 00721157ae682-6dbb6b3e36dmr183987027b3.20.1726609621901;
        Tue, 17 Sep 2024 14:47:01 -0700 (PDT)
Received: from [10.0.1.200] (c-71-56-174-87.hsd1.va.comcast.net. [71.56.174.87])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2ecff41sm14882377b3.95.2024.09.17.14.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 14:47:01 -0700 (PDT)
Message-ID: <0d3ccb61-22e0-4aa1-97f3-ac4f08a4c20b@gmail.com>
Date: Tue, 17 Sep 2024 17:47:00 -0400
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
+	sockopt_lock_sock(sk);
+
  	if (needs_rtnl)
  		rtnl_lock();
-	sockopt_lock_sock(sk);

  	switch (optname) {
  	case IP_OPTIONS:
-- 
2.43.0

