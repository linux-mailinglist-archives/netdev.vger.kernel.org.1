Return-Path: <netdev+bounces-288782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6enrEm8/CmqbyAQAu9opvQ
	(envelope-from <netdev+bounces-288782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:21:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7254564282
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 111D13001323
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329173D47A1;
	Sun, 17 May 2026 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJGnA0hz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964B3043DE
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779056490; cv=none; b=B3+eeGLfA5aIFLqlRNkC9+KG2QtZlC04URQmggDwtrJLqHN8T7s4IDwVtGj0Kn4SPAsrvt82fwVpnWEOX9/xgL8u9/GbBSsADjQDxunE7lu1JC1Sf0GKhGfqt2kXCb+l44R2ZIhMGLwP0GIrjYCbZw1CDUDp3uURDRyCTlrQRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779056490; c=relaxed/simple;
	bh=Nkdh/o+NdvEDXczKo7JSi5D+SMLbhUf2r08VjQQK1u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSzbkuzITb0hR7sOdus4GNGD3V2FYnhzeK3UxQSf3/VM/Du4e7nKtzQIrxVzhkdBWKnDxVUhUnDOWIPgl8Iv5/lVtG7qiZxMrwm6FDNSjrSOzE2vQKu1ca9KFDdlAxMu5fo0D2WBw0FL3J8GRkndX1NcXUhPs+EGfUQZVvrxRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJGnA0hz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4585a116a4aso1260249f8f.3
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779056486; x=1779661286; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRXKAgR6mEIDdOY7jCBs+jQiL9+n0WTtYZp0RJAX6B0=;
        b=dJGnA0hzcwA21mytuA1t2RaR1bFa9b2pQBy4dD3hIWomjLekUFiTIZ9PWC14nGWxCc
         CaU7mkpSL0XJfABX+H+XdmVqIC7wOte88Ydy9t6VSzQrih2gf1A+Pfkj73/+UXcJ5keT
         c9xhp2RyG9C9+p5TqCdtc2bO/tMNSG2AFDDMTMFTeq5mtKT2M3bgQpe3TVicipeNn6NJ
         bkrfGBmB8YWqojaObo0yg4Q3GKC8pdSXtGTcpkhYDBpWy4Ur9ttRrBVF01zcitDYMfpI
         WBz2kqvMSl0Irp87OL2/py18HXrE+7B8HvMgzeo6PbdB729d94+l18ZPqIcd7aLmcfl6
         PJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779056486; x=1779661286;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jRXKAgR6mEIDdOY7jCBs+jQiL9+n0WTtYZp0RJAX6B0=;
        b=DXXQrCBFL4d9OxcpXWgab86HUyINJqqE9spLldvxgnlSSHSmnI5yr9DStOXxxzEtNx
         AZYtwlNKSaIa1eWDkW2koZGHnFThKto9Nb/8xAhCGxCe8Q6FkPtvYkCGuWLAoFCLVrC7
         7okfcJFsnP9m1ew4TZd/yLesFh0WFxju6z5MGffbOaO4n6wWbDDYrArz/1tkxEFP0kng
         um/5mqjayntB5FrHZvj/F4I9hiTUXz0MaVQclut74W8t75dq1Uh1Ia0sedOAHoJgZ2L4
         y5S5ROMFO3jkfCm8szfIWYTUtxz5KZ8l+sFVIsoMX7zr5xblFAHgww90rXdlfKJZR5/1
         VBMA==
X-Forwarded-Encrypted: i=1; AFNElJ+6BfXw4qYMzvyCKNEzIHZ01jKopRsL612KtyvliuK9MLg2fi0V2AJsROJZHHLQM02xyDcOqvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqKOEZJis4BYlvc93buAxF6/dlSWJaQE9vyKpvs+Da/ErC2Cp
	K5qPV40cDSwPkh1zxyEOU6Z0URTdPzIqy79EglVUy1MOTht1a50AARpZ
X-Gm-Gg: Acq92OFHDbhmjFL+xs59JFEkybbEQO8ZDqey5tS+OlNVzR+K/vlZdjxcyrLu2ybwe3o
	/7U75YZzgpAteyqoMCHIRY4KMkRZHY6bTtGA/Rq2iSV17fL0B/TmgiGWK62B1VwCkmVEMbk9Onv
	zcJSoyhun60+NilRdu0ZhocLPeMEtWEo7LcQBTwwbi8qL9lyZ2ofoZDhB73VezNam9IkeO1uU8F
	k7WOFcMlxfblP3AhcMZYCDGaJvkBhfhJAbbM5khowhZRhS/nYwPFpD9rJ6vTu7Yvo3avCag37j8
	CHiBI3K1DlBSE3A2r9CjA+zBfyEJgrA9OM4PtxofWxJBxqduOOSFd9WgbZpVs9nMalDn1ux0X/n
	IpOVBn6IbZPrsH/Ozesjnds8hLIEX9N22rj622yUILZXneVFLDzdWoQRtifyT8WO0yDo9+zCkNG
	RXcxIRdiDseYaxLBNIHWTl2rRMbIc=
X-Received: by 2002:a05:6000:1a8e:b0:441:202e:3d2d with SMTP id ffacd0b85a97d-45e5c59a3fbmr18364490f8f.19.1779056485427;
        Sun, 17 May 2026 15:21:25 -0700 (PDT)
Received: from grain.localdomain ([212.46.38.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm32072217f8f.12.2026.05.17.15.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 15:21:24 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id DD7CD5A005B; Mon, 18 May 2026 01:21:21 +0300 (MSK)
Date: Mon, 18 May 2026 01:21:21 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: [PATCH v2] ice: Fix wrong dsn read in ice_adapter_put
Message-ID: <ago_YTTWiZs6G8_5@grain>
References: <agQ_xZUp3Sq905O_@grain>
 <20260517125307.287246-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517125307.287246-1-horms@kernel.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Rspamd-Queue-Id: C7254564282
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288782-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 01:53:07PM +0100, Simon Horman wrote:
...
> >  void ice_adapter_put(struct pci_dev *pdev)
> >  {
> > +	const struct ice_pf *pf = pci_get_drvdata(pdev);
> > +	unsigned long index = pf->adapter->index;
> 
> Is it possible for pf->adapter to be NULL here if the device was probed in
> firmware recovery mode?
> 
> If the device enters firmware recovery mode during ice_probe(), the driver
> calls ice_probe_recovery_mode() and skips the ice_adapter_get() allocation.
> If the device is subsequently unplugged, the memory-mapped read for the
> firmware state register might return 0.
> 
> This would cause ice_is_recovery_mode() to evaluate to false in ice_remove(),
> allowing the normal teardown sequence to proceed and call ice_adapter_put().
> Would the unconditional dereference of pf->adapter->index then cause a NULL
> pointer dereference?

If we're in recovery mode the ice_remove will not reach ice_adapter_put,
instead it will stop service work and just deinit devlink interface, no?

> Also, does this implicit cast to unsigned long bypass the XOR folding used
> during insertion on 32-bit architectures?
> 
> The ice_adapters XArray is keyed by an unsigned long index. During insertion
> in ice_adapter_get(), the index is computed using ice_adapter_xa_index(pdev).
> On 32-bit architectures, this helper explicitly applies a bitwise XOR fold
> to the 64-bit Device Serial Number:
> 
> (u32)index ^ (u32)(index >> 32)
> 
> Since pf->adapter->index is a 64-bit value, assigning it directly to a
> 32-bit unsigned long implicitly truncates the upper 32 bits, omitting the
> XOR operation.
> 
> Because the lookup index would differ from the insertion index, xa_load()
> might fail to find the adapter. Would this trigger the WARN_ON and return
> early, permanently leaking the adapter memory?

That's the good point but it seems the problem is deeper -- the xor doesn't
prevent from index collision which may lead to wrong assumption with shared
clocks as far as I can tell (and this will cause warn-on-once in ice_adapter_get
with unpredictable state of adapter in further work). So it looks that xoring
index on 32bit archs is just broken.

Still point is correct (i've been working with this adapters on 64bit archs
only so didn't get this issue). Here is an updated version.
---
From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [PATCH v2] ice: Fix wrong dsn read in ice_adapter_put

When registering an adapter instance, we read the PCI configuration
space to fetch the DSN and generate an adapter index for lookups.

However, if the adapter has been physically unplugged, the PCI space
is no longer accessible. Reading it returns a zero value, which results
in either an incorrect adapter instance being put or the proper instance
not being put at all. To fix this, we will use the previously known
index instead.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: linux-tip.git/drivers/net/ethernet/intel/ice/ice_adapter.c
===================================================================
--- linux-tip.git.orig/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ linux-tip.git/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -40,10 +40,8 @@ static u64 ice_adapter_index(struct pci_
 	}
 }
 
-static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
+static unsigned long xa_index_mangle(u64 index)
 {
-	u64 index = ice_adapter_index(pdev);
-
 #if BITS_PER_LONG == 64
 	return index;
 #else
@@ -51,6 +49,12 @@ static unsigned long ice_adapter_xa_inde
 #endif
 }
 
+static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
+{
+	u64 index = ice_adapter_index(pdev);
+	return xa_index_mangle(index);
+}
+
 static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 {
 	struct ice_adapter *adapter;
@@ -130,13 +134,13 @@ struct ice_adapter *ice_adapter_get(stru
  */
 void ice_adapter_put(struct pci_dev *pdev)
 {
+	const struct ice_pf *pf = pci_get_drvdata(pdev);
+	unsigned long index = xa_index_mangle(pf->adapter->index);
 	struct ice_adapter *adapter;
-	unsigned long index;
 
-	index = ice_adapter_xa_index(pdev);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		adapter = xa_load(&ice_adapters, index);
-		if (WARN_ON(!adapter))
+		if (WARN_ON(!adapter || adapter != pf->adapter))
 			return;
 		if (!refcount_dec_and_test(&adapter->refcount))
 			return;

