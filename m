Return-Path: <netdev+bounces-301794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4zOkN/VVPGptmwgAu9opvQ
	(envelope-from <netdev+bounces-301794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C56C1B15
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:11:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kTF6YpxH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301794-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301794-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E383A300B1CE
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAF28D8D0;
	Wed, 24 Jun 2026 22:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABDA28C869
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:10:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339058; cv=none; b=daJ1vVBhkGHnwCCRehjRrlKVGJPexbceji159Q9xC4cilTyVGTmgXDheGWGPFhpDqsKOPKFdWPZ1zHIWPssFyK6zQ1ll+78UqNygb0AHELHrmovHBUfPOLXPDIG0l7kDhnuX+KIkAkqH9JRyOOhHMy+ccmfwwAFJodkjKWbBq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339058; c=relaxed/simple;
	bh=+qcaSEjsBGY0hfxGQAac9FZCSg+r6O3gmoiaDeZc9b8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qV0LCELkDXraDCufggby5WX+2sd851jRLUcXpejFr3LaWLJvF5qdRATNSvmXj6X1tG9Dw/AGTI/G3TiYCQd8+0DHyG4t+YEyya062/vmbTvCdwV9i7obc3Us0zW6PnneNL0plogJbpMfNE0lWL4Ln5l5B9S/lm+rDl4rL6qOkqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTF6YpxH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5361F00A3D
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339057;
	bh=2zDeOvPena4qlSxGBMWoQ/GeMf6iu2rEhQfYk/kmj8Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=kTF6YpxHbCRBNyLhjZIBEHLDUxNmaF9rCQtZWDwx28bzGNmtzeVA0NChYBguxf169
	 vgbXcI1yReX+DovftnbDhToikdzLBVhsom8X04oz2kTcaZC4so2JwQOUa93vUTvWMX
	 5le6N8ViIDB6caUyCMIJtbhw6hSe5izfuFOKszTqAW4mP/9h+mBI8iVh+u8Ce97fdJ
	 FrcSLlTSAp6Eh3yfBZr+yYVsSNkxiGwis9qeqCAHY8tfo3u4FebGqSeKR9KNE65m2U
	 ZlBfsCB2+vazOzmuvnLM53KKf3TMuB0rQvu4UnPRORzuXBHzWhqXPPhGs6Fysv40XR
	 riuCGUpJsIxrg==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5131DF40088;
	Wed, 24 Jun 2026 18:10:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 18:10:56 -0400
X-ME-Sender: <xms:8FU8aiME317O9D-ZFxSWrSyQzIias2JSQOcoGtydlMAvCu6vZ9tisg>
    <xme:8FU8aihynh8JXZBgkQo-8a4MHIx0XI2AxtNLJkGdZqEvsKOTflxvvpzFdApOpmiDy
    Li9wwXRqnEyQgZMWgd24nrKoSMJqCqpexmmteufkgomxTJl3cz2n9Lm>
X-ME-Received: <xmr:8FU8aoghcQQKtP-3Z3J9gPq0gWu6wqPfLsWlYRY_bVlJ0Ppqg-qTwTo_c1UgIWMMU60GpTe4FvC6DI7ynErQafLp89NO7Sqdj7A>
X-ME-Proxy-Cause: dmFkZTF3zlzLBzyKjCAA6Cea2zlqBSqAMAQCqXaPu05Ub4Ydgfd8fyShASWLMBR4wT+YMG
    UcPBGsHqJxZJy8fX3hIF5Jzl0g8EowykA7Jy613efCgfGn1XxpcjT6osgdQkpc57steuEk
    9T4HXnYjXfCX1JRV8f7uW4pjeX7REeW5+eUwZdMprmX3OIdWMnNLG42vXdPO0Dr4fPRa34
    4PMRLgpm3YAACIU+F7mzvGzCYOIfDn8YdGIIUa+3GxABJcyjdMMGuPQ2qCJsg0g1Iwxq/E
    Tk/6H3iC+oO1TsNt1Lz0UGhCXp1t7GxV5AGSTqCJTxHNZBKlbPuwdlS3RHUT4BpFSt4wLJ
    8rawabeRnaKendPHMoFLJ55MVQdQ47RrzL7syVw2djYIyH65LihPi1nxXQOTIR4TYm/5CF
    7B3lKuzL6tgTpPrs/Kw/Ro25YaZIN59BpSlT1dyFBHCjT2dg98TLABqMGpsyUT9AM5fE4g
    uHOJBIkaP8fg+C5RmVBktVI4bXmPXWLh0yvMl75wEFcO2RqftwSxoaZtMSxSAbE0/4/PFh
    4xWKUd6gCPxk9tA0ADA27F0Eoyefqm1i6hncwE+tHqzYnRzfTMCtcbyLk6FOUJ+3CkLGbs
    CsvJz8jF6M2X5VMVD1Ji/TBGOdELUx6qxvWNOpkKXYz9ydApNu0RAabLb7Yw
X-ME-Proxy: <xmx:8FU8apJIqowhus-XKQ6rF5FpLH23yGvVlV-_oF3wdhuhnFcIqdJRAQ>
    <xmx:8FU8avkf5S1z8fy8bFwUAC8a8DE6CuyVCKJAxKA-szyysQ-OU6S83g>
    <xmx:8FU8apPRPh-9iqI63DESH3c8YocBVSAaT_Mbt-E0OoF-K7B9zV8HKw>
    <xmx:8FU8ah5vfegxnX7PARtXxRKrEGtStvPLaJLVUAaL-_GpuD9nWgSN7A>
    <xmx:8FU8albjUoi-G9B67uEzJXlvqnmE1RS668bbjvxo4aAEkQaNpw0mi4sx>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 18:10:55 -0400 (EDT)
Date: Wed, 24 Jun 2026 15:10:54 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 netdev@vger.kernel.org, 
 dan.j.williams@kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>, 
 Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6a3c55eea91d0_f12301008f@djbw-dev.notmuch>
In-Reply-To: <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v29 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-301794-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,djbw-dev.notmuch:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A8C56C1B15

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use core API for safely obtain the CXL range linked to an HDM committed
> by the BIOS. Map such a range for being used as the ctpio buffer.
> 
> A potential user space action through sysfs unbinding or core cxl
> modules remove will trigger sfc driver device detachment, with that case
> not racing with this mapping as this is done during driver probe and
> therefore protected with device lock against those user space actions.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx.c     |  2 ++
>  drivers/net/ethernet/sfc/efx_cxl.c | 23 +++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 61cbb6cfc360..3806cd3dd7f4 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_fini_io(efx);
>  
>  	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	efx_cxl_exit(probe_data);
>  
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
> @@ -1242,6 +1243,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	return 0;
>  
>   fail3:
> +	efx_cxl_exit(probe_data);
>  	efx_fini_io(efx);
>   fail2:
>  	efx_fini_struct(efx);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 18b535b3ea40..3e7c950f83e9 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct range cxl_pio_range;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENODEV;
>  	}
>  
> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
> +		return PTR_ERR(cxl->cxlmd);
> +	}
> +
> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
> +				    range_len(&cxl_pio_range));
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> +			&cxl_pio_range);
> +		return -ENOMEM;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  }
>  
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{

If you are going to have an explicit efx_cxl_exit() then I would also
add an explicit unregistration of the memdev. This would also fix the
Sashiko report about pci_disable_device() running while the cxl_memdev
is still registered. Unfortunately, mixing devm and explicit unwind is
always fraught.

Let me know if this passes your testing, and I can send it out as a
standalone patch. You could also use it to unwind if the ioremap()
fails.

-- 8< --
From 47940f7d6de6dd1039d0e445eb944ca96ad5eb3a Mon Sep 17 00:00:00 2001
From: Dan Williams <djbw@kernel.org>
Date: Wed, 24 Jun 2026 11:47:24 -0700
Subject: [PATCH] cxl: Add devm_cxl_remove_mem()

Undo devm_cxl_probe_mem() without causing the host driver to unload.

The expectation of devm_cxl_probe_mem() is that upon attach the caller
depends on the CXL topology not being torn down. If it is then it is
escalated to a 'remove' event on the caller. However, if the caller wants
to cancel their interest in CXL operation, they should be able to do so
without that side effect.

This is useful for setup scenarios where CXL successfully attaches, but
some other event precludes CXL operation.

Cc: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 include/cxl/cxl.h         |  1 +
 drivers/cxl/core/memdev.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 016c74fb747c..cff2922b0d4a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -226,4 +226,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 
 struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
+void devm_cxl_remove_mem(struct cxl_memdev *cxlmd);
 #endif /* __CXL_CXL_H__ */
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 33a3d2e7b13a..aa35876f0067 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1185,6 +1185,31 @@ struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 }
 EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
 
+static struct cxl_attach_region *cancel_probe_mem_teardown(struct cxl_memdev *cxlmd)
+{
+	struct cxl_attach_region *attach;
+
+	guard(device)(&cxlmd->dev);
+	attach = container_of(cxlmd->attach, typeof(*attach), attach);
+	cxlmd->attach = NULL;
+	return attach;
+}
+
+void devm_cxl_remove_mem(struct cxl_memdev *cxlmd)
+{
+	struct cxl_attach_region *attach;
+	struct cxl_dev_state *cxlds;
+
+	if (IS_ERR(cxlmd))
+		return;
+
+	attach = cancel_probe_mem_teardown(cxlmd);
+	cxlds = cxlmd->cxlds;
+	devm_release_action(cxlds->dev, cxl_memdev_unregister, cxlmd);
+	devm_kfree(cxlds->dev, attach);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_remove_mem, "CXL");
+
 static void sanitize_teardown_notifier(void *data)
 {
 	struct cxl_memdev_state *mds = data;
-- 
2.54.0

