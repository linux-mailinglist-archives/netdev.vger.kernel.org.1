Return-Path: <netdev+bounces-288279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHVDIWT2BmpUpwIAu9opvQ
	(envelope-from <netdev+bounces-288279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:33:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF2154D660
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3ADA73012D4E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B403D0BF9;
	Fri, 15 May 2026 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK+F8Vfp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16F429802
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840973; cv=none; b=QklJPBpsk/O53ZDv7Sln1UfwyZJ1JADFsPvpwIUlAQcfe+F6MvyzyfGPKI+bqjraDo9ThrVMl0ZKeOnrjgXQ+oI050FRGTNccJmiy+ecutPDsXvs6SBwb+51REk6lVoQ/ofZHnhVuW2Q6WmcpmNvpf3KZAdCzNU9Yc+67s3hSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840973; c=relaxed/simple;
	bh=er+VPAXbatkw7V4bzkd54CKNZfcNcVFF2LecyOSnC74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oEK8gKA7tNRbMjw2fRK5wrwVW0cwMnFSFPuZsh9keyjg2vstaHRhtL2RurdaRCcXFi8hdAv+CT1l4jsT/rKrQqPotPf3A43BZ+c77d+XSR94GpD72AVWbv26hkqXEVUWwAde89btuU/Hr3XDwU6goN66yZKchFgiD/DHVvmtdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK+F8Vfp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd3d7c29b4dso456293366b.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778840970; x=1779445770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dFRR0YqoO/uOT0mubVZdvujclLqeOQBDRrkQLRytwA=;
        b=AK+F8Vfpls8S8O7Xqz6iWcayy6G2Q/Q3zhXEQyKhWvYnw807bUnI5fYDs3jYyxl5uL
         KHgWxxRwKwyb6KpzHTP0QFXh5xTmT+1o9C9CiDNP7rWom4gQv5VS6/eqaCw7BtN9+HyL
         OVitNv2hL+Lo11bxGuhvTXqu87Ftngc7PYj9APTVc9SbI7/Eb0MuAPm8ZTnnZOeFEu6H
         YyuH69nkjnKg38NNqTMPpoiQOIDzXTFnf4JvOLfqXoXFw6FcEpUZ2ULtl/J0ZFq4o6IT
         DFI/4WvC9sPTQsAZN5TQ4Dvh04ZNn2QYFLxV0AWmm7Pj18UWkPqPfSCSG4npvk0VMFbq
         9RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840970; x=1779445770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dFRR0YqoO/uOT0mubVZdvujclLqeOQBDRrkQLRytwA=;
        b=hpTL2XwbFLVj65UepJV6YJQwni5iA88QDQZW7rHp49R+2TqEcr9QcOfZPSJErfQ8w2
         oCyqLZCwKSROxREgOeyC2whe3vqwjruiDsR+lgzgA5zZHc96V4ODl4X/gtemgWK5q3iQ
         MRSy56vk4YvtiDCE9jz4OMGEtFqC1c5pniWVL25HIIMQajbcDjbkTHGq6I9yYJzJ8+Uh
         YZt6B9nQe9rk0ptsEXNEk1yzyuzNY/711wpoaEkxcV11MiAbKXrbTpQcgvcDgW3KiTPG
         +9nDFyQ2OOeZ/DOc351z9NXR6rJIXcri2/ucjrs+xkogbNjPyS5fHlev6PyQxFU5a6Ds
         S0EA==
X-Forwarded-Encrypted: i=1; AFNElJ8WOVOdIng7N6eFvYHJ7/jp3Mr/piz1otghjHzyZbAyKSIuLWRANHz9VdL57vSgxeacbWDL7Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2w9oDnJEIGtqcCruOAsKR9luJoOoBSmqhDFIm+179jDQgUPzh
	ep0ANZT4/cmZrdx1n0M+Ha54zCpxsx/QKmVFPDnvWO3Qv5GgWl5325Ct
X-Gm-Gg: Acq92OGDh4wbAzQCZD/5hEW/xA0UmZGE4rX7AVYd9cYwIGYjY9Sfg86U3e6ev7B5OLo
	l3sSSIAmRzyhItDgZueNJ3kwQAOcJGdh/84Ivr6DhQKNnOfG3BiAqMBhWf3RvuZIacAWZ7I0dtr
	TRpK+UUEDCmcoUB0Ka1mAtMd62IvElqUr8PlkBVfEaAJ7pjSXrcD9JHhRmjbu6nzqy9Q35CE9IK
	kvuvMd9PzFChKgrIe+XtTaEt6MXyMGWoPEwKKRnqvtLujdjRj1hFBsJSDjVi6PMHuVwrcj8kH1M
	wqpAfmMytH1KH20XWZvNMPi/sQNWr5TFku3chmtTdXXcgZWYF93llj8eIp903gyzEBPUDlNHgZz
	2dZbEx5G/BoIgdcl5Q3OORUgpyi/yPyi8sZ4QF7NR8UKKV2klD4imym0b6vxJBfq2B+SDTHYNyq
	Zr41oE+aG1AnS3v7E3DC5mqTWdyne+Db635J+NszilWDF6vqWHbwX5vuIVG3RW37a7eprkrcX/3
	JAtv6M3Yk9OOINsluoQNZdMaFL0tpY47gFoalgaNUtwp5EwEdtf9PUWvnk/H9g/MQf5fnOcdxgK
	rR9kwoA9LYP0EOP/otFxxwN7o3jQ
X-Received: by 2002:a17:907:c248:b0:bcd:bd6:94d with SMTP id a640c23a62f3a-bd5177f054cmr190400866b.20.1778840969376;
        Fri, 15 May 2026 03:29:29 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e21b1esm205726566b.44.2026.05.15.03.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:29:28 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	miriam.rachel.korenblit@intel.com,
	ilan.peer@intel.com,
	netdev@vger.kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH] wifi: mac80211: bounds-check link_id in ieee80211_ml_epcs
