Return-Path: <netdev+bounces-280837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABJ6ANBo6mkHzAIAu9opvQ
	(envelope-from <netdev+bounces-280837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:45:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E29E4562F8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0519306C3E3
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FA3B27DA;
	Thu, 23 Apr 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbv3I9p+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAF3B19C1;
	Thu, 23 Apr 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969883; cv=none; b=j9uId22DwzhC9SZLGbkXURxu0Pcdee5lI/Qh8uxEUB72WGO7PAhXtlc3F771B4fRyq6OiXh4gBQoI9/Xpj7G740d9df6N4wqTgMz9tHmNGjc4sukGrMcwIgfLh8DeeSZGAfdscjvy8wIYfVS8dXzq97fuiyr6HIpCjPJW+Xu430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969883; c=relaxed/simple;
	bh=nKVYm2+4MNBxAqoWq5rrdNi92Fr/21nB+LRbVjB2Ve8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsFw9gWm0RBkiKuLuuUT1MS/1hb+CfUqep+CdYM8iYvuY6Aa05v/9F9jKg3T54GhfRA7z2Y4t9kyPo3EBnoqnrbskZKFC9pI9JdMxF4XovIV9I+1kdsw3Z/IzFdNSE0foSk4zVGqjQ9/VMJX+hHgIe9Xecoifs04no8JXHd0el0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbv3I9p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54D2C2BCAF;
	Thu, 23 Apr 2026 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776969883;
	bh=nKVYm2+4MNBxAqoWq5rrdNi92Fr/21nB+LRbVjB2Ve8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lbv3I9p+gITv3tWYKs51g/2l270R8ygYaJFsH5SYTqpPsWNWSDHv5RxjP2tkQNjIf
	 7IG87Vf+DJN1SyR/v54Kwu7I7sADKW5suriaLk1th1F0lOG2clyumxIdRIMmY9e64x
	 tPgr/pZ/MG10uprTY1oz0Kgz7N10zizUagSb0QsHGIawoH44SLbWfP/XUM4mwVJ1mX
	 aKsta5I+VarVA4MoGngN2nns7YFC3Qne+O2fQDXI4RHOAbsQhHNHlaMLSYha0MtdP6
	 +8lTGYjVCAD/YMmLjQ6KY/K5sIlM7OUjYV1NNDeEGmlDUQAKT/n0h5bluYPhLoq8Ub
	 1DkkPxfZj6irQ==
Date: Thu, 23 Apr 2026 11:44:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: Petko Manolov <petkan@nucleusys.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: rtl8150: free skb on usb_submit_urb() failure
 in xmit
Message-ID: <20260423114441.7dd5c677@kernel.org>
In-Reply-To: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
References: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280837-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E29E4562F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 19:10:25 +0800 Morduan Zang wrote:
> When rtl8150_start_xmit() fails to submit the tx URB, the URB is never
> handed to the USB core and write_bulk_callback() will not run.  The
> driver returns NETDEV_TX_OK, which tells the networking stack that the
> skb has been consumed, but nothing actually frees the skb on this
> error path:

Does not apply, please rebase on net/main and repost.
-- 
pw-bot: cr

