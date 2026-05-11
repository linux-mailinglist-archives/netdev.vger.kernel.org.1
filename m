Return-Path: <netdev+bounces-286565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEcCKKGhAWpKgwEAu9opvQ
	(envelope-from <netdev+bounces-286565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:30:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2A50AE7B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36FF43010BF8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736553C2796;
	Mon, 11 May 2026 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DyDUOSAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E663BE659
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491744; cv=none; b=YsMq6brYpCLxBiBtbaxWDiy59Rtypw3nZY/mazmBOKAWUhyuEjdJkGsJPLCEKjFNsadAwvOUBR728ioszRdgy28iDg4xSwQcBxbzBauwwa/rG8D2ZaJ0DtXmCKc+NWtOgXoVmZKIBDaPA60UFjw2oYGR0RbnqcEH4sLfqWMSU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491744; c=relaxed/simple;
	bh=FUElfcPrwKM1P1C2e4YAuvNqKXojJwDlHLEXWbmd+O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aox80Z3rzmwNPeVegraEmnEXupARhcWaYArfd4tTN0JhemwPzBNzoS2dnA4y3OFI0khoMs9WQA8NGqP+6CBQgJlbEJcEk2pJW0mtAzO/FeWVGJbg2WFlRZbPk8jqNSKDRN2WHiszi++ovJfz4VyuIeZLSSHEoiZNxOtUdRiBBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DyDUOSAp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so39391415e9.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778491740; x=1779096540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFnchCOERV/K3rqnNmAlO2sDAoWVt97APGhHAMjqjX8=;
        b=DyDUOSApwrveoXQsoEHcbmlnHY0X1X2cbUv+04aq6gUh13R741ICk4wwaP7JbWozhP
         8DUtE6XJSokSvfVJupia9e0CEu7cWYM/ADD/bQTWbdXnUV+upaH+35eNqZaDTWp305RB
         0lvmO2AwInC9AhWXt5NFa3acgQzeYZSBoS6uBgzgBKE4dTtMf3COK10EqJfK1pUWtp3n
         FYRb8ExDv+9ddQd5DT3hJ64rsVn2OpBiSrrz47vR3RMhAFROAX04LdZHVK1dz4MD93P3
         FHCPO7IouwOL7HXmh0drICkb8RWXWIYiTRWlTZrDKx7/URaJBEUqHnMAncQkTGXf52CW
         3dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491740; x=1779096540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFnchCOERV/K3rqnNmAlO2sDAoWVt97APGhHAMjqjX8=;
        b=ESJ4/LGFW46x1UHRm6lEDCvmOptrhluFQGo9CcuWDTDIXsuY3UNCheAk+hckwf/IIZ
         xBDPeFYJZgxisCXRl24eU2E1BWkhVmBvDzKzsp+Ck0BOQLUoi3EUELQKTFxeWgGJmy4d
         ZGSKQuxonDK66Gk1HBE60CgGKhZssUi3viuxQAeIxThBtdrbhkFNujWKTr+rcO5Q/paa
         ZsbQoycf5AANgjG8ooIy4kbFMuwVLhCYCZ16Sg8kXxVykAgEs927XS7ogGBds8tRAiRo
         xGbSpOrkLo9382ZB8vSQvLkj78hAL2Ssm8lQYHfZwhBN1jZmU4MGHSHJaK/31zX64B5V
         QjtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fN7J/YCtTC660c0/jc/hhPRIJvRCzDxplUdS134zyGP9cUQndqqR7Cp3iQAr6MPkckLH519A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCFPmHZzIs0IJu++9KJwv964G8N+S3WanzlO940WCTqHBWwcQ
	DUfXhMCE0BMzvZxlTk/C4WUNFL4Ym05MtBV7H316ZinKyp3egkrwnQMkGdCGHrFZrCU=
X-Gm-Gg: Acq92OFJ+N3s+gkXCI2nTANnbdNMclIorROyvrj5QOQqgqXoIjV33afB6oxW0/uWBX1
	wsHmHeWmF8jrzHJrZkMuS7LkJr1H+czDOuORf2HU8v0ELmZoSs8r5bXP4r59Eec58DA/i79T+Rk
	yvamuA0wqG2QIpCOmXe8TdupHWHzUbWxgaY83m5D0Re/g0/u9RcBC3fY9HkMXkL2KejSeGghwQO
	qq+6X/EYSPjQDN85bP94W6S3YLav8agQ1IKOALX20qedt4dzWa0onIcYWeINeXHzyeIXb79/+gF
	UYnrVLLw5OsgJV5njLUrnniHw3qzP2H13qUBOXeiPUNQ8FOTyLFR1YhfxUilQ+XH+RhohyZ+CEL
	WrEFWeKXcdWlaJZPcBTN8zwd3m8cMVoTFdgozraH76sNXo3fUyNMpe3G6tmO1VvB9eQp9ETK9Va
	GyKSQP231C5JV8cpqw1V6Q0XlR8Hx5utoiuhAq9CMmjDqAmToCcNNUMthSn9woiJDNQWv3
X-Received: by 2002:a05:600c:698d:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48e706f11dbmr152723555e9.14.1778491739910;
        Mon, 11 May 2026 02:28:59 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e701e89fbsm157606675e9.4.2026.05.11.02.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:28:59 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [RFC PATCH net-next 3/5] net: thunderbolt: Move long delayed work on system_dfl_long_wq
Date: Mon, 11 May 2026 11:28:38 +0200
Message-ID: <20260511092846.120141-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511092846.120141-1-marco.crivellari@suse.com>
References: <20260511092846.120141-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 45C2A50AE7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286565-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: Mika Westerberg <westeri@kernel.org>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/thunderbolt/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 7aae5d915a1e..f365ef642b62 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -315,7 +315,7 @@ static void start_login(struct tbnet *net)
 	net->login_received = false;
 	mutex_unlock(&net->connection_lock);
 
-	queue_delayed_work(system_long_wq, &net->login_work,
+	queue_delayed_work(system_dfl_long_wq, &net->login_work,
 			   msecs_to_jiffies(1000));
 }
 
@@ -464,7 +464,7 @@ static int tbnet_handle_packet(const void *buf, size_t size, void *data)
 			if (net->login_retries >= TBNET_LOGIN_RETRIES ||
 			    !net->login_sent) {
 				net->login_retries = 0;
-				queue_delayed_work(system_long_wq,
+				queue_delayed_work(system_dfl_long_wq,
 						   &net->login_work, 0);
 			}
 			mutex_unlock(&net->connection_lock);
@@ -704,7 +704,8 @@ static void tbnet_login_work(struct work_struct *work)
 		netdev_dbg(net->dev, "sending login request failed, ret=%d\n",
 			   ret);
 		if (net->login_retries++ < TBNET_LOGIN_RETRIES) {
-			queue_delayed_work(system_long_wq, &net->login_work,
+			queue_delayed_work(system_dfl_long_wq,
+					   &net->login_work,
 					   delay);
 		} else {
 			netdev_info(net->dev, "ThunderboltIP login timed out\n");
-- 
2.54.0


