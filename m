Return-Path: <netdev+bounces-277282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNzoIW+p2GkhgggAu9opvQ
	(envelope-from <netdev+bounces-277282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:40:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1DF3D372F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96DDF300D746
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95FA3A380B;
	Fri, 10 Apr 2026 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="DDqneyPw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1733F38A
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806823; cv=none; b=k/hgdDP46U9l+1D+f7Ocq/almlaCnb+43TDgxEvnElth3hPrC0RyzCWmvWUNrn+Gxfxo3tQxZ4h6yaD2u2qrGK7k+QW5Q83xTLmc+3LBNiLO/hvW6U2dIkAz9HvtjkJNoG4px+tM/ikaCA9xLK0RbezCjTtzFuRAFtRDlBACtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806823; c=relaxed/simple;
	bh=8UVGLM3tCk8JI921O45NinRZAOpPG+OzGI1sC+NEJG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=giarVf8nyHEmt0MI5SUFTb1C+CTTqmcRGRw7y3smQD8mpG51cgjcD4mceutVA43HyWwzwRNJdet5aktjttYgYZHLYIz96d0k2lvacD35STOvybiYYorspeFN20DkQyiVHQ/qvAmpxdhUZ9VsbbU9m+/V/UEpmaxB41f9/VgFikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=DDqneyPw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso167880a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775806821; x=1776411621; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdQm+7qKkQGpWz/x294jzIY9WDuqqRzuW6cUPd5hDXQ=;
        b=DDqneyPw+A19EEwKb72/XWhva+QCysn8VkRNUpuyMzvHReEm8wronogJpULCV29X1a
         dQub90M4DlVhSSTYCWDXFl8sGKt7SlSrmhyZ4pOJUsQuVXU/Ez9J0ZzGXYQbTP+pKyqw
         NDyjoasw/qa/aTE3I1xWz9edsqFsxmbk18+/LGuQFZag8L2lF57F0DnTFl0nSrk/GGib
         M68cO33vggQPkkNeOU7D1hBr9VvcGElUvVZnJemYDgC+gIEAHtmifMjkwbp/Xai3TleD
         wkqPC6FjkyN5I1FF4fWvFa4VWrDO1qyHhxC7tTkG9Iia2DEtayXyShOS8IPqU2GhGJsL
         +vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806821; x=1776411621;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdQm+7qKkQGpWz/x294jzIY9WDuqqRzuW6cUPd5hDXQ=;
        b=XcMFXMQ9ttpmAPXPReNhQz2EN1CYTYkCHbhqrkA42zmZ8MShEp6heydeqX4+CjLx+A
         ytKGAXr5HEwRPIbwZBKK/rXF4Tn/OAWOjCLHpljBlbrBwQxoz6yCCS1Ueo8J+gHbHK2l
         2sRwqLgU/ti1v5GYj9bJfuUNxZ86cvykm1wqVvcLs507kEKWA66Wvdi0yEnweeqa7ZOx
         5jHasjJ8HDs7kfIo55lFXgRBpTF74I39ciSS6iMcAzyZKS0/bEmrlHXWtOR3mh+jqIbh
         NlDrb7iutTMMfcNuFuQeqJWQLXs9BrfJy352PsWjy6htFpQKlogRFYLa0KxhsTotDahI
         t6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB24IuM+DkOQZVAI/+dEoaBXMEUGNtqA/I8c/eqrcafJno6tK6TCk9xcDxFx6b9Zh/f4gR5mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nkPghN9UM2jRPLQrwBZWNQZkciYcvPmPxpXy/EP6JswC4f3l
	Nnm1vyWrmnDsL0VBQ+r0ieTcuWyEZM0RsAy0C+AUFrIrtxnEzZGze8GMbg6U5QxSeFU=
X-Gm-Gg: AeBDieshQCrdHOkJHBILfqhO7OgkNOfxAGC44IbrFbyKCFVPbFu27kn1H2eMsDv1KUn
	xxPqvTeZy1pL7ZsL2/LMmQ5RrqcMAS2ePHVRFg05KqJMZIoqQGSvawDCgMdkF2U8VGal/7JX4xY
	NvBSmDjdoeJbmd1bCedxcmcFHm8yzUliUOQ4p5oHCtuFn8WrDezZ1a/tbrSSVlrVZ6qIVNvBg7U
	jwl7wzf+YgXIP2UUlGoIx1R+stZuwsKV7MPBg+jfWa7EJs00wrKDPwhmMSqcJbJbCq6anybFcTu
	Cf2tQIeZsrXimna8jJK4HbQXGsXQHPMQZIL/IXU4KUIeW4Ww8ScMAizDpOmcLC7WDlwimA/H8k/
	vqg11Du8YfIs0qUiIrmThBEHP9N8tdD4MX8JfN0xdQR+6QayoLFuUoGEsstiveJ4et+HikmqDhS
	DC2r2N4dpD3duJBRZeIaEpzOTwVBxxWHbMJEYBpAwL8ngyYu31gncSjLP9dq0Dbi4Jimfw4j/ed
	k88ZQ==
X-Received: by 2002:a05:6402:4548:b0:66e:44e:3103 with SMTP id 4fb4d7f45d1cf-6707931e447mr686513a12.9.1775806820681;
        Fri, 10 Apr 2026 00:40:20 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67070815a1dsm400310a12.22.2026.04.10.00.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 00:40:20 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH net-next v2 0/2] IPA v5.2 support
