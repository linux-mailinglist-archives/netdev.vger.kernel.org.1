Return-Path: <netdev+bounces-269028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKN8LZWuumlXagIAu9opvQ
	(envelope-from <netdev+bounces-269028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:54:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD72BC690
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE608316C4AE
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94583D905D;
	Wed, 18 Mar 2026 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioVsn8bu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF33D9DC8
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841735; cv=none; b=nBQT8Tt7Yhsoa92VuRXYrw0QOeUm8JAbBaCXf351pN36h6gNMJsDqRI2h5czIchGewYvrPU0v8hbQ6UwJYOvflgu7AbDow0afBhgzOLcAZTAlfqFxJPAOMJ2fnyCtRAdc71F3OChtTEVmoH56Nn0C/7g1K86rvqDKilP9XR9QZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841735; c=relaxed/simple;
	bh=L0ieDmT5GiinMFr7D+jmWSLHSiAB9d8xkoyNARMPWqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFhfRbYLb+YwAaQI4s/R8GjaxK0XiKXgmf6ecTPh8gvmqeFAlflQr5oXyKQexsCmOji/83jAGo8xeGpicyKMHMBzvXAnuQGoe7YZHZR+6GKTyufXRw23znurGM+57rTN8AwClThj0FZ1MQjLP3XCv0C92ds+bZsJTnaS8+iwlCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioVsn8bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A43C19421;
	Wed, 18 Mar 2026 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773841735;
	bh=L0ieDmT5GiinMFr7D+jmWSLHSiAB9d8xkoyNARMPWqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioVsn8buB7rZHHv8kELKML3bHiiPFX6M0RLCNu2AcK6DZyJ0/uPHjmoDJAGF/aZwc
	 ZPjzljOb5zGVYHcECuJ3BWZafgs1VjPurpHdILMFJKOp5C5/yIlRlwq7e15Yt/uHli
	 1bhWvoPPG/KNpL/Skw3o0/3l3S3xKDYJCRmoHBPFPcQc8eiRuAriWoh+w9kk6PPQMf
	 CMbQvErQQvcb0L9fPGtHa5mBH3Mwo3WgT0jC3W9GINcqR5NBLJqL9w8sg3iZBbjKVR
	 9UUwk/UfngHLTk6ySs/zpi4oyIiMOqsOc1LTptOeXrwWJ4ymWX6qs6W8bwynWucAQy
	 Q+wJ02wOIIWwA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	toke@toke.dk,
	sdf@fomichev.me,
	j.koeppeler@tu-berlin.de,
	mfreemon@cloudflare.com,
	carges@cloudflare.com
Subject: [RFC PATCH net-next 6/6] net_sched: codel: fix stale state for empty flows in fq_codel
Date: Wed, 18 Mar 2026 14:48:26 +0100
Message-ID: <20260318134826.1281205-7-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318134826.1281205-1-hawk@kernel.org>
References: <20260318134826.1281205-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269028-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email,tu-berlin.de:email]
X-Rspamd-Queue-Id: 3CBD72BC690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jonas Köppeler <j.koeppeler@tu-berlin.de>

When codel_dequeue() finds an empty queue, it resets vars->dropping
but does not reset vars->first_above_time.  The reference CoDel
algorithm (Nichols & Jacobson, ACM Queue 2012) resets both:

  dodeque_result codel_queue_t::dodeque(time_t now) {
      ...
      if (r.p == NULL) {
          first_above_time = 0;   // <-- Linux omits this
      }
      ...
  }

Note that codel_should_drop() does reset first_above_time when called
with a NULL skb, but codel_dequeue() returns early before ever calling
codel_should_drop() in the empty-queue case.  The post-drop code paths
do reach codel_should_drop(NULL) and correctly reset the timer, so a
dropped packet breaks the cycle -- but the next delivered packet
re-arms first_above_time and the cycle repeats.

For sparse flows such as ICMP ping (one packet every 200ms-1s), the
first packet arms first_above_time, the flow goes empty, and the
second packet arrives after the interval has elapsed and gets dropped.
The pattern repeats, producing sustained loss on flows that are not
actually congested.

Test: veth pair, fq_codel, BQL disabled, 30000 iptables rules in the
consumer namespace (NAPI-64 cycle ~14ms, well above fq_codel's 5ms
target), ping at 5 pps under UDP flood:

  Before fix:  26% ping packet loss
  After fix:    0% ping packet loss

Fix by resetting first_above_time to zero in the empty-queue path
of codel_dequeue(), matching the reference algorithm.

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Reported-by: Chris Arges <carges@cloudflare.com>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 include/net/codel_impl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
index 78a27ac73070..b2c359c6dd1b 100644
--- a/include/net/codel_impl.h
+++ b/include/net/codel_impl.h
@@ -158,6 +158,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 	bool drop;
 
 	if (!skb) {
+		vars->first_above_time = 0;
 		vars->dropping = false;
 		return skb;
 	}
-- 
2.43.0


