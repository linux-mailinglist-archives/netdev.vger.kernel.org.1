Return-Path: <netdev+bounces-307664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJREBLEeV2pTFgEAu9opvQ
	(envelope-from <netdev+bounces-307664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:46:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497B75ABDD
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:46:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=P7xPp+mX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307664-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307664-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 314EF3037F70
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB54D353A9E;
	Wed, 15 Jul 2026 05:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B830674C
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:46:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094382; cv=none; b=o+iZZv0dcbM+HvFL/jLRVv6jYi21nwDD3aSV7E+xFYsGc+bnD0YsqC+Vk3DYSuE0zrhNu8ZsFUrE8Z+kf4mdN1/lL/QE0zVawg6UFWchlLsY24FqjUJPkVzvmcrC7nd8pEIEQgc59aawJ+tMpHPq9YzkeDm8ocCe2+o+FpOL420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094382; c=relaxed/simple;
	bh=8w4wrmXPFzBzLWihNpLauxrKxi09MS/mQ4dCsI7xtSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdXGfM/C9EQ08WcOIA4te9yzJ7UsWHJ5N8TYRrrchwy/8J8nW03OUBXoqIuaCzTl+lCK8PQE/Syp6mKfSrUbpzyXOmDUU4lupzpbIxI1Rvlaa6CQQ7vISq21Rv2nq0NSJ0Wp+gk7g67QHXeyyqOYymnqycyfrgNvB45hDwIJ2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=P7xPp+mX; arc=none smtp.client-ip=185.125.188.123
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 935A03F61E
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784094378;
	bh=IoG1Whp3gfhDFJ0umUwcIOIJfD5L91Xz9sc0pOou7vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=P7xPp+mXbUEhruHoV7a+jX1u/PIuspN3CGYNetDZMRpmFordWnqQ6go4PteBc1M/o
	 Z5JkKwabJHkN81bNkudLJdpdsNfCPO91NLNFS0pEs2TwchK68t2LTzrx5zuri4H9vN
	 bfmXtAHPYp/6mGn5jv9dPJS4ESF9FuUbZb7HUA1pEJa71MwCToakOnBvXVyj7sPzVU
	 KFSy6eq4dgHL64+9jdgRBwn+RxUOaXHMc7CrmLDhFEjIZYiNHuKaNT4X4wZ0U9GT4t
	 LI8dDuKTZID5K05Ac8O5k6+YT2yPOvCo/b6t+2y4niTE+N0vFRSgwVGRWcbMbWl0dV
	 6Jk8sefcEYAP2GFvWJFWvSMet3Q00QAUgLDglQvdGXkCBu/HQ1O97lLRl0GqqZV7RK
	 Ko5dGfPjrFUqY+XhEQLPcmN3OdZ+GCgsvzIxwyaF+DjkmPy8fzNrAba+v1xNxSvV42
	 nw5Awz5mt5hCTwUqkSdabwLQ+S1b+yJfd9wU4GL0HNP7/BdhiUR9gd3ZT+rkmyL9ym
	 2cbOjEfyzVNIReqOwu6AW3Chki5JXr6jX/h+xh40j8cLz+siZJ/QiV+iKeOBqDaKL9
	 JGkfYfA2AZn0u9Q7ZdLOGX+XpIt5fmlyGwplXVKdo2ildXs06FrvXMns6Lw9fuH22d
	 0EU8E0LTH6BGjG5/jt1bkfKo=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e2237bc43so1903301a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094377; x=1784699177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IoG1Whp3gfhDFJ0umUwcIOIJfD5L91Xz9sc0pOou7vk=;
        b=eykYFqGTIoFGnkpzITGi9RcjYS9v/bw6PPzciYBvvk0XVDtaFngQyarnTpae8xt7Rb
         Bt75oN3Aft0j5WR88HQSVkktt9pGFxPhSpDn1L9rj+AhPgGECPKQkdeY36vrK7twB2SQ
         MdD0NCdCvBa+lDiZ8KRK3ZovtTs/gTkR4qw3t0IqUJ9tZmOL3LP7l1FyUmJcF0l92kM1
         UK3NynpBJQWlisx3jmGnmDyPCDi1AYLKM4LkcyMQQqgpLn26fwjBLOhJPMZUaucNqqFp
         l5uzQqtl7KQOaqKMW/R5u+Y8Lrr3EFS8LqJT9PLY1/kmEUBYvDQIPpzvrIKO0riqjYlH
         /F9A==
X-Forwarded-Encrypted: i=1; AHgh+RqRuG77P9A2V++4pkhNJub8HWlJ61jczxIFyO4eZvVq1joBce5wY0YGDZK5qbVqUSKwZl5djoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxto9TtW5hIUywt+vHVhNOZ0XEa3zC9Lu7fC3iaoAC0CAGplk8R
	pGArXtCoTEIRgFRcXPM2fu7uCPaSfNca9ZsfmP/1s4VZDMR16L1nCAnj24AI3yjsRMG59Br+Y/u
	a89bZUTU12V8GMnVOYhyOox9Rx7GqXhwRxGRq2tXZJZJ3WWTMj+F4h0ANEuWW0Q7j8TC+4oLevQ
	==
X-Gm-Gg: AfdE7clhfgmnMU71ZU5U/SCAeo5Pb/rCBrC/EzzCEPpVY4blb74eKxGp5TnzeD8CDuU
	qWV0YTVLnW3engc4+H5CkkE7sN9QMJn81V3WyehRLG2MFa+wQ8VA5Kl0FSynlOau+B/zZkHHrv7
	5XB9/sPAEHQjDiNnTbEfZf3BZSAubWEJhL0hA3rWefWi4Jx2SCq8W7aiNumrLxeyRG2Es5bIc2w
	HruSOznoKJpVKAZso5SbJDQ7fEASWTQNUsOB2Hfd7pQe3OCb9pshhVbuucshDHOn8I2LTfNxIq1
	CsFAZ/lAAGMni5GElujwN5ejyX+4xF59CCFmi8mbJowsGguXeR/HhHY5cYQRU4UO/ISHBz2F0sg
	I0fhFOCGonUDwTEPsZETX7U7wF3NAq3skyY9nlmXG1EWGvX5PQ0vID2lx8q9r8wVuhDk=
X-Received: by 2002:a17:90b:28c4:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-38e17db7bd5mr6184610a91.10.1784094376917;
        Tue, 14 Jul 2026 22:46:16 -0700 (PDT)
X-Received: by 2002:a17:90b:28c4:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-38e17db7bd5mr6184580a91.10.1784094376304;
        Tue, 14 Jul 2026 22:46:16 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm86874914eec.6.2026.07.14.22.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:46:15 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:46:09 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough
 after reset
Message-ID: <alcd_FnUdrQug5cm@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
 <IA3PR11MB8986B77F49DF672178FEE4BCE5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
 <c3030882-55c8-486f-8ff3-571d001b99a1@intel.com>
 <ajiHH-RaHUjgraMh@acelan-Precision-5480>
 <1d6c3aae-c9b1-42da-b5fa-6f8ee9ebcae1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6c3aae-c9b1-42da-b5fa-6f8ee9ebcae1@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307664-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[acelan.kao@canonical.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:dima.ruinskiy@intel.com,m:aleksandr.loktionov@intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acelan.kao@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,canonical.com:from_mime,canonical.com:email,canonical.com:dkim,vger.kernel.org:from_smtp,acelan-Precision-5480:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6497B75ABDD

On Mon, Jun 29, 2026 at 07:42:43PM +0300, Ruinskiy, Dima wrote:
> Hi AceLan,
>
> Some more comments below.
>
> On 22/06/2026 4:57, Chia-Lin Kao (AceLan) wrote:
>
> > >
> > > Because 100 iterations of 100msec each - this translates to up-to 10
> > > seconds, no?
> > Yes, just in case it takes longer.
> > I think 5 seconds should be enough if you feel this is feasible.
> 5 seconds also sounds excessive, assuming the majority of the systems do not
> support / enable MAC passthrough via the FW feature (and I have a hunch it
> is the case). 2 seconds... maybe, but then you say that in some rare cases
> it exceeds 2 seconds as well. What if in some even rare cases it exceeds
> 5/10 seconds? Perhaps because of some glitch it will not come up at all on
> this cycle. Should the driver always wait?
>
> > I wish we can detect if the MAC passthrough is enabled, so that we
> > know if we need to poll for the MAC address.
> Unfortunately, like you I am not aware of any way for the driver to know
> whether MAC passthrough via FW is enabled. Because of this we have been
> exploring a simpler way to support this feature via ACPI objects (which are
> set by the BIOS when MAC passthrough is enabled and are easy for the driver
> to query). I know some vendors have already implemented it, and I am
> currently drafting a patch to send.
Any good news about this patch?

>
> > For the FW interrupt mechanism also needs BIOS support, and we don't
> > have the power to push this.
> The mechanism I have in mind does not require BIOS support - the I225/I226
> FW already supports the required interrupt, AFAIK - it merely needs to be
> enabled in the igc driver. With that said, there still remains the question
> of how to notify the network stack above us that the MAC address has changed
> post-probe - and whether it is even supported.
>
> --Dima
>
> >
> > >
> > > Thanks,
> > > Dima.
> > >
> > > >
> > > > > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > > > > ---
> > > > >    drivers/net/ethernet/intel/igc/igc_main.c | 48
> > > > > +++++++++++++++++++++++
> > > > >    1 file changed, 48 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > index 2c9e2dfd8499..fa9752ed8bc5 100644
> > > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > @@ -11,6 +11,7 @@
> > > > >    #include <net/pkt_sched.h>
> > > > >    #include <linux/bpf_trace.h>
> > > > >    #include <net/xdp_sock_drv.h>
> > > > > +#include <linux/etherdevice.h>
> > > > >    #include <linux/pci.h>
> > > > >    #include <linux/mdio.h>
> > > > >
> > > > > @@ -69,6 +70,52 @@ static const struct pci_device_id igc_pci_tbl[] = {
> > > > >
> > > > >    MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
> > > > >
> > > > > +static void igc_read_rar0(struct igc_hw *hw, u8 *addr, u32 *ral, u32
> > > > > +*rah) {
> > > > > +	*ral = rd32(IGC_RAL(0));
> > > > > +	*rah = rd32(IGC_RAH(0));
> > > > > +
> > > > > +	addr[0] = *ral & 0xff;
> > > > > +	addr[1] = (*ral >> 8) & 0xff;
> > > > > +	addr[2] = (*ral >> 16) & 0xff;
> > > > > +	addr[3] = (*ral >> 24) & 0xff;
> > > > > +	addr[4] = *rah & 0xff;
> > > > > +	addr[5] = (*rah >> 8) & 0xff;
> > > > > +}
> > > > > +
> > > > > +static bool igc_is_lmvp_device(struct pci_dev *pdev) {
> > > > > +	switch (pdev->device) {
> > > > > +	case IGC_DEV_ID_I225_LMVP:
> > > > > +	case IGC_DEV_ID_I226_LMVP:
> > > > > +		return true;
> > > > > +	default:
> > > > > +		return false;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static void igc_wait_for_lmvp_mac_passthrough(struct pci_dev *pdev,
> > > > > +					      struct igc_hw *hw)
> > > > > +{
> > > > > +	u8 addr[ETH_ALEN] __aligned(2);
> > > > > +	u32 orig_ral, orig_rah;
> > > > > +	u32 ral, rah;
> > > > > +	int i;
> > > > > +
> > > > > +	if (!igc_is_lmvp_device(pdev))
> > > > > +		return;
> > > > > +
> > > > > +	igc_read_rar0(hw, addr, &orig_ral, &orig_rah);
> > > > > +
> > > > > +	for (i = 0; i < 100; i++) {
> > > > > +		msleep(100);
> > > > > +		igc_read_rar0(hw, addr, &ral, &rah);
> > > > > +		if ((ral != orig_ral || rah != orig_rah) &&
> > > > > +		    is_valid_ether_addr(addr))
> > > > > +			return;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >    enum latency_range {
> > > > >    	lowest_latency = 0,
> > > > >    	low_latency = 1,
> > > > > @@ -7259,6 +7306,7 @@ static int igc_probe(struct pci_dev *pdev,
> > > > >    	 * known good starting state
> > > > >    	 */
> > > > >    	hw->mac.ops.reset_hw(hw);
> > > > > +	igc_wait_for_lmvp_mac_passthrough(pdev, hw);
> > > > >
> > > > >    	if (igc_get_flash_presence_i225(hw)) {
> > > > >    		if (hw->nvm.ops.validate(hw) < 0) {
> > > > > --
> > > > > 2.53.0
> > > >
> > >
>

