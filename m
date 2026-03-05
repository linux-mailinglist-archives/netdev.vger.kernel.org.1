Return-Path: <netdev+bounces-264244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMDWIS5NqWk14AAAu9opvQ
	(envelope-from <netdev+bounces-264244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:30:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EACB820E6B6
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B9A3018BDC
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61CE378D93;
	Thu,  5 Mar 2026 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="lxthE3MV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FDA378830
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702851; cv=none; b=kY5MpwcY71Q93ON3/qHAbqUeQzUknGL5wq+Alv4+nygL7OkcDddAP6qVQ84lNREAoG5eaytdKfxpzX2SSPFa8eOp2UMmcI4/ZFcXQ0c04Kzi4GvnKGLfGP/2tXM2ZtL3tdfuWIH/4dak7zBNj8AwjwesI8zdCBNhhnvkymkYkTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702851; c=relaxed/simple;
	bh=2PePMH51QOQScBKIQmAwYsCjjKFqsiR+6Jtikcio/ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oj9IAAdihFXXY1A7QJmWdBP5//iZg6Chg18ZvtMoRLz8EgkWnapXIGeKZDvVG8bggaq4ZVKFtpQwJoOa30En9J6EpU0JJauL4ZGKoEBo1voM3S6uEFzVga9LMSOcYHsreqyV54gDQo/UyOTeXw81nWreZFKFw4YmduFzfRokiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=lxthE3MV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8297c035d28so435477b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1772702850; x=1773307650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPXs6PfUXl1cEMp4W1johnBTotcqaLqamluhFRdFy+Q=;
        b=lxthE3MVLq6Jc49YsIpu8x54hOhdYMENOLInJYRJLb7cqfRdUP5PhqIEnryhVoFb3V
         HenYBEhebkx0EpaKiDyQfyYtH2mI6T5uP8GkYbh+kJeJ8ONncDoZ/NSDeq8Owlg2LRnr
         B9Nq6zVzp6xlCp4SFXDtMcrg/7/Yf+7FLm6SuZXQ/hbK7jM+qFvgHGiXNJWQ2Ea81qJz
         0AM619GabogMbx5CnU41gdr11Uu7AqDYhG09EvsuHVsLHHcrTEtZqARZqIfQTrURWJjV
         3Ra9iGU6Wm5FsWfcq5ZQYbIHdit3k6Tg4aqDQlTEhaVg7TlhVFXX8+KFOpLE1oRNMmDe
         zfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702850; x=1773307650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPXs6PfUXl1cEMp4W1johnBTotcqaLqamluhFRdFy+Q=;
        b=O02ShOfFvB/Snh8+33OqrSJunGjtNAniu/vFaK2wj3UYjaqTz3uGujCpW4TVG0sYmz
         0JR+rz+do+9rARfZoUzdD2nGu5iEBJpMBMRIYCu+d6AIiNjwqnyJxVbjgz69LUKKRAUk
         F7d1I8gnuDksnVvl7PRl9H+lUGpP5vJzhQUotKoLKfZUG+6whKAeSuI8y9r8PSBUga2U
         J2RFOeJayl2FSWy1feltIgyIa4o75RgFbk9ign8YkIzNvQPe01BbQ3z+ByxGixIwFZD9
         0FVz5ROv2FsgauHKCXX6mXRj3JZybheis1cLpo6uBtOvlI0qmmGi3ZtEffHMbBcGqd8v
         wxDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVd3VEy6Wfr1b90UdKJ7kyVoxCOZjD+181/rpX1NwIXwuGGDkAszZIcjSPttGbdePeKw3wqqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzV/vSSqDI4EEStlmoJ1Dv+GOEP9QB06Wb6wNHhAx8MR7COB1d
	ZYBo6zSyfZ/rsC1TREOMZKp2NnZZPMM/T1dgcGVmvf//K2Pf2B1G0LqG13tgHSGvQ/o=
X-Gm-Gg: ATEYQzwDhDvlnWp4YZrSE5E2sYg4R1BiwMV+ESe0BPEPuG5pDIe0jEkoW82WNwHWLs4
	UCPTytA5Kv7geOsc0hAn+0Oxi658vJ6lGp3iOnOfZuHRCZ2OCQxoA3ZNBLXzmXSD+2EQATcH1CI
	GjieUb7kuZIhZSIOto8C3CnwVa8ZJr9uOSByoPw0JnmWmSWZ/EdlVrRsam1zSgDYd9liT+Cmv6X
	Jg3cm4ePMbv54XTHzfItWuzmieyf0V8Ws+i57A5UERJAD9l6+o8e3+PaMu/D6B3pAeewLs/cPxZ
	hFqi13uW00IlACmF7fNoQh/v29ihKEXW3XHn9upAkfUYfQzkUO5OukmSjfMjbZyQlnbRyJYyenK
	RcKgBio0TFO/LJEeAbI1mMhvCJr0Ii21EjhOJQaD4vKqsyHJslfoXLpJjz5B3HyUab4AozivMAc
	DTxIx0XuCiA0txUiZSHhgKSFiwrv+yJQAbWjrqalF2kZsCsHCsmupnwaklplVco6nmUhajgdwQV
	OqBYR+WMbTAH62Y7nJ7SgI=
X-Received: by 2002:a05:6a00:928f:b0:829:9130:e699 with SMTP id d2e1a72fcca58-8299130ec95mr151661b3a.52.1772702849761;
        Thu, 05 Mar 2026 01:27:29 -0800 (PST)
Received: from cachyos.camel-monitor.ts.net (akacd-04p3-188.ppp11.odn.ad.jp. [210.237.248.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82974e75a4csm3606530b3a.30.2026.03.05.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:27:29 -0800 (PST)
From: Kota Toda <kota.toda@gmo-cybersecurity.com>
To: Kota Toda <kota.toda@gmo-cybersecurity.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Subject: [PATCH 0/2] net: bonding: fix type-confusion in bonding header_ops
Date: Thu,  5 Mar 2026 18:27:02 +0900
Message-ID: <20260305092706.145085-1-kota.toda@gmo-cybersecurity.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EACB820E6B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmo-cybersecurity.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264244-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kota.toda@gmo-cybersecurity.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmo-cybersecurity.com:dkim,gmo-cybersecurity.com:email,gmo-cybersecurity.com:mid]
X-Rspamd-Action: no action

In bond_setup_by_slave(), the slave’s header_ops are unconditionally
copied into the bonding device. As a result, the bonding device may invoke
the slave-specific header operations on itself, causing
netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
as the slave's private-data type.

This type-confusion bug can lead to out-of-bounds writes into the skb,
resulting in memory corruption.

Patch 1 stores the slave's header_ops in struct bonding and sets
wrapper callbacks in bond_In bond_setup_by_slave(), the slave’s
header_ops are unconditionally
copied into the bonding device. As a result, the bonding device may invoke
the slave-specific header operations on itself, causing
netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
as the slave's private-data type.

Patch 2 uses READ_ONCE when loading header_ops callbacks
to avoid races with concurrent updates.

Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
--

Kota Toda (2):
  net: bonding: fix type-confusion in bonding header_ops
  net: add READ_ONCE for header_ops callbacks

 drivers/net/bonding/bond_main.c | 66 ++++++++++++++++++++++++++++++++-
 include/linux/netdevice.h       | 28 +++++++++-----
 include/net/bonding.h           |  5 +++
 include/net/cfg802154.h         |  2 +-
 net/core/neighbour.c            |  6 +--
 net/ipv4/arp.c                  |  2 +-
 net/ipv6/ndisc.c                |  2 +-
 7 files changed, 95 insertions(+), 16 deletions(-)

--
2.53.0


