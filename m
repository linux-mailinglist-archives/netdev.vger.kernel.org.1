Return-Path: <netdev+bounces-252779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAuQLl9Lc2lDugAAu9opvQ
	(envelope-from <netdev+bounces-252779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:20:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A43743A1
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B21683024100
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B540366819;
	Fri, 23 Jan 2026 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj/LdxF3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C833A9C5;
	Fri, 23 Jan 2026 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163141; cv=none; b=RjnooO3OawixJOILY+Gtd786ijMKapOOaWFC2poUxLIjO1eTqZjldGDWBjMpw/8R8q1WYJxvLQqSdfy5I/4hceE3RgE++W/tvyU1P94OHNUmN/b3CSAWHhU7HJEK2MLBNMSLCedUv2sWlL1DzExxWi9ElY+ZSrMxa4GoqFc7i5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163141; c=relaxed/simple;
	bh=Rs3+J9vly3EX1QkycoNIipTzcrq6Sl9s200nzYCGxDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmaqAYTZgvS5PFH6T8vTXLOukE+QgXU+nToxqJMljR7efTYChmYH2OBv33oaNCaOdCZvPAJ4fhvqI7tWzA6z0XSrJ7bF+QyIZadTuv1seS3hYBBQUYF+TNgUfF1iA5ttCR/VtgRvDOCOuBX49SP6R6kjqt/y/luwSqEcn5vXrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj/LdxF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36331C4CEF1;
	Fri, 23 Jan 2026 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769163141;
	bh=Rs3+J9vly3EX1QkycoNIipTzcrq6Sl9s200nzYCGxDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cj/LdxF3Fsu/SGpfZdF24FP4C+lzIKjq8qs6dXzoJaYBJnE/rzc13e6W1vCJ37Mo1
	 c1m66pANSmZviUS51kES2Twe5cI02pyI0AmT2EDqgFl7yHfHfh9iCVn75r54XCVzFm
	 iTD+BJJCjXra/jnzCidwJ/DrItSo79TZifqu4rjUiSkqpJA+aJEUtuPYDbDxK89lno
	 N0d7MteUWt1jAldAVfFr/qgPVy5hOwJUfTAAMBYI+hfp6Z4YePli/K/j33Xkx7/oUJ
	 vBCOx7Ul1+5Ge7O3Nrzz4O4cbFdyybkmRY2u72jiIVaW4vw7iZ5rK8kITbXr7CPF1r
	 nTxLaC/MZ6ptw==
Date: Fri, 23 Jan 2026 10:12:15 +0000
From: Simon Horman <horms@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/8] net: dsa: microchip: Add KSZ8463 tail tag
 handling
Message-ID: <aXNJf98EW7knlYkD@horms.kernel.org>
References: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
 <20260115-ksz8463-ptp-v1-5-bcfe2830cf50@bootlin.com>
 <aW-4qgp0mGNPNiau@horms.kernel.org>
 <4f36ca91-9749-4502-bc30-838238d24ba3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f36ca91-9749-4502-bc30-838238d24ba3@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,se.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 43A43743A1
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 01:59:21PM +0100, Bastien Curutchet wrote:
> Hi Simon,
> 
> On 1/20/26 6:17 PM, Simon Horman wrote:
> > On Thu, Jan 15, 2026 at 04:57:04PM +0100, Bastien Curutchet (Schneider Electric) wrote:
> > > KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
> > > use the tail tag to convey timestamps to the host as KSZ9893 does. It
> > > uses the reserved fields in the PTP header instead.
> > > 
> > > Add a KSZ8463-specifig DSA_TAG driver to handle KSZ8463 timestamps.
> > > There is no information in the tail tag to distinguish PTP packets from
> > > others so use the ptp_classify_raw() helper to find the PTP packets and
> > > extract the timestamp from their PTP headers.
> > > 
> > > Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> > 
> > ...
> > 
> > > diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
> > > index 9170a0148cc43b4213ec4bd8e81d338589671f23..635679402f8a96b29536a91988346a8825bae976 100644
> > > --- a/net/dsa/tag_ksz.c
> > > +++ b/net/dsa/tag_ksz.c
> > > @@ -16,6 +16,7 @@
> > >   #define KSZ9477_NAME "ksz9477"
> > >   #define KSZ9893_NAME "ksz9893"
> > >   #define LAN937X_NAME "lan937x"
> > > +#define KSZ8463_NAME "ksz8463"
> > >   /* Typically only one byte is used for tail tag. */
> > >   #define KSZ_PTP_TAG_LEN			4
> > > @@ -383,6 +384,108 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
> > >   DSA_TAG_DRIVER(ksz9893_netdev_ops);
> > >   MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893, KSZ9893_NAME);
> > > +#define KSZ8463_TAIL_TAG_PRIO		GENMASK(4, 3)
> > > +#define KSZ8463_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
> > > +
> > > +static void ksz8463_xmit_timestamp(struct dsa_port *dp, struct sk_buff *skb)
> > > +{
> > > +	struct ksz_tagger_private *priv;
> > > +	struct ptp_header *ptp_hdr;
> > > +	unsigned int ptp_type;
> > > +	u32 tstamp_raw = 0;
> > > +	s64 correction;
> > > +
> > > +	priv = ksz_tagger_private(dp->ds);
> > > +
> > > +	if (!test_bit(KSZ_HWTS_EN, &priv->state))
> > > +		return;
> > > +
> > > +	if (!KSZ_SKB_CB(skb)->update_correction)
> > > +		return;
> > > +
> > > +	ptp_type = KSZ_SKB_CB(skb)->ptp_type;
> > > +	ptp_hdr = ptp_parse_header(skb, ptp_type);
> > > +	if (!ptp_hdr)
> > > +		return;
> > > +
> > > +	correction = (s64)get_unaligned_be64(&ptp_hdr->correction);
> > > +
> > > +	if (correction < 0) {
> > > +		struct timespec64 ts;
> > > +
> > > +		ts = ns_to_timespec64(-correction >> 16);
> > > +		tstamp_raw = ((ts.tv_sec & 3) << 30) | ts.tv_nsec;
> > > +
> > > +		ptp_hdr->reserved2 = tstamp_raw;
> > 
> > I think that you need to assign a be32 rather than a u32 to reserved2.
> > 
> 
> Indeed. By testing this back, I realize that this is only needed by the
> one-step mode. This series only adds support for two-step so I'll just
> remove this part.

Great, thanks.

