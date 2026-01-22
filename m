Return-Path: <netdev+bounces-252427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFUZKPhWcmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:57:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC36A7D8
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BCFA3099BC0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62AD3994BF;
	Thu, 22 Jan 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT5yWHwp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4573994AD;
	Thu, 22 Jan 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098107; cv=none; b=DV4WrKsCFjCywZ5aDhj+taqH452/xRJ1FDpvgc+JL4KW1Occw5W/sZzsahzMx64GxjMJNO3CwzJGtzw5a3B4enQn7lKnhyrWuWk91H4cmIi1siPaif1LT4JQ1v15630Lz3Ra4/+wPrUOt53e9kHeUg1qxcE7U4qkol9qkQ477S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098107; c=relaxed/simple;
	bh=KhaqxuaTMA0SiOWI18UsVIS+wXCJkmLtCI0y06ff6qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjeiQPKFCYu6mlkAkznJ5fNyLMNWjDJxH/6NdJx59lPdnthtVeLBMJsTPaF/RLqQdACLYwcpglnRdh9m0dxvTTJ/cyQATjGNvzgUTIO8zzQTcATASTGbZniFxxPc7DNMAsKgFbKlq6rebNiZKbW/3+RMWKxW3n39Lz4n8Ystir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT5yWHwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84DCC116C6;
	Thu, 22 Jan 2026 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098106;
	bh=KhaqxuaTMA0SiOWI18UsVIS+wXCJkmLtCI0y06ff6qQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kT5yWHwpLgO5uOc0y4g6eTLU3F8AQINpNiH4dp71jpJgsNMokIFcqHRdBkZx8OYW4
	 Ok0i1CfqnjQCs3jqEm2S/zbzyKsuO1w4+92mYSPq1HZi664IwZREhSF7AFcQK7MX1O
	 13a1zjEiZ8MaCLDMb/9D/Nyhvl7FUCNge2Zma2Fmg3SmBP+rYnHJymLS+z+LUMGwV+
	 EdU8M2NoTmLizGh+JqccfwyoIcu9zDZfK8zqFpdAd8OEiPtn1Qh9l8XYKeX7Wim3+v
	 JvzJW60ljRypIbIZX2vRaE7BMgkGt/VZL+hgQ0JguQjBJJWiLyn6J0rMdahWduUS9b
	 eeWFWCZ08DQbQ==
Date: Thu, 22 Jan 2026 08:08:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net] net: mvpp2: cls: Fix memory leak in
 mvpp2_ethtool_cls_rule_ins()
Message-ID: <20260122080825.39eb96b4@kernel.org>
In-Reply-To: <20260121140600.3903164-1-zilin@seu.edu.cn>
References: <20260121140600.3903164-1-zilin@seu.edu.cn>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252427-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,seu.edu.cn];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47BC36A7D8
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 14:06:00 +0000 Zilin Guan wrote:
> Fixes: f4f1ba18195d ("net: mvpp2: cls: Report an error for unsupported flow types")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Please feed the _patch_ to the get_maintainter script.
The author of the commit under Fixes should be cced, please repost.
-- 
pw-bot: cr

