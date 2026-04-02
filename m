Return-Path: <netdev+bounces-274450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAy5GhpBzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:12:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D88FF387882
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B68D8302DE2B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC363D9DB4;
	Thu,  2 Apr 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Dby5lTAs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GyI+nYQi"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9113D9DA2;
	Thu,  2 Apr 2026 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124228; cv=none; b=CItqrc2YCFztJXF7lIa9vPnzoP+X0W7t77GgojzvNhx/J+YuzEfg0VhiRmjTkhcGazjq0MKxyOEWhHqj1UcT1tzWwsVGrlCq29ubsPmgC+sP2ssE7dOHjyUxvlUDkvTrJlZMkaG14R1r7gPqovsCgIgovyhkuwO2jAPKX8dZsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124228; c=relaxed/simple;
	bh=Es7mj+dqk9IjsLZgauQ941j3zmmFqxCxkCRxqLFw1Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkU4YKFE0GyoFF6J/trw5bveu8a443PL0d+bcXJvo3WIsCOq4O/secX7AbzyeIFto+zxF4NoFpvITcjomJtG54iBd/80Z6CO4gWZMRLnJ9Q7RKxGXGBVlGNR5v59R7i2Rs849VibycZpQGIBcg+5eLr8uGjklgsOLVeIiIieBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Dby5lTAs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GyI+nYQi; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 589CB140019B;
	Thu,  2 Apr 2026 06:03:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 06:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775124224; x=
	1775210624; bh=31BfsB1ksQ9uLm8RwHMSEtjdx9AbBKTp/giRFpN+ieY=; b=D
	by5lTAs5uIFRc0dRltUZT501i6C8SKOb28x4JPK0hhBzq6LRquHHeTCRfIq7e7Ms
	FLObI45C5BSHpp/wVwicbCilVKuBkLDl9CDSSaNB3AHrw/fcvDmzKXnbMcyGUDWQ
	9OMxmM8GZ05TYEhNdgROwVFBqAeLja3QhtvChWndT/T1e9Mkhp39nNMHJev/PwRf
	7/u7VG8H8NBSt7t9keE09Pz0/C+6O1+eHikqRDd0edsntqRld9qQHwvTKmH6cGDm
	Edpj6mMoEh5zNd11+eGdNPRMdl0cuza5sOf6if7PybMe9KbCdDx1xS36Nk2PieA9
	cy3FXNz1WFTbPYQIJQPgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775124224; x=1775210624; bh=31BfsB1ksQ9uLm8RwHMSEtjdx9AbBKTp/gi
	RFpN+ieY=; b=GyI+nYQi4zmJWUMXtGiTkXSbHQ9fSxVmRtQi+dZTtOpZ4GlB96S
	t6dMYdt/2HSfDEPKkvsgPy5Ucip++j89mVw381ZWoFlZfKdSivOeZGW7o0kjp6BL
	P3xtJkGW1vABEQJaZo6xdxse/4rmK7vPlyDpaiOlLWqfSfX2aE+Lx8FLO+XOqnss
	U6clEWHc7PDlXXodgXX6QusdwJQxjliRcJo+RJaM3gAyy8piQjXLaoVm6zrAN/Dt
	NmFK0Rc6Jsde6PuQWg5JgxzZ0Fj8Trj8NJ0Y6Su0jFGnMBxiqnTMf8waweZFan+E
	lG22FNH4rXhL+1kLHh7+sqbz0c4En2VXs2w==
X-ME-Sender: <xms:_z7OaT69qCoImun6Gasks2kNOrzS0FeDWZMSk_aLVPM4MTnY3WeyIQ>
    <xme:_z7OaaeEtC9ihT0HZkliIF5W16Bc-EKjTn3LuhVbnV3d9vHtdRsD17IBc-sAjcoRd
    FbPDJajCiykMeDzMhfqV4vlBEw2K3T4wrHuo64KUjiBdsiWRraW_jg>
X-ME-Received: <xmr:_z7OaZsbieEzAu5GWXdHo5JtgoGTCIGumncLmpItkinQtar9oGcivkSpb8LV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvuefffefg
    udffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomhdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvg
X-ME-Proxy: <xmx:_z7OaanUED5OBZfuSXKTJ-mgvZBlPC5BCwAJ1mdssCh5e3XKGDX43A>
    <xmx:_z7OacRvn-8c6zbBbNIfhc3m6kcpdk5kwZt1XwH5yPG_Yz0JLQGQ6A>
    <xmx:_z7OaQItZ5hnlUri5phthUqx6XV2wJIaxOnNauXq0CPIrmHEKY9nhg>
    <xmx:_z7OaWEXJk0caw5zX4rsGZT38tKde24--CfavIsKIQelsoi2XxxqGA>
    <xmx:AD_OabLjYK24TzQWeyKe2rBSwHd_mPbEjw-syrDOb7dOc5zQHMgHKPox>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 06:03:43 -0400 (EDT)
Date: Thu, 2 Apr 2026 12:03:41 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v6 1/4] selftests: Migrate nsim-only MACsec tests to
 Python
Message-ID: <ac4-_ZPJSlXV4Vmd@krikkit>
References: <20260330130130.989236-1-cratiu@nvidia.com>
 <20260330130130.989236-2-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330130130.989236-2-cratiu@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274450-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: D88FF387882
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-30, 16:01:27 +0300, Cosmin Ratiu wrote:
> -#
> -# test ethtool features when toggling offload
> -#
> -
> -ip link add link $NSIM_NETDEV $MACSEC_NETDEV type macsec offload mac
> -TMP_FEATS_ON_1="$(ethtool -k $MACSEC_NETDEV)"
> -
> -ip link set $MACSEC_NETDEV type macsec offload off
> -TMP_FEATS_OFF_1="$(ethtool -k $MACSEC_NETDEV)"
> -
> -ip link set $MACSEC_NETDEV type macsec offload mac
> -TMP_FEATS_ON_2="$(ethtool -k $MACSEC_NETDEV)"
> -
> -[ "$TMP_FEATS_ON_1" = "$TMP_FEATS_ON_2" ]
> -check $?
[...]
> -TMP_FEATS_OFF_2="$(ethtool -k $MACSEC_NETDEV)"
> -[ "$TMP_FEATS_OFF_1" = "$TMP_FEATS_OFF_2" ]
> -check $?
[...]
> -TMP_FEATS_ON_3="$(ethtool -k $MACSEC_NETDEV)"
> -[ "$TMP_FEATS_ON_1" = "$TMP_FEATS_ON_3" ]
> -check $?

Those feature comparisons are missing in the new python test. The rest
of the patch looks good.

-- 
Sabrina

