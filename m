Return-Path: <netdev+bounces-233006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC72AC0AD9D
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 17:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636383AFEA0
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E024A06A;
	Sun, 26 Oct 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7wGD6kr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0B2222A0
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496405; cv=none; b=oEBmB3ou4B32OfbQxQl7pdaB6ASS7NDJfITd5ZLGCMz8nhy9/jWVU8z9Back0AJ11Yn0OsNJ1sJKc5wYHTH3ZHRG5vhsqDpV35l7rE9tOGk/B/4RTU/5xaFCFGOTAQ7+DasDhxUyDmvTcu5tBunv24cPjOqYNHUpSB4NFBjO3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496405; c=relaxed/simple;
	bh=dkfgSRg3n/ubnVVhdVKVipSAGyUHeSxeTZAvC8QYEGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jm9GjwxkvLze//h5yfNdzK6dL9FROFUQprIZ65vT5z3jcnMul0QIhWg7IQOwO2cRdVlHTIiuIcchVi1s8ll1WzVyFLJBSIEOcJgKlNQh7FkoYc+LDI8ORy8ZbLxp8+UuPE5kvjgtQrNeyVSZ6tODlVBHArFBUl2VgCIUpg97Q74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7wGD6kr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33bba55200bso730398a91.1
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761496403; x=1762101203; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sbMEHOWO5Ae/gMtvFENkyfzcNJXX7WO2rOgBfdcmdE=;
        b=D7wGD6kr5KaXWkuZ1RT7Yb+wB9X17LgfcJy/ebeZVv1InmTLBgRbvPtP7fIv6w9bS4
         rulFeG3MhawTMlx75E6Z7TgtQRZ8KnDyd9yr9/sk07WGkZwOVe4iXlly3OS2W8/StTUe
         d7NjHX3Hsjx+PO1Y10TQ992gqU6mQSiGaVRj+4RCxU1jd8kVlVHfJ9ri827MFp2lcDXR
         /74URtbdqrRNAyBSbhCOiqOyvipc2XPvEH137PH/1fKJAl9+yLMwpemXgDC9hVTKBwmi
         XQnBg84PnQGwQWQBHC57q6kCQFZ1nSQvNYb7Q3JIvAQ9zfsL5tMyOQUDI+9eek3CWD25
         MMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761496403; x=1762101203;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sbMEHOWO5Ae/gMtvFENkyfzcNJXX7WO2rOgBfdcmdE=;
        b=J5Szn3flN16uxLC4RVlIaIofE6Mramu2ckFikgpa9iXTdaDO/8AihjLgyyDf8OH0qR
         FNdIIAXvGTVSx4DKHbE6vTfIvTa7szO9EpY/VR9U3eTqVeKahaiDr1sErtUviOtQSnbj
         r1tg6SzM1GZFDQ9dAWM7wwvYS5JVvQyxCU9Up3vN3XPbWhA/ZBYDRWQrDnFhCIjX8vhe
         kDf4EAA+Mrg+N4yiYlMpUxBMJRdcmz/7/3Ozcqab6wgKSpy4Td15HwJW9w9jkp7lIhFD
         Kd9eEw9xSKSuVXo7Lf9+7pQqgD6cW4Gbw4sM7/v083jRqxCGoWgMgEaaFjaiBgUvpW4k
         oD+w==
X-Forwarded-Encrypted: i=1; AJvYcCVP89Rekq2ZsfmS6SCMzc9j3GNLI3Mz7e+jBmvHUNBSoY8NjYwxYXo+6wiDYJooru/XHz302og=@vger.kernel.org
X-Gm-Message-State: AOJu0YySMoplbXlNhy+K6Kio4Pepn6lGvD390Fao8GOVaaKdZ+ZR5el7
	wXJDlwoNgStWfryAj82dxK+stdeRZl8gE5/Lj+oFIweYfUdB8wy+GVqG
