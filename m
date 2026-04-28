Return-Path: <netdev+bounces-281706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEOYOYNv8Gn9TQEAu9opvQ
	(envelope-from <netdev+bounces-281706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:27:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCC84800EE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 170533062A1B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3D3D0939;
	Tue, 28 Apr 2026 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="dl2hdOjB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3C3CFF53
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364429; cv=none; b=oudA6/3OiTwF/+uOuHHcxCOfCc5n7WfrVt8Wvq+nJwyXHN/oRvXcqTQKUaNGhqQYF03M1s0uZeEbKNBHK4LQ5Edqjxd1zsu77c5TPzGWAwNHZj+HMegro5908KdS+7sFLsailUvwb0oPUi0kRsSlzDwoOKmU95COTdA690jIVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364429; c=relaxed/simple;
	bh=a0TEc6WSZav2wock5/GID0t3gR+3qLjktNsuOTurOxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2DbB+LJg/KjWNUQm7iww7roA9XWt4MUJopL1CikHNVFJ8Fzcyi7nQs5se0n8TvSrArWyO+MZ2twgtxPNvFMLSDFEhF35t4qC2mhX7Ms1qpxJLGrdI4tkS7yl9a19t6/FL1NikKf7AGO9qlQJVBdxgxfnKc3RXnmB+WZEnRQ450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=dl2hdOjB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1E93D3F442
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1777364425;
	bh=FjJThp4I5WkrMZHH23Stv5s45vttZoJtLgvhqAh471A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=dl2hdOjBO8uYRjnetaTJvlpToAro/E8dQyYvzxPm+sT84cVsFipdVzD5MmCMjAbO2
	 xxd0qA6P/oDne6mHDaVIZssua2K4e4y3sWotgPkqDEIVP/Hctym0ul639ysT/bJez0
	 6r1XXh66zrhp+Y9AFEhdcNpWXVHxe+wFHi/CXrrUj8iu42C/U92EmnQS/fgZPtAfzu
	 LxpA4zOCa4Gy3xFfXPYLxz+iO4HXdDg61J/Kht8x2qeyYLMOU9SRZKSNnSaOlgLvq1
	 LMdZ8vL0Gv7fYDFuZru8I/1cjOQd2WC+aHTPzmdvcZCKld0V8IZWH7meB1a2UtQY9t
	 1HsVgwr4Xya0VikKc+/9cljZgjXSPL3sDwlTGTrQ+yey9OuZcjnrl8fbMHKqSSdeMx
	 wXtMJH+ImkQvVE3L8XbbiG27jno0cgUwvMXXthP52j86NWvTqPogg1/8ZK2wOocDtj
	 +EjZBcsrAe+6eWeP98xWvP0JYB0LmaI9gF6UotM42qPWKgk4sWhpA+iJG5mu1Xfqh9
	 PB4XemlvispFLz7Vh7vBYYlTeYrEVNZ6+zN9rQxKE/VkZG3yCD0OyngAuKUIWCar+i
	 vmTt+ggb1s6NArDX1slPYCLu1/YwjvnqtCC9Um63zNJguxcp7t7fpmVXSEGqn6ZsBS
	 nIh0gDbWWfIo/aYpQDVLXTPs=
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b79f4b35b7so51811095ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364423; x=1777969223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjJThp4I5WkrMZHH23Stv5s45vttZoJtLgvhqAh471A=;
        b=mZ48OY1/+s1zPcYZ/nSdgFgCNpvR0mOO376L4OrlHdsoOuQTsmpPWz5ZJ5qBYuN4Cf
         tKQo396QhfeFTNvo2noZgRkFDjCc4DbjvyF6o8S15zP5q584VA6NebhL00PTXTUPuYK2
         l/85dT9tt0xU5/fISp+0cLIKqhppoqVqQe0H3vXhsVRCZ73mIsknK82Efuj2MyF9N+R/
         frQQKW41ebXv5oW9xXC+Sk5/sfzl7rco7GLrCXM8KLqqRlEHlxwRXVa5didDXUWOf3SL
         qbXmahDJ+bBHkTOWIOX1+uRC094PD8VpoTbiIKMuJy6l001u1+OiRM55AxschmM5Rega
         vjcg==
X-Forwarded-Encrypted: i=1; AFNElJ8hGy3NI/7tfTTs2yKk4HYttpszymFGPpgwM05VE9fl7c/YT7U9FaXDfIdwk4J/GrgRjmw7IU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35jvx89GRk1z7i6BXX5d6Ix5CHvMwcABUt5J083BWdSUyOB6e
	/jVl6TEewxA6YhSM+4+cF4whYsL0t+gvdNqp04FiSJQ+ScK1BBhNQHeX16MyZ5Qq6yesVlcb62L
	J6k8rOqgt57G942YbZKd/q/sLa4JUdUS9BO6LDKao5geOo0ECFBpTV1vMI6On+HuXZCdpIFwI4g
	==
X-Gm-Gg: AeBDieumkokTlvCFeLrFYNa7Fksyyih6fL0Cx5fG1R5b0T4iYOUlqTjRexTVlwwch4P
	pEPVLFt5KPdVYSMA32Qopso7FF1w1SVlRWvEoIHKvJzU8gtnQcAa8GgTi5tWR9tltq18NpqQHni
	kkRPFdN6oZC3SbFHt3WWLnUe7Gw351iUyFbULf7v8yzAbCPZIY5n08FvlEjFpezeB9nkxRF3UU4
	J3IAvuV/qHUFlswL9f9NCsXk3E+3Q4rWL4ue/1k7oVy+81I7+QbZlAHPPx0icx/sBhcMecQmgrT
	GLEQ/59tvYnPuLbV7yZZyxSAqUXAk1X3YzFvmBFRYT9KBG9nNkW3fpWRhPLUH3Jw7BU1/1SwZjX
	XAmj5O7lmEau3cWQbXEDy988cYWHij62eGWAy4V4Lvn7lwFQb1FV4SHQsqG0s52lF7LN7hNAAxh
	5wR7lORTvV+T/7tZN6ASuvAfODyBmh
X-Received: by 2002:a17:902:b689:b0:2ae:450c:951e with SMTP id d9443c01a7336-2b97c435bc1mr13505295ad.17.1777364423373;
        Tue, 28 Apr 2026 01:20:23 -0700 (PDT)
X-Received: by 2002:a17:902:b689:b0:2ae:450c:951e with SMTP id d9443c01a7336-2b97c435bc1mr13504915ad.17.1777364422830;
        Tue, 28 Apr 2026 01:20:22 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8328sm17881525ad.77.2026.04.28.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:20:22 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	aleksandr.loktionov@intel.com,
	kohei@enjuk.jp,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3] ice: wait for reset completion in ice_resume()
