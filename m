Return-Path: <netdev+bounces-122385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8365960EAA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B91F20406
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1B1C4EF9;
	Tue, 27 Aug 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q0D219xi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885251C57A3
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770257; cv=none; b=rBr6AvxU6/nxcBhCR5CDJFIAEhawmDikDDT2jI/W/8dqDW+XltPrZvbSof+nWbimWuM+ug9HRVEz5IUOaZ10hhYc+0jqgnLUL2AySzk+ERcTDtenA08ENTNH8FecBJOa41eYHPLSnWtvtCWTHMhGc43Ujmqq8mn6uT3og0knouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770257; c=relaxed/simple;
	bh=paZ0GNFKn4uEQjz0srhCfFTNE/NCDkZfX4JypROkEfM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgAG0DVoI0M9tIaqajZP6C9Sy9/VFz5l8418rOFXu4sCUcn71Mv70/Uskxn6xs8ZNRasevs5SEBfUt/f3orjtpqLQyxo4JbrviDhgc8p7b/9RCftlHgSEoSmW5gHrp2wHfkmsRKHR6kH5QSywRtDkLEfEktOQWsa+pRxCR0B1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q0D219xi; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5dca997d29eso4052898eaf.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724770254; x=1725375054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMEhLTTiqmBwY1nXaDK4IjIztlks0giYedmAFfB8Fwc=;
        b=Q0D219ximTRFJJ4MNWZAg1CMJ+HHtAiF4URWZcBj4uTyWvoX4OY/zFDTwSMIYPQgAh
         G7mmPVp+QE6RKBk8fwVkavHT9UVIvuZehGYqe9tyCaJNvdsjKEloOoW97Hbxk+T+riBU
         WuokYxB8chQwR8WR7GO2MfKseUWmKtOQ9LHfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770254; x=1725375054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMEhLTTiqmBwY1nXaDK4IjIztlks0giYedmAFfB8Fwc=;
        b=VjYRscNTt/2HdxD6oFHqR5SKyp4e7OFJx8U4RXT4N+2rMdI3PTaXc+wbs/vaL9+oTb
         hgBuLiV35x3qBoMjofpaoOpuwDdjkJzubGxsKBaF+rEelySCjoSXCVyVmHqTLwqTISe3
         7PkqDHaHm3R+/aeJc4P3vfQ+mR2yyXkMUOWxBWB8VXu/qOHkqgUt1O4d81ZNGDTUePMS
         i9T5gzRmpqCCKrBrpbvvobv/4fLQyjWMlT2AR0SpQOwnK571WK1rntGr898la6qbtHzJ
         aCmnKOfJCIYitjmNnq/ddy0OjHoju2lzdidXK61nvaZBfd3lfVMP2gxFiJNuZjTPkYRF
         4TJg==
X-Forwarded-Encrypted: i=1; AJvYcCVfb9f8bigucLSF8h3GRUXdc4ghDC5aUWf4pZOffKkfX3cByazKApjoRIwucKhDNHZNNR4wbYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0M0boyEzYqYma0qJGpehPLTxCLAHcX3DGgFGuzNgein3gVkT
	y4r04/y0x9i4LzWtOJdAzuINEnKxz9klvDo/BipeeFSYB7GHT8nKG232LEyg+g==
X-Google-Smtp-Source: AGHT+IHatlFAvK6uXGDuOiOcHjDE37TG9ucPimxIcM7gtB4jyoTqbUPJ3VH2CYXi75P14ZJFtn+zNQ==
X-Received: by 2002:a05:6359:4c04:b0:1aa:c8b7:4224 with SMTP id e5c5f4694b2df-1b5c3a6a7fbmr1146323355d.17.1724770254273;
        Tue, 27 Aug 2024 07:50:54 -0700 (PDT)
Received: from C02YVCJELVCG ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3199dasm558635285a.15.2024.08.27.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:50:53 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Tue, 27 Aug 2024 10:50:51 -0400
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, Jonathan.Cameron@huawei.com,
	helgaas@kernel.org, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, alex.williamson@redhat.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, manoj.panicker2@amd.com,
	Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
	horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
	lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
Message-ID: <Zs3ny988Yk1LJeEY@C02YVCJELVCG>
References: <20240822204120.3634-1-wei.huang2@amd.com>
 <20240822204120.3634-12-wei.huang2@amd.com>
 <20240826132213.4c8039c0@kernel.org>
 <ZszsBNC8HhCfFnhL@C02YVCJELVCG>
 <20240826154912.6a85e654@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826154912.6a85e654@kernel.org>

On Mon, Aug 26, 2024 at 03:49:12PM -0700, Jakub Kicinski wrote:
> On Mon, 26 Aug 2024 16:56:36 -0400 Andy Gospodarek wrote:
> > We plan to replace these calls with calls to stop and start only that
> > ring via netdev_rx_queue_restart as soon as these calls all land in
> > the same tree.  Since this set is [presumably] coming through
> > linux-pci we didn't think we could do that yet.
> > 
> > Thoughts?
> 
> The merge window is in 3 weeks or so, so this can wait.

Are you asking for the patch for this feature to include the queue
stop/start instead of this?  I just checked linux-pci and it does have
bnxt_queue_stop/bnxt_queue_start.

> I'm worried we'll find out later that the current queue reset
> implementation in bnxt turns out to be insufficient. And we'll
> be stuck with yet another close/open in this driver.

The queue reset _has_ to work.  We will ensure that it does and fix any
problems found.  Note that these have been under test already internally
and fixes are/will be posted to the list as they are made.  Holding this
patch because an API that it uses might not work seems odd.


