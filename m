Return-Path: <netdev+bounces-292829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEsyLiKaGGr+lQgAu9opvQ
	(envelope-from <netdev+bounces-292829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:40:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E655F73CE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FE6730138B2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F208A33120C;
	Thu, 28 May 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1z0JytI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675F258CD7
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997214; cv=none; b=ZryjBNZJPv9SExlnIF1x8SkMrxkXbhTBfJHp/Yu57i/fRMK/fLBZwHYdEVMS4VrpetoZDBj/4YCFkWG5K6NtU7+EyVQR70L6n8XoAGEPOrZDVWAzwt5Ipy6Lhr/qEbJ2s4HAW+IqZMxydNVxFOchXqCXlU1jKfNJWWxfC8PC+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997214; c=relaxed/simple;
	bh=K2qUlCqGCf/92jJx+4IF5oKyHHYYJLXgJasaVVc43Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjujIiHN31q40PBWzTAOBev+ZcmTgfK8I/kcvWuVmzYvdkhJhnD8nvBNAf3XzPoMLbmemRQylUGa/QIkHujFg+8sX2EA6fj4Fakd6B7c/lk6DWP967QKNGqe7GUqTgZ+7Jcs9H26/vTaPC4y/PbVMm7h/HVqicCornJv0pP8Lhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1z0JytI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-835c98b659eso10448936b3a.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779997213; x=1780602013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+CsA+/J1XG/Pr/EQfHy6KOutt5c8etxLwz3i9ZhzAg=;
        b=h1z0JytIG9k4N1CL71kMHimmgDQ3QMqHkdkCKekrsdLfl4qP1bOU18uq0Xe5PXQoUt
         HiEjg/UFjFonPqeKO4DXFIwKvvmxHPfHRP+nhzztSN6ZfnChxH8LNJdypthLbO4JPjT4
         Sdc8GwOPk6WBD1TeEqhvVIkwXMCFWtGx9u3Cm3oRaO27TSTR7AcXQ4k0dJjek5/a+dSG
         aUEEO1pa+FblNdzxM+Pi3+F8MSkzpos5ip+BgiGKLysQheCmP4GcCL0+QLPxUvLFgSO2
         8y6yFAi45iVb6Ar5VVNCpTXbcRr27fJMqGynwz14K6xNlKq6gv2tRZVc4OpvfA3waBTy
         4xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779997213; x=1780602013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+CsA+/J1XG/Pr/EQfHy6KOutt5c8etxLwz3i9ZhzAg=;
        b=iLc3KZtV31AM4KBKuApLD8HaKRC++v2EIZ4/BXbpRHxeEpH7wfQ3bH1Fv7bLBijR16
         AR7xc/MQrM31UWyvYesafpv/3coKmIplROY7BWYjdrCX8B+ODfzqnrYM/Th+Y9LDHK8f
         3L6co2wTZXS1gzo9x21SRF7YnZ6jp6Fa3L0fRynkWuZn9Lxp6ENkjcobWZQ0hrLPOAxS
         rKIh0jJUz7+QDu9nVGH539v1Ooaof9uFvUodLrnxp6tWuiwvnGeU/tkLg+nCFJFhOEdv
         nyYzGmd+cQR8zKYZiho337NpG9I6BL11Z9MunO9kTDiIaZnI/V1vYwSzguOKvNKX5sg+
         MkYg==
X-Gm-Message-State: AOJu0YxHop7g5dyJeel2BDcys94L3eUtdVAepdFBX0XCV4l2QiQ3nLoR
	AEUpO7EVLPLpnZ103zvXNQYP6lT05E2s+iWRXUvvT3nTziDlQ11c9TTrqcFI0MmX
X-Gm-Gg: Acq92OGuBJcPTGNol4kIfsLXNiKbZsj55sRr4ByeJm8LzE4yrma2Pl5AV0qAR55t3HJ
	UXylafnPsYO8qDNqhvHJhyRKTZiMJy3GleG5/xfoNzMi+OGINFmiqh2Np2o7kQtx18NR3DfUL1+
	ceUWPmXOCjosi4QkSip8WD3D6QJO4BTjwl0yUUM55Pk/mSXKGGHvlNbqoxLAw0F2zsUWDcWCyvx
	3DZYZnqdM6esYNvFgjOQz63aKlCwrkeo1XeWxexAOtwmYZphUDzhTcLWBU06V57HozbXq24l1qs
	+aKAxDD+zk4vj9UxUyB9erMtPQhPq2OWMQ7TfWc+VBD5sv3uSWNtE5+OJno6xrtEzDRCXwd0pFr
	T/WtfPzO0W5gpRsM213Wb5y65Blr5eBqkZweWf9jzi6h5Z/fMacgeWyPy1GXo0+AL2WtQVd+FOW
	X1KgWcygz7qRJ509CNT4pHPVOe1D66pNYbGDSxqQ95RJq8DjHxOYZYEkw8W15mEtybrAGlqaOI
X-Received: by 2002:a05:6a00:2e03:b0:82f:2a78:6302 with SMTP id d2e1a72fcca58-8420cebe803mr289820b3a.26.1779997213194;
        Thu, 28 May 2026 12:40:13 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eac68esm5900184b3a.15.2026.05.28.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:40:12 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/2] net: dsa: yt921x: Add ACL support
Date: Fri, 29 May 2026 03:37:17 +0800
Message-ID: <20260528193726.1893365-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292829-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 33E655F73CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3: https://lore.kernel.org/r/20260523020704.503966-1-mmyangfl@gmail.com
  - handle ACL tag code
  - fix the upper bound for FLOW_DISSECTOR_KEY_PORTS_RANGE
  - extack messages when possible
  - check the redirect target for FLOW_ACTION_REDIRECT
  - fix candidates overrun
  - fix the activation order for rule and action
v2: https://lore.kernel.org/r/20260520022242.120640-1-mmyangfl@gmail.com
  - v1 was mistakenly sent as v2
v1: https://lore.kernel.org/r/20260514192140.3468543-1-mmyangfl@gmail.com
  - fix issue reported by test robot

David Yang (2):
  net: dsa: tag_yt921x: handle ACL tag code
  net: dsa: yt921x: Add ACL support

 drivers/net/dsa/yt921x.c | 1013 +++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  284 +++++++++++
 net/dsa/tag_yt921x.c     |    2 +
 3 files changed, 1296 insertions(+), 3 deletions(-)

-- 
2.53.0


