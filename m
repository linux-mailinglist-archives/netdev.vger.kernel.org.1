Return-Path: <netdev+bounces-286662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P3KLTfhAWq1lwEAu9opvQ
	(envelope-from <netdev+bounces-286662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:01:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B44F50F8C3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C9E5303B17F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462973F7A89;
	Mon, 11 May 2026 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqztsxt0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1EB3F9F3A
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507852; cv=none; b=psHmjL0bMiHSXSSus8gaxJUKuwweM0uEKPZytyfMc1j8+qCOTOU6s8CfIkQ63ic/vF//nGs0B9Z30YHPv2/r9ODW5rLGxTWFQYoDaw7aoZg8tZuszrmyMR+Kjl9RhQ72Mf11hIGUSrTHdqpzPbPzSdAh3Nfdx3Nkmdn1eTiYZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507852; c=relaxed/simple;
	bh=ibm/ZDHMWfIYB/a+JVogHL3zgQTqT1cxj2txge0qJK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8K/ogJPzEnIN9/XhQMrIvZ4tp4x3HlGWXKZWinOqbIz0cJROsYyoCkFqeahTEZ8m2GgoDry2Ea1eh1WeikHArqf0aKUZBXVqwVfWts5AYBHnoXwbdWOwhGw30k7TEbs6mYQOBzNStLahxo8T78dNMDuUNzLFsp7GgGw7ZAujZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqztsxt0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67e9e343b22so5011179a12.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507844; x=1779112644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yZ2RV9klSfc79KrOIT+9nKykbDSPRLRaZkXlnlwwJM=;
        b=Oqztsxt08VSED0yBq9y7gCvbNeIQsWzh6qCP6bEWpOdaH42iP9LOw/D6fGAQi8O7pP
         8+T/5rP9lXkGXz2utuy3yO0zDbfmXhzJypfb6BgwM6PSQX0GCpNEM14v5BFNjmOov3Gn
         vxaPdFefs6gvL0p3aCWOocLQqQo5BTYQrDwktwEq8VWzDpzN8toh2+prb+Ng2NNrP0xz
         XhX00H0+39dIbVI/dH+NyThiFKEqNozZZR3B+4A0iu+cG+u6cxhhiHfjz21bwZ3E+ghv
         4ZmQ7dgxb+4CkXeqhSUYaY50vct0v3vg3gyhxjPtxPBDVISq/a2x1EKKCpekXefD/C50
         KmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507844; x=1779112644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+yZ2RV9klSfc79KrOIT+9nKykbDSPRLRaZkXlnlwwJM=;
        b=Oup4klqml+iAHT9x//D373OzserQV8VBTmEZ1Nm5eL5lnFqrlA5HpZNJ5v++D+3h7P
         xnFlw7lrdXQ94TrPQo/a/kZfmoChyDeiP3oUjRB/w/RWeoXbzMLdH/c7KxjPzWEUKLQk
         lrSWVqyO08MFjcoU3tn7dh63ditGMMvc7gZR4ikn4E5Rcc9XNt0k9ltTzpFCwvchPpwz
         F+D94NqtkBEOeSLdOydWZ/VpQOZ1xJkXzGNZj7P8ZTTgnoJe1e6EGC0Zz96UoaPra1m7
         GeC+Q6j6/SLNQOibi0FoLFZ9FT0SOPlFrSqbwuHDjXCjy+j+nkm5K7BYEJ65XOzKrwkG
         Y+PQ==
X-Gm-Message-State: AOJu0YzVDlc9FAH00rc9ikLtgf6haBhbWDSmkjdpkxJRcjDfsMqxyElk
	bklLLXiZVUFpq7gsdGpk4N3TmAlW+MDejgFckV4ZSlIhJzCGJcqUEiIO
X-Gm-Gg: Acq92OEgwhqmyNdX/3KHJv+ld1BPyG5wM3SCl8j8Wzbc5M45zOwJSQYvY6oRZClpth9
	A1r266nN4QQix62SPHFwFTVp0Ne3JWdNJ8XhKfF1VGVnIpWfoJi3oLbzHmJoSeMSPPDsOR8mYW/
	4743gBIucWXZAWY+Rh/1wxv5uKbvsu9veqAKQC+Lr6kW0u0bPQyFBOGhDuGzZX1sHYWUSMoNMpv
	s+33JC47rydflGGiBxxkMZhz9JMa0vFovbNvQGEh+bzOOHdU5k/OYsfbdqvML7HugDDataHSmnx
	MfUDASfohc52q2gWDy4rwzadi7+9TN1uVFRjR3uPWpCV0pOX41MxFp0dxKi2o8LhT8dTQz9u828
	tAQXLljciMN4rSkabc/DaD4O/jOcD1M9FkQMuyXVImbvfQ8pzoIKYCcGuO3mDh/8VGzMIiAvj5W
	FV1obWRzF6Jppt
X-Received: by 2002:a05:6402:5297:b0:67e:2498:dc7e with SMTP id 4fb4d7f45d1cf-67e2498ddc9mr9228829a12.11.1778507844261;
        Mon, 11 May 2026 06:57:24 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3b904sm3685357a12.1.2026.05.11.06.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:57:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Chen <peter.chen@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v1 1/6] dt-bindings: usb: ci-hdrc-usb2: Document nvidia,external-control property
Date: Mon, 11 May 2026 16:56:56 +0300
Message-ID: <20260511135703.62470-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511135703.62470-1-clamor95@gmail.com>
References: <20260511135703.62470-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B44F50F8C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,nvidia.com,linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Document the nvidia,external-control property required, for example, for
USB lines in HSIC mode connected to a modem, where the modem requires
precise control over the USB bus to properly enumerate all its stages and
intermediate devices.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 691d6cf02c27..a13c1ef49a57 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -75,6 +75,13 @@ properties:
     type: boolean
     deprecated: true
 
+  nvidia,external-control:
+    description:
+      Indicates that the controller is configured externally and that the host
+      should not attempt to touch it. Usually used by a modem which requires
+      precise bus configuration.
+    type: boolean
+
   ulpi:
     type: object
     additionalProperties: false
-- 
2.51.0


