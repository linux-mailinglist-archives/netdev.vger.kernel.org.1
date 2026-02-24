Return-Path: <netdev+bounces-260341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMamOUI5nWl1NgQAu9opvQ
	(envelope-from <netdev+bounces-260341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:38:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED1A1821CD
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43AA307B210
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B437279DC2;
	Tue, 24 Feb 2026 05:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F50287257;
	Tue, 24 Feb 2026 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911364; cv=none; b=k1yKPrDSoY6/lBAH9dyIdTvQDgp1pzUatE5EBBB1i3L8foLO+u3BFm/aHtkAb3bpUeUYD4WqAFLLe6segwGunSMBC99qeEYQd4+keQByS8gfIYzp64Mg+Tf1J878hgCZ2Hbofi+PgoLJZUS9J7KfuR+r9F/bzxKepkVMp3mEhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911364; c=relaxed/simple;
	bh=/YTey1WQjiYss9/V+PrecoRrskVEEVXWgcRO2xscE7k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FVN/intbvLt4W2CiYDLMHnYf/D43rJbHg8WDHp6D0psjv3KfnfUv0BqfS//mWlVl3RWZ9kR9ngGFB7gKqv6kdUXM2YgNZUEhtWKoIf9lQpDIq9w7m2I4XaEgtqXI13OT3iwcz4FhS1YjOxBnHjq+c01W5+8Gzz/VBhru7nIibrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-ae-699d38bcc761
From: Byungchul Park <byungchul@sk.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	david@redhat.com,
	willy@infradead.org,
	toke@redhat.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Subject: [RESEND PATCH] ice: access @pp through netmem_desc instead of page
Date: Tue, 24 Feb 2026 14:35:46 +0900
Message-Id: <20260224053546.62757-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsXC9ZZnke5ei7mZBqfWclus/lFhsfzBDlaL
	3Rd+MFnMWbWN0WLO+RYWi6/rfzFbPD32iN3i/rJnLBb/b/1mtbiwrY/V4vKuOWwWxxaIWXw7
	/YbR4vbSq0wWlw4/YrH4/WMOm4OAx5aVN5k8ds66y+6xYFOpx+YVWh6L97xk8ti0qpPN42Rz
	qcfOHZ+ZPD4+vcXi8X7fVTaPz5vkArijuGxSUnMyy1KL9O0SuDLWdi5lLHjAXtF5bS9TA+Nh
	ti5GTg4JAROJpw0fmWDsja2TweJsAuoSN278ZAaxRQR0JbZ2TWHtYuTiYBZoZpa4cOEiC0hC
	WMBbonvmM7AiFgFVie7T28CaeQVMJV5dfcEKMVReYvWGA8wgzRICR9gklt5YBbVZUuLgihss
	Exi5FzAyrGIUyswry03MzDHRy6jMy6zQS87P3cQIDNZltX+idzB+uhB8iFGAg1GJhzchdk6m
	EGtiWXFl7iFGCQ5mJRHe379nZQrxpiRWVqUW5ccXleakFh9ilOZgURLnNfpWniIkkJ5Ykpqd
	mlqQWgSTZeLglGpgjNq76oP9ny0SwdFz3zzZWdW7arJ5+GPl47vi+6sNrmU8/nLUpN/s4tPl
	hjGCX+9GXv88U/rWmTmcXq5fLwlXzGC+uubqWq2w4IcPnHsZDJ0nN++JDf/ssMJzZcl3iznF
	GzyfNnP6VWxg7V2/PuqcafzhiZazb5kdY7oiLLLjZUcls1r5uWvPmJVYijMSDbWYi4oTAQoY
	ztZSAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsXC5WfdrLvHYm6mwcFzxharf1RYLH+wg9Vi
	94UfTBZzVm1jtJhzvoXF4uv6X8wWT489Yre4v+wZi8X/W79ZLQ7PPclqcWFbH6vF5V1z2CyO
	LRCz+Hb6DaPF7aVXmSwuHX7EYvH7xxw2B0GPLStvMnnsnHWX3WPBplKPzSu0PBbvecnksWlV
	J5vHyeZSj507PjN5fHx6i8Xj/b6rbB6LX3xg8vi8SS6AJ4rLJiU1J7MstUjfLoErY23nUsaC
	B+wVndf2MjUwHmbrYuTkkBAwkdjYOhnMZhNQl7hx4ycziC0ioCuxtWsKaxcjFwezQDOzxIUL
	F1lAEsIC3hLdM5+BFbEIqEp0n94G1swrYCrx6uoLVoih8hKrNxxgnsDIsYCRYRWjSGZeWW5i
	Zo6pXnF2RmVeZoVecn7uJkZg6C2r/TNxB+OXy+6HGAU4GJV4eBNi52QKsSaWFVfmHmKU4GBW
	EuH9/XtWphBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAPj
	+csT58yUmLo19+aZHRubi6obJQ6c29VjZCN6y92S6U3bvgs26geTJ8218mv3bvJp+7Wx6ax2
	1dM3l/6Hm7/429um+FWRcc7ymiM/tjsbPbmjKlit+WKh3cbXR+6cmP/m9dW4FUuLDp6bYTE1
	XdOreIrTaa5Fl74V/SwVcugMiL15U8RLeFEalxJLcUaioRZzUXEiAB4e0qw5AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260341-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[sk.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,redhat.com,infradead.org,gmail.com,google.com,intel.com,lunn.ch,davemloft.net,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sk.com:mid,sk.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ED1A1821CD
X-Rspamd-Action: no action

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make ice driver access @pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c6bc29cfb8e6..c16e54dbe75b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
 		rx_buf = &rx_ring->rx_fqes[i];
 		page = __netmem_to_page(rx_buf->netmem);
 		received_buf = page_address(page) + rx_buf->offset +
-			       page->pp->p.offset;
+			       pp_page_to_nmdesc(page)->pp->p.offset;
 
 		if (ice_lbtest_check_frame(received_buf))
 			valid_frames++;
-- 
2.17.1


