Return-Path: <netdev+bounces-285141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLRAEOUO/GnsKgAAu9opvQ
	(envelope-from <netdev+bounces-285141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 06:02:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985FF4E2C1E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 06:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61FAD301A1E5
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 04:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04FD31815D;
	Thu,  7 May 2026 04:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC6Cnx8m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF02D0610
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778126549; cv=none; b=LXZO5V7LWgsk6o/YVL02DxIKHHIsy+jqqHwC8/n1iCxRY+zX+GUt6+p1P+IXLnFPlaoLHWLrmco7Wp+z5I2EfiDzFTsZRTTVckWqgHcD1SWaWcRrcdLzkt3iMQaZjnY80r2H33tC9LykYevN4RtuWtrvgeKHvQC/Sk6pRrJtSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778126549; c=relaxed/simple;
	bh=c7K+X72uYM/LaQUiEpD9eAXSPW2etRLQvoWgsxwz6nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h39mcVjgoWRcsU/SpoEgI9F9sFHu8LBoFdC56r7ZFBEEWiTlL/4qhUr4SI8wej6eLWc29TrmfWMCBZGjNDu/htRP1Cf/DGJ7tKK7p6k31VVb+UP4d8flRqRMGU3UJklSob6FAa1yoQ0WCSD/dSAOLS07ep/AsGFfpomByhSzb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC6Cnx8m; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-365eecc5885so361023a91.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 21:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778126548; x=1778731348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yj9VpfFL3+hunMFrVeuK8hWm2xzuHDMrd3yGXwj1opk=;
        b=SC6Cnx8m/E6TIlEjYpMYlqrTwUNmfPR458TnimWlYkBdk8vIoAxdH4fp5InL62puqX
         xzP0hSYY+D1wXou02QQdsa7jpaRGjw4ZshQ3cIiiq68Cq+QoQVfYMkqd6TSpLireVfTa
         dzpnw0aad9tvM58D6Qn+Ud2SwGi0wXkbrKHQcbpMztxTzwNqgoP6MdE80obCmUa2K+S3
         CLHY54NDELIvgS8PScr3QvzZmVa+w6WfvYMrl2wM3U2Y0bbGLBb+/HLosjkt8S5fSqnz
         HRkz+wKTFrdjnKx6beE5xSdlNrL8mWNmRnZqmpJjLaBT5DOHqDJhwRc0jmcmLynRbMJ4
         anCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778126548; x=1778731348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yj9VpfFL3+hunMFrVeuK8hWm2xzuHDMrd3yGXwj1opk=;
        b=Ja8ANpqLFWVNV4BobcvvZmSzfPGZRDqkZsPnqRokt0AXXYkPAG8JMj+e4pqPva9kgT
         u2hECbXzq5t4rbWYJkINxhI++gIcSLGcKiU3JmdrCD58HoHiSLoLL08bi700AvqnoEs5
         kLp7MlT0ka6LmF3N+wRbjHYICgDK0hlW8Snm3dpAjx5Gtb26OP5eFtMEeuFzPQIDZ9aj
         cfXiJTv9rDdkoF8gTwNMvpLPQquUqYehapkjJ+l5So0dWq6eOybvM8Pgi0lqFIJHUBQV
         QRZhZDkHAkbQPyKfByAh+/YFa55ck8WbhQTFN2+FWsPOLhRTWo6ZlkEYYLsajkWuQ3wG
         pTZQ==
X-Gm-Message-State: AOJu0YzbCq46IBPmUdhx642Gj5BpxsQnrLjunadzioJeHR+emE4UxSbP
	kV0pg11zn63ewOQwUgRKeUvZOWZ+ZIpPUy2q36d2qC2wRDU7cydkJ6Hw171v2F0B
X-Gm-Gg: AeBDiet/EyRt2ssea+tHuoeWn+kA46mzsn9PBUmJ2bqu+1zSJRoMdO9YWTEDfUv0xEl
	YrsDJVy0hiYsW58Q60+fW18+GEbOb4Mhg9I5W/cFxFAWzh4K4i2zFdmrhC0PAQbPX0jj/tAR184
	jOPOP/Y/vxI0dgKbunB2fPHlWKEuoZ92MiydwARm+Bpz+bobu4sDoajRJInFkdVsp1V4LCqP2WI
	X6eqLKWxZzfv+XG0qUD2Mnof4R3WZwPxxDRr31sQUgg/p9mdJ6hwS/d91bBc9gbItwwcrpetkkG
	29ACbrRXlsod8utxmrGN+jakOqrVTKsR6j/qAl/VwjSoTiri9dgtEV/CXVg6RSnVJ5pm5RVsfWI
	sGRodKEWX0c8zhp3Oo9GavWQ/zjbh2G7unFz8VtMm3OiSExvvT0yriU6utXHSia7eYyUJADFVNj
	6GAqqqL6guJtMPj9Id34XEcvbtefd530GyTa3LfWmPjMFimK8LP8aRg1qJIWGasWjk
X-Received: by 2002:a17:90b:3a4c:b0:35b:e56e:a17e with SMTP id 98e67ed59e1d1-365abe8a2dfmr6013189a91.17.1778126547585;
        Wed, 06 May 2026 21:02:27 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365d8e3dad8sm2536182a91.1.2026.05.06.21.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 21:02:27 -0700 (PDT)
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
	lenb@kernel.org
Subject: [PATCH net-next v2 0/2] net: phy: motorcomm: add ACPI _DSD property support
Date: Thu,  7 May 2026 12:02:19 +0800
Message-Id: <20260507040221.3679454-1-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 985FF4E2C1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285141-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,redhat.com,google.com,davemloft.net,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[linchunzhi0@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

This series makes the Motorcomm PHY driver parse firmware properties via
device_property_*() so the same property set can be provided by either
Devicetree or ACPI _DSD.

Patch 1 switches drivers/net/phy/motorcomm.c from of_property_*() to
device_property_*() on &phydev->mdio.dev.

Patch 2 documents Motorcomm yt8xxx PHY ACPI _DSD properties under
Documentation/firmware-guide/acpi/dsd and links the new document from
the ACPI index.

Changes in v2:
- docs: sort dsd/motorcomm-yt8xxx-phy within dsd/ entries in
  Documentation/firmware-guide/acpi/index.rst

Thanks,
chunzhi.lin

chunzhi.lin (2):
  net: phy: motorcomm: use device properties for firmware tuning
  docs: acpi: dsd: add Motorcomm yt8xxx PHY properties

 Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst | 107 +++++++++++++
 Documentation/firmware-guide/acpi/index.rst                    |   1 +
 drivers/net/phy/motorcomm.c                                    |  41 +++--
 3 files changed, 128 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst

