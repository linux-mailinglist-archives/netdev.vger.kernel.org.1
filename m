Return-Path: <netdev+bounces-256870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCj6KNrOg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:57:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C119ED22E
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EE2530117B6
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2441739A7EA;
	Wed,  4 Feb 2026 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HK44WUzM"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9B39901C
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245848; cv=none; b=NR2wlCuUTPPW6QMRFdfLl2LawN0MWc5PpGXLIoZZ0XPCAl/Yfpcj+4OLaplsgARys3h4gdz2aQItU6mnebgl40KeSwx+URgD4a/xi0dthNEl5UsG/+ztzMj4NxiTIt1Ja+Ng/8dZGwpEJALa8mrep6Io/zyhUUD7mPMx+duQN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245848; c=relaxed/simple;
	bh=NHd1asEpRG5L+/D4uyhSxZD5zxGYxW7LuIhpPgZMFGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZW1zgsXXADlMweD+2y9/DoCKbQZAnU1xc37dqgTTAP7A88eFHvJXsAhqtbBBrQDxRMaz/B7CCJLM5ih8EvK+3nNcd5uHIKKo13ZOOIxE03W6j7P3X46HXZrGkql84oY0UvaMYF+kTqi8RBOE+X/hfkhLyu55OSEq++0AuRDIfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HK44WUzM; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e7d4ff92-232c-4683-b235-aa1d75374be1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770245845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBt8lt8bM7kV+Zu3BUC89Q+Zy75+2GMxIq581jsCjw8=;
	b=HK44WUzMaWM8Rka/qoHOX77lnm8HDdtPBUdxnIbURLPeP2r0edD3WlO/hdKyb1NXjirVyV
	pTe9xU5s/rVYN8o8hce9VmqHqNZjTP4UW8FX/adILp4kA6iRHmrjC83/cHcmr0FmdMzX9u
	i7Yk3SOnv+meqKNARN6qxrWNqJ2IvVU=
Date: Wed, 4 Feb 2026 14:57:13 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 0/6] Address XDP frags having negative tailroom
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, Larysa Zaremba <larysa.zaremba@intel.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kernelxing@tencent.com>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, Eelco Chaudron <echaudro@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260203105417.2302672-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256870-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 1C119ED22E
X-Rspamd-Action: no action

On 2/3/26 2:53 AM, Larysa Zaremba wrote:
> Larysa Zaremba (6):
>    xdp: produce a warning when calculated tailroom is negative
>    ice: fix rxq info registering in mbuf packets
>    ice: change XDP RxQ frag_size from DMA write length to truesize
>    i40e: use truesize as XDP RxQ info frag_size
>    idpf: use truesize as XDP RxQ info frag_size
>    net: enetc: use truesize as XDP RxQ info frag_size
> 
>   drivers/net/ethernet/freescale/enetc/enetc.c |  2 +-
>   drivers/net/ethernet/intel/i40e/i40e_main.c  |  5 ++--
>   drivers/net/ethernet/intel/ice/ice_base.c    | 26 ++++++--------------
>   drivers/net/ethernet/intel/ice/ice_xsk.c     |  3 +++
>   drivers/net/ethernet/intel/idpf/xdp.c        |  2 +-
>   net/core/filter.c                            |  3 ++-

Jakub, can you help to take it to the net tree? Thanks.

