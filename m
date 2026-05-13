Return-Path: <netdev+bounces-287486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MKIAZxBBGpJGQIAu9opvQ
	(envelope-from <netdev+bounces-287486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:17:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C495307BC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AE9430EEEAA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5913A5E86;
	Wed, 13 May 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFD11lWO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A453672BE
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663370; cv=none; b=scaNfAEDKHkuWBPI7tpegoBGudAQV1q/hWOvSgZXvjwQfV4ASSSx3yLB0RewjIkZFF8vkNqtXfenGxZpnFPyqkKbnArnvFYJMjVGQptjCmQfoJhJaUPuONcEWB9xnOpOMoVSy0OisrRRXaVdQAs3jTN6AJsxxHmTohEwJH2mNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663370; c=relaxed/simple;
	bh=8wgVrvTzhPuyby+YsggHPtQ7/AgumtARByVyaARbZb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PcQ+NyRJDIQOC5HbFknL1LPIUS0s8SGlm+FE2nmv9+x1YYjCvrvaD6JMhFSGZg32+Eia3SHtON5dwmplctht18n1CnIOZ1sdbYjiIDDLVXDkeeIebqf5n9tfibYagWJWiCWTXpdNzSiTWzqMMVleZSLnZYlajVgIQNgC1WKvuyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFD11lWO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8cb92f26aso3135830e87.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 02:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778663367; x=1779268167; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYyER6YbOgaODTitWGTBF5s2T8z2KS499gj7ChXFEfA=;
        b=RFD11lWOlZNOM7VW69G9qtkwmzUFfIqvRKEAUuB1Dc7GC1oQLe7fF+aIyGz0N6AIXh
         hmrPGpO5sAYhj4agTDPx/dPn0xKj4dKLmbKExH6IwouQ07Zs07V+WR3HqD3FP7YTt65g
         HQh1qVazOKOfMZf0FmH7N+tFHak5eR3BsQ08MHyZtrxDSqgw9BTSijmCAjMg9lCK+WMD
         gopENqdZ875x6Qa3zMA594hEmSkaRjuGfcd07buA1a1k9p5zGm67TPmvptk7kngETZaD
         fjmKZ7MnudlWDOTTAOmpTLgcgE+3W8C1/zs6C9Wx0k8gALdVoUUB7AwKmWdZQB8ovr15
         GepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663367; x=1779268167;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYyER6YbOgaODTitWGTBF5s2T8z2KS499gj7ChXFEfA=;
        b=dI4wnHRLOo+qCha0+wpJaAN4LSgfNsL0p8Sb5eXSIjNxAfqElf3CE3NHqFbzTC/bw2
         bZ4PkG5l+kfoXYXGFr7iLRTDklGMcJFQ/xT4mPsL7YUyb5UZNBpJkY6NsNFKfUoOn468
         oGzg3BBoAuDKI30eeLyxi7FB/ojwnNlHEkrL8R10C7xvVb/UFMclkqBvHeNwVuntL5vg
         TDBu4ua4Sh5MlZ/AoxvZEydrqLECbHa4IXa8RZfk3gu82vfgFfg0VdQeeSNRZS069J9J
         sxwcmkLY+1YOJJO4H585P9dFeoQS/vpm8bvB2NgVnrZoeGEPtzsaxiFEVKCTD6h1klzO
         LkQg==
X-Forwarded-Encrypted: i=1; AFNElJ/Le/8ldJ79BNeZT7G+E9Gwm5KLhzDNROK7guPHr5lU+IdW0nEUaQtsGJC+XT2ykG577URzZ3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuYjMBzFflfdUdz3Jbq78mU67uwzE0oU7ubISS+4qErsLOIH0
	PoAAsJI1kjIGyzzK9171Ljm1Jl55wHSgoLR1Qxn9DHM0UAUoAiuXK60DNtTIDQ==
X-Gm-Gg: Acq92OGb1BT01w8sFoQg4JWsg42sXNZhj5vm5rcmvLnWrBiAxz6uOZyVdQbNY5dJPBz
	4jOsXxauOW/ZP5Zx+IU4fi8DbGkhL/NJ84/bT70Z0E2ZpOuLXj2jDNIBKguhE5iC5wa78mCUJzd
	WIqA3u69jC+gNP768RRGJDjzHdXih049tePGZIYSkzMpF39bxiaYNJbtXd03IaEaFlF4Wb4pHTd
	qJft0C2yhIDTY6IG2IY9Yt50dtJqJZWYjfq2DKUTs5GlwowcxM3UxW8JYFRb/0r9BwQeBaE103v
	gSrY9II/NQmbIKZGhj6iGgesHJE65mQ2hwzU/kPJlttChbd8d0wpQRT77aiDmx+yUws/C17eYXl
	Zt3hySXCorbvbz2RwLK16TJj/s4He2PL34xzC3pUtODWN2X/QV0s6PNNTlTH5AXaPxTr9D9wEDY
	K6PGKJZqPS+YvGgU2kDr+Try02
X-Received: by 2002:a05:6512:3c9f:b0:5a8:d1ed:8d4a with SMTP id 2adb3069b0e04-5a8f445a687mr630442e87.40.1778663366402;
        Wed, 13 May 2026 02:09:26 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a956b1cfsm3975152e87.73.2026.05.13.02.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:09:26 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 8720A5A0185; Wed, 13 May 2026 12:09:25 +0300 (MSK)
Date: Wed, 13 May 2026 12:09:25 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, NETDEV <netdev@vger.kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH] ice: Fix wrong dsn read in ice_adapter_put
Message-ID: <agQ_xZUp3Sq905O_@grain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Rspamd-Queue-Id: 83C495307BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287486-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When registering an adapter instance, we read the PCI configuration
space to fetch the DSN and generate an adapter index for lookups.

However, if the adapter has been physically unplugged, the PCI space
is no longer accessible. Reading it returns a zero value, which results
in either an incorrect adapter instance being put or the proper instance
not being put at all. To fix this, we will use the previously known
index instead.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-tip.git/drivers/net/ethernet/intel/ice/ice_adapter.c
===================================================================
--- linux-tip.git.orig/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ linux-tip.git/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -130,13 +130,13 @@ struct ice_adapter *ice_adapter_get(stru
  */
 void ice_adapter_put(struct pci_dev *pdev)
 {
+	const struct ice_pf *pf = pci_get_drvdata(pdev);
+	unsigned long index = pf->adapter->index;
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

