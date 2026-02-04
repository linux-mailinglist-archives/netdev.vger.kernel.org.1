Return-Path: <netdev+bounces-256665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COmbHfEfg2nWhwMAu9opvQ
	(envelope-from <netdev+bounces-256665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:31:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3F8E483C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2C74302C6EF
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2653DA7DD;
	Wed,  4 Feb 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUURnUy7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D293D9049
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200985; cv=none; b=HypYKtddF/sKhpkIgSCTgH8yABYMfpBAe+1M3TuUC4eAVP6qm7LeWTts9WbJ04yIappiug5yNnkzk+Wp5JhzCPjOYfZu7PWjhgCpytCmCi2d5Ht56HIZYytWGxUc7/4IWzmj6PlE0pyykhZCgB+Fu182lQJnqM7Gy/G9rRdCHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200985; c=relaxed/simple;
	bh=YIUU21IB9wMtKDb5k3cUtJycso1XbTtnuYNTeLOpXFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWcJx8pnADlfDEu9cWgeASSkLW9/1CnC2Xjig6IGgC/n8oMQOKDqcC4Fsj8OsUz/tsxtESHMNSPJ82uw1lhlHn2DY4fNegCvoe5ymI5Kj5t2hU7+/pJAI49Wy9sQVw/IeVQy/e91i/BL4FNQ7rfcmxL14iRqCdymf4oJNUBYWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUURnUy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91DBC4CEF7;
	Wed,  4 Feb 2026 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770200985;
	bh=YIUU21IB9wMtKDb5k3cUtJycso1XbTtnuYNTeLOpXFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUURnUy75lFJ47lfvr6v7SQEKYbogXwdwVBX1uYvo9wwxAKPjry4jY7BZ4Ftr3Bsl
	 o5wrRfoxCcGXcGLhwN/yErAUskFE3Sl/Yg8+YDSLjQUr+FuB0PBASFq5bdNkfNpKJX
	 jOA73CIpo8zd3beVs1wR/MzPrPnLaBIjfTjkfuDszlImxkbm314uo1+gNZj2M91kWn
	 Gmn0q7axBlAROst6JIxfM51NoUMN4yo+0gVnH2bxfi8hguAEL83m9A1GLn2SSuW2Xu
	 TNCtNQiujADfonQ2JDOif2BJzcYBhCSGWrEFcMHcxscX6eGEzdrAUU4Zf6/X7VpECH
	 NdfWHDa+vtwfA==
Date: Wed, 4 Feb 2026 10:29:40 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	kohei.enju@gmail.com
Subject: Re: [PATCH v2 iwl-next 3/3] igc: allow configuring RSS key via
 ethtool set_rxfh
Message-ID: <aYMflIxseCDvgmdq@horms.kernel.org>
References: <20260131163037.88108-1-kohei@enjuk.jp>
 <20260131163037.88108-4-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131163037.88108-4-kohei@enjuk.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: CE3F8E483C
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 04:29:38PM +0000, Kohei Enju wrote:
> Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
> RSS key. When a key is provided, store it in the adapter and write the
> RSSRK registers accordingly.
> 
> This can be tested using `ethtool -X <dev> hkey <key>`.
> 
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>


