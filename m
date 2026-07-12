Return-Path: <netdev+bounces-306922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n270BvATU2r7WgMAu9opvQ
	(envelope-from <netdev+bounces-306922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 06:11:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D90743C77
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 06:11:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="JRn/Ekcy";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306922-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306922-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 146233004D06
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 04:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB336DA13;
	Sun, 12 Jul 2026 04:09:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65B369D7D
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 04:09:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783829367; cv=none; b=DiIBKgbRQGiw0NtpFJfcgRaY+zxLIQDSTcq4iWk5f0IvSzIEtYl/eAPYH6z95lDk2YQaly39Suh6/ijiG7Vv6n4JRyJl8vwgid3WgLbiKexB0yZryMmR1+FgjPSxRr5f83z68SWzRPqK8StXYb+Q60r9Eyn4bhEGrRQRNHSpHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783829367; c=relaxed/simple;
	bh=VAj6oUe/TU0O43DOvhQx6ZvzmDHg3qu28qW30e0TS1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsQ5bCo9eHAP3uu0dyH6ad1sRr/LPnZMHBT7ttG3GxeHv0oMaCAwvBS1cDBTogaz6cuQKw8RMMjxj6eAA//H7BeeJzdlAgycG/dZQgSImbtqEdwBXqSqL7Co0E4v9RDb+xFm5U43BRcM7i/7u0NwkQ7JWPyxe5PWus5zPoju8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRn/Ekcy; arc=none smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f032b47e3cso15415266d6.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 21:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783829365; x=1784434165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfLzU+Ux3JyzhsCTRzc6rXQZzc52Sb+wpPjR6e6mN6s=;
        b=JRn/EkcyfRJ6M8Qp16TFbox85SAeTcXEsk7FV3P0Sne64W7hqL0TnrM12c3jCFXPcw
         1rPgeB9PtPB5ejzU32hzIaHKPV9y3xSYFnsiqHRpfsEcgeO1y7UpQdQhrqTeOakwRWma
         hh6uWI6QuWD4jxuGPZwsNzTNXTqCQclzAqrLcghY3kjRgPGQ73xnEpYK0d8B5epqVmT4
         Sc+RsLDNqt4S919je58iuqO8wSuMMb5VuK7nEam4+R7yO0v3OdCW7DOQpyEzVbAtlu5d
         fovN/25J/SALI13VtV7s9vQfsthhlHqf+bA+iR7/nyiltehKRKjiiEzrwu7s+bE5sWcw
         gfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783829365; x=1784434165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jfLzU+Ux3JyzhsCTRzc6rXQZzc52Sb+wpPjR6e6mN6s=;
        b=Aw+aoVccztLsTIRPE0XbQXYhkYjy/tr/rxVROzzvE2ehItN999ZT/fUpJXfmyZlU32
         I5JBaGtEx8nrrUUsHFXshx5F2s7jRq5yDcfT1qgIs8orsjzgpiak6pXHvwE6wrZYXhJO
         MIHCy2aXgU9HwvcisHqs49S0pO+3aoqqD9NmuMs/aVhSTiJFb78OHzn+3OtztzmtKitf
         S4qmx4xQaKguW1YyRajskt3AmDP+IqOm4/Cz2wqwOk9f0rRjEAUao0uLy2Nmk2a6oXuj
         bbykSehqRmtzmM8mHYpsTJDlv+8EaaaMclLUgQ7rD+n6Vb0rCRvKrmhTnSoXoy8nuZiZ
         FfaA==
X-Gm-Message-State: AOJu0YzBNBuredYoukUiW8w3YCwoejC0nzChWYfJZscr+vbvG5unK9jC
	OuP6JQN1TTCFbiAETjEy2I5+Q5eZCKCkezwEbNBI7lQHaSBbTt4VD7Nm4teCKbLy
X-Gm-Gg: AfdE7clS79zuLqLDsMDLBZYjjSnv0U/WSUTixVEQ4ktdMBzyEGTuGZmxk6setBntbrm
	WtO7vEibvjn84ktuwIKEU8wBNeKNDNnYpyP2m+gSeiWn/S8HFFWjox4bpoqDCXFeups2BB342bZ
	Nb6ZyePsrSViwBTVmSCuDljWAz6asFQHhWFxZwE771Ed5SJeCZpXE4F8vFGA8Z8FqrK1CFH4Tsm
	HGRb2tjpffAbIXB4TWZAWrVozwRjVCs4m8/LSkURxrq0O8noMtPeOM4Aw/m5jwdkOZVqdpj+uZI
	T+GoFyIrgoM/2jGhOQ5a8o9k7r42SdpqTAl/jztVqxIjdM2nW+lintPT2E20xMY1DwheRz/giCh
	x2o4yCGvvt/HHvalR9x2ocjsC0PKYeJ8XhyPJwNp2fUmbjeWZn7UWtTyurJRk173l1IVhc9BpF8
	okVDNBjXyEkCNrXKiMQ/Okpifq9iExGcrFFeppXP8pq1HmOZBCBHoNdZEP5e/Bq2Sg6lS44CIOB
	TnI5xPfcy3pB+NuNZ3RByRC3bv5Y0s+ZV8FvMVmb9o=
X-Received: by 2002:a05:620a:6403:b0:92e:c117:5ee6 with SMTP id af79cd13be357-92ef2c63c87mr502225185a.82.1783829364696;
        Sat, 11 Jul 2026 21:09:24 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-44-200-214-82.compute-1.amazonaws.com. [44.200.214.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm687147085a.28.2026.07.11.21.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:09:24 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Deep Shah <deepshah146@gmail.com>
Subject: [PATCH net 1/2] ptp: reject frequency adjustments that overflow scaled_ppm_to_ppb()
Date: Sun, 12 Jul 2026 04:09:21 +0000
Message-ID: <20260712040922.6403-2-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712040922.6403-1-deepshah146@gmail.com>
References: <20260712040922.6403-1-deepshah146@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306922-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:richardcochran@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:deepshah146@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,redhat.com,google.com,lunn.ch];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[deepshah146@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deepshah146@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37D90743C77

ptp_clock_adjtime() converts tx->freq to ppb with scaled_ppm_to_ppb()
and rejects the request if it exceeds ops->max_adj.  On 64-bit systems
that conversion computes (1 + ppm) * 125 in s64, which can overflow for
a large tx->freq and wrap the result back into [-max_adj, max_adj].  The
check then passes and the original out-of-range value is handed to
->adjfine().

For example tx->freq = 147573952589676412 makes (1 + ppm) * 125 equal
2^64 + 9, which wraps to ppb == 0 and is accepted.

Reject the request with -ERANGE if either the addition or the
multiplication overflows.  This hardens the max_adj sanity check and is
not a security fix.  It follows up commit 475b92f93216 ("ptp: improve
max_adj check against unreasonable values"), which fixed the analogous
s32 narrowing but not this overflow.

Fixes: d39a743511cd ("ptp: validate the requested frequency adjustment.")
Signed-off-by: Deep Shah <deepshah146@gmail.com>
---
 drivers/ptp/ptp_clock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index d6f54ccaf93b..f83aa44b0a74 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/posix-clock.h>
 #include <linux/pps_kernel.h>
 #include <linux/property.h>
@@ -159,7 +160,18 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 		delta = ktime_to_ns(kt);
 		err = ops->adjtime(ops, delta);
 	} else if (tx->modes & ADJ_FREQUENCY) {
-		long ppb = scaled_ppm_to_ppb(tx->freq);
+		long ppb;
+		s64 tmp;
+
+		/*
+		 * scaled_ppm_to_ppb() multiplies (1 + freq) by 125 in s64;
+		 * reject a ->freq large enough to overflow that, which could
+		 * otherwise wrap the result back into the max_adj range.
+		 */
+		if (check_add_overflow(tx->freq, 1, &tmp) ||
+		    check_mul_overflow(tmp, 125, &tmp))
+			return -ERANGE;
+		ppb = scaled_ppm_to_ppb(tx->freq);
 		if (ppb > ops->max_adj || ppb < -ops->max_adj)
 			return -ERANGE;
 		err = ops->adjfine(ops, tx->freq);
-- 
2.43.0


