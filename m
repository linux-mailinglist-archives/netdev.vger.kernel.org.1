Return-Path: <netdev+bounces-284827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNgmJhA8+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:03:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 752134DAAC7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB1313045A90
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D73EF66F;
	Wed,  6 May 2026 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kP/2qPFj"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D074657FD;
	Wed,  6 May 2026 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072261; cv=none; b=TkWLL+l6W1ZWhRfP5WCm8OQlwRr18bbmMjEr9xYqtf6H7PuDZnqMeo7VjibI1wi/zl9u+BkW/uM1fJ4633IgORdnVVJ2LSu9Kulk7aa769pfRrbetnarPEE9N1xNmSdi666PFoab+5YFSMICcFqA1cv0XDAKyAe7lBXWEaNMvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072261; c=relaxed/simple;
	bh=5dPQLPM8bePoFuXo+KMMdUNyGhXMyhns/oXbNrLi3L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvmDxjxRM+rlGWrj/ua8UHYnH+WfjzlHXHJSQzVUFRPXyY0uzjuodR7ke3P9kXBOgdPB2vJiWTy5xEtBvp4T0rFK8HhaM4+QvbdIuEI7Ch3KVeLEl79axCpURpJHAWt7m0euqe3PIhCsUhqTNiGWOExdbLxOTVGrOTPRDzAdJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kP/2qPFj; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fd
	TXVm9S9X4vRIBnFq17gJB4n13kBeVsfjlElxdlkpw=; b=kP/2qPFjNKSA3k6Itz
	T67eU19jyWyARd8xtBTBYD82xhsOymC0dl4N3V5GxIZFQoY6NeI/sVI28q8qaysM
	K8YflLLlKLGJr2iP3oLhHKpdbVaXocKZr+GmM+enXXkJuMiZcNYzpJ+KxsqtlgJc
	HmlrRt5mQBRe/zs0dcZIV1ZmQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3_2l3OvtpM4PaDg--.47018S2;
	Wed, 06 May 2026 20:56:24 +0800 (CST)
From: albin_yang@163.com
To: alexjlzheng@gmail.com
Cc: alexjlzheng@tencent.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	shenyangyang4@huawei.com,
	Wei Yang <albinwyang@tencent.com>
Subject: Re: [PATCH] macsec: defer RX SA cleanup from RCU callback to workqueue
Date: Wed,  6 May 2026 20:56:15 +0800
Message-ID: <20260506125615.3078625-1-albin_yang@163.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260506100107.388184-1-alexjlzheng@tencent.com>
References: <20260506100107.388184-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_2l3OvtpM4PaDg--.47018S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU173vDUUUU
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/xtbCzhkGqGn7Onk-XQAA3K
X-Rspamd-Queue-Id: 752134DAAC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-284827-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[albin_yang@163.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, May 06, 2026 at 10:01:07AM +0800, alexjlzheng@tencent.com wrote:
> crypto_free_aead() can call vunmap() internally (e.g. via
> dma_free_attrs() in hardware crypto drivers like hisi_sec2), which
> must not be called from softirq context.
> 
> free_rxsa() is an RCU callback and therefore runs in softirq context,
> causing a kernel crash when the underlying AEAD implementation
> performs DMA unmapping during tfm destruction:
> 
> [...]

Looks good to me.

Reviewed-by: Wei Yang <albinwyang@tencent.com>


