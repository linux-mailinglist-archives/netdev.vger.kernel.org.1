Return-Path: <netdev+bounces-300829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EJltCZy4NmpWDwcAu9opvQ
	(envelope-from <netdev+bounces-300829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:58:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B60F6A92DC
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:58:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b="j6dgkj m";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300829-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300829-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 963373009FBA
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1B37BE96;
	Sat, 20 Jun 2026 15:56:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E68E39A4A4;
	Sat, 20 Jun 2026 15:56:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970976; cv=none; b=l3779hv5pEYQDGNaQVaMPbrEI02HZoHMUS0o9HAzX+VZTILpIWeYElks+YgU9rur0h1FkQvyVVuxaeJM/sYx/BMh9uh6+cNIv1ntK7a3KSDe4ojSPUcyDRZjxPAva9i5CRXdhhwxVm2hFGxqzd6AF/9Z30qq5RrXe2mD6d6I2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970976; c=relaxed/simple;
	bh=mREn7aMvhQtSFuMpN5QJnDkICANt9vZVAK6NJo0cBdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p6YoeesWzNE7CAW+IlSUNZEczHhqsFI6FhKchY2vGWPtJ16j/afQkCTseMz4RTTih/bwJD10dFZBBp3+E49XmnhtK+BQrYCR7pfFDF2tUsP0hWBZxVakmjRChb41DjvEolzwOXxC657qGkXioZTGcNM0NvLLLxireBs3tPo0MKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=j6dgkjmW; arc=none smtp.client-ip=209.97.182.222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	To:Cc; bh=NChoqlksllFYffaZiR5WyUkVWdR1IVof5odJETtw+70=; b=j6dgkj
	mWMAnWAnWzURKCPhnQPWwzaFnQJqp7mrmHVHB1Pq3Ftb8Le1RMrMYIHrP9tISKES
	qS1WGJwZOWRzTTDor4Tq8y5dXcFAhqqwKvcDRWvC2yCzUIcoG0F/tFZDK33/20V4
	rik1m3COkbSrEg8YRKgeQtAfTvpL0ZCA5i8g0=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQAX8JcHuDZqT9ptAg--.25215S2;
	Sat, 20 Jun 2026 23:55:51 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 20 Jun 2026 23:55:51 +0800
Subject: [PATCH net] seg6: validate SRH length before reading fixed fields
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-f01-17-seg6-srh-len-v1-1-36cbb29c12f1@mails.tsinghua.edu.cn>
X-B4-Tracking: v=1; b=H4sIAAa4NmoC/yWMzQ6CMBAGX4Xs2U3aKgV9FeOBn6+wxFTTRUJCe
 HerHGeSmY0USaB0KzZKWETlFTPYU0Hd2MQBLH1mcsZ54+2Vg7FsK1YMnjWN/ETkpi7Duby4Cqa
 lXL4Tgqz/650iZnocUj/thG7+/Wjfv8dnB/98AAAA
X-Change-ID: 20260619-f01-17-seg6-srh-len-a85f35427e0b
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781970953; l=1611;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=mREn7aMvhQtSFuMpN5QJnDkICANt9vZVAK6NJo0cBdk=;
 b=QF7me+lqK7ri0//msrqYpBtXqOFI2RKAHhoGaT4z46WecpCPPzY5tumOHil9gW//BWc+BSgpX
 nnLPFgzTMWmC+zncx18RwDCQNt1v9RmuLnkDbO8lqX3VEGD3rzlV/ff
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQAX8JcHuDZqT9ptAg--.25215S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7ZryrJFy7JryxWF47XFb_yoW8WF1UpF
	yrKw1xtFyUGrWIkF1Iya18t34Y9398WFy8XrnYvas2krn0qw1ktF48Kw1YgFZ0yrW0grsa
	kay8tFZxZFyDZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU8EAp5UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIEA2o1wTCydAAGsq
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrea.mayer@uniroma2.it,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gnq25@mails.tsinghua.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[gnq25@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300829-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnq25@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mails.tsinghua.edu.cn:dkim,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:from_mime,tsinghua.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B60F6A92DC

seg6_validate_srh() reads fixed SRH fields such as srh->type and
srh->hdrlen before checking that the supplied length covers the fixed
struct ipv6_sr_hdr fields.  Callers that pass a length smaller than
sizeof(struct ipv6_sr_hdr) therefore expose those reads to memory
outside the validated range.

The BPF SEG6 encap path (bpf_lwt_push_encap() -> bpf_push_seg6_encap())
is one such caller: it forwards a BPF program-supplied pointer and
length straight to seg6_validate_srh() with no minimum-size guard, so a
2-byte SEG6 encap header lets the validator read srh->type at offset 2
beyond the caller-supplied buffer.

Reject lengths shorter than the fixed SRH at the top of
seg6_validate_srh(), before any field is read.  This fixes the BPF helper
path and hardens the common validator for any other caller that reaches it
with a too-short SRH.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 net/ipv6/seg6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 1c3ad25700c4c..d2cb32a1058af 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -29,6 +29,9 @@ bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len, bool reduced)
 	int max_last_entry;
 	int trailing;
 
+	if (len < (int)sizeof(*srh))
+		return false;
+
 	if (srh->type != IPV6_SRCRT_TYPE_4)
 		return false;
 

---
base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
change-id: 20260619-f01-17-seg6-srh-len-a85f35427e0b

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>