Date: Tue, 28 Apr 2026 16:17:33 +0800
Message-ID: <20260428081733.1615755-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CCC84800EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281706-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,canonical.com:email,canonical.com:dkim,canonical.com:mid,enjuk.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

ice_resume() schedules an asynchronous PF reset and returns
immediately. The reset runs later in ice_service_task(). If
userspace tries to bring up the net device before the reset
finishes, ice_open() fails with -EBUSY:

  ice_resume()
    ice_schedule_reset()          # sets ICE_PFR_REQ, returns
  ...
  ice_open()
    ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
  ...
  ice_service_task()
    ice_do_reset()
      ice_rebuild()               # clears ICE_PFR_REQ, too late

Reproduced on E800 series NICs during suspend/resume with irdma
enabled, where the aux device probe widens the race window.

  ice 0000:81:00.0: can't open net device while reset is in progress

Add a best-effort wait (10s timeout) for the reset to complete
before returning from ice_resume().

Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
Cc: stable@vger.kernel.org
Reviewed-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
v3: add error message to commit message for searchability, mention
    timeout in dev_err (Paul Menzel)
v2: reword comment to clarify best-effort semantics (Kohei Enju)
v1: https://lore.kernel.org/intel-wired-lan/20260402024220.210466-1-aaron.ma@canonical.com/

 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5f92377d4dfc2..260cbd0d9ad90 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5635,6 +5635,16 @@ static int ice_resume(struct device *dev)
 	/* Restart the service task */
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
 
+	/* Best-effort wait for the scheduled reset to finish so that the
+	 * device is operational before returning. Without this, userspace
+	 * (e.g. NetworkManager) may try to open the net device while the
+	 * asynchronous reset is still in progress, hitting -EBUSY.
+	 */
+	ret = ice_wait_for_reset(pf, 10 * HZ);
+	if (ret)
+		dev_err(dev, "Wait for reset timed out (10s) during resume: %d\n",
+			ret);
+
 	return 0;
 }
 
-- 
2.43.0


