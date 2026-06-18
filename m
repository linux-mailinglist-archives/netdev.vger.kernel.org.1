Return-Path: <netdev+bounces-300432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K6VbHuDrM2qcIgYAu9opvQ
	(envelope-from <netdev+bounces-300432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:00:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E67A6A042F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:00:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ACCWjUAp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300432-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300432-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40D743038113
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABFA3FA5CE;
	Thu, 18 Jun 2026 12:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DEB3F8ED6
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 12:58:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787510; cv=none; b=LUQvMtgM2sZbvUERtrLflUJuEHMhtMYfEb1FCLSYSJqqdw+lvEfHhpcp1VnK8ieDquaD7pA0mdT9l7aSpcCJ8rnkhrGApR2FmpcskoIBiICsQldBpmfT1rezV3ryYASwAVMKK87sX8BoIGZ+gHBS8uqPhLvanzpjgRo++DnkOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787510; c=relaxed/simple;
	bh=s24y9GPV7y+NJAKmvwvAX1cER3c+JYcl/Cz6+DphJa0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+CJI87nAKVrpZHKR+g8Ug7lrTUnp78Zx7/03hAkmd7AQHOxw8Wuzgqry+/iGlSd7vmY+sZ94uBmRw3+sPaYQXYztGK+EYtHLK5wrwWJzF/EE8s/9+/dDHc9vPGpgVSWJAm4J9tQV2vWXJOQOk/GeMu91t9hSFjD8WUGS9p068c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACCWjUAp; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b12270b3so4772825e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781787507; x=1782392307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3neVONgdAVcEZX3f1l1KWGoYXB46SXm/tOXseRIlMNM=;
        b=ACCWjUAp5FlJtvTHeL5llLI95L/v/bpNwqNXtjEZOHCX7Zb6tawmNtuVnMBptKXcvd
         B5aKiqRmUwgnZ5LpWviagQyszsaqC2IwBnbNi6QDTbuB7PWWzBsvw/xqcilbE5x9hmcb
         7qwO+CXr9WQZ+RD3cQOeR1if7/20NS7s5em5Z8A8AQPR+rt5HWCNr0ZyFFbFYTiDl44O
         +dSeJIcwPw26XGDCUlBZp387FDAj6rnkMUN40NJ1mb1jNx8NgnavvspgXbqP3fUnNmSd
         X7IYyBEjaefl5MKurFG1BsyQK/N8m7Ooq8WpVD/4/8P9k3nhDp3dobihf/o4ZJfWNdsw
         qdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787507; x=1782392307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3neVONgdAVcEZX3f1l1KWGoYXB46SXm/tOXseRIlMNM=;
        b=IoFRrOny/C66EigqzdDO9cE/+gbJs+olTp6mbDncAtrTMNoprD9P27HQBiuzjuz6AR
         8zW+PKXRsoCnkTsTyF6nHKVya1vZ6+nx8gK7x+CtVTFOg0wy5J7CuCPqtBCCGDmzzeeU
         TYLYshDFeMUq5GQTqInIv47METRcRrF36kyUvibptkMy12Vf+auuyhtlDPi3zxJ7HKO6
         +H78t3JN3yWJp9V+oZ1xAXJaLGyYGsr6OBySymle0dFh3MfvNpR4jfWEalRejx4aNfR1
         stjb3tMXTZG0yfp0aGbZl3Iv5mVtlCjAMzdzSR0YNugtBRuBlVm7GI5y0ntK7SdDGvWJ
         HmvQ==
X-Forwarded-Encrypted: i=1; AFNElJ94Yb7gLGXZNyXj7emfHcVKQpDyC+RPRh2wrfqN8W6j7q4p2+5DFZ+X1sistKN7IOP9H2mAMJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOHkJ32fYDJnkfScsKhmIuxO8R3VyYgG9Fi8w1yYv1s29u56X
	PolcG6HMsJIxOdOtDhj0MkiM4wYCQo52MF+3tIjt0P/Vqi0etqO23Whk
X-Gm-Gg: AfdE7clZ8KTJsWgky7pKkQevTN4zWTq2MhixK2OkONnNzSsgwEwxZlP9XB9KOmPI/VL
	5o0vlE0Pjwpi8vA/m6gSvhamZzlUfQpNLTV4t0OMF4FK7cjQ6v8xwzNarsw+cyVIPED0nRV5BnR
	pdXOizk2RMhBItAicfwUre0pN/bywoEw+vjk5uAhBFzlOt8K+l1p3PYfxvdVoCuvzNFUSoQwCGu
	CkPm5OWL+vEcxu5IpC4/GJqsg9tkfsHXxAmbcAadTkTltHIApoEmf98yGR5pw4sOU+z/5o4YdBM
	0JvF/BrEZ+VtkDaxlpzdfQfqyRIGegsPxiSWSYYXLSJ5aFF5jVIEQ7/AMv97xpLwQXESYtwnI4C
	m8BS0ZrRJREokuOtraIkq6OS4GvGNrN2Q2LCxKShk73BqgiMHWKemfjkGqHdg51+3s86jLfJsLo
	Ap6sW1wYx5MK0+JDqQJ3iZU/9bdRn7NoULFvrbObDJ33o3s8SxGrly+6x6/ffY7HNBxZlUBxwm
X-Received: by 2002:a05:600c:8889:10b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-49234139bdfmr97586515e9.28.1781787506895;
        Thu, 18 Jun 2026 05:58:26 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49230a458f2sm241451585e9.3.2026.06.18.05.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:58:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [RFC PATCH net-next v8 08/12] of: property: fw_devlink: Add support for "pcs-handle"
Date: Thu, 18 Jun 2026 14:57:16 +0200
Message-ID: <20260618125752.1223-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618125752.1223-1-ansuelsmth@gmail.com>
References: <20260618125752.1223-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300432-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:ansuelsmth@gmail.com,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E67A6A042F

Add support for parsing PCS binding so that fw_devlink can
enforce the dependency with Ethernet port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 136946f8b746..e6584a2f705d 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1392,6 +1392,7 @@ DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller
 DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
 DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
+DEFINE_SIMPLE_PROP(pcs_handle, "pcs-handle", "#pcs-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1548,6 +1549,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_interrupt_map, },
 	{ .parse_prop = parse_access_controllers, },
+	{ .parse_prop = parse_pcs_handle, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.53.0


