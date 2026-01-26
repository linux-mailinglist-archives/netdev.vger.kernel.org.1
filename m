Return-Path: <netdev+bounces-253427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFBsAv5Jd2mLdwEAu9opvQ
	(envelope-from <netdev+bounces-253427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:03:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7280987764
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA6BD3019FCE
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4DC32AAB3;
	Mon, 26 Jan 2026 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXh8D1bI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0170238C15
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425283; cv=none; b=f+UPIJuikOhXzpkPLaExWGrjDfapMqrd0UJSTo8KZKQSeWOjUotQ88heYTxRAFhW/PnDCgoLyeR84kyhk3BJimF2A+N7EqyHWK00IWqv/yIMcFVo6NMWZUZeLSoeRyv+G6SQtqWUtSSXCjmhLHF+LuTn9nyZU/1NWRh7Z62u9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425283; c=relaxed/simple;
	bh=63TN7QkZFEfpjv3JCIQCeLZhAYXlS3k1CkWWAp/J7Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W45aIADWnPRgLodUiHCkNxALNMHPSgarofGuj5w2CVVdMrzHGeJaWBRX3fIjVyIg179JduO/pwBjOPuO9aBpzODpRny+U4qyRccErqeQMd00fs37pZ3UliO9tnDy5xNA0XJ3AVVWQYSM6XllSTIZY+B7Udqcb0fi68LW3rjogok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXh8D1bI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354F8C116C6;
	Mon, 26 Jan 2026 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769425282;
	bh=63TN7QkZFEfpjv3JCIQCeLZhAYXlS3k1CkWWAp/J7Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXh8D1bI1mTXEW0Y0Eoa5tzXUgVWZsB9ygK+gp76mzHVBTYVx2AkipxEeCsdzGkLz
	 r7C87jtd8YGiWP160roI8zhB0GQCtAnkHFEevyq/GFXXFT0nOqhGV4aMTDzUL/p7jo
	 3WPr44xRNljALRQbOK+6GBjP0vnlW+ny/WOlw57UUGcZKILMu7eZLzWoP1ROG0uptN
	 AMtSCQ5mFAdf8VZfjJD/0enoSNKq5fOHUd9whUmaFyNFWs4ZuPdlZQnB592ogufBF2
	 J9aXoMOLWp9PI102j6Ht5V97DBbT/XOAifA3hnYRSEoRyo3FA9t/SAcEi1BvM2qKyx
	 hXRugYFKcHDfw==
Date: Mon, 26 Jan 2026 11:01:18 +0000
From: Simon Horman <horms@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v2 1/2] ixgbe: e610: Convert ACI descriptor
 buffer to little endian
Message-ID: <aXdJfu8Lml_dnjd3@horms.kernel.org>
References: <20260122164632.112607-1-piotr.kwapulinski@intel.com>
 <aXPU4YQi73T088lS@horms.kernel.org>
 <CO1PR11MB508945D598B6284773B6E9E4D694A@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB508945D598B6284773B6E9E4D694A@CO1PR11MB5089.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253427-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,mpg.de:email,linaro.org:email,osuosl.org:email,horms.kernel.org:mid,pf_hicr.sv:url]
X-Rspamd-Queue-Id: 7280987764
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:41:26PM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, January 23, 2026 12:07 PM
> > To: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org;
> > dan.carpenter@linaro.org; pmenzel@molgen.mpg.de; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>
> > Subject: Re: [PATCH iwl-next v2 1/2] ixgbe: e610: Convert ACI descriptor
> > buffer to little endian
> > 
> > On Thu, Jan 22, 2026 at 05:46:32PM +0100, Piotr Kwapulinski wrote:
> > > The ixgbe device registers/descriptors expect little-endian ordering. Make
> > > the code aware that the e610 adapter operates on data with little endian
> > > ordering. The extra conversion is required on big-endian hosts. In most
> > > scenarios this conversion is not required.
> > >
> > > Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command
> > Interface")
> > > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > > Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > > index c2f8189..f494e90 100644
> > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > > @@ -113,7 +113,8 @@ static int ixgbe_aci_send_cmd_execute(struct
> > ixgbe_hw *hw,
> > >
> > >  	/* Descriptor is written to specific registers */
> > >  	for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
> > > -		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
> > > +		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i),
> > > +				le32_to_cpu(raw_desc[i]));
> > 
> > IXGBE_WRITE_REG is backed by writel.  And my understanding is that writel
> > converts values from host byte order to little endian.  So I'm confused
> > about where this is going.
> > 
> 
> Yes, it should. In this case, the raw_desc value is being converted *to* CPU order to work with writel... 

Yes, sorry. I seem to have completely confused myself there.

> > >  	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
> > >  	 * PF_HICR_EV
> > > @@ -145,7 +146,7 @@ static int ixgbe_aci_send_cmd_execute(struct
> > ixgbe_hw *hw,
> > >  	if ((hicr & IXGBE_PF_HICR_SV)) {
> > >  		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> > >  			raw_desc[i] = IXGBE_READ_REG(hw,
> > IXGBE_PF_HIDA(i));
> > > -			raw_desc[i] = raw_desc[i];
> > 
> > I'm also curious to know what the intent (if any) of the line above was/is.
> > 
> > > +			raw_desc[i] = cpu_to_le32(raw_desc[i]);
> 
> 
> It's being converted to LE32 order here. But if nothing else touches raw_desc is there any reason to convert??
> 
> > 
> > Please don't use the same variable to store both host byte order and little
> > endian values.  In this case I'd use another local variable, say scoped to
> > within this block, to store the intermediate value.
> > 
> > And if raw_desc will be used to hold __le32 values, it's type should be
> > updated.
> > 
> 
> If I understand Simon's comments correctly, this whole change is a no-op, and unnecessary. Writel and readl already handle conversion to CPU format, so unless you have some issue because raw_desc is assumed to be LE32 somewhere else, I think this patch should be dropped. If you do have a real case where something was wrong, can you please provide details?

Sorry for not being clearer.

I'm suspecting that the issue that this patch tries to address
is that the backing structure, struct libie_aq_desc, is described in terms
of __le integers.

I haven't dug deep enough to be able to say if that is a good approach or not.
But if that data is __le, then I expect that some sort of conversion along
the lines of this patch makes sense.

