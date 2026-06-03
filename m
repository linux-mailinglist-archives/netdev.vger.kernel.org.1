Return-Path: <netdev+bounces-294916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U7WqH0uTIGok5QAAu9opvQ
	(envelope-from <netdev+bounces-294916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:49:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5C263B398
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:49:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=I5RL9D5u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294916-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294916-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090C430D10A1
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 20:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A5481FA4;
	Wed,  3 Jun 2026 20:44:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75F42B742
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 20:44:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519451; cv=none; b=X58LznsC81w2mnJuAWQ7owdoZonnaaTnX92/wDEwhAbb39KrO3NyUnnoZ7nY8HcqwrVwQ6cpUxoGafHNVnyG+he3llIgiqjZGmtBKlTf6EoGhBTiL/QCz189VFHeiFspNBAgv3ClMTCPgMfI11HAjTWEidqem3A9ooiSY4bFE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519451; c=relaxed/simple;
	bh=amPURw1JjZfEDUE22gJ+bKOK7PktxrSxr1SHV7K3oHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NPr1JiseAqwhPrtn7QneSJtkUVQHMgwBIigSXm9pdKHCT24Njh5NixAbjeKQ6s54hrZuV/BUXAImh4cFy+IbvUP4lnPjs1oP/ORoSAlb8PZPL2lcIBdqsLemqerzlRsam4n7nvuz8FpOSvf0F/mysyLdTu5RKfzBe6uo5H8ORUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5RL9D5u; arc=none smtp.client-ip=209.85.167.179
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-48650c78e09so823177b6e.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519448; x=1781124248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIMHRKZ1kbgwP55bGp0c0OQ+sOxMVw/a+CoqATe1mLs=;
        b=I5RL9D5uhEAyzv9tsLU2FeMJxU9b/Bi54IP9i0s25oEq6IkiWt3wMeW96YdViiZypi
         QMTIfabDlD9IQcSkCES6tGRHJCNrtRBNrjOHnnPlJ/rj5W1jTuO6uLKufTvl4AhxTqo7
         HHLnF3x5Tc0jfyBsXetMUqdSMKBGyxxWWxaH/0Fxu7TNYRsN8DF5+39ZDetxVDUoj+aj
         Hrj1Wj5gk+XtMTrUaFqaNvmniHVHDe8VQDaEc6hHWz5RWWMF+HWNYmlCo6upyjKMbdR7
         ONK99j3x4hqqOrJTg/ylUFHJCtQP3tqpSsAyqCUEWI5aWdqpjnpuxkEjC6/0zfMXyf2i
         XkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519448; x=1781124248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RIMHRKZ1kbgwP55bGp0c0OQ+sOxMVw/a+CoqATe1mLs=;
        b=F0AcklCnoHTro2QPdR5bhCoPx6+oDAxHZOmS1CzG7v5rci5gwn+UZoiI9+QdRA66xC
         5/aZv6QoMbsb0mZBe+mHmZT0WAdULv8/i8bQZxFsX5sC0ZsOLfL9Ii/L247vXEC35txQ
         tmIYHUqGmPF5NgrSOiK6sjz+EYNsYAY/Pdi5QV1XKwzD55JbsqIpTWdTe5xank4t+50Y
         esIXGWFI7D88KHLhMlGUWsoUUeEJdCZxONGQUw2oDDLD9WjLjPWivDVxrxidEBHxfwe6
         5mmHneESxNjDl7bN2eSDvYzeJHN1povjcQ/MBL/PbuAziQiYIJLhkhmgR4b0SO5z9C4T
         pCyg==
X-Gm-Message-State: AOJu0YxvH/vmj64BxpJQuwNcSFMJf/uwPyzd6ao5Oe7abInX0kkoLyo1
	7C++xzss9+U+V2xl4LXidMAGHPVcE2KKUBcXu0ITmZSZiDhrVOa+YWUU
X-Gm-Gg: Acq92OFV6rI5ihtFy/AupAPUQ4HXdHp0Uz3wislH831++vxITY0xv0YUnzja1YUEYKt
	mdBRCWRN19SmXaDV2f9M9KVW51j2XCTAvsaSW1uXqQXR9yV2wHPvBjfkjOzTUwzKl0FTy9BwYCe
	JdcEClLrmEsF/Ni/yFQ3hanQRYj+Ax/QAmaPLoLSBNF+kc2yaia0TsvGEJdBA0eo1EHqmOFU0TV
	M1hSVPxCzv+74nykDiD7cBzJF4BJmRtmLNt+upGhvG1SFDxOBIDBMuAw0ROcfHvqRPOzoepI32P
	wjsnofH5hlyHakU+KP27MeU787bRdQj8VORRxCJZVcaXH7esMFO+lxQ89ei9Ujo0KJlXMS4gddG
	1tnE9wUSOOFBYgINScz+IhrqGiRpBkEcQtwU497eCP7J6HaFRf+aL90OuJv+OKgUrzk2ByubolK
	gaizwePVz/9YE1pb/UrEbEek+aJiqsWyct/ri3DAGzhdco6ds8oA==
X-Received: by 2002:a05:6808:1783:b0:47b:bd7b:10d0 with SMTP id 5614622812f47-4865aa81a6cmr2841639b6e.13.1780519448489;
        Wed, 03 Jun 2026 13:44:08 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm2667962b6e.4.2026.06.03.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:44:07 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Wed, 03 Jun 2026 15:42:21 -0500
Subject: [PATCH v2 4/4] dt-bindings: input: remove obsolete
 matrix-keymap.txt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-remove-redirect-stubs-v2-4-c8c19876ab64@gmail.com>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
In-Reply-To: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Akash Sukhavasi <akash.sukhavasi@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294916-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mchehab@kernel.org,m:olteanv@gmail.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:dmitry.torokhov@gmail.com,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:lee@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:akash.sukhavasi@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:akashsukhavasi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[akashsukhavasi@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akashsukhavasi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA5C263B398

matrix-keymap.txt has been a single-line redirect to
matrix-keymap.yaml since commit 639d6eda3b80 ("dt-bindings: input:
Convert matrix-keymap to json-schema"), which introduced the .yaml
schema and reduced the .txt to a stub in the same change. The .yaml
has the same filename in the same directory, making this redirect
unnecessary for discoverability.

Eight instances across six files still reference matrix-keymap.txt,
forcing readers through an extra hop to reach the .yaml. The stub has
not been touched since June 2020. Update all references across input
and mfd binding documentation to point directly to matrix-keymap.yaml
and remove the stub.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
v2:
- Patch 4/4: corrected commit message (eight references in six files,
  not eight files), Sashiko review.
  https://sashiko.dev/#/patchset/20260529052246.4934-1-akash.sukhavasi@gmail.com?part=4

v1: https://lore.kernel.org/all/20260529052246.4934-5-akash.sukhavasi@gmail.com/
---
 Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt    | 2 +-
 Documentation/devicetree/bindings/input/clps711x-keypad.txt    | 2 +-
 Documentation/devicetree/bindings/input/matrix-keymap.txt      | 1 -
 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt | 2 +-
 Documentation/devicetree/bindings/input/pxa27x-keypad.txt      | 2 +-
 Documentation/devicetree/bindings/input/st-keyscan.txt         | 2 +-
 Documentation/devicetree/bindings/mfd/tc3589x.txt              | 6 +++---
 7 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt b/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
index 262deab73588..33514eba0c9c 100644
--- a/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
+++ b/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
@@ -59,7 +59,7 @@ Board Specific Properties:
 	  subsystem (optional).
 
 - linux,keymap: The keymap for keys as described in the binding document
-  devicetree/bindings/input/matrix-keymap.txt.
+  devicetree/bindings/input/matrix-keymap.yaml.
 
 Example:
 #include "dt-bindings/input/input.h"
diff --git a/Documentation/devicetree/bindings/input/clps711x-keypad.txt b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
index 3eed8819d05d..5f4514c0cd5f 100644
--- a/Documentation/devicetree/bindings/input/clps711x-keypad.txt
+++ b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
@@ -5,7 +5,7 @@ Required Properties:
 - row-gpios:     List of GPIOs used as row lines.
 - poll-interval: Poll interval time in milliseconds.
 - linux,keymap:  The definition can be found at
-                 bindings/input/matrix-keymap.txt.
+                 bindings/input/matrix-keymap.yaml.
 
 Optional Properties:
 - autorepeat:    Enable autorepeat feature.
diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
deleted file mode 100644
index 79f6d01aecaa..000000000000
--- a/Documentation/devicetree/bindings/input/matrix-keymap.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has been moved to matrix-keymap.yaml
diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
index 1faa7292e21f..460b64d332cd 100644
--- a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
+++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
@@ -12,7 +12,7 @@ Required properties:
 - nvidia,kbc-col-pins: The KBC pins which are configured as column. This is an
   array of pin numbers which is used as column.
 - linux,keymap: The keymap for keys as described in the binding document
-  devicetree/bindings/input/matrix-keymap.txt.
+  devicetree/bindings/input/matrix-keymap.yaml.
 - clocks: Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
 - resets: Must contain an entry for each entry in reset-names.
diff --git a/Documentation/devicetree/bindings/input/pxa27x-keypad.txt b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
index f8674f7e5ea5..a727d66eece4 100644
--- a/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
+++ b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
@@ -10,7 +10,7 @@ Required Properties
   interval for matrix key. The value is in binary number of 2ms
 
 Optional Properties For Matrix Keyes
-Please refer to matrix-keymap.txt
+Please refer to matrix-keymap.yaml
 
 Optional Properties for Direct Keyes
 - marvell,direct-key-count : How many direct keyes are used.
diff --git a/Documentation/devicetree/bindings/input/st-keyscan.txt b/Documentation/devicetree/bindings/input/st-keyscan.txt
index 51eb428e5c85..fd88f40faebf 100644
--- a/Documentation/devicetree/bindings/input/st-keyscan.txt
+++ b/Documentation/devicetree/bindings/input/st-keyscan.txt
@@ -17,7 +17,7 @@ Required properties:
   See ../pinctrl/pinctrl-bindings.txt for details.
 
 - linux,keymap: The keymap for keys as described in the binding document
-  devicetree/bindings/input/matrix-keymap.txt.
+  devicetree/bindings/input/matrix-keymap.yaml.
 
 - keypad,num-rows: Number of row lines connected to the keypad controller.
 
diff --git a/Documentation/devicetree/bindings/mfd/tc3589x.txt b/Documentation/devicetree/bindings/mfd/tc3589x.txt
index 4f22b2b07dc5..a6d356e90f42 100644
--- a/Documentation/devicetree/bindings/mfd/tc3589x.txt
+++ b/Documentation/devicetree/bindings/mfd/tc3589x.txt
@@ -48,11 +48,11 @@ Optional nodes:
  - compatible : must be "toshiba,tc3589x-keypad"
  - debounce-delay-ms : debounce interval in milliseconds
  - keypad,num-rows : number of rows in the matrix, see
-   bindings/input/matrix-keymap.txt
+   bindings/input/matrix-keymap.yaml
  - keypad,num-columns : number of columns in the matrix, see
-   bindings/input/matrix-keymap.txt
+   bindings/input/matrix-keymap.yaml
  - linux,keymap: the definition can be found in
-   bindings/input/matrix-keymap.txt
+   bindings/input/matrix-keymap.yaml
  - linux,no-autorepeat: do no enable autorepeat feature.
  - wakeup-source: use any event on keypad as wakeup event.
 		  (Legacy property supported: "linux,wakeup")

-- 
2.54.0


