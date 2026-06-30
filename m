Return-Path: <netdev+bounces-303328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VlfdONwJRGpTngoAu9opvQ
	(envelope-from <netdev+bounces-303328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:24:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A76E72D9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:24:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=B6h24mVW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303328-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303328-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D6C330A74CC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40BE47799F;
	Tue, 30 Jun 2026 18:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F73F6C3D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843700; cv=none; b=lRC5HvYIhEpa/cXQDMc2JgrscM+U90L7GJupP7X3kOQsa/BPLau6CiG0IJyURTKXOyfvvzohJ6/h2txEmOoJUljRHO43uz+eTgnYZnK8VMffexU2Ai2HuGY9YUCRXkq0G7UbWr0ieSK5Zi1LIyWC5llKAeP5dLdULJHlSBFC6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843700; c=relaxed/simple;
	bh=k8f9Ybe0sB3z35sO/LdQgs/kFKGLgZdTLy5Qv48lClI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teWBUkBvpKWEhvILMYO2RVQfHg0fOibURzNnR6pOGD0rSIOk0TnN6pDclbL+Bp58Lzz4YPCgoe1Rcgx/ja2XLBwUaQPY70vwPMra12haVF4AZlboNwHQ5OmLJG6yr/O6PDBBxyTJD+xubnju1O62Bb42rSIem6TSiWRM6PMSt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6h24mVW; arc=none smtp.client-ip=74.125.228.0
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c88c8dfca3dso241031a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843699; x=1783448499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypiM/OLEFB9eP/sC6o3RqlF/MIMYqtwsL4EuhWu/WC0=;
        b=B6h24mVWa6A8Nw/dtna6AEZJSQCmbTR8hKxqicvyAv4rKLF1GJUU1VoxKEuvNduWcB
         tAe/aGR82vwB0tNXESdSHxQA2DhpTRjGw6SrDOp4f7vCR4rd5CDb7Fu9QOzQhud6pMlS
         qBdG1OKBZWv0VmKOtK4VTbFohglLgGw+D0NI4bI+K7jXLorSQnmEPtEF7XcUQwWvtK1C
         GMQ/6kKuek0X6COyrCBc/uYP1aGVaqMwMhugQlNxBOeiQpyf13aXY+pPFMBNS+eXpm1Z
         BgudMCpkk9YGAVo47A/wyTyQqbqTD+edUjiJgmkQF3F8+joYhpI0AaZ6xwDwt+otlRxj
         uNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843699; x=1783448499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypiM/OLEFB9eP/sC6o3RqlF/MIMYqtwsL4EuhWu/WC0=;
        b=Y5ENPZlVQdHh5D1Hdq/Xr+Z4AbbmzxDsmhqj7B6B1m22qbwm6WC9UokQb2CxjZGlqu
         cYx4Fg2sR/IleaX0skmlvULiB8zMyUhNHJWb7/rvHFSd8SBeTFcdVKAkUVP1C7HeeaXe
         U1WdvmE+joTT0mwfVBZEiYM9akckfiNSfrzv8uvYSIVrrpQG5fLyzDIRm6KPbJpO/VfU
         QtXvfYS1SFGmBFSDMRHv5BWf+m20JLUNjLrap5TZjvoV4g9OKqV7VJ7ug5mjbcxsKdi6
         AZwY/iNm2sTE49QMZlyRi313kJFPjWCcieu6RZbcS3eYlLttfkWlTQ+FjO+TwrWgimi5
         O7hw==
X-Gm-Message-State: AOJu0YwdUkT4zc9wdBC8Q8etjyOWwhOo+95V0v+UyjMt4epNzku0flGd
	2C7ncwyEBocL5EVSIU3/nfkw2k9O8RkW75QwPWdh73xnwGpZJ7ULQ5PymYHQAHlQ
X-Gm-Gg: AfdE7cn+Pe9Gah4r5kJZM8C8eyzr2dDapDHoEeJ58vihjz0XtGrnThp75Kd3Rq36+Cn
	q3vXjZcNm64gJgP6tSxI8O7vZaEHHbsjr4UG0cn6J1IO14dyHAgtWAWDoWv/JDa35IIj06E1I8M
	M6wj+OqiZlvjZyYDb3fTUYhu+zSlpqsTDcpeA4uzl+d/ZxdkhOkl3QB70xBrteaIkt8Wwf0A6+p
	NmamljL4CyRAnSvx8BWVwd8q3J/7rySpixRkBQDPfx1pQzW39xTHw8YprZp1nYXPdvkjtmFEUvZ
	GQRmpySjIr0Ki23H2EtC/v7LWL55EHdkG8xWpBRk4dP2K3EagqvdJgiCJU/M05cLkvJpAPBOkpV
	FLEUpP4Q7l3RKOHSnkSxB6pAKWi2QNUTFgzrHrTpBQr1oEFNwk4LdWxWBd+g9YBoXeOyejQCVSz
	an/2IM
X-Received: by 2002:a05:6a00:4208:b0:847:8f33:b159 with SMTP id d2e1a72fcca58-847a81a36b9mr2052670b3a.10.1782843698886;
        Tue, 30 Jun 2026 11:21:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fffa65bsm2631468b3a.21.2026.06.30.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:38 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 6/6] net: document NETDEV_UNREGISTER unlocked rationale
Date: Tue, 30 Jun 2026 11:21:29 -0700
Message-ID: <20260630182129.1601784-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630182129.1601784-1-sdf@fomichev.me>
References: <20260630182129.1601784-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303328-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B4A76E72D9

The lock-state table marks UNREGISTER as unlocked without saying
why. Add a short note that many handlers release the lowers via
dev_close().

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 1bb68a73bb67..761cdb08bf0f 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -427,6 +427,14 @@ For devices with locked ops, currently only the following notifiers are
 The following notifiers are running without the lock:
 * ``NETDEV_UNREGISTER``
 
+Many ``NETDEV_UNREGISTER`` handlers release their lowers with
+``dev_close()``, which takes the instance lock itself. Holding
+the lock across UNREGISTER would deadlock.
+
+Moving UNREGISTER under the lock is mechanical: switch those
+callers to the ``netif_*()`` lock-held variants. Deferred to
+limit churn.
+
 There are no clear expectations for the remaining notifiers. Notifiers not on
 the list may run with or without the instance lock, potentially even invoking
 the same notifier type with and without the lock from different code paths.
-- 
2.53.0-Meta


