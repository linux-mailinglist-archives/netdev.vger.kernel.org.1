Return-Path: <netdev+bounces-186844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3988AA1BF3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DE21BA7B91
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E32D267B85;
	Tue, 29 Apr 2025 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdipxO7w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879F263F30;
	Tue, 29 Apr 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957854; cv=none; b=BlgrP+7K0YGT9XwI5Bi1vj99fMGJKljSgDcn16j3/a5u02sqxlr8dcMdK9sbYDv9kZAc5mwApbn2R1T2bc821BMqvvZAH/YpTHVE1FoMz3hJ0pqGvz16h+qxCGKMu8XKBE/hrXE8PZCp+cYDLgcQYq9BbyNWsOSKO+fgD1YVt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957854; c=relaxed/simple;
	bh=VPHjNFmaazifb+K6wHzWOxmAQtWD4cFqQPpv0T7UAro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e24YG4WytLzEftRxwjTKoKw8r6Gx+k6DjRCk78cuIz3ZaoJsdMj7bRPeEQQ6XRhWPa08MtirXrujB306i1qacy2NbEX+cueWQpA7K3WQI5YvXnvBdkZOSDG7HXj4q7ajExZaZ5ZWbfkHhKO1Y6SUZAfnUcgnjevpcUKUUlaywdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdipxO7w; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso1402800166b.0;
        Tue, 29 Apr 2025 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957851; x=1746562651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI5IVVmmMWscuzX6mqYN0L5taOLHq280xXdP7NoKx4w=;
        b=YdipxO7wwXsjfHVOhpnGWzVLCHwExjp54X/jekBoTtK4b3JWtu1sfKA986HjCuOYN4
         dJfnAWfqagOxniC6wgO8CvfpndvCDzeo7Atfhr6BSamasnNQ7utjzaJoJuhU/KoJGc6V
         giqwzw62EhueRV2eUDz5LwncpPm60JhPBNBVxtpcQA7Z7/gMaefNm444e1ka6rfoPBbU
         OxvfAIhRcR3FYH8f90bZ7lNDSJqi+RKp3Hb0Ey3E69IBvVINlGv8uYnP8WznwpW4Fb2V
         yyJeGGCqow6SUKcBubCwFV2a/rSjabi3uOoKoU8hvJaJ5Bk8929TxFsADV2ecoB1DkwA
         STeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957851; x=1746562651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI5IVVmmMWscuzX6mqYN0L5taOLHq280xXdP7NoKx4w=;
        b=nDojN/IVg5uILp5Rou9a+PqP49k7S64r55j4HWEM2/jlxmE6552rMI8dXWMwmi9uwI
         BOFQ+NNstdk9847WFBbs7uo80Tpfmd9pTOYL8CK4YKNRUiTZ1E+Nj4F6ZPs/CFd3lPoA
         JFwyu8Ok+1iBc3iuPhYWRFe/YA3cK8rliouPMaA8rNJLIgmYaw20nwGjMJ965Wm1JwqH
         GAN1VI9CR4gy+fV+Bluu25GkM+FcBIcJizVtXLG4HfuIFp528MJLX71BdwEixXANtsC6
         7psvHo3EYjDEU3Wfr3L8rC0/o3lcpMWRbO7Xn3tgejFLE6VsHKNM7j/V4PR3HCIjbnHB
         4oTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj5WNZ9FskJ3kDz1qV/7wtuGZNdYtqqY4eIap8EgcfkNQqnmqKV68JIYdoeO069njLfS7oePdm@vger.kernel.org, AJvYcCXPeAqT/4NHRpbKIuO4Dr2OuJPGuwUTe1bh5lqRxdsNC7WfPZbLvFu4JrwTS2wMoGIPqh+l/sNg9WNeKik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXBk7fxmtDT1h10JZhCmobnBKG8sScdZ79eaeT922UDDxRTgK
	8W1MWdxLzb1bzrSvovRkHrsW2VgoffO+rxjd49E0a31yOUBqzWAE
X-Gm-Gg: ASbGncs3pqw6RRloSu/cMAQERHrA1VEdghBqKLU4rvcDV1RRX5d5aiSIwECSUb4Zu3f
	tZNvFG1yq3ThboGvp+LC4kugueh1z74WA1Dwd7dnAu692BfP4fTJ4qTiFrgLsuqBmXx+MPajQpI
	VnCCAvki+Z/3ik2jwVqfiywaEsl7jS+lQZ5Y6tdkW9eEkOlRmd59vozYnU7G0pnawoaQvEorxl5
	m/U59KQ0AZmtO/ElWtNjSYcuxt7wehFmfFSdo6HM7zTLqzVpa7JrjLGha5M+SAhU88ka/J1AVDV
	j1T8d7T2oxjjTnHPNaBq3JGuru0jJcPxDZHtEATh+UjX+Wl9s1/jKa8QH5VcgYzeLCic/ZX1bKK
	3IsVKzaLR6quBUBVumOM=
X-Google-Smtp-Source: AGHT+IHnd+ayfnOME7pGWyrc+45sfFNXyd6LeRpU4Hei6WSpO5/z7+NbUYnxSoFUbSe6KH3aCc1pvw==
X-Received: by 2002:a17:907:3e05:b0:ac7:322d:779c with SMTP id a640c23a62f3a-acedc793324mr63478566b.50.1745957850521;
        Tue, 29 Apr 2025 13:17:30 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf8603sm819056066b.112.2025.04.29.13.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:30 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 02/11] net: dsa: b53: keep CPU port always tagged again
Date: Tue, 29 Apr 2025 22:17:01 +0200
Message-ID: <20250429201710.330937-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429201710.330937-1-jonas.gorski@gmail.com>
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Broadcom management header does not carry the original VLAN tag
state information, just the ingress port, so for untagged frames we do
not know from which VLAN they originated.

Therefore keep the CPU port always tagged except for VLAN 0.

Fixes the following setup:

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set sw1p1 master br0
$ bridge vlan add dev br0 pvid untagged self
$ ip link add sw1p2.10 link sw1p2 type vlan id 10

Where VID 10 would stay untagged on the CPU port.

Fixes: 2c32a3d3c233 ("net: dsa: b53: Do not force CPU to be always tagged")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 62866165ad03..9d4fb54b4ced 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1135,6 +1135,11 @@ static int b53_setup(struct dsa_switch *ds)
 	 */
 	ds->untag_bridge_pvid = dev->tag_protocol == DSA_TAG_PROTO_NONE;
 
+	/* The switch does not tell us the original VLAN for untagged
+	 * packets, so keep the CPU port always tagged.
+	 */
+	ds->untag_vlan_aware_bridge_pvid = true;
+
 	ret = b53_reset_switch(dev);
 	if (ret) {
 		dev_err(ds->dev, "failed to reset switch\n");
@@ -1545,6 +1550,9 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	if (vlan->vid == 0 && vlan->vid == b53_default_pvid(dev))
 		untagged = true;
 
+	if (vlan->vid > 0 && dsa_is_cpu_port(ds, port))
+		untagged = false;
+
 	vl->members |= BIT(port);
 	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
 		vl->untag |= BIT(port);
-- 
2.43.0


