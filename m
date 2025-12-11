Return-Path: <netdev+bounces-244420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC32CB6DEA
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 19:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89FD83052B3E
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDD3101A5;
	Thu, 11 Dec 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJY+rCP7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3423D2B2
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476400; cv=none; b=j7orRl9YBGUYANM66PCw+UResGIB5KsSbLdnSLRJby+1LT7evnyILdD0fqHYo5PRIrYON2Mg8SLeYBht4lr2Pa9b9ncE4T4DSqeHgYyDXJEjWBXJL99kSiTjZyHrDurm8Qo5UAM1gUsZw4X87e/wd0gnWkY5tapnkI4Zv8nTg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476400; c=relaxed/simple;
	bh=xxtOmK9vYTXikPSTDkOMFjuMeEHuFteHGsKUNFxKH+8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OYsfNNRK1gojCIYvWGS5K59aKZdKCD/68Bbptov7jkK8+/udZ2IZIYg3hJXrfu1lWcMtawdhfoC5a5geR8woUDOBdM8iaNYakA2DdjzCv2TqFfcHvs5il+CZfgL9c+hAi73cuyTEnX2NRPomF0v05Rb4pbM7pghlzq+v//feafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJY+rCP7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so449188b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 10:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765476398; x=1766081198; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVuhv5P6hJ1zjT2JDUQQiYg5T2ClxfRdCFokAQQIHv8=;
        b=iJY+rCP7mgLk8SRKB0oihYXVPSi5XiE2kZKyW2wluV4LGvkSd3ndjcokJzb/yIHOpl
         BcHIbN2RwJRgC5KOCJBs6ZJFfIvX0PtmGYHooH3mjo8yjO73jXHojyLuhpQEqoG6ZFGR
         lUZe7wvApqcsHY91YNyh5yvpQIk1MyHG3uJmI30tclPYCedvzUBV0G8NKrxi/8j0LVR9
         gTk6SE78ngGizdecw7DNwMIHL3lzStfu8LSHtxLD6ya/yDv939yyHbo2o1qB/pfE+bYP
         sLmgF3pMY5A1A+yKNK7xH+QJIZEo5NxbJTbRE1viJUroKylm7ZHPLNAEG22/719o36mK
         vMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765476398; x=1766081198;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVuhv5P6hJ1zjT2JDUQQiYg5T2ClxfRdCFokAQQIHv8=;
        b=EPpzp1Z2Xx3iH07Ex3eYn7co9nG2Qn/H4k95TGeCLbebsc4PudSdFoZuh14cg9Pvq0
         4oTat8NW1lLK5CqGLqD6AGlhNJcYoApA6n2QNxu/CVk3PMpd9IcZOrSrtaG5K3tH5bt7
         /hKGffeBHYp+uyMteIo09mbutDLt1r8cUSm+0V/jGZl+heAV2WrJR8a+tyj4JIn7eY7S
         PswwlxoZR+sNTjdy6NJttdgU0B8rQrygPK504cNd281aSseYO3wWzX2MgITayiFZ7JI1
         C32/vs2YGSsH3fwo/b+sg+368V8cv+ZedSLW2sMWmrBDzyokKGLRfIocOgCgk4NFbue4
         +gHg==
X-Forwarded-Encrypted: i=1; AJvYcCWtp/Ivf6YC9cADwtDzF2GLRTO3B3FX53MpI6SSj6EUjWjNCY4mjluI56eEsLE/VgvXuN4AI6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1Pmpy8dc7Dhp1g+h+L7/Ptg2/Ld9oP+9eRuP2+a9D2pbOAz6
	FGfzHNuwRSesL0EM7E5EfMkaPApSWCsq4Fejr2cbBhdQznvLRn6Em7MT
X-Gm-Gg: AY/fxX7oSG5p25ytOc81GW6/FJLmbVrqSVyZ3dRD3mHfcO0AXPlN61xFsnn3/API9+6
	dlFxR1V5Q34hsOjE2goU6poTs1/Mmn5T4sjnVGvbCpThgHQfIeCfH8XJXZ+nZ6iUUefhRUgcCAW
	moIEfWROFxPyPzDrcNw1IIUhAqb702Cgi26IP5dNtk/8QormerurC8gQ892ZAqNPMkAVeY30dvb
	bvATH6wJ6qxhf8fYYUEqj6i4+2wSn5emaYGFwueBlr8ZMZLZ/7S/bybrDKS1ERTN6VsthXPzUq/
	BooCj2VKO3A+QL0FUxfKO1rKl/SRRRw/3edDb+AAT48+s0xLTG5VLPEcNGzTIg4SH6adw0TMXjN
	x6zeFuCTvgOdVnHvLi3V7X2304Uka9HRdcH8rk9wqhRD7c1mZFJoWyXu1btRDGIvP8k3zfqXOUm
	HjlAOolOkxhMDcVKpbO+a1lU4C/V4fphwxQLkjPH57cDNlNnXGeYwb9D/Gjhzo3MdiTHM=
X-Google-Smtp-Source: AGHT+IGTqJDyBQxv1q8zCkfVVLxfu7DrsDf0DisO/iFj11e3b8tNWHBU08c4v15NM8iE9wN+gatQDg==
X-Received: by 2002:a05:6a20:4321:b0:366:14ac:e1d9 with SMTP id adf61e73a8af0-366e33cd277mr7052883637.63.1765476397950;
        Thu, 11 Dec 2025 10:06:37 -0800 (PST)
Received: from ?IPV6:2405:201:2c:5868:663e:4f7b:7032:7e6c? ([2405:201:2c:5868:663e:4f7b:7032:7e6c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a92747d55sm928962a91.4.2025.12.11.10.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 10:06:37 -0800 (PST)
Message-ID: <f69b2c8f-8325-4c2e-a011-6dbc089f30e4@gmail.com>
Date: Thu, 11 Dec 2025 23:36:32 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stephen@networkplumber.org
Cc: xiyou.wangcong@gmail.com, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Manas Ghandat <ghandatmanas@gmail.com>
Subject: net/sched: Fix divide error in tabledist
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Previously, a duplication check was added to ensure that a
duplicating netem cannot exist in a tree with other netems. When
check_netem_in_tree() fails after parameter updates, the qdisc
structure is left in an inconsistent state with some new values
applied but duplicate not updated. Move the tree validation check
before modifying any qdisc parameters
Fixes: ec8e0e3d7ade ("net/sched: Restrict conditions for adding 
duplicating netems to qdisc tree")
Reported-by: Manas Ghandat <ghandatmanas@gmail.com>
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
net/sched/sch_netem.c | 11 +++++------
1 file changed, 5 insertions(+), 6 deletions(-)
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 32a5f3304046..1a2b498ada83 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1055,6 +1055,11 @@ static int netem_change(struct Qdisc *sch, struct 
nlattr *opt,
q->loss_model = CLG_RANDOM;
}
+ ret = check_netem_in_tree(sch, qopt->duplicate, extack);
+ if (ret)
+ goto unlock;
+ q->duplicate = qopt->duplicate;
+
if (delay_dist)
swap(q->delay_dist, delay_dist);
if (slot_dist)
@@ -1068,12 +1073,6 @@ static int netem_change(struct Qdisc *sch, struct 
nlattr *opt,
q->counter = 0;
q->loss = qopt->loss;
- ret = check_netem_in_tree(sch, qopt->duplicate, extack);
- if (ret)
- goto unlock;
-
- q->duplicate = qopt->duplicate;
-
/* for compatibility with earlier versions.
* if gap is set, need to assume 100% probability
*/
-- 
2.43.0



