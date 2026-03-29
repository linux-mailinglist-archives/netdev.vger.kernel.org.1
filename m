Return-Path: <netdev+bounces-272938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA1TDmdSyWnrxQUAu9opvQ
	(envelope-from <netdev+bounces-272938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:25:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4B2352E19
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 491103037E4E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8F37C922;
	Sun, 29 Mar 2026 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxYsCGFO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FD3750A9
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801346; cv=none; b=cl5Xoz/4fZPsWYxgMbEK8Tiwx05FKeVuCAWdfXYuFsTjU87axXVX9TMttkZx9vv55TigYlBukW6Bh10l9Bj0Q/P7KPAciyh6MehErnMN0c05JXXaUg1WwbaAAVyZza9jD8/hOelJWTC1VpqXg5hi9IUIl8eYZPk7LlbCrPKx7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801346; c=relaxed/simple;
	bh=y5/H+TqDE4OujzUA/5gacU9H3XM10J/mK0k1UKIflqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avb+MQhkK6ufKRWKNcJXEi358InMd4mS32GE9SmxSH2fKUxTMiLvvQ7ZzdqesALS/t6/A3jh2FF5NN0HwO0eUlbbacPjCCaKFeuGvlS6LnfCj+usPFe0RJ/PnrqyFulkjlgY9pXrn1nzpbJ8UmkLxw5lORFB58np7nibpB0UHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxYsCGFO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853a485721so5375215e9.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774801344; x=1775406144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39nWh5Sbwqb3QyZ67qx+99ZIlQgRVmnOj8xt3uyYktk=;
        b=MxYsCGFOtAdujG99DC3NLSrN+NUhC1hI8/fROaAwLyGUJHnZXM6b9fK0BBl6JGd4aa
         oPZV8Ywjjiw/QETPlnzUlLpFCLvGh1KHH3dcrhsGxxf7Ex+Ti7RyAKA0patUiJx+VFKe
         04cJI7wTl4DOXen+MwjwHSzZk4i34QbtyOriAPDLZxKlVE6YB0gqaCFQU07wc/b5rR2p
         TOn1a+P7I9rkseRoyblwcICO3DdfG4ft3gBA87IGxMRAh2ql2siZx6P8cPAxz0DwUl+/
         DbVl/mFl3Get7haSR+OGl8IKF+pLlrnTTaWH12uemZKxSozO+8eKreEaja919Eu7kr+f
         gMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801344; x=1775406144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39nWh5Sbwqb3QyZ67qx+99ZIlQgRVmnOj8xt3uyYktk=;
        b=rvh/mtr7oSB8OY4vvjjkLAJ509mR5F/sn3lL0/v3ZGCU9j1Gwqe4X3fxuKDBGvcizJ
         vhrHC9NaEYsnWHVUmYh18qodQ4c9p0KRUFnPPuuWKqpK2537ulfdKwWEcaJ/0GTcvcYb
         eKbIQaTwtueaCxXq8pUHr7dQF7eBVOVjf0tgkrF5kTttGjVsUGbTAGTcYIoU7pf0CaSo
         DjseXapLbohhqxmNzjOB+fLXNeKtBOY/C8tiNytIfulbYzxzczFMXEPMmPr17RVbGf8z
         +H3UfxD0+TjYcSeO7tB3wlEDX7CEvKQWb8wiY40afm1XwASb5qEzVSbTu/h2IYvPgxPg
         7nYA==
X-Gm-Message-State: AOJu0YzoB3FhveBYMgxz4cYH7uaHXGV5l7eIaCpZbm212Umiz0LCsQ5j
	lCJMHQ3gfsMLNzI4GFKZnAQ2rtxu9ZivVGIJ2rRVjy1DInW8caqp0U10
X-Gm-Gg: ATEYQzzQrKDGXIIOx7+m7OLj7drO1NSSIb81Eph3va4MTVnkkVkOlIov3FtuKcgiUVZ
	aycJP1SfmiCtSGouY3mtcMliSJzwz7fjbb2pcZbanb+iani8o4OjZ/Liw8qN4JmzQLGzEyddTOR
	XelGamC0o8nURdNYeGYkXIef1/f+z2b5LdJ/Le9cRv1H7kBMlOzM99TskC98XUUF7WWHLyjhGoS
	VB28ayUj+n0Q8emzRcuQrVw5M3KHzFgFH5qjm//zTOFhhyCjhp6PNNlP8thojqdOjmwgfUtThLA
	1mlSO1cy/iWdFddkIi5DT7Fp3AyOZ9YYJqBMIapVKxBAxhcQ1LezayuWlowq9oLw7SaavUj69U0
	mG2jvs8PHexkzNypjKlOtK4sWTakvSksqrzydZNJorrPEQG4gVlIAsp2DBt2OMdFe+dreVH7v8r
	S4maMwMe/USyB8Q7pl+39GZwLAMNEQxBuYmWTfYB2182uEudGeeTl71NFraxL6asCT/oeTGEht6
	K9iGEs1j155FKMpvjRIoX4pc9Co
X-Received: by 2002:a05:600c:b99:b0:485:39a1:bcb3 with SMTP id 5b1f17b1804b1-48727f5f8d8mr76636175e9.6.1774801343387;
        Sun, 29 Mar 2026 09:22:23 -0700 (PDT)
Received: from localhost ([2a01:cb1d:4ec:6700:174f:90cc:2ec3:a84b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24707f2sm12760803f8f.26.2026.03.29.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:22:22 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	arkadiusz.kubalewski@intel.com,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH net] i40e: fix memcmp of pointer in i40e_hw_set_dcb_config()
Date: Sun, 29 Mar 2026 18:21:51 +0200
Message-ID: <20260329162151.2043655-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272938-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A4B2352E19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In i40e_hw_set_dcb_config(), both new_cfg and old_cfg are pointers to
struct i40e_dcbx_config, so sizeof(new_cfg) evaluates to the size of a
pointer (8 bytes on 64-bit) rather than the size of the struct. Likewise,
&new_cfg and &old_cfg are the addresses of the pointer variables on the
stack, not the addresses of the actual config structs.

As a result, the memcmp never compares the actual configuration data,
meaning the "no change needed" early return never fires. Every call to
this function performs a full DCB reconfiguration (quiescing all VSIs,
reprogramming via "Set LLDP MIB" AQC, and reconfiguring VEB/VSIs) even
when the configuration has not changed.

Fix this by comparing the structs themselves rather than the pointers.

Fixes: 4b208eaa8078 ("i40e: Add init and default config of software based DCB")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---

Found using Coccinelle/spatch with a semantic patch that matches
sizeof(ptr) and &ptr used together where ptr is a pointer type.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6904,7 +6904,7 @@ static int i40e_hw_set_dcb_config(struct i40e_pf *pf,
 	int ret;

 	/* Check if need reconfiguration */
-	if (!memcmp(&new_cfg, &old_cfg, sizeof(new_cfg))) {
+	if (!memcmp(new_cfg, old_cfg, sizeof(*new_cfg))) {
 		dev_dbg(&pf->pdev->dev, "No Change in DCB Config required.\n");
 		return 0;
 	}
--
2.49.0

