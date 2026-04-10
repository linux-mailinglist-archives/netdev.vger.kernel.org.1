Return-Path: <netdev+bounces-277317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGinMiLN2GktiQgAu9opvQ
	(envelope-from <netdev+bounces-277317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:12:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 644E03D57BF
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3909307309F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F93ACA51;
	Fri, 10 Apr 2026 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gvkd+Nqj"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB872D7D27;
	Fri, 10 Apr 2026 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815590; cv=none; b=Y96y+ZPgQx6MKsaTZPmF4ydPzcl89mQsXoYai+Qyr1EahjD/k7SCGmlEPZznLC+MMVS05RoeFxRg1ntGQJjy7y8fW65FbArmOIlW40Md7aNQtNjD0tf7lg3VtBwSCXXxfhxWc1NCvEy1xURh9+FRaM9EfGqatHHmu5S3ElanQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815590; c=relaxed/simple;
	bh=wnr94lP6aL8TmgsrcpDiGyiUGOH8xvev6pjgyErOphs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-Id:
	 Content-Type:MIME-Version; b=OZnEtRl6oJEpcj70O0lTUTbPzZHMsWcvbtBvRTUber8jtHIjUz3YSnb/NMvSI3EDIkvO1zUAGATuZ2AY4zVtugWY3u4oCgEu99+NwfMB5EdPuBjgIdB0eymLU6D3p7dAmgMgXP9l0kemnACzTYaIOv0Zkp0bSJaM28iauL76Whw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gvkd+Nqj; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=wnr94lP6aL8TmgsrcpDiGyiUGOH8xvev6pjgyErOphs=;
	b=Gvkd+NqjdcrK3C61swxJhEcQE1K8bqJ83Zb2OF/BXWpYoJVZfowHhcCg/9Z42z
	mbFHscdob3GJNUOlGezvP/VFldsyNEN06Q2v/EaF5OHKlyLEJ7hqTOshiaWUxTOO
	VACrPFdGIsHIsSBvuCvuTpbhLIgHwsXcaDEXgoTMPz29A=
Received: from 229.199.16.172.in-addr.arpa (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCHJs2Ey9hpC4kKZw--.1776S2;
	Fri, 10 Apr 2026 18:05:58 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefano Garzarella <stefano.garzarella@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Bobby Eshleman <bobbyeshleman@meta.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] selftests: vsock: avoid races creating Unix socket paths
In-Reply-To: <adi1X_3wVUsDhRmR@sgarzare-redhat>
References: <20260405195733.86043-1-create0818@163.com>
 <20260410035237.59644-1-create0818@163.com>
 <adi1X_3wVUsDhRmR@sgarzare-redhat>
Date: Fri, 10 Apr 2026 18:05:56 +0800
Message-Id: <177581555638.13754.16558385745397476529@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:PSgvCgCHJs2Ey9hpC4kKZw--.1776S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUlkVUUUUU
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6Aak3WnYy4a25wAA36
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,meta.com,lists.linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[create0818@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[163.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 644E03D57BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sorry, that was my mistake.

I accidentally sent v2 without the patch description. I will resend it as v3
with the proper changelog and Cc Bobby as suggested.

Thanks for catching this.


