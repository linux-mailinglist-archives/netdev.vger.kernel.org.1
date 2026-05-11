Return-Path: <netdev+bounces-286455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIE7JhJ3AWpGaQEAu9opvQ
	(envelope-from <netdev+bounces-286455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:28:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC050885E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27AC03031EBF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A22D46A1;
	Mon, 11 May 2026 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="NBqYZFdh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB602D29C8
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480518; cv=none; b=Z7FDJoIKgTzzpwDqbL8tBaDe3uqiUCsG24bFZZ3wi4MANKpVH6wmkEf76wwaeaTr27DqiqaEo8OHISnuPYyomlKb9rVNMnTfblrUHTH4B/HtrHI1qN/QDnTgYACFrtgMSPd0Bt/RWWTMgAvytBwLdG2i3wLn/j9DNuG/OciXVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480518; c=relaxed/simple;
	bh=A7y3fzKCF+AJo3foiCNqQdkebzrP/Mi0PRjx4WBSn84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r75QvHRThLTm8e0NIOQ5vptBu5hXPEaGFmjM04mUShU8PH4q9Qonv1OAH/67v175G6Bbptw16QhJO6ifJ7XOufuf2pv3my/hQkxu8eGR5k5FUjZgTtdqFeNvn8DtOHXJO1rw/804oa8ZVaPDjZunK6hRvv9mRzJjvGEFjz9OJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=NBqYZFdh; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-132c3280e8fso1418300c88.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778480516; x=1779085316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cLVkZzC6n6tfb7crw+XJ4fgX5lyHGF1s/SBlI8VZgbc=;
        b=NBqYZFdhZq+RQK96TfcXFzU4STpoQTG0rofHiPtAuknXhXQH20V43EsufTJWZnLn49
         PkWK4MXWjFjAcEhxyoHsDS9Gzh1iW7okoTs2izRAx2oEhZLYNNqZFr9lRNp/NBzHNxRg
         4r2afnXeb5cSpUZyFzEXfuxLkeiaKJB0tT5QcDk1MtEVKG9MCfZVDZq62OypBr5vhVO3
         HnKgW+zyLjoPE4hRy6M1Y/dGXySjSl3Rq3kLOKFWccGJs4XfFnJ+lI+EulOHJLqOZWHD
         Pif4qIWzIOOmKDjWKH7Hzd8kZgAm9q5/fWXxyi5/h2tCc86JYwK+DpMP59uGlMhQS7BO
         ZP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778480516; x=1779085316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLVkZzC6n6tfb7crw+XJ4fgX5lyHGF1s/SBlI8VZgbc=;
        b=aXRJ0DDoKEGh75vhhbfuHxjC4gk+cmrFTcCjufExKwHutGPjWSwmMj0sFdIyNWc7Af
         an9TjsS66luKg3ITi27zRa8n+ZqTV2su1EuCwT0zTNMc/egl23C+A+EPIRL4wjoRkZdH
         8vRn2/NAtZg7zleZQAtWIB0umQIWspUz/I2SPGPktjbTCoZrE1B6lvd0cpPEX0nT2Er+
         /6CxfNX/HUzXIMq7gneD2kznvLwfr7X1nYH21PWhow1Tz+mj7VDBbhV0Dh7NhfRB4B2t
         BeyducVUf4jAjfBvUEWep1ZZipyLR7iSpue9N9YhsXpWChyeYRjlZOxoQ4UUeV54q4R2
         Tzdg==
X-Gm-Message-State: AOJu0YwHoplfWwbfst/tUsfcRyQXKsYZaQre4xFceU0nTtGUh/Gmw5Q9
	tuVM1zOo34nhKU1UF35CFY4GaJ+sEC35Dc4594PW7uP+mvoT3is1O4LSmG3mrYjM7JANBiMrh+6
	8zy2DUg==
X-Gm-Gg: Acq92OHIwq5eMMlXFk9vz+cFQj55mgjwp04GYOPZomesU1riOK6l3haFwdods+X5CcZ
	dnO/vz16GXNjFqgr9piqOLqrmGAO/OnrK+Z0mehWkd6IUh26/3VWSmYmCheka0eo/p29cFL0Xs8
	7LykPGsIg716oD1QmPF8Mi1ynsVxkWdo0I3/IINdkSMlCllG817mbkCKGGLANhCqB6Jy+HrYQpv
	APPTxKULnp5MxwtMgl/xEvG2t0XmSZ0oXHnI1j1zZt0GpLVzMjJ7OA7q95c3/YRqV3TnxlrTkfk
	SRKP7BEJf7fRTu25SuRk297SETr2WzuHK6Ft30e+EQa66fep2Sdms80gu0yKQz2ob9hRfGglEv5
	zqkXMAZy9if8QQd1/yma8lSx6+CKNxj9N4yYdegK4VTQ/AA0N4nQ9JBvtDCjh2L93apuLrvm114
	g9HSLNjM7GI3QbExxmaDUONgP2nhq0+thJSANOAm/hseMJOUarzAohpQ==
X-Received: by 2002:a05:7022:439b:b0:128:d24a:a5ba with SMTP id a92af1059eb24-132a83f77d3mr4278742c88.20.1778480515748;
        Sun, 10 May 2026 23:21:55 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210d40sm16083102c88.4.2026.05.10.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:21:55 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	ubraun@linux.ibm.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot
Date: Sun, 10 May 2026 23:21:38 -0700
Message-ID: <20260511062138.2839584-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9BC050885E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email,asu.edu:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	DKIM_TRACE(0.00)[asu.edu:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,vger.kernel.org,gmail.com,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[asu.edu:s=google];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286455-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.028];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Action: no action

On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
populates V2 entries starting at index 1, so when no V1 device is
selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] ==
NULL and ism_chid[0] == 0.

smc_v2_determine_accepted_chid() then matches the peer's CHID against
the array starting from index 0 using the CHID alone. A malicious
peer replying to a SMC-Dv2-only proposal with d1.chid == 0 matches
the empty slot, ini->ism_selected becomes 0, and the subsequent
ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
offsetof(struct smcd_dev, lgr_lock) == 0x68:

  BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
  Write of size 4 at addr 0000000000000068 by task exploit/144
  Call Trace:
   _raw_spin_lock_bh
   smc_conn_create (net/smc/smc_core.c:1997)
   __smc_connect (net/smc/af_smc.c:1447)
   smc_connect (net/smc/af_smc.c:1720)
   __sys_connect
   __x64_sys_connect
   do_syscall_64

Require ism_dev[i] to be non-NULL before accepting a CHID match.

Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/smc/af_smc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 185dbed7de5d..12ea3b6dbc64 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm *aclc,
 	int i;
 
 	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
-		if (ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
+		if (ini->ism_dev[i] &&
+		    ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
 			ini->ism_selected = i;
 			return 0;
 		}
-- 
2.43.0


