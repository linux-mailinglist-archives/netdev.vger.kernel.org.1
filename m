Return-Path: <netdev+bounces-280791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFrKI/NB6mm1xQIAu9opvQ
	(envelope-from <netdev+bounces-280791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:59:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AF45499A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E826300DE3C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8F3374190;
	Thu, 23 Apr 2026 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsnih13R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97794370D6E
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776959912; cv=none; b=oN8Kgkehsevnzci7T71APtua86fTYLLKByAdXaFwphH866nipR2LCUY6ZDq7I7u+5bF9WG3RN52S+rVxb82KkIPY9SybF6zROX5EmLKaFCCEVhWukuwx4xF3IVkKDV0ZyLKGhnAJEiKvtB2p+aOmb5eaOlc/fzQkudwT9WG09zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776959912; c=relaxed/simple;
	bh=AR1tyKWtZeVWgHbhDNYPsmlXWN6qh8CcT0QwnDPOjPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvYDG9+m7f6qKvAwsHjwixRpIQ9h4ibTbspbTxATQ6hnDAUKoIaqunNqwyvg6PP8Nbtj5skK8ggpVwLC/XlbKHLm8153Wt+u+PB2uqWyWUUEAkEp3NGoPLe6VW4pLNM56Ro8Y0X0EndJeCdrSbc6LDXmVP0Q5cuuAkQOCH1HJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qsnih13R; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c8c9c4cd8so2359165c88.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776959910; x=1777564710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lw0eJ0HrBtMu/NfaNFWlMNPqLWJs3EMGa99HbAzS2UY=;
        b=Qsnih13RTYuif+n7XrE3Jslgh/QElLXemxDoJNesFb96kT9AylGiiHX0xD5JnlNsL/
         9bSD6pH6nvaXkTKsvPQWDbjRtWi6xWpvWj/w1YbyE35r6rizeuFPOO9Z8Dwn1K1V58TC
         nmoukm9yhFrSQiVEK9XmHxe/B+mK79N6TVkL+H+d+dz4L2XuHfiuph+SgjAqtoJitYmI
         JvF/nVeMURj8RE9QXpJ7HvjogC+ZYVSd96Ln/r9wHy7S66tL9l54JD+j8CKUyRyrMVSf
         257IScf276DBNFDDQwzRdI+AUXvAAnn49Viw3rvImBj3Psdo4+hscmIaWMoqBDh2/Lff
         7LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776959910; x=1777564710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw0eJ0HrBtMu/NfaNFWlMNPqLWJs3EMGa99HbAzS2UY=;
        b=Yd+ySzf1BTGs1gbdWlt3MViBpsSl9IS28JQa8Q8kjZDx4Vcp/9Yh1ht7svGkkq6bxm
         x/JKmftJJ7xZASzoaImtLmwMFMATH8uGLy+f38drpkLdi6A6Sh2Kf4YY14zmbEJzqreL
         9ddiP4/cYd+WEcL1S6fuNLgnZnLtEKkm4Oa9NlH5FpQw4ikUoR5svddg8YzT6hWQNwuh
         JEBkKGzDk6bTkjmz9lePHRqDuozphicLaAQVeJdNy+H5/5FeG62T5n8YSVRNqRyMKVRu
         Li9Yuajr3IZxFy+qNJP2IY/mv4IqNe9MUCQK6yv88o9RwKrH8ZVk800WOQV3xJ/+E1KG
         XMrA==
X-Forwarded-Encrypted: i=1; AFNElJ+F5viiTby53A1cn7cUluI/SlryFA29P9/RVS6ZIK0cnCtMdQrF2FdMn3lCo360v9MJtYMDDQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxee/GUmwmVpoBCUkdgGEPHaLOScDacEKOXruBqJFiRN6Xo0KM+
	ixQYwDCfSWELwT2mk6sAdEyR5YYGSFs2Ks0UoTyDFW7psPJ1zyykhXxm
X-Gm-Gg: AeBDies1IfuuFslug9JNpimm8q1HyxJrQO6zUG50Funskz7Pb0UTz8fC6TELZ4oHqim
	BCwzn0t8T6++aZkixZcQsGBDwRqj+FZ7xAEmiAfEnS8DupDcWsQxpk5ZoetBMsGYtzOjBD4SMKq
	wegtw2YQwGKa6Kv5qEOE+rjbL7a5zz4aknxu1ip6emvnQn49tNmSgRL/UqUDEjDBRsbjAQ0VpWZ
	ncvIsAAL5OJwP7XsKswAiS2IhBAqu8AHSh7hqlv55clY5U9vLx712/vwSY0moXdpcbPs54t4udQ
	iJQbDdVTxTjKwom+QR4dZe6ACZGXXDgmN8qRikw8oibcyN1inN+gTVbTej6qp0Pk5DWRLB86gx+
	mu4nfOvmWAumMvSjYOec/P/e4amSdm0wWWE4VIjkArt9jYAZHBA3XTneCar9FUq0VXGuLEqP1jz
	41lSGD1Gd3qEnHUsPdV5Xq6EidKc62huVS3fQqesp7TqD9XjBotM/Fv/SQjutfb1iKk2UD90iwM
	AmLBJH2j0U0DY8RIMA1Qch/XLom7zk=
X-Received: by 2002:a05:7022:b8d:b0:119:e569:f86d with SMTP id a92af1059eb24-12c73b26cc5mr12096979c88.10.1776959909284;
        Thu, 23 Apr 2026 08:58:29 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm35656689c88.14.2026.04.23.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:58:28 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
Date: Thu, 23 Apr 2026 08:58:08 -0700
Message-ID: <20260423155807.1245644-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org,asu.edu];
	TAGGED_FROM(0.00)[bounces-280791-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.603];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: ED8AF45499A
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

When bpf_msg_push_data() splits a scatterlist element into head and
tail, the tail's page offset is advanced by `start` (absolute message
byte offset) instead of `start - offset` (byte position within the
element). This makes rsge.offset overshoot by `offset` bytes, pointing
to the wrong location within the page or beyond its boundary. Consumers
of the corrupted entry either silently read wrong data or trigger an
out-of-bounds access.

 BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:2728)
 Read of size 32752 at addr ffff8881042f0010 by task poc/130
 Call Trace:
  __asan_memcpy (mm/kasan/shadow.c:105)
  bpf_msg_pull_data (net/core/filter.c:2728)
  bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
  sk_psock_msg_verdict (net/core/skmsg.c:934)
  tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
  sock_sendmsg_nosec (net/socket.c:727)

Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3e56b567bd18..f12fbc49bc03 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2865,7 +2865,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,

 		psge->length = start - offset;
 		rsge.length -= psge->length;
-		rsge.offset += start;
+		rsge.offset += start - offset;

 		sk_msg_iter_var_next(i);
 		sg_unmark_end(psge);
--
2.43.0

