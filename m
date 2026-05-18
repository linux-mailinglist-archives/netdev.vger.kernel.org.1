Return-Path: <netdev+bounces-289092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NxlBkImC2pAEAUAu9opvQ
	(envelope-from <netdev+bounces-289092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:46:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 812AA56F284
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF4D8302E0FD
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A498E3EDAD6;
	Mon, 18 May 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+v0rU5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75030EF94
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114982; cv=none; b=XZ4i2dbT5XFsR0mKO5OVydShPBBVPxTZOOhGxIzzIoRaPci6f6gtl+9apsKeZevclfPz5rEhPCtCKUQx3eLJ2YJ0M2fICDX0YRp48cXkn9Ak8/WHfy3QTEUOPgXvDuqIqlOJJONlycMRSOZWWw2PzvOF3I/C76JN+Zjxu38S8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114982; c=relaxed/simple;
	bh=PvlW5CgxycObmiZI4lRjUsgR5KCWceNDmjznohoyoXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWRkfp35paxstpX1CTZPv4r3++hBavq0mwIvn5yXymfQNW6isC5LVSSJ+JHbiONDmZD7aJ7/xd/sqrp6/kRcHB1lPoKpkQFSjz2kYfY4ZExIyORQRRGLADJZ1Zd1t5cYxrQduhm7d5ZrsxK5hOU0dgUdHCMbzwiRpLF46ti/z5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+v0rU5j; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39556b00a85so22074151fa.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114979; x=1779719779; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEZzf4JcWdSBWSfWMNNpDZQiDx2NJ9RUJ4DQdsAO6FQ=;
        b=R+v0rU5joIWBWPlSBknhVTD5ktniNysiwTu0daTBIAOsz7GNJ2aK/xjKATqmYAoFWO
         p8tlOvOcN8RAM7aDUfLAUpwLnRO5q9duYTjzHWKgO8IeyC+zIrOuS89vBCSON9o5GHr9
         9wgZivNPLRGg8HprVfrM+1pQilnSXNhHCqLweiK3syFd4JR0zB94pQDmWWtjVgHSmIc5
         TwrG/TOkaflPAM5ZtnTvj9/Tw76aWf5I7wQU8bM/GCkVHaJZRh73MBCI3U5V8EJFAZ5N
         5ySazHSBfYZskKL93MdlZmaHQHKiQ5HMmVlp10HFJKWiM+LLsZS4O1z1GZUBsykUQtWp
         wIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114979; x=1779719779;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEZzf4JcWdSBWSfWMNNpDZQiDx2NJ9RUJ4DQdsAO6FQ=;
        b=CTNhliQsZzNMpeNLVF5uF95ESdEQmIu0fiuFNi0zSZWhcdCc095Q/roc4TitUycEox
         RHpv2thod/zYA01T5WYX/Olgc8WrJTwjHTm+Imc1D+zFqYe1aJTOdw5JPhMTQifmcHOF
         Y51RM5KtQTYf05c2e3zs1uk9hIifznauXe3hrf11dBcILNRGU54XLGBEkawgVe+j3CoR
         Z0QR/lS6Le5KG27PYmkOv6NHugk91So73jBX95xnrhwEgq0OhF6MoLJx9nFhwTgW3fNI
         5v1L1+9+aDBo1LiZsCo6naz8JSRwTAVW+Kfw6Z7ZWT5mU+McjWjJC5n7Sn33JqBxWXae
         lu5w==
X-Gm-Message-State: AOJu0Yyo4tM4mYBsyxgpMnNZajCjxrVFr+lfZxerYFYbnQFnrgKw8mdA
	5pxm9umFa+g6qQJ2kcjE2fsaW2OYpYpK2ZBknULCIPsShCDq2s4iRsTh
X-Gm-Gg: Acq92OGDVxSq5ho/ByHe8Vx4nLXf2nXaLpjhpiJuU4/33OtOLRVX7jrsKKOUfJtG88t
	zRPCK6vj/qwGhCUUfkBT5iubCcAvY+H1ELuk+IXPIMKUIqnYjjpbDv8s6GkPXcLlJ/zlVZza2d3
	SpkfZHxVHsF0xyB08m8A67YokiLT0NsEGPA/C6JKBa6Qs0mZeDnMG08WLUy7DE24M++m706w4wt
	07gEMuTx1olwh0O7Dw9YeaBXT0LP+HYj8fCn2lPLcD7xP80wG3CLjmvMjfEiBLLmpyHByRQxexu
	PPDAcz73JDx4Z8kyXFleCBbegPeiIk98YhBsq18rPa0Qr4qEH5MisyDcEKPJ71FYrr8u+/FB6UW
	v7QTSKI34M8cMEwdZLDRHG7XAWPzA+Xqu52GCaYV0RbBAvOx/tqKo244ALIIm32zXvtwWCyiu1K
	joJHSUyZ0AHL+HnpfENNRicaedwDqAvmF62TM=
X-Received: by 2002:a05:6512:1044:b0:5a8:9c2f:5712 with SMTP id 2adb3069b0e04-5aa0e7390a3mr4812926e87.21.1779114978739;
        Mon, 18 May 2026 07:36:18 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164c545asm3435421e87.56.2026.05.18.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:36:18 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id DBF025A005B; Mon, 18 May 2026 17:36:17 +0300 (MSK)
Date: Mon, 18 May 2026 17:36:17 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v2] ice: Fix wrong dsn read in ice_adapter_put
Message-ID: <agsj4Rrexhkqao0c@grain>
References: <agQ_xZUp3Sq905O_@grain>
 <20260517125307.287246-1-horms@kernel.org>
 <ago_YTTWiZs6G8_5@grain>
 <agrjuAlzsV0RqAwU@grain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agrjuAlzsV0RqAwU@grain>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289092-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 812AA56F284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 01:02:32PM +0300, Cyrill Gorcunov wrote:
