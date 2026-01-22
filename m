Return-Path: <netdev+bounces-252419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OCdHZlJcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:00:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC9A6963D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0912C303F041
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A134D90D6;
	Thu, 22 Jan 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsYIVTIr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333284DD6FD;
	Thu, 22 Jan 2026 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097129; cv=none; b=bQXbpmlMKMqlTIstrfhCBokXV+EQ9xedFCDR3xjA30BKaJ/q3uBYVGNN7vE1cj1UpObxhLShdIUl64fGCbCIiDDgttOfxrM9D0CmhQX3sRmea7Hqv9qq4xlc34cWE+jiuJqI2wOa7orX+vfSuYsq1kj9BVMtKypGoVjX0/h/BIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097129; c=relaxed/simple;
	bh=H4l1iCP7+VOlZiUZ0OKn22FT1fDkfwOd/D4+GeFIj5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4jz1i2j/tqzyEEzMTzUuXdczC6fpG1nrTi1/H5hHfp5IYw3sGJFYyEU/EpK1AEqLajEGXz912VYO9H5OTV4BebnvFKWChmPe+TNPNIyd4foRM5rQteZD17Z3+MnOcpeeUg60nZTXns0hI+nujiEflBMbm7Y/gA3s7/t6y4GJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsYIVTIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BA2C116C6;
	Thu, 22 Jan 2026 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769097128;
	bh=H4l1iCP7+VOlZiUZ0OKn22FT1fDkfwOd/D4+GeFIj5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SsYIVTIrs2T6yP7qetT6dLHxtGob184hnkzuxvIKZ5/GKUyNyCyjeHUorA1x8hH/A
	 8lDdFXjIzJtDJMllwS6ha4K+38OytVR4bMIpiZU5jA6nVUPaK0JULGPjNBqK1MRO02
	 ayeA2w046WtdRe+QIji36SH7Y4bn3pQHxBujUw8GzlHQtkKit9rCLOOYjO8SlG4Q0X
	 xrgbMIyMN1o1wWk3vLxBttEGnf2Eu5ozvL38cbzkDrDdBdgOuev5zcFNLEcIxvUfjV
	 CTP/74H6CDhUq5VUiQlJAlzAN8QJJdyVgefVDXmVfI54+qWOu/pX41BHlGCOttyeub
	 3KYEzb+60Zlcw==
Date: Thu, 22 Jan 2026 07:52:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Srujana Challa <schalla@marvell.com>, Willem de Bruijn
 <willemb@google.com>
Cc: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <ndabilpuram@marvell.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match
 NETDEV_RSS_KEY_LEN
Message-ID: <20260122075206.504ec591@kernel.org>
In-Reply-To: <20260122091527.339180-1-schalla@marvell.com>
References: <20260122091527.339180-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252419-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,marvell.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EC9A6963D
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 14:45:27 +0530 Srujana Challa wrote:
> Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align with
> the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.

I've been meaning to bump NETDEV_RSS_KEY_LEN to 128 or some such.
Most modern drivers can't use netdev_rss_key_fill() either because
core generates a tiny key. And the devices support hashing over two
layers of IPv6 for tunnels.

Willem, WDYT? Is there a reason to keep the core key small?
Or deprecate netdev_rss_key_fill()?

> The virtio specification requires devices to support at least 40 bytes
> for the RSS key size. However, devices may support larger key sizes
> up to 52 bytes (as reported by the device's rss_max_key_size config
> field). This change allows such devices to work properly.
> Previously, devices reporting rss_max_key_size > 40 would fail with
> an error during initialization.
> 
> The driver already handles variable key sizes dynamically through
> vi->rss_key_size, so increasing the maximum limit is safe and
> maintains backward compatibility with devices that support smaller
> key sizes.

> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     52

