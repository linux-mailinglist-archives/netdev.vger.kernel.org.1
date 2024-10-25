Return-Path: <netdev+bounces-139126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EEC9B0583
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA0928418C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5EB1F755D;
	Fri, 25 Oct 2024 14:16:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477117083A;
	Fri, 25 Oct 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865784; cv=none; b=EPz64j0MtyTqfT2CN939t9DYmBasqpFRy0Vf0l2+5V2+/RK9KYOHnvcF88HFu2wmBMUAkY+RZ+uJ00iZ+Q06FuYAUEvmbNguQn0doUMd2IhyzIrPKO3v/MrfKgVK363Xelx/RtZyvxcsObjFGkP3IOK2OaZDFw/RsA2hPY32p4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865784; c=relaxed/simple;
	bh=dk6wxg1P1FKqTk7RM53nnZfR1nK55spF2u1jxwN6tcM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCTj+0zKobrQc4BcTcRdXdjhM6YeFiI31UCAH5EZWcXVWwO0TInLMJbaadY0+nJ1+164i5X1OjTxqhk01cp6sD15lSxT+whEwwrZt3JBJADH41VIjgqTH07z7+oZEKkLhDsvsKJjn6/QuWiZDXzBlPpciAQCkvsjoRF9m6rWFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZlC41qPFz6K6fQ;
	Fri, 25 Oct 2024 22:14:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EE3A7140390;
	Fri, 25 Oct 2024 22:16:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 16:16:17 +0200
Date: Fri, 25 Oct 2024 15:16:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
Subject: Re: [PATCH v4 04/26] cxl/pci: add check for validating capabilities
Message-ID: <20241025151615.00000868@Huawei.com>
In-Reply-To: <9dba2210-5488-25d8-c065-f6a2c4fa2d82@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
	<20241017165225.21206-5-alejandro.lucero-palau@amd.com>
	<9dba2210-5488-25d8-c065-f6a2c4fa2d82@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 11:16:55 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 10/17/24 17:52, alejandro.lucero-palau@amd.com wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> >
> > During CXL device initialization supported capabilities by the device
> > are discovered. Type3 and Type2 devices have different mandatory
> > capabilities and a Type2 expects a specific set including optional
> > capabilities.
> >
> > Add a function for checking expected capabilities against those found
> > during initialization.
> >
> > Rely on this function for validating capabilities instead of when CXL
> > regs are probed.
> >
> > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > ---
> >   drivers/cxl/core/pci.c  | 14 ++++++++++++++
> >   drivers/cxl/core/regs.c |  9 ---------
> >   drivers/cxl/pci.c       | 17 +++++++++++++++++
> >   include/linux/cxl/cxl.h |  3 +++
> >   4 files changed, 34 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 3d6564dbda57..fa2a5e216dc3 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/pci-doe.h>
> >   #include <linux/aer.h>
> >   #include <linux/cxl/pci.h>
> > +#include <linux/cxl/cxl.h>
> >   #include <cxlpci.h>
> >   #include <cxlmem.h>
> >   #include <cxl.h>
> > @@ -1077,3 +1078,16 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
> >   				     __cxl_endpoint_decoder_reset_detected);
> >   }
> >   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> > +
> > +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
> > +			unsigned long *current_caps)
> > +{
> > +	if (current_caps)
> > +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
> > +
> > +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
> > +		*cxlds->capabilities, *expected_caps);
> > +
> > +	return bitmap_equal(cxlds->capabilities, expected_caps, CXL_MAX_CAPS);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index 9d63a2adfd42..6fbc5c57149e 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -444,15 +444,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
> >   	case CXL_REGLOC_RBI_MEMDEV:
> >   		dev_map = &map->device_map;
> >   		cxl_probe_device_regs(host, base, dev_map, caps);
> > -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> > -		    !dev_map->memdev.valid) {
> > -			dev_err(host, "registers not found: %s%s%s\n",
> > -				!dev_map->status.valid ? "status " : "",
> > -				!dev_map->mbox.valid ? "mbox " : "",
> > -				!dev_map->memdev.valid ? "memdev " : "");
> > -			return -ENXIO;
> > -		}
> > -
> >   		dev_dbg(host, "Probing device registers...\n");
> >   		break;
> >   	default:
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 6cd7ab117f80..89c8ac1a61fd 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -792,6 +792,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   {
> >   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> > +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
> >   	struct cxl_memdev_state *mds;
> >   	struct cxl_dev_state *cxlds;
> >   	struct cxl_register_map map;
> > @@ -853,6 +855,21 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   	if (rc)
> >   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> >   
> > +	bitmap_clear(expected, 0, BITS_PER_TYPE(unsigned long));
> > +
> > +	/* These are the mandatory capabilities for a Type3 device */
> > +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> > +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> > +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
> > +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> > +
> > +	if (!cxl_pci_check_caps(cxlds, expected, found)) {
> > +		dev_err(&pdev->dev,
> > +			"Expected capabilities not matching with found capabilities: (%08lx - %08lx)\n",
> > +			*expected, *found);
> > +		return -ENXIO;
> > +	}
> > +  
> 
> 
> This is wrong since a Type3 could have more caps than the mandatory 
> ones. I will change the check for at least the mandatory ones being 
> there, and do not fail if they are.
> 
> I guess a dev_dbg showing always the found versus the expected ones 
> would not harm, so adding that as well in v5.

I'd also make it clear that we only check for caps that are actually
used by Linux drivers. I don't fancy having to fix emulation up to support
something random that no software cares about.  Will get there
eventually but it's not a priority.

Jonathan

> 
> 
> >   	rc = cxl_await_media_ready(cxlds);
> >   	if (rc == 0)
> >   		cxlds->media_ready = true;
> > diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> > index 4a4f75a86018..78653fa4daa0 100644
> > --- a/include/linux/cxl/cxl.h
> > +++ b/include/linux/cxl/cxl.h
> > @@ -49,4 +49,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> >   void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> >   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> >   		     enum cxl_resource);
> > +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
> > +			unsigned long *expected_caps,
> > +			unsigned long *current_caps);
> >   #endif  
> 


