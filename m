Return-Path: <netdev+bounces-266376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDrzFpansGnZlgIAu9opvQ
	(envelope-from <netdev+bounces-266376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:21:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8525939C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BEF5308ED53
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F273793B7;
	Tue, 10 Mar 2026 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="n6kW/ZRl"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D000271468
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773184915; cv=none; b=LpgjTgDGUHJL19ztAa3DDbsDqFiBl0xefjvOvoueY9/O67uOnBhkLZzcwroX5PBJ4H2jzNOCudFK1MQ9QolhycKp2ZO0ScgLqh5rV9rIilj0ppHEeNuYxZ24jV/FUkIG0W7cV0r+wpptz44O64ijEq3VeF+v5jcLUF48pmrVbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773184915; c=relaxed/simple;
	bh=bvqzWANvPjz6RqUPpsIg3jA1o1pFcI/n2qiTmXiY2cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqk9F4ZNzSG0+ucCIYXDiRZ8CAQUlGW4w/E8upwosevYQHM7/ryNkzEBBDM246T35B65QR+ZtTNF9zkLl0KUfwf9w9OroayxWB9SR3UgvH4PUIe1J4NYP7gixly+Sh8koNdmqJA6e/RCpj+B31XKGxzl5+E1bkg7R00mxBTCbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=n6kW/ZRl; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B2F2A38F7;
	Wed, 11 Mar 2026 00:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773184909; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WwEWWzIpFNOFe1BaTV+lhWg06jRJbYhvQ1ALST3655o=;
	b=n6kW/ZRl8Fb2IJlSXDtc6sCnqqaIUE9CA1/b0Ssq+6h6dgSw1/of2QVL00cPf8vEhHUrR/
	OzsLei+IX99tpjSW2HdTGcyFRhw/O32fSVIT2P64Lm2IC0Inst3WZMW31pYgrojA0sjevR
	B+FlY9Lx22wEogM+iqAKJwxmqYjrD0ggFerXCuKPtAn0p3180PmAGNIRJk2QQ3Lh9mLdjt
	WOaTKcSRUSvBsKJCj7VEK7mnfj3g1COaYz7+JLudllcjEaxYl+sArz143Rie5RSaT4Q0Uh
	T+woqsQ1BcHTvjIWTYGbMylWzX2TDORAVsTgEmSHFT+gRj0OOSV/4ojLD0Actw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: pvalerio@redhat.com
Cc: netdev@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH v4 7/8] net: macb: add XDP support for gem
Date: Wed, 11 Mar 2026 00:21:19 +0100
Message-ID: <20260310232119.1254817-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309144353.1213770-8-pvalerio@redhat.com>
References: <20260309144353.1213770-1-pvalerio@redhat.com> <20260309144353.1213770-8-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: AAB8525939C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266376-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Action: no action

Hi Paolo,

Nice series! One issue I spotted that interacts with the EEE support
that's currently in net-next:

> +	spin_lock(&bp->lock);
> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> +	spin_unlock(&bp->lock);

macb_xdp_submit_frame() writes TSTART without first waking the MAC
from LPI. The regular TX path in macb_start_xmit() calls
macb_tx_lpi_wake(bp) before TSTART for this reason -- the GEM MAC
has no auto-wake mechanism, so when TXLPIEN is set in NCR, TX is
blocked and frames will sit in the FIFO indefinitely.

This affects XDP_TX, XDP_REDIRECT and ndo_xdp_xmit. The fix should
be straightforward:

	spin_lock(&bp->lock);
	macb_tx_lpi_wake(bp);
	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
	spin_unlock(&bp->lock);

macb_tx_lpi_wake() is a no-op when EEE is not active, so there's no
overhead in the non-EEE case.

Thanks,
Nicolai

