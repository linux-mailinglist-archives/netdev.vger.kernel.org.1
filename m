Return-Path: <netdev+bounces-299781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6qSHNTsRMWpobAUAu9opvQ
	(envelope-from <netdev+bounces-299781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:02:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C968D5C9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:02:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=LWXn3Xit;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299781-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299781-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8FE308D40E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF90B3DB31C;
	Tue, 16 Jun 2026 09:02:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705A40B6E0;
	Tue, 16 Jun 2026 09:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600525; cv=none; b=iV6pBRhKC3W3PTe4EQW0Q+vxAKZ8ABCb5YXMZh22Jz2gDBjBZ4xfD79FRXw7EyevAFJAZDMvE0OJq3x7f8+dkNZWVt7WHyq7uFHr9CahNBqZXLp4qiNUin6r2L1nlCo1P7X6kuEdQuBVEnLwL/7/ce81y03ivrsUQBWjxPCnYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600525; c=relaxed/simple;
	bh=49w5pQXimTq2+rcz8HAdsxh2TDzJGYdv1MnREY0ukuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4k9BVNvfkiG9LEKPzJOIBfE94XWFQe/GrEa68Ou/1Eug1zwtxD3DpKKEqYm0gZ15lZCEpr1uWkZYjFDZBPbZ8Q5Bdy1jGvAa4Qr6UtNQcDnbJw5dn4iTgMMg+47Imb92o706CrWx6VvpIzAz0BmKXKnYcBcog23orCC+1mDiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LWXn3Xit; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=E7
	8rCGEndI8LmHgvYI64KGxmrptBpeFFszYQlWaMOcM=; b=LWXn3XitqQLYox9FZF
	uka70RynGoyaJ8LCdxttoKRYgReynewLPDlmL795qJlh9cH90XkVYfsJ1ojLSiiZ
	NeRcxTrsXkMiqZAGYkBtEjPtW1hnctKvgHxDp5UziFWRTFgX0HTH0svahYaXK3Je
	Pvi5Dc/mOxW3rwPa7R0MOvUVI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHlAP0EDFqXkm_Cg--.9273S2;
	Tue, 16 Jun 2026 17:01:41 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: r4o5m6e8o@163.com
Cc: eperezma@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	wangyufeng@kylinos.cn
Subject: Re: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
Date: Tue, 16 Jun 2026 17:01:40 +0800
Message-Id: <20260616090140.61347-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526080336.61296-1-r4o5m6e8o@163.com>
References: <20260526080336.61296-1-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHlAP0EDFqXkm_Cg--.9273S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRMlkIDUUUU
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzhUonWoxEPV1KAAA3N
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[r4o5m6e8o@163.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299781-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS(0.00)[m:r4o5m6e8o@163.com,m:eperezma@redhat.com,m:jasowang@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:wangyufeng@kylinos.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r4o5m6e8o@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 577C968D5C9

Gentle ping. Any comments on this patch?

                                  Thanks
                             Yufeng Wang


