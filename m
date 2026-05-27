Return-Path: <netdev+bounces-292199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO3SLaawFmokogcAu9opvQ
	(envelope-from <netdev+bounces-292199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:51:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134E25E1576
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD94B304D728
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EA23E2ACA;
	Wed, 27 May 2026 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="SxlWblVq"
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD16E3E2AC1;
	Wed, 27 May 2026 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871617; cv=none; b=rf4WfXfNLTNmV19DS+AeniGl0Ysd3R5li1PMKAkmJUdhReFuj6QTGwkbLU/B4VfAFPHHaZymp34ON7GYeWgG9eczjivAGrehFlAkNn8l6BtiCKTFW+WXnf0jl/C9QJ1MS9BfljPHYCOWjxOD3cHrBtj+VDlXCR1Uj8Z1OY2jDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871617; c=relaxed/simple;
	bh=x0TjYIL/s1gpuGH9FLqzgMf7FxOghlekalySof5ot7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgNgn584CtXZRACE3y6ifCzNeALkLTKBwKKuO68WUHn0GjzpZGIRHjaysr0UdHbgJC9VJaYq327kuBfa4XbKFQg9LDWqcp5tedVQ4w5Wqv2Zj9BnWH11LZN9s7pO4kdT3Ki6C5MQArsC/djUx+IKlUemxXp/pAutB8gk3QZEsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=SxlWblVq; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=LzJE3
	O4Qs1Ym9XnI/hVKMeO2kL/geGUsSlJQprhHVG8=; b=SxlWblVqHLKdPpmLRmpDg
	plbXcaJZcw1W3Z5kLA37KVS41iJ5HOPHfgeOWGWeg0mk1rP4Hhl12mDImmIZunha
	LDshu1rybPace4G8t88+CKmYPU9zzLVgMxEeiJ99Im4cZY21LNYSsup2iNGB7UCm
	+ptKyUQVrrOUxy6Y6NFeWA=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web4 (Coremail) with SMTP id ywQGZQDH2J1qrxZq0WnMAQ--.63780S2;
	Wed, 27 May 2026 16:46:34 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S . Miller" <davem@davemloft.net>,
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
Subject: [PATCH net] net/802/mrp: fix vector attribute event count handling
Date: Wed, 27 May 2026 16:46:22 +0800
Message-ID: <20260527084624.43057-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQDH2J1qrxZq0WnMAQ--.63780S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr45ZFyxGFyrAF18Ar1xAFb_yoW8Ww4DpF
	W3CFyayF97Gry2va9ayrsrWr4rGrWkJrZ7Jr1Fyry0vwn8J3WxWF10gFZ2vryavrZYkF1a
	vw4jqayUK398XrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbasjUUU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQMAAWoWnq0mawAAsB
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292199-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tsinghua.edu.cn:email,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:dkim,seu.edu.cn:email]
X-Rspamd-Queue-Id: 134E25E1576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mrp_pdu_parse_vecattr(), vector attribute events are encoded three
per byte and valen tracks the number of events left to process.

The parser decrements valen after processing the first and second events
from each event byte, but not after processing the third one. When valen
is exactly a multiple of three, the loop continues after the last valid
event and consumes the next byte as a new event byte.

This can make the parser apply a spurious event to the current vector
attribute and update the MRP applicant state with an event that was not
part of the VectorAttribute. For example, a VectorAttribute with valen=3
and events JOIN_IN, JOIN_IN, LV can be followed by another byte whose
first encoded event is then incorrectly applied to the third attribute.

Decrement valen after processing the third event as well.

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
diff --git a/net/802/mrp.c b/net/802/mrp.c
index ff0e805..40cb941 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -753,6 +753,7 @@ static int mrp_pdu_parse_vecattr(struct mrp_applicant *app,
 		vaevents %= __MRP_VECATTR_EVENT_MAX;
 		vaevent = vaevents;
 		mrp_pdu_parse_vecattr_event(app, skb, vaevent);
+		valen--;
 	}
 	return 0;
 }


--
2.43.0


