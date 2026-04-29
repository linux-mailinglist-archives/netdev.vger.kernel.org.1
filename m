Return-Path: <netdev+bounces-282229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IESmMeuA8WlYhQEAu9opvQ
	(envelope-from <netdev+bounces-282229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:54:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714B448EDD1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AA213058136
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF253128D4;
	Wed, 29 Apr 2026 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="dxokGYNW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36D31E85C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434547; cv=none; b=G49nWjhLghv7PPkOfoU9zMC6rBiAxuVBeKVQJ0DLDm3YIR0n3E411EHCz9lUkT+SnG0fpiDeiJdbDQIyFFqurGM0/dWgqBbpZSWenAL80f6QJAaRhhWW8T6XGiILQhVScXCEIzsCjWt+6b18TItykSLxLQ5v6R/aVm54boBGQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434547; c=relaxed/simple;
	bh=0v25Za+7o8YkYnq2Rk8ediQfsgs4jUxwmLfDUCjvKws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cd4Z/gdvOi+eDRg620FX/i1eTX7hJyJt+RZ5Rk1Xu9qa0L2yWcLYXaK9AY5q11Uy+ZDtlnaMv8Jy2j57Zw/glWNphI+jzy9Ci5xRwZhwVNt6W1ldBWoqwT9tyRdKoVezCLtLxgk9sVQmuvEhmG/HyIG/5IOqDLj9jCyw/cZSnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=dxokGYNW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E44A53F7DD
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1777434542;
	bh=9Poun78EQtztiC583t+elgVeEgGqZI6iTcp9LxQ5+sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=dxokGYNWBfVHMu4VcaLtOE5TgrIb8LulDvUkmSMqLPereGehZOjvuPB40Bn3R5m2+
	 JopZXuzvqJJ/jvp4diXLdF5bPvZSfWOiAID3U24FlxG2mJXjSnYNMYtUXHqI5yhllq
	 GIWtsdCZDsQad1K1Owm2weyofo77tHfiGjU+YhY8FAf6w7hZoAyrGfXVLo3EmLwslm
	 gJMJbMBmJ6ivkV2kmkf8j/HJ9tz6vpShp0r/+VPMlqV88/3gcYzJqHJExjigtWU1r3
	 a/HNCwkSp9vga0xce/uZ4+NQBQeDBByVWya913VU6LVNBcWnzFjpCO9/gJYoMlQ+mZ
	 WGSz728QKCvwDGg3bNGiT+ybTaHFz2j27zy+A7NtGiNeQtHn92pO/eJmMNjLcSv5Tp
	 BOlsEOqVg77IG9Oh3zQaOcUdl7N+P5hykn4PmxMSVDMtHQwpJBrTJk9sQtg0XisSyu
	 DepeIEbRjYq7A6gQlIoFyGrqKjbk3m0Fw8eaMThVLNEhJzBh51BoBNAlqpKlotVzdN
	 nELuhNo5X0mxv4Mrz9ILKXVzC8oLxB5/nOhyF7byA5F9H+Db1Qe7fBwXgpdPM5q/C1
	 EUexKjPcWTSfqllQJxv5HDGCfz3TaifK4oknlJ8copvJ5wzVIoAKupCjqsEZ+hshiW
	 klVsXpoZeQdExNNiPZ5gZ880=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2d83e7461so210755435ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777434541; x=1778039341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Poun78EQtztiC583t+elgVeEgGqZI6iTcp9LxQ5+sk=;
        b=eLZgp8O+1FHYNzKal033LYzxRjfbnWPIsHzPLoNI0/1FNmG7LJD6BsNwrHB0OqLXUy
         Q7eWWgFGJx7vDPwFt5S32XFKHc2lByvOY7ZN2nwQoVNV+2CHA301AF4nKqroVrL/fnH9
         PhuKA7T6g+xju4/c6raMmdfoTK/DI8YuT87FA6Zkd1qD4/cAyJ+jFVI+GpLY9hrsbqqK
         6kbkVTCAzIycc1hzyH/tVdW9TSf8KgiwA5lY9tW/oSniC78Nnqq+jYz0Luo5JdN0bjdx
         L0uEYn6BH7YvBfXRERr1ibNg9UCQERvE9PRoLbF3hmn2yabxCR14MQ+q35gPATj6mErX
         aC/w==
X-Forwarded-Encrypted: i=1; AFNElJ/97pH80V6TXySdLW20kME0eLKLbWGxvz+pvjWN/DlM4GNYjtm3WKOq6Rrgn+7SWBvMtWFy+o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/dGdonUBAbMxMcEQsgNl0EgVybtjASYWhCNP9opMUKAXjXrL
	Ih+DThccVJFOqMncsl10EaWXzrcjYLNANTBuYVvZFCsqu0MlrW8huW/rAr1zcrlS8woVWmQbf2x
	SCZQAR8ZvWHJgpjaOms0M0XAGsMTJz4DKLmrt03/onPFmwdDo119PoAvHG0dIQT3GVg/VRfK4Zw
	==
X-Gm-Gg: AeBDietQSyZCDpLqkh6d0YyCl75s8KwbTpGmIDHXrjsVn4edmdAImjjZ+hFyIVGYioC
	U2eAYEN4M8GsivARzG/WmzizcJjBHNgpuOBKXEeKy24Leh0NI1EUZP0nPkDF6XEKq1uHiy7qzhI
	OP0o3B5RMqxERtx6wug2fdGpR38Yqs4KwZU7R/4L54LgK7Y6UiSWkRfuKUvHyjmN1x/9VgrJbNN
	gBjnHebWwYSjkRSGYBn+Z0PCmCwK+GGdFV7I9eeWKuPVkI7Skdx+f5eL1yOezXg5P5nc7pQPyMF
	+lMEk7MZeWv6s1KeWO0lqLahutESlziqizuPpw5ltp4MpDGw7z8u3t0vCMC7EOtF8BInZFWzc6I
	tQsX4BQ7Klqop2+vHSyKk7smUHz9Wul02StwnZX87MtdFe2B8ioi3VFTxzMrnN8IK2J8LCp/mxS
	NiQ5U3eUbxfUqiHHPbIrzhmc4km7kV
X-Received: by 2002:a17:902:b7c9:b0:2ae:c529:a13f with SMTP id d9443c01a7336-2b97c4373camr40318375ad.14.1777434541572;
        Tue, 28 Apr 2026 20:49:01 -0700 (PDT)
X-Received: by 2002:a17:902:b7c9:b0:2ae:c529:a13f with SMTP id d9443c01a7336-2b97c4373camr40318195ad.14.1777434541160;
        Tue, 28 Apr 2026 20:49:01 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98893f1d1sm6615585ad.48.2026.04.28.20.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 20:49:00 -0700 (PDT)
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
Subject: [PATCH v4] ice: wait for reset completion in ice_resume()
Date: Wed, 29 Apr 2026 11:48:49 +0800
Message-ID: <20260429034849.1686650-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 714B448EDD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282229-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,intel.com:email,canonical.com:email,canonical.com:dkim,canonical.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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

Add a best-effort wait (10s timeout, matching ice_devlink_info_get())
for the reset to complete before returning from ice_resume(). In
practice the reset completes in ~300ms.

Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
Cc: stable@vger.kernel.org
Reviewed-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
v4: use secs_to_jiffies() instead of 10 * HZ (Przemek Kitszel)
v3: add error message to commit message for searchability, mention
    timeout in dev_err (Paul Menzel)
v2: reword comment to clarify best-effort semantics (Kohei Enju)
v1: https://lore.kernel.org/intel-wired-lan/20260402024220.210466-1-aaron.ma@canonical.com/

 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5f92377d4dfc2..5fce644dc658e 100644
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
+	ret = ice_wait_for_reset(pf, secs_to_jiffies(10));
+	if (ret)
+		dev_err(dev, "Wait for reset timed out (10s) during resume: %d\n",
+			ret);
+
 	return 0;
 }
 
-- 
2.43.0


