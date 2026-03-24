Return-Path: <netdev+bounces-271133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECjBBjWwwmmRkwQAu9opvQ
	(envelope-from <netdev+bounces-271133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:39:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2131834C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D186F308B56E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1666407114;
	Tue, 24 Mar 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXTu5mXb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA5407568
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366254; cv=none; b=iObE/f2IIkDTbjNGd3we73f8KpTz5WQA812Am9yZMxgokpB2JI3CDXZVQ3y7xLUNQtJahkECc8S8EMR67CA54BQrm7Wubmgo0nfu7JLlbA4jsXTDVYsiFmeiw1JLEyDN90zmDVu1FOiGJNKynKT7PbKHLxp7HAhm8MxVSvI/iQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366254; c=relaxed/simple;
	bh=IkRvC5Y3yv7EfUIouHSB7F/B/icLT44ICvi/VwM4Hso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lY5pPfLV8McAlt2lHCt0XH11ldxDzag3UWQP3GCAd5b7Gy/GiNLSCOjmqZXEXc48Xdj1DUIO6Nf41IuCCLRdDc12LG+Vo7/vVLzGaM6qHwUcUQt/2gH2UINDcKr6erCuRqxnoC8RKsn/vJ0Ec93X5rsoToDPMOR2Yiu3cH9DNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXTu5mXb; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-127380532eeso2671528c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366249; x=1774971049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiVBh44Ha4wklKoyn3mQlolcP3I3uICA1aXisZpChwo=;
        b=TXTu5mXbOvgnCld20uPbVAxA90LbgMSKWj4aY/HKBV/gqROu0t4G1KCmZ2aCvNvqKt
         epK7amemp8fedLeQSshBoA7casRlnmbqXULDvFCPfWXcwN9gyTEC75lV7GwREypB9cDE
         VWay9GSgNKSatkkoVjhRuz1aj3H5TSuZaTaO9wjqsEhQ+CBFKP/WjgNuWmH80+HUSLwR
         yXO8vvt20J2zzGzm/lkhwelmWh8UQnbgZC2kCEyw5g4O34Be9y+OTn3arkD4sMn4ZS9Y
         /70AwpNo1VY2VGpFZhxZxaYS2NdvElrxW/ra3sWja7DQ6w4Lj4KA3jQ14WjzA7crqjZe
         WgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366249; x=1774971049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiVBh44Ha4wklKoyn3mQlolcP3I3uICA1aXisZpChwo=;
        b=r6QGhjOwDXPyvClg2Afsy9z6dnYxuw4AWW3aRwhjc+2gMybp5YUOg2isR3BeNV0J22
         pnEI2suylcng/wlhS5cO7LQbXi+7FsAJwfICWbanb4Gcx4xXe5fuwdYaXcypIOU5S46M
         vuUB7Ea++OCU0P0uZlEbMPea2aBOprFuSqPGB4oDPNnpiGsGRKeCEhP+REVl5FKBoQC5
         Xy6FLdj+CmfZHK6kwHJeYwHiSiCI4m0kHpTeJqbtURTrjehqwNHyExBN3Q05SRyoD9k0
         ipEYhNibAb2YU0f6FzLnKttUT/hsjjK500r3hGWp3wFTk6xOmgOtm2Uu1bugPBD/l2Qq
         6jdA==
X-Gm-Message-State: AOJu0YwJoopMy6MwDjTZqwkSvKqMVN6i+t2CYJd3OXFcYKzCT94Yzhep
	vhDJ3FLqI/pBSFLfjsKiubaG6E3ivJJ63BscRUuQARLFMmfgCySbbKuE
X-Gm-Gg: ATEYQzydvy6F3AAn3/Yh86yk9AUYCDwHIvp8rpWX9OCSVkMoxyY48BZh3BefImVlm4n
	YV3FVHtrEsSnTN5twO6yo6t51dZZCLcdIN0sk4jQVwTROZZryS1M5gqay87SKN81mXvsYdbW8IR
	+QRhN9gUXCOcyBpm7c31kPRAtV0u0XRe0oEqhy1QJDrSUKk9e5zlI5vLhEat+VvPo+JXO4ypobZ
	EdlC6NhIXZiR5xPNiZ3uzY1JmhhvOoPc7OIxZ3kH3xSRBSVLGP12X92JsEuqOhb6YkEykpsaJ55
	tUzUy2qUNS0INSe0Q8ojyuInhxwL2VHe2f54Mfj8+g2QUOz1u6/8k8Hm4TVl8y7yYVLlL2tmYxX
	+Kd8OAr1eH5HSJd5UBKcQ7fC0wCgjdCmLRpgbBnx6gKCRDEVmTG04OC9UkGanwh2EuQr46G5/7Z
	TCVOuO/zgh8C2ZJRk7AB2Q/fsh6RCPm/JtE96VMUt5GP4THKGn3ZrKNBa9IvnsBwxDXjwnFPLeq
	Lrpmnwx
X-Received: by 2002:a05:7022:6709:b0:12a:6c84:601f with SMTP id a92af1059eb24-12a726dee93mr8317819c88.36.1774366249330;
        Tue, 24 Mar 2026 08:30:49 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b952asm11668865c88.12.2026.03.24.08.30.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:48 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 2/2] net: sunrpc: replace deprecated simple_strtol with kstrtouint
