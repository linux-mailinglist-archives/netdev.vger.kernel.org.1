Return-Path: <netdev+bounces-277299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDwwMn+y2Gk8hAgAu9opvQ
	(envelope-from <netdev+bounces-277299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:19:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2543D3E84
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D263019F05
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D03AB272;
	Fri, 10 Apr 2026 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iy1Mfw/9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0553AB284;
	Fri, 10 Apr 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808973; cv=none; b=s12kwv++nMvXDzSLkFq9jsOqUW9LyqMbjxM1Kgq833iZYv04BxvSLpfGjscL+qVRIYWSrLPY18gvkRtZiT+D+8QnnwNZQT8wCozsg7WARDIWT3b1n6GmAGsQOBWmnlEIHj4GN3L4fhX+N1AyJIe24XsbgxI1GrRh17Y58WVcOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808973; c=relaxed/simple;
	bh=FlkvDopMbw59+z0XdHrMqtDa5KxFChBVJQJSz0U20X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBjimSYPj8moeW0RqsFevU3LtJFbYOfR36Ws81l0QQ2Cj4SisV8AkOxne9eJaLgj0diAHw0XnNbP5F47BQePa0FjdGe7VBEpvBm7zJ9lfzi0KFeojcjB2w8Uk0I5UKJ/IobdA/mWybv8y9BhFukYzUbu+yf7V5VrNYoMge33Pqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iy1Mfw/9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775808971; x=1807344971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FlkvDopMbw59+z0XdHrMqtDa5KxFChBVJQJSz0U20X0=;
  b=iy1Mfw/9W/spgURQjZP9GawPmcpBRAOvQT5FQBqDv2dav2QoTCF7FgtW
   rijUKIY4mm4Xj85qef32QiYD0A+GFc+a8rjIjqOkrmPgbZESjV/w/qF2w
   DQtgqVEOHL4Y1Kb9e2UAjQOh7kQHrAHZaVWTW2dzfb7czWPXB5/wEKBx7
   l/Konie33ccOmSI21baQVTOqWRMXStSdhR29qSEpLoSf+nZMHgFnNAv8Q
   XWKm6Mnj9/K9LT5faEsC/KCYvQJxPKcyLH25W3+1I0MReeiAyz2XTVFs/
   IfLMd7n18dXk9FbcHQLSnDlx/JdYHTlr+4edjeb0M5hShfC6oTI1AmBjP
   g==;
X-CSE-ConnectionGUID: VcYCsOj8TkGNfcBuVHfwLg==
X-CSE-MsgGUID: usFxe9ObTTm0ikzPnzPR0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76715073"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76715073"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:16:10 -0700
X-CSE-ConnectionGUID: GIvxrKJuT6K0PufgwPoptQ==
X-CSE-MsgGUID: lxTmbZwsRLa7jymHZyxuzQ==
X-ExtLoop1: 1
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.31])
  by fmviesa003.fm.intel.com with ESMTP; 10 Apr 2026 01:16:06 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: linux@armlinux.org.uk
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	khai.wen.tan@linux.intel.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	ovidiu.panait.rb@renesas.com,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	yoong.siang.song@intel.com
Subject: Re: [PATCH net 1/1] net: stmmac: Update default_an_inband before passing value to phylink_config
Date: Fri, 10 Apr 2026 15:53:41 +0800
Message-ID: <20260410075341.5806-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <adirrTJujEsrsK4F@shell.armlinux.org.uk>
References: <adirrTJujEsrsK4F@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277299-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,intel.com,linux.intel.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,bootlin.com,gmail.com,renesas.com,redhat.com,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 2B2543D3E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell,

Thanks for the review. I will address the comments in v2.

