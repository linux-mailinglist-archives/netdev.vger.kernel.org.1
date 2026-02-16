Return-Path: <netdev+bounces-258850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B+AJoTokmlSzwEAu9opvQ
	(envelope-from <netdev+bounces-258850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:51:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3122D142142
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97FDF3016810
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26292EF665;
	Mon, 16 Feb 2026 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKrUyLK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2A2EDD69
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235448; cv=none; b=f9U+ZDT4wINbDFXeLPL6cwkGn0GT8PS/hC2WGVR5PZSvmM8+m9cLJAQyO759RGM0MqXZwUsDvIsgDrLlAi8Kb5BUpQp7z08MWHkra7/8tCz5uDV769/HUTu2RghCTfGkl562C/fLeDSTypSl6wGxf0SU1ajoCOcp2r4l7NzsdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235448; c=relaxed/simple;
	bh=MwWFjpb1C+eOhzKyQeFDWoURC8HYjjTPP6Wc+G77Bq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvPq50eB4lloyy8Ih90rQSKpVvE2NWR5kCIRpT5eKjBoV6AdmsOzIEuyipE2yOilJXNDYilewXBHlxl0DRuivow02TYujWMAizhwSqfq1GWgJ6yp8x0D8fW3U24sf11jarWv/Fg+uo+96shSJYxhVGsxBVgu3DwNhHcWO13ZjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKrUyLK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2BAC116C6;
	Mon, 16 Feb 2026 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771235447;
	bh=MwWFjpb1C+eOhzKyQeFDWoURC8HYjjTPP6Wc+G77Bq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKrUyLK44/9uaqJs/pgx/NLvTJrhpGuj7l9ECuOkQqIgxoNnSviLXGZEdM1oPtXK6
	 MXin4UOBzV8koqPc0T6lwxz/GscMAicdLpNWLBoihzsCKZdJIfo/1jNebJPXe4PnKo
	 7VLnyyZvLwaRKQIV288K34y9aPhd2nAG2qU2E9pYWs7h3RADKQqGP5iFIsCq/Wlljj
	 P8fpK4i53GXa5DZNG0FPJBilE02g4XkOrlVH1N6qe8bzq/RYH9rTBDfFuy4/sXsS/x
	 VrsIW4rzJrZk1YL1g+6z7JoxEUepih40UK0+m8WLc2XdhbVsdGnnYKLAqIMxE4tC3K
	 qSTBz3rH0A/1g==
Date: Mon, 16 Feb 2026 09:50:44 +0000
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [iwl-next,v3] ixgbe: fix unaligned u32 access in
 ixgbe_update_flash_X550()
Message-ID: <aZLodORhpbrDPJaO@horms.kernel.org>
References: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
 <20260213151344.2513857-1-horms@kernel.org>
 <IA3PR11MB89860CF09BBD00129F59A4FFE561A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89860CF09BBD00129F59A4FFE561A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258850-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,osuosl.org:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 3122D142142
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 04:02:53PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, February 13, 2026 4:14 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: Simon Horman <horms@kernel.org>; intel-wired-lan@lists.osuosl.org;
> > Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; pmenzel@molgen.mpg.de;
> > netdev@vger.kernel.org
> > Subject: Re: [iwl-next,v3] ixgbe: fix unaligned u32 access in
> > ixgbe_update_flash_X550()
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-
> > local.html
> > ---
> > ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
> > 
> > This commit adds a u32 member to union ixgbe_hic_hdr2 to ensure 4-byte
> > alignment on the stack, preventing unaligned 32-bit accesses when
> > ixgbe_host_interface_command() treats the buffer as a u32 array.
> > 
> > > ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
> > >
> > > ixgbe_host_interface_command() treats its buffer as a u32 array. The
> > > local buffer we pass in was a union of byte-sized fields, which
> > gives
> > > it 1-byte alignment on the stack. On strict-align architectures this
> > > can cause unaligned 32-bit accesses.
> > >
> > > Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte
> > > aligned, and pass the u32 member when calling
> > > ixgbe_host_interface_command().
> > >
> > > No functional change on x86; prevents unaligned accesses on
> > > architectures that enforce natural alignment.
> > >
> > > Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
> > 
> > Does this Fixes tag point to the correct commit? The alignment issue
> > appears to have been introduced by commit 6a14ee0cfb19 ("ixgbe: Add
> > X550 support function pointers") from 2014-12-05, which introduced
> > both the union ixgbe_hic_hdr2 without a u32 member for proper
> > alignment and the
> > ixgbe_update_flash_X550() function that passes this buffer to
> > ixgbe_host_interface_command().
> 
> Commit is correct, please configure your AI to look all the history of the patch, where I explained that it was a 0 day issue.

Sorry about that. I did look over this myself, but I guess I must
a have forgotten to look over the patch history at the time.

...

