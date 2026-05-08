Return-Path: <netdev+bounces-286031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJt8CPpm/mlaqQAAu9opvQ
	(envelope-from <netdev+bounces-286031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:43:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5B4FC721
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D24B03040032
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BADE39E185;
	Fri,  8 May 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psAF8k4d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770863264F9;
	Fri,  8 May 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280169; cv=none; b=EUX9AtlKcwB4PpB2uc2p/YtlulboOFYmw3XgVJcsCVeif8blbo/QqCbTf4AWvykASynOsaHDcnfskK3yj2BVS/OX/H/fx8WQqaCmCkilL4uaVt6YZlob0v/hv2gPwh9iSeolnjMyDteSPlLQb1uheXpG2rqDebrv6vkodg33I+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280169; c=relaxed/simple;
	bh=y8p/nv8mwbshSRK8if8raXCz3A+5b7jtCmU2nYbxPGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4CLaWhby8F87sA/Z4GjHzmrKCsH1m2R/bcMYz5Im2fq0tB7q4aPs+KME5E+pwWRM8TUyVBc4sFcIeH/dH08kIXrTU6HfR/Na865uVOlmGV6PNjfHDyl0MeXRre4jWnKL3+LyK0X71NF88Eq47+0Ighe4D6dRbayc81dNfI+WoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psAF8k4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4714BC2BCB0;
	Fri,  8 May 2026 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280169;
	bh=y8p/nv8mwbshSRK8if8raXCz3A+5b7jtCmU2nYbxPGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=psAF8k4dXl22qKcoK5l5uyyeYNOrZRQzNa+nxMKSzraYjP3hhfTsMCt4emhyHPF+f
	 oF5KkafqPlcaMPl1llsZ5ZExS2n4BvnEA+cVNoX/iFzg9AocPQ7mkmot+bM479JuZi
	 xpOUNM82XQAhVCwUjMleUuK6Ema+HRIITrgYD+xzNQPd9eKQyl+M/aojK8JTg6Z2eF
	 OBW9uafvuqmuqwevWgkkhgp++0KChZ37G8qS8oR3K2SIB61ywB701GcUck3B471rO/
	 XCc80VikcOu89HCR+U4F8TCKHJm8CGu5Cmb34UmKQ7tyMYyesWkkIMdZPWePK1HAyb
	 vKbYVq/XDiuSg==
Date: Fri, 8 May 2026 15:42:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: alexjlzheng@gmail.com
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 hannes@stressinduktion.org, albinwyang@tencent.com, kuniyu@google.com,
 shenyangyang4@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH net v2 v2 2/3] macsec: use rcu_work to defer RX SA
 crypto cleanup out of softirq
Message-ID: <20260508154247.1bd84fe1@kernel.org>
In-Reply-To: <20260507020426.1126254-3-alexjlzheng@tencent.com>
References: <20260507020426.1126254-1-alexjlzheng@tencent.com>
	<20260507020426.1126254-3-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A6A5B4FC721
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286031-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu,  7 May 2026 10:04:25 +0800 alexjlzheng@gmail.com wrote:
> @@ -136,7 +137,7 @@ struct macsec_rx_sa {
>  	bool active;
>  	struct macsec_rx_sa_stats __percpu *stats;
>  	struct macsec_rx_sc *sc;
> -	struct rcu_head rcu;
> +	struct rcu_work destroy_work;

Please add a kdoc for the new field? (same in patch 3)
-- 
pw-bot: cr

