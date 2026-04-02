Return-Path: <netdev+bounces-274370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J+hFhn6zWkdkAYAu9opvQ
	(envelope-from <netdev+bounces-274370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 07:09:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB081383DE2
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 07:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AF6F301DAF5
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 05:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCAB358369;
	Thu,  2 Apr 2026 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfirjlRf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D224186284
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106582; cv=none; b=eI9DDTVzmaQwQpxcGu4J4Xo9NqrmI5Jv+ZbJr2t9vs4tRBn0ojoTJOe+/gFIXHP0qgdErbFH8lKi5ULbd7lqWWg3TDZ+agykwG5S20JDDQBwvcKZpqghpeI5RZyJufcSl2ey6ISTH5JyvGyYf9nXh2eN3g1YLgQyc4mOBp6PsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106582; c=relaxed/simple;
	bh=x6EXvLd1wUC7SvCNDTvMHc1kTSqHTF4xEughUeks0d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVO8tHB0VICrHKwkNiL+DySqzwIWhEB/dMjNi/UhVZLC6N6SmWGdCHImz8tJFp+WlB0+ST8VANtd5Z9Gv0rnPgxkw/rvI7apZ8tmemR2lFfRJW0Mf6VqVFJrMYBSIhb8joVz8NV3D/RNL3SAOG99Dyph6OxcS3+MCMkPBPSCdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfirjlRf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b23fcf90b2so4112205ad.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 22:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775106581; x=1775711381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8puRGWeANdZKsMbyIk9XwB9F11o8slKWtfPbwiNQgs=;
        b=PfirjlRfUZH60fEIyygrq48fRE0EKnWvYu5PWSyqy3HtCrFBo7+z7/hRZHtIZIy/bf
         0njlegEDg9rO2ibsMo5d94L6fk2QvQzpEhexwuoYUPynjvYVjN857jhL1WVwMRFdcjBs
         pMWbDmU1rkuveVd6w4TtoNXzpp+5lppByvkWili3TUiQinEWvFeH/vP+zWmXgiIpvLvl
         tkemErttn/ZucHuYlSj1Iny50SY+riOiuDrE8stolSTlJfEzn5/8GrLJKC4a71Ro3M2N
         4eXXvaCK98a+iAVcCvtNYy4uqUiIxuXbwZ/884UZajOsMQI8JR5QSM3XyPU6DjvmhXAE
         HpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775106581; x=1775711381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8puRGWeANdZKsMbyIk9XwB9F11o8slKWtfPbwiNQgs=;
        b=TCUtenkAsj3Ec7d2aFH+Ic/6BdNEeMR0y3abF8coqALj3U+oL/W8VdbrM+FC5lnrhY
         2mQ6bXE0a2uLQd1UjSt1qsCCubBb7Re8SOXl+t7RgZiRkJyl9ETC2znkGzC397douGW5
         9+pY54ZlSKpJTBbJ/LiKPdtylqmbottHbLdmAIkzsk/f39AljxONtbAphxRxOSGaYiaT
         0BP12Ye1hCq9B+qPH7IXE5Ery7AxERS6tBK3ttf9WIiH3DxWm+evqzLy6xZUPftzT0p4
         sp0/H1sKUee75H5iPZ1kMvL9SMin+aLwBDlfiSd73OjznonDYjdG/p45a6RIYuLCKJd0
         1FXw==
X-Forwarded-Encrypted: i=1; AJvYcCWWRFAi/7JCOqAFgew3ABiMq3MBSQgesQGN0RdFSfJu/QiK5w5O1h3hTb81GPh+aCmgXHEkNgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUVT7I8iwZbynadaXZLhZ9buwWt+ZY942vRxOrJ4uaHiT/mzb
	bsoZRTf+TZGyU8wErxf/4DPVmmbKeXqlhrLkJAwZOBXZlYHbys8ktjUy
X-Gm-Gg: AeBDievQLAAclTV0v4k86xh4VxLrnL7LkrbOkOL5xHHMqU8O2Ju599ZU4PnjR0P5xAE
	y5zQVCX9Nwr9qQdZHtLvHTl0SXhAjMzyjfY4VB0ldgzws0XqXrHNTH7sSBy9OmiGl5bw6Q250qp
	jG8r2HB2mJFtGTwuonhNHBJoKAk80Z1b/eky1QLDv+nkCVKgnm2ynSmPwYrQ242LPBfxsgP+iP5
	ef4LlkLoge+k35PHEYT2RYFo3yIfaHJiSvn+Z+r33srv00kRKeX3vCi2s7ic43P1jTQbYoFUho8
	+7M+QyPyn8rjck+yAuUYLyv+hDeHNIStEjoFCHTNwDJH3QyLclDQylH9BLlhWQXgKPMhF5GTDmG
	d7S9gtuVH4Tta24pvpoz6eukc7kwNRN5McTtCeY+hSO+Ix1nXPAp/6WrOUU+kHwZ4S6G1oWfkJ9
	djzI4DfcXUNOHrmSfNbeS854g6DaZpwmIx51QQxH9o1J1GXk4YvNkkyT+rkgiWB3+KFXYwHobmv
	nAmsn8=
X-Received: by 2002:a17:903:b84:b0:2b2:4029:d781 with SMTP id d9443c01a7336-2b269ac7f68mr61839905ad.20.1775106580712;
        Wed, 01 Apr 2026 22:09:40 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:2c0b:3bf4:b5e1:33f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478b64csm15219615ad.30.2026.04.01.22.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:09:40 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: ast@kernel.org,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Subject: [PATCH] udp_bpf: fix use-after-free in udp_bpf_recvmsg()
Date: Thu,  2 Apr 2026 10:39:28 +0530
Message-ID: <20260402050928.32946-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bytedance.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-274370-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,davemloft.net,kernel.org,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,431f9a9e3f5227fbb904];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB081383DE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

