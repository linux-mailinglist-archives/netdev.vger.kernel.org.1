Return-Path: <netdev+bounces-289248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFRYFKzAC2olMAUAu9opvQ
	(envelope-from <netdev+bounces-289248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:45:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEE57628E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 378263014A0B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CE22FCC0E;
	Tue, 19 May 2026 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVcGExee"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269152FC037;
	Tue, 19 May 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155109; cv=none; b=KcCRz6srtkZEzcVOqjtuGNhU09teVeUp5niDy7HUXWldbZrC7TovwZJNc4zCUYG07qpWcThY/zG8UTDC7nmhtghVR5VglJTIe4GspxnojZjbQGfigFTn2zd7Sd4KxS+AIfDDXH3YIj6daeoVQLH9fdhkPhyNBpz+99xTTA9A1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155109; c=relaxed/simple;
	bh=jWldts9FblFH1mYDzIugutl7ATve2iNQ1j1e6bLhQoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPmBuxjKL1rUh9YvNDOpgwHA2lxlPKa3N/9Mlstce7hTwXCN0oj51TQPgekkHWO4lpeodJYlgi5RMW8rngcBVv53zyoah918Iyma3+g54wcmChBtN+13LWB+FLvklNKNeT6UR7RGkgRg9n1ayegViuLKWp+sHMSFVnvx4Yhbtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVcGExee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B597AC2BCB7;
	Tue, 19 May 2026 01:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779155108;
	bh=jWldts9FblFH1mYDzIugutl7ATve2iNQ1j1e6bLhQoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qVcGExeea97pfo5vK6My+3vFGZ8z+8IjEdgt+PGRaznq5MiotUpDOsXOhUtPMFwmb
	 oZ8DNLP933KyTxRvRyjZL9uGx4FG9I+tB76CmurjqPLi0R6udkvrUJBCZHPO4auBx6
	 xJzOS1jsyeISCc8aecwaEf4yEwYqmKG9R4QvFORhIIX8HKv7khb3afuh2GWRJlQLtc
	 H+c9POwXWVKKL/bb+YZ/pbuDUXGZH3NT5zxJA7aw8kUaFet/Vd7lC8JQlB3tOKPU3E
	 ZKa1D68Pev6F4tT8Y4zBtfY18+i4CG+nm9dVfdInNaxiYq7YbapsnrUPBbO4zyfqa2
	 Z5485zhJZjr4A==
Date: Mon, 18 May 2026 18:45:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>, Felix Maurer <fmaurer@redhat.com>,
 Luka Gejak <luka.gejak@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Meghana Malladi <m-malladi@ti.com>, Jacob Keller
 <jacob.e.keller@intel.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 2/2] net: ti: icssg: Add HSR and LRE PA
 statistics
Message-ID: <20260518184506.694c584e@kernel.org>
In-Reply-To: <20260514075605.850674-3-danishanwar@ti.com>
References: <20260514075605.850674-1-danishanwar@ti.com>
	<20260514075605.850674-3-danishanwar@ti.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289248-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,ti.com,intel.com,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org,nxp.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 52FEE57628E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 14 May 2026 13:26:05 +0530 MD Danish Anwar wrote:
> Add new firmware PA statistics counters for HSR and LRE to the ethtool
> statistics exposed by the ICSSG driver.
> 
> New statistics added:
>  - FW_HSR_FWD_CHECK_FAIL_DROP: Packets dropped on the HSR forwarding path
>  - FW_HSR_HE_CHECK_FAIL_DROP: Packets dropped on the HSR host egress path
>  - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES: Frames with duplicate discard
>    skipped
>  - FW_LRE_CNT_UNIQUE/DUPLICATE/MULTIPLE_RX: LRE duplicate detection
>    counters
>  - FW_LRE_CNT_RX/TX: LRE per-port frame counters
>  - FW_LRE_CNT_OWN_RX: Own HSR tagged frames received
>  - FW_LRE_CNT_ERRWRONGLAN: Frames with wrong LAN identifier (PRP)
> 
> Document the new HSR/LRE statistics in icssg_prueth.rst.

To an untrained eye these stats look like stuff that could 
be standardized across drivers. 

Luka, Felix, others on CC, do you think we should expose these
from HSR over netlink as "standard" offload stats different drivers 
can plug into or not worth it?

