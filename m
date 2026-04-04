Return-Path: <netdev+bounces-275322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMpECDat0Gll+wYAu9opvQ
	(envelope-from <netdev+bounces-275322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 08:18:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B439A1B5
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 08:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0140D3007BA8
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 06:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5133BBBD;
	Sat,  4 Apr 2026 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oLQkKPDp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6632FE056
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775283505; cv=none; b=lZ8ESS0JueRrCO6Mos+p4KJ2XXOH8bDrFNXEyi0k1wqGJraLjng6caAozURnA4IV28av7LmD9Fhw2GziXXl30sfmj0D1DHiSpIf+zE6PTFD7Fm7VGSdLEo6Een52kjObWWCdE6XuHHi6OR0sT2GOr8tndKg4izy8LfS/VXIJtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775283505; c=relaxed/simple;
	bh=oz1NsWKFN908kdETYVcdeNmEkUFKiu4Wtoc8BzmgJbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXsfAgGFRqnSkM79p9pLoNlLQj8DsGotcZyGViENIX+ozCOprOnNV8slK8pt7oInTSU/3eS74Aasts24mGvZjnFnvvo1zi5PGGsT5eDldeXN4L8DWRO7tD3fN8Wp19L6yxlUmkoPNlpEXZmHoafmoF8/iXoqnuFnEOopntRn+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oLQkKPDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6808C19423;
	Sat,  4 Apr 2026 06:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775283505;
	bh=oz1NsWKFN908kdETYVcdeNmEkUFKiu4Wtoc8BzmgJbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLQkKPDpImSTuEvvF3B/UNJHkGEeKhdR2YrAh6WMBTUDBKWaUhH+PikH2edLBPwrf
	 gmcwNQ1BpW7kKX/0VYU+JFURyZ98wlx3soigF22atosbfkK3xEz+9IMYxusBT/+/DZ
	 zLuBa1cAv5Am7mR6CWjAFJvRfDynFHpln7+txxF0=
Date: Sat, 4 Apr 2026 08:14:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Main Frame <framemain@outlook.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"security@kernel.org" <security@kernel.org>
Subject: Re: OOB heap read in =?utf-8?Q?nci=5Fcore?=
 =?utf-8?Q?=5Finit=5Frsp=5Fpacket=5Fv1=28=29_via_chip-controlled_pointer_a?=
 =?utf-8?Q?rithmetic_=E2=80=94?= net/nfc/nci/rsp.c
Message-ID: <2026040440-unnerve-dork-3a79@gregkh>
References: <IA4PR10MB85192CB7160F3B87AE25DE55AA5EA@IA4PR10MB8519.namprd10.prod.outlook.com>
 <2026040335-gout-cytoplast-a1c0@gregkh>
 <IA4PR10MB8519F683F0FE5B64122A5216AA5EA@IA4PR10MB8519.namprd10.prod.outlook.com>
 <20260403163545.6e7c0f53@kernel.org>
 <SJ5PPF8C7834C85946892B0A1418D1F7FB2AA5FA@SJ5PPF8C7834C85.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ5PPF8C7834C85946892B0A1418D1F7FB2AA5FA@SJ5PPF8C7834C85.namprd10.prod.outlook.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275322-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A76B439A1B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 12:24:29AM +0000, Main Frame wrote:
> 
>  nfc: nci: fix OOB heap read in nci_core_init_rsp_packet_v1()
> 

<snip>

For some reason your email client sent this in html format, and it was
corrupted and indented and couldn't be applied.

Can you take a look at Documentation/process/email-clients.rst for how
to fix up your email client to not do this and resend it in the correct
format so that it can be applied?

Also, one note, the "v2" stuff goes below the --- line as documented.

thanks,

greg k-h

