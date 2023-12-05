Return-Path: <netdev+bounces-54067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FEE805EAA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DBBB210EF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAF06A35D;
	Tue,  5 Dec 2023 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Q/Eo+FEb"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE01AB
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 11:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SkMzdOaiE/tH3KLyUGpebGooZ6m/kC6AAcd35NxWXmA=;
	t=1701804788; x=1703014388; b=Q/Eo+FEbKPrfOziPHy5XnZPDgWyqEAoY9xNRUGnOrPSvk6R
	aJoy7+UYUfnwneXoGIt5udVb0G1ZB2MGZbmXZjkUlqbDNoapBOfwj3ZCYPoOrpcUnFAfF0sjKxAT7
	oMW9yyD6H2hYTpiKy2wgjCTBQmq6YxfVA1W0ODxGnLCF9hmIOQEHBzS1kRaz0w3z2rrFlG07rQvta
	czoMk/VHCCGHUEHAoz9FaYjmfkIc05xpt6URXvwHvoYaBQtlC7rDkPg+jwl4u/V+h77iOAdXSCNev
	lAr6/sL30Zwx2SVTyBBV8JgkSkTJH1LLNVZ1brrjRU5IR93TudPfhqp/kv8Zqupg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAbAF-0000000GWCC-2rbp;
	Tue, 05 Dec 2023 20:33:03 +0100
Message-ID: <1d986c73c1d39b0cced7d8d2119fba4b2a02418b.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
From: Johannes Berg <johannes@sipsolutions.net>
To: Marc MERLIN <marc@merlins.org>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 05 Dec 2023 20:33:02 +0100
In-Reply-To: <20231205024652.GA12805@merlins.org>
References: 
	<20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	 <20231204200038.GA9330@merlins.org>
	 <a6ac887f7ce8af0235558752d0c781b817f1795a.camel@sipsolutions.net>
	 <20231204203622.GB9330@merlins.org>
	 <24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
	 <20231204205439.GA32680@merlins.org> <20231204212849.GA25864@merlins.org>
	 <20231205024652.GA12805@merlins.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-04 at 18:46 -0800, Marc MERLIN wrote:
>=20
> [13323.572484] iwlwifi 0000:09:00.0: TB bug workaround: copied 152 bytes =
from 0xffffff68 to 0xfd080000
> [13328.000825] iwlwifi 0000:09:00.0: TB bug workaround: copied 1272 bytes=
 from 0xfffffb08 to 0xff42c000
> [13367.278564] iwlwifi 0000:09:00.0: TB bug workaround: copied 1328 bytes=
 from 0xfffffad0 to 0xfec41000
> [13389.737971] iwlwifi 0000:09:00.0: TB bug workaround: copied 572 bytes =
from 0xfffffdc4 to 0xff091000
> [13389.860480] iwlwifi 0000:09:00.0: TB bug workaround: copied 148 bytes =
from 0xffffff6c to 0xfe412000
> [13393.435354] iwlwifi 0000:09:00.0: TB bug workaround: copied 360 bytes =
from 0xfffffe98 to 0xfedcd000
> [13409.827199] iwlwifi 0000:09:00.0: TB bug workaround: copied 1348 bytes=
 from 0xfffffabc to 0xfd057000

That's fine, just working around a HW bug on 2^32 address boundaries.

I had a patch a long time ago to make those messages not appear ... not
sure where it ended up.

johannes