Date: Tue, 24 Mar 2026 23:30:36 +0800
Message-ID: <20260324153036.86901-3-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324153036.86901-1-ericterminal@gmail.com>
References: <20260324153036.86901-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=ericterminal@gmail.com; h=from:subject; bh=6agocKJaIItyp0/DYq8x5bAU5b3NaTnGQ7RmsnHGIwk=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqt142ldbiBb3nGxexem6LS+7Hnxdq9vf/LzfVUZT 5nv3p2b3jGRhUGMi8FSTJHl7v99c3O9bs25zn04F2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU MzTSMdAxZuDiFICpDjzC8D//4YOUx4Y/r2h2zbm/a9vDWZO7Vn2bfVc+sG7JQ7GMaROfMfz3nsO 2NCFps1Lc2d3NjLcjXQzm9DgUTRafp86w+9q1i0kcAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-271133-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7D2131834C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yufan Chen <ericterminal@gmail.com>

In proc_dodebug(), trim trailing whitespace and use kstrtouint() for
full-token conversion, preserving acceptance of surrounding whitespace
while rejecting malformed input.

This replaces the deprecated simple_strtol(), improves error reporting
consistency, and avoids partially parsed values in control paths.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
v3:
- Split from mixed series into a dedicated net series.
- No functional changes since v2.

 net/sunrpc/sysctl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index bdb587a72..07072218b 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/ctype.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/sysctl.h>
 #include <linux/module.h>
 
@@ -65,10 +66,11 @@ static int
 proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *lenp,
 	     loff_t *ppos)
 {
-	char		tmpbuf[20], *s = NULL;
+	char		tmpbuf[20];
 	char *p;
 	unsigned int	value;
 	size_t		left, len;
+	int		ret;
 
 	if ((*ppos && !write) || !*lenp) {
 		*lenp = 0;
@@ -89,19 +91,17 @@ proc_dodebug(const struct ctl_table *table, int write, void *buffer, size_t *len
 		if (left > sizeof(tmpbuf) - 1)
 			return -EINVAL;
 		memcpy(tmpbuf, p, left);
+
+		while (left && isspace(tmpbuf[left - 1]))
+			left--;
 		tmpbuf[left] = '\0';
+		if (!tmpbuf[0])
+			goto done;
 
-		value = simple_strtol(tmpbuf, &s, 0);
-		if (s) {
-			left -= (s - tmpbuf);
-			if (left && !isspace(*s))
-				return -EINVAL;
-			while (left && isspace(*s)) {
-				left--;
-				s++;
-			}
-		} else
-			left = 0;
+		ret = kstrtouint(tmpbuf, 0, &value);
+		if (ret)
+			return ret;
+		left = 0;
 		*(unsigned int *) table->data = value;
 		/* Display the RPC tasks on writing to rpc_debug */
 		if (strcmp(table->procname, "rpc_debug") == 0)
-- 
2.47.3


