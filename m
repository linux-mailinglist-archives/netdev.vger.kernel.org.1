Return-Path: <netdev+bounces-298896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x3XZIVPPLGpwWgQAu9opvQ
	(envelope-from <netdev+bounces-298896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:32:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBD367D9D7
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:32:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ldFT21cP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298896-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298896-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C71893039380
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307AB38333F;
	Sat, 13 Jun 2026 03:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD437F8C7
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 03:32:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781321523; cv=none; b=QP98RvIdvD4iEbqtnhpDCiHMDmTqTAan3PpZJnbYNy3ZDG84HfKgNRqNDRGCQ62K6mQL66+DjxWTkuDYi9hI9EWE9YvdWZ+ZGdqt0YaPbblWoW6h6O6+aEWHsZjKPOdPz2F8YmCxIQ2kcKFeXEdwoeqB3WFEBZV0bvtV496kvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781321523; c=relaxed/simple;
	bh=XEGNtJgL9zV/iYvc+RbEVKQGxheJ2tZMTihk7BmV8fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv72+DEMqHPqC3vDAoHja+2EJC+Q9JDXSMYJXR9I+ipaLZy2eCU9F7/mqawyi7QR2SQh66P6Inksm/TPuNKO5pmNW31eBCDT1K8BuyZM2vp90kHwrgQ2etNf+SPEqJnaShhKvq4hFNRWYFtj9nvbyGnNxNkwfqLPWrfenP5dFBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldFT21cP; arc=none smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1370417c01cso2150197c88.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 20:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781321521; x=1781926321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB2UXCTST1G3EKX58d9G7S+JZrvHFI4WiciNlIDqnEE=;
        b=ldFT21cPronIyrkDfdk4OFdUfONZ8KnTr0NMJozvaFyOCgPmlw4yCrSMB3jDggGtNe
         jD6yCMsYXas33ZledkzeDw1Hv5icvH8oqEhV5f+/7JNVCsc2bNpw76puhFMbDQ+TN6wn
         njHf1kbM5A8qr53nN1uWFjIdJlrKVc8heVvthtcM/V64rCw9XS0CtsKp5xMJH2yOfWbt
         Qi1YGPg9hAXNzEAmDP43qFQgtxJCzpRDNN4MTvgQ+vjb05Sp+2t2nNgPay99S6OOOgRq
         dnYYuMk3+dUSk2aLbFwtyR8OzEw36h++l/okrpnjIFHwX1n7r3JVNbd+Eeh1IkXL73Pu
         0OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781321521; x=1781926321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YB2UXCTST1G3EKX58d9G7S+JZrvHFI4WiciNlIDqnEE=;
        b=lgULI0yG7+0cUim5RO4Coz+4xTw6Eupz2g84SjXxIOP7FJKo9l/j9LH6S+m+yjOfn1
         bxB3oo1Cbxs/82DnoH4rHBYEey2tE16h5Djuv7ZmiqZgueg+kEp/7ygPP8ryUtn5sgUv
         NYQz5X+AJVWA5kt0QWW7ZWQ7BIdXYqQRGLcD+7GherT5TWhEIA4ztyUhFDfOGXUT5Bdr
         paqypQYuqne8D7VGnBvVO3VXtgUp0sMFWcofW/imgb6JwVf+5U4sDjMpl4mE15bXOCbZ
         mEHjqMmRHOLXAadDag/Y7wHX7V2GRwqLcFpSzriMeTwsFKHZKtDVLHeM3Gft7lOyydhs
         sUBw==
X-Gm-Message-State: AOJu0YzEpBjwC81RRyiJ5JMtsAuPjcWAFb4jsdkqOltWvewhluSdEQlQ
	8rLakmAxx3542scYcFLrw5gfUCbqfIo0T67SvOjY3t7TJtje8NIi8s0f
X-Gm-Gg: Acq92OEw6CX0cruOiTiYPZGdnMghUTueRJKaBMUj8i6VrStCZkei63jF85t+kUPVPfy
	eYLh2rCNpxVs1pSQg8dI56FK9NNzehMOqVldShVQY80FAdDHejgW93OM4UbJDARTZnGjuGehBlU
	BkxDR/Re4O0LYvBedOfY01ozsYAvXzB+UTJxz8L4prUZ11jd2pQSREtgiGB0cpVUZmDlVMmPVq+
	3wjP8oi8tO8hsufZ+9VloLdNtA81JYTml3ClmB+ILjCkbuytoVMPl/L1v1w9HLsOGxRGSl9qjPi
	eH33xfisr0we/ZXl3wH1Opu9raZCVzSHrYf6lgegVqh+omasUW3aoBgRVtX5/ag9mSXwFK4q8mb
	E85H2rkvtrdpPRNFoO/YNde5PQY8/69glcRX79GuBDnOysyQB+vVLe/L5sL6MMoPhI4NsJ/ZnbP
	Qjj2vsz/QH6G0fw6H9zJj7bA==
X-Received: by 2002:a05:7300:aca5:b0:304:5b0d:489b with SMTP id 5a478bee46e88-30820098d2emr3305528eec.27.1781321521004;
        Fri, 12 Jun 2026 20:32:01 -0700 (PDT)
Received: from 192.168.1.17 ([179.63.13.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d810fsm6136001eec.12.2026.06.12.20.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 20:32:00 -0700 (PDT)
From: Gabriel Ramos Barbosa Mota <maguraa53@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	deller@gmx.de,
	fero@drama.obuda.kando.hu
Cc: netdev@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Gabriel Ramos Barbosa Mota <maguraa53@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] staging: vme_user: remove obsolete VMEbus driver and Kconfig entry
Date: Sat, 13 Jun 2026 00:31:31 -0300
Message-ID: <20260613033138.601841-2-maguraa53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613033138.601841-1-maguraa53@gmail.com>
References: <20260613033138.601841-1-maguraa53@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[maguraa53@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com,intel.com];
	TAGGED_FROM(0.00)[bounces-298896-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:deller@gmx.de,m:fero@drama.obuda.kando.hu,m:netdev@vger.kernel.org,m:linux-fbdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:maguraa53@gmail.com,m:lkp@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,gmx.de,drama.obuda.kando.hu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maguraa53@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFBD367D9D7

Reported-by: kernel test robot <lkp@intel.com>

Closes: https://lore.kernel.org/oe-kbuild-all/202606130547.TsvyPMvB-lkp@intel.com/
---
 drivers/staging/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 2f92cd698..0e6e5330f 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -46,6 +46,4 @@ source "drivers/staging/vc04_services/Kconfig"
 
 source "drivers/staging/axis-fifo/Kconfig"
 
-source "drivers/staging/vme_user/Kconfig"
-
 endif # STAGING
-- 
2.54.0