Date: Fri, 10 Apr 2026 09:40:06 +0200
Message-Id: <20260410-ipa-v5-2-v2-0-778422a05060@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2Nyw6DIBREf8XcdUkQUNRfaVzwuLQ0ES2gMTH+e
 2nrcjJnzhyQMHpMMFQHRNx88nMogd0qME8VHki8LRkYZS0VNSV+UWRrCCPWdZIyrTvFNRR8iej
 8/lPdIWAmAfcM479Jq36hyV/TxUZ8r+UtXwOtEhIzT5PPQyWY67UwLbq6R1lbZqTttbPcNJRLK
 xwKLpSVMJ7nBxOCLQTCAAAA
X-Change-ID: 20260410-ipa-v5-2-df8702bb8a3b
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775806819; l=1265;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=8UVGLM3tCk8JI921O45NinRZAOpPG+OzGI1sC+NEJG0=;
 b=e568NAGenV1WUAKn4vo+K9IN+7el7pXrpPW+HhtT5w74qciWXF6gyyTjTzbDTHSh8Coul31XR
 KQx+9WomOv1DP0aQNzeQJd4US2vLaTjWPNIWMMudNGMMW4Hb7pwwlDg
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277282-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:dkim,fairphone.com:email,fairphone.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 8D1DF3D372F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for IPA v5.2 which can be found in the Milos SoC.

Note: This series has been split up into two, one for net(-next), one
for the qcom dts bits.

Changes in v2:
- Split the series, drop applied IPA fixes, mark as net-next
- Pick up tags
- Link to v1: https://patch.msgid.link/20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com

---
Luca Weiss (2):
      dt-bindings: net: qcom,ipa: add Milos compatible
      net: ipa: add IPA v5.2 configuration data

 .../devicetree/bindings/net/qcom,ipa.yaml          |   1 +
 drivers/net/ipa/Makefile                           |   2 +-
 drivers/net/ipa/data/ipa_data-v5.2.c               | 452 +++++++++++++++++++++
 drivers/net/ipa/gsi_reg.c                          |   1 +
 drivers/net/ipa/ipa_data.h                         |   1 +
 drivers/net/ipa/ipa_main.c                         |   4 +
 drivers/net/ipa/ipa_reg.c                          |   1 +
 drivers/net/ipa/ipa_sysfs.c                        |   2 +
 drivers/net/ipa/ipa_version.h                      |   2 +
 9 files changed, 465 insertions(+), 1 deletion(-)
---
base-commit: 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7
change-id: 20260410-ipa-v5-2-df8702bb8a3b

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>


