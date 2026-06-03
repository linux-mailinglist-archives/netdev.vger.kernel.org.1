Return-Path: <netdev+bounces-294549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id icT3FsO2H2rCowAAu9opvQ
	(envelope-from <netdev+bounces-294549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 07:08:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6AE634370
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 07:08:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=AMc2EX7s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294549-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294549-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF0483097F76
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 05:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14CD36AB56;
	Wed,  3 Jun 2026 05:08:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6130AD0C;
	Wed,  3 Jun 2026 05:08:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780463296; cv=none; b=FX4vNEeKAZkjcU3Subt7fVGaB39LXJ9lVj5GMc7emVbToRDdfdbePLtMKvR23pBgLjl7PcKW3v+zU663oNneaI22zh4lzLMteguTX1M+LxcjDTINqlyx0VMOyxxevAZ1MFtkKygQZw9T5R17gbpxuI9WOC2io/fq2v68/GoLXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780463296; c=relaxed/simple;
	bh=WYc5Tzd+eZ9eGvvfRd6F7VTYBVKX+VNW7i7+uzj6FVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6zY3jTTSjz7kjvCk8uDUoaX4qqPE5ZBLsu1kwdwDyV7iL499ymRT8XfASVEyQvGydbZdb6BSVPQi9qOpIGL+Pa4go7rRH2x9DU6lz4IRlFp69GjiQoorxRqYWIKbr7jpUtg5qvVkaFqMuS2pziUdKR6rcUwas9wCu/h6nq4+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AMc2EX7s; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652NRcKD023755;
	Tue, 2 Jun 2026 22:07:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=5eQENOO6sKs86U0uX0xY88q9C
	c+hze9tj3mFULNqykg=; b=AMc2EX7sWMxZOpGvGbejWMB0ObwORME5dceAmlvb1
	IvSgNzekKRdDxzI9WAOeMxrkbY27LiT7lz2g01IP6mWMvfj28prahHBcoU/DjAqX
	MwMfP5/CjEJV8dVnm6yS4dZYelQVjN7oplKGcbvYS1Ep484bmm3dQe51LcMXDGJi
	Ys0AiZCZmigpkerG4nB7+ovOR+DNFz/0Ids+OW7ukGSn7p49mnjPDc8Rp/y+V0fc
	31UXZhGvSibmnvU/xk35nsq9CrV1EE1jR7EgdqgrP8jtWWLtuNfBaVbsFp1acc0a
	z2vma377mSuQWNosnxgi+3kAdRtLFlWWF+9vgDWS/tjBw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ej8v98xn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 22:07:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 22:07:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 22:07:53 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 50BCF3F708D;
	Tue,  2 Jun 2026 22:07:49 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:37:48 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <naveenm@marvell.com>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Nithin Dabilpuram
	<ndabilpuram@marvell.com>
Subject: Re: [PATCH v2 net] octeontx2-af: npc: Fix CPT channel mask in
 npc_install_flow
Message-ID: <ah-2pHqi1dpsdmB7@rkannoth-OptiPlex-7090>
References: <20260602045853.1558530-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602045853.1558530-1-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: 6d3EHUXegEUAPdyef5xpW9MMODweyB79
X-Authority-Analysis: v=2.4 cv=JNQLdcKb c=1 sm=1 tr=0 ts=6a1fb6aa cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=YThyNGSxP4xWRHlZjwkA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA0NCBTYWx0ZWRfX7a2GHjy+IUie
 ayNVk1kAEqIpYVTNzVxYHvQ0q79oUOKRVg/Qv5vh/cqlFYrzm6wrZylVRNMEkESi7Xb9bGhngE0
 tvhGTVYe6Tk8S9b5Fl/yDYhfCXbxR1TYExZyUqOAK3NU1iMlOs1w6Gy8DSzMsTLNqJJ75rE7lyH
 6EyTd/rA6V/2lj2Ywq4mEZ7KdEeqwHIjP23MR3CyQeDfVZN+zrYjmYz89bI2hMVLhVilQowKVUR
 YCO6USf9XZ6u0AMNFMluEYom6bVoaqC04YzsABNpQGO2VC8baxsfDSrsM3dkNS+jn9g5ZXeqMIJ
 IaPiljp8kHSbEu0gzvRb0bqzj6EMMiN+ZMx2UpwXP6WhDA1sEvWL9EdPhh3MXYNL54aNHl1wsn/
 /U7j/Jb4AsdcQtpu0lWMUeqGsUOP6LzIJMZPqsYuh8uls1RcbQUFzNBc3R0Ry0z3ejE42l0S3tp
 /WjbxxKmJLMNmcHAafQ==
X-Proofpoint-GUID: 6d3EHUXegEUAPdyef5xpW9MMODweyB79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:naveenm@marvell.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:ndabilpuram@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF6AE634370

On 2026-06-02 at 10:28:53, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
>
> Use the CPT-aware NIX channel mask in the npc_install_flow path so that
> when the host PF installs steering rules in kernel for a VF used from
> userspace (e.g. DPDK), MCAM entries see the same channel mask semantics as
> other RX paths.
>
> Fixes: 56bcef528bd8 ("octeontx2-af: Use npc_install_flow API for promisc and broadcast entries")
> Cc: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---

https://sashiko.dev/#/patchset/20260602045853.1558530-1-rkannoth%40marvell.com
sashiko says:

> -	/* For cn10k the upper two bits of the channel number are
>> -	 * cpt channel number. with masking out these bits in the
>> -	 * mcam entry, same entry used for NIX will allow packets
>> -	 * received from cpt for parsing.
>> -	 */
>> -	if (!is_rvu_otx2(rvu))
>> -		req.chan_mask = NIX_CHAN_CPT_X2P_MASK;
>> -	else
>> -		req.chan_mask = 0xFFFU;
>> -
>> +	req.chan_mask = rvu_get_cpt_chan_mask(rvu);
>>  	req.channel = chan;
>>  	req.intf = pfvf->nix_rx_intf;
>>  	req.entry = index;
>This isn't a bug introduced by this patch, but should the channel mask
>also be updated in rvu_npc_install_bcast_match_entry() and
>rvu_switch_disable()?
No. we dont need this in bcast and switch_disable().

