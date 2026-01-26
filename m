Return-Path: <netdev+bounces-253601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PAMN9LYd2mFlwEAu9opvQ
	(envelope-from <netdev+bounces-253601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:12:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F78D949
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 354203004D22
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9822DF134;
	Mon, 26 Jan 2026 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z8zh3r3p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9042DEA98;
	Mon, 26 Jan 2026 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461966; cv=none; b=EHAB1ow5exwxRIauSsCgAqCdYEc1L7EGqOSzooBILE8PQuj6aopEaNVdXVrQBITl2oN9Cr5zNo0z8Ckki2+Puqg+yrNIuy4p8tfniZyBo6dwubSI8LMwnQDyFcdXybx1z5HlxaZ87w5Jx91REqV7Uopsey844eTiGpck7ySECtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461966; c=relaxed/simple;
	bh=ieaBvrlaCVgo2gU3xm/PyOCSiqsNMrhbOxf9A4GtSlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1iQ/UgiEMOZ+3OJxRDTSQid8MFRXJf1fL8fEDmrdky1Q+lFQuU8uVIB68q71V2qPt0ZW6gBGsE4/UqXxgzOyCWJC1CkM5qfdfzCOcgfKj40Q/QyEGEXVzVzdFTM4+2vqk2wex5nSh3QXrDPRQ7h6k8RSv0zWbkmClijCwuNxuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z8zh3r3p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1GqpcYUiw2sTK+oDrLcovhe4bjl1PP/TJXojV87BrcY=; b=Z8
	zh3r3pODrj/qNFlKP+2mQcovx7xapqxwrOo6PJ7toOKkwvEEPbZ9jm3RvgGePoikXDXrV6sztYO5a
	VjfRN7amua/BPXZKlYiV4SPMXJrAvC4TvlvvjmywcapS+BaOmK7K295u+9+fDLNcctAGWd7pxQZOY
	cIsEq1P8GmQ1VlU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkTst-004qkp-B7; Mon, 26 Jan 2026 22:12:31 +0100
Date: Mon, 26 Jan 2026 22:12:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Dumazet <edumazet@google.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Brian Vazquez <brianvv@google.com>,
	Brian Vazquez <brianvv.kernel@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	David Decotigny <decot@google.com>, Li Li <boolli@google.com>,
	Anjali Singhai <anjali.singhai@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	emil.s.tantilov@intel.com, Brett Creeley <brett.creeley@amd.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [iwl-net PATCH v2] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
Message-ID: <649ae4be-3081-49a2-8ac7-18724272498f@lunn.ch>
References: <20260126144624.2319784-1-brianvv@google.com>
 <37e1a648-609b-4d5e-9176-fbbacc7e9e07@lunn.ch>
 <CAMzD94Qt9-5G-8MHcmHLgYEyjRUoPB+SruzZXafxSTkNV8criA@mail.gmail.com>
 <b18b4b38-b3e7-485f-91f8-e3a74ff90572@lunn.ch>
 <72764a6e-602a-42ed-88c9-e4259b6078f3@intel.com>
 <CANn89iK-W6bKuVZD-5FxxunOtcmwOgAM9d4NPA8XwXXKi_TVJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK-W6bKuVZD-5FxxunOtcmwOgAM9d4NPA8XwXXKi_TVJw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253601-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,google.com,gmail.com,davemloft.net,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org,amd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,intel.com:email]
X-Rspamd-Queue-Id: 861F78D949
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 09:51:10PM +0100, Eric Dumazet wrote:
> On Mon, Jan 26, 2026 at 9:46 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> >
> >
> >
> > On 1/26/2026 9:53 AM, Andrew Lunn wrote:
> > > On Mon, Jan 26, 2026 at 12:40:15PM -0500, Brian Vazquez wrote:
> > >> On Mon, Jan 26, 2026 at 11:24 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > >>>
> > >>> On Mon, Jan 26, 2026 at 02:46:24PM +0000, Brian Vazquez wrote:
> > >>>> The code uses the vidx for the IRQ name but that doesn't match ethtool
> > >>>> reporting or netdev naming, this makes it hard to tune the device and
> > >>>> associate queues with IRQs. Sequentially requesting irqs starting from
> > >>>> '0' makes the output consistent.
> > >>>>
> > >>>> Before:
> > >>>>
> > >>>> ethtool -L eth1 tx 1 combined 3
> > >>>>
> > >>>> grep . /proc/irq/*/*idpf*/../smp_affinity_list
> > >>>> /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> > >>>> /proc/irq/68/idpf-eth1-TxRx-1/../smp_affinity_list:0
> > >>>> /proc/irq/70/idpf-eth1-TxRx-3/../smp_affinity_list:1
> > >>>> /proc/irq/71/idpf-eth1-TxRx-4/../smp_affinity_list:2
> > >>>> /proc/irq/72/idpf-eth1-Tx-5/../smp_affinity_list:3
> > >>>>
> > >>>> ethtool -S eth1 | grep -v ': 0'
> > >>>> NIC statistics:
> > >>>>       tx_q-0_pkts: 1002
> > >>>>       tx_q-1_pkts: 2679
> > >>>>       tx_q-2_pkts: 1113
> > >>>>       tx_q-3_pkts: 1192 <----- tx_q-3 vs idpf-eth1-Tx-5
> > >>>>       rx_q-0_pkts: 1143
> > >>>>       rx_q-1_pkts: 3172
> > >>>>       rx_q-2_pkts: 1074
> > >>>>
> > >>>> After:
> > >>>>
> > >>>> ethtool -L eth1 tx 1 combined 3
> > >>>>
> > >>>> grep . /proc/irq/*/*idpf*/../smp_affinity_list
> > >>>>
> > >>>> /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> > >>>> /proc/irq/68/idpf-eth1-TxRx-0/../smp_affinity_list:0
> > >>>> /proc/irq/70/idpf-eth1-TxRx-1/../smp_affinity_list:1
> > >>>> /proc/irq/71/idpf-eth1-TxRx-2/../smp_affinity_list:2
> > >>>> /proc/irq/72/idpf-eth1-Tx-3/../smp_affinity_list:3
> > >>>>
> > >>>> ethtool -S eth1 | grep -v ': 0'
> > >>>> NIC statistics:
> > >>>>       tx_q-0_pkts: 118
> > >>>>       tx_q-1_pkts: 134
> > >>>>       tx_q-2_pkts: 228
> > >>>>       tx_q-3_pkts: 138 <--- tx_q-3 matches idpf-eth1-Tx-3
> > >>>>       rx_q-0_pkts: 111
> > >>>>       rx_q-1_pkts: 366
> > >>>>       rx_q-2_pkts: 120
> > >>>
> > >>> Are there any ABI issues here?
> > >>
> > >> The patch doesn't change the format, it just fixes the numbering in
> > >> the name to make it consistent with other reporting tools. It
> > >> shouldn't break any library.
> > >
> > > But is the numbering part of the ABI?
> > >
> > > Making a comment about ABI in the commit message makes it clear it is
> > > something you have considered, and you have decided it is not an
> > > issue. If there is no such comment, reviewers probably should ask.
> > >
> > >         Andrew
> >
> > I don't see how an application can depend on the name if it can't
> > correlate it to anything meaningful. The change fixes the ID values used
> > so that they *do* correlate. If an application was previously assuming
> > it correlated to the queue ID, it would incorrect associate the IRQ with
> > the wrong queue.
> 
> Agree, this mismatch caused me some surprises, we can not keep a broken
> ABI (which has been broken by accident)

So everybody is agreed, great. I just think it would of been good to
mention ABI in the commit message, to show due diligence has been
done.

   Andrew