...
> 
> Thinking more I think I got what sashiko meant here: the pullout of the
> adapter when it been in recovery mode already, and reading register state
> is obviously incorrect here too, instead we have to save the state upon
> probing in some flag and use it later. I'll update the patch.

Here is an updated. Actually even in recovery mode the ice_deinit_devlink()
may call for rd32() with undefined result as

 | ice_health_deinit
 |  ice_config_health_events
 |    ice_sq_send_cmd_retry
 |      ice_sq_send_cmd

unless I miss something obvious... (i don't address this in the patch).
Please take a look once time permits.

---
From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [PATCH v3] ice: Fix wrong dsn read in ice_adapter_put

When registering an adapter instance, we read the PCI configuration
space to fetch the DSN and generate an adapter index for lookups.

However, if the adapter has been physically unplugged, the PCI space
is no longer accessible. Reading it returns a zero value, which results
in either an incorrect adapter instance being put or the proper instance
not being put at all. To fix this, we will use the previously known
index instead.

Similar applies to recovery mode detection -- if card has been in
recovery mode and physically removed we're not allowed to read its
state from hardware registers but rather provide state flag for
this.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |    1 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |   18 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_main.c    |    9 ++++++++-
 3 files changed, 22 insertions(+), 6 deletions(-)

Index: linux-tip.git/drivers/net/ethernet/intel/ice/ice.h
===================================================================
--- linux-tip.git.orig/drivers/net/ethernet/intel/ice/ice.h
+++ linux-tip.git/drivers/net/ethernet/intel/ice/ice.h
@@ -310,6 +310,7 @@ enum ice_pf_state {
 	ICE_PHY_INIT_COMPLETE,
 	ICE_FD_VF_FLUSH_CTX,		/* set at FD Rx IRQ or timeout */
 	ICE_AUX_ERR_PENDING,
+	ICE_FW_RECOVERY_MODE,	/* Firmware in recovery mode */
 	ICE_STATE_NBITS		/* must be last */
 };
 
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
@@ -130,13 +134,17 @@ struct ice_adapter *ice_adapter_get(stru
  */
 void ice_adapter_put(struct pci_dev *pdev)
 {
+	const struct ice_pf *pf = pci_get_drvdata(pdev);
 	struct ice_adapter *adapter;
 	unsigned long index;
 
-	index = ice_adapter_xa_index(pdev);
+	if (WARN_ON(!pf->adapter))
+		return;
+
 	scoped_guard(mutex, &ice_adapters_mutex) {
+		index = xa_index_mangle(pf->adapter->index);
 		adapter = xa_load(&ice_adapters, index);
-		if (WARN_ON(!adapter))
+		if (WARN_ON(!adapter || adapter != pf->adapter))
 			return;
 		if (!refcount_dec_and_test(&adapter->refcount))
 			return;
Index: linux-tip.git/drivers/net/ethernet/intel/ice/ice_main.c
===================================================================
--- linux-tip.git.orig/drivers/net/ethernet/intel/ice/ice_main.c
+++ linux-tip.git/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5121,6 +5121,8 @@ static int ice_probe_recovery_mode(struc
 
 	dev_err(dev, "Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode\n");
 
+	set_bit(ICE_FW_RECOVERY_MODE, pf->state);
+
 	INIT_HLIST_HEAD(&pf->aq_wait_list);
 	spin_lock_init(&pf->aq_wait_lock);
 	init_waitqueue_head(&pf->aq_wait_queue);
@@ -5366,7 +5368,12 @@ static void ice_remove(struct pci_dev *p
 		msleep(100);
 	}
 
-	if (ice_is_recovery_mode(&pf->hw)) {
+	/*
+	 * .remove() may be called when adapter is physically
+	 * unplugged so we can't read the fw state but use
+	 * the flag instead.
+	 */
+	if (test_bit(ICE_FW_RECOVERY_MODE, pf->state)) {
 		ice_service_task_stop(pf);
 		scoped_guard(devl, priv_to_devlink(pf)) {
 			ice_deinit_devlink(pf);

