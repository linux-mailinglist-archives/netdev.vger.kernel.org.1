Return-Path: <netdev+bounces-279682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPLJAajj5WkupAEAu9opvQ
	(envelope-from <netdev+bounces-279682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:28:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09940428207
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA6123001A65
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826F9388E44;
	Mon, 20 Apr 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg84gioy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54231383C64
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673698; cv=none; b=S5Av8V3e0vyRAsCmD5XhFWUb1um6FhwZKJWeCMgou/pL/TH4QTJ8pKFuKj+A8nkCpxQ+kMdU0XJ0ekYykxXE3sot2zrRCoQ3dvKvzaFnw65yDzS2ULe/DQJdZbDiNugZY+2QqmaDQQyC3vdKcj9Rfq2BxRe7ol9polcFyWdpD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673698; c=relaxed/simple;
	bh=HzJCBFT618+qO9u307LUokE8hHZ7DtCp7Z25T9rzeHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bAH8wI9TV1D4eg45FhwUEcCjZZdDAPTF9SSX+QKRirYUHreEct5Sdr/svZc70FVWHLQPw2yfktrwXWPqwrHo2KYm38ywvKoDJXhq8/t34HmPcghP6+ijOo5P0+Z/uahdfSu44lE6lhESgCw/r19DkL/JlNMfCZXbGuti97g/7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg84gioy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3614826eca4so2115143a91.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673697; x=1777278497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2Br3MhZ3tKCh5Kc8JUM53z1zA2qqK3E/yJuKpA65Yw=;
        b=Eg84gioyvG/GF5wOt5LQ3IhvyhhQdbuCGC3jR1EO1SshNKxbQaBlJKfNwKMa0+kwI9
         cTbeH82es78ryuOH9ZpJ1BTr3ZCVbvR16DCpeOqVHskUx5+kReDY1iAiDOWNXsqoHgzu
         hxGD76fd/y2tjUHWNOrBX//O6mokJ4SxTyAS2P2gaiBKB8XEVsxfBVKBWm+YokbBP2f+
         ey9oi3bkdiULRoNsgevRbSfjxeaUPupvCLmL0EoTVYSeVhBChV4KNEa9/VaCqXDWpZBs
         dXIADndaFTWoFcaYRpznIznCjZsgDwli+wv9+ESMwvH/PUZDnrfKK5TaT0JtM9ys7Ecx
         1+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673697; x=1777278497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Br3MhZ3tKCh5Kc8JUM53z1zA2qqK3E/yJuKpA65Yw=;
        b=Ik+50AAkQpZr/+Z1OB+IJQn6uRB/MLVD4c8iOfsA7yXi7LjezV8or0uGXKytwQsq3Q
         PMBvsGj2BOzDK+rfLE4DQg/P5bU1GQlSnqVIkUD5jCCbQgqcu1l8C26yXtbEOzElaCbf
         u8Q3mggycdi6OE8Bru39mg5E9OANYHdLwui8X+yb7Wgs1YRxDhRmzxYachovLQXpuMMM
         5p39GCnmZ2F5g6xYpNlPob6kvc+cwYv2+eRTDjerEUT83yKCGsZPQv4hNFVpUTbD56jN
         5FyxDX2hIGR9zztNiIKmK6BLxll2b/ot7liprl81Fy4eWcze20avxqDVDYioM7gBYW+o
         Hz/A==
X-Forwarded-Encrypted: i=1; AFNElJ8sN4MfXqpwcOLZUYh5O1w8xnrCcxhboM3TbtNmbbUrZUu2O6SCmgyWeivUL4tEr9/cZEm52po=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybrvBOJHNga42iX5KG3S0XFTnbs7PaIodkWxHHou7PJD0uBvA
	EuTR64d8TpJ1jU0MO0Kn4J8GC6GhVNYGRURKgqSDNk7B4hyKHXIxZpu9
X-Gm-Gg: AeBDietF3ZG5Kkp1XmrvEWoNzr4h9fAtx5oDCUTqRcCtUmpgTb2gCtYIoBNNGV6Hvyb
	+6EX16FSZZMJRNa9o7SH97p+e35olUj7KoHiagJxcf46e49N+ZrsLFlcBAvZVCETS7IrCcXKMHg
	NwAdqC6AYOqODtbpBkr2XfUH3VLzv4Cz1dwsUEfO+QWYOk5PbWbtHUiPaXlUVDpLOMNGZcltcRK
	e0o8a+Fss4QIpxkQvtlcswhCTvot/xjQ1VaMo9IhApkzEnf0H6JyGysA1Y9ya3BFH5vR2OYFgqJ
	DzazDEfqjxML2Tp1wkQePW3eOHggJuxtR2GiBA9HUYsb7hmmoS+gnvE83PGE8Ec4ZBrjT5CRbrc
	PYm6GrHcTPPi9FSnPIdwppoJbsTkFsJTzmcrWQQ1EiARpf2x5NBE+/kVP14sNOFwkwkJ33yWZP3
	67it02al6dmM7PXz7W2K85H3XF134uj4H2MUiyQ9ZfpUB7FX4F2q6qMLvj2dhBFHThYA5CHNyLH
	U9QWusu
X-Received: by 2002:a05:6300:210d:b0:39b:a48e:6a77 with SMTP id adf61e73a8af0-3a08d8e9ce8mr13593889637.37.1776673696624;
        Mon, 20 Apr 2026 01:28:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:15 -0700 (PDT)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 0/8] xsk: fix bugs around xsk skb allocation
Date: Mon, 20 Apr 2026 16:27:57 +0800
Message-Id: <20260420082805.14844-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279682-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09940428207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

There are rare issues around xsk_build_skb(). Some of them
were founded by Sashiko[1][2].

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/
[2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/

---
v2
Link: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/#t
1. add four patches spotted by sashiko to fix buggy pre-existing
behavior
2. adjust the order of 8 patches.

Jason Xing (8):
  xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
  xsk: handle NULL dereference of the skb without frags issue
  xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
  xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
  xsk: avoid skb leak in XDP_TX_METADATA case
  xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
  xsk: fix xsk_addrs slab leak on multi-buffer error path
  xsk: fix u64 descriptor address truncation on 32-bit architectures

 net/xdp/xsk.c           | 88 +++++++++++++++++++++++++++++++++--------
 net/xdp/xsk_buff_pool.c |  3 ++
 2 files changed, 75 insertions(+), 16 deletions(-)

-- 
2.41.3


