Return-Path: <netdev+bounces-294555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MzsHImTDH2pppgAAu9opvQ
	(envelope-from <netdev+bounces-294555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:02:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA36347AD
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:02:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b=AAs5EUH8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294555-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294555-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E4ED301996A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF973CE0B0;
	Wed,  3 Jun 2026 06:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A8B3BE64B;
	Wed,  3 Jun 2026 06:00:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466460; cv=none; b=PSreyMpFUPtxYhj2PjB9cwQb0vRddIDu+JZf/mwGJnKfAUDbSefOCZSsKp00Ev7MR6qxkxefd6/l1Zem/dHclZ2zDnPoSfZzNVuL6KXntQpoFp2+xvvwGnxHiyOnqcE+CJNJbpgFweyMe/xfbek2Hc96HId9swH7/CqCovBhg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466460; c=relaxed/simple;
	bh=qt/jpgqFH3E7YDS9zJIYVXJ5hW0CvZa9phmttO3Chdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOAeGnZ1Mmmgs0qL04eguuvsz4RFHJqyDm7Q5uSv192BA2PYq8ueHOu6odvJUXZqEAcgq4M+hQMtAmeU6tS5ApeJpqorjUePBX6WePe2tMfOqTB/T2jc6SMlTc2gVv/gWMvQiVp1mfmuNIVS0fmlfGZEdXWLznb+7yESwnR9L/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=AAs5EUH8; arc=none smtp.client-ip=207.46.229.174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=gE+SZ
	3fE+KZCdLXHIRIBscYYnAhhqEXe3lZmVUHwI4s=; b=AAs5EUH8ppzbj2S5DjgH0
	yCBJ4arG5IET3GXwTXRXVrUJULc9K5qutfvNxnHMLIx46lT942KqXOdkM473ya3J
	xJKU+kgWwuMzk+9EKiC77RtCAVqHPXUxpHIAsgxKj7XsvQ2vYnMVPHxm9ZVCDVyj
	vE3CQ28fqlCIsTVx14cBJ0=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web4 (Coremail) with SMTP id ywQGZQDX6Z71wh9q8vX+AQ--.6110S2;
	Wed, 03 Jun 2026 14:00:22 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH v2 net] net/802/mrp: fix vector attribute parsing in mrp_pdu_parse_vecattr
Date: Wed,  3 Jun 2026 14:00:13 +0800
Message-ID: <20260603060016.21522-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQDX6Z71wh9q8vX+AQ--.6110S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGryxXFyfZw4xZrWxWr4xXrb_yoW5Zr1fpF
	ZxCr90yFykGFy7u39ayws7W34fCws5JrZ3Wr1DK34093ZxG3WxKa40g3ZFyr1ay39YkF1Y
	vw42qw1UKayDZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjgdbUUU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQEHAWofuXIaRgAAsk
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294555-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:zhaoyz24@mails.tsinghua.edu.cn,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,seu.edu.cn:email,tsinghua.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53BA36347AD

In mrp_pdu_parse_vecattr(), vector attribute events are encoded three
per byte and valen tracks the number of events left to process.

The parser decrements valen after processing the first and second events
from each event byte, but not after processing the third one. When valen
is exactly a multiple of three, the loop continues after the last valid
event and consumes the next byte as a new event byte, applying a
spurious event to the MRP applicant state.

Additionally, when valen is zero the parser unconditionally consumes
attrlen bytes as FirstValue and advances the offset, even though per
IEEE 802.1ak a VectorAttribute with only a LeaveAllEvent has valen of
zero and no FirstValue or Vector fields. This corrupts the offset for
subsequent PDU parsing.

Also, when valen exceeds three the loop crosses byte boundaries but
the attribute value is not incremented between the last event of one
byte and the first event of the next. This causes the first event of
the next byte to use the same attribute value as the third event
rather than the next consecutive value.

Decrement valen after processing the third event, skip FirstValue
consumption when valen is zero, and increment the attribute value at
the end of each loop iteration.

Fixes: febf018d2234 ("net/802: Implement Multiple Registration Protocol (MRP)")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
Changes in v2:
- Add early return when valen is 0 to skip FirstValue consumption,
  addressing the offset corruption noted by Simon Horman
- Add mrp_attrvalue_inc() at the end of each loop iteration to
  correctly advance the attribute value across byte boundaries,
  also noted by Simon Horman
- Link to v1: https://lore.kernel.org/netdev/20260527084624.43057-1-zhaoyz24@mails.tsinghua.edu.cn/
---
diff --git a/net/802/mrp.c b/net/802/mrp.c
index ff0e80574..160a3b145 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -703,6 +703,12 @@ static int mrp_pdu_parse_vecattr(struct mrp_applicant *app,
 	valen = be16_to_cpu(get_unaligned(&mrp_cb(skb)->vah->lenflags) &
 			    MRP_VECATTR_HDR_LEN_MASK);

+	/* If valen is 0, only a LeaveAllEvent is present; FirstValue and
+	 * Vector fields are absent per IEEE 802.1ak.
+	 */
+	if (valen == 0)
+		return 0;
+
 	/* The VectorAttribute structure in a PDU carries event information
 	 * about one or more attributes having consecutive values. Only the
 	 * value for the first attribute is contained in the structure. So
@@ -753,6 +759,9 @@ static int mrp_pdu_parse_vecattr(struct mrp_applicant *app,
 		vaevents %= __MRP_VECATTR_EVENT_MAX;
 		vaevent = vaevents;
 		mrp_pdu_parse_vecattr_event(app, skb, vaevent);
+		valen--;
+		mrp_attrvalue_inc(mrp_cb(skb)->attrvalue,
+				  mrp_cb(skb)->mh->attrlen);
 	}
 	return 0;
 }


--
2.43.0


