Return-Path: <netdev+bounces-282862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B4vEgFZ82lfzwEAu9opvQ
	(envelope-from <netdev+bounces-282862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:28:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EAB4A36FC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC8EF300F7B5
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E6426D0A;
	Thu, 30 Apr 2026 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMF3hyn2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB9221721
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555708; cv=none; b=EOgN+54BJFUwJUJqb29jeXqPCLQL5z/jEDbmZIwtmWGba5P+1V23s9zZLV+k//8Qk9PzDUn5XynrQiUsE8DwG20XXBOnNRjC5rlrxpyfRm5RHoLzgs1/9x5gQxNZOhdmCigW/yPxF9C6kllNvdB4CtCZcPtRUp+S0UlMLD+Zdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555708; c=relaxed/simple;
	bh=dMTfBCWjd9C0Mkh/fV3Up94vE9QmfdGahx/8pgg2eUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFbk4dnqDcs6xctXBcaih5WZHUkZg8Ut59yGS8OIz+3WjnXUEm2gxCTdAWsRYTjRAwM6VhQNpSnpFq0EXphIhXF8PUYGVk8ODC7lD53OZaVdTiME95lF/0h+Z5R6kc9SQG2E9Nyx+cEiNRaVyT4QWxxeiONPPZdvUvTE4pSUrDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMF3hyn2; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a60975dc5so10988427b3.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777555707; x=1778160507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8jma2vIWpRhduHXFrOOjuW5x1NS6leEbUAYpZKRvsM=;
        b=BMF3hyn2+x/5EkKvXMatF5nSQsIuE7w66UuGjuOHEW03q9znO41yZnJD4YBjhKOHiM
         vlC3gYmt6NE4jutmLJ17cjJW0C9eCC6Xv79ELoGK0Uckn/2H0jFa8IkYEPFm9Ut9bbHi
         3j6BeW+H1ZHdXNRaE11Cf5cSEuvozNPFO7jLcfJuL7rgavIbZxN9Ve+1IKhliOGmx6Tn
         m9Huc4SoWff74fHoGtdY9RdKlOizioAP6MGIBWgW1fXScQI0cFwO4fNpkF85KMNa9kLE
         SWlxfEpfxT+LwujMZIRjId+y2R0y57cQ5GrBWxapcrOQZj4GgbiN87trFTZlrPHr7g0q
         lUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555707; x=1778160507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8jma2vIWpRhduHXFrOOjuW5x1NS6leEbUAYpZKRvsM=;
        b=AJAmjRTU1kGsbcnMrDNk+nzmpo6lAzu58heTqLAjLHZ8ZDtCgNq8uSEdeCd6aBYHl4
         WyshCH8YP6R9QaKQ8fH8QCJ4O7y/NMesOugp433kHbRFX0CuRXUSRjuZTFeidKipBcd0
         SmhUxvDewFJR0kRSHmUpkbbWBW+HkQrI1HsdBhBvJsFOhWEbUJL67cL3cpeo5mD5DcIR
         M7UHF6y7EAyUyUdB5+lMpUROljVUemZeg6upC85EMqHGrvMCsiyIzRb8oaiRW1/GnQaK
         nY6H6LgFPGlOb8ej6A7czU8YGFTGt+BC+9ZkB9YZaa5DtF8BLdntLt5NM5Otx7Hv1J5s
         C2CQ==
X-Gm-Message-State: AOJu0YzN8jFZnVKvPzgkjNAHCEyJZe2aciXPFa57s6ZhG8jtOCP/91kW
	ehN+2MaCfA7gn8gc5sccKip+DR6Uj3sIuG51dsPark3gWHPcdbYgjlRVL4qBKw==
X-Gm-Gg: AeBDieuAb32N2gltojkoEAaE1dyDVZz6rPTeJ7cQMNAN9n1cqwvV/1LWPIj3jVVn7wO
	Wu7hgH3KHqm46mVRgfkd/D2dAG8Sr4WjF0WeAU0AvM9SsGZ7sTYaXmfIG6MmheZu0S4OSRLTiEJ
	wsWoXcqEz7fiYA3KTvogQgZFMXu3LuQTF3ijz1NOwI/OoPcs0HzlFBas1+/66L1IGw8dfKDgG6P
	DAMiNSKsu8wMc01z2ByIzG546pvj0lQo1dEEg229mEkC2E4sBwoZxwA8cDMI2/KWGOvZ3wTALCP
	AB3W1du7ROIveQpmqe7tUux11+w4WkQIKaNDwO+fA33cPBQV6SMiKcjblGFYU1WqQ8Hjzryqufz
	6cnZQ6Lxs9Q9LMIJEXADcid8SBpgCin0auPECg1eyQcDllTe9I9N5G2+xyWgsTO2/btT1aoOdIs
	dmbV6z9dlEyHO6MPHKKMP9fXoU3OZcx38k6fCkGxtn0PhMnFnMiWqqGX3aBNYaJnulqJ1atd2ND
	wjiLcY0YejthWx5qHkkH3NwzcOyboSUZ+xXRA==
X-Received: by 2002:a05:690c:c50d:b0:7b2:2382:e309 with SMTP id 00721157ae682-7bd52963da2mr32039197b3.33.1777555706671;
        Thu, 30 Apr 2026 06:28:26 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b332fcsm8592957b3.16.2026.04.30.06.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:28:25 -0700 (PDT)
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
Subject: [PATCH net-next v6 1/3] selftests: net: py: support cmd verifying expected failure
Date: Thu, 30 Apr 2026 09:28:04 -0400
Message-ID: <20260430132820.1944517-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430132820.1944517-1-willemdebruijn.kernel@gmail.com>
References: <20260430132820.1944517-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08EAB4A36FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282862-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


