Return-Path: <netdev+bounces-258903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGfaMWAvk2ke2QEAu9opvQ
	(envelope-from <netdev+bounces-258903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:53:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3BA144D7C
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AEC030090BD
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A0313272;
	Mon, 16 Feb 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycq6Dfc4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994483128CF
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253594; cv=none; b=t8qDTx3oVcbrbku6VxPASoND6aM1lCGXhrsorUXUrhP3gdVkfX+71k8zVjcerGdAmFQMNAOBGeDozpfjDoiSeSQNCutLvKkuQV8kS9wxhDktmeVKnDCj2d7NglJhirzL0pWXYUIZm0Sj/5IhUwxfsHZJ+RYP7xbQM51vG2zjNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253594; c=relaxed/simple;
	bh=k1OBCTVrSeNRrFsqs5C+Zz2ho34W9SpeXsRrjeRBMnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8I2WK8bLOtW6EQ0Dd0R0sBhwIFvMguNDsBYOMOR8HcI1HOlrLjokwqtOns0AflH8sR84z5lxR4a5REMTUai60VwrEs4R65Y55rKqTTQwr5IYZAZzUZwAmHF+ySUToiU3pyS+FIqiLLWSadnMpo430Up3x8Hn9RjzfFdFXWYmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycq6Dfc4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8230d228372so1982458b3a.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771253593; x=1771858393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BzPXx4/xU1OyhG3PzSrYUGxFAh6ykIsO6RQoTNEOyc=;
        b=Ycq6Dfc4lElKz2kKBhicUjc7SbLK8z3PWUn+zM3AEoZLvn+Mafq1cPR0ISfYdAesql
         pWdfVFqWohMrVVpLWr1/7ISJ/8WyPPWBMZXLINIhZNAr+HtETISGNCE4PBDju23nk1Dc
         rKnjtSQSN93Kb3xdeInzzf4shHYdEZZ/tlZJIFL7zSbWgsKSzIEVQuwse0joLG9uMiNZ
         VvTUqjFweuL6uXwn5vnPjNVRZ99d7/g3lcx9VlsjW0vgWKWgudKh4Drs2OYXFC5J2eMr
         cjA0oe51va9VfQCMuu9LirNbbU7f6rHLuot2qk5+9uarMkCl5c7Huwarjk6gDHWJZcxN
         8p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771253593; x=1771858393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BzPXx4/xU1OyhG3PzSrYUGxFAh6ykIsO6RQoTNEOyc=;
        b=D28m5RWxSqXwr1ZUr3k347k4+HeDft4rWzbrAWUTRditvpNyQpNplj0Qrm5DZEcngE
         xtzXVewcnVhVBfAI6bDxEb6U4vm45sxxq6BXu2FwwSvGGs9uwZ/F8KBOccfp0gE9csuH
         LxYuELKENynJUA2aG0HT+CZTbmy14qwJTJYzTQCpiHhX0Obat5oXdEZcCaj9aK/g9fyT
         pcXA88TQ6zeXWLokbM6Ma638W7c9xH5mYo8b5fPaxLiUgvBn1uzc0l6i4rrsuznubsgd
         y4SzARK+MofqagzKT0dPiKzSQ+6haWSWetEB0eaMI2IcbxpceRtovlM49o938ofOenxP
         VbgA==
X-Gm-Message-State: AOJu0YzMhZ65GWozenp0QchtXoxgoxUZ48SP718BRJXb8uy7yexRw1ca
	ZAv49MbsNyfhIvxFKV0gd7BSjKn8LH+6Fk0jCkmB8HNcHwuhC+1ancLe
X-Gm-Gg: AZuq6aIA2wgd/XEjW31Jt23oPyYN8KOgub7MwFY0N4bXrUm5Un686CoGafHElOp1pRC
	nbBDnj9QZMSP7FGK2XaqH8noHRcZ0y3ZYiOGIQWC0GheCCeg4RDJaX0v7PTqWpwToyQJV2YdXIE
	9qTH/yfxmZUzeOtW7qwTq8tvQdt86UCP2OhG2Pvc7hLabHx8T6yifpF0vBmw5EH4Dh3XJbzkrA2
	plso+EpDtrWbWcV3a3zHl8DRLdmLq6pG454Q5byerYgIPRmqoe57/u3GxoXO2UpcdHLjKeQ8EAe
	2spxBnZcGbMLdUK2X9CnnHZ94qbl0BF+aR7MKDpWKPlwTmz2afG48Pn6AluRG80Lfo3wvhbQYAk
	K6Nl4rdOAP7htLSd1tN6w1my9QeowOSvqxC1FCV/nS9qb1/Iej0/BFPREOJoJxfpFjYQ2W58NCy
	ALoXEAsw/dPWyLIhbPWJL/z6bvc3Ae7dzksij8KdmTktwFfhCYb8ZBVPpCCDgIGY785Fguausfl
	UQ9mQu3G+dUmMFx9j4=
X-Received: by 2002:a05:6a20:9c9b:b0:38d:fa22:8ef1 with SMTP id adf61e73a8af0-3946c718148mr11383953637.3.1771253592775;
        Mon, 16 Feb 2026 06:53:12 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532f211csm7238610a12.23.2026.02.16.06.53.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Feb 2026 06:53:12 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH] bpf: devmap: hoist loop-invariant xdp buff pointer setup
Date: Mon, 16 Feb 2026 20:23:06 +0530
Message-Id: <20260216145306.96108-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,davemloft.net,fomichev.me,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-258903-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anandkrshawheritage@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E3BA144D7C
X-Rspamd-Action: no action

In dev_map_bpf_prog_run(), xdp.txq and xdp.rxq are assigned the same
stack-local pointers on every iteration. xdp_convert_frame_to_buff()
does not modify these fields, so the assignments are loop-invariant.

Hoist them before the loop, matching the pattern already used by
cpu_map_bpf_prog_run_xdp() in cpumap.c.

No functional change.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
 kernel/bpf/devmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de..568477ce7 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -341,14 +341,15 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
+	xdp.txq = &txq;
+	xdp.rxq = &rxq;
+
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
 		u32 act;
 		int err;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
-		xdp.txq = &txq;
-		xdp.rxq = &rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		switch (act) {
-- 
2.39.5 (Apple Git-154)


