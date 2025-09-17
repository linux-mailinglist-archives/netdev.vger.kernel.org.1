Return-Path: <netdev+bounces-223830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0109B7DC04
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8867F32303B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 01:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903442F39AD;
	Wed, 17 Sep 2025 01:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59C2D47EF
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758073999; cv=none; b=o94GbA4HbMLYsUdZ315usyxXkJHufV7YoIB7rLZpi1Kf7VAgliPmCxRFTUiCYcQMVI5YueuIVzAFB7gelnO/nYeIcb+3R/tjXzejp2CG4/60qzM5Cxw9A6pMJug0vI74JsSK0351THHUgZVq2/uRdwXhozsjalSOOJkigAMd9vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758073999; c=relaxed/simple;
	bh=kgeLGOrNcTYp2D9LgQs6xlhUeTiTTU12sptbKZBqwWk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=kOtmr0yrfic0sfSH8umpiKFM/yg0zthBLnT8+tBjIxjxmedwWc8HnkxVbSp/GIRG7zHSjVJSoQBVzaeEeS27UrB5HStBLMjiod+mTES43BCiK+HSNsube4MV7WBp6ulPO0qwS/LITEqlS5PRv1wlJLMZjaQ4ZslrHk/vqjq7a4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1758073906t085t05518
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.139.142])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14167441494631330915
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Alexander Lobakin'" <aleksander.lobakin@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250912062357.30748-1-jiawenwu@trustnetic.com>	<20250912062357.30748-2-jiawenwu@trustnetic.com> <20250915180133.2af67344@kernel.org>
In-Reply-To: <20250915180133.2af67344@kernel.org>
Subject: RE: [PATCH net-next v4 1/2] net: libwx: support multiple RSS for every pool
Date: Wed, 17 Sep 2025 09:51:44 +0800
Message-ID: <038c01dc2775$9f4c58f0$dde50ad0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFA/7Etsb+JxZdvJ6Pe7eBYG6K7DgGXMDePAjSuA021roooAA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NcfXIs+Ms1qHx6RmUAli/PFMB7VlAjFnL3SkGmXHY5Iy2NdHuGT1rx+n
	nkWaHyGbAl558a8W/PTBkiCEycowdvrJrTw2cAc8smAC2wTLfcmWAot1p3RMKqGzE9KRsUg
	bedFNkNXlP4rIJXZwRXpOk4lP5pXDKilAP2Lviq1Gbs1sq0XlBUkYZoQZIBuGNNd1YAJ7kk
	GSvv3UxsF56gdpCNiCDl+XrkJbGCnZydvd7gUWfgXyY6zVNyO3HjEwmfsOrF5RzVwYYI1jb
	8WOGI50RibjtLIvZUO0ENDXx5eYzZHXjaC5BWH8cHYV+YjYlS2TlBqXOarVmjdIKDl3Nc95
	ozCRP4gclCt7z3Awot54c3EUHYcoIrJjFGiJeGBS1TY2KjqjieXqVN7Gq9d0LZXwHhCxIDn
	4QM6owQ0gjzDSKP2gBY8tH46BPz94A9B7b6Se1mBc6hqKsZ8wV+10/vN839qllHQlwfyZ64
	Oq7hXnZYS6RHo0mmuwW7C5+WGN8QgNJvkb65pJsuQ2NrmVIVDhsUYDtQSkiznrfvNJeiJ2j
	GQ+mM5cpx1Byg9x7mVqbc02w442W9wJLmRbVKz+J2cm3f334pW5pfv6AwoX386EIFGHP+pP
	4PF0NlzKFC6di0taVEJQsK5yWzpWdZl07pV+AXNYCydj0EHHfg4ZcJxfChGa85RHhg7ALS3
	Dk78Vgvwaq1utsvSFoUn7HenVqjB5j63Sh1kRArnrb8utmS8v7Hbbgim4P+TuJxmwlw6B8t
	LuLPIZMMxryCZU3NrZ34jxj9TwB5E7D+vF8bLxAi6i1L9j+DnMsB8u/m2p1yEcf/7m9Pj7s
	pvaGYrb5K3wO7gjYRGn/sBpTNv9Y+qPBTdBmKOGwbGA+GhXo2lTOPu7Q6o2D9Nuem/gxaB8
	ISLEpcTSmwlQtYOMM1dbmuY9sr200XhO2t42rjNNALoxkyynGg1qzpEJkmv5zMvzgIQgTC6
	BE6lpLfHxFPeIXh2idLkmw6a7bXHt1TYRmOY3e3vRCgJ0EEWxzuzIubnaKUVI8TxFvlDxfQ
	Tl/BvZOIqSMw8jhC2zmSfxUr2f5nQ=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Tue, Sep 16, 2025 9:02 AM, Jakub Kicinski wrote:
