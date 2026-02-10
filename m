Return-Path: <netdev+bounces-258019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELyVJembimmDMQAAu9opvQ
	(envelope-from <netdev+bounces-258019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:46:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E3511668B
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD1330413B5
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582792E228D;
	Tue, 10 Feb 2026 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="M3H0iwuL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADE2E2DF2
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770691427; cv=none; b=HbNHQZnhERcjjaRCr3KIYKp/+4TLA3gE5d46H1vV+qwe8yfConBFBysDQQdr9hpMNEfIw0UJ+6gI6iCCUafW5ERU+XZzZqP0BaVFdBxCx5lG01sSaLUNZOWGtbpVm5wIBH8JpMUR+V/ZvMs2nD/Qnu2QhK0SsqazWNTHTJIFeT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770691427; c=relaxed/simple;
	bh=b4xPWImOTlDajhrUG7eXtH2aZH7I0nVFi0jycnY3IPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5ckXO8SXgSrYdjD+fP/EoFYs257MQ0bauv4djOzeCis2sMnrgEGl4B0I9k32jf/uV8PMXy47i2DdbM1ILZ21vxEvtN8nrTraw88extXVH4ALk+ZklO3Sg3XXbD4fEDXmo3Wyx6rqfPg5QrzWGKyx8N3haO4E/OpBnAfyg1oadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=M3H0iwuL; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89473dca8aaso51131076d6.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 18:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770691424; x=1771296224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qvKGjQtrDpaNiZmMQcUWKgx5WOmlV0d55tFNLhvEBPw=;
        b=M3H0iwuL1syI+nG/M3a/AR6NS6HRLuuNbAF4IS61EgIGtMp0IgGqpzlqjR4JTctgl+
         Uab/E7KhfhAVk32VLZZTlavxezyGdpZbCvGVchQ7w6kyOAmEBiCzXFmcvTsFCNi5+Uf6
         1ZEulBwbljoUdjWob8AR8NUBX2RWifva3bWo1N8gC9VtA30fz0dSWcDT0NhP1MCL+Xwn
         8tyEPUQdg2OvpeWlEfxfstAFOD9VdEkXczHaqNIuJPOL+LIO1/dosZFU5w7aXZkIPp56
         MN1ckPE2H1U8n+TmwBOHUxK1jmUNzp1ehmfiGI+AxZRc00/VHNgezZP6zT+n95vprDS0
         yuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770691424; x=1771296224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvKGjQtrDpaNiZmMQcUWKgx5WOmlV0d55tFNLhvEBPw=;
        b=EAP+xTsYTvoSfD4r6SuNeVzaVfVQIZwijwdAfcpV0x+qBKt7E8M9vpB1z6lOuSsbwA
         hGi6YI559coR0ESd40jWPyR+FY48DzirB2pB1zbUIVJnuBG5ZLAWUASQhNCQ5BviA+qG
         OrDBAg9WUlkNmZkYWn9U9kQXFXs5eqovdnxCsk1YLvB9rF8BifLEruxkII8NKYYsrvYW
         71HJxXg8Cf4mIV8KwlFEk6KEydH/3ykrBo+hWLpShKC0dyuMdcCJswRTiaELXx4QxxjS
         s+nyzG6snYdafJkUkt6hsNu3jpVXPWtz0gucI4B2Q7fMdITjF4SXS3UrOvvw+wbJe9Bb
         SeZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZRkI2yGvqfcS0iidIqehOk/iY+XnbGbhYejCq/HDHsHEs2idTGdNpw8T8X9WW25kLMujGIzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdBCqR02thHHwYQiz+ODA7QUJMZFICcA4oGEz4AdBKd6M34RT
	HpVQakTYTc1iVgkSUknVFxXZCouEmjplill4nlo7xMsSsGawc7+AsiyrGlY94QC+O3wJnIN+neV
	Zqfox
X-Gm-Gg: AZuq6aL0zOUQhpNdxq5p2Wtom7AvG6iy0aRmZGvswR25t+qxXrBeVKawwdFXypI6/Sh
	5hdIfFZrDHnp70P2gvJTRFU53/xQpRxhxnQXpebk/HHZvPxvNgS2TCXQq8M1ZXvXQLZzY3TD6Pq
	qnNeWM9Yk88VwCrt4wwlLpqrk653A82uFDnbjg47TMJqF46GqsTrA1J2rvpxJOZk8CRfZrDaFBM
	NX59DRNcFdT8S3VzWlKJC0uzqV7FKuaJvz0DJKUbiOFgSAA9HfsWtFg5WDNPYwfvlyY7cqgeY69
	6qp3zq78dC19lSCAbp/6CMSxdUdRVMkJ0tHNwqfmXfaxY0YWUqBchfDvNaqS+90S9IeHUzDsWbY
	aiJOmQJusvChzJ9WT1s/HD+pLVvfC3mwGcEuTvBy7ewSRomgZeBtrDXO10YQLJUKnQZECP73cM8
	Jt/Rpepo846TAXC9VeTd19ECtEemlZSSmraJr74UOamvlHgPEQvzSNqToaeHXREzOTba7c0AWPu
	wymZgTMhYgxxCk0in0DgCOY1wponAr3iuH5ulGO0+U=
X-Received: by 2002:a05:6214:518c:b0:895:c06:8cbe with SMTP id 6a1803df08f44-8953cfa19a3mr211943866d6.69.1770691424012;
        Mon, 09 Feb 2026 18:43:44 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf5b2ddsm88416486d6.18.2026.02.09.18.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:43:43 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH net] net: usb: catc: enable basic endpoint checking