udp_bpf_recvmsg() calls sk_msg_recvmsg() without holding lock_sock(),
unlike tcp_bpf_recvmsg() which properly acquires lock_sock() before
calling __sk_msg_recvmsg(). This allows concurrent tasks to race inside
sk_msg_recvmsg() on the same psock ingress queue, where one task can
free msg_rx via kfree_sk_msg() while another task is still reading it
via sk_msg_elem(), causing a slab-use-after-free.

Fix this by adding lock_sock()/release_sock() around the sk_msg_recvmsg()
path in udp_bpf_recvmsg(), consistent with tcp_bpf_recvmsg(). Also make
udp_msg_wait_data() release lock_sock() before sleeping and reacquire it
after waking, so it can be called with the socket lock held, consistent
with how tcp_msg_wait_data() uses sk_wait_event() which does the same
internally.

Note: syzbot testing shows a separate pre-existing warning:
  sk->sk_forward_alloc
  WARNING: net/ipv4/af_inet.c:162 inet_sock_destruct
This warning triggers from the idle CPU path (pv_native_safe_halt)
and is unrelated to this patch. It appears to be a pre-existing
memory accounting issue in the UDP sockmap path that requires
separate investigation.


Reported-by: syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=431f9a9e3f5227fbb904
Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/ipv4/udp_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 9f33b07b1481..f924b255cee6 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -50,7 +50,9 @@ static int udp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	ret = udp_msg_has_data(sk, psock);
 	if (!ret) {
+		release_sock(sk);
 		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+		lock_sock(sk);
 		ret = udp_msg_has_data(sk, psock);
 	}
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -79,6 +81,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out;
 	}
 
+	lock_sock(sk);
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	if (!copied) {
@@ -90,12 +93,14 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (data) {
 			if (psock_has_data(psock))
 				goto msg_bytes_ready;
+			release_sock(sk);
 			ret = sk_udp_recvmsg(sk, msg, len, flags);
 			goto out;
 		}
 		copied = -EAGAIN;
 	}
 	ret = copied;
+	release_sock(sk);
 out:
 	sk_psock_put(sk, psock);
 	return ret;
-- 
2.43.0


