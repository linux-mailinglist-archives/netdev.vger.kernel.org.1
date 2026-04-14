Return-Path: <netdev+bounces-278492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OVyHEFb3mkyCQAAu9opvQ
	(envelope-from <netdev+bounces-278492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:20:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 928AB3FBAB6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C8C5301BAFB
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5333E92BA;
	Tue, 14 Apr 2026 15:11:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC843E715C;
	Tue, 14 Apr 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179462; cv=none; b=AJBsLnAdkORmqNMbLmoH0G8s4MzYht9N2lRaWj179GDWL7/07ZD/6S6QN0xc9kH2AyjCXbqO1k5cFb9m46v9ToobJWcZ47oPsZM5NbRfLikmySf65zV/Rj/2C2keRrDAcVD0hQHRMW27cXr2l3XHa0Hz1EHzDJmykLv9EdrdEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179462; c=relaxed/simple;
	bh=vE8oY2+CFeERbpQcQgcuOZjFVLN/Cm8VzpD9mYKY/gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La5+/MtS6vJOOc+K55y5rb1kFStqsZFo+pudoV8gPt0uMuXO+buTtwU7HlrAs7Yi5NyYpUsxFZ8A/eaYUJRktI0uWeSqPMOA5hcf/8Vy9BmTShT98vCXUczIaP5a6xJVQABQT1A1EPzDA3p71xw0PVGMDOyeg3+OtR975p+NFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id E03F9383;
	Tue, 14 Apr 2026 17:10:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C9EB86034192; Tue, 14 Apr 2026 17:10:50 +0200 (CEST)
Date: Tue, 14 Apr 2026 17:10:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Bhat, Jay" <jay.bhat@intel.com>,
	"Barrera, Ivan D" <ivan.d.barrera@intel.com>,
	"Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Chittim, Madhu" <madhu.chittim@intel.com>,
	"decot@google.com" <decot@google.com>,
	"willemb@google.com" <willemb@google.com>,
	"sheenamo@google.com" <sheenamo@google.com>
Subject: Re: [PATCH iwl-next v2 2/2] idpf: implement pci error handlers
Message-ID: <ad5Y-gNBDvns-WAE@wunner.de>
References: <20260414031631.2107-1-emil.s.tantilov@intel.com>
 <20260414031631.2107-3-emil.s.tantilov@intel.com>
 <IA3PR11MB8986C6EC840268F14C44B28CE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986C6EC840268F14C44B28CE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-278492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,wunner.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 928AB3FBAB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:09:05AM +0000, Loktionov, Aleksandr wrote:
> > From: Tantilov, Emil S <emil.s.tantilov@intel.com>
> > .slot_reset is the callback attempting to restore the device, provided
> > a PCI reset was initiated by the AER driver.

Just for clarity, those callbacks are invoked by PCI core error handling
code and are shared by EEH, AER, DPC as well as s390 error recovery flows.
So it's not only AER.

> > +/**
> > + * idpf_pci_err_resume - Resume operations after PCI error recovery
> > + * @pdev: PCI device struct
> > + */
> > +static void idpf_pci_err_resume(struct pci_dev *pdev) {
> > +	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
> > +
> > +	/* Force a PFR when resuming from PCI error. */
> > +	if (test_and_set_bit(IDPF_PCI_CB_RESET, adapter->flags))
> > +		adapter->dev_ops.reg_ops.trigger_reset(adapter,
> > IDPF_HR_FUNC_RESET);
> 
> You say "Force a PFR", but PFR is only triggered on the AER path,
> not on the FLR path.

And?  idpf_pci_err_resume() is only invoked in the error recovery path
(aka AER path), not FLR path AFAICS.

Thanks,

Lukas

