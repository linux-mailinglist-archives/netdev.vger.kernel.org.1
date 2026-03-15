Return-Path: <netdev+bounces-267962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIfjLZMat2lGMgEAu9opvQ
	(envelope-from <netdev+bounces-267962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:46:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5737A2926EA
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 911D03067409
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAC37BE8E;
	Sun, 15 Mar 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy8WKNlL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A336D37C0F7
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773607513; cv=none; b=hxgCa4tl9Oa3paSysNg+ZcpIZEzq3vnQqtdERVM8C7/3E24UqSJ3QiuOQb2JqbOzNEqtiGXECrZAC6+fnXwBhUfIBTTG4xvAF1Z+2mNYv5JAC5xbHALiTxpYj0qfdpy346sIhzFLdMnWkxrHa+s/L8liNuCig0kJEvXYlWxXMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773607513; c=relaxed/simple;
	bh=i6Ts41fXLRb5swardCZUkTCJ3f2AD6uWbw7o0btGsW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcqKDDJZ5FhwIkOawIhMEk3SzlLYur7pkCyLd/p+zjtOMYna9IFUMXuU8NO1YQj0cD2yIrtAP9auG786BgFq6VD6VEg6tkNhBKXWwpHCrersPjYW30K8V6xVDfpoh7gL9drtDP3AaJR5w2HZueeoFXskBljUzlgwfDbdhxOM6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy8WKNlL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852ff06541so43718115e9.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773607510; x=1774212310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98rPC4PTu7tCmBtkzzBMDz6PWd5qa76zGSirl2GTGes=;
        b=Vy8WKNlLTLqR/g/wB4o6G9mzeTCLHrEhf2/eM0BgizBIQZakxr6t5fTjyvtcidTIJf
         RuLbfvubzx4MjHZZ7bNviW+VIVR8PCasXMC+5uAOpyqMlrzWHR3qGvQD/gfn8FzzPZeY
         IQrGIRlksX3I9J0om5YWTWnQpPRdmbRxk/ZmZ1znK4juMIniTqvyHEtiu6XtFaRIRSKy
         GYsbAF+6dwWvCFStMU25lO2XA/D2MAH5SxIZArqFrTwyWU9w1zUK/P/nnbaNlIwvKzk8
         lQZnZcT0AesXZL57WRFDBG/1X/3kfjiBduONRrI86JdLNWX/kPMQpsQj0fJ2+aI/95uD
         uUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773607510; x=1774212310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98rPC4PTu7tCmBtkzzBMDz6PWd5qa76zGSirl2GTGes=;
        b=LRRKYziwkoslDe8CA1/R5O2dkNq8Z0s6r7NRNq9XinmZBRhbz+9+ncmxxzI5j0evTK
         h2BemT6Dv4cZKud4a+V8SGr1XrVcZ4/Z7Ijy3mkBdGTj+AV1x0mi6vngs0hJo62Vh4jN
         drkM+dd6nesVNTE625Vbb4utvUAqLPQ8A1AyU3gpfoOnD2rxIGE9E27l6YDWKTTYaeIv
         qkVQbaWcBJWHkNLv4t6bwmHc5bz2uOWiw/SS8vJlt+/nK2jkbeksLqV9gTvLxuaqP2vs
         LOD/0GsgM6ohP2GAaKc41MU9LxVr217mWzRLTV3rZ5Gc+PqVclKYRZs2VzgKZ+McK0rw
         z7Vw==
X-Gm-Message-State: AOJu0YxThH2fiiXYAdQFfOj0Zl3yu7IvX+q1IqE9YBE55K2e66I1SsKR
	tr2C9z4KmmoVPUNRa2R4glQUglUXrHD1MbKizzrJifdF798XPjGGh1Eb
X-Gm-Gg: ATEYQzyc/ADy1ZTACUu2i8ODZzNYfjUwbxMDbiNHZA6Aj7wWfnB26TGJo58lpsTCU5U
	jqkcqVuojV7IFAe7Om5KYmsWEXfALYAit6yQKhKgU1buCUaVBa0Plxo9fEMpx8Kc4uIpzucDggz
	euqa4vMWftzu2oXkli6ENhBWd4pkt/Y0Wgbp3Ne50/QrKr81+sVRO7hp4xgKQ1huMkIL7wYlFLr
	mC6V8OQJSm2LzMTiaXULPI0cdAbOrZ4YKJhDS4Z5PeNCa5ZMGZS8jdfFd9cZXkBJzBl02wjmpMI
	JibVxKPadutMd79bi7lZdAq9/3mme2bIeeGC42iDawEFzjlN3dDR4GQlRNcJDbGYJG8S30qwutj
	SlAkzo6+nY1jqnJySOLGVNC5KChR90nMTWRd9t1NViAc2+F3/ya31zsmidGiTtkRbPXNkdMzSSR
	OJ87sc1z2lS7R7TyziAygd9tM=
X-Received: by 2002:a05:600c:8b2c:b0:485:4bd1:4c7e with SMTP id 5b1f17b1804b1-485567148e8mr179710125e9.33.1773607509651;
        Sun, 15 Mar 2026 13:45:09 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563f8c23sm132043885e9.1.2026.03.15.13.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:45:08 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v8 1/4] dt-bindings: net: ethernet-phy: add property enet-phy-pair-order
Date: Sun, 15 Mar 2026 21:44:51 +0100
Message-ID: <20260315204454.124544-2-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315204454.124544-1-dam.dejean@gmail.com>
References: <20260315204454.124544-1-dam.dejean@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267962-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5737A2926EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add property enet-phy-pair-order to the device tree bindings to define
the pair order of the PHY. To simplify PCB design some manufacturers
allow to wire the pairs in a reverse order, and change the order in
software.

The property can be set to 0 to force the normal pair order (ABCD), or 1
to force the reverse pair order (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 58634fee9fc4..4a27547f7d7a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -126,6 +126,12 @@ properties:
       e.g. wrong bootstrap configuration caused by issues in PCB
       layout design.
 
+  enet-phy-pair-order:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).
+
   eee-broken-100tx:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.47.3