> On Fri, 12 Sep 2025 14:23:56 +0800 Jiawen Wu wrote:
> > Subject: [PATCH net-next v4 1/2] net: libwx: support multiple RSS for every pool
> 
> "support multiple RSS" needs an object. Multiple RSS keys? Multiple
> contexts? Multiple tables?

All of these are multiple. Each pool has a different RSS scheme.

> 
> > -static void wx_store_reta(struct wx *wx)
> > +u32 wx_rss_indir_tbl_entries(struct wx *wx)
> >  {
> > +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> > +		return 64;
> > +	else
> > +		return 128;
> > +}
> 
> Is WX_FLAG_SRIOV_ENABLED set only when VFs are created?

Yes.

> What if the user set a table with 128 entries?
> The RSS table can't shrink once intentionally set to a specific size.

Deleting VFs will reset these configurations.

> 
> > +void wx_store_reta(struct wx *wx)
> > +{
> > +	u32 reta_entries = wx_rss_indir_tbl_entries(wx);
> >  	u8 *indir_tbl = wx->rss_indir_tbl;
> >  	u32 reta = 0;
> >  	u32 i;
> > @@ -2007,36 +2016,55 @@ static void wx_store_reta(struct wx *wx)
> >  	/* Fill out the redirection table as follows:
> >  	 *  - 8 bit wide entries containing 4 bit RSS index
> >  	 */
> > -	for (i = 0; i < WX_MAX_RETA_ENTRIES; i++) {
> > +	for (i = 0; i < reta_entries; i++) {
> >  		reta |= indir_tbl[i] << (i & 0x3) * 8;
> >  		if ((i & 3) == 3) {
> > -			wr32(wx, WX_RDB_RSSTBL(i >> 2), reta);
> > +			if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
> > +			    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
> > +				wr32(wx, WX_RDB_VMRSSTBL(i >> 2, wx->num_vfs), reta);
> 
> Do we need to reprogram the RSS when number of VFs change, now?

Yes. We program RSS in the device open function, which is called then
the number of VFs changed.

> 
> > +			else
> > +				wr32(wx, WX_RDB_RSSTBL(i >> 2), reta);
> >  			reta = 0;
> >  		}
> >  	}
> >  }
> >
> > +void wx_store_rsskey(struct wx *wx)
> > +{
> > +	u32 random_key_size = WX_RSS_KEY_SIZE / 4;
> 
> They key is just initialized to a random value, it doesn't have to be
> random. Just "key_size" is better.
> 
> > +	u32 i;
> > +
> > +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
> > +	    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
> > +		for (i = 0; i < random_key_size; i++)
> > +			wr32(wx, WX_RDB_VMRSSRK(i, wx->num_vfs),
> > +			     *(wx->rss_key + i));
> 
> Prefer normal array indexing:
> 
> 			     wx->rss_key[i]
> 
> > +	} else {
> > +		for (i = 0; i < random_key_size; i++)
> > +			wr32(wx, WX_RDB_RSSRK(i), wx->rss_key[i]);
> > +	}
> > +}
> 
> > -	u32 rss_field = 0;
> 
> completely unclear to me why moving rss_field to struct wx is part of
> this patch. It looks unrelated / prep for the next patch.

I'll split it, thanks.
 


