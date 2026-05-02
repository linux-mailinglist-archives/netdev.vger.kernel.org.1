Return-Path: <netdev+bounces-283472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNSNDodZ9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:07:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C824B35E2
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4DB300D68C
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1DE388378;
	Sat,  2 May 2026 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4muSleW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35638758E
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752451; cv=none; b=if/CYMEV54JWb7L+F0O+sTH5xs8OHUijBAcGa3QBpNPSvFRQKOeyWdm60Ba+GgODtYXHHKrm09EdLiuI7XuosR8kHRCYSnQ9FqJlrg/tirVpM5uHfQMXYBNLMXRZO9xrcwDi3vdf/RvTt2acsvuPgJytl2YtWlx9oIgRBEJEHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752451; c=relaxed/simple;
	bh=TURl7kKo2rz7v+LlDTeZ01AGJ284PRpIn80ytw66Cxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=boPcKmiMF65GqqrbphGn0ERakPkH/V116D1HHtP08NUcALKCUC1bmtu5ClStcPyrpAvq9GBEB7x1pxXY47xDdox2MnDep/pb5/i7oIePUGUujMC0ydB0PFpfSwenW8P6a/rawkJk1Ws/rzATV3pMx0jCxcY7KJ7YsfrYEOLh4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4muSleW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso894297a12.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752449; x=1778357249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAg/0mIVowv8LOWrAsq6a7YduxLHVN0hmFUezp0XVPE=;
        b=J4muSleWHrfdFEtOuEqD1x0PgGfxM01KVbGNVMnLB7LDtpgZ3VYENet2Lj42xPRAyx
         pN3ZfQWJiDE0g0TbelIvs4fURGO81d5rlNdWtBDe72pgcqjr4sVSTOmWYLxygWQ+BdKy
         yxl9FDPDf46Wt11PJ+yOZMm0QOM4rUg3uXx50aVE+HTswzrCdbIbhihJRfuUTGBJgRmy
         C0r0OKShIkI+prp5yUzi12vuA+r31M9CCivTlxZh4hUBA6TIxbzcGYQgZuuJU/QyoLOG
         7YXbL84WWuUxO8dL03cX0PRz7V7AsfvV/8oKdhMA55ixNnq2e25ztEMfr6YDc+TZDoWB
         zjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752449; x=1778357249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAg/0mIVowv8LOWrAsq6a7YduxLHVN0hmFUezp0XVPE=;
        b=ShWUu2oQ5/EyACVlg+u258bQ6g6BwNbEFCY2CedftRw+mz2q9D1tfXjnbqxaFUAk1i
         9q7vKnEPNFU+1gPbt0ONaMgDvYSP67E4XOvV6JWXd7f72xMtEeJXXrHeHijU1/TBhHaR
         rSoxBEduvAx91P2DMhD+nVsGfNpaLb6XZ6gPXSMJKOFQQI19dJoxqCSiq1UAcwrGdNmi
         fktiE3ErQfrgODRxHsjKs9vpTHLvSXGPB41LYJNJQW5FGlnge59lBE8g12Bxxwik5VAn
         AOLEeA5M2z2cd//pSLPP9JsB4oQE93cqMtGV8yoB4Ks7wW0HhMKbimOhgLTq5bUroIvZ
         8kmA==
X-Forwarded-Encrypted: i=1; AFNElJ+9wr+X4ZTESEdoQDvL7YzLcLM22cjXD2GuiKpw/Wz0XnNRHlZktPrKx16o2Vm+CBDA2cxQWTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn22YtVFQYY4lzQeBXOBDCgmNyDTHp0lZXcj1XqkHgO8DZBCz/
	sUo+zpsNhSMrpq0BY1g+yUL1m/L5XJQni0p/opLI7PiQvLTRbpQTk0ym
X-Gm-Gg: AeBDievQLBTAi7L+3jl3dOJ3W3TdYtV88AztbXC9mzQITAhu3J/iU6UxFhFKwoGJ7qV
	SOoJSAlgZolA1oraRpKYEw4fMtk5DVT+t9HdfTWgPRduxIBiGmah6nmnfTYbP7u3a6wt8OAjJBq
	GHKOz4uFfOvZmKBGm4QMdyFAL1CvrStVkSQWqSAVeKWqUU7Lx+46aUqIFk9rOVoJi4kql0qojqK
	3VRIg1Uwsz4NgAXwY4e6kQlKLMH3nGfxmXSnJeF/JLiCSDvesZvz6PwUcQ73Q/5MRCwoBecVxyg
	TvP8a6WJJkjekpFBy2dCMnkq7Wc2ufQwhEZMOESmhMmtNTkZA3WE28bM9UZU/J6oMFUqwXyU4O5
	JEoSz869vJ6YyNEee5UJuE0wAfcMIFGLAsrhb+NLnm4g5/QYM5Jr8xesLwthoP/Hv9dxd+AgazR
	TzdmhVZL13T+OX3fmaKavRnIHmCTOZKpC948HaCI+3xSKh2UMoe7YOiKLxeeyA3H3Um7ZkUe+tA
	WCDMyvfI9cSppWpNcpmD/mzd2M6
X-Received: by 2002:a05:6402:605:b0:671:a18b:32b8 with SMTP id 4fb4d7f45d1cf-67c150d2b76mr1186953a12.0.1777752448468;
        Sat, 02 May 2026 13:07:28 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:27 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5 0/8] xsk: fix bugs around xsk skb allocation
Date: Sat,  2 May 2026 23:07:14 +0300
Message-Id: <20260502200722.53960-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A8C824B35E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]

From: Jason Xing <kernelxing@tencent.com>

There are rare issues around xsk_build_skb(). Some of them
were founded by Sashiko[1][2].

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/
[2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/

---
v5
Link: https://lore.kernel.org/all/20260424053816.27965-1-kerneljasonxing@gmail.com/
1. reword patch 3
2. adjust the order of patch 6 that is now moved up to be patch 2)
3. use helper in patch (Stan)

v4
Link: https://lore.kernel.org/all/20260422033650.68457-1-kerneljasonxing@gmail.com/
1. fix 32-bit arch issue in patch 8 (Alexander && Maciej)
2. add acked-by tags (Stan)

v3
Link: https://lore.kernel.org/all/20260420082805.14844-1-kerneljasonxing@gmail.com/
1. use !xs->skb as the indicator of first frag in patch 3 (Stan)
2. move init skb after it's allocated successfully, so patch 4,5,6 have
   been adjusted accordingly (Stan)
3. do not support 32-bit arch (Stan)
4. add acked-by tags (Stan)

v2
Link: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/#t
1. add four patches spotted by sashiko to fix buggy pre-existing
behavior
2. adjust the order of 8 patches.



Jason Xing (8):
  xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
  xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
  xsk: handle NULL dereference of the skb without frags issue
  xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
  xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
  xsk: avoid skb leak in XDP_TX_METADATA case
  xsk: fix xsk_addrs slab leak on multi-buffer error path
  xsk: fix u64 descriptor address truncation on 32-bit architectures

 net/xdp/xsk.c           | 115 ++++++++++++++++++++++++++--------------
 net/xdp/xsk_buff_pool.c |   3 ++
 2 files changed, 77 insertions(+), 41 deletions(-)

-- 
2.41.3


