Return-Path: <netdev+bounces-282809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEo1LPNA82kGywEAu9opvQ
	(envelope-from <netdev+bounces-282809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:45:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E774A24E1
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE49E3014868
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F95B392837;
	Thu, 30 Apr 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYnMtukj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28A2749D6
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549551; cv=none; b=styjXK248UiMGtsKK09lgYyhw9AIhdBiVdHaOfyHtA/1mhA8vaYgHhF4GF42ljKPfboyKhVnRectnDf2eM0aNBLjAljZsu2ZwrD6vB4ImuVwm3duKS++roQnPznw1cMOD81iB2Pc/TeZyBj2Vhv8vzyRBEpw3m5JZ2nsd0JUHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549551; c=relaxed/simple;
	bh=/0FsnXk2ybdqWyFYOru4Nkqe7n0z9NrSPOnr27Eas4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AB1Fdedmd/7G35E5lu+dsCe3VggVHmHW4+O+sMGeNcxWEcqlmUk+IpiwhjyYpmpKIl4/bQfyJ/V2m4aNuBQ3AvvsEwNEGONASO76+788zenhz3eJB3vB4uFYB901Nzsi0QYn95WbkGi7dg7wGMjmsd4eoLErIaMXdwAd6w9zBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYnMtukj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so347777a91.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777549549; x=1778154349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ9mC93O9dQ/DXZa3COPcwu3s6gJGPdzx4PPPp5upBc=;
        b=bYnMtukjyleA8m0V8wCG7OIn8LJSjF3mZMST3wdis5zHqu6G7CtXKXiaEpaphRxfVl
         FhL/upfYEsQe1E80oOj7tnsND7TDjqZ/uS1PwHfrqORXcDgH5CEUn6x4zL5MKfUZfjj0
         0EuNM8EWyY88KrHzpJ7mWlLaf4cWmEoqv23p3h3W98a494sCDeHrUFAHR4VuVEcKmrK3
         aRv2YrtgcQ8P/HfBpqSXLKlVGXvDVto66k7iodZnXxKT0om/BY55UtLyR4hc9SlGUy4I
         ma9MlhYBC69NfXGsOlygeKssJpU34ZoDkEWzYGGEPXHTUhdm7PLU6NRxWtS4JRhePpBM
         8lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777549549; x=1778154349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ9mC93O9dQ/DXZa3COPcwu3s6gJGPdzx4PPPp5upBc=;
        b=WbvnPShKpY7opVn2twJc8KYN9h5T4v5Qm2xo/xOzwKR2xKmWEeSf8dvnrrJ4AKFeYi
         Z8uR2YFLkm49H19P+Hw8P51JCI43pYaqeEAyBQ6m8ccnRiUyAvmuD17X1WUUP1VVGvfd
         GTVuPUM1Z5TOppkeOccz9h4Ft4ze2uogR7a+zsu7rTEKE2VcAKqUqQkb9WtI/Qtu0fpN
         lJQkxFFuJt5RCBM2lh82+EjGZIo9of07dCQ57UP8YdZE6yofe9pLM1aLECOLAKl5G/6H
         /31SWUhRAktcHU1MAvXqC/ibv6eCp3SNUZsPWy+OGjcYwj3VLq4IIPsEZQBQkuKxP9UY
         csVA==
X-Gm-Message-State: AOJu0Ywo7lGh3wvTWjA78XcxVu7RTr/WsZo9Fryv6Q+OJ/d6613mpakt
	SEbEUFIMRnHeC3rohswixZ06joh/5LWtk9hgHasYkIL7NHREmFq66BiDzEDtV7Dr
X-Gm-Gg: AeBDiettM1frHGVftNTb5hmVeeMLia+dHXlu2Vqo+/l/siXw3IkzND7rj36Fk51mhSa
	XFPHOOq8YWxXzgYAY9jJxuB4Ko+ul+KJ+0QkZYbPv0TuB2pKoLZpZFHpKW0O06KAMmP9LfJmwBx
	iudWJfWqqLPMzJftuQ/r6g0e5/nqb3O4J7284w/F4i18wipH6bPp73GydUawXxAhhdPsV9fYSBg
	hioZNvdArSvJA/px7Y/EsY3IrLeYj3PAO4UOElZwiptalpUfixDPU1tuGaG1bsRHBrwtCdPhgDN
	8pVa25uiyTbgfKTiimp7n9Oe3TUXj39v0cvZ4tGl0qCVvnoUA/+mS0oOKaT99vtAn28wZuWzBI4
	Lk7NvQpdtfwFuk2eW8E7SoROOFslE7pKZ0sO8xc9tO5W8pIlSide0t2z/PxIpotCxzLXdBFk9+F
	/P/wNRb7BeS0H606fedSU6VjQplvrOH3oqrOv8DBiMsATUAlgVO6LH0n3cumgj
X-Received: by 2002:a17:90b:5408:b0:364:6558:99be with SMTP id 98e67ed59e1d1-364c312e298mr3085695a91.22.1777549549353;
        Thu, 30 Apr 2026 04:45:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98895afaesm69245665ad.57.2026.04.30.04.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 04:45:48 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v6 0/3] net: dsa: yt921x: Add port police support
Date: Thu, 30 Apr 2026 19:45:23 +0800
Message-ID: <20260430114529.3536911-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26E774A24E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282809-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

v5: https://lore.kernel.org/r/20260428112606.1917230-1-mmyangfl@gmail.com
  - remove new line chars in extact messages
v4: https://lore.kernel.org/r/20260409171209.2575583-1-mmyangfl@gmail.com
  - split series and drop patch for qdisc tbf
v3: https://lore.kernel.org/r/20260407160559.1747616-1-mmyangfl@gmail.com
  - explain long registers more accurately
  - fix missing packet mode flag
  - rearrange function layout, in preparation for further patches
v2: https://lore.kernel.org/r/20260402223437.109097-1-mmyangfl@gmail.com
  - refine commit messages and code styles, no functional changes
v1: https://lore.kernel.org/r/20260225090853.2021140-1-mmyangfl@gmail.com
  - pass extack to user tc policers
  - keep reg64 helpers along with reg96
  - avoid macros in favor of functions
  - adjust log messages

David Yang (3):
  net: dsa: pass extack to dsa_switch_ops :: port_policer_add()
  net: dsa: yt921x: Refactor long register helpers
  net: dsa: yt921x: Add port police support

 drivers/net/dsa/ocelot/felix.c         |   3 +-
 drivers/net/dsa/sja1105/sja1105_main.c |   3 +-
 drivers/net/dsa/yt921x.c               | 485 ++++++++++++++++++++++---
 drivers/net/dsa/yt921x.h               |  87 ++++-
 include/net/dsa.h                      |   3 +-
 net/dsa/user.c                         |   2 +-
 6 files changed, 509 insertions(+), 74 deletions(-)

-- 
2.53.0


