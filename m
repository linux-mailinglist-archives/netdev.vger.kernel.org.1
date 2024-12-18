Return-Path: <netdev+bounces-153070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC249F6B7E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388B6188BB72
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0E01F7577;
	Wed, 18 Dec 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWIAWqC6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402911FA8F8
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540628; cv=none; b=jrNSGgtIOfvj+O3QXc+MUfbA6/hGGIzIkAsVkvSB6OyNcLdemrTD4H/v+YJ83Y4twp3fMW/gQV6KQUrPgTmtgnuf5fiWZ2hhJJnqFIdJwwW+h0ImAGa/YZ63FSMSCccDUwOJWkp0w5hIYlzufvAP5+nn61BwssE7h901eGkPVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540628; c=relaxed/simple;
	bh=xAMGpVL6RuB1YICsqOfqmB2N/jHlEoCcl+7bOPfIuLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLDqst5wI9AwrrBoP+sUw14c768wtOz0Na0WDzZOMXDEVsyb8sbVHdxPEmkpQ4oWVyWynvqM18RSsnA/NdHDnD4dfNv35FjO67Wv8AEbVJVmAIDFT1eHPHf2565+DNwJN4rDD2+mr1je/5cCA0acOO9V+o9mGgjH0u+Sgapxt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cWIAWqC6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4258F11401AD;
	Wed, 18 Dec 2024 11:50:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 18 Dec 2024 11:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734540625; x=1734627025; bh=SdUE0ulVHexkh7fJyafYOpFD0x2zK9okKIk
	rIy5EBpY=; b=cWIAWqC6igb+VuaWE36tzWVe2MWS1Uy96kgy1HXUyyOUaHXXWtV
	MyTf925mpAFaLXDH6Qsb2vTLjEQt+RSXKQbITvT9O8dUgKXkakpZVuCjQPjkeDx2
	O1PO/ASRQUe4NItGEV7QduE6v72UpG4M24xpfXZqlczoPwmHvK5o2+24b/uWbqWF
	+WeAShEH7Jo5QaG5HfvFz4PGBT0wcvQFhw0y2MXHpicLoNZIqJ7UcCofZziV9d2F
	CNP80WKMQyzMuIJ9k3sAu99AfexLX3r2uEFLVRGrFjOcC3p+RQsSnRZO+8/6xkXU
	IyPaktSoge9VkyNYUVnlxsWVLKMInwmgRrg==
X-ME-Sender: <xms:UP1iZ34sTbylMJx13DN0WofzWYUND0616s_pE33HrN-y15gBMai7Qw>
    <xme:UP1iZ85B8xKWIc_mbNA9O7toJl5Ix5H4sJ-Qb9tkmPPovBZfM1Fvwzwv626GxpdDc
    As9mrgC-cVOfXQ>
X-ME-Received: <xmr:UP1iZ-dw-uNg995cOpYF6nRPv4vblZSRrPUGajfHkYEqwxxYJumgG2VDXxWi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhrvghnuggvtgesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdp
    rhgtphhtthhopehrohhophgrsehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhiug
    hgvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:UP1iZ4II6b6L-gEzDakbYgwCv-wDo9MpbMBdsWP1nCdtDN2tJYVQzg>
    <xmx:UP1iZ7Iv-XYixM7cHWcXQRIZdT99bEbjKXpk-o64TW4Wp2KjPSFybg>
    <xmx:UP1iZxzX8V0kcTynI-zbJhnXLoBrsl5os5dzm5Ol_qp1BhG2M5NuZw>
    <xmx:UP1iZ3JQqU8yfrOMxbjIgWsenRGaRuDzweQyBoAQIy1Jtv0oUWHQ2w>
    <xmx:Uf1iZ8VNOQOkP9LrWQkqoYWObr80S7vZiTjp-PrlR_rtKY1VmPvqjXz5>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 11:50:24 -0500 (EST)
Date: Wed, 18 Dec 2024 18:50:20 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Radu Rendec <rrendec@redhat.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 1/2] net: vxlan: rename
 SKB_DROP_REASON_VXLAN_NO_REMOTE
Message-ID: <Z2L9TFL0dWJn_D-M@shredder>
References: <20241217230711.192781-1-rrendec@redhat.com>
 <20241217230711.192781-2-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217230711.192781-2-rrendec@redhat.com>

On Tue, Dec 17, 2024 at 06:07:10PM -0500, Radu Rendec wrote:
> @@ -497,8 +497,8 @@ enum skb_drop_reason {
>  	 * entry or an entry pointing to a nexthop.
>  	 */
>  	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
> -	/** @SKB_DROP_REASON_VXLAN_NO_REMOTE: no remote found for xmit */
> -	SKB_DROP_REASON_VXLAN_NO_REMOTE,
> +	/** @SKB_DROP_REASON_NO_TX_TARGET: no remote found for xmit */

Looks good, but I suggest replacing "remote" with "target" since
"remote" is VXLAN specific.

> +	SKB_DROP_REASON_NO_TX_TARGET,
>  	/**
>  	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
>  	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
> -- 
> 2.47.1
> 

