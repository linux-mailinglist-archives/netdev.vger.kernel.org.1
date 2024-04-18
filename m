Return-Path: <netdev+bounces-89020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578B08A9410
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF600B21DB1
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D6077F10;
	Thu, 18 Apr 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5ahAiP7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1D53E3F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425578; cv=none; b=PUw/ncJbfkkgT4P9CyoXAXAViWPpXtbCleK3AAvvntwOJvxIWEef6hjOdeYwMeOGKgu2I9jkYiD5XE2nfmQ6jIYKYRF10CMjCtpqAg8HpOrc/xXRL8TUY7fe76NK86gUMFaTR6vWFGc97sHOodv2vZZlHG+58n3Xsrmq6ZpWfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425578; c=relaxed/simple;
	bh=o1C4rkkaRhTIn8JKPJwSZY4szztCcHHb3B+Gqgn7Lf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YQe+MWMqbLCCZZ/TpUKcnem3jrhGDqIpnYqJXz5r/pBvO0jjJR4kqDBcNm29M+2orMlI7u5+p+peGnvG88+HpeZI8CiEcNQA0GgYAoPJIVeLyWtKo62PjkyzVjEYJNLgU+NTFZlThrnhqbgvQXNQZXGnorD5XeGROItpPoRlRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5ahAiP7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de4691a0918so603051276.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425575; x=1714030375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2eTMFAEJNkYixMviBRtFiCkX59OC1AUV6clrpwB4sk=;
        b=F5ahAiP782aNdklTiepRv3LeTZrM8IshnhMtgXDBWeTkIORQyWNZrC3lOIfsDSKt4d
         FedVxykQqS7jrPHPLPG1lGtT9YDHm77AZgeA+CEZyXSdYcKBGov6mZGygsO09c8vziEf
         GK1xtMcQS43Tu3hra+HLmLGddtLBFU7tZ6uC/7vw6R7/A4C0k4WD9D28i8SYqWj4I2OC
         YKxzvqs0cts+4PdfUULUJsn7h8H+pAt93lL6HrnZSNfOBdCd0EJIy18+zC13S7l2V+l5
         H4yMQM5IJcbw6/QRk+713sRVLCBFWe24MXJonTJEirk2AJVnJWwK7FjEj7+WK+uHQT7x
         EWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425575; x=1714030375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2eTMFAEJNkYixMviBRtFiCkX59OC1AUV6clrpwB4sk=;
        b=cnfxfNpNCcO6m4dwC+JQwqBzFw8tjYLAJYDHnwOZzUo1ojsFgRduS/9nARUlvv8/Y+
         F/HkXD6bvnqgL2m7YxBe8pkBUDaYHL3AtwflIdJXIRhb+w0UzuUJ4i8VXhq8nCG5A5rl
         M+81bAs5ClNfpgSDi6mv6QrXT5vkyYETiGBthRLiiOFZZKtW2907RfwJw/AF7M2KTB/u
         +2SgAuso+4mRUqf1aetwrhsmxfsfC+rdkdOblEfqOJPyipDf8Vm4kW9EyHF/vywPqLBy
         Qay+STWhKmrQ6h9PRwEngbf8YM0lggEoEOu3AAYYX6xY1vK7O5zWffGZLoMiTLhFfzo6
         Cq6A==
X-Forwarded-Encrypted: i=1; AJvYcCX27TJTD4O7HTYxFNKkH5q88eVH4g5j1VAhX17nh9F0sLHHEZPBnA3rKAH2yvPR9PxZ2EUG8diRTsTHY4+N44MivZEsU6Nv
X-Gm-Message-State: AOJu0YzspD5MK1XL4J1ZsO8dyqluzD8gdngDg59YfThGTI+GSCLwzRVX
	zVS/Nu3e8YywhTipn2TF8qaGc6p/uZ1f7wCyh3FWx2zIp7hOCzfHuytEKBnM7t0exie2Ud6zi4j
	7QWHpLgaqMg==
X-Google-Smtp-Source: AGHT+IFH59AxRrWBkRPNTeChaBvTZL4dve5kvy/nSuVhcqBVrBxiO/FVIp+nqFF1JVAjYp9JVEdTmkwwcv/41g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1001:b0:dda:c4ec:7db5 with SMTP
 id w1-20020a056902100100b00ddac4ec7db5mr449112ybt.4.1713425575648; Thu, 18
 Apr 2024 00:32:55 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:37 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/14] net_sched: sch_cbs: implement lockless cbs_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, cbs_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in cbs_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_cbs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 69001eff0315584df23a24f81ae3b4cf7bf5fd79..939425da18955bc8a3f3d2d5b852b2585e9bcaee 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -389,11 +389,11 @@ static int cbs_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	/* Everything went OK, save the parameters used. */
-	q->hicredit = qopt->hicredit;
-	q->locredit = qopt->locredit;
-	q->idleslope = qopt->idleslope * BYTES_PER_KBIT;
-	q->sendslope = qopt->sendslope * BYTES_PER_KBIT;
-	q->offload = qopt->offload;
+	WRITE_ONCE(q->hicredit, qopt->hicredit);
+	WRITE_ONCE(q->locredit, qopt->locredit);
+	WRITE_ONCE(q->idleslope, qopt->idleslope * BYTES_PER_KBIT);
+	WRITE_ONCE(q->sendslope, qopt->sendslope * BYTES_PER_KBIT);
+	WRITE_ONCE(q->offload, qopt->offload);
 
 	return 0;
 }
@@ -459,11 +459,11 @@ static int cbs_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (!nest)
 		goto nla_put_failure;
 
-	opt.hicredit = q->hicredit;
-	opt.locredit = q->locredit;
-	opt.sendslope = div64_s64(q->sendslope, BYTES_PER_KBIT);
-	opt.idleslope = div64_s64(q->idleslope, BYTES_PER_KBIT);
-	opt.offload = q->offload;
+	opt.hicredit = READ_ONCE(q->hicredit);
+	opt.locredit = READ_ONCE(q->locredit);
+	opt.sendslope = div64_s64(READ_ONCE(q->sendslope), BYTES_PER_KBIT);
+	opt.idleslope = div64_s64(READ_ONCE(q->idleslope), BYTES_PER_KBIT);
+	opt.offload = READ_ONCE(q->offload);
 
 	if (nla_put(skb, TCA_CBS_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
-- 
2.44.0.683.g7961c838ac-goog


