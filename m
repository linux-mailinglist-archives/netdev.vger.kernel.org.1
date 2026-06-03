Return-Path: <netdev+bounces-294504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nO65HCGFH2ocmwAAu9opvQ
	(envelope-from <netdev+bounces-294504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 03:36:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF118633784
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 03:36:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294504-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294504-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27FE130610B0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46BA35E1BE;
	Wed,  3 Jun 2026 01:30:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D135DA4F;
	Wed,  3 Jun 2026 01:30:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450231; cv=none; b=NYX8i4UZjKys2RK0xU7wP+tKSjWL5D31KJE51sH1BN9vVjIbLlnDNeYCS8aIkvKpNbdRPbF+aPA925UjpoWqrddloKlg+/MjKZ5Se3b9nLcbkfEQnT+HZ7qOZGximQJfCj65aK7g480jtC9vZO7YQbESeYEg+WyJfvrJ3GRe+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450231; c=relaxed/simple;
	bh=gcXgt81jVg+t71PXjrujpm/6IA3UwCOkGUgQ+gOoPeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gflueHUzGhuTK1EzbPP1RAl/1k7D4NbZWBAixyQKQmL5LaHvWkEuX2nh+g1K2quPDcnrM53gse73I5UaPuIueGwFXi96zz4X7q0oRrGkT8SP5E6JAcGtikFnW1xLa1WbpLXsby1dPkkfMhFq/dUEypza05RnxCno60ilT6Zkvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from fric.. (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAAXvtafgx9qzq97AA--.10147S2;
	Wed, 03 Jun 2026 09:30:07 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	ernestas.k@iconn-networks.com,
	horms@kernel.org,
	kees@kernel.org,
	kuniyu@google.com,
	leitao@debian.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	xujiakai24@mails.ucas.ac.cn
Subject: Re: [PATCH v2] llc: Fix race between sock_orphan() and timer callback in llc_sk_free()
Date: Wed,  3 Jun 2026 01:30:07 +0000
Message-Id: <20260603013007.1171695-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602133002.3ed70fc3@kernel.org>
References: <20260602133002.3ed70fc3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXvtafgx9qzq97AA--.10147S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw18Jw1rGF1xCw4kJFyrJFb_yoWfXFb_ur
	Wjga97Gry8Jan8Z3W2kr4FqFsxWw4jg34jv3yUJasrKryxtFZ7WFZF934S9FyrAay7W3y3
	twn5A342q34SqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbh8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr
	0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUrb18DUUUU
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ucas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:ernestas.k@iconn-networks.com,m:horms@kernel.org,m:kees@kernel.org,m:kuniyu@google.com,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:xujiakai24@mails.ucas.ac.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xujiakai24@mails.ucas.ac.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294504-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xujiakai24@mails.ucas.ac.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF118633784

Thank you very much for your review and feedback. I really appreciate 
you taking the time to look at this.

> Sashiko points out that there's more issues if the timer runs after
> llc_ui_release(). Can you reliably reproduce this? Have you checked
> that this change is sufficient? Sashiko says that llc->dev may
> disappear even tho we don't clear that pointer in _release().

This crash was discovered by fuzzing. Unfortunately, the fuzzer did 
not generate a reproducer program, so I am unable to reproduce it. 
Our analysis has been based entirely on the crash report.

I'm not an expert in this area, so the quality of my patches may be 
low. I really appreciate your patience and the time you've taken to 
review this. Would this V3 approach (moving both sock_orphan() and 
netdev_put() into llc_sk_free() after the timer stop) be the correct 
way to proceed?

Regards,
Jiakai


