Return-Path: <netdev+bounces-298777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z4GeInZZLGoBPwQAu9opvQ
	(envelope-from <netdev+bounces-298777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 275C567BEB7
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:09:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DxsG7OTA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298777-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298777-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 012FD30C59E4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961B3A7F58;
	Fri, 12 Jun 2026 19:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5139B94D
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:09:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291363; cv=none; b=b5wKDU/I+/yVKeLlu/JokXWOOiP4fTcXtoXdOyihFfN412Fj4bG+nlqhE0q62Aq+4J7v8MwgZCzxn0j7FxFGYI+dQpRQgbqN4FP6e2d93RQNPfksYymk3k8mpuzxJ5x3PzaeDsS50DYgPy+FBIlgiep7D/E7dB5MBjWpUUdc+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291363; c=relaxed/simple;
	bh=yKA+ZzX6XcYhDv+LWR2Mk2bht6hMBJSX9q+2jBi6BiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZC29K87xRw+QzPzjDyphUNRxp8ynEMocJvj68ixqGNsqrjGvZYDY4mckQnbHu6YSeExK2UOCOHMnQuUc/1dKxlLCfwQSlIgWTmSh8kqYsaxak9WZCzSuUq0I1J1/VnFoD4vTCpjjyi7Hi9PvaDnu0j9cp9xMNI81avWrii2O4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxsG7OTA; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c40397e746so6813365ad.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291361; x=1781896161; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4L3vRJymTPS0qt6L5cUW7zrlkl0+scsI7rVDfbLQutE=;
        b=DxsG7OTAfEswUiofcEZgU4C6MGzD8OlDzXfOGJAfD+skZOWyZlxsZvHwTOy5qhLJoS
         lni68xIvEl8xAJ1XoGhwb2NWe1n/zwdKDSgXwsuTbSGSt/QSB6jGh5O9NZg1rShQnS2S
         7DN1MSbo5iL3R08TPX3obYlyV+kZ20U3vKqcU7YD5tD4hhEtvW72D1HGleGNNb6M58M5
         sZFzq6P0Rkq380SS7NbI+KQBvrOEgojY3KjXS5vfINOjFBtKcg12IpzYq/BVDcOyhTrF
         Ue6D7U2lqq4hn0wpS55Et64hQ19ZdKWo6JWXMlq785B6La1vu+qil6hkO+lqOLS5HL47
         c8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291361; x=1781896161;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4L3vRJymTPS0qt6L5cUW7zrlkl0+scsI7rVDfbLQutE=;
        b=EBqp2iZvUjDxVwABjQ3bHu0YdE8EK5TN2SItne60gQkQcZ0xtGYlXeTrdyziBx+now
         tsojeSGW3KteJJbciZfbEdWlCM1u4cieoIChjsoZvANSAnhn++t6xX8ZC8GiQmhgNrMA
         t5KwhPqsz89KxVeI7+/R9inK57+BkUkv5tJw/7Km0HMShID2f+MICWT8M16YcgUw6Ecl
         lGyInOsJgVYR6lSG1TtRrK2yZKAk2CoT2OXbPXkLomEDzFnz7dmLc2LXxXN46+UtSnNb
         Xb1zNWhBPtzhtRp0oKHEUbYw1xFgoUdfrMB7srlZHDTZ6Q0jdDGYZKGnBt+TGvyjPhqW
         5s/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9QpbeNDWmZzIA1zBxJZParE6IQ28+oLcyqs+qoN5pNFmshBRA6cR9vQV84OYGlN0zsKAZyOmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypIh/TBFUoX4WnNenjeic5Mp46bHtgTJPLJz+YvTPXdB9sIejJ
	I1Rl+l19Iifz7vp/f9S6fGRA4hkew34T5d6/1xP6DON9lrEcPEoxiCdA
X-Gm-Gg: Acq92OFs1M0jDg+IQqPFoc0uXA9FwgN8OEfIUT1H34kIPz6b7mVw9mpJGi1aHhyd6/s
	c/Yji87SpBJC8YlNkwtBMWciXCuGVPgfnAr28y6id94HEMbyyqRER29gWCLSUoUCiVsWxxXgmEY
	YSV7bJjXHwZf8zQlxg80Rmmw4kplStlZjV6hyN6CbNEl77paV1YUnWNnikzr+YJsW29+5vB8I1+
	2+TUbzR7bSFpmuT+YSIVDC5XkVNhkrXAvNxKGZryY0NYVm6WwYNGCy2nwUOMqrdX+Bp4OrjCCpK
	AzX1tMYlaJJDsgnUSZ5zJs77EqLZOeLUJZWsmOVJzsX7/6H5cI8RybtK2KbVO07y/stzFJbug97
	8rMJfaK+kjyCnRGz1ShoL6XDSBL1I5y/MVvVc5SKy8yl1iYCzft8+7a21Dp8kd0wN+bAYtIvWtS
	4X65G2kYznxMmvWJSo6bc=
X-Received: by 2002:a17:902:ce8f:b0:2bf:11ed:3d64 with SMTP id d9443c01a7336-2c411c7997amr52161945ad.18.1781291361424;
        Fri, 12 Jun 2026 12:09:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm27661395ad.41.2026.06.12.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:09:21 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/2] selftests/vsock: improve vng version and
 quirk handling
Date: Fri, 12 Jun 2026 12:08:40 -0700
Message-Id: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADhZLGoC/x3MQQqDMBAF0KsMf+2ABiqYq5QuQvLTBiFKMhVBv
 Huh7wDvQmcr7PByofEovWwVXqZBED+hvqklwQvc6OZxnpwefYurGrvpd0/BqDkGLjlHpofDINg
 bczn/5xOVppWn4XXfP6AnZaFtAAAA
X-Change-ID: 20260612-vsock-test-update-fcae9ffced52
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298777-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:shuah@kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bobbyeshleman@meta.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 275C567BEB7

As vng has continued updating, there have been two things in our
selftests that have been affected. One is that newer versions always
emit the vng version warning, and two is that we have a workaround that
is not needed in newer versions.

This series just updates the version handling to allow all newer
versions without warning and version-gates the workaround to only those
versions that don't have the commit that fixed the root cause.

Additionally, we add function for comparing major.minor versions which
is used in both patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (2):
      selftests/vsock: accept vng 1.33 or >= 1.36
      selftests/vsock: skip vng setsid workaround on >= 1.41

 tools/testing/selftests/vsock/vmtest.sh | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)
---
base-commit: dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6
change-id: 20260612-vsock-test-update-fcae9ffced52

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


