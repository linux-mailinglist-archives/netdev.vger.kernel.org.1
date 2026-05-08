Return-Path: <netdev+bounces-285587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLzCCKlT/WnZagAAu9opvQ
	(envelope-from <netdev+bounces-285587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:08:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03A4F0FDF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EA03030D00
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96AA2C21C5;
	Fri,  8 May 2026 03:08:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202D2D0C63;
	Fri,  8 May 2026 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209696; cv=none; b=M6p8v+z12uHBuv6B4u2dog5B+jzmF18BBUv/4XsnQ8SXIotpD4+SNKUcnjNLa7p1TcqiRE1Qjl1vArSRJ4fWTx+XWhz0AaKAFFwOXQVPrfWa/YmBEU0LjWM0u4+qZ1xb9lrxgRfbS7tWFK1DMaHizby71qNcFQUYF9dQydbYfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209696; c=relaxed/simple;
	bh=R4QaLoZ21ZWIyPXIDUNgRMphhclhCRWSPOmd6S6pEmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izv2TJVDAWcZavHLYw7gGDEkctqRbPiAKQYhq3mkiv+1H0GisVYiV8npdX93BcHpmuqYhl58piJp3ulotAWZnB4tnOg1FllJ86zpkcZ7a31DF70ISbJlLH6oKdQoldJusBfpbet22/3uqq/LHHJlZWN0XOVhp7RA8L5/C8kPd9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1778209603t05234e01
X-QQ-Originating-IP: e3y/p6SyaB390KdMAAFShBQkpIAg0Aaw079vcng1oIE=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 May 2026 11:06:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9392278446034368298
EX-QQ-RecipientCnt: 11
Date: Fri, 8 May 2026 11:06:40 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v3 1/4] net: rnpgbe: Add interrupt handling
Message-ID: <B1A8B62336166017+20260508030640.GA201293@nic-Precision-5820-Tower>
References: <20260507081539.171844-1-dong100@mucse.com>
 <20260507081539.171844-2-dong100@mucse.com>
 <5e9b15c7-5db4-408e-a5bc-75fe5752ed74@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9b15c7-5db4-408e-a5bc-75fe5752ed74@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OOCyznbq6KdUduxR6UO4g51jNDQga9H1OeqXbHS3oza5DSS5Bu5WzqnZ
	PiVB0d2LYXCo1foOTY1+/ouLs82VwJSmF5Xh/9h89T8+WD1FEDj5IZzuJkGuQUXdP1OHKyC
	EAiTn11qDSDbShAv2gSobPxhNbcq6fifNmh2ocIsBm5PbxUKEck7Tl7I7kXXu0/9dNbouts
	d/rhs6anDyytOB2yma7Fbxsaio6AqhXRKS+0AEiM8clqfZ8keix9ADT0ItLGHwv/UCVRDx5
	RdCNuh1hY8cBNEppEe3akVOPb/doZGeFb7wq9uR88hg1rZpd1NYqySpHFZoVojBPU4a4pbT
	UM272XhjyDSJg8jggu/NG6s1u5WixNuIAl9d1gSzoePfiM2elrjOwnu3lGjDBVDsHlYcuZ+
	ArKst10OXZCl71RJOMRKIPAYHTBhFPTDw8uX8DM+3qQtfA5wjamTkM3rgT9QzZOAiyemKsI
	hKK2Y6a0AQtUqsQjy1QFjmPhgfAK9eG4NEYSG/dOCQgZFvnqAidraDpDnsuOTHuDoEMLr80
	ftqCFLKf0Cz/8tSNUuX2cpqzLRv1XBwLHbVi5A6PH3RmUL6QlZMV/lrSBo+tbPoeWRMByEL
	Fjhugz33q2dRXqJT4WxbFNq9MgIqO9Vks0ZP0+pU4pqxIv6xM0tWC7z33Hn0tMsrYJeNbHZ
	4ZjG18EugigLiLR3hxpPP8XFiTodkQfJ2q26322sFMZR2KGQ/5DDRaHEHWGz84SlYLkOsBy
	4I/XPLYRCKajbPdJUkd7+0IPcf4UXleTiNbAM+uQEkNfrPeg6w2KWWYIgU8arUsEouMOe5g
	lPgNFdmbB4W6yhAuNq9AY0UkazurMW/2lk4hrgrUyg1ilG3E8osp3RaXGst9Q0gJ8JF7e0z
	VcHHKRuCUrxKTRBAu95qxqsPY8J8pKAEP2iR9e1Rp0aEd5wSZQ+Gz8iH/iRXJgKfY9hCTAk
	FsRIxiDc32MONjwMntHFsSZf+0QiXl7sa9iH3RmFwT9T6JEse3BRjMUUqYEIgGdZmQe7A19
	dMuZs6pQO2qxZPMxyAv32GZ/aBUlQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 7C03A4F0FDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285587-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mucse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 01:30:55PM +0100, Vadim Fedorenko wrote:
> On 07/05/2026 09:15, Dong Yibo wrote:
> > Add comprehensive interrupt handling for the RNPGBE driver:
> > - Implement msi-x/msi interrupt configuration and management
> > - Create library functions for interrupt registration and cleanup
> > 
> > This infrastructure enables proper interrupt handling for the
> > RNPGBE driver.
> > 
> 
> [...]
> 
> > +/**
> > + * rnpgbe_set_interrupt_capability - Set MSI-X or MSI if supported
> > + * @mucse: pointer to private structure
> > + *
> > + * Attempt to configure the interrupts using the best available
> > + * capabilities of the hardware.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
> > +{
> > +	int v_budget;
> > +
> > +	v_budget = min_t(int, mucse->num_tx_queues, mucse->num_rx_queues);
> > +	v_budget = min_t(int, v_budget, MAX_Q_VECTORS);
> 
> these 2 lines can be simplified to
> 
> min3(mucse->num_tx_queues, mucse->num_rx_queues, MAX_Q_VECTORS);
> 

Got it, I will update this.

> > +	v_budget = min_t(int, v_budget, num_online_cpus());
> > +	/* add one vector for mbx */> +	v_budget += 1;
> > +	v_budget = pci_alloc_irq_vectors(mucse->pdev, 1, v_budget,
> > +					 PCI_IRQ_MSI | PCI_IRQ_MSIX);
> > +	if (v_budget < 0)
> > +		return v_budget;
> > +
> > +	if (mucse->pdev->msix_enabled) {
> > +		/* q_vector not include mbx */
> > +		if (v_budget > 1) {
> > +			mucse->flags |= M_FLAG_MSIX_EN;
> > +			mucse->num_q_vectors = v_budget - 1;
> > +		} else {
> > +			mucse->flags |= M_FLAG_MSIX_SINGLE_EN;
> > +			mucse->num_q_vectors = 1;
> > +		}
> > +	} else {
> > +		/* msi use only 1 irq */
> > +		mucse->num_q_vectors = 1;
> > +		mucse->flags |= M_FLAG_MSI_EN;
> > +	}
> 
> How will it work in case it's only 1 vector allocated? AFAIU, you need at
> least 2 irq vectors - 1 for queue processing, another one for mbx.
> 

Mbx and tx/rx irq share 1 irq. And in fact, Hw only support 1 msi irq.
Just like ixgbe_intr in intel drivers.

> > +
> > +	return 0;
> > +}
> 

Thanks for your feedback.

