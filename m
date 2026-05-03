Return-Path: <netdev+bounces-283525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMVGKeGv9mlyXgIAu9opvQ
	(envelope-from <netdev+bounces-283525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:16:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F22F4B41EB
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07CD7300F5EA
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868E35DA61;
	Sun,  3 May 2026 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM5oOxWN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7534E57C9F
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774536; cv=none; b=aD9iMon4nc4Z9kPmHW+RdBqErNPaC4rSjPEeeP0dfVCQroPUBvoHcq56D77njwS7sC16hBxqO6m3e30BPFstifhRLZzzbq7q88YQe5urX8FbNVSAytuxzdgpjGjxO5yuZxZZwsJN9n+owg5/f08EDOp0SINb2EzJAGV8snw3dLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774536; c=relaxed/simple;
	bh=lBXQivGKQTMr9UXZ4Qwa1yAjt9bA2hoVDwRtzeZxKaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMEbDFWG64AxiAOo9V2idQnioXKpUCcRj458xQGRZqdjYjSjKGrkt76ib5JUDTpcHY0S48zS/e03XaaVxE5+wIYVtfNTkStrfrRvzjrFIRevPNvjk5KHekycx285L7/iRblUHQy4OwjtXV3MB8Ozlcmmd60RjuXd6+a1zxHQKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM5oOxWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638D7C4AF09;
	Sun,  3 May 2026 02:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777774536;
	bh=lBXQivGKQTMr9UXZ4Qwa1yAjt9bA2hoVDwRtzeZxKaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CM5oOxWN9UFUGFIWYK3gp5OMKO+WJI1dbo8kOIfdDRIb1p7PYmVPJcGJh7PvLORDd
	 RSyG6A5exzobHwxrfqtJ4xl3xMm541akt8ZQ4VLaEb9JY4rgUgRZ20+Y6K6EZlvDrx
	 Ik6+i0ZPTFvUohtVDxyT1SsAsOhZ5PiZoFIzKxjmho9koYsLhIvDOMWNuxOeUyTFRL
	 1BMvoxT9YTvR+QbGQK9wJuXkkCHddwRNvdQJEqhz4Hp0RMS5kjwB9bXTCcuq0PcYfU
	 w72CZRI3Ec0zJFgeahCCp55pHKDZ5XfEFZzBAU1xjO1jvndNKYQaLlI2+fqUiaM4G7
	 cnM5qGPCr5hrg==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	kees@kernel.org,
	larysa.zaremba@intel.com,
	leitao@debian.org,
	joe@dama.to,
	jacob.e.keller@intel.com,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v2 4/6] net: wangxun: extract the close_suspend sequence
Date: Sat,  2 May 2026 19:15:34 -0700
Message-ID: <20260503021534.4127288-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430082517.19612-5-jiawenwu@trustnetic.com>
References: <20260430082517.19612-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2F22F4B41EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-283525-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wangxun: extract the close_suspend sequence

Refactor the .ndo_close implementation by extracting the necessary
hardware shutdown sequence into a dedicated close_suspend function.
This is for later implementation of PCIe error callback function in
libwx.

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index ec14dd47cd428..2bd00eade11d2 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
[ ... ]
> @@ -547,7 +555,7 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
>  	netif_device_detach(netdev);
>  
>  	if (netif_running(netdev))
> -		ngbe_close(netdev);
> +		ngbe_close_suspend(wx);

Is there a chance this change to ngbe_close_suspend could cause issues
with the PTP clock state during suspend and resume?

Previously, calling ngbe_close would invoke wx_ptp_stop, which unregisters
the PTP clock and stops its background worker. The new ngbe_close_suspend
only calls wx_ptp_suspend.

This leaves the PTP clock registered and its worker thread active since
wx_ptp_do_aux_work will continue to reschedule itself.

On system resume, if ngbe_resume calls ngbe_open, which then calls
wx_ptp_init, wx_ptp_init will unconditionally call
seqlock_init(&wx->hw_tc_lock).

Will this re-initialize an active lock, potentially leading to lockdep
splats or silent lock corruption if the worker thread or a userspace
process accesses the PTP chardev concurrently?

>  	wx_clear_interrupt_scheme(wx);
>  	rtnl_unlock();
>

