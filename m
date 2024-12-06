Return-Path: <netdev+bounces-149671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5E99E6C54
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A540188154D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D801F9424;
	Fri,  6 Dec 2024 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFV/TCXW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A901F03F6;
	Fri,  6 Dec 2024 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481190; cv=none; b=uzBJ8TKojQnTet+ZCk/vlEJ5EDPVUZfe15qBsS+lxvVR7QVBzYQ2BwLIs5+9NMI32igmU+Iln88Zy44MTnydiX7LeGZnnTWmB6olC2qi0KcYyfZfUa+gAaTa0g/SJWptfELdWrvl7bb2S0CmtfX49x14cyaMZgOD7Tk2kvBnrdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481190; c=relaxed/simple;
	bh=XuzOwpFB9sywQSU+4oMv/Zl63PkuoIPjymxIiQJreng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcWi1MUwxcIGFZvQBabCN3MMcCj5PvzKv7Vc3pOTjOkbWhugglR4dvPHWR534rFsndesn/dOj77jvxh8UcZRn1PSfGNmOiihIrQzH5PF0llGAfXSth0XC5rw94lkyYdc5ELkQVhsbJLlNwv8teLpCoW9MFfN8GctNoY59ykyytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFV/TCXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4779BC4CED1;
	Fri,  6 Dec 2024 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733481189;
	bh=XuzOwpFB9sywQSU+4oMv/Zl63PkuoIPjymxIiQJreng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFV/TCXWSx7XOt66H991/1PpIX/WCc5At1/hNxEwTuSlZMdlcuDkORPjhTTRIedPJ
	 AnZAo9lUxC1jRONO6yKbX+A/KwfppAimbStyhjeu3Yq2K4LtasH+jhCxTD1qfjoFBS
	 YuF8wfG2RMFoMROXCfYGXgPglwIymc1xG1hc2U6Fwz84q8qUzJkEUovflBUoAhw0ez
	 +hdcP5HGiw42X9Y5Uk5bCFJpbBlEFBPLg45fpwDqbEub/FVmTkl6/DawPWCrFbSUxi
	 UsZcXGVSMCWP98h6I3thXdtkeXgdE0QG5mdrAdqCG2yDOlvIEgKDVVg0xdOTP0kc74
	 RPiOxim3O0rFg==
Date: Fri, 6 Dec 2024 10:33:05 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, frank.li@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 RESEND net-next 4/5] net: enetc: add LSO support for
 i.MX95 ENETC PF
Message-ID: <20241206103305.GL2581@kernel.org>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-5-wei.fang@nxp.com>
 <20241206095938.GJ2581@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206095938.GJ2581@kernel.org>

On Fri, Dec 06, 2024 at 09:59:38AM +0000, Simon Horman wrote:
> On Wed, Dec 04, 2024 at 01:29:31PM +0800, Wei Fang wrote:
> > ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
> > and UDP transmit units into multiple Ethernet frames. To support LSO,
> > software needs to fill some auxiliary information in Tx BD, such as LSO
> > header length, frame length, LSO maximum segment size, etc.
> > 
> > At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
> > CPU performance before and after applying the patch was compared through
> > the top command. It can be seen that LSO saves a significant amount of
> > CPU cycles compared to software TSO.
> > 
> > Before applying the patch:
> > %Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si
> > 
> > After applying the patch:
> > %Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si
> > 
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > ---
> > v2: no changes
> > v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
> > v4: fix a typo
> > v5: no changes
> > v6: remove error logs from the datapath
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c  | 259 +++++++++++++++++-
> >  drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
> >  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
> >  .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
> >  .../freescale/enetc/enetc_pf_common.c         |   3 +
> >  5 files changed, 304 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index dafe7aeac26b..82a7932725f9 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -523,6 +523,226 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
> >  	}
> >  }
> >  
> > +static inline int enetc_lso_count_descs(const struct sk_buff *skb)
> > +{
> > +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
> > +	 * for linear area data but not include LSO header, namely
> > +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
> > +	 */
> > +	return skb_shinfo(skb)->nr_frags + 4;
> > +}
> > +
> > +static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
> > +{
> > +	int hdr_len, tlen;
> > +
> > +	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
> > +	hdr_len = skb_transport_offset(skb) + tlen;
> 
> Hi Wei,
> 
> I am wondering if packets that are neither TCP nor UDP can be process
> by the LSO code added by this patch, and if so, what the implications are.

Sorry, I now realise that the answer to that is rather obvious: no
due to feature flags. I should have paid more attention to patch 5/5
before sending the above.

> 
> > +
> > +	return hdr_len;
> > +}
> 
> ...
> 

