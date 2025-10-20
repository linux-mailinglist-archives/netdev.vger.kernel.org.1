Return-Path: <netdev+bounces-230772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3960BEF200
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 04:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB713A79E7
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BAE26B756;
	Mon, 20 Oct 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="AUOXQ4U6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96817A59
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928604; cv=none; b=TZMs7MmxLDC3whRQ6HYFiFy69srA9dKoz9LYLvActdCOL5SLjdXDhaztuWgM9dMUDZPwx+eplKPKjaUAlJdK8xsn99vTPwblWYHp4mYDS+OMSDqKX1SwcvqVl9r8eqIQ/XE7adttw3Lq0DMO82Kt9akQs173JLFFTF7yZo3q4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928604; c=relaxed/simple;
	bh=3wpwCecmyV/NJOn8EtkxacL5jdQzwDbCsRAxDYCXMTY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kzdXO8iaNRw2q0D/mICXJctqfmMyYwCxfbZ7FLl929ivUT8He9KBR1E4UlptUGbZy7o4CwMt55klw+iEG8rMC7EMjI+DP8bWCYDZOiRm1Q6xztbFqWTOBAt7lblWtITlv3o3qnIYCidY3WM8MhPpOgOAb38HlvL8spc7Nm+yWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=AUOXQ4U6; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63e1e1bf882so2412389d50.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 19:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1760928601; x=1761533401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZzLybvm6rQ/SZfuZuCVccpB0+XbR1hwk4zHrp1RZnt4=;
        b=AUOXQ4U6P8ZWo4BggpRmSGYllSriIpA14jwZnyYypncNj+BK8waijQl6Az+7+BpVnH
         N0Pjt5DXTDiLJOLW23GniWF0CT5oi+jAknXvqL87gsCpQL++bByVaKr4P1s3fD+f/wRU
         OhOs9UbH67r7QiLZ6IWeaQM/nVyGnKvyM8syw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928601; x=1761533401;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzLybvm6rQ/SZfuZuCVccpB0+XbR1hwk4zHrp1RZnt4=;
        b=j2EqXP3BynAaubWXZFayIRaYcvy+W1ToGYYucp8MGduyAYzdehYc8Kv3Houlsxcfcp
         A7zIMUsMcIEW6BrHO77kpc2rfiOzT4nDGkOW6JxQO+A1Z7N3S4MG5pTEUl+o9BHMrw+4
         9fBVo30UBmThQ3Bzk7XmfAyDzlrVFvAcv4rcTjoVzJ53j4vkvSAIiyLaLn7TKjceM0l8
         ha1SlhcqIynWR8NNS7260nxzJJSFRiVAzGeB/2qyyPCEXdAv90aEl8E2BfeJin0iENHf
         JlcNSA2tGRi0uD/2jpAIVAgBOFx0eStu2/fTbW9pnNn4NNMllb7juICSMglwPwGrsJGz
         VtLw==
X-Gm-Message-State: AOJu0YxyJKFQKzttVTBT1tAQtsBZlxDikpfjmShmgQ0q9Oq29e4MC/ua
	mvgfK1vVJih/epEgS7u/1asmRjc8yTlfJvjg6e7ZVKpmCdt4Qx4A5reGQWbX+gAeHLOj79p/NDH
	oEJkbvcQ0JkXYvA6B1l56oJWAnFeM/vGpQzs++P/S8w==
X-Gm-Gg: ASbGnct7Grm5bJ7j+PSVsmMgjyg9nBPfkzi+jFtMTQXNjTzJfLEQqZgyWKPZ9lHVveG
	pW05wap7fLJ3BxWYeN0flP6uOBvfgo+riAsGMugqhVd61NjXNdAtBjAn+kgkVGBTTy4zLC+O6kx
	i/0CbcFHJoFSk1Pd0UinoV9MvNkxHAS6MwTp2Td9GZQLIQgeyLcYdlu9ZHUJ9rj0S2PgPHrZ70x
	cFI49mLbfp9JZBANlLwJR1GozjrcDsxcARmHc9FL6Mi9ZydnhkKVBE5ldvd+9qVLVn+nbnt
X-Google-Smtp-Source: AGHT+IH/CFAht/O2GnafzPeQ+I5kuVsM3xbiD3VVh7auuOXBXqlPb6+pZc30M0xEI+h6bDQbHueVWdKyajWfv2UQx8k=
X-Received: by 2002:a05:690c:d91:b0:783:116b:fc5 with SMTP id
 00721157ae682-7836d2d669bmr207397957b3.33.1760928601556; Sun, 19 Oct 2025
 19:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Date: Mon, 20 Oct 2025 08:19:50 +0530
X-Gm-Features: AS18NWB9KnaNglZk_pGuDn5x4gPPuwdOpJenF3vZoDgxum6_ss_8inU_5YuOPek
Message-ID: <CANNWa05pX3ratdawb2A6AUBocUgYo+EKZeHBZohQWuBC6_W1AA@mail.gmail.com>
Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()
To: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com
Content-Type: text/plain; charset="UTF-8"

Hi syzbot,

Please test the following patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

Thanks,
Shaurya Rane


From 123c5ac9ba261681b58a6217409c94722fde4249 Mon Sep 17 00:00:00 2001
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Date: Sun, 19 Oct 2025 23:18:30 +0530
Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()

syzbot reported a kernel BUG in set_ipsecrequest() due to an
skb_over_panic when processing XFRM_MSG_MIGRATE messages.

The root cause is that set_ipsecrequest() does not validate the
address family parameter before using it to calculate buffer sizes.
When an unsupported family value (such as 0) is passed,
pfkey_sockaddr_len() returns 0, leading to incorrect size calculations.

In pfkey_send_migrate(), the buffer size is calculated based on
pfkey_sockaddr_pair_size(), which uses pfkey_sockaddr_len(). When
family=0, this returns 0, so only sizeof(struct sadb_x_ipsecrequest)
(16 bytes) is allocated per entry. However, set_ipsecrequest() is
called multiple times in a loop (once for old_family, once for
new_family, for each migration bundle), repeatedly calling skb_put_zero()
with 16 bytes each time.

This causes the tail pointer to exceed the end pointer of the skb,
triggering skb_over_panic:
  tail: 0x188 (392 bytes)
  end:  0x180 (384 bytes)

Fix this by validating that pfkey_sockaddr_len() returns a non-zero
value before proceeding with buffer operations. This ensures proper
size calculations and prevents buffer overflow. Checking socklen
instead of just family==0 provides comprehensive validation for all
unsupported address families.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of
endpoint address(es)")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/key/af_key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..713344c594d4 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3526,6 +3526,10 @@ static int set_ipsecrequest(struct sk_buff *skb,
     int socklen = pfkey_sockaddr_len(family);
     int size_req;

+    /* Reject invalid/unsupported address families */
+    if (!socklen)
+        return -EINVAL;
+
     size_req = sizeof(struct sadb_x_ipsecrequest) +
            pfkey_sockaddr_pair_size(family);

-- 
2.34.1

