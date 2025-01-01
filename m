Return-Path: <netdev+bounces-154647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521E29FF322
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 07:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE463A27C8
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 06:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B47E179BC;
	Wed,  1 Jan 2025 06:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17315E96;
	Wed,  1 Jan 2025 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735713416; cv=none; b=miP5pEVRXtUpv6bc5Riznr8MnAGgoxz04edjkJeALnle128A0ATxaafjd06/3DimA7lcdeFEqYJueLcOQ7dPKlrA2qHZb6udiNk24TYB7nlm2Irmw/25CIsIJd3bhUK6pLLGbpyHMptBv95bz44+/pgiMK6C+e867XoPLz2gINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735713416; c=relaxed/simple;
	bh=E7jkv0qJZOxX7V8zy9yU5i1n/5iQub00XQUeGsEVIm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDXvZpMgzKMboxeX1zjWll5a9EkqF9Aj73M1jWTmLCfaUmTyKg+lMa9qCNQWPCRMUAs+CXTOBqvIGCVloFuLbIu7bYRz6V5MXqUvOG7KxCwF33Ykq8cw6pCsUPdjLOj8A4IVKnDkHqx0CkKPxJI5EiAJDgtETl7/65qRGoJcuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YNKpJ6LnLz6M4cS;
	Wed,  1 Jan 2025 14:35:20 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id D16DA1402C7;
	Wed,  1 Jan 2025 14:36:44 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 1 Jan
 2025 07:36:33 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <helgaas@kernel.org>,
	<horms@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <meny.yossefi@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v01 1/1] hinic3: module initialization and tx/rx logic
Date: Wed, 1 Jan 2025 08:49:37 +0200
Message-ID: <20250101064937.2825242-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241230192326.384fd21d@kernel.org>
References: <20241230192326.384fd21d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

> >
> > We studied previous submissions and followed their example.
> > Were the maintainers wrong to approve Amazon and Microsoft drivers?
>
> It's not a right or wrong question, more a cost/benefit question.
> I'm not sure the community benefits from merging every single company's
> paravirt driver, when virtio exists. I'd say having those drivers
> upstream is somewhere around neutral.
>
> BTW very often guidance for new drivers is set by problems with already
> merged drivers. Not that it's necessarily the case here, just sharing
> some general knowledge about the upstream process.
>
> > I don't understand what the problem is. Please clarify.
>
> Primarily the fact that you keep arguing as if joining the community
> was done by winning a fight. If annotating HW structures with endian
> is beyond your / your teams capabilities, that's okay, just replace
> the "will not be converted" with "are currently not converted" in
> the comment.
>

Ack

> For your reference here are the development stats showing that
> Huawei is the biggest net-taker of code reviews in networking:
> https://lore.kernel.org/all/20241119191608.514ea226@kernel.org/


