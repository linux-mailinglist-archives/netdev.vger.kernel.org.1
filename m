Return-Path: <netdev+bounces-167489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5FA3A7CF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95C23B309E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1781E8345;
	Tue, 18 Feb 2025 19:41:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6D1E833E;
	Tue, 18 Feb 2025 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907661; cv=none; b=GHlNIS2zIhI+jt4oI2b3EEOapP3B6IHfe7K0TCgpSuVqOc8fAHHUZeENjS9RdIWngykC0rpAzcgiseL6VF2BOFCSVRvW34cI4X1bGEGpnyoygPyIWXcbr+1fht0mF5M+EhivD2FrAtOq+K8uvNGqqw95cuZwVVs4UeOkP9jlz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907661; c=relaxed/simple;
	bh=N6QhGimnjyJ9i/C0YwoLfKJQ5BUqKUjKSjmb33KO6jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kj2poE8uMQJDx3s/8IRq+e2lX5gUbJ3RIGaSFmWDEdT78D3ve0b0qY14ppqEPjv6Vw85pBlfzFx67tFDt2FgVGjRYNvwqWr447UaUJn0iRjrbxOM8XwtmsteVZwBf9C43cm87/NdA6q8vHHOP6A329K4TxNu7BNzTv9vn+DlHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2210d92292eso89590845ad.1;
        Tue, 18 Feb 2025 11:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907658; x=1740512458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dedq4ViV78aMkujB/wC8+wjwO96fqDArfjEd2ZEUF4w=;
        b=RRPyy76mkkh/XHJOFszJbYk1fF1jW6TyLz5XN0MWI0AHR7e+7KGMtdrOMw4fN/9LAr
         qbdXUHwtYr4i+tEJDxGdYGtvjYeUzApZFmIlT/Fm5VfmOleDvahqyJQKPgMSIk8AOW8U
         4w9V9/BsspQeHE1si5R49JhegyuOZRz0gu5a9FrVeesMPX23xCs0Hl4Qk2bUdszH9WaD
         2N+qAEp8I45UVALvLJCY3mue9ldf527tLPJAXJO/kZDymDiUkmKaIVTQz8qiTl3rv1sf
         Ubgz0cQODvJXRlgc8mttx30tMlMDihVtMz3JJfbg0yZaDU55kZdMcvMh5k0QfjzNy0H4
         mxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgz38cfbYcQet1huBccHo53kyD3vNIC6/VWMgHYHib8SSIqhiuQC814R9hcP80GQYmflqh7ErZ0SdRvs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyasg3SqXG6eFEcjjWGFd4NONFwiAfTdDEVzXQYH+5PVa+omW8n
	H3tgRIukiz/Mp4m58Ng8Jx+bjMMf0Vmgr2zYOWD5F+/cdz3IHHBN0E8p
X-Gm-Gg: ASbGnct1pAdrqB+vgh1m+Lq9BExUEW+H7SAooGviN+YAMcWSBN6xeFhz1ED3onmMUkT
	KRgbK3bW6DsA2ikUWH+eiWbLbmGHUat6OfOZ04BteKdObJ3nzxzSl33Hecc2ofxD9BJ6GcAv/Ok
	kIPk0rlCvoH2sl3w1uOGxJCkkMtxY24XwTwfGbOHhctE34+EB7tCcxNIcEfhAEvKyScGBuNkPRT
	CILvW+QsLAo3MZhNsAEtpDUXGlvIzGB8D3SXMtlmX2zpk3Jl+L3BEH5CIrez2Mjs127YKvcVSgu
	9KKaI5dvYNfIgAM=
X-Google-Smtp-Source: AGHT+IFzfWdnlrhx/CyuZxeiYFZnYK35mh2vPM2oa23XHLeubVs4FrXtZa7laXH4lMIYxZjQgocrMg==
X-Received: by 2002:a17:903:244a:b0:215:431f:268f with SMTP id d9443c01a7336-2217055ea65mr13665665ad.10.1739907658228;
        Tue, 18 Feb 2025 11:40:58 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5367e8csm93069495ad.67.2025.02.18.11.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:40:57 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	kuniyu@amazon.com,
	dsahern@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	willemb@google.com,
	kaiyuanz@google.com
Subject: [PATCH net] tcp: devmem: properly export MSG_CTRUNC to userspace
Date: Tue, 18 Feb 2025 11:40:56 -0800
Message-ID: <20250218194056.380647-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we report -ETOOSMALL (err) only on the first iteration
(!sent). When we get put_cmsg error after a bunch of successful
put_cmsg calls, we don't signal the error at all. This might be
confusing on the userspace side which will see truncated CMSGs
but no MSG_CTRUNC signal.

Consider the following case:
- sizeof(struct cmsghdr) = 16
- sizeof(struct dmabuf_cmsg) = 24
- total cmsg size (CMSG_LEN) = 40 (16+24)

When calling recvmsg with msg_controllen=60, the userspace
will receive two(!) dmabuf_cmsg(s), the first one will
be a valid one and the second one will be silently truncated. There is no
easy way to discover the truncation besides doing something like
"cm->cmsg_len != CMSG_LEN(sizeof(dmabuf_cmsg))". Do not mask MSG_CTRUNC
to keep conventional cmsg-truncated signals in place.

If there is a concern with breaking UAPI, I can document this case in
devmem.rst instead.

Fixes: 8f0b3cc9a4c1 ("tcp: RX path for devmem TCP")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/ipv4/tcp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..bdc9ac648d83 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2441,7 +2441,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
 				       sizeof(dmabuf_cmsg), &dmabuf_cmsg);
 			if (err || msg->msg_flags & MSG_CTRUNC) {
-				msg->msg_flags &= ~MSG_CTRUNC;
 				if (!err)
 					err = -ETOOSMALL;
 				goto out;
@@ -2504,7 +2503,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 					       sizeof(dmabuf_cmsg),
 					       &dmabuf_cmsg);
 				if (err || msg->msg_flags & MSG_CTRUNC) {
-					msg->msg_flags &= ~MSG_CTRUNC;
 					if (!err)
 						err = -ETOOSMALL;
 					goto out;
-- 
2.48.1


