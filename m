Return-Path: <netdev+bounces-253940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGynMkfoeGmHtwEAu9opvQ
	(envelope-from <netdev+bounces-253940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:31:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D139597C8D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 836603017038
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF20350D6E;
	Tue, 27 Jan 2026 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr+9OK31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACB311946
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531459; cv=none; b=pDMlOSwaplQdeNjZrWg9DKn5bHYSXHO2zkdm2mlv+A92FLm2eaKOyCfGGc4jJNwGB4zDQUka93akVjubn4OceozbFGeuUfnNDmFNE5Gg/h9lcOu5RFYlLJfftR8WnhtXa5Jh+a6eoh+xXwfucDGnF1O+O89YnBughkIFZ2xajMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531459; c=relaxed/simple;
	bh=Ni9cZG+geyV7R5ptEtpT9bf+Z96YeRXMlBWy8S2AVbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ka3PNoTMwiVzKK4wRIKkCdn4v645TwCf/ffrLrgPDM5m1CE5sv+XvJVuAW+iPphgo7F495FJ8ciZX7qWp77LUJebtP1k8cTt+1hi0M1BpAQ+MnJTX54HZSG9FCrMbtbNchtA4L8PxxE0mjcQV12c1cBaByf8X02dTXi4aiZH2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr+9OK31; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7944693b824so36729577b3.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 08:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769531457; x=1770136257; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3HHYD4aeaQa5ff4aHF396cehTuEDTmWYhC92tg8m6k=;
        b=gr+9OK31GZpDs6hmjZjiOxTWfr5wTUJofTfFpb4sgkfMfzWIGBVfNMumd1ah7BTx0O
         OCnBkpVsRZcZB+nka2MD9cCazlEjbT4gjUAgH8sHQHGyVYl/+g496KF2HGwIk9a4ZDK2
         OT1AMWXof/kOQh/VWCClh69YgU4NyMeAzRZN1RfPVSvx5DUBTgTv0kD24TPPD1EwWh4r
         rL864Xj6oVN0jnOiCnewhZDOfQ9bDU95SYJfU04O+AjfjR0CMp9oSYt18JDvZTkb0SQJ
         2oS6vRQguemOHixU947P0FzkD/Noz7qh+nwb0sByOLG1RwaytmyILkKb63KHm+cRsFA/
         Bs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769531457; x=1770136257;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3HHYD4aeaQa5ff4aHF396cehTuEDTmWYhC92tg8m6k=;
        b=HA/kmcZwzU+mtv1Opq9p/G1fqBACSbRJqjt8HMzDi3myLWz7wIrbU0b+NIP+uUCKJ6
         DQLfeBqSsZtC0uvGNANHJri//OfADZOanjOXmiFfO77zL7MB+lEJhpiTNpg6EMu3za/k
         XxYGQCyjNdGCxuDi8zbTZsuL/VIMK8Fx1hkZKVKnv+C0V5UVmZEUnz4putnmUxnScNic
         37+rf3yS71mZ7CF9sxBVFihBeIyeWf/gwk9j2t/f0vhQZRDWskxJ3jeA1OU5Yf83Z+20
         xpVwFd4WhXeAv8nlXkZtz52sJIp1+ME8kdyHZcdMTqQ9ocpHN9P7T5FsWgQEZAJIMwxl
         A1vg==
X-Gm-Message-State: AOJu0YwpsBYKostiozdPHyGZf5jKx4VGCsflX2nXFJsouRsI8lMY72sk
	8F4Tj+uTRJlld/hL8rIcLfMpqrZ21r8zTV1fgYKqSUnyESHHk7cTPiAL
X-Gm-Gg: AZuq6aKrRfxtIJom6VUK6F6iBMEBevDCtMwOmDVnGAq3Y2+SgdIFhAkJdONIqvK54QW
	pheFZrIK09ExT1Ra2wFVftA5PkfZTX6kusGe3t7xjStNTngaHed9/BDsmr1A4i3PH019sRwoTM1
	20SByyX4NXIkEAOkm+taQ011GllyKQyfWXxaTLlDu8avE/lz2q1XH9efgrGbU7Piavd7mVUG30n
	BCMrx927GX7Rgd+3kl52sh69hcNWm2Gjdit8Bk5x2WebDLcZtd8H4mJ9qKNHH9nFIci0Z9kM/LN
	P4Dw+LxpiBONuv4UKmAr9b1whWy4Op9kKYUt8PDNLde+u0hV6FSngIXK1tneA//majGRgAywgZC
	VSMmEbmVORZP0eJUhk3bfumzIBYg8mJecTY7wVNnWlCozZiStttVj6LFio/aCh2qSdLauNC+nPi
	YcY6kh2eg=
X-Received: by 2002:a05:690c:6902:b0:78c:672:9b40 with SMTP id 00721157ae682-7947ac5b3f2mr16260637b3.55.1769531456630;
        Tue, 27 Jan 2026 08:30:56 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2a2cf6sm63595157b3.33.2026.01.27.08.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:30:55 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 27 Jan 2026 08:30:55 -0800
Subject: [PATCH net-next] selftests: drv-net: psp: fix test flakes from
 racy connection close
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-psp-flaky-test-v1-1-13403e390af3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD7oeGkC/x3MQQqDMBBG4avIrDuQRAzSq5Qugv3VQUlDJhSL5
 O4Gl9/ivZMUWaD07E7K+InKNzbYR0fTGuIClk8zOeO8sc5z0sTzHrY/F2hhBG97hKEf/UQtShm
 zHPfwRRGFI45C71ov306BlGoAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253940-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D139597C8D
X-Rspamd-Action: no action

There is a bug in assoc_sk_only_mismatch() and
assoc_sk_only_mismatch_tx() that creates a race condition which
triggers test flakes in later test cases e.g. data_send_bad_key().

The problem is that the client uses the "conn clr" rpc to setup a data
connection with psp_responder, but never uses a matching "data close"
rpc. This creates a race condition where if the client can queue
another data sock request, like in data_send_bad_key(), before the
server can accept the old connection from the backlog we end up in a
situation where we have two connections in the backlog: one for the
closed connection we have received a FIN for, and one for the new PSP
connection which is expecting to do key exchange.

From there the server pops the closed connection from the backlog, but
the data_send_bad_key() test case in psp.py hangs waiting to perform
key exchange.

The fix is to properly use _conn_close, which fill force the server to
remove the closed connection from the backlog before sending the RPC
ack to the client.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
The data_send_bad_key() test case has been flaking in automated
testing. The root cause is actually some racy connection
setup/teardown logic between the client and server in the preceding
test cases.

I have detailed the exact circumstances for the test failure in the
commit. To reproduce the issue deterministically, I inserted a sleep
into the psp_responder.c conn clr handler

	if (cmd("conn clr")) {
		if (accept_cfg != ACCEPT_CFG_NONE)
			fprintf(stderr, "WARN: old conn config still set!\n");
		accept_cfg = ACCEPT_CFG_CLEAR;
		send_ack(comm_sock);
+		sleep(1);
	}

which produces the following error just running two tests:

 1..2                                           
 ok 1 psp.assoc_sk_only_mismatch                                                                          
 # Exception| Traceback (most recent call last):
 # Exception|   File "/data/users/dzahka/psp-flaky-test/tools/testing/selftests/net/lib/py/ksft.py", line 319, in ksft_run
 # Exception|     func(*args)                  
 # Exception|   File "/data/users/dzahka/psp-flaky-test/./tools/testing/selftests/drivers/net/psp.py", line 420, in data_send_bad_key
 # Exception|     tx = _spi_xchg(s, rx)
 # Exception|   File "/data/users/dzahka/psp-flaky-test/./tools/testing/selftests/drivers/net/psp.py", line 65, in _spi_xchg
 # Exception|     tx = s.recv(4 + len(rx['key']))
 # Exception|   File "/data/users/dzahka/psp-flaky-test/tools/testing/selftests/net/lib/py/ksft.py", line 258, in _ksft_intr
 # Exception|     raise KsftTerminate()
 # Exception| net.lib.py.ksft.KsftTerminate                                                               
 # Stopping tests due to KsftTerminate. 
 not ok 2 psp.data_send_bad_key
 # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
 #                                                                                                                                                                                                                 
 # Responder logs (-15):                
 # STDERR:                                                                                                
 #  Set PSP enable on device 3 to 0xf                                                                     
 #  DEBUG:  ...                                                                                           
 #  DEBUG: command: conn clr                                                                              
 #  DEBUG:  ...                                                                                           
 #  DEBUG: command: conn psp                                                                              
 #  WARN: old conn config still set!              
 #  DEBUG: new data sock: psp     
 #  DEBUG: create PSP connection                 
 #  DEBUG:  ...                                                                                           
 #  DEBUG: data sock closed                                                                               
 #  DEBUG:  ...                                                                                                                                                                                                    
 #  WARN: new data sock but no config                                                                     
 #  DEBUG:  ...                                                                                           
 #  DEBUG: data read 20                                                                                   
 #  DEBUG:  ...                     
Traceback (most recent call last):         

The problem is caused by the conn clr and conn psp RPC handlers
running consecutively without the first connection being accepted and
closed by the server.

The fix is simply to match all conn clr commands with a data close
RPC. The forces the trace to be:

 #  Set PSP enable on device 3 to 0xf                                                                     
 #  DEBUG:  ...                                                                                           
 #  DEBUG: command: conn clr                                                                              
 #  DEBUG:  ...
 #  DEBUG: command: data close
 #  DEBUG: new data sock: clear               
 #  DEBUG:  ...                                                                                           
 #  DEBUG: command: conn psp
 #  DEBUG:  ...                                 
 #  DEBUG: new data sock: psp                
 #  DEBUG: create PSP connection

So the closed connection from the conn clr is removed from the backlog
before sending the ack for data close to the client.
---
 tools/testing/selftests/drivers/net/psp.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 528a421ecf76..864d9fce1094 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -266,6 +266,7 @@ def assoc_sk_only_mismatch(cfg):
         the_exception = cm.exception
         ksft_eq(the_exception.nl_msg.extack['bad-attr'], ".dev-id")
         ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
+        _close_conn(cfg, s)
 
 
 def assoc_sk_only_mismatch_tx(cfg):
@@ -283,6 +284,7 @@ def assoc_sk_only_mismatch_tx(cfg):
         the_exception = cm.exception
         ksft_eq(the_exception.nl_msg.extack['bad-attr'], ".dev-id")
         ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
+        _close_conn(cfg, s)
 
 
 def assoc_sk_only_unconn(cfg):

---
base-commit: a8a6c8cc8796ac573fb3902803da28cfa374787c
change-id: 20260126-psp-flaky-test-ea613ea5386c

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


