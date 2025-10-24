Return-Path: <netdev+bounces-232502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF63C0613F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B3B3A536E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812730C363;
	Fri, 24 Oct 2025 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb6Y9IxP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4F309F13
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306270; cv=none; b=k2jg6OtTj7eISiNXEeQIeQGQ3JA7iDhk/1vybb2P8kKFMo7JFd9i3xTymnAAOBelVuzIVtQI/QSCxEEpRXPXlj10heWKLpf6ucF3FA7F3PQWXmzUHd+yGGtxL25kCUonKshWlR4ccdt6wzCUNaF6SZ+RJaGdPn8g9IwzQx29GkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306270; c=relaxed/simple;
	bh=Ej80jl2uiwzW7Q0agNgjGQwqhc8eFg6CYRfWKq5oG7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gHMmk0Wl+FwKGYG66tHcTKzeSAbzeZOAgPWd+DGihmGxosyqAal5M3aYoAdU4AaI07/qJ1C8uLWQUGPqXMHqJJ8oYh8Hkf6QA3VseCj6tQHJ6dCVAYM5v/OMXB7wJDRcreHqABhzCqa7YWZA95L7hQxJ8BgVUTVz6LWkDY+Z8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb6Y9IxP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33fc9550f68so207917a91.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 04:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761306268; x=1761911068; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zacr6gvmQ9vDqaS1O97ygNGkrRkfIl6K5RuWNpVBtP0=;
        b=bb6Y9IxPGuigaIbtVaYVwewQT4+j6B/dHufdTT/LSGtyCwkK4n5Rp7JV4Y8wkaVeeF
         B45fW4JHWOUPwSZk7uTq6GBk8mjM/FwYHes7+5JfrIAF9F+fNFzXIxoReLNykeeE95WN
         3bxPfcDT87n66jQEr5ZWavXn4if2RlQsW8rNs7di2SWv2tyydeizu9wKLo0y9hQ+Ov7N
         wm42Ll0k8d4SdrFpLJJeDQMypiWzCCtVKMrwOcQrM/rnp4iy/7IVI0rNINbAW3ZLrWLO
         Jnm+hgjdTqMjBkFAAJCg7HVObFzpJoYCOb2JL0bOhYOD4tRznX8NxDJ7lVvWppqfXgnM
         8faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761306268; x=1761911068;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zacr6gvmQ9vDqaS1O97ygNGkrRkfIl6K5RuWNpVBtP0=;
        b=OR5k9UfUSVw2tTqvgvajvtpIv3YKe4Q62AmTN6nChbp4Fu2RDCfkugIlX1m7Py2yM1
         /i5tpyf1m/3/HTmvNvzMYnHCgboGaAbWwbdaMpXJqdknwByTMNpNM4V7O7GEk1LvG6F/
         j2dOLyUO4NSA/fLDAY/GY8417riaptTK1HUENXJBqPy1RPd4mQy90cQgk1it09nYmyat
         IucMol7I0WZsR4HXnTdr3rTGW3P/7UJFEOEH7KwHxVQZaGDOzGmN8M8gBffWk4hUmA89
         SwsQQqWqoMDu6U3KGYIXRqj6MlswVvfVEtT5WHMU1vr/2Gwj6VSJ+NJWC+7YnlJiHzXU
         AAWw==
X-Forwarded-Encrypted: i=1; AJvYcCW9bpjiBpLVvoGt12+Y7HsBdzoiik7HUMKCS0lj6qsjlE3growXRl8KXhTtpd+oqGyMjvMoAck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrt+fQcht+L99wP2Jgq6lXL1cTe6+vhIu90qMR+KBciQSh/jhn
	SoyXMBF+txSr5eYiU0ASNpp3bEGyuJ1Yrn35xNOHPLWKy10+dZX4+Zm7
X-Gm-Gg: ASbGncuDyWOPZOjfE2qFQV/RvzBe50zZVJbjrC9Kf8XxcthtiaPrZAMGIRS+gP+2G3q
	VKByc7E7/3gJKbBWL4SyEfpknvipifq6/H4+sRyK1Kf40j//OEcQW8Q4MNq7E/bbcR4lNAAPn3/
	NSOk8DTA70YEw4bBCFp+3gG8wmV/gQ1/KVTNnceCuhFjGXRoJp+1dEpSV2IDyaX+k1/5Rzb/y9h
	d2FFiuxQSEwU1M5RdF2dDL5rz5aazKpr/PgqHjGVBAa/3FtPdOn2t/1LJn09X2iE0f30jF0oY+0
	z+8vmenzAgNt6CZJOt+FCYfVU40XEQMB6ykBVMyIdQrf1KvtsTGjNTQXpE9qFGbSgEWMOdxFSf6
	82Bs3p8xwAzYz2MfpRIdAe9RfHNGaUJxfKGea5PXCGDtp7eUchnji+s62nf9+AXq0bORjh4PTaK
	u6nChaJiDGiYu+Nf1cNalTjW23028oZGpgHb0l+43jeA==
X-Google-Smtp-Source: AGHT+IFOG4zJwYCvCSoVrrWzwKKmIiySYPYWgc4iF6gWM6N9sou9RGKgAl7ua7MJsfPaFXhK4sGlmw==
X-Received: by 2002:a17:90b:1c8f:b0:335:2eee:19d7 with SMTP id 98e67ed59e1d1-33dfabaa9bfmr10185450a91.5.1761306268465;
        Fri, 24 Oct 2025 04:44:28 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:c912:9303:ec55:988d:afdd:e21a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7cfsm8817027a91.11.2025.10.24.04.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:44:27 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Fri, 24 Oct 2025 17:14:17 +0530
Subject: [PATCH v2] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJBm+2gC/22MSw7CIBQAr9K8tRjAVKgr72Gahp/tiwIGDKlpu
 LvYtcuZTGaD7BK6DJdug+QKZoyhAT90YBYVZkfQNgZOec8oP5GHzypMd1yJkLbnQg/DmWpo/Su
 5pvfXbWy8YH7H9NnXhf3sv0thhBFLpWHSaimFuM5e4fNoooex1voFaMxkOqIAAAA=
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761306262; l=1755;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=Ej80jl2uiwzW7Q0agNgjGQwqhc8eFg6CYRfWKq5oG7k=;
 b=uxw4Ot7rDxrniMfFmTEyfL8btyNNpnas0ivgGVzCMdJ/z0NJGeUtYduGENI6w4tyVhUmZK3HX
 bOta6h5thJGC3Q6Xrkl4/8kYe8Qaf0YEQJy+isSl/NAlMgk+RgOd5dI
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
Fixes: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
KMSAN reported an uninitialized-value access in sctp_inq_pop
---
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


