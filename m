Return-Path: <netdev+bounces-268753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OBpITTRuWnMOAIAu9opvQ
	(envelope-from <netdev+bounces-268753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:09:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC892B2F45
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFEB8304935D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23DC364E84;
	Tue, 17 Mar 2026 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZriffEZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BD363092
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785385; cv=none; b=hU3dKjxhkIMVLGHmHB7fzcsiimN9gan8TcbzNEBlE9wv75wOPguUWz+az6lRdDlHOTEWP7v5cyW9SExJdUo4PZb6PftqdrGkv76Gt8wHdA/zEuNyIzIQxp6Zf391S3ahUfAlf3XEwxOhVrSALHJ8A3uU5cshygAYzK+O7Hq+oeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785385; c=relaxed/simple;
	bh=ccqpQikEVGKBGw0ltsN2mllZ0nk/M9oUDNdcseB61A4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ukj+An2aZuGH0WCor2hokI87FgBqRsaFydoyDPMHsBd59bQt5JpFcRB8dUYgeoQhFf8S8WpE9KUdm31aJOH0sJgPSEjt8bMe4pcTeF11dm/VphvOnuxx11VxW2cLs7MthJqESL2i6zw9KfvKzxVwROIjZh5+GjBj1yj171OEZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZriffEZ1; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7991db3dc98so60275977b3.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773785383; x=1774390183; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XDkvz71rFjofuSbw40JV4KJk/HAj2618RlBdKEjDpw=;
        b=ZriffEZ1JTumtpp2UjboKELpyeEU9UtZ9fdojxUK3Jn67kMP1DhhOcuW0uGNLZwqFk
         uBdnhqLZiQuaCiIr19ONg5Pe1ghFa0KB/HZC/LuZwM8Pp2FdU7hHx/hDyPOp2XZzvmW4
         Xwx8Ft1IcEmVPZ9dtgUp9Ulx0NrJDIhoi3tnZa6acn1I4O1LlD7il0NTFzlPWehQgkF5
         gLaynyCXpdTkIcGLPohNj6yQuEBieusJdNLLNRvzm6hcuc6w3H28ydHsxpIfC7/w38Z8
         4inv3J3PZipPAsx3/71vhx3FbG16K3lrRcHbZC9/9ytTHzYzgEVdbuXZf/1vLmjrQx4b
         5+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773785383; x=1774390183;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XDkvz71rFjofuSbw40JV4KJk/HAj2618RlBdKEjDpw=;
        b=sxp/NViEZgdgG926ndAhbEtogCoGOtBlefS1PaQUES4dQ4k4jIxVALveRdykVNJSMH
         w79ObDH9tMfwC4hcr3Vtx0vPYIflBiMPUCkrh60CwDYMLRNqDPjjzkRisR3/BDe9Mtz7
         Da5EdQoI9wxFXybH0fvYnYbspwyG4tfL3Lz0Cp3yeum9KuE54h/f/DadBWOpe8/TxhAT
         eSfTvXxEpcQ5l5BoH2okV1AePxNYAUmDU614ScNxKM4rUjC46oU/82gd/lpKkwySAf5p
         21QPU1T1Jiz5QLrUBXiFaMfwZ5hqragkcQrychz41SFcyl0T/yawGvnrU8q3DjHh4gy1
         8kgA==
X-Forwarded-Encrypted: i=1; AJvYcCU3I/viAGVvj3oNn2ENLJ5nR4HxmNlZaLhN2tIdM5F/qw0Z/gGNEbwU/iQYRT9EKRYsCJ6wZrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+Jx4kWueBjeXnosUQj6gTe/sx146aY7SBKw1w9eufmJu6/tw
	8xUgRBEbNMpg1Jp4cBYxyfJ15+wvPeq15XOPTS9SeCsC8CXlIF/rQMdV
X-Gm-Gg: ATEYQzwGlwV6zpfLLZAltN0+SJJvGolxF8CTo8mWUstaRbrkg2nqfYJPiJRW25PADTC
	VzRJKK6dDHopJelAmq+s2ZbCmfqNddpnsyB0uw7BEJCbeDI7uyTeOq/n47Fb25jDNGfFoAiCyfx
	ngelUEmpkGE/YDHanESCvKXGQoejQKvmeFke/GRugrEhxLnSu7dl8jD2BF4oJAABVyxwEp02Dk/
	pGEwHs+P+EhNhah/hM3dPtecdTIO9e43xbw3ALHC0AQCt6bm7e46rDmJQV66u3xlCiu7iwX3e05
	iesV0Cty7QrWJdlGI09nXeGBD9gKLwKrlUT/FWCfr2uMTEeF9S5MZTwumv31d2J87NA0RkmhdVR
	ddmiNshx8nT3+9CqbHmm4EI+VmWEZ+BpWiQcaD6pWKtzhUw4NSSH9x6j69c2AdGG15467xC+xZh
	vP+n3ekDgXOHyW/XNCk5PRFg==
X-Received: by 2002:a05:690c:6d81:b0:798:4fa4:c6a3 with SMTP id 00721157ae682-79a71dbae09mr11240077b3.62.1773785383515;
        Tue, 17 Mar 2026 15:09:43 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713d1d29sm5642337b3.14.2026.03.17.15.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:09:43 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 0/2] selftests/vsock: support nested VM runner
 for vmtest.sh
Date: Tue, 17 Mar 2026 15:09:34 -0700
Message-Id: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/RuWkC/42NSwrCMBQArxLeuk/yKdVm5T2ki5K82iBNJC+ES
 sndxZ7A9QwzBzDlQAxWHJCpBg4pghW6E+DWOT4JgwcrQEs9SKMMVk7uhXUrxAUjcSGPS9iJcVS
 3xffezOOgoBPwznQCsOIBkX72XmDqBKyBS8qfc1rVyf/oV4USvaRBX3tn1GjuG5X54tIGU2vtC
 5rA4hLLAAAA
X-Change-ID: 20260313-vsock-vmtest-nested-fixes-918fd4d3a961
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268753-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DC892B2F45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes a few issues trying to launch vmtest.sh in a nested VM
environment and were discovered when trying to prepare the tests for
netdev CI/CD.

When taken together these patches make vmtest.sh work both on bare metal
and in nested VMs, regardless of the outer VM's user, coincidental path
overlaps, or filesystem settings.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Address shellcheck warnings (Paolo)
- Link to v1: https://lore.kernel.org/r/20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com

---
Bobby Eshleman (2):
      selftests/vsock: fix vmtest.sh for read-only nested VM runners
      selftests/vsock: fix vsock_test path shadowing in nested VMs

 tools/testing/selftests/vsock/vmtest.sh | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)
---
base-commit: 8f921f61005450589c0bc1a941a5ddde21d9aed9
change-id: 20260313-vsock-vmtest-nested-fixes-918fd4d3a961

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


