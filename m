Return-Path: <netdev+bounces-296417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mq/yAxB+JmqZXQIAu9opvQ
	(envelope-from <netdev+bounces-296417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:32:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CCD654138
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:32:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=nx8PZRa5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296417-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296417-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 193BB3011E9C
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1703AEF5F;
	Mon,  8 Jun 2026 08:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FED2BEC3F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907426; cv=none; b=IYn/xmV4vgDbxxkQjRj3ndtbpXW6mTO1RJpMKPlN9RNDY2bQaB69H7nrShPECZ0vrT0+GN7yNGNY3ADXM+ajWz/w24Rmrmo/qa/mLXctiHh/fGS6uViV6/O5l4xW2e5glYkZVzrJFLTxJcRtRqrO592GvVW2vpwpBaFD8YPzoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907426; c=relaxed/simple;
	bh=uwHLugokt6wTViB6gk+QIYR6ZA3nKcU9v8GIUGnRLD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=KEblYiquOeQ2hBgb91IqQ/8yYIHE9T4RHTk+k6ZYYvWkn+mBGMyUxygR4+X2bzwDS1PjeQlUTTOT9B8af4QpSEuihrYqlv6XmawCuyiKbYasMLDM0gQoXhSBo8tJz3DyjKaK2LVU53tb65ySf24itVDIxcByWnvAmFp3Jy3UYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nx8PZRa5; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260608083022euoutp01525ddcc6e279609b22baf615005d1bf0~3Dd15bJ_i3186431864euoutp01V
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:30:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260608083022euoutp01525ddcc6e279609b22baf615005d1bf0~3Dd15bJ_i3186431864euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780907422;
	bh=wjeEYiLODKr24D2k4QSbkK13mn3e3WvrB5HFWfCI+Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nx8PZRa5udYktTVgfsn5NFFHUa0anqP+Lf438B0SRyHqaNPT+Z2alvfxDANX0dPc4
	 iIIH5j6AoGsxoVmEIdBTv6bpZU5Ei5SWnwsvodFfB7wUEKenBlNrYeEghZv4RgVikX
	 OlBZ+D7+m31Xh2U2BVQgVxTGqGwDSGa1sPlW+V9w=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260608083022eucas1p2ddbb690dd15bcc5297e83779ce13f694~3Dd1itoi62513225132eucas1p2F;
	Mon,  8 Jun 2026 08:30:22 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608083019eusmtip256610289b9ea9aea5e3d3d6b518c3b1e~3Ddywy60Q1379413794eusmtip2V;
	Mon,  8 Jun 2026 08:30:18 +0000 (GMT)
Date: Mon, 8 Jun 2026 10:30:18 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org, k.domagalski@samsung.com,
	k.tegowski@samsung.com, cs0617.lee@samsung.com
Subject: Re: [PATCH net-next v2 1/3] net/stmmac/dwxgmac: Modify DMA
 functions for future hardware
Message-ID: <aiZ9milz2xnxYBHM@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260605190210.13d9b18c@kernel.org>
X-CMS-MailID: 20260608083022eucas1p2ddbb690dd15bcc5297e83779ce13f694
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_10f6c_"
X-RootMTR: 20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28
X-EPHeader: CA
X-CMS-RootMailID: 20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28
References: <20260601162537.553512-1-j.raczynski@samsung.com>
	<CGME20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28@eucas1p1.samsung.com>
	<20260601162537.553512-2-j.raczynski@samsung.com>
	<aiAULX7SlidVGmhq@AMDC4622.eu.corp.samsungelectronics.net>
	<aiAiAbasQA3B3aT_@soc-5CG4396X81.clients.intel.com>
	<20260605190210.13d9b18c@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296417-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:larysa.zaremba@intel.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-kernel@vger.kernel.org,m:k.domagalski@samsung.com,m:k.tegowski@samsung.com,m:cs0617.lee@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96CCD654138

------FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_10f6c_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Jun 05, 2026 at 07:02:10PM -0700, Jakub Kicinski wrote:
> 
> +1, this feels a bit sloppy. The driver has some painful abstraction
> layers but if we cut ourselves some slack because of that that'd be
> basically encouraging shitty architectures.
> -- 
> pw-bot: cr
> 

Alright, will think about it.
As said in commit, problem is that current code really does assume
number of DMA=MTL=TC's and uses it interchangeably. So that was quite minimal
setup to get this stuff to work.
This is not longer true though for new hardware.
XGMAC 3.20a and 3.40a are fully compatible with dwxgmac2 as far as
I can tell, so new HW is generally supported with generic xgmac driver,
only some features are extra. And since there is no free space in some
registers, it should continue being that way.

Probably better solution would be to not change these functions to return
something, but rather check this in upper layer using synopsys_id or
whatever version. Will see what is more feasible.

BR
Jakub Raczynski

------FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_10f6c_
Content-Type: text/plain; charset="utf-8"


------FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_10f6c_--

