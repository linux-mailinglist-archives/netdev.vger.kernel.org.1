Return-Path: <netdev+bounces-252826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIeKGUtjc2luvQAAu9opvQ
	(envelope-from <netdev+bounces-252826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:02:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC74A75819
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 675B8302335E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5C31487F6;
	Fri, 23 Jan 2026 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDqFlzVg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0D296BD4
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169690; cv=none; b=mCk1P27mGVmx2HXhStVuVgzadT9C/n2P88QzQ7SK55rn6oeF16je/8gqYOgNpdS1TzGrQMYSXmc7LqLyi+rV8mKwSLxzlz9nnBY782eRBZssV1YeGqDyijIRJnl7pQf5B+wlrnoe7qRk10sqO270cUmgxr8s5LmdIF7R6RMMYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169690; c=relaxed/simple;
	bh=EifM3JqyoqVdIYaT0+68FZEg2TzSn0f7GV0JfA73XTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A30G8leISUJYTpj7A3xBjtttjALwqB9DOCt9HWAWG/641rzh07MPt5RNaLohy95qWuO+uq4CcdtN3teQjN27IhwFZLDmByIFZht4ZrIp1yxCGHuxyvzybPsVo6T3I7aU91yqdbsdKrW4vo9yibYjl5YVsjJl8Y5uA9ZzaOwwM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDqFlzVg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edffe5540so24701965e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 04:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769169687; x=1769774487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iq6qtRr1VN9uZEEh7QyzjJgtaD86rVZ5JvpyoMwbVI4=;
        b=JDqFlzVgyN+rgmX1NMuZppt493pjKeJHQuQ2iI5oc5tdR61sUu+FrP3lYQbdCP2+a2
         1Ay49iQ2j41DSHD/5l26Y8NvlHAwUULXmqrB8Lvy1iRiKlKsemBGteciTkH0Qgp2LQyp
         oFRIKcYg9VXckXs9f0nXXEDYHVRweTZ8js6BKEX8S0QnKbVQaikyOQgYZXTppOnJp0/F
         fN3n2xRGoJAwqqok1+YXTKDDDYu11Xl7gYyGUe77hDo/YVbNEZFIqvOuUilxuM4wOlMH
         HibZp5qxKzkqG2WCKvpUeZib7UVivd9je1aE2u1fueZCzLdOrGMZmqXd7SQspy5t1sJW
         XdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169687; x=1769774487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq6qtRr1VN9uZEEh7QyzjJgtaD86rVZ5JvpyoMwbVI4=;
        b=BOkVOrchgPIC2FK5WOVeU7xVHcL68i1Z4jma+c1JiB8B8tXgGPg38Uj14IFuA5BWIy
         1QBMi8nxF/1b1yV9xPGV+G/NvC9aDoVwCq1K7X/jrQK5ioP5YJhmUENBR9+Er+wJankk
         Ff1kd1VeW9LpsoWM2NX7chzxU+5V5an8wNCh3v6ARd0zEQORTKEHreGd5waxyEkt1OK+
         LmKX081lBVTO5jqcK2eDQEVil1dOyt40u+DY9LaOZujNOeGWwVI5I/+EGEUvORMM95Fa
         0XznUsXGFWCjzqAS3+T3BDxkWvXHo0IQ2CAMmCl91ScP8+dNmaLx83GXq/0ZXBJjcDUG
         aJIA==
X-Forwarded-Encrypted: i=1; AJvYcCUJNnzY7sFct6/PN29vEndpHGeGKCLrGI6jmYAq5vsZ+OoPSQa7iYap47bQ7v7ZJEabAWCWlBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZngjvthl2xfqEq8tUfJVhG9WzviyYI01f+aeZdp/vBwv3EC/w
	T2lYDloHGDqbYaJppw5GYY3QDBwREOcINcvNTGsoPLjHnattwJGgi0WN
X-Gm-Gg: AZuq6aJE13BLlH7/Da9vEG8D/bI9msZBpaNl9Gdcj58Xj3sXcaLg98NLmu+Mz6mnyvV
	Fko33U84GMiwAE5VqV0JRwF6ag8RtZqaF/LDTsFEbq+9G6XP6flm4aq+Q5ov3g8VQRVhUA2SAnr
	RvY+/n3zeDuOERaNR5+2s5Z/GRQ3b2eBv0Ym3MESHuypuvJQRlw7oL09SLyExjQ3xP00MSMPssI
	qcNecA3e7jEJt6dQZ02o7gJxqgCoBQpqLMTUBCBzmsGlvmicbhZ/mvyCD+EYyS2TkyKSuQjePO+
	zDPPII1zfPsZTxy/uufdABbnVslJ4TzhefmqyLc4sC+z+7ozB1UUhNVyMLvwgw3OD7fW7Zg5BWZ
	gxrdeDtydFLnAQ+nhy/gQcl+coK1JJGd+Yatdh7Bj4Usxtv0xB/jbTEzqiiD6SrFZ2OchBEdE8l
	gN9gs5RWXJyPGCuL9zt9pC2F3frLyrcLhqzBG3AUtR
X-Received: by 2002:a05:600c:548d:b0:480:1c53:208b with SMTP id 5b1f17b1804b1-4804c9cf3c0mr47143415e9.36.1769169686399;
        Fri, 23 Jan 2026 04:01:26 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4804d603ac9sm21575135e9.4.2026.01.23.04.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:01:25 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 0/3] net: phy: as21xxx: toggle In Band feature support
Date: Fri, 23 Jan 2026 13:00:28 +0100
Message-ID: <20260123120117.10883-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252826-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BC74A75819
X-Rspamd-Action: no action

This is a new variant of the previous submitted patch adding a similar
feature.

Old Aeonsemi Firmware permitted only to enable or disable In Band
support and it couldn't be disabled after (or there wasn't a
way to detect the current state of it)

As suggested by Russell this was bad Implementation. Some talk
with Aeonsemi permitted to release a new firmware with correct
implementation.

This series adds support for this if new firmware (1.9.1+) is
used. On the new firmware, 2 new IPC command are introduced
to GET the current state of DPC RA (Rate Adaption) or SET it.
(DPC RA is effectively In Band mode)

It was verified on the same scenario and can confirm it works
as expected. (Airoha AN7581/AN7583 with and without In Band
mode) (If PCS is set to In Band and PHY isn't then no
connection, so it's easy to verify correct functionality of
this)

The new firmware is currently submitted to linux-firmware
awaiting it to be merged.

For old firmware to save on compatibility we still enable
In Band by default (this is what the current driver do)

This was discovered to be needed in some scenario as is effectively
the most compatible featureset.

On a BananaPi R4 Pro, one of the 2 AS21xxx PHY is connected to
one of the Switch port and such switch supports only In Band when
set to USXGMII (assuming the Switch expect an SFP module to be
attached where in absence of i2c or MDIO line In Band is always
required)

Changes v2:
- Rework to new firmware version IPC command
- Add DBG IPC command
- Store FW major/minor version

Christian Marangi (3):
  net: phy: as21xxx: save firmware version major/minor version
  net: phy: as21xxx: add support for DBG command
  net: phy: as21xxx: fill in inband caps and better handle inband

 drivers/net/phy/as21xxx.c | 316 +++++++++++++++++++++++++++++++++-----
 1 file changed, 280 insertions(+), 36 deletions(-)

-- 
2.51.0


