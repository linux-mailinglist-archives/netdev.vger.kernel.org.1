Return-Path: <netdev+bounces-300418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XYTwG0HiM2qLHgYAu9opvQ
	(envelope-from <netdev+bounces-300418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 14:19:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 323A969FF7C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 14:19:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z8Mri2I0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300418-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300418-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43E8630034BE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095A3F482E;
	Thu, 18 Jun 2026 12:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB03F44E0
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 12:19:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785148; cv=none; b=LpNFS2f9L3cW8T6BQgsNUCpwr8pL0Q47GRWHTtNRhKn1B9r9Zi1TAo5g6P86/ZzgeuQjL8kDkMH+fIgHovbw1qyq/jSu20FJO5Ah1DBKvdgYBvwasthhHiYiAPnbkI7uFofNuBeuG2PPjvIHh4v8QV5c6RUs3TB5YIX1rodfCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785148; c=relaxed/simple;
	bh=1h85HEiwu5SrvP6LXSFmCX8HYJCZmpF9jCx93UjL+R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1vZWbA2GHET3EZK8fB6L1Xrf4O3Xy5y3FBFDTwUz2oV0k0Y/VsQBgJGIJ8na6AUuplCh5UkJi9z6yoLEMlMn+b+kwmEtJ3KLb6a7wczhEZZtzHJHa+8rhdXvu6Cwbmhgo6GDJjjjgmh/C/fNrxyvUPhqI0LZpP9Fk21fClwtmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8Mri2I0; arc=none smtp.client-ip=209.85.167.52
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa68dbd44fso953234e87.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781785145; x=1782389945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqmSWHmzTjiXv/ea7OlEQSmT2M86q0mo+1Enkd+tLH4=;
        b=Z8Mri2I03uhCf8ZQU9bkmM3N7GPUTMl+4ZjPcsDsqcCmbkD7GJ5iQfCLQ0uxyOGklx
         nBDEYg0NEV/V6LOs2lO21+S1RQr2Pv799svKwZvOPke+3yjE0pATWAW6w2u8sLQ8V2yt
         Av/YJO7vXd30SByDTBmEtEoT8g9bEd7TmHgzBrVDLZwujwPBGYsbfDnmoLUxOqy1YPAV
         xxOoIkDZy/H/unUv97wFzSRKOpaG8Yyt3yB03HJZivotuBiZlKYJYFxW891/VudVxd2P
         O+SJCTAg6nVu7bUcGagB99IEzkNC18TDp0kUP6vTiPSVC+tGa8s9+VVzdRuf51KklwHv
         qDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781785145; x=1782389945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqmSWHmzTjiXv/ea7OlEQSmT2M86q0mo+1Enkd+tLH4=;
        b=K8pn0i/lZSoH8x/sAWYiPhVUGl2xJs0qNSoLjHTX17yWd4I5ER5YdTyFhyyJeQcy7q
         Op4BvU+RN6fx9GFi3LxEteCaYtycByFxMDrJFf6cFQGedCFUaB5mSbzkvCb+vkbYDzeh
         YvTmB0+xvsLWMWdwabqHG5+Yy3TgJlVsmNfJmRgs+94EyOys+OxTl2G0iacoAHlYpRfz
         ggE7K69CnP3hpV1N11BYgcPxa8fJ3iTam7ODFH7hXIGsGYp+i18d7lGn1w8KtB5ymI1s
         d2ey8Oof2xwrnQzmKABSXhn+q02tl1HpBgJqOpefzRUhptG+U4c2S/pktTaIh4DwgdJo
         7V7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/MNfN66E2Ny+D8QXwC27ov6wB08jMvoDiMYPx3kVnyJytTOG0T8QEQYILyV/htYvYRZgZ0XbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZy4Z6AV/CylircW7cLFTjU4lEbR2x8BdnyrPcPkPlGbexwMt3
	jU1b87/Rb+3KO3Y5ZlmJ6zS/R6NHO/THKda0imuGQ/rMA4DUyLRq0Kv9
X-Gm-Gg: AfdE7ckWu+m4kBvJHepsBienWrwIld2ZmwquS8me2G6+BfCzxmekZswwSnzvcZjBn64
	jgi6nv8C+TlckXzR7szogaX2vmfNU0v7Fm6485uhfZ+yIE8/3cC7wc3YlE+uEGrLuyj3QqQmNZi
	WEkypDYj//3szFfMGgvIG5BZ70iyjse/7oV1U0E2E41EHbZLYvcyGPS7duqPex0t4jaa9YvF53A
	RQ0tFe0ZPJl/A+F0y5myVAVnm6EMebQJRTFmx/bubZ6CRU6hPhuSpevbcj7ZMxBNvkSXmkJoaOY
	ASrE+qed6Y9bR8Fk/ZQfxekYD7M5q1FFmNRMtD5pPXQb0bYaDNRDHPMMwnBVspNVO/PUrFhNQkT
	JD+ZS8kvWt9cA+cmK7PLTEvgZObAoMrxbl8O6ooCMFtnb9fnxWvNXYJIcCTVSOnpCKwXaaGhnpc
	B7DVSVRBhzUYv+jEm/tcQUY7SuuTfERg==
X-Received: by 2002:a05:6512:3509:b0:5ad:3035:fa47 with SMTP id 2adb3069b0e04-5ad4dadd259mr879893e87.53.1781785144944;
        Thu, 18 Jun 2026 05:19:04 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad4eb57734sm657424e87.34.2026.06.18.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:19:04 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	v9fs-developer@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	lvc-project@linuxtesting.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH 5.10] net: 9p: fix refcount leak in p9_read_work() error handling
Date: Thu, 18 Jun 2026 15:19:21 +0000
Message-ID: <20260618151940.76321-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	DATE_IN_FUTURE(4.00)[3];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300418-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,ionkov.net,codewreck.org,davemloft.net,kernel.org,lists.sourceforge.net,vger.kernel.org,crudebyte.com,lists.linux.dev,linuxtesting.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:ericvh@gmail.com,m:lucho@ionkov.net,m:asmadeus@codewreck.org,m:davem@davemloft.net,m:kuba@kernel.org,m:tomasbortoli@gmail.com,m:v9fs-developer@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ericvh@kernel.org,m:linux_oss@crudebyte.com,m:v9fs@lists.linux.dev,m:lvc-project@linuxtesting.org,m:hbh25y@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,codewreck.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 323A969FF7C

From: Hangyu Hua <hbh25y@gmail.com>

commit 4ac7573e1f9333073fa8d303acc941c9b7ab7f61 upstream.

p9_req_put need to be called when m->rreq->rc.sdata is NULL to avoid
temporary refcount leak.

Link: https://lkml.kernel.org/r/20220712104438.30800-1-hbh25y@gmail.com
Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
[Dominique: commit wording adjustments, p9_req_put argument fixes for rebase]
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
[Alexander: this branch doesn't contain 8b11ff098af4 ("9p: Add client parameter
 to p9_req_put()"), therefore the parameter is removed from the added line]
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2022-50114
 net/9p/trans_fd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 40d458c438df..bd6a54e6f427 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -346,6 +346,7 @@ static void p9_read_work(struct work_struct *work)
 			p9_debug(P9_DEBUG_ERROR,
 				 "No recv fcall for tag %d (req %p), disconnecting!\n",
 				 m->rc.tag, m->rreq);
+			p9_req_put(m->rreq);
 			m->rreq = NULL;
 			err = -EIO;
 			goto error;
-- 
2.47.3

