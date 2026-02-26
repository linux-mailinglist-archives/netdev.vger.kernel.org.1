Return-Path: <netdev+bounces-261114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GvJNg2kn2lfdAQAu9opvQ
	(envelope-from <netdev+bounces-261114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:38:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8B19FDE0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 610E8307C4A8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCBD372B26;
	Thu, 26 Feb 2026 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvmvmoV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D9226D00
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069825; cv=none; b=sqVb5JCE1PdOIx28WU8T7VT6NV1lIMzjLOPpk00EyvP8XhgTumw4XnyrLdXStPH7b25RZGobj/MczKBSd/k8X2GBEE9lkAVXh9qMUdXEbsILYf73k3F9lDh3k9FxpMsTXXSPZUMPo2q+v3Z9yaSvnt1op5FlWqWelyeMKGgyj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069825; c=relaxed/simple;
	bh=gAM4awADKSdsPrbx1wNHgpDGmlspJ6kUCc7JuLL+93w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhpYny8fi0mm8dYUmJCEWS4p/0Oxf7zOBMXjD1NP3bn3ugpWAEczbZkU6KGmiDdchrjFiY/rYzcxY7p/aao/RG7dkYMAtHHUJ9gW5FpRjhhC4tmZy3+fT8M7YHhB6sZdZTpj5MLNqXjIYqHrWeLN8sUy8EXLpv/y7T+QgNaZsWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvmvmoV+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a019a7f3so4109661cf.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772069822; x=1772674622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEzs+NEbBHCW6agJfY0Z7umIryAW2GMRfZymnqKt8AI=;
        b=WvmvmoV+sJa/HkmAZaVNGQm1d1fto2MbOOOCKWymGITf1QLaUskAV/jYYtGcnKYOU6
         ubEcZCyFCKcp+6iI/8brMUoarxd13DgoDt6w2pvFpgFb0qKppAjgx1zkwo7kjy/W166X
         1yTyXqYhi7xxevaC8Zcau9gT5M8b/nkw3xR5ZSbElR1SQdQDyTMFTiAQNIezU7bbNKTM
         ni2iPfTBB6ZbTYWtp96eenS4v3TkjCZ9ewR9P6rrj5M/87Me3UkYLM0pdI0oTJToJMri
         vX7QriYo3X5+wBciHU0iuK1XBrMckIY78Db6+RsjYsncyrZYvkdDp2dp9Y0WfhhEQtnX
         lxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069822; x=1772674622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BEzs+NEbBHCW6agJfY0Z7umIryAW2GMRfZymnqKt8AI=;
        b=RxFPjTgHZq2Ux5Lt6lEB47tWD/O6LG8xFLfIkV+EAIRvTERQ7d8KMG0uC3rOlzcQcy
         zdVe2TpXb3SDUuuj6f4qqRmwCIWo0NcFJBjUEBeXMpJe5T1Wj2CAMhcOpTd5LJtqkLO4
         nJLtAXjw0Xvoo3R6APyxIE1IJkxp5HKIdic15j4AQknyijcU7Y+srTXSDsaaaeymd9oU
         GGe7zZcKqPva2cg/H5pac6uXh4t0nOZPyMxlmEXkPkVuGF3TEVXsmgIb9qhPLbKdaB8K
         gYXFf9YN3HRhQ6ML48GkVAM4ibb6OvREALOnbFPDefdZIekh5otUFpVznzq31+wwOhCp
         19MQ==
X-Gm-Message-State: AOJu0Yz2gwEsCo0Q0VzDHn6+HzSY1gemAQK/u1ZfUal+sboK+sW1uQXy
	6hGvdiXU/AJ2YUJgF+JtuI1r7fMb++9U9oMjyOqZHc6j0B3XAewbrlkeMdoZg6u+
X-Gm-Gg: ATEYQzz7gLOE44D/8S0DrqLkx56YWuIfvso0SnPh9Iks+HL4Gq4J65XxkmfAuBmfyUZ
	dQz0KLBpS4dDpfkKG8kzh//H2liYYfP6ruzu3+XRvWZX+DpK8TnxuGxXI6ONRJzIWFhu3b2FnKI
	CP21vBMgJDm3/qgnhhmD7n9GpN8t0AgLSvSb3mwGzprR1khNRsQK/WMAmRxLz8QakULpHaNZgaw
	lARO7HZHyZAqeBDAhP7STHAdpJKUCO+GHR26LZ/Q1c/hNHqvsxKghoZwfyDRgw7sMzjQGN3+44Z
	Yn4cH9Sken+VYKrOXDs/iUGe9I/H+0ymcHy5sHLTm1j1PK5Ef2pvKwlq+WVg3etaczyp4mkXCHN
	jgu+9Bpq0z+jcBkEu0R3ClLtJ7GVBRGVtdFUuq7PST/bUJ2054sy+OUj/hQ7FFwGsUkseqaI+oq
	bQlG6ZPTUaH/YWBVF6JrE3/pF9HYAXbk5fxAgXpkUpnFCpRQbEmj4/BJ9g1D4egca3
X-Received: by 2002:a05:622a:406:b0:501:426b:d497 with SMTP id d75a77b69052e-50741f9c7f2mr34651541cf.52.1772069822560;
        Wed, 25 Feb 2026 17:37:02 -0800 (PST)
Received: from I4-L-HQH5357-01.ad.psu.edu ([130.203.159.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507451cda23sm6638401cf.18.2026.02.25.17.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 17:37:02 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	hdanton@sina.com,
	vadim.fedorenko@linux.dev,
	simon.horman@kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH net v3 1/1] serial: caif: hold tty->link reference in ldisc_open and ser_release
Date: Wed, 25 Feb 2026 20:36:42 -0500
Message-Id: <99a19d63fa322bf21463de1671085655a3f444f9.1772055898.git.shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1772055898.git.shuangpeng.kernel@gmail.com>
References: <cover.1772055898.git.shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261114-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,sina.com,linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EA8B19FDE0
X-Rspamd-Action: no action

A reproducer triggers a KASAN slab-use-after-free in pty_write_room()
when caif_serial's TX path calls tty_write_room(). The faulting access
is on tty->link->port.

Hold an extra kref on tty->link for the lifetime of the caif_serial line
discipline: get it in ldisc_open() and drop it in ser_release(), and
also drop it on the ldisc_open() error path.

With this change applied, the reproducer no longer triggers the UAF in
my testing.

This issue becomes reproducible on top of 308e7e4d0a84. Before that, the
reproducer typically hits another bug first, so this UAF is not
observable there.

Link: https://gist.github.com/shuangpengbai/c898debad6bdf170a84be7e6b3d8707f
Link: https://lore.kernel.org/all/20260215025141.1106576-1-shuangpeng.kernel@gmail.com/T/#maee804ef687b4442f18c74e8801f5cde421ab000
Fixes: 308e7e4d0a84 ("serial: caif: fix use-after-free in caif_serial ldisc_close()")
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/net/caif/caif_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index b90890030751..1873d8287bb9 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -297,6 +297,7 @@ static void ser_release(struct work_struct *work)
 			dev_close(ser->dev);
 			unregister_netdevice(ser->dev);
 			debugfs_deinit(ser);
+			tty_kref_put(tty->link);
 			tty_kref_put(tty);
 		}
 		rtnl_unlock();
@@ -331,6 +332,7 @@ static int ldisc_open(struct tty_struct *tty)
 
 	ser = netdev_priv(dev);
 	ser->tty = tty_kref_get(tty);
+	tty_kref_get(tty->link);
 	ser->dev = dev;
 	debugfs_init(ser, tty);
 	tty->receive_room = 4096;
@@ -339,6 +341,7 @@ static int ldisc_open(struct tty_struct *tty)
 	rtnl_lock();
 	result = register_netdevice(dev);
 	if (result) {
+		tty_kref_put(tty->link);
 		tty_kref_put(tty);
 		rtnl_unlock();
 		free_netdev(dev);
-- 
2.34.1


