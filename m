Return-Path: <netdev+bounces-72017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE2685631B
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6748428258C
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073E12BF00;
	Thu, 15 Feb 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VieJJYmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE212BF15
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000054; cv=none; b=DpyoOzKDg7oUQ336NRvFmyOjlUu1Ariv7ru0rNhe2kPHUka9h6w9TS7UhNJomCOZf7Q6SKhkNhG18OxItVwZ9Hnf0zAYi32qvsplIuv2jBMtXv3ClX3naDX49DblP78kLMlLxmstg7cveDfkTS7Jk99jz76NhhxUb72V/+r3Wyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000054; c=relaxed/simple;
	bh=lQjqwfFIpfguek3ysT86icCdMOt9lb9UMoTX5trS2Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IK2I9707hk71YstNk7SKY3+gpHN0269JSxtxIxlvqClQzXoZxefEFbkOBf2qaXSema3hxVWytg82lFh4e8NYyisCMZ4tc9BEEESv95p7pSENhBtmf0ZfhfZgwAGEpkLBpmkijI6Jol91g3Syxfoky3Xae5AjFvbTSprFnAXgs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VieJJYmK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3394ca0c874so461165f8f.2
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 04:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708000049; x=1708604849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29rgK9RLEgR1oboieHyNa5NitwkN9svbE6p8t/OozIQ=;
        b=VieJJYmK8PvbaRalTGxvTYUHAK6yZIIneYyFnZVEm2HzJdwi8L82sUk+cODw+3JnBf
         S0QEMxOvwaCbTS99aRYaSJVUBshnrDuUBhl6c/RXAPNKR2vU+I2dSwII4k/v/hWVA75u
         hEYN2NV9xUVqAIMOvvkfNp8VZnqBOKkJtfwUdVpr7qQYkVPQy3aEZVbfiw6VhDmAu9w4
         U3L8Ac05jMohUH7TXyR7d5C3y+Ee91O1tRVOvhiPyz5yGWhcnX8iwM13i9F7EZRhi6kT
         GhqAi3JHtqItP/H8E4XxKP1kfdqwevSQ2kCf0ASclSQEYdTYInsJymGOdGtgi9GXEav1
         b1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000049; x=1708604849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29rgK9RLEgR1oboieHyNa5NitwkN9svbE6p8t/OozIQ=;
        b=u3AH2QtNAN5yWZJHMdtHwf9y7VDutXUPAkNXmsrpEShj4meC03kx8rAmqW5Ors9Y9F
         6FeNnvmi0kiiJC+BgeU+gQCzvD6alKYv0Y68FNScpQZhAl2h4VO5FdOzfDAPwJrHs8iW
         8ZnhQULwNE726a5lg8oHkdFn8dbMt4uW3YtpSXstAHBifX/C5gkDiId1TcOsCLzXNN8n
         pqsrDFXHOcosBrFI0PBZ4e2x3PRnd6kILrr2jIIcv19TLsbwDnYs55Kd3nsqsax1NPqX
         pnhfYhvKUyNm2l60GuNZs1BLf8gSKarn0xKzhF2+RKD4qHvc1ry1yYFEwtl+x5nOnOI7
         lPqA==
X-Gm-Message-State: AOJu0YwMizeFvqG/h1qNZjJ7I7gGYqXY2UVLahHIbrOLnPiND5PnkYMQ
	SyN7c8FjJo7fHQs/IrSJycxDFKrzO25aWQPUAa8gp/Tk8P1X6b3XkOAuACxrQQ8LjrQq0eMhTeW
	ACy0=
X-Google-Smtp-Source: AGHT+IHyDMpwPwuQP22SMTNssv/4Kje376SGV3PztzB53oUb3kbXkS12a2qHaEWmucobUT9so6gn1Q==
X-Received: by 2002:a05:6000:698:b0:33d:9f:efff with SMTP id bo24-20020a056000069800b0033d009fefffmr1994545wrb.16.1708000049482;
        Thu, 15 Feb 2024 04:27:29 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d668f000000b0033cf4727a46sm1665465wru.25.2024.02.15.04.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:27:29 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	donald.hunter@gmail.com
Subject: [patch net-next v2] tools: ynl: don't access uninitialized attr_space variable
Date: Thu, 15 Feb 2024 13:27:26 +0100
Message-ID: <20240215122726.29248-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

If message contains unknown attribute and user passes
"--process-unknown" command line option, _decode() gets called with space
arg set to None. In that case, attr_space variable is not initialized
used which leads to following trace:

Traceback (most recent call last):
  File "./tools/net/ynl/cli.py", line 77, in <module>
    main()
  File "./tools/net/ynl/cli.py", line 68, in main
    reply = ynl.dump(args.dump, attrs)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 909, in dump
    return self._op(method, vals, [], dump=True)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 894, in _op
    rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 639, in _decode
    self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 569, in _decode_unknown
    return self._decode(NlAttrs(attr.raw), None)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "tools/net/ynl/lib/ynl.py", line 630, in _decode
    search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
                              ^^^^^^^^^^
UnboundLocalError: cannot access local variable 'attr_space' where it is not associated with a value

Fix this by moving search_attrs assignment under the if statement
above it to make sure attr_space is initialized.

Fixes: bf8b832374fb ("tools/net/ynl: Support sub-messages in nested attribute spaces")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- avoid attr_space set in else case
- alter the patch subject and patch description to better describe the
  fix.
---
 tools/net/ynl/lib/ynl.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 03c7ca6aaae9..f45ee5f29bed 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -588,10 +588,10 @@ class YnlFamily(SpecFamily):
         return decoded
 
     def _decode(self, attrs, space, outer_attrs = None):
+        rsp = dict()
         if space:
             attr_space = self.attr_sets[space]
-        rsp = dict()
-        search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
+            search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
 
         for attr in attrs:
             try:
-- 
2.43.0


