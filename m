Return-Path: <netdev+bounces-273439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNAqClUry2n8EQYAu9opvQ
	(envelope-from <netdev+bounces-273439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:03:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F713633E2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CA72302A555
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690831B114;
	Tue, 31 Mar 2026 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV55W4p7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136552727FC;
	Tue, 31 Mar 2026 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922576; cv=none; b=jLZVYwYCdgprvDVUe25vHASW4cP+xxo/gXCAqML42UpSX0y7jOmL50GmF5bvXqr6gNb99Vo6l9z6h8ZOnPEAulhaDcqLc2JbPdcCh2ZfmG8gfzCEUsWmtvBktmsGRCEWQEOTb4mNygiwpQfzUSb9PDN4TUlUjybHSFwzW/Zl2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922576; c=relaxed/simple;
	bh=RirdtZQT4XKv4gVDUR1oaEGSsQYUx5/kH3a1aqQvyDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVV5zily0qBKktByeEsbOd6b2olVj2ts4HaJKSI7A4Ov0Yx8IAJPAQVHcqkvQFPVknTW47DmnEdyeQGIVmAEU6VJiX2daUpf1+bBSHi/JgY8IO6ITvX4rBOg+c+6kudIOO8zdGh+u4fOecK03uxblTRjpEB4DWPMllbnPesxfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV55W4p7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391D7C4CEF7;
	Tue, 31 Mar 2026 02:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922575;
	bh=RirdtZQT4XKv4gVDUR1oaEGSsQYUx5/kH3a1aqQvyDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XV55W4p7nuFwEo/aHAkn58rfNcSMi5G/IOhkP2IIctK3HCxMBWBU1I8eDoly8AB3H
	 re+O44S6sIS4dZiI5PfqktV/9ykUIGj5ADfci2EUJQaRiXPy9kU1Aij3azUz0DDyMS
	 CgYVzkbudNZVmM7masjONUY5O3tyLwvQ1I7AfUrQf+PrbqTWSc8dYUI2ceZBwcZoys
	 4noqsFemoaLQGK/8awr0NGLZtuwHOtswrIFr66uzYVOgVPK7fpW/dUsX06jc0Pr/KC
	 RufrU13ijuFpTT/1EzWowXp9h2wvbnNDHfirtcu5CbABnpzQ/oLt0JgGZGiqlZrSLK
	 iCKQn1l9Ep1tw==
From: Jakub Kicinski <kuba@kernel.org>
To: hsu.chih.kai@realtek.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	edumazet@google.com,
	bjorn@mork.no,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v4 3/3] r8152: add helper functions for PHY OCP registers
Date: Mon, 30 Mar 2026 19:01:56 -0700
Message-ID: <20260331020156.3518006-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326073925.32976-456-nic_swsd@realtek.com>
References: <20260326073925.32976-456-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273439-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92F713633E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 32a4e8d423115..8747c55e0a484 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
[ ... ]
> +static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
> +{
> +	u16 data;
> +
> +	data = sram_read(tp, addr);
> +	data = (data & ~clear) | set;
> +	ocp_reg_write(tp, OCP_SRAM_DATA, data);

AI flags:

  Does writing directly to OCP_SRAM_DATA here actually write to the intended
  address?

  Because hardware indirect SRAM access ports typically auto-increment their
  internal address pointer upon access, the sram_read() call will advance the
  pointer. By writing directly to OCP_SRAM_DATA instead of using
  sram_write(tp, addr, data) to re-establish the address, the updated value
  would be written to the next address (addr + 1) rather than the original addr.

  Could this corrupt the PHY configuration memory across the initialization paths
  that now use sram_clr_bits() and sram_set_bits()?

Can you confirm if this is legit? Not sure whether this device / register
auto-increments or where AI got it from.

