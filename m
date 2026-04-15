Return-Path: <netdev+bounces-278883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHMKANUg4GlMcwAAu9opvQ
	(envelope-from <netdev+bounces-278883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 01:35:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03019408FFE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 01:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4A36300E4B4
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 23:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C62324B1E;
	Wed, 15 Apr 2026 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3pCBlmP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F4C311C2D
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776296140; cv=none; b=TEiFkz11OnGSSF420Srq7rvNm1TJAIgxL0d/d/5czEd8qE1i2dtpVoo4FIlTs7JvuCO9S140CXvc/cRLqQeIJEpQgwenftQ9K9p2rR01+l7b+NOVKsVQharifOUkW+kMjMQqOEVkSCRgiYVfA9waIHqzYe31i6nU6C0WNuy487I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776296140; c=relaxed/simple;
	bh=MHhCiYapKSkKWFygJLgj04EqRYRyACWqZls9L5asc40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TavB/QSSHXOoUo2J9W6Uy79RwORz6Ui0rQJu4bBpQ32JPiC8+flgJYbrL05XL0MUpPAg4BYzEMP9OEL1uzPl4u+mCmeN2ciN0eDedyJ2A0PdZ+BNpl1dW1c3gQgL3a7opHzDGkk905LHEtXyI9dxRWpxHgP5ezyQw3LPCcjZIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3pCBlmP; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-35d90833cacso4417103a91.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776296139; x=1776900939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtvt4KnahXapURT5aFQtvU/CH8l6W8PxDKVGLxGvjHo=;
        b=m3pCBlmPjedMYpxKLzqB0rDc6ZdttXj3ZIDufNqRhWxcaic/f+GN0vWOy+CwHX3Yls
         C6IhvcN5qoz4/xaT1DOD2qxRzmca3MUkPE4qvNObbjUWEVa+3PmwlO2jXC8ZMkfahhOB
         1w6SfYUpsOr+/ttJthRilBEVeOqcnRchaeSq5DXV8D6lplqn+FVHWoiYue5WizOJFk+Y
         +3xaVQ+OtjHsrfh2R/X43pxpOf3wcVkRRS6or2Q2VyuAyJg4c9WjBOftG+kKwjWjNomv
         IWloLGJjuP5pvmLjH4EEniuFg+/JZncdqMKxgrL2LzFfpayni7GWRCucjn3qnilPb+P5
         HNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776296139; x=1776900939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtvt4KnahXapURT5aFQtvU/CH8l6W8PxDKVGLxGvjHo=;
        b=WV/6NqEyMZxuS+j2y0aHa0O00x1kNhHnjBn9fqnf+zWYzoMFvQz2tnksSg3VrQVJFf
         TQ+CuWTJcjbYtMkSPQhSeWFst+nSbPjsBdibARfgXFyeh50ZkdXLSzySQK9/pNRSm5eJ
         7Q2j/ShmnqUkYpS2UI9PfZUkkZpvWWyov9S1RvLQzcKK963ci44yEGUsmr4+CufPEINO
         wAxbAoTgsO+qPrwrj6qFjNUETvFNEjUiwqFM3h8fWheuKPT3Sx8stjQF99Iok9DoDScj
         mto4LlJLjCipOMywnRyPy3eYiQeyIBr8vNOzq/KsIOzz2pc9GHxHdXjGKInCWDd+n3Qt
         mooA==
X-Forwarded-Encrypted: i=1; AFNElJ8ujHZb8OqiuHQc0Ufcm8hrIB1wGaRwnr1Ue6+Mx/B3SFCh8DWgw5W3AjByQzgu42KvBNNeq08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh8Mqjsw4kBNj8QrLEo/tY6GZoXdETWpq9mcENtKNidcA6QaTv
	xUfB7NsrOPJ5WBjbm+U0zxB/kH0BjXkepJYnmGlLD61dAfrqVxD712IZ
X-Gm-Gg: AeBDietXS85Rr3jMcvn7C1+k8Tvb+f82fIwIpETbfdesTGTL/wEgobgTNgoJ+mn8psn
	sPaQLQY2xyKvkWY3OFScx0RNJhtg/AZeOOPRc8lBYAxDvJnV5XK1odtig6YU9zBdvr9T/H2BXWh
	mmlbP/1d+erObIueZEeCs/e/NyEupAa6Y4BNkZTNKpC3gx4hCBJYZ2M3tqJXqQFgcLMN+HYO/A4
	v1jzpBCSkxJ6W/CfNKyPoD+eHdSfLPq34qQFwQUE5HxkgLthcUgcRvUREDiCnHUmxHye2xCYUGA
	cO1jLDPHtpLAo4r4AKQ4mTJmMPN3zg39k/NjguUHktp7L4hGgBJ/bvvIh6zGChcTzuzZAfjROuj
	mkgRM8ktQH2oBeoEocyBnEukpZUr3l8dcYaMM4KtouRzBbBAq+pUPczip1Qmng946nZuG2j1OdS
	uZKfsJC/Pzm5zJa/pgAvRY58Hbr81gN3Rxcku63HZTwoggl49xELkOck3KcOc=
X-Received: by 2002:a17:90b:3e8a:b0:35d:a542:2dbf with SMTP id 98e67ed59e1d1-35e428320a8mr22548221a91.20.1776296138675;
        Wed, 15 Apr 2026 16:35:38 -0700 (PDT)
Received: from localhost.localdomain ([240c:c001:1:2e07:d16d:209a:fff3:5532])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132d1086dsm173152a91.16.2026.04.15.16.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:35:38 -0700 (PDT)
From: Wxm-233 <lty2wxm@gmail.com>
X-Google-Original-From: Wxm-233 <2200013188@stu.pku.edu.cn>
To: kuba@kernel.org,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: caif: potential UAF in cfusbl_device_notify()
Date: Thu, 16 Apr 2026 07:35:03 +0800
Message-ID: <20260415233503.923-1-2200013188@stu.pku.edu.cn>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278883-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lty2wxm@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,stu.pku.edu.cn:mid]
X-Rspamd-Queue-Id: 03019408FFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

