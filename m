Return-Path: <netdev+bounces-273415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LTUBbwby2kEEAYAu9opvQ
	(envelope-from <netdev+bounces-273415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:56:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB46362E73
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872743052B87
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB18F2FDC20;
	Tue, 31 Mar 2026 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f06MeiNJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4E2FCBF5
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918469; cv=none; b=S5ObC4fpoO5a/Luf6koJ6bwjMf4mPaqxPX5PtQg4VyhZMOBVND8eR4XFqZwAVG1Jd44Ttu3reBS6S2DqnrUPAsY/WPdsKbQ9XHTLAQR79O7JMGwO1phWTC6xjfCayvLvtqixirjrRu9bHnssGkd58IW8tVXxPNsyeU25n3PwU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918469; c=relaxed/simple;
	bh=K0DscVSa4MTnx5Wr/Z6aTcwWmBEICBnBOcksu7QjC54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CO3K2e7w9btJsLF/Fnri0CJx5bQADj9Xw99g3UUcd0YW3C3Tg4JckNdaIxJE7LOkAboSYSu+9IOKsscD1artcb5nEL+0Tejv8LXgtFnMDxvXZADgYE0qkx9LriRrEIY/XU54miT6CnVMmyvViJCQA76K/rD5yVKvLFxFa5Ycsvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f06MeiNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EADBC4CEF7;
	Tue, 31 Mar 2026 00:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918469;
	bh=K0DscVSa4MTnx5Wr/Z6aTcwWmBEICBnBOcksu7QjC54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f06MeiNJhnStjaxXOOk6DnNZEsCbvApG2tcxJABCL1y12QWRGexuGzWBCq2uEj6hh
	 Kf2vrJTQPP7neR3Zr53VZGr54/M34vW/2L0N1zcRMZEFsVSmeiIqfvS7JsqiyjC8pB
	 8JyeREoRxeY0M0Dr4Mupx//n/yPa+CIvvgKaIeKHhs2qUdjKpJf5bmRE8lgJ8w2RLR
	 MdjKqsqxOevp/mBSMORlmUSsjLPtn+19tgNz6kMlvIpkA3ktPJmSS6oThixGT1K0xJ
	 BbvjS921IE3/1WE7Z9RAHKb3vdvs4EtAQTZT6Yr8ITflIGw3ebl90MxTAkEpC/aHiD
	 fja9dbVIfXv6w==
Date: Mon, 30 Mar 2026 17:54:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, Joe Damato
 <joe@dama.to>, Larysa Zaremba <larysa.zaremba@intel.com>, Abdun Nihaal
 <abdun.nihaal@gmail.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net-next v6 00/11] Wangxun improvement and new support
Message-ID: <20260330175427.53eaf2d1@kernel.org>
In-Reply-To: <20260326021406.30444-1-jiawenwu@trustnetic.com>
References: <20260326021406.30444-1-jiawenwu@trustnetic.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273415-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,linux.intel.com,intel.com,dama.to,debian.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACB46362E73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 10:13:55 +0800 Jiawen Wu wrote:
> Implement power management function for txgbe. Clean up the same code in
> the two drivers, to make more use of lib functions.
> 
> Add Tx timeout process and pci_error_handlers ops, to recover the devices.

Split this series up, please. Why are you submitting flow control 
and error recovery changes as a single series..

