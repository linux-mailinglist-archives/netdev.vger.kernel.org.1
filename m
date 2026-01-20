Return-Path: <netdev+bounces-251536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOo0HKu+b2kOMQAAu9opvQ
	(envelope-from <netdev+bounces-251536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:43:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D428548C19
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECDD9A04D75
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C4233439F;
	Tue, 20 Jan 2026 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IT6R9Mdh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E0334694
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925869; cv=none; b=M28UuzLr7Xe+RPWaxCLEEd+THVrRTlEiKXDW4t3SUXvVToPOyel4hIHBqD3+s6vl1ChMSip4sbWkqmhAHK9cDkjrAelD0hvL1mrl1HtT9eMo6o/z6Kd/mvQ3xpYsR3kC2jYe2AknQGAr6L8pK9HHjXSy2t2QbvGxzfLgT97k1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925869; c=relaxed/simple;
	bh=A1bpwayInKC3xoS8sBW+Ss6JExuba7Y64eDC7kXzPR8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T/kKlHcZoGkKribWola2BPLyAsSRnSJDnpF0qYtJGSSAu1QNSbNR0/5V3c2q6epZtlg7xOlqzvZ6H+MbB5WtZ3gBRKJSkj2p9Qj0htHJN6lyFuXKpnNPc3VAgdZG2I67kDuXx6g7xF6NGyWruhWquM5oQ9Zb2TSrxyNxsmGqFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IT6R9Mdh; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c6b4058909so673131385a.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768925866; x=1769530666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SDtjAf8U5bgsUGsfPHUl8gtWnxZbtbccG6M9wC/879Q=;
        b=IT6R9MdhNt/f/ofN/LfOOcmmpZmiwaAARW4lxg4RkkPYjWVv4smrJWuPPY6p01iTC7
         NgfX9sW2qlBVxo9UADTMqqXde9O0gSmQqsw7F3d6AvN1msUd5qmJ1H3z7l6IGcpd9+h9
         X+jJu7xDTZy/rxhyCqUos53Jz0zRqKhhcPNbWVtkI9mUJGcPjcnCEiO08dkLOpuWXPAb
         xr4T5beTCR5YbxlBwyAB/4dfiQCpyrL7DJ1QNIA2lLNAYKZGNaIRcEAO+zqjgDcLhSKi
         nTREis08yNVf2JNtqOeXEAzXmQlffUAPHU3VcToIEqd4DfNEfp5aaP+NyGyNcaGZdg/3
         vx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925866; x=1769530666;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDtjAf8U5bgsUGsfPHUl8gtWnxZbtbccG6M9wC/879Q=;
        b=AfIL7o5tdz02bua6o7VSwBS/qvtfGSUVU8mYvFyqzaCnjbfPfw+fYhLrG82Me8+x8L
         rZlpivHq3ELlBVS8z10t48fc6N3KF7iV+/nnxJZ+Jf8DAH6CaeCXX1501bJHLyQEnZoa
         utPmSKHfHZAiIVIyFY43OgTqLkptmMplvQDHU1m8Kq3gkblLBdwlhX9IFIjyEwImmzRC
         h+qx1hPBly4hfF3LZGD5oHZE8ohDBm33MtdOHLYb//1v7BaHnNYEgWOIXr/IRJczk/kr
         CZD+mfbT95z4/r1xmBgOaGqm8I2zNNAkA1yvA71/y6vz2sNW1/OXtx2KriOw8eFtaCFS
         zm/A==
X-Forwarded-Encrypted: i=1; AJvYcCVTFV/GZJ95JHrJx37weixZUuhy4lri3tXYVc/FBGqFyk7w4R6oxqivQv8XI6bdIX/ifroU48s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwneD5kpVS3FS+bOBxaxQNQH1eqEpQTq75m1dfvqtYsl1n/Ok
	/goex1BwQqG5h7HufU2yCLHvZNc1ZXvsYn6E5nJp0Us5OJUJGDYodQXoc+dtI5StaaDeKavpInf
	6bdu/YlI4Ctf+bg==
X-Received: from qknwd25.prod.google.com ([2002:a05:620a:7299:b0:8c5:5b1b:d60c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a92:b0:8c5:391f:1db7 with SMTP id af79cd13be357-8c6a6789295mr2078264385a.64.1768925865734;
 Tue, 20 Jan 2026 08:17:45 -0800 (PST)
Date: Tue, 20 Jan 2026 16:17:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120161744.1893263-1-edumazet@google.com>
Subject: [PATCH net] bonding: provide a net pointer to __skb_flow_dissect()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+c46409299c70a221415e@syzkaller.appspotmail.com, 
	Matteo Croce <mcroce@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251536-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com,redhat.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,c46409299c70a221415e];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,fomichev.me:email,appspotmail.com:email]
X-Rspamd-Queue-Id: D428548C19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After 3cbf4ffba5ee ("net: plumb network namespace into __skb_flow_dissect")
we have to provide a net pointer to __skb_flow_dissect(),
either via skb->dev, skb->sk, or a user provided pointer.

In the following case, syzbot was able to cook a bare skb.

WARNING: net/core/flow_dissector.c:1131 at __skb_flow_dissect+0xb57/0x68b0 net/core/flow_dissector.c:1131, CPU#1: syz.2.1418/11053
Call Trace:
 <TASK>
  bond_flow_dissect drivers/net/bonding/bond_main.c:4093 [inline]
  __bond_xmit_hash+0x2d7/0xba0 drivers/net/bonding/bond_main.c:4157
  bond_xmit_hash_xdp drivers/net/bonding/bond_main.c:4208 [inline]
  bond_xdp_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5139 [inline]
  bond_xdp_get_xmit_slave+0x1fd/0x710 drivers/net/bonding/bond_main.c:5515
  xdp_master_redirect+0x13f/0x2c0 net/core/filter.c:4388
  bpf_prog_run_xdp include/net/xdp.h:700 [inline]
  bpf_test_run+0x6b2/0x7d0 net/bpf/test_run.c:421
  bpf_prog_test_run_xdp+0x795/0x10e0 net/bpf/test_run.c:1390
  bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
  __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6182
  __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94

Fixes: 58deb77cc52d ("bonding: balance ICMP echoes in layer3+4 mode")
Reported-by: syzbot+c46409299c70a221415e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/696faa23.050a0220.4cb9c.001f.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Matteo Croce <mcroce@redhat.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 0aca6c937297def91d5740dfd456800432b5e343..e7caf400a59cbd9680adea3d1b8ab7a22c78f7e6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4096,8 +4096,9 @@ static bool bond_flow_dissect(struct bonding *bond, struct sk_buff *skb, const v
 	case BOND_XMIT_POLICY_ENCAP23:
 	case BOND_XMIT_POLICY_ENCAP34:
 		memset(fk, 0, sizeof(*fk));
-		return __skb_flow_dissect(NULL, skb, &flow_keys_bonding,
-					  fk, data, l2_proto, nhoff, hlen, 0);
+		return __skb_flow_dissect(dev_net(bond->dev), skb,
+					  &flow_keys_bonding, fk, data,
+					  l2_proto, nhoff, hlen, 0);
 	default:
 		break;
 	}
-- 
2.52.0.457.g6b5491de43-goog


