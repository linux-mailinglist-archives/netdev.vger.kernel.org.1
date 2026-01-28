Return-Path: <netdev+bounces-254098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ck8tHJCOeWlqxgEAu9opvQ
	(envelope-from <netdev+bounces-254098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 05:20:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C58BF9CF15
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 05:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E990300B450
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB222D6E75;
	Wed, 28 Jan 2026 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="i3fpqlWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A385265CC2;
	Wed, 28 Jan 2026 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574027; cv=none; b=EysWUjNuUczO72K00N4nQsikbcF8ZddeqCmmARAESn/aRPHJThmUnp0XRtwZW2HP0XABgb8y0Z5B9mYMcFGPXh7WbGyw0A50SzHOFQJXKJIwbvTRmXA4V7b+PnlieGNeSOPvOGh7hJ27LzGDCF+oCzxHGJDXSbddPNXEOS/OFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574027; c=relaxed/simple;
	bh=EvP/yjeV8vViKHCgiamrBj2IOA0SoGnxDSfIsxW0BhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qo9yJxAXnwK37yT9EsPvSeOK2ZoZN9jTuQA/LmJ5shHPZjcUvd3N8PfmGenNG4GLkDJL2FkuHDC6cXVocmt6XzFQEIHd1GWlnDxz2dqPzqYR5hTdLSW//sGpvhO0tXIdsoxfCvIjDioJvGuNtmKhWJZOTSCj1ubc6bHOnycaez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=i3fpqlWi; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3239de2c4;
	Wed, 28 Jan 2026 12:20:19 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jianhao.xu@seu.edu.cn,
	kory.maincent@bootlin.com,
	linux-kernel@vger.kernel.org,
	marco.crivellari@suse.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	zilin@seu.edu.cn
Subject: Re: [PATCH net v3 0/3] net: liquidio: Fix memory leaks in setup_nic_devices()
Date: Wed, 28 Jan 2026 04:20:19 +0000
Message-Id: <20260128042019.1631049-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127130546.7f53b313@kernel.org>
References: <20260127130546.7f53b313@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c02d4b14403a1kunm26f07c7488273
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGRlKVkwYHR8dQk8YS08aSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=i3fpqlWitm6zc2D1UytD3MN245PnJKsri+FqW8+kaklmTzWSfSNK+GFvZn7qDVLRso/941MQMNzWarlLek7wfAHwJJkAL206ILkyr81A30HrdggvzPHZu+hDnrNQcTWZEitkfl7DImlZjLQYl6iyz0fhO0HSbqJYEQBs9YNdcoY=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=48HlpW0XQnKVlol0xdOLHQn1go+nIuTPixswB9F7kn4=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254098-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C58BF9CF15
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:05:46PM -0800, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 15:12:38 +0000 Zilin Guan wrote:
> > This series fixes memory leaks in the initialization paths of the 
> > NIC devices.
> > 
> > Patch 1 fixes an off-by-one error in the PF cleanup loop. It ensures
> > the current device index is cleaned up and correctly handles the 
> > post-loop devlink_alloc failure case.
> > 
> > Patch 2 fixes the same off-by-one error in the VF cleanup loop.
> > 
> > Patch 3 moves the initialization of oct->props[i].netdev before queue 
> > setup calls. This ensures that if queue setup fails, the cleanup function 
> > can find and free the allocated netdev. It also initializes lio->oct_dev 
> > early to prevent a crash in the cleanup path.
> 
> Coccicheck says:
> 
> drivers/net/ethernet/cavium/liquidio/lio_main.c:3769:8-9: WARNING: Unsigned expression compared with zero: i >= 0
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:2215:8-9: WARNING: Unsigned expression compared with zero: i >= 0
> -- 
> pw-bot: cr

Apologies for missing the unsigned integer issue here. I was worried 
about a potential underflow during the devlink_alloc failure path if 
the loop hadn't run, which led to the while (i >= 0) approach. I'll 
fix this in v4. Thanks for catching that!

Regards,
Zilin

