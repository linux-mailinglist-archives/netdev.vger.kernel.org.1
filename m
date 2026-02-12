Return-Path: <netdev+bounces-258518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIueFftWjmnHBgEAu9opvQ
	(envelope-from <netdev+bounces-258518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 23:40:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C81318D5
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 23:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28400305CD33
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F18A3375DF;
	Thu, 12 Feb 2026 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="avI28/bm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D259279329
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936047; cv=none; b=QnxfdEFfkj1aiipXAsEGvnCfoWVcVQzCatIg0v5WUHDfiwMHJonfp8P+6ROypcbkGPj7EpM+hTunq4g28NfAwo4s2lDOHHsJQs7ZH9/F18sqEhJXBkcgMKiZGgNa7/xB4uYfc9JRtZZel9iOzrkoY8OfwN7TvoQ6953PTPm5Bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936047; c=relaxed/simple;
	bh=B30fNyjs/sRZ8qy2TlpcByjrvsb1rtWES5yfvfygjUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f4I/p2a4b++8HqmifUEk4KjsFF13k+nYNOykoDorjnI1/1oqLI0ZdYLqXOdi5Wo14Ti2Z0PW1UXhG3T25sNtDlep9P+028Tj67GXvbW+QK91u1P0CKhCr6mDn9Rz27E6se5OqcnSmjG6gvy50ca72j8DqD9vBxaYzNzCCCqCWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=avI28/bm; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c711959442so168809285a.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 14:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770936043; x=1771540843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWWGIVqElCdFKk2jvTyzzGQRjen7XYqCpsyceyHmbuY=;
        b=avI28/bmMh7RENrx+ypCIBr3DNfhSNVBQjr767mkqVt6OsYeftv051NaCzOJuX83uL
         94SuoGklQPwVmlKAne5ETsUmJaD3rNC96+FsFuwLwNzcUOoW1XI0IDJNgysC/ex6PKyl
         YqX4952VN7idjh6IYpUOnrgIIvoIDOi3Vy33fWyB9Zp5Hct/vBYNGD9T1vw5Q6EMYcQF
         PSg9jXs1xyI617AFn9z7fC60JSzRLs1BautQovCKu27HABIzaF7+oqXL+gqUe0atRcUt
         DFhTdIJtGP65n62WQViYHE6WVFIw3/QGM+OMcjScsl6+clfGRnte/J1Zq9qMxvv2EoFy
         GDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770936043; x=1771540843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWWGIVqElCdFKk2jvTyzzGQRjen7XYqCpsyceyHmbuY=;
        b=oX7v+o3tFo7wjWtt/9tmPZg5SWu7P+yWb0cJZ7W2OffMorBk/evb+ffkf+1OXvfstP
         eWGwdZQCU1bakiFMFWNv6npwYcWMuguJS3hyAuqLnrf6NxB+BO/6ThSz0G1cRyEja+wF
         mxK5TZWj5FOCjI37kz8zsBL576dQz7GGH2y8XGNkeng0TjeBH0Rhq2OVjGDRJWp9OecG
         tZD0PTHZe5f1rTfurhNMjWM9P3F24wsgGMb+h6Ld4m6ksR4w1x5uFuVBrTILvtRrvjcA
         cHxPMBDLYR/wFDEltb9SA0cxZ3GBdU9woGFWLzktrmtUv2U10AxlkOxqng7IQ21I/D9V
         5nOw==
X-Forwarded-Encrypted: i=1; AJvYcCWnhVpgrM55sZDjyQzDiD3mTKeffq9bsRZhslSvJsbLZKgHfMIauZs7QTmsehNqxCAOE68Lqhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQfYcv2LYT78kk/BJigkH+KviZFupVXiFG6uG+IKDad/UfmQ9
	t0LduDhmFNuNFpsWATF4wyrvyySA+X1qIXY/weeqPze4CTYVtaS9svZdtk3di5N2/3M=
X-Gm-Gg: AZuq6aLWSLtA/GFl60EVNh0LQa6o8SDS4DTSE1PAxBPSXOo9HAjYsXYA7KVkxJUYtVP
	K0X4hTqKMY/J95sM6Bzz7uQ5zXJwss6js/xHv0s2+0brivUUfF7B3ajSwQvDqL/K1C2yknf6O6b
	TCwiUMZcVuY1re7D0K/C8XzvZ+WO8jpf7fEUbQcxrp9n4+ZjOeeW1BIvcu0gF/qk7P6J9TuWmu8
	PWOTenOTLHSZzQZ9PoAakGbzyciqDTgZEm3fVkbUpS9cAIUeWtGJRBiO9KRw6e8ua8jN86HWoa8
	HgdHuBKUeqQWlu1ieOkUFIaupWPwjPra74U1xX8kmwIsYsAdyHbsHPDPJgZIEXX4uGrwEN8FUDH
	Vjp7KKQk20uvEn3TBu4NThSeumIkNigWDSuaeu1FiExXYuR+nvaQmtow8NgWONYoERzDCbY6FZK
	ZVFCCtZRlca3X5Z1F9VuAJYdLV+qvL5KKysBaFoB2WKUzWavXJWv2OLHKntvBJi4/U4r3S4VzYG
	DdXcxtlQmI6Pn+gvOrqrwM0MVA5urZ+z8Q5jIJiEs8=
X-Received: by 2002:a05:620a:1a2a:b0:891:7008:f2e0 with SMTP id af79cd13be357-8cb33a58005mr507763185a.8.1770936043069;
        Thu, 12 Feb 2026 14:40:43 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684bb9251sm46363411cf.30.2026.02.12.14.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 14:40:42 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "Andrew J . Bennieston" <andrew.bennieston@citrix.com>,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH net] xen-netback: reject zero-queue configuration from guest
Date: Thu, 12 Feb 2026 22:40:40 +0000
Message-Id: <20260212224040.86674-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258518-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,u.northwestern.edu:mid]
X-Rspamd-Queue-Id: C40C81318D5
X-Rspamd-Action: no action

A malicious or buggy Xen guest can write "0" to the xenbus key
"multi-queue-num-queues". The connect() function in the backend only
validates the upper bound (requested_num_queues > xenvif_max_queues)
but not zero, allowing requested_num_queues=0 to reach
vzalloc(array_size(0, sizeof(struct xenvif_queue))), which triggers
WARN_ON_ONCE(!size) in __vmalloc_node_range().

On systems with panic_on_warn=1, this allows a guest-to-host denial
of service.

The Xen network interface specification requires 
the queue count to be "greater than zero".

Add a zero check to match the validation already present 
in xen-blkback, which has included this
guard since its multi-queue support was added.

Fixes: 8d3d53b3e433 ("xen-netback: Add support for multiple queues")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/xen-netback/xenbus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index a78a25b87240..2ef59b08ae21 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -735,10 +735,11 @@ static void connect(struct backend_info *be)
 	 */
 	requested_num_queues = xenbus_read_unsigned(dev->otherend,
 					"multi-queue-num-queues", 1);
-	if (requested_num_queues > xenvif_max_queues) {
+	if (requested_num_queues > xenvif_max_queues ||
+	    requested_num_queues == 0) {
 		/* buggy or malicious guest */
 		xenbus_dev_fatal(dev, -EINVAL,
-				 "guest requested %u queues, exceeding the maximum of %u.",
+				 "guest requested %u queues, but valid range is 1 - %u.",
 				 requested_num_queues, xenvif_max_queues);
 		return;
 	}
-- 
2.34.1


