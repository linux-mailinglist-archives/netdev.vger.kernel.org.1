Return-Path: <netdev+bounces-294912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XX3JJxqSIGrL5AAAu9opvQ
	(envelope-from <netdev+bounces-294912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:44:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F24363B2D5
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:44:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="eBhHX/bj";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294912-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294912-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF9AD301D84B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694D0407596;
	Wed,  3 Jun 2026 20:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A66403EBA
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 20:44:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519445; cv=none; b=MLOXYHMLSdRYmzjeVZEbcNvsOak8A/YX6Tf13f88gPhIF+UHEvVm0GEm4ganeuarz4Pt5topOOaudhZJskrYwXFxB6GrTxLy7T6pCk6ZMm4uTAJ5ETfsQVKAuoXuLBGtEcExpYUe8C9M3D+9s1/MDlEMpq5S9jXEEALQW2ve/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519445; c=relaxed/simple;
	bh=+JosnbZhQUF/MOBUAyqR6d/lHKYmP/5jY0EEF59+azs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oIM1ZUg62pe+pQwqWj4C3apXJzo1SLxDyiRBybt0rAYC9UDn5JAPFZeNYrl8SvtgZwbxMjCVpQvf4ZhJ65MgBYw2stU5M0J2VNVQEcipAB7T8h0gHNzHMMUAi1xbMtUCoxBfEMadV6hD6+RUbRScSAxkheVu/1hmw3tVNE+/ES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBhHX/bj; arc=none smtp.client-ip=209.85.160.46
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43d08bc82deso11921fac.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519443; x=1781124243; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IEf6hXj7f37DFxPYxn9sI96qJysjet+fYfxXFRG2SM=;
        b=eBhHX/bjUqK/bQgWs32lKFc+cdIrlG6bjDtdscaOc4jE8J3fMP6N6xa4MHb+aanQ4r
         vjdbiFEKLGRZgWx8jdRAt2PzEL0vjWQoxbnsouDIXQtzrul6Gxuu5eRXWMVcz+5n/Rhe
         jig4upRzejUnzDzQlUALFqK+JmJAoR8lz7Uw3U3SwruM1FGl3106LcTKsn/3yDD8FH/B
         3MSbKgu1iwmv1uz4BAc1vZBJ0hfRZTGZvVUyaUtoFLczTJCWd14PC4Nsc9C6lHppBbNh
         4pe3UUvDR5qWghr81ltPt45/kVmIgiN1XGrcWJ5QGk7LUk2PvpJL01qWrTkj+rolK28m
         xPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519443; x=1781124243;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IEf6hXj7f37DFxPYxn9sI96qJysjet+fYfxXFRG2SM=;
        b=g3YELqCb+Je1XVngu3wkv4lNO4P/Jtg0Qqa/s6c4h3NCgdW6+4MhCAbUoXmRdTF4Gs
         3UGMiHj/AbTAp7Sem0Hfaxk/GaGasB3UAvWsQ+vwmius3+fpc+mUUpNNGgDLpz80B9js
         4g24lyv3pLMBuuEfNaMG/uFoQRReDYzyd1VsGMr2ZjdIqiIiI+gmdD22c8o4SS8KTmzg
         6SgaS6STqcDvFTivHXnkmzyXJRhmZfNoJYSNLlG2yM2WuuS8ie3tHGJvT4xrd+LocVtv
         hZU8SBz6Di40jIwNFP9NZXYiF3dQ7i7AG+we6dC+7+W6G3IKlLybTl/wZAWLYrPqvhQd
         lpEw==
X-Gm-Message-State: AOJu0YzeZrmCgWv6WWKgm9dVuBFoVEM4cN3isIjEpgkr8Prxxvqs6G1i
	JdDucHn39exMRrkg1EQr4Ab4QbG7OPMeWmQWRDenr9X8f4YwWj4t+v7R
X-Gm-Gg: Acq92OFynDrY6Hj6Mo5iJrb1AoGpyLAiaYC3Bc818X49V7gfyNqwOY/8MJQqawnPg6U
	0srRXYLe9oOucilkfaXWlDD08sCq8PQZNr/HeTod3kriuXOKP8wd/Z7ogRPaOxqDPrKrmTsym9x
	0pBYRinZFI4QSZz/LTlxr4l64PBDbo2ThxKUBOeFDgFr7ztfhfEsk/yqWkTBqwvxithe0i+KUxO
	Jt4VTsfqnwTmmlYV8hxdz76vRr/ZYSLKzJEVoWMpe44cXNu5AdqLbqzjV0MifpTaADZT9cJCVLc
	Tw75zWuTZhzWd2G5py/qiV+AtrwKBybnm0vtTOJDDhsua3wcqRZjisxVzN8PpOE6zQzrlqL9n9o
	XsuSTcIBYOUEgtKLwHSXN6Y3vUaeEzmSR1QoAEh7qk4NvT69cWv7uYXndzIjW9YDvy8NVQdRYe1
	PbpMPXiv1KuiZ6luELS6obcE40o1Gwc7OhYVME4kol43e58YALLA==
X-Received: by 2002:a05:6808:144f:b0:479:fa21:adfe with SMTP id 5614622812f47-4865a9264e7mr3070801b6e.6.1780519442890;
        Wed, 03 Jun 2026 13:44:02 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm2667962b6e.4.2026.06.03.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:44:02 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Subject: [PATCH v2 0/4] dt-bindings: remove redundant .txt redirect stubs
Date: Wed, 03 Jun 2026 15:42:17 -0500
Message-Id: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDMBAAvyJ7diFESWO/Ih5isql7UMuuihD8e
 0NPwxxmCigJk8K7KSB0sfK+VbFtA3EJ24eQU3WwxjrjTIdzj0LrflFFYqF4oB7nrOiHIeToc3g
 lBzX/CmW+/+txep4f7I/bSWoAAAA=
X-Change-ID: 20260603-b4-remove-redirect-stubs-899afc8fa7d6
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294912-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F24363B2D5

Several .txt files under Documentation/devicetree/bindings/ contain
only a redirect notice pointing to a .yaml schema with the same base
filename in the same directory. These stubs were useful during the
.txt to .yaml transition but are now redundant, since the .yaml is
discoverable by name. Meanwhile, other documentation still references
some of these stubs, forcing readers through an unnecessary extra hop
to reach the actual schema.

This series removes four such stubs and updates all remaining
cross-references to point directly to the .yaml schemas.

Other redirect stubs in the tree were evaluated and intentionally
kept:

 - Stubs pointing to .yaml files with different names (e.g.,
   spi-bus.txt -> spi-controller.yaml) serve as breadcrumbs for
   the renamed schema.

 - Stubs pointing to multiple .yaml files (e.g., nvmem.txt ->
   nvmem.yaml and nvmem-consumer.yaml) convey that the content
   was split.

 - Stubs pointing to .yaml files in a different directory (e.g.,
   reset/st,stm32-rcc.txt -> clock/st,stm32-rcc.yaml) serve as
   cross-directory pointers.

Two additional same-name, same-directory stubs (leds/common.txt,
regulator/regulator.txt) have significantly more cross references
and will be addressed in a follow-up series.

v2:
- Patch 4/4: corrected commit message (eight references in six files, not
  eight files), Sashiko review.
  https://sashiko.dev/#/patchset/20260529052246.4934-1-akash.sukhavasi@gmail.com?part=4

v1: https://lore.kernel.org/all/20260529052246.4934-1-akash.sukhavasi@gmail.com/

Patch 1 supersedes my earlier standalone submission:
https://lore.kernel.org/all/20260523004223.3045-1-akash.sukhavasi@gmail.com/

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Akash Sukhavasi (4):
      dt-bindings: net: remove obsolete mdio.txt
      dt-bindings: media: remove obsolete rc.txt
      dt-bindings: net: dsa: remove obsolete dsa.txt
      dt-bindings: input: remove obsolete matrix-keymap.txt

 Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt    | 2 +-
 Documentation/devicetree/bindings/input/clps711x-keypad.txt    | 2 +-
 Documentation/devicetree/bindings/input/matrix-keymap.txt      | 1 -
 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt | 2 +-
 Documentation/devicetree/bindings/input/pxa27x-keypad.txt      | 2 +-
 Documentation/devicetree/bindings/input/st-keyscan.txt         | 2 +-
 Documentation/devicetree/bindings/media/hix5hd2-ir.txt         | 2 +-
 Documentation/devicetree/bindings/media/rc.txt                 | 1 -
 Documentation/devicetree/bindings/mfd/tc3589x.txt              | 6 +++---
 Documentation/devicetree/bindings/net/dsa/dsa.txt              | 4 ----
 Documentation/devicetree/bindings/net/dsa/lan9303.txt          | 2 +-
 Documentation/devicetree/bindings/net/mdio.txt                 | 1 -
 Documentation/networking/dsa/dsa.rst                           | 2 +-
 13 files changed, 11 insertions(+), 18 deletions(-)
---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260603-b4-remove-redirect-stubs-899afc8fa7d6

Best regards,
-- 
Akash Sukhavasi <akash.sukhavasi@gmail.com>


