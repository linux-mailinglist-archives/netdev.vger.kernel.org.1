Return-Path: <netdev+bounces-294856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ty4QC6tlIGq72gAAu9opvQ
	(envelope-from <netdev+bounces-294856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:34:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2317B63A2FD
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:34:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=asVgDDIE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294856-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294856-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BC5D3010725
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607344D693;
	Wed,  3 Jun 2026 17:25:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32913E5ED7
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:25:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507543; cv=none; b=GZS13Y49h79kZ3Jix0j1hBLqTW97AxLzEZbOAd/FuGDJVlyomTWkFUJnJIQfIm/Oe/zdZ71Nizkl6dcz2JHLrfj0k/ysWWE29f1tI9SS9UAodq2V5xNrkD4aeISf/kymrHZs6WJlwdsS9YfgtaQBLJSjt5tx/9nuFBNCs6Bvx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507543; c=relaxed/simple;
	bh=K/YVSy3Jio3EDLqXiV7+CBIoj59O3grDjIPmiQ+k2Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+vJpnvfptuaC6Iy+NuiUnfDRoq4x4POrOoIKH4TciFyVhBgOmVSgZfl9NLNSwJGPb9psueUW+lkE8J+jtS1bYM0RtbDK6nh+8lg+uUQ/7wY9Bcqa44XsYISqqWr/9xOw2pEFbDy5ok5Aq8AyW4Gognqh9zwlaXlg5Nge9findM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asVgDDIE; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso4911161f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780507540; x=1781112340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=asVgDDIEl/hUus8pyxQZJv54iYTduyujs1d8MjDzV4ySec94yjEROB7Xu2yukq+iYG
         FhsyScXHft/XuY4mw/OxxYdhFcO02RJojJi6wi8dpRn5bAx7wFSCbm0zOGsvMBh+RPlG
         nVpPcCdmMw7Au1hnRXiux6fquozCE/+MxxHGL5c94zmLvq3Ja22mNOn7n4Lpo7AGUZzB
         g7OB1vcibCoVqS97d+TO58mcsujD46ExP5pyq1M9ZqRHxW1PP0c8FU5nTZfGWkOvICh1
         CzjqAPQMMrD+aLLCmyyVlI08xp4ofePza/iiDlw3z3fPKjBZrAf9LAJDJz713a/DOCKC
         5cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780507540; x=1781112340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=YbBkVWgNfKBJRfKlIgXrcL40NFw2bhDmXur3nR2GYPrnxthGx0QXQpD6syFnCGhwlp
         mHFbnNfa8knEgrt0PUAbSQ2yKcQQRadxuRhYFluoI9OZMa3nEYimloeAVMf5FBBrhBDq
         AOhjWfZI7I3pX2j/jWsA5nsPUEqnqYwPVFL+6Afyq0GqnDSWfroaRz4QlTlBUYhwPErx
         zLhVQz0pAbyTRO7lOloDkIH73ktUF7GVBhHRLjDizwmBD2Q7er9ts8scFAIbHje6FhTJ
         3EE1eXKUkS/GGbxtPRUUeUVRVx9iueo5KC0SbYXXuJKbn92Ezd/FHcRSzsUBUTtxAfG0
         yT0A==
X-Gm-Message-State: AOJu0Yxzbt18/64M2xWFfFXQRh1Mbx18Jvc8KS3K1FJq4jXYM/8Njj5I
	MuFOd6E8SUqQvpOhzuGav/Zy5SXhgqfmhZfe5SwYBcfh4icApbmOstEu0bsWHnwhJF/ifQ==
X-Gm-Gg: Acq92OEWCUTUUXvKQG3gKKfssD0f7ZJD6T+GdlGA/hzyc21GVixmXifotYtQFHC42RF
	ipQbXwNadAT5OzRI3B6JbRM6ZpUlbWOpfKdk9oMkkwXSrd0PE029ZJrqcaHh0tCGi0DLNiwkGYr
	q1T+rXQAhFc9L6pcKaxuhuW8JZzJZC+9H0z8iOe3GAwL15+ow6rqwew2EQxgfsRMkkN98fj1o1u
	axbngr5g0LlIo8SmmMEQYkE9goOtUBfCGUJZge0PwTm5DZIoNDP1xKnSov59XdAPOrTE67KDPQK
	AnmdTBpjcujP0HqLzRVBTCBa7WEZn5zy4gs0ixgM4th5eS7thta6qUkuy+sout35k/wTiuus0Br
	ZiC+w3Ck11vdoCn1VzS1mOsNQMEU4HptqoUtohFrJ9UUs3R+4q0cb1v2WTWaRaQqK4kZwKhf9Ab
	NNdcohTBrOm6t4hicQNQ8wSAoucW/eQwzkeQdBG7h5Kjd3laDNBMSOx9KGf6UhcA==
X-Received: by 2002:adf:f8ca:0:b0:45e:ea46:ce13 with SMTP id ffacd0b85a97d-460217a5a76mr4654078f8f.10.1780507540027;
        Wed, 03 Jun 2026 10:25:40 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm9071573f8f.26.2026.06.03.10.25.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 10:25:39 -0700 (PDT)
From: Anton Leontev <leontyevantony@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Leontev <leontyevantony@gmail.com>
Subject: [PATCH net v2] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Wed,  3 Jun 2026 20:25:43 +0300
Message-ID: <20260603172543.19230-1-leontyevantony@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-294856-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leontyevantony@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[leontyevantony@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leontyevantony@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2317B63A2FD

netvsc_copy_to_send_buf() copies skb fragment pages into the shared
VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
x86 with CONFIG_HIGHMEM=y, phys_to_virt() (i.e. __va()) is only valid
for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
address that has no kernel page table entry and lies outside the
kernel direct map, so the subsequent memcpy() faults. As this happens
on the transmit softirq path, the fault is fatal.

A HIGHMEM fragment reaches this path whenever the page backing an skb
fragment lives above the LOWMEM boundary, which is common on a 32-bit
guest with several GiB of RAM (for example when the in-kernel NFS
server splices page cache pages directly into the reply skb).

pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity. The
physical address is reconstructed first and phys_to_page() is used to
obtain the native struct page, with offset_in_page() added so the
in-page offset stays correct where PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g.
arm64 with 64K pages). The page is then mapped on demand with
kmap_local_page()/kunmap_local(). On !CONFIG_HIGHMEM configs
kmap_local_page() reduces to page_address(), so this is a no-op there.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
v2:
 - Reconstruct the physical address from the Hyper-V PFN and use
   phys_to_page() + offset_in_page() instead of pfn_to_page() on the
   raw PFN, correct where PAGE_SIZE > 4K (e.g. arm64 64K pages).
   Reported by Haiyang Zhang.
 - Built for i386 (CONFIG_HIGHMEM) and arm64 (64K pages).
 drivers/net/hyperv/netvsc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..2038d9f5c9f9 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -965,11 +966,14 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = pb[i].pfn << HV_HYP_PAGE_SHIFT;
+		struct page *page = phys_to_page(paddr);
+		u32 offset = offset_in_page(paddr) + pb[i].offset;
 		u32 len = pb[i].len;
+		char *src = kmap_local_page(page);
 
 		memcpy(dest, (src + offset), len);
+		kunmap_local(src);
 		dest += len;
 	}
 
-- 
2.43.0


