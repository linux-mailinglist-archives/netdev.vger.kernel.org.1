Return-Path: <netdev+bounces-53928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474D8053BF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF05D1F212B3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE05A103;
	Tue,  5 Dec 2023 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArxQyuij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B1BC9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 04:04:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1b68ae4104so293083366b.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 04:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701777863; x=1702382663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOCHRNsSqa+2PLlcHDQrKN1JnjtDx8/+Zi9Gy8f1NXs=;
        b=ArxQyuijoTfeCu1ZFU4kHyfMPSwe/XuP+72h1rzEbWM6Q1VFPlvmlVUE2E7Ys/XTEC
         qxBbgmEfSw0IvdJY0RlHX+0wC/2w31YYvCwnM0W7nZqSTzCAVYmFKKd4p6vHTtDrpX7M
         4zpTu9yKesPKaJSaenkeU2Ho26TbakqcoNXVcT64npMiPZtgcqMwnPsqWAANtlTmXB5g
         wFt6VtHsVGdxe52i8YhZlvWI+vQwplh++rXz7zhJrvY14vlXf/aGJRQIFjQl1uvsOgII
         9KfSoUxTfSfeHRORUFwwNZ0xtRPhaTgqPB8987sQEp04uleKOSpxwavL84YXGUBKNRmX
         1QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777863; x=1702382663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOCHRNsSqa+2PLlcHDQrKN1JnjtDx8/+Zi9Gy8f1NXs=;
        b=nKIJlYlA9hLv66X/1aO2sxVMD5g/GBAIDGL3bkkto4nw6Rq9AUeKJifL43x4Go+XVm
         s1GOMWWgtkBLzsFGtK5Hy81QQzvPlGXWu9hOlJbQXirrbhDFjYmm4D/bpd8FpGSDl45G
         S1i8LQs21EUN1jT/RH8TUPKxAu0rw0cI8oxbsm3Dph/CWPRCZsCih0gCEjBc0nzfj+jL
         xOwPZ0jwlSa9KMDySMyWifEYsQn0f16Gu1fwq4GY6PYseqKUgcqV6tufjVgeKKawVa4Y
         t8dYLCRvN70NhAvDlGed7KeYPWCasDI+/XPJq0aGtQcwPSE/zTSSPOWBvGJaPOooskrg
         NG4A==
X-Gm-Message-State: AOJu0YzTF7cigDTFS6jqEyOkXn7Y8fGBuBYqZp+I7n6rvkMDxiavWOTo
	bcq44Ja+tWPGEErUtvD/Kkg=
X-Google-Smtp-Source: AGHT+IGAgX5r9tbHSgWtGxDvnoKPgQQv3ojFHdn4AELIcPYKYbbiXApHv3wsQFNQ66SB2Lg7rcAmag==
X-Received: by 2002:a17:906:c4c2:b0:a18:3897:658d with SMTP id cl2-20020a170906c4c200b00a183897658dmr420985ejb.34.1701777863216;
        Tue, 05 Dec 2023 04:04:23 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id l14-20020a170906414e00b0099c53c4407dsm6553650ejk.78.2023.12.05.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:04:23 -0800 (PST)
Date: Tue, 5 Dec 2023 14:04:21 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231205120421.yfs52kp2ttlqkwlb@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
 <20231205101257.nrlknmlv7sw7smtg@skbuf>
 <db36974a7383bd30037ffda796338c7f4cdfffd7.camel@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db36974a7383bd30037ffda796338c7f4cdfffd7.camel@embedd.com>

On Tue, Dec 05, 2023 at 12:44:41PM +0100, Daniel Danzberger wrote:
> On Tue, 2023-12-05 at 12:12 +0200, Vladimir Oltean wrote:
> > On Mon, Dec 04, 2023 at 04:43:15PM +0100, Daniel Danzberger wrote:
> > > Fixes a NULL pointer access when registering a switch device that has
> > > not been defined via DTS.
> > > 
> > > This might happen when the switch is used on a platform like x86 that
> > > doesn't use DTS and instantiates devices in platform specific init code.
> > > 
> > > Signed-off-by: Daniel Danzberger <dd@embedd.com>
> > > ---
> > 
> > I'm sorry, I just don't like the state in which your patch leaves the
> > driver. Would you mind testing this attached patch instead?
> Works fine. I could however only test the platform_data path, not the DTS path.
> 
> I would also move the 'enum ksz_chip_id' to the platform include, so instantiating code can use the
> enums to set ksz_platform_data.chip_id. (See attached patch)

Ok, looks alright. Code movement will have to be a separate patch 1/2,
to not pollute the actual code changes from 2/2.

Also, please keep my authorship information and sign off. You can post
the 2 patches as a v2 of this series (separate thread). General info:
when submitting somebody else's patch you have to add your sign off at
the end of the commit, immediately after his, so that it is apparent in
the git log that he didn't submit it himself.

The change doesn't functionally affect the DT probing path (it just
renames variables), so it's reasonable to assume that it won't break
things.

Thanks.

