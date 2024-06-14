Return-Path: <netdev+bounces-103551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF69089A3
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CB91C26DD0
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE801993BA;
	Fri, 14 Jun 2024 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="OFslIQ+A"
X-Original-To: netdev@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931A19754A;
	Fri, 14 Jun 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360317; cv=none; b=TcBuutl1YVmPWCtJnw5ayQIsPoD22u9sjgV5d0dkbMGRFlnrSBuimBsTpYQdjr6CBegr1ecQCYKs3S6dNIxiLj1OnLDriDxiZUX7hvnBJnPmwusHnKj5jcxWKSzFSHVpeWpkn+Yb7rNFqD8qYT43IaV/6PeLBisUwKGnvGQDf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360317; c=relaxed/simple;
	bh=9sQxTcB4tQcicv3SgwJlLxCQ8Gwg5BkPrUfSOqMLj5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocC6yR80i4xv0lJ0CdL6UJFGn0gqdT84Ffw8/RnUFYlCnhYZUKEuUq8aH8vOE2OmKVxXqj78qdimn0auvXRDDIb+EesWSvCddRD34HMQLAJaCGGdcU+APePGuR/VraGQNIvc7b8ofJ8xdTaf86IDA4iqXbtQ1snohZYfZ5gPusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=OFslIQ+A; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1718360306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xG1AQXuw8xV0an8P6VCKByYew/mF3CYP7qNVxhJkJ7A=;
	b=OFslIQ+AwLcdrvdVlRhus0hfY038/oT5zqHecaJhOhY9lt6uI87bTL1iOey3o52ki1ZfDF
	gD6WOhSiAxm9ZNmhg+DKmw5Cczm5h8vkHv7Hso2m3nA0tdVm70LD6/2Csf+sFx1LDR+wk5
	xktdnReIjxLOvnEzl18u0YK+d7Xs4Qw=
To: jiri@resnulli.us
Cc: arefev@swemel.ru,
	edumazet@google.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH v2] net: missing check virtio
Date: Fri, 14 Jun 2024 13:18:26 +0300
Message-Id: <20240614101826.30518-1-arefev@swemel.ru>
In-Reply-To: <ZmsG41ezsAfok_fs@nanopsycho.orion>
References: <ZmsG41ezsAfok_fs@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yeah, I was thinking of adding Fixes: 

But this code is new, it complements what is done.
1. check (!(ret && (hdr->gso_size > needed) &&
               ((remainder > needed) || (remainder == 0)))) 
 complements comit 0f6925b3e8da0

2. The setting of the SKBFL_SHARED_FRAG flag can be associated with this comit cef401de7be8c.
In the skb_checksum_help function, a check for skb_has_shared_frag has been added.
If the flag is not set, the skb buffer will remain non-linear, which is not good. 


