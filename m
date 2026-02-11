Return-Path: <netdev+bounces-258298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLJ6JTmdjGmPrgAAu9opvQ
	(envelope-from <netdev+bounces-258298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:16:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EAF125889
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB30F3064660
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80BF2D5C68;
	Wed, 11 Feb 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MidDK7rT"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF772D061D;
	Wed, 11 Feb 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822806; cv=none; b=BQVv+4E17DLQ9qYEgkXBYjLa9TtSe+h5LC/BmFTy3tWiExSbYG0Ss6CsQnloKht45ANxRIK4cUY93wjgk3w14zTK28wd0Yyjr2Q35js2vS2BD1vQB1xm3LB9rXNfCgqAy8ZHF9Cm8OLb2CV9nnFDZD5DqGsxPdbfShdu4BsZYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822806; c=relaxed/simple;
	bh=BDt70VS0gj39ZE/mzTwLE1Inrng5CJZFq1et97efOT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fzL6Ip1CEYHYGm+kSB4+3DjdZxsWiLrMpECtpvLCrgKaS7XXa6mzz/6O1kBbvgUmdV43tK6bCKMzT90OzywbM8nCs/lTQslUGsI8xLgvIcAOQIwGzMXKPj9T0PDqFzfH2GvutiN+EmHkD87/q++GbQIcTpqA6o8UuEoBAiUQVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MidDK7rT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=u5FSJJSbZqmk4MvjnrE7nlyprOC+aW9hoQNy9WAvwng=; b=MidDK7rTgp14lyq8Q0IjGwdINI
	CpuJ6ic0KCqULXNzyIY3rFdoi/9A03UyPZ2UkKTUwEEt4AAZdrFems/RYduEgEWigJ9+0KZu2Doat
	aJxBkNsc+MDfZT6ISfgD2kRgUaDLOzCsNDfGiSsrGRqCh0kZGO9Ez79uhcOOvg1/Bm41NpGG9168C
	On2XKrdLEGWJ0pAmdaELmyMT1ysg1INqeNWkDz0KXSpptoIG2DJqqXVFn8+aLVtlOSrsqa34TxQTg
	o7egdX2BqJfka/h/eqaJ9LvqB6EPEbOMq9oAEn+I1aLq+FTDaVbSk/Go/i5+4CPoWiy72fczFj6gS
	7EjGWC6Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vqBu4-00B7Re-Ms; Wed, 11 Feb 2026 15:13:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Feb 2026 07:13:03 -0800
Subject: [PATCH] iommu/dma: Rate-limit WARN in iommu_dma_unmap_phys()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-dma_io_mmu-v1-1-cf89e24437af@debian.org>
X-B4-Tracking: v=1; b=H4sIAH+cjGkC/yXMTQqDMBAG0KsM39qAk9iquYoU8WdqpxCVpJaCe
 Hdpu3ybtyNJVEnwtCPKW5MuMzxxRhge3TyJ0RGeYHN7zS2zGUPX6tKGsJkL133p6qpiVyAjrFH
 u+vllze3vtPVPGV7fAcdxAmaaJ59uAAAA
X-Change-ID: 20260211-dma_io_mmu-519b73988134
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 ttoukan.linux@gmail.com, netdev@vger.kernel.org, kbusch@kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; i=leitao@debian.org;
 h=from:subject:message-id; bh=BDt70VS0gj39ZE/mzTwLE1Inrng5CJZFq1et97efOT0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpjJyMwMucrgj50E/0kcvc/1AJxnwFwoYu/h5Eq
 4lXg1Cl8X+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYycjAAKCRA1o5Of/Hh3
 bd19D/4hDJnTw/fQYRbZnT627yXhU80lxul3ZB90ALN2r6/yOVrm/kuM9CwyAtphg/lUK8a5NiF
 JXGSO9eKHwkS7JzQhY92AkramHvrmS75vdrCMDGKoHJpFxnwjEFLt8t5UbE/UFsHIpvvTUSOYuT
 28Sun095fLEf3X5e3oT7H7q79yVxux9ywRazp3vnPPZEDYD3wB4pZbfLJOG37E59aB7vjK6JOZ+
 CQv+TiugkeKCD06uinkvRuUuJq4F4DciLn/5oty49SbcwbFDHhLk1ZCFmfwCPSBZ78nSo9ibo9x
 ru+HW6TMwKRp7oIAFVbhsgsCUIX2F7g+K2Hptff+purStLNQdwsoL+2tHNDazG8UUdd+gJZhVHq
 BvdRp5Plcp31E52PmInpiXRfI8HldZnSlTkQ6LrlZh5vzL7fAboQJclEygXNk6StpEpxfl4YM2d
 1a5oPrGVhjmFPVlTsfcqaPMz7uJjd57yjr2tDmYHLPeyKfsDyT/92O3LIVnhqGCcDSkhWR/+8gy
 T+yzDigd7P6znTpZMT/Kg13i44rOU4QyO/lVwJpquwXi8U3cD7oDB3Jz/fg6lA5zq0tJrtxHvBe
 pJFFs6YG6Kn6k2J/A/S6pIqJloGVZezhJcdv7wNnYOWyax/pVmINViM8/unCmzEJkRgOISqOpOR
 u6j2VEAiSXkoTgQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258298-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,kernel.org,debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12EAF125889
X-Rspamd-Action: no action

When a PCI error (e.g. AER error or DPC containment) marks the PCI
channel as frozen or permanently failed, the IOMMU mappings for the
device may already be torn down. If a driver continues processing
completions in this state, every call to dma_unmap_page() triggers a
WARN_ON in iommu_dma_unmap_phys().

In a real-world crash scenario on an NVIDIA Grace (ARM64) platform, a
DPC event froze the PCI channel and the mlx5 NAPI poll continued
processing error CQEs, calling dma_unmap for each pending WQE. With
dozens of pending WQEs, the resulting WARN_ON storm monopolized the CPU
in softirq context for over 23 seconds, triggering a soft lockup panic.

Replace WARN_ON(!phys) with WARN_RATELIMIT() to cap the warning output
at the kernel's default rate limit (10 messages per 5 seconds), while
still providing visibility into the failure with the device name in the
message.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
---
I initially attempted to fix this in the driver itself, but that approach
doesn't appear to be optimal, given the mappings can go away at any
time, which is impossible to check at any time. Please see the discussion at:

https://lore.kernel.org/all/20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org/
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c92088855450a..3cb5948eafe86 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1239,7 +1239,8 @@ void iommu_dma_unmap_phys(struct device *dev, dma_addr_t dma_handle,
 	}
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	if (WARN_ON(!phys))
+	if (WARN_RATELIMIT(!phys, "iova_to_phys translation failed for dev %s\n",
+			   dev_name(dev)))
 		return;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))

---
base-commit: f884ff9142ee4b741a88030d77feede84f51fd4f
change-id: 20260211-dma_io_mmu-519b73988134

Best regards,
--  
Breno Leitao <leitao@debian.org>


