Return-Path: <netdev+bounces-284666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJNMFQal+mm7QwMAu9opvQ
	(envelope-from <netdev+bounces-284666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:18:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5585B4D59AE
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EC333019975
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19D279DCA;
	Wed,  6 May 2026 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLEswJx0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0C2459EA
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033919; cv=none; b=tqigKI0aKT1mN2gg3tNHvqWBX4Te3ucFAXi0t9YfXReiUBGg5cZo6qjx7+tzwJm0oj1kUUTZ6U8dhnDeoY6+cycIRQTr6ciBwfN8ZIkqAwm5O3xLd1RnNp6cUO+Pqo1rIzCq+y9LSvsfqAi/BPB5agsitciR6GSblzrrVSkInAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033919; c=relaxed/simple;
	bh=bpKuTDWLrq9nRB2Uy83zrkgw+0T+HWieTx8p+YwRkoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ICLeLCjodUb4DlL5aXkMl4VRzouCf7v5ZhzTNpx7NxIfwfUR6aSc0WGH9BznCF36WLOy0o2yWWfyEZLPIhZzSzgAGuHzlXBLypoW/zZE6UwFJMIBFSZcCesuR61Gg+WUodXYuGiIgIA7whLbCvgF4Uh/0ZBNU/wW49IgjIx4684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLEswJx0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso32379375ad.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 19:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778033918; x=1778638718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ8xQG/pi2YZ94Wyif4WkSnUaUizpmS2aclrnUnSYok=;
        b=iLEswJx0Kz1me2GcAqmFCKYvEnNaOKQOXFkWPHJPm3kXwAPzEId3NuY7C8CEDmNGqF
         EIyIFFh9BH2BMa6+9c2H+bw+UOfHVmfMmiR5zUdhQfIjoztgjbMJdg5gz4RVtfccDXbD
         4UpwLpWUz5GpcldKbFVZ1pe7jBetiCNpS0O/a1qWRw1i4FwLP1CNlXj44YWfKbbZr1A9
         ZkJ5tmBt1+ajwFCptseAfW5GlfkcxJfqyZuJurHbfV0Hz7SsMg7uQ6VJhXHd9fcA3tbE
         cYv/1kNrEKgY1pY6C2WxpeOZqSYkJqZef1c9CVi/2hBkgwvcyZXKFbxcP4E1lpUGYPA5
         C/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778033918; x=1778638718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ8xQG/pi2YZ94Wyif4WkSnUaUizpmS2aclrnUnSYok=;
        b=s4Bz3I1YWdcxa7GHiHzSpGbYqwFQK1ewEYXsne7DBTBlkhtSNMlyJfcuCfszPnNXGP
         UCEFoFQLTlaZS50SYARjUggL71RhVcpRajb1ugGMqOnU6JtbWxZqUXO9nSmisD8n/NXj
         y5VhaD4LLeaRxVPUv4M+Lh4BKkTCUeAejHBwdSJF6c8Y49kbtmofajoVhPUWFY1a2Dse
         YiusYIvvRE7100FApIyBEJDJCZzSCN82DValZ7ttUS8P+pernA9jhKjThk+Y4EF0a0mL
         1lFrP9eoiLkfLUvjDFDpoyA326OPk4yjaQTaoIoUcEQWXtmmPopvrEkvJD1M79dALxX1
         n44A==
X-Gm-Message-State: AOJu0YzmXOtrc4PisrSHM3FZsjisUcKp4ts+sUo9+FzcyyZoUBpJaOQ2
	EPDzZ+sJ+lX9RKI3qbsfLvJ3AVRAXxDza3w50RP7nRD2SNFunDjCbyHa7MWO3Zfp
X-Gm-Gg: AeBDieuI2lJgSTrbq5A+Fey7g2nXCbme7L6crAh9pZLEBJ5D4A5VjL1lVAvSO2BmntP
	JEfHfHh7z8QdIjAai4hBTiYvjSFSytWRgjoOxJC8uny/SPZYK8uXOWeDDgVFELzp+Ojse9TKo4F
	N9Zwrpe+NsicS7EPHGXLI+L/MCZqGVQtYYEgpCdL9fcmYSJwGKoDuE6m6VLsFVxDImjTCBs/IKD
	P7umVH0um15eCxxDI9rqL1ua1XvGArw5RzdmjYHupftLSd3s48xV6GDGeSQXA/xYuJBpks9zSvz
	YYExSZlHfEiSXf8hz6dzjqTpPCX6t3aImfZRM5rx4mpvHgiWmWcn4xyy2gErTAdZZsBC8F/Md2+
	3yAhQyHkLsKsGoz0IB8yIuFwtPiG1OP/VV10ua1d1TsWagaqiruRSSLT5uxuZonFGAZAcO/1UTk
	wv6z5wIOjhwvmzWJYw5LwULrG9UucRLiqRzR3axC9l6/2513z9/xWl+A==
X-Received: by 2002:a17:902:e54e:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2ba7a358d4amr14644345ad.36.1778033917583;
        Tue, 05 May 2026 19:18:37 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1ac6sm6319525ad.42.2026.05.05.19.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:18:37 -0700 (PDT)
From: "chunzhi.lin" <linchunzhi0@gmail.com>
To: netdev@vger.kernel.org
Cc: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	"chunzhi.lin" <linchunzhi0@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: motorcomm: add ACPI _DSD property support
Date: Wed,  6 May 2026 10:18:11 +0800
Message-Id: <20260506021813.3658669-1-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5585B4D59AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,redhat.com,google.com,davemloft.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284666-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linchunzhi0@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi,

This series makes the Motorcomm PHY driver parse firmware properties via
device_property_*() so the same property set can be provided by either
Devicetree or ACPI _DSD.

Patch 1 switches drivers/net/phy/motorcomm.c from of_property_*() to
device_property_*() on &phydev->mdio.dev.

Patch 2 documents Motorcomm yt8xxx PHY ACPI _DSD properties under
Documentation/firmware-guide/acpi/dsd and links the new document from
the ACPI index.

Thanks,
chunzhi.lin

chunzhi.lin (2):
  net: phy: motorcomm: use device properties for firmware tuning
  docs: acpi: dsd: add Motorcomm yt8xxx PHY properties

 .../acpi/dsd/motorcomm-yt8xxx-phy.rst         | 107 ++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 drivers/net/phy/motorcomm.c                   |  41 ++++---
 3 files changed, 128 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst

-- 
2.34.1


