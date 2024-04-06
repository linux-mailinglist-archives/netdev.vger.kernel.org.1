Return-Path: <netdev+bounces-85381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692789A848
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 03:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB1A2824D7
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 01:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E7FD29E;
	Sat,  6 Apr 2024 01:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkmwZ0zd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1679111CAF
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712368147; cv=none; b=p2M+2n0OKYIWSn9RUNoBeb8k08QTECQXIrVnoBeiP/yU+9g52vjc6RW87689k9z9hsbmJWN0uU5g1X9e6mhukWhvjkuYnNnwOfgRr/I5KhJAj4e3KF+1QtunCiV8xRiVRsSvfxxQv6qMcixob4SGJS8mW1SJJ7AoOshNVtHC/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712368147; c=relaxed/simple;
	bh=l825sw8ynG4lR2su7izmRLMTBPsxEofiIOdnzLywsnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F1S3IhpPDIvm/agwd6xcpVal6GBGCVynAwXsXoEuQ54PL3xB4flYklehQiwNr9/lS8vgDRujBLpuYclqYvWZs4QNotGc75mj8eDlHpk/50xwUescLDaz2h17WfVs/DbdSLhU7fHmxXRGLfQGmo3IgUrrIKbmXY5+s7H+ELL578Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkmwZ0zd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e2bfac15c2so18292235ad.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 18:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712368145; x=1712972945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHpmksB/cpcKRYpeYHWK9D8wSWzvbKo+X+QX5tAxBEU=;
        b=XkmwZ0zdqt8Jvb7uT+NvjFGkZV6knukqMP6y2FcTqRwXW5Kl68F56/MXtwmYEPPOKB
         tm1R05zzVMuCDSf+k3e5a1LiiG6jjooIQo6ESBPemCPM1sj/JcVBVU7NQ3EF1A2K1YOb
         ISEMOYrvR4aAvV0gUHphTknhnAYtJ46We7C9dBjUjj0YN0KV9x644IXNrMQ2uX9Pi6Ug
         gC9fwa+D318cOYs+06f4WIbuDOrdPL37hWJl7WA5hUXEtwBuy8uA+lEOeJJTDUiV6hci
         o+QnZ9VwHoxhV3izcXFxzzikGnk7kOvtkDPrLpYm3S/dufBU4rdKNJYcdJ/3t1m1Q7Xw
         30zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712368145; x=1712972945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHpmksB/cpcKRYpeYHWK9D8wSWzvbKo+X+QX5tAxBEU=;
        b=Z1jtCJ7JYbelyqOz/YZv/h37upkxSTSOuqcMFx3N3eSHjj6uivSYbbgZXyQMIF4hhZ
         0q1Qd9STn1PhJvjNoEh4BWpUZwGaWiX+WhIFzZfJRV1NmMG6wydf/WuU+1HVDGUtzn1L
         FTyVkSE7CAgci4qP9pmYNKjK6+zlzB3YpMvAs4B4ARdhxd36kxojEB06DmCr9D7hqm9b
         8MTeCHt6zEAPSu22za6GNWBNBEZNjv9MoR28viTWQVAY5UJpGKTDnX9xu86HhA6+lcVj
         vju5kLZj+n0MSfBx1BaHNxnXNUacGrBYH2q7pBve5pb4YhDMDL2Mwtp2PSCjJdMTvOVw
         LyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgwWc2Z0wyJoa5d4UBaIXfHLE3XulPFUhEiN0H+/Xh+VcpO2kFn2zyGPwdE2BqzjfSaDmWmQkMSUVWsW8r+Ng5SLVyAtcr
X-Gm-Message-State: AOJu0YxBacSwRdZrdFQOAQqiKST3E7mdUiRtWHoKKwK9U3nThKKF/0Oj
	dN9OXw4dP688Z1lfK5xFIV67LihNbu2ff0QzJlgDWrh8DHb7L/1Z
X-Google-Smtp-Source: AGHT+IEaKSQcXPmMfK9yeyGxm0hiJOl2DO/8v67vlGnpg38UtgcstdgBDRfHXT95j/2CAsF0dqq9HA==
X-Received: by 2002:a17:903:ca:b0:1de:f569:cf41 with SMTP id x10-20020a17090300ca00b001def569cf41mr2654923plc.26.1712368145277;
        Fri, 05 Apr 2024 18:49:05 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001e0b60e26f5sm2287139plg.62.2024.04.05.18.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:49:04 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] mptcp: add reset reason options in some places
Date: Sat,  6 Apr 2024 09:48:48 +0800
Message-Id: <20240406014848.71739-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The reason codes are handled in two ways nowadays (quoting Mat Martineau):
1. Sending in the MPTCP option on RST packets when there is no subflow
context available (these use subflow_add_reset_reason() and directly call
a TCP-level send_reset function)
2. The "normal" way via subflow->reset_reason. This will propagate to both
the outgoing reset packet and to a local path manager process via netlink
in mptcp_event_sub_closed()

RFC 8684 defines the skb reset reason behaviour which is not required
even though in some places:

    A host sends a TCP RST in order to close a subflow or reject
    an attempt to open a subflow (MP_JOIN). In order to let the
    receiving host know why a subflow is being closed or rejected,
    the TCP RST packet MAY include the MP_TCPRST option (Figure 15).
    The host MAY use this information to decide, for example, whether
    it tries to re-establish the subflow immediately, later, or never.

Since the commit dc87efdb1a5cd ("mptcp: add mptcp reset option support")
introduced this feature about three years ago, we can fully use it.
There remains some places where we could insert reason into skb as
we can see in this patch.

Many thanks to Mat and Paolo for help:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/5046e1867c65f39e07822beb0a19a22743b1064b.camel@redhat.com/
1. complete all the possible reset reasons in the subflow_check_req() (Paolo)
---
 net/mptcp/subflow.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1626dd20c68f..b7ce2ca1782c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -150,8 +150,10 @@ static int subflow_check_req(struct request_sock *req,
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
 	 */
-	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
+	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
+		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 		return -EINVAL;
+	}
 #endif
 
 	mptcp_get_options(skb, &mp_opt);
@@ -219,6 +221,7 @@ static int subflow_check_req(struct request_sock *req,
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
 			}
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
@@ -227,10 +230,12 @@ static int subflow_check_req(struct request_sock *req,
 		subflow_req_create_thmac(subflow_req);
 
 		if (unlikely(req->syncookie)) {
-			if (mptcp_can_accept_new_subflow(subflow_req->msk))
-				subflow_init_req_cookie_join_save(subflow_req, skb);
-			else
+			if (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
+			}
+
+			subflow_init_req_cookie_join_save(subflow_req, skb);
 		}
 
 		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
@@ -873,13 +878,18 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
+					subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 					goto dispose_child;
 				}
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
 			}
 
-			if (!mptcp_finish_join(child))
+			if (!mptcp_finish_join(child)) {
+				struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(child);
+
+				subflow_add_reset_reason(skb, subflow->reset_reason);
 				goto dispose_child;
+			}
 
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 			tcp_rsk(req)->drop_req = true;
-- 
2.37.3