X-Gm-Gg: ASbGnctNp/DqY++EvO6QxLAzHVas2ChN3hy3B24PSTtObEVzuVZMjZlCi2wTx7ae886
	MkRIx7Git6Jb2XV/osqpmmpqMLhQBlIO6MGFJ0cvyYGCGkveTZxwgHZ8if4nDNdNMNMXlRipRFZ
	cRObO5nm2FUMCh/P565Ok/w77WJgEf1wJSGQidLryS6N9qhfpnv3qk3sCgDxTNZxKc+s9u4rZg/
	tmy4qh8uYlMrTQyFFKrz+55ZCQRi6PNgTjsYnv368zFsT9+iUgvOY5Tsv5xdSGU+1n+2MUCYKLm
	SfW+EBjvPnQ3/hSwTSdf3+uuTrjwnJ+QKJVVMo4UQDjaaiVcdvqC5Ew3RYjPcd3lU63dI9Cp6Sb
	uEALlgB0838u1kH8MoQnbxoXNHfv8epiOENfgdVgS8QQraoYGZPLYOXfrHEAYAEBUe1RnbasyKy
	AndFj5864GzOu+rmWaymv4/v6clyRDlGwAGD/hvqSFaiFRw9i+YPVe
X-Google-Smtp-Source: AGHT+IHcEjmlNyC3BUiCH/cJeBxJokcXHzVfjj+6EljnXykqRRfg4XwTOuv1Q9en28L2oqmxU7E7rg==
X-Received: by 2002:a17:902:d589:b0:290:7634:6d7e with SMTP id d9443c01a7336-292d40198f8mr135057545ad.11.1761496402921;
        Sun, 26 Oct 2025 09:33:22 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:10c:a59a:a7b7:a351:9b3b:d26d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bde68sm4837369a12.1.2025.10.26.09.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 09:33:22 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Sun, 26 Oct 2025 22:03:12 +0530
Subject: [PATCH v3] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-kmsan_fix-v3-1-2634a409fa5f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEdN/mgC/22Myw6CMBQFf4XctTV9iG1Z+R/GGPoAbrRgWtNoC
 P9uYcXC5ZycmRmSj+gTNNUM0WdMOI0FxKECO7Rj7wm6wsAprxnlgjxCasd7hx8ilau5NFqfqYH
 yf0Vf5q11vRUeML2n+N3Sma3rv0pmhBFHlWXKGaWkvPShxefRTgHWSuZ787Q3+WpaoYXtjKaS7
 c1lWX7X3VYF3AAAAA==
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761496398; l=1958;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=dkfgSRg3n/ubnVVhdVKVipSAGyUHeSxeTZAvC8QYEGI=;
 b=cXfC2grfwFoLTzuKTmqRsq4RmFBhH81YwCEK+w6/9OREBTgr7kj10VBf6eGGDduYtb9w//Hn/
 uGQe23ZPQprDUJ2/t63/UnLKYIyUrrrQIs7T0xElPUnR1QpQ8ABqBaS
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix an issue detected by syzbot:

KMSAN reported an uninitialized-value access in sctp_inq_pop
BUG: KMSAN: uninit-value in sctp_inq_pop

The issue is actually caused by skb trimming via sk_filter() in sctp_rcv().
In the reproducer, skb->len becomes 1 after sk_filter(), which bypassed the
original check:

        if (skb->len < sizeof(struct sctphdr) + sizeof(struct sctp_chunkhdr) +
                       skb_transport_offset(skb))
To handle this safely, a new check should be performed after sk_filter().

Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Tested-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
KMSAN reported an uninitialized-value access in sctp_inq_pop
---
Changes in v3:
- fixes the patch format like fixes and closes tags.
- Link to v2: https://lore.kernel.org/r/20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com

Changes in v2:
- changes in commit message as per the code changes.
- fixed as per the suggestion.
- Link to v1: https://lore.kernel.org/r/20251023-kmsan_fix-v1-1-d08c18db8877@gmail.com
---
 net/sctp/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 7e99894778d4..e119e460ccde 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -190,7 +190,7 @@ int sctp_rcv(struct sk_buff *skb)
 		goto discard_release;
 	nf_reset_ct(skb);
 
-	if (sk_filter(sk, skb))
+	if (sk_filter(sk, skb) || skb->len < sizeof(struct sctp_chunkhdr))
 		goto discard_release;
 
 	/* Create an SCTP packet structure. */

---
base-commit: 43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
change-id: 20251023-kmsan_fix-78d527b9960b

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


