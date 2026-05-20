Return-Path: <netdev+bounces-290075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBw3NNI0Dmqt8AUAu9opvQ
	(envelope-from <netdev+bounces-290075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:25:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3759BF52
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DF8339DD4C9
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0D3403FC;
	Wed, 20 May 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLeRYqeV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01E33B6D1
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304864; cv=none; b=e6Z+1xhZvji64XbVTWTdP4xGeoTL2qzCcAYhw2H8Qc0FfsLlNwT5aDTKHRY4JeMHhoi2dQd1puebdepumaGkr2og4UXiqwEj6ESn+zbsM//QVkLrvGU2g1MMFMb1FJE/umtk4M1W74slDOXFSzbQEpo3z6cqT8Kt9P8FpHI7HJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304864; c=relaxed/simple;
	bh=Ml8+WIXJmSGrbqib0u5ulf7PiZ8NZS12P3rO01gEh/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PYl+It5he9Hzjtr20Dw7j1CLIuvAg2A9Q0de+e54zJ9WQwRagKfMxItY8KYpq26yNOrt0YI/2uK8jfXBcYiHi6EX8EN/krRQJ+xwMC8FYc+tahFScPnIprrPV4Fg5SyQqNqIps3nudy8ufx1CDjXd26USJI3KTqxaOBFXw2C8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLeRYqeV; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bde9d73678so53121867b3.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779304862; x=1779909662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwF/HhmYwf5QBeLN9SEfEOEh9juP5SjaaFwH3isu8iY=;
        b=WLeRYqeVpli5/TM8ddIWG9QHPs6THZEQsoxujNVTLRBAYrA81gzsMcPrJJKpgRNVUx
         kid0Go6Lx45PAzZRcKzvr7cHIqd0ai1AfBpGu0N287SLszRtc/+QFAURh6ZU+JRVuoQO
         IPLxDuhvNvA6THL4nL/18EkUgs0sETV95bXvZX/059FaIp/42AN9K3Gm3Tj2QXCSEZKJ
         MJd8VjVPvfTubJEIVUGRHiacXYO9fbg9uuKGmlmwgDh1NN7ZYJ18vcnuQXqBLEIgeyMr
         lI49F6dS1xWkBW/m6P5CYy/v45dSJzEbLtenA6WR7Yxk6oRoj7wDWrsMGhsy/z5sm7IL
         jXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304862; x=1779909662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwF/HhmYwf5QBeLN9SEfEOEh9juP5SjaaFwH3isu8iY=;
        b=Z6XGtfr956w5w2I+pEuXPYbIg7YUo5ES+dU5dPm7KFpi/4mHP4rUTA5Um+xijnu+RN
         HjckDiXqpd0uedoJxCs2cyw41IG9dIfJT9M49E6wGZ1qBJCCMEMhHH7I3AdpjvlNzfNW
         IQRxslk/wCspkJW36POcjMClJ4jDYDRHCDx+SF6J1TbDyDDOTeSQ5t0vWLM0zj7xr5kl
         4Ftzw+W32tNvZV58sMDt9T548WSS6vOZok9JIgJoXodXJcR9hHJuRqqMhLvDOCzXydGp
         c3TtrrYgqX6keFB3wIrxfGdz1PaLnCZOK2n3dKX78pj4dH17jbwMMMlAZjbeYKZKweT6
         urLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vhgRGy47q0CkDGdJN95g+11A965bKqCz6Ezqca+5LoCPobm0B9TWUdL+bbtn7LMhtphhr4Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFBF2EEFCATaIiWBdgj8862G3FoqiEuuMXDIqHNfx9tveAzcp
	E4c4jMGolWoA3bR+Oy4sNH5m8MBm+pYWAAhRHX/4bdDoRl6/On6yczw=
X-Gm-Gg: Acq92OGq1M+yJS0HNXDJLa8wggf6VzaG9S/CRPutUg5vk3tai3QQCWXtVfrA5lltAQ1
	UQCfojbXTs2kS1asrgMMIAwfRtKkaYlGXzhWlRAHw+4OKSkB165MFLKwDilfxNqLtZ+TqPAXxtk
	aLWRk6xOgJIYvTDwR6D9EMMPg5OAXYQn8qTr2b16mzxNz6budiMF0jvXR9yq1ArZmKyajkPrfwc
	Uegi3UBgWcnRBnCp22I6ThHfgMS/X2Pz4MsFztXDPzm4U9lOPUEbEzlef8CKRUPIFKIkVojF7ti
	WGa/PXTDrVLDbc/nAYIG94OT8vxMnSYUu7cOKT/qDdJRotyEodRmu/qsY4Cxt5Fg4GBKzmv3NR0
	n3EhKTGgoWHUKJmN+JeV90fvJCa9e5mzh8PgMTvSQ133eBoyN2F2h6rImxJq/oi/+gN3r+MUKwc
	IfE5b7/UFezv5DTzJXgUiJFgLiuloGcJsKtUwNR2HL2i4DlA==
X-Received: by 2002:a05:690c:b01:b0:7ba:ded4:df69 with SMTP id 00721157ae682-7d1c369ba38mr8993067b3.1.1779304857169;
        Wed, 20 May 2026 12:20:57 -0700 (PDT)
Received: from alir-mac.sitimecorp.com ([12.1.37.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18dcddsm56346757b3.49.2026.05.20.12.20.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 May 2026 12:20:56 -0700 (PDT)
From: Ali Rouhi <rouhi.ali@gmail.com>
X-Google-Original-From: Ali Rouhi <arouhi@sitime.com>
To: jiri@resnulli.us
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH v2 net-next 1/3] dt-bindings: vendor-prefixes: add SiTime Corporation
Date: Wed, 20 May 2026 12:19:41 -0700
Message-Id: <20260520191943.73938-2-arouhi@sitime.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260520191943.73938-1-arouhi@sitime.com>
References: <20260520191943.73938-1-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-290075-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sitime.com:mid,sitime.com:email]
X-Rspamd-Queue-Id: 6BC3759BF52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add vendor prefix for SiTime Corporation, manufacturer of
programmable clock generators and MEMS oscillators.

Signed-off-by: Ali Rouhi <arouhi@sitime.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..5e81b9bfa3d0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1527,6 +1527,8 @@ patternProperties:
     description: SiRF Technology, Inc.
   "^sis,.*":
     description: Silicon Integrated Systems Corp.
+  "^sitime,.*":
+    description: SiTime Corporation
   "^sitronix,.*":
     description: Sitronix Technology Corporation
   "^skov,.*":
-- 
2.43.0


