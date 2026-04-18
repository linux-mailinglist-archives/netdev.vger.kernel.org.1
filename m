Return-Path: <netdev+bounces-279464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JBhIDgP42kuBwEAu9opvQ
	(envelope-from <netdev+bounces-279464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E15BD41FF8D
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED6C304E50F
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248A303CA0;
	Sat, 18 Apr 2026 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI4VE0Jx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA42EA498
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488229; cv=none; b=V3TNqcUOwl18voY3uiNnYNLV8iF5RraEIKUI1S19QHyPM0rYNqTK+wP56zc0pyh5XhPLZaha3jIibH/MrkY3ykcCft1RX2dmN/qJht1wc0nVjhQsOMTZhpKHlnVuCLxs5hLwsbLMTsojGktEodnR/uJWDBY+xe+FV7HpvnJMUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488229; c=relaxed/simple;
	bh=PO+dYX/F8E6E3r4GYYIN8Sci3WTYu9lNvD2ARzd+ONY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMyJOT8TzdRGVm4fzLq+gtrRyaaCZXYUPf3tfWlUM51dY6m8sOTqY5EAUnJWFEIWqNQR9Y37n8MgZ4s54jGT6VxNVCljYcvwYQj7HonV4gEdF69jfx3r9mFoZnfyCImFHMM8HuU2ohPu+GA4H5tEZTagVJn4qZyP+qkAcuSLZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI4VE0Jx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1215491a91.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488228; x=1777093028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QXV8vxINpWlyXocdw7x8mtClIUb+GRxRnLWTH5Veis4=;
        b=bI4VE0JxCvpuRU4axQDDFlFgQYa3tX+P8BNfDQvA3K5jvQS4zIfOvy9lcb0ldUszj6
         8JvP6dVN1akbeiju+NZTE8zHMyfpsmqAa1Ry7mnZJUByCLVFL8NodbTTQuyzqw6wTLy3
         cufzm6wLGfoW1Du+PfSAcIEtrdz4xbUzUUSA8GkpkTNArp7SwD0YtFLiu8GVE59CI2FB
         f+QqqWZzz8oDQCYP2udytGFQ6r7KiQpUaVgM2s5sjozRHYEI0zPDpuJWhWsZp7dalNGz
         //D0laylsCnkPYCKmozTFVUsxFdmkEPfVTLv+f2QXrrwKkgZAaqnXfqbISl2XlBWbH6a
         Rz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488228; x=1777093028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXV8vxINpWlyXocdw7x8mtClIUb+GRxRnLWTH5Veis4=;
        b=EJRE2LhHe4kvOhcOxz6044+nsgpr0sXYcQ4ayffg6Wji+KCFtc7hh2sDZ19PK7TCEp
         w85fYnItWUjfZuEZxG0eNdqs1ajf/XF/UqYANqmFGKx4RKn4sDzZZAqGTXrX7dSbKRsk
         W/IPh0gW/3BKchW9qZeeX43W2RbNMUp7Wo8PX9WGzG5Y1gktz2cDDenIYpL+WYCCPdNB
         qc2AeaeLqP68nwJSXcL18MVPx8nGKl1137z7rnorQWY96b9Hbg5IQt1oFWJM1hU+vFx+
         Xc0dtf0srI7+YBIY7ZxsTfc2C7VljdC5QsdwwemnnDfdP+k57ofLxgRKJ8loJFhXYvlC
         sZOA==
X-Forwarded-Encrypted: i=1; AFNElJ9R/xGMrPJ7TUIZ6ozdyLtRDr5YH8Xmp0qyqdLui3X+6adDwBnMnGeM81DTM0jR+kN+vp2Qx6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVyFIHxHHCI6VocqxyZb/qiQd+oAbxBJgf2DjXdLMXayYSn9O
	smDQDDBi13FnDTBRzfARBcly15Hw8Nkrqxxjw7eMWNmP1HAovtgm1tKD
X-Gm-Gg: AeBDietjwNMQK6A0db8rYkm9vOUJO/iKUflgCQ4H8V1Zj2KcSvwET3xp8ScfWbwdaDU
	M2kcAktVtzP5ONqiQR9Yr1TckF5CDTYar0tcoqnjBFqOSJdVvOna/dOdUth/P6i92544jqgEuyx
	s4eFDWg/lPBqV6gFOuZICrWEXVJm0EwAKHeB3AjPz6wVqUdio/xegRfv5cRMFirXFWeyLFATxWm
	a63nOyJgUVW1iDbcK69KMI0Le7HTj32MlBJp3tmvuw6x8xSIO2WDLyTJhdpRCJ4tLuhUjGmzdLw
	tSV0IDt4Sa2hECgkHeQ2Brs+13qxUqzdrMZuo+pKJnhFyoOXAmBwfOhuJToutxR7fg4Dn+6ikid
	jlD1UelgYwR6EAWlQEnOE1ocp5XLEtQuPH7g9YWoI9CCzkAcJ1AfaXj1I+olJ5DD1NnXydqal0h
	OPn0Ey1YyhSUBjPv04fw5fnNRAfRYGT3VyMPy9SVoAV0WNQ7wMEkhjA0uwS131nNGShcDeB8woG
	JcBCGrRwg==
X-Received: by 2002:a17:90a:d607:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-361402339f2mr5898880a91.0.1776488227780;
        Fri, 17 Apr 2026 21:57:07 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:07 -0700 (PDT)
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
Subject: [PATCH net 0/4] xsk: fix bugs around xsk skb allocation
Date: Sat, 18 Apr 2026 12:56:40 +0800
Message-Id: <20260418045644.28612-1-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279464-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E15BD41FF8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

There are four extremely rare issues around xsk_build_skb(). Two of them
were founded by Sashiko[1].

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/

Jason Xing (4):
  xsk: avoid skb leak in XDP_TX_METADATA case
  xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
  xsk: handle NULL dereference of the skb without frags issue
  xsk: fix use-after-free of xs->skb in xsk_build_skb()  free_err path

 net/xdp/xsk.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.41.3