Date: Tue, 10 Feb 2026 02:43:41 +0000
Message-Id: <20260210024341.3216007-1-n7l8m4@u.northwestern.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[u.northwestern.edu:mid,northwestern.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u-northwestern-edu.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F3E3511668B
X-Rspamd-Action: no action

catc_probe() fills three URBs with hardcoded endpoint pipes without
verifying the endpoint descriptors:

  - usb_sndbulkpipe(usbdev, 1) and usb_rcvbulkpipe(usbdev, 1) for TX/RX
  - usb_rcvintpipe(usbdev, 2) for interrupt status

A malformed USB device can present these endpoints with transfer types
that differ from what the driver assumes.

Add usb_check_bulk_endpoints() and usb_check_int_endpoints() calls
after usb_set_interface() to verify endpoint types before use, rejecting
devices with mismatched descriptors at probe time.

Similar to
- commit 90b7f2961798 ("net: usb: rtl8150: enable basic endpoint checking")
which fixed the issue in rtl8150.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/usb/catc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index 6759388692f8..e92773cbf5f9 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -770,6 +770,13 @@ static int catc_probe(struct usb_interface *intf, const struct usb_device_id *id
 	struct net_device *netdev;
 	struct catc *catc;
 	u8 broadcast[ETH_ALEN];
+	static const u8 bulk_ep_addr[] = {
+		USB_DIR_OUT | 1,	/* EP 1 OUT (TX) */
+		USB_DIR_IN | 1,		/* EP 1 IN  (RX) */
+		0};
+	static const u8 int_ep_addr[] = {
+		USB_DIR_IN | 2,		/* EP 2 IN  (interrupt) */
+		0};
 	u8 *macbuf;
 	int pktsz, ret = -ENOMEM;
 
@@ -784,6 +791,14 @@ static int catc_probe(struct usb_interface *intf, const struct usb_device_id *id
 		goto fail_mem;
 	}
 
+	/* Verify that all required endpoints are present */
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(intf, int_ep_addr)) {
+		dev_err(dev, "Missing or invalid endpoints\n");
+		ret = -ENODEV;
+		goto fail_mem;
+	}
+
 	netdev = alloc_etherdev(sizeof(struct catc));
 	if (!netdev)
 		goto fail_mem;
-- 
2.34.1


