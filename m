Return-Path: <netdev+bounces-279609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zVU7F0dM5WnvggEAu9opvQ
	(envelope-from <netdev+bounces-279609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 23:42:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E6425948
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 23:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAC6A300955A
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34353093D8;
	Sun, 19 Apr 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="tughlEy5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03186329
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776634947; cv=none; b=d0AJnXSXAUCFCmZ0GgXQzy/WHeqhccPeJsUEU7cmeiYL/obFONPkokvbDebhm8AK96ofVRA1I+NaJvdp/vCFxzqvEmp85/ubtlAOg2JieHLaqxJlsTQ2m2JsVZUjxXYYia7pe5fw5jmOhNVp5jj23Ymx0Ym+2JdCSD4chtv7o10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776634947; c=relaxed/simple;
	bh=gw6s3vnIxJ9uTCmH8z6pU2gzLZpggQukHai+xXAmDWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qd9BMyBtRXxUTBdhB7tU8w1QBbJyzBQNwt1M9G+f+jQKcq8y09nBqPmmKVKNJDipOB48SoKhE7p072QzFg15DUXfEwNcHMbKYFyCBo5z/fiYV59MQFJx92CmTI62vMqlsVI4tYM6KbZaWxA1nWNt8Z1CJt18vSO1WrnlnsA42/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=tughlEy5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so3222035a12.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1776634944; x=1777239744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J280H++whneAEaFqspPJ2mzFXuoS+YNva5vD0t3AK0=;
        b=tughlEy5MJ6YK5EUYyoQVyywKz5mDB5zZjcFYfQE/iQHtdeQTium+ZDLe6uoNVUQiW
         KVfnWui7IFQpBkRjiVKu69Q5NazgoH9GfeOv+SXeUGdj/REL6dfQ6eNfCrc7TAKIgaUc
         DJDUX/bLDLAO/tY3A6QvhlfJosgYBpM5t7zpAMxDrEHnZbqMFtCbBlbY/g5asxQSC8lX
         TWkTNovrEf+fgcDZ3bpTSC17Ugi2n+0/95gaDghLiieI0bOYfIJ3zk/VBF34pNyIqi7M
         CImqxAeQHJ4e4A81H4O9sdEihj+MluhNVm7gFOcdWbzj5qaWXhWNyZtG5TWOn7PERDWq
         GTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776634944; x=1777239744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J280H++whneAEaFqspPJ2mzFXuoS+YNva5vD0t3AK0=;
        b=P14AL6biu3IXv/IlVKFCwvaH/dqT2kxfIyrTE/1o6IGhxoXfUu3wxuaNwfNfEYR++e
         O8UgFMrrtSBMvAO4C/EoGCAiUviSwHf3QB+UClcEUI/PSsj5w3S3oXXRk1ktexACOH1s
         PY4E88W1n+9WSD6fAVzSxoO5RB9rEkpyU+x8gLoLCqiWVPKd3BmFx/7oFbdA3AycRPWX
         r6u4bB4hQ1iFIFh0eDUXKsVrcHBJ4/jWl5GY3QDa0Kz0mSaiPizj6C6ffQmZjTdSq4n9
         dGjEZMJ497m5ES89VRhcD1APvJqZb8OIRVq98AtvrTRHbWFc2eBtib34nrhV3fAYMTgN
         c/Lg==
X-Gm-Message-State: AOJu0YxFYs1ClAT+V6t3fvLr1d0yIlPg67BjQ26t4lLJBiVIDRftV3Dm
	fAu2lK+M1ynHQBVc/KE3XYfM5852UVo2YsWPsh33Pq2/j4a5VbMUtDCtNW3FcmL1P8M=
X-Gm-Gg: AeBDietlgzLrL0bkjY/+AgbfdzyYR4AYiM+7xQT5a36j/d3N7zsoxGSSnsyUQDsxjBx
	yPkYKWjVdst6hN4K+ljAGS8H3SQLuW0l+R5LfQXNe5/4ZAhdcrIhzlBMSDLE2wnqdSPyUy7LKgR
	98u7UB2R8o99TFah5W3wOwxor0EdsSAUSJA9xlpCPUPwk8ziFo+oQe7IEYs4iFumOM/BAcTE87f
	K48xULc/4vbRTbBOTUcVV74VqwIUj5gyEEibVN+/1nxJM52Hon/3jjS2VwKEFO0yX8RYr3xpttl
	8B7JB7YLE+lnio4dBizDx70Ewpc8VapqicCy7dKIyjNNsbD2g85T0G1Y5O+ogfz7ZM5EGGmbdjo
	ODTA6Rp+wItX2SlOhPkhTixHOtfUbA40jnKHct0ChROfUI638jw1raJXpwQ3mZa+WCVN2awLO+w
	9RV0Fv2XfihK/H+X3AuDWo1yzFKCOHnQ==
X-Received: by 2002:a17:907:868c:b0:b98:6a8f:7916 with SMTP id a640c23a62f3a-ba419557e44mr546980466b.15.1776634944439;
        Sun, 19 Apr 2026 14:42:24 -0700 (PDT)
Received: from airbuntu.. ([185.253.98.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45504441bsm279225366b.45.2026.04.19.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:42:24 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	John Stultz <jstultz@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] connector/Kconfig: Enable CONFIG_CONNECTOR by default
Date: Sun, 19 Apr 2026 22:42:17 +0100
Message-Id: <20260419214217.108901-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[layalina-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279609-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[layalina.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[qyousef@layalina.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[layalina-io.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,layalina.io:mid,layalina.io:email,layalina-io.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 760E6425948
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To make new tools that depend on it like schedqos [1] more reliable, it
is important to ensure users can find it by default on all system.

[1] https://lore.kernel.org/lkml/20260415000910.2h5misvwc45bdumu@airbuntu/

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 drivers/connector/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/connector/Kconfig b/drivers/connector/Kconfig
index 0c2d2aa82d8c..bad247d47146 100644
--- a/drivers/connector/Kconfig
+++ b/drivers/connector/Kconfig
@@ -3,6 +3,7 @@
 menuconfig CONNECTOR
 	tristate "Connector - unified userspace <-> kernelspace linker"
 	depends on NET
+	default y
 	help
 	  This is unified userspace <-> kernelspace connector working on top
 	  of the netlink socket protocol.
-- 
2.34.1


