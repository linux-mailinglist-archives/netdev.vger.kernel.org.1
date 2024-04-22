Return-Path: <netdev+bounces-90076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F49E8ACA7C
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10571C21096
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF113E405;
	Mon, 22 Apr 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="EsfFe/Sn"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445953814
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781293; cv=none; b=Y4iUDcpZBjmIOKXnj/oHF7Mfxn6aT53npk0hadw7VCyuUw9R4iMm7hemFtFQiby/bei9uvrgi4tJYP4Sp1DDKtplSqguZKapAssNMXoBxO92nSiDj+TACYFWSt76we3qSABiCiwDWWicjtBC5zezttJj79BuY5pfYBqzXc6RwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781293; c=relaxed/simple;
	bh=pg8C8mTdpAyzP7IhwHlSNoBi3pGZ42LmMJtTWiQoNV8=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=kuPFhRqn7xZtWOBb9xy/hHTOzYn5rPKDQ7aMbt45mxq1mqEl8TTAxgirYcIyDzKra3hnIZYfT6FqS9OmKS3+AsJ5IOIpyJcrUj139kjWcphYXG0tqipaaBRITqNPJBEwfLWKo3KhtSW7iE4RtsRbe6skVSrLggDsTUnL1vAdTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=EsfFe/Sn reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NoXqFYOZkWfDuv+eKJeXfbFFpbrGaUh/snnhSrRu+Yo=; b=E
	sfFe/SnxWG+erY1/jHD7Ji6hbalOd1DyID6T6bJ8Ni76bnci/YVs/zwZtYz0mr9B
	mAFtxs2N/0uWUAAxAgpYTlEre4RHBAhiF1mVUsQ3jpy26UflgFL2ZT6KkrsydYQL
	5IFJgUv/jkI/5O7qvbRMPaCgAmhqGO94sUhLpx7xXs=
Received: from zhulei_szu$163.com ( [116.128.244.171] ) by
 ajax-webmail-wmsvr-40-123 (Coremail) ; Mon, 22 Apr 2024 17:35:48 +0800
 (CST)
Date: Mon, 22 Apr 2024 17:35:48 +0800 (CST)
From: zhulei  <zhulei_szu@163.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net
Subject: Kernel crash caused by vxlan testing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2aAfuct00v7iCdbekWkkYagew/X8u3uv4k1IVePZE0kSTo/Swyf1xOEGrI7MWlCBCXkzuOegNF89lATINlZpupEDdFFHeFpxFHuxGKKWdr
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <610c7229.e38a.18f05295d5d.Coremail.zhulei_szu@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3n1l1LyZmeaMTAA--.2860W
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/1tbiRQ-ITWXAlxfr1AAJsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGV5IGFsbCwKCkkgcmVjZW50bHkgdXNlZCBhIHRlc3RpbmcgcHJvZ3JhbSB0byB0ZXN0IHRoZSA0
LjE5IHN0YWJsZSBicmFuY2gga2VybmVsIGFuZCBmb3VuZCB0aGF0IGEgY3Jhc2ggb2NjdXJyZWQg
aW1tZWRpYXRlbHkuIFRoZSB0ZXN0IHNvdXJjZSBjb2RlIGxpbmsgaXM6Cmh0dHBzOi8vZ2l0aHVi
LmNvbS9CYWNrbXloZWFydC9zcmMwMzU4L2Jsb2IvbWFzdGVyL3Z4bGFuX2ZkYl9kZXN0cm95LmMK
ClRoZSB0ZXN0IGNvbW1hbmQgaXMgYXMgZm9sbG93czoKZ2NjIHZ4bGFuX2ZkYl9kZXN0cm95LmMg
LW8gdnhsYW5fZmRiX2Rlc3Ryb3kgLWxwdGhyZWFkCgpBY2NvcmRpbmcgdG8gaXRzIHN0YWNrLCB1
cHN0cmVhbSBoYXMgcmVsZXZhbnQgcmVwYWlyIHBhdGNoLCB0aGUgY29tbWl0IGlkIGlzIDdjMzFl
NTRhZWVlNTE3ZDEzMThkZmMwYmRlOWZhN2RlNzU4OTNkYzYuCgpNYXkgaSBhc2sgaWYgdGhlIDQu
MTkga2VybmVsIHdpbGwgcG9ydCB0aGlzIHBhdGNoID8K

