Return-Path: <netdev+bounces-281477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DH5Fj3E72lsFwEAu9opvQ
	(envelope-from <netdev+bounces-281477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:17:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47628479D8F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEF5A300D1C3
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46394332EDE;
	Mon, 27 Apr 2026 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrGj8vOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E51E4BE
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321011; cv=none; b=S5fkqepIpXIUBGHg8MxpmnEnH/zad5jk9ZzJzlk9UQjC4xUKVYvHylqMA4v2dvJNdoM0E3dz/6/d3Br0vKX2jGnfHpJPsqUfuDzyG8pQwDU9djqcvdAd7oycLTrma7+XbTdzBRTDTWgDPhKWltzygLUcKHMcwJnQgoN60PJswfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321011; c=relaxed/simple;
	bh=dMTfBCWjd9C0Mkh/fV3Up94vE9QmfdGahx/8pgg2eUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOEuckjktaWNfKRAyosWXQWF15jp8fKX0DZr/Jd3grK6lidGehys7YFFEs8B8N33v0W1+U89qQcwIjjmVdAAtyDHWxGdV/yVK4q/eO4rydoKs0cswFmD+iAQ9Wdtuc+7/U1gIi50vEI2jvak1CSaMB2vxSBtHNVNkVkTJ1U4c68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrGj8vOH; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a60975dc5so113390547b3.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777321009; x=1777925809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8jma2vIWpRhduHXFrOOjuW5x1NS6leEbUAYpZKRvsM=;
        b=FrGj8vOHfFd8kn9CrQnnl7kHBerwcKdQrOA7zwWKsoUsIZxAwHqL/S57hKJQGBKMt3
         l1LF1akcGEmpBTp4vkqkkJ5yjzbJsOAvmW8NrJq3CSGoHGzWjpibUeupCjWRwnQ5MSO/
         su+mWsIiIn1bMOVuAKvvf2SJ/C5LzSS/SbJXyBqi5Q0qOWegXfiTzWbw+iB3qVRUKXOC
         6ldr1eDX610ShLpc7ShMQBov9SGltyPt5HJg68wn2761VM65UnRz9Mjwp6leEToxX4sr
         son+rOtQpiuPz6P/sC+dVr8x+utQT1r4uN54lphrZvrptRP6roa4lNpzaYdX+l2zz1dV
         Udfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321009; x=1777925809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8jma2vIWpRhduHXFrOOjuW5x1NS6leEbUAYpZKRvsM=;
        b=mX51/jJD+SpPXny6UJMLNdjkXfuoOKy9gdfK+DR13EgseJmE4oLvCWaqjd28cWU76Y
         qDgHubZfKV3bCkWtCtXPi5agUCChrz0q9svNUfdtQSoHFTc80b4NIfOMajP+rxA0QO8x
         YH8s4+SBwnfNVYa9F+IRo24092gf2Tv3BmKQtO7mA8RiUV8ufcq/Ed2rPNWjkPNb196B
         jve3NPyAA76DhrshjBV8YlDq2pGClRNYm0HkspkMSh1peEq95V6VHUAPvGQlnO8V8UMp
         Kpm7tIOYS7aXaBJXlhUl0kAUldM3Nh63RYM5crVMADldTMeNv62y8gENkrTCvVRTrJXC
         H85w==
X-Gm-Message-State: AOJu0Yz8GAhDDc+QHhhnPKdc9areiT3liAPC0xpqifF8qNRzR287upx2
	RKWMbK3Kv4z5w6hzhbQ0tduVlRMpjX/du7Zcv/3tbx+uy8tifbSmaYNrG1nGWQ==
X-Gm-Gg: AeBDieuwOLDTacUE052R9336BlHucYCX4gB+S24m4nQBMq9U4P0N4EJMzL0Mn4NiEYj
	dnWpAot7lWtTcLUcgFafFE4jntvIciOOdwwO9f3U8cJvSzTC7H1tFZeE/6rl8WxV5EUBR7BDJ3K
	XEFyuDyMp847UMiuv/ABeHhmuGEUjlndQu29mIiPSj69dx35dOBpHDiFpbs7IrIfUgi7GVPH+fD
	T+xE4t57hDQ+M1GBWSG8/l5N1jt0BpwBlX65cubLt+hL+148pV6zXxCPMmixH+Y66PWut6ev37t
	2Y6xVmkU+dGMmIjJtJRzmBNAtBZJOwlGq25XosJV4TbkjGYerQ6m8jIcfTZR9rawLnt5d3PyH0t
	+EVRjIYL5SB6okDOnBa66bEMMtR5CqPRj9O6qcKdJM0p4gsY9ipg2Aa0hBsqyyq2W7rPROoUhEi
	IjvsnuvBoOptXX3+a6QizORIKelYiPZAO5a5YCLZWqyEr41fB52AiSCzmZRJR84q6rOI8/gLyqw
	6syUeX39RWAilQdw9XV/X1WJtGj7E9HgZOrUg==
X-Received: by 2002:a05:690c:c508:b0:7ba:ef98:9719 with SMTP id 00721157ae682-7bcf5222840mr737527b3.10.1777321008878;
        Mon, 27 Apr 2026 13:16:48 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf05e6149sm1753387b3.11.2026.04.27.13.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:16:48 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 1/3] selftests: net: py: support cmd verifying expected failure
Date: Mon, 27 Apr 2026 16:14:33 -0400
Message-ID: <20260427201640.294694-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260427201640.294694-1-willemdebruijn.kernel@gmail.com>
References: <20260427201640.294694-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 47628479D8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-281477-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Willem de Bruijn <willemb@google.com>

Support negative tests, where cmd raises an exception if the command
succeeded.

Existing fail values are

- True:            Pass if returncode == 0, raise Exception otherwise
- False:           Pass unconditionally
- None:            True iff not terminated explicitly

Introduce a variant of True that inverses the condition:

- 'verify_failed': Pass if returncode != 0, raise Exception otherwise

We cannot reuse False for this, because existing tests rely on current
behavior to pass unconditionally.

Only suppress regular test failure. Python subprocess may set a
negative return code on process crash or timeout. Those are not
anticipated failures.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/lib/py/utils.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 6c44a3d2bbf7..ef31c0ba47fc 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -111,10 +111,14 @@ class cmd:
 
         stdout, stderr = self._process_terminate(terminate=terminate,
                                                  timeout=timeout)
-        if self.proc.returncode != 0 and fail:
+
+        if (self.proc.returncode != 0 and fail and
+            (self.proc.returncode < 0 or fail != 'verify_failed')):
             if len(stderr) > 0 and stderr[-1] == "\n":
                 stderr = stderr[:-1]
             raise CmdExitFailure("Command failed", self)
+        elif self.proc.returncode == 0 and fail == 'verify_failed':
+            raise CmdExitFailure("Command succeeded while should fail", self)
 
     def __repr__(self):
         def str_fmt(name, s):
-- 
2.54.0.545.g6539524ca2-goog


