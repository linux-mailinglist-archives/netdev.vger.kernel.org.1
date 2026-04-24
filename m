Return-Path: <netdev+bounces-280938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIr1D9YB62laHQAAu9opvQ
	(envelope-from <netdev+bounces-280938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:38:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C4C459EFA
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D005B30039BD
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A5C33F8CA;
	Fri, 24 Apr 2026 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwJA9U35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6172DB7BA
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009108; cv=none; b=WwR0Zz0d1foCtB62XK9VKSTVvPY5hLotLYwuP7JyCZt+CEtjKl5u8plfYuiGYU6ph0Em8NETmunqiq3vkfBB+cCc6wUN0FYCXcNu1QPOyy6Jik0pCElrBIpafk1L2RnX+a0glUALLguR+eBk7qp+gtPdgWOPsQ/3eYCtE2iGWtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009108; c=relaxed/simple;
	bh=jKUtYQkcUdb6GMiVBeZKnn2Sg4Wt48SXWC8LTq8RAjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L2Jk9tEJGnUX6zpunRWItIQ/9LiqGPNaf3JsbJQQgrtcB/CoESB2JnqvsXhVfphjKREKeAss2cP3x5icYn6a5FglSVCqjI7o9DUk/abAXQHODsgtX6pqnGnZ1CmFIl3jaFlL13KmML1znG+rfi4ZAB40hZOwlSp/LzvE1pfY4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwJA9U35; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so4982040a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009105; x=1777613905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvxaDNg9rd7ZuL5f80UF/S9IKmmFHCybFxij/pdjuYw=;
        b=NwJA9U35rCIFYqCR/ys3E7KG/rfMKTN1rm3AaFVpq6l1wkllhf9g/riwxgoScSsqRb
         gWgudmmZF0S5qY4cKKdT6pKSTiRgyCcBw2vG6yBVcWrv1SX94q4ZxfqX+cO6ILecvXO4
         j7/Pj8fyiOSQhU4BT8yDreecJRiI8qKJWt2AiRqAdfHSB1BmLco8mJNV+toe/7gfrU71
         P+JFGmJCk+gExQxWK13QcCEHz02yy2Nk4Q74u65svT41cbzQBTPfAbElJBvQwvry/MN7
         6DeM72QCTZMuofN+h1EoscsdcQOVj3ZKGAGbVmehVZjEYE6cNQA3ObfTYVgXMRHs5QUd
         Z2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009105; x=1777613905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvxaDNg9rd7ZuL5f80UF/S9IKmmFHCybFxij/pdjuYw=;
        b=hqYEjf4+A61iuYOw9L7oyDpuvcKKm9tldNommJnjyhCMw3g+faKULCdp3mB785tPkl
         qMUr7FzTKLHEYINrSFkzdtFoTVXpyLALVu9XUvqMTxgyXgdGm1C2VHqzGy41pzbWXRe+
         yM59ZR0Hx8jBgy6ihQvtAzU15xNq05Jh2BaqpuXHTC5i1rwqkAgCoFt3NN2ZRpt62233
         N9yvh89Vshq5NJrK3Q4zEMLxIai91Sfd2nLNDubDWbDfi1mBf6c7uCAUWAp1RvbYlINg
         mgH/OZB/O+zqdCuiSUS18vmG0Ubs/3DPd40DOcF+twMaIqWLyFkE1yyCFwaCm9aZcsn+
         79aQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SRzOedhSOA2UJsDTlQjocAerJiHRiQJIEGiD8A28yD1Pgyo1aGD+z7V6QJ+zs+KgUUC/E46o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHsoLEhIiLcTxLzkd/e72sXhJh4hR0ACH5c1g2+x+Dk25+6Eb
	9/55LPdFFWc7Iij0WBB2trurWLxtan+etVhWojP/8OjYRxlaDQ//d443
X-Gm-Gg: AeBDietQYDQFLrKRml/KEfG2Ll4pH8dmuUrWtZspk5hM56/IMnPj1Du6AJkV0Uy+l4f
	88ER00sAAf1GIkiPeCwXsrSQomWJigoraYJxJfth+QLhR0Ynt8EVOfwwYLZboNgbBVNn0MqQ5mo
	kQW4RDpicEirwKztMKH7J5mleIsqY6QiTycpruVFgpWjoSG2u9oYRD65Ww7BNv6oQ0wP/e9xHyF
	I8iDhUZjO+qLZCxUNDvn7t8eMIRWJN6Ti7m4K1ofISO9W0r/ZmiGIGUykRTc3+3jYDBayB/qIoZ
	8zMOzjeN1oVcmQ3i6DiXbDTwDO/e+HGsCmwyRv8CpcOHY7UB7WPFepZMeJneZqz3C5AnkSsT0mH
	FsCFXJ9I7YC09urB+3of575wc/qHE7tRakSfIli2swhWikt90is+Wz9TECpkPUEb4V7FrH9NJEX
	U9ki+mOwBrdsiJmDZimGtbxQh0ORpTeNYwW8GQcCV8isTrWA49Na53iLx6fKFyntukIdujkmC62
	2H/1OlvcxvX1XHVxtEZ9RiUBfbG6GfFwNHcDYuL
X-Received: by 2002:a17:903:1b48:b0:2ae:c5fc:b2ea with SMTP id d9443c01a7336-2b5f9f5f84cmr309649415ad.30.1777009105137;
        Thu, 23 Apr 2026 22:38:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:24 -0700 (PDT)
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
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 0/8] xsk: fix bugs around xsk skb allocation
Date: Fri, 24 Apr 2026 13:38:08 +0800
Message-Id: <20260424053816.27965-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6C4C459EFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280938-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Jason Xing <kernelxing@tencent.com>

There are rare issues around xsk_build_skb(). Some of them
were founded by Sashiko[1][2].

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/
[2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/

---
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
  xsk: handle NULL dereference of the skb without frags issue
  xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
  xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
  xsk: avoid skb leak in XDP_TX_METADATA case
  xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
  xsk: fix xsk_addrs slab leak on multi-buffer error path
  xsk: fix u64 descriptor address truncation on 32-bit architectures

 net/xdp/xsk.c           | 65 +++++++++++++++++++++++++++++++----------
 net/xdp/xsk_buff_pool.c |  3 ++
 2 files changed, 52 insertions(+), 16 deletions(-)

-- 
2.41.3