we hit a KASAN slab-use-after-free read in
cfusbl_device_notify() under syzkaller-style workloads.

We reproduced this on 7.0.0-rc2-g0031c06807cf.

The crash happens in the NETDEV_REGISTER notifier path:

  bnep_add_connection()
    -> register_netdev()
      -> register_netdevice()
        -> call_netdevice_notifiers(NETDEV_REGISTER, dev)
          -> cfusbl_device_notify()

The faulting access is the parent/driver-name check in
net/caif/caif_usb.c:

  if (!(dev->dev.parent && dev->dev.parent->driver &&
        strcmp(dev->dev.parent->driver->name, "cdc_ncm") == 0))
          return 0;

From the report, the freed object appears to be the device behind
dev->dev.parent, not the net_device itself.

My current reading is that this is a cross-subsystem lifetime issue:

- the CAIF USB code registers a global netdevice notifier and
  inspects every new netdev
- BNEP sets dev->dev.parent via
  SET_NETDEV_DEV(dev, bnep_get_device(s))
- SET_NETDEV_DEV() only stores a raw pointer
- under concurrent Bluetooth teardown / suspend-related activity,
  that parent device can be released before cfusbl_device_notify()
  dereferences dev->dev.parent->driver

So this does not look like a CAIF modem functional regression in
ordinary use, but it does look like a real UAF in the notifier-side
filtering logic.

The trigger is clearly fuzzing-oriented and cross-subsystem, so I
would treat it as low urgency, but it still seems worth fixing in
net/caif/caif_usb.c, likely by avoiding naked parent dereferences in
the notifier path or by using a safer or lower-scope identification
path for relevant devices.

If useful, I can also send the full KASAN report separately.

Thanks.

