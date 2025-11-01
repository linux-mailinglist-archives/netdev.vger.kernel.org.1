Return-Path: <netdev+bounces-234838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC843C27E1A
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 13:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C2B3BF8EE
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DFF2BDC05;
	Sat,  1 Nov 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI8oYo/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639942E2DDA
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000501; cv=none; b=FgAKm1ukNOfoF0aA9oamn5l4PoTxMZ/n3mtzDzPmDjGk+NB8FLqSKgjAHukf5JLpXBtFn7yS8eqjhg7yv+vHO8eJ84P6VnPzPq+4B5JqM4lALe33CWZ5NFL6ZcQWn00ceWL1T2/LpP8yEBM13YmXokspLT25HhgO3sZPrxuCtpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000501; c=relaxed/simple;
	bh=chT7ZuJdmZz2+odZdjWBl1QPwpZX5AyyiSBmBy+TRRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjCipBG67ZBci7VR5zSdLdsWkWpz6Rx2GhMArkA9cqptvvYOU4SttdRe7AnHOsOpxCz+9jMl0khEY0GXTu46lWbZLv5s5/cao35Kb6cQ1w3Os2CdvO4w5Fwu1Q6A2u5Ca2djsCONDNRQVTRsAOCvZARszV/dWBMnEw97UAtmPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI8oYo/Q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3404904539dso525633a91.2
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762000500; x=1762605300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDRT+NEI4paVe6C3WZWM0dixLtLFOOKY3SXggLATTdE=;
        b=KI8oYo/QLWsn+hDSKqleoz+sPr2vstS6qoomYQ+B1wEKKSJdPW1/wDogvSchBMoC13
         r0RFnrEPBHln01PTB2S1KJasxAQgJqmpEB56be1AoQDIwGxyk7jUGA7eHd6Wn3a0N4Eq
         evh/k7Wz6wPyYWTZhdfFZ59PT1DtKRdcdJ+1JYuLsRZWdf2lnRXw6PxTSXqlf2Qda5EZ
         OC2OsLkjslWHtS0ruJOitXNNKwcGSiUK507MSomOu5ytfK43J2oh7eba+wAdVGwP8ADB
         LjXPzv1RmpiWuK7fvmbbt/TRXIzbSv5qZ7Jwh32+kDpOjbcNS3rV4AeUQFkfGgGsXP8+
         trAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762000500; x=1762605300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDRT+NEI4paVe6C3WZWM0dixLtLFOOKY3SXggLATTdE=;
        b=uK3o9xBzxHDb2K+/OLMGQEi0Sy+jxCQ6zOnfNtqGI7qr6jf4zQcEY/4FXAbnoREohn
         HYLXGnLcjIOlM4lnbpZJtS6pEQvWOCr/Y4VY7oPV1pL60GCXLXBU7aXx25fXqeX6Vqjx
         YjZx3KkDEvye/KV96ARaK93qhKoaIX+h1iAHg2mtsDV4pyImFltvw7Nqd4rWZ1PS1MP0
         Fbi5Hrn+5oglBpri/tEbbpgFusUTq5JiF5DYe7g01aBPONsJVkhth94AltuKUNhq5bXB
         nPOfJAVMsIuWTYkene/4sE2vS+p3xoIxelg9CTfgdCyFbhMSce7dzda6RuTzWyA23ZBz
         WvYA==
X-Gm-Message-State: AOJu0YwHAmddG4LD5p+b1w7wyRAT4WIRiVPuW/+TRzTCLV0+Q6GdC33M
	OaJzUf0+hpN4j55+M5F90rKzyE6Bx7zCPS/cgzq+BZCvPthczgVawFcj
X-Gm-Gg: ASbGncvxfPv283r1UgnTLNOC0srrJ+mnUaB4zJiVFZvFmH0va7iANM4El3+SXgoo5XV
	I28EBjWLOgAXBZKt5M5WJ9IPRWvynG6Ig+Gf70Nm0U60L0imqV0/OChBhIGbXV1KYHj5bli/VUv
	P2ydbenqntupbKGh1P4TsV4aEKTghsGEIBJcra4PXgHUSc1vgesAX23CWpori2XIPDSlyMxRKdN
	K/PAXcFsuoEt6l+Qczhvx80UO1Od9q2BYsJHinlvtKey5V/+U3+XPrduNvurw7C8zKm6BzpODw3
	Dw9L6VHkd6KZfIo+oT8P2nax3I+x5ceaksaVLfT/DfV5fWv2vzkDkXYe59zZ5/5En0iRyVCJCxE
	rzIYmYSY2NuCa09C9sk9dqTgPvXZvLw1uCuWi89ekV4OPO8rtbqe8RIk8M7Cq8G+iymgSUKbHd6
	UqB+xYVvFeyu+XlgBRIkLCA5jWWytSPUeEfZ1pG0DE
X-Google-Smtp-Source: AGHT+IEIpXxPwq5sEDlkOcaHuDBQuKRHH2343dqIJklYh5KJcqhNIUb8e5LlvsFd0ntOyTjMFiZdcQ==
X-Received: by 2002:a17:90b:180e:b0:332:3ffe:4be5 with SMTP id 98e67ed59e1d1-340830b422fmr4786530a91.7.1762000499628;
        Sat, 01 Nov 2025 05:34:59 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:10c:9fcf:a95f:918:2618:d2cf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm5214017b3a.60.2025.11.01.05.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:34:59 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Sat, 01 Nov 2025 18:04:47 +0530
Subject: [PATCH v2 1/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-infoleak-v2-1-01a501d41c09@gmail.com>
References: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
In-Reply-To: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 Ranganath V N <vnranganath.20@gmail.com>, 
 syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762000490; l=2056;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=chT7ZuJdmZz2+odZdjWBl1QPwpZX5AyyiSBmBy+TRRQ=;
 b=QhYz129puv3oVszl5c9tMRyDFQV70rx+6GTRyuQ2lTGOmSohCfnYhkr7dhtyfXGznRR41o9n/
 ydrxrEdNIyCBMzus9PmjGIv2Da7KLzDO3m1QO4QL6o08Ea53pyn97Pe
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix a KMSAN kernel-infoleak detected  by the syzbot .

[net?] KMSAN: kernel-infoleak in __skb_datagram_iter

In tcf_ife_dump(), the variable 'opt' was partially initialized using a
designatied initializer. While the padding bytes are reamined
uninitialized. nla_put() copies the entire structure into a
netlink message, these uninitialized bytes leaked to userspace.

Initialize the structure with memset before assigning its fields
to ensure all members and padding are cleared prior to beign copied.

This change silences the KMSAN report and prevents potential information
leaks from the kernel memory.

This fix has been tested and validated by syzbot. This patch closes the
bug reported at the following syzkaller link and ensures no infoleak.

Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Fixes: ef6980b6becb ("introduce IFE action")
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 net/sched/act_ife.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 107c6d83dc5c..7c6975632fc2 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tcf_ife_info *ife = to_ife(a);
 	struct tcf_ife_params *p;
-	struct tc_ife opt = {
-		.index = ife->tcf_index,
-		.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
-		.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
-	};
+	struct tc_ife opt;
 	struct tcf_t t;
 
+	memset(&opt, 0, sizeof(opt));
+
+	opt.index = ife->tcf_index,
+	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
+	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
+
 	spin_lock_bh(&ife->tcf_lock);
 	opt.action = ife->tcf_action;
 	p = rcu_dereference_protected(ife->params,

-- 
2.43.0