Date: Fri, 15 May 2026 12:29:08 +0200
Message-ID: <20260515102908.1653088-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AF2154D660
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288279-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[sipsolutions.net,intel.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

IEEE80211_MLE_STA_EPCS_CONTROL_LINK_ID is 0x000f, so link_id extracted
from a PRIO_ACCESS ML element PER_STA_PROFILE subelement can be 0..15.
sdata->link[] has IEEE80211_MLD_MAX_NUM_LINKS (15) entries (indices 0..14),
making index 15 out-of-bounds.

A connected WiFi 7 AP can trigger this by sending an EPCS Enable Response
action frame with a PER_STA_PROFILE subelement where link_id = 15.  The
unsolicited-notification path (dialog_token = 0) is reachable any time
EPCS is already enabled, without any prior client request.

sdata->link[15] reads into the first word of sdata->activate_links_work
(a wiphy_work whose embedded list_head is non-NULL after INIT_LIST_HEAD),
so the NULL check on the result does not catch the invalid access.  The
garbage pointer is then passed to ieee80211_sta_wmm_params(), which
dereferences link->sdata and crashes the kernel.

The same class of bug was fixed for ieee80211_ml_reconfiguration() by
commit 162d331d833d ("wifi: mac80211: bounds-check link_id in
ieee80211_ml_reconfiguration").

Fixes: de86c5f60839 ("wifi: mac80211: Add support for EPCS configuration")
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 net/mac80211/mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5b02141b0cb2..0403ebd11a4d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -11214,6 +11214,9 @@ static void ieee80211_ml_epcs(struct ieee80211_sub_if_data *sdata,
 		control = get_unaligned_le16(pos);
 		link_id = control & IEEE80211_MLE_STA_EPCS_CONTROL_LINK_ID;
 
+		if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+			continue;
+
 		link = sdata_dereference(sdata->link[link_id], sdata);
 		if (!link)
 			continue;
-- 
2.50.0

