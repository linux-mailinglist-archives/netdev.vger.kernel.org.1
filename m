Return-Path: <netdev+bounces-290183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF3NAZRaDmp3+AUAu9opvQ
	(envelope-from <netdev+bounces-290183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:06:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C81759D83C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 290A03037D62
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A745E2BF002;
	Thu, 21 May 2026 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swUrJ22s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198025B0A5
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325442; cv=none; b=jrD+kEoa1eawgRxOPtV3LAaFiyGBgn9wZFg+KDl7OJ+axVOfoTvm60fJgI0BcFQExhfWc1QaNBl1nSbv9weUB2oF9B/1vO9z9ZzdKlytnChBo6goi6yBHEpF1Ioh5VADdttf86f3VawYGsGk4ZR+kYAenGtPA2JMl6tviJ8XyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325442; c=relaxed/simple;
	bh=iVF98rxkKevQZZ30uvqawTGtd5j6GjtZOX2zGSy727M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lq5E02m5c6CE6scfmVvNP+IlrTUqj0HQ3NTl07WI82/g9bZB46Yhhn2fg5sz8ZRePzeNXjz0qyZAUQhzgMEXYXe/QdmrkQppp+LNMK2htUL6WE2qGXqcD6wUd4PNSO07ilDpyM2hJfk5Pwm3fVCQ7FhBkCqi/k24ZpD15pi2350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swUrJ22s; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83659d38e38so2207404b3a.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325441; x=1779930241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pgvLZ4VWbG3vGJKOXmNMkb+MxdZzBVgDJVkzCi4rFUw=;
        b=swUrJ22srRHcLfq5V2Paamq1Mbi4IoPH4N03+FEFhyWjTBWPbaPH4ivhJOyGjMcjFS
         pvXvXfGSnw4x5Fr9KctpyemTm/dBooH51fZH0VaaaB6PMfYL2P/Z5XuR3Q4xhFwEhLdl
         ARfA+Db+/pcRzxubZ2lij8uzZdQjzKmB0dYayXAsDurHBz74Mf7zW6Q5Q0ztIK0nFK7u
         tgSSpW+AhfNhAJK3xleOIyUVZRRx17BhXT4CIazJRgzsapFvIY6qc/MfOAukyGQHzgeY
         RQGpqSUuPRfow9QX4NYYSl5HK67p+mZrZU/2vbKl5rdfrqXMoHkA1KV7t2YT+FAhTiT+
         6Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325441; x=1779930241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgvLZ4VWbG3vGJKOXmNMkb+MxdZzBVgDJVkzCi4rFUw=;
        b=k3JNrzM6V1jYp7JTdhLiYdl4TldDmAeiiLCOGjJc3qC7Ml7OzGC9wsJwLc47hAASkb
         u1QIqvzGQnc6PG3/aal1iSTg75DtRhYUeVhQoZf/tnn+GVVysKKRJhtzuECyPFDizLfU
         VzIN5w1C4IS+xhXQxyVT89bq5I3VIMVYc7ZDMQmmZgsqkDIWYeaDE3kp/RhaTx2sCn0R
         H9WVxJZZTJuKsangscRGl0O2nqMrINcktEjQpBVOlBeYIm/W61+rtrqDZaRjuNTGVuiI
         c8AYE1cPZHa/RD+L/zwm7TVz3joErQoBjkvmBYfTHUsdDgMb6qOKRsFla4tVi9SpYNg4
         Q3Qg==
X-Gm-Message-State: AOJu0YzADhjO45ivM9Ncc2/bEDn7uNL8zHoFCua6lvaeYif4lk0mV/CE
	ns8NYtInN0HIIQcbY4XYKJsm6Pc5YwWxgZrWTToKMCopqOkAuVWetvOViZVs8jPo
X-Gm-Gg: Acq92OH/LAKOgrk+TfBcc2bJwuhFp3BcNjZlf43d315N2xR8UrIL3+IzCQtdvDL+Tz1
	+VnfNHX5Eo+kFcxG5P2DLs4TQRiPh1RCEI2tKr6u4e1EsvYLtx2TNxzf5Q43dmOvNf4V56f0G/E
	qi8f5uL1hh0Zdc82mjxlZl0SYSKlLBhO3iDjp8zis040Ph97dTmfKysMQVMVCk2XWhcOs3J4n8P
	r58hAmBHESd8osTKRWLnEY9/xUTPPo6qC/GGhT6ppJXOF+EUlUF2JR7BWXjaN2C1BcWJxDLrHAT
	/gp9rTzKoVgUFACshoTSJ1eGvpYdMABeEcuLhYz8jAYLBq9CPBKfZcO/9tQC0gEaXEMyF0o9Zdm
	FCqZ4qSChj78J4kzBnWKlGIs6h1fre+KwR7a0uOzdIS2M1T8ozxJEdt/hSCFKD7Kaey9zt3KQGI
	4xD21lNJX6Ydtw0wIHB5EL8AXGj1cGVCot5lG/Y3uQ7OzhYiE4vFNXcgHHvh5G
X-Received: by 2002:a05:6a21:3284:b0:3a8:1350:ba47 with SMTP id adf61e73a8af0-3b30885f550mr709050637.47.1779325440590;
        Wed, 20 May 2026 18:04:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661f:1232::1d0:bf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114a70sm26319616a12.22.2026.05.20.18.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 18:03:59 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/3] net: dsa: yt921x: Add port TBF support
Date: Thu, 21 May 2026 09:03:04 +0800
Message-ID: <20260521010320.208138-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290183-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C81759D83C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3: https://lore.kernel.org/r/20260508065757.2566258-1-mmyangfl@gmail.com
  - prefer existing extack message in qdisc_offload_graft_helper()
  - comment the dilemma for TC_TBF_STATS
v2: https://lore.kernel.org/r/20260504101258.1608004-1-mmyangfl@gmail.com
  - drop changes on tc_tbf_qopt_offload_replace_params
  - drop excessive checks for tbf setup
  - react to TC_TBF_STATS correctly
v1: https://lore.kernel.org/r/20260502215314.917687-1-mmyangfl@gmail.com
  - remove queue related register definiations
  - add missing extack param during tbf setup
v0: https://lore.kernel.org/r/20260409171209.2575583-1-mmyangfl@gmail.com
  - picked from old series
  - add extack to the offload struct
  - add all params to the offload struct

David Yang (3):
  net/sched: prefer existing extack message in
    qdisc_offload_graft_helper()
  net/sched: tbf: add extack to offload params
  net: dsa: yt921x: Add port TBF support

 drivers/net/dsa/yt921x.c | 87 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h | 18 +++++++++
 include/net/pkt_cls.h    |  1 +
 net/sched/sch_api.c      |  2 +-
 net/sched/sch_tbf.c      |  9 ++++-
 5 files changed, 114 insertions(+), 3 deletions(-)

-- 
2.53.0


