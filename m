Return-Path: <netdev+bounces-295360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id va+oEzmxIWpxLQEAu9opvQ
	(envelope-from <netdev+bounces-295360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:09:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E830642324
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:09:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=l3azZzTf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295360-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295360-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B13DF301DE02
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BCE2F7F08;
	Thu,  4 Jun 2026 16:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8422FA0C6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:59:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592378; cv=none; b=tKtBzMUWHWzEkEHrnnBOZ6G7Ykg5iYcplSppONJXB5NE67RN1O6yHSMogB8Vx6J2nxQZvp3OXk024K3RWPUwVYG3Wfd9VofsdURjXngKDxuOl2CF2pSdsfaTke834Ib15Vf3eQndHaAhTXSZroitYe6z0THIgazQrS3e4N4MJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592378; c=relaxed/simple;
	bh=yUtTpJHdzEWbgTjsiuCj893qdVCNtyL0l8/2vu8sS4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaGx83Tskw3KXuSy0WR40lDmacj8mHblH08kR6LsSj65MwQDa+dTHWZkGhgvonhQ0fZaEGJ+eKUPXGN1GF5+KEe92ZajEQKZHI+cwdzOn8Hx9ReqcXg0/Sbq7FqvPh3SsQfQj6qBW+aCbPR4UKWKrIbN/pxvNtvp8F2NYMxYa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3azZzTf; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso727827f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780592376; x=1781197176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pGoeEOr9RRtwxMbbZF4kryR7MSLvpeOOpDT4EcPNUk=;
        b=l3azZzTf4EZCVX985MITEzwnHVrxpYoDZ+7GeOT75J6Yl7pzlRp9z8FUksGklfxSfO
         FbyEgSyOH78cyvMnipX1G3pn16hEUjqzmp4K6lQ6+zxb4N3jp23zpFsE1dencmxyCm/V
         jlLMQ/efXxRDXqhKS3khhnx02Oe4IqWSOFe9Oh5sWnQ0lnY0oOUFaX7qShd4hd9Ua/8/
         /nACZ9JrUUSq5exUxtua1rkY09rzwdoVhnEyoKR46+KxmEM3CsSPfsH+U4oA8mttTjnf
         4eh8J+T6uf3wTdxC8XE5fCV/PjNLBrTuM1dobmKR8diC3jADYl0Ihh2aLSkYC4k9tt6r
         e/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780592376; x=1781197176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pGoeEOr9RRtwxMbbZF4kryR7MSLvpeOOpDT4EcPNUk=;
        b=MZqr8bCaAD0j7R13sNvp7fVjzk5/J5AtTQIWg1IcEGXPYInoVt0jW0LKaUt6fFzhIj
         4nN8nn/ptLNsOqxJI4T4aK7I8Y3GuWfdHFpLbkuMEjBoMeWLsTfrX0PO6CSlEMVfn2zL
         8jvmmbDISWru87ws5WrbjbVC5zEi68uQ61XUxE7BmpYN1R1nA4RIB/8jcKe1rw6hlmMv
         Vp+rcWkezLLlmdwbuDbplCfu2afT1LEtHCeYSZRQveN7R6dBnx3aM5p9syv4wiwJBz4a
         uzbDNZ9wltz1NnloGJOVKpOpGXQwRnzhXow0QSTmEfs/dDICjwKkh9GO6iGwFQLzxuZK
         sPew==
X-Gm-Message-State: AOJu0YxKAM/t4jjkGXD57HduC+nRmIiGyAnvwpbgQ7kxhgHcMItuU1Z6
	QB/mgF0O57yV3irz57YJb6RUzVxf43kgwndto8nahpauo3WRReSjG1oTct0A/JRE+gRxeg==
X-Gm-Gg: Acq92OFjURzFoPl88gk6msV0UiK9Ddm4ADcgvR4BdJbwzDkd2HbekcHMOR7fN95G0iJ
	Z1rKp3ZGFSdhJjcH61J7t2Olo2MDoQtzPwQPqKWuFQ0FaIFj+5itpX8DcUWk7NbfXmVEqrhIDXr
	Nv+CEQK+SRcCxmv2YLTa2306DaC3yKkajIFs918PM8KzfPxuv5BUDBjHf9Dn4zo3OvWrp2yn20N
	sKYdKbDty1s0tK3U0CI/SmmLQ1fP+ib3iAWnTh0BMrpxaRxTGQkYr6Ws6o57QMdWDjVNBAGmLiH
	b1rdkrADD7xf2cLxUM9EqDyCCOeOHl1Zsc5yS08YMSuwkksUJIlfFY9OSV15Bx6m+G6vdi/vOrO
	ckjOQcgRESuUp4RtxSDQuN0IViSoRAH1jVnT9TaIGnb6qAvJo1+V1fNHNkyZW+2Za5/7LXsiSTs
	aidXRSEOH09ZcW4OWpHw4t/f+arUC6Ro/+7gjra+9jVnJXcvwWk26pmdEqgRmy18YiBlk=
X-Received: by 2002:adf:ef0a:0:b0:43d:7c1b:b8c7 with SMTP id ffacd0b85a97d-4602183267cmr11729522f8f.21.1780592375658;
        Thu, 04 Jun 2026 09:59:35 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm17376308f8f.21.2026.06.04.09.59.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 09:59:35 -0700 (PDT)
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
Subject: [PATCH net v3] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Thu,  4 Jun 2026 19:59:38 +0300
Message-ID: <20260604165938.32033-1-leontyevantony@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-295360-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E830642324

netvsc_copy_to_send_buf() copies page buffer entries into the VMBus
send buffer using phys_to_virt() on the entry PFN. Entries for the
RNDIS header and the skb linear data come from kmalloc'd memory and
are always in the kernel direct map, but entries for skb fragments
reference page cache or user pages, which on 32-bit x86 with
CONFIG_HIGHMEM=y can live above the LOWMEM boundary. For such a page
phys_to_virt() returns an address outside the direct map and the
subsequent memcpy() faults on the transmit softirq path, which is
fatal.

Map the pages with kmap_local_page() instead, handling two properties
of the page buffer entries:

 - pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity,
   not a native PFN. Reconstruct the physical address first and derive
   the native page from it, so the mapping stays correct where
   PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g. arm64 with 64K pages).

 - Since commit 41a6328b2c55 ("hv_netvsc: Preserve contiguous PFN
   grouping in the page buffer array"), an entry describes a full
   physically contiguous fragment and pb[i].len can exceed PAGE_SIZE,
   while kmap_local_page() maps a single page. Copy page by page,
   splitting at native page boundaries.

The copy path only handles packets smaller than the send section size
(6144 bytes by default); larger packets take the cp_partial path where
only the RNDIS header is copied. So entries here are bounded by the
section size and a copy is split at most once on 4K-page systems. On
!CONFIG_HIGHMEM configs kmap_local_page() folds to page_address() and
no mapping work is added.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
v3:
 - Copy page by page: since 41a6328b2c55 a pb entry describes a full
   contiguous fragment and pb[i].len can exceed PAGE_SIZE, while
   kmap_local_page() maps a single page. Split copies at native page
   boundaries.
v2:
 - Derive the native page and in-page offset from the physical
   address instead of passing the Hyper-V 4K PFN to pfn_to_page(),
   correct where PAGE_SIZE > 4K (e.g. arm64 64K pages).

I do not have a 32-bit HIGHMEM Hyper-V setup to exercise this path;
testing help from the Hyper-V folks would be much appreciated.
 drivers/net/hyperv/netvsc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..4d319c50955e 100644
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
@@ -965,12 +966,22 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = (pb[i].pfn << HV_HYP_PAGE_SHIFT) +
+				    pb[i].offset;
 		u32 len = pb[i].len;
 
-		memcpy(dest, (src + offset), len);
-		dest += len;
+		while (len) {
+			struct page *page = phys_to_page(paddr);
+			u32 off = offset_in_page(paddr);
+			u32 chunk = min_t(u32, len, PAGE_SIZE - off);
+			char *src = kmap_local_page(page);
+
+			memcpy(dest, src + off, chunk);
+			kunmap_local(src);
+			dest += chunk;
+			paddr += chunk;
+			len -= chunk;
+		}
 	}
 
 	if (padding)
-- 
2.43.0


