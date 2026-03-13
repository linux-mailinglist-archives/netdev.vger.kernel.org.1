Return-Path: <netdev+bounces-267338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KbvCuXPs2ncbAAAu9opvQ
	(envelope-from <netdev+bounces-267338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:50:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761B327FF28
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF2463016515
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778D6387367;
	Fri, 13 Mar 2026 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eDr52meg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4DBDF6C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391840; cv=none; b=WUCLyTitulQC7bGw0YV/Jd61ST7AZf9BvwcH38Gh53e6YQFYamEQ9KQvDK8tLMN5xwyTqvWXnjBgwxEQrqgA0Z/YqSiZHFeKQ/fdgaZ+Icr2+YXXSXkLkXAJMbAq3tkgfNJ1x4Ltnw1XqZ7pgvh0MZwvWpcTmXpVvvU51YMpXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391840; c=relaxed/simple;
	bh=HngBp9zwUVTOc8cWhCRSHEddVxXjIezmA8vRWVUUUEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uek/Tb3hGC3Z4jiWcLSOJ+YOfEM4k7J2nTYzVxDUnJ7qJDHGUJaHya6YbNPgQeCg7Bfk2Ax8kt50qhtuWiQLnnuiSjBNJzfQk6RXX2aSyRPM0y7f/ORgApdkUSgtXiGUC2VCB/OtagjW+PtVjMp5pGNg74XEZ39dmEFUm7ccl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eDr52meg; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0DB1C4E4266E;
	Fri, 13 Mar 2026 08:50:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC9D260027;
	Fri, 13 Mar 2026 08:50:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F043710369044;
	Fri, 13 Mar 2026 09:50:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773391834; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CRbMmZcTVgqE5UCl76Xsr6hd1uo+lW/4EJBhIeZPwB0=;
	b=eDr52megjJQxHtqmYRUkWlQDxRI8Iq4S2DcmFHREyTcxhqsnDLyk/xgun0DLxwbZlX/BoQ
	WaZ42lZj4IClnTP0o4xR3KazLfMOMXVi0TULKwzp0+9vTCf+vl4AvL60Qure6XMqlmLgiI
	7IvbcXUG2DiafOVIa/KRDQ8Tua2n5lOyaddZ+I9zSQcmoud/zIHTVTvM0H2hTvf9huf7Et
	7JWbTTn8nPi5dbeEzApTxjJ176YbcT9bbFzqE/Czx2ImaTai0xGnhuVo9qY3quOAnXxbxJ
	ow1R55q8/7akQ5uJViHyNxx1sVYF551H49OvGTEjnwofTxsd3jzGnIa9rJ8CnQ==
Message-ID: <439753dc-496d-4e03-8480-ea409fb3d4bd@bootlin.com>
Date: Fri, 13 Mar 2026 09:50:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v01 5/7] hinic3: Add MTU size validation
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
References: <cover.1773387649.git.zhuyikai1@h-partners.com>
 <53eb2c11ed4ccd93787352ef48ca56d6d51a150a.1773387649.git.zhuyikai1@h-partners.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <53eb2c11ed4ccd93787352ef48ca56d6d51a150a.1773387649.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267338-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 761B327FF28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 13/03/2026 08:54, Fan Gong wrote:
>   Check whether the MTU size is within a reasonable range.

I don't get why this is needed when we have netdev->min_mtu and
netdev->max_mtu already to sanitize these parameters.

Is this patch needed, and if so can you explain why the
netdev->min/max_mtu parameters aren't enough ?

Maxime


