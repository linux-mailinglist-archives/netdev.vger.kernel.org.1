Return-Path: <netdev+bounces-293626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBkVGPZOHWrDYgkAu9opvQ
	(envelope-from <netdev+bounces-293626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:20:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B73EE61C4AF
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D81A308B7B5
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539BF38E8BD;
	Mon,  1 Jun 2026 09:13:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98638F24B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305199; cv=none; b=crl68jAnHb5lnjtXsv5SokFmrscEJsl6027uODbQ7Gqs85xIht91wBGgdoGExSWHEST4I0Y2ElQU33RregCbiSNev3vL1/9ioSO8QgpyGwzXLJTtR2uIhlghSDe6IVOn0pB5MmLXc9CnuZX7vTDcq1R+4F4KdGx864tHIah5ph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305199; c=relaxed/simple;
	bh=ToYqdGU7+iit+uhmRTQEer6aCgEUE3bYFeUUNH4lS4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t4VymOrD5GH1RrbLbfS88E6K6z6dK+3a0uHqTlSFjMefEnRNA0aX2ezg7gs/6wBwgDtL8U/D69CVzmWBNrrOWbDw5qRFpCitx6mKQl87F4CfipR+a0N7CAZASGRPkqiA2PgMIkckUxNvY/v/MQEVJ5oZ4CYE3NKM5gtcu+jxjI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CFCCC604DC; Mon, 01 Jun 2026 11:13:08 +0200 (CEST)
Date: Mon, 1 Jun 2026 11:13:08 +0200
From: Florian Westphal <fw@strlen.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Felix Fietkau <nbd@nbd.name>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org
Subject: Possible UaF bug in netdevice teardown path
Message-ID: <ah1NJMrJ5rEkQlJG@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293626-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.857];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,strlen.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B73EE61C4AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Another sashiko drive-by report. TL;DR, do you need to apply this
pattern in your driver?

-       metadata_dst_free(priv->md);
+       dst_release(&priv->md->dst);

Affects:
drivers/net/ethernet/airoha/airoha_eth.c
drivers/net/ethernet/intel/ice/ice_eswitch.c
drivers/net/ethernet/mediatek/mtk_eth_soc.c
drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c

Long version:
https://sashiko.dev/#/patchset/20260527135751.1031891-1-tristmd%40gmail.com

This isn't a bug introduced by this patch, but looking at this fix, do
other callers of metadata_dst_free() suffer from the same use-after-free
vulnerability?
In drivers like ice_eswitch and mlx5 MACsec, a metadata_dst is allocated
and references are taken on it via dst_hold() when packets are processed
(for example, via skb_dst_set()).
However, on their teardown paths, these drivers call metadata_dst_free(),
which unconditionally frees the memory without checking the reference count.
If packets holding these references are queued (like in a netem qdisc)
during teardown, does the memory get freed prematurely, causing a
use-after-free when the networking stack eventually calls dst_release()
on the dequeued packets?

