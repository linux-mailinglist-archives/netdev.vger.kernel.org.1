Return-Path: <netdev+bounces-117181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B09794CFF3
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B21C2187D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A9193096;
	Fri,  9 Aug 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuBHoulb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21C335A5
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205791; cv=none; b=jQZA8w1DWtxbTy5fAEUkAxZZ1LdtPLuEY3+xjwkrVeDyE/Y0qrwFpAnYEMxhzJ8hFohg3WOHuMF1cKWiVP37YWnMtl25yJpafIvnSMj2VzowXdqFJl3dlv+dJWAwRwavG4IKprmcfZxB2x1aQb5W1f/zBFFfkTNB1L3z9mvPxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205791; c=relaxed/simple;
	bh=c0I23kMx95R9m2P+tX7Xl+P9GCZ7ACJmL3YCMK8WmkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGSPwFvXEsk4xbx7nx7XGhZJ64lGvV91Kmq1JZhfBwEBABN3uaGnuru3EWg5Rm3NzHV73ytuszKIoF+eLeY+MBr9jw0aKURJQLxdASPmRBkpqDU+0I0pdYYsTH4GFR9h9OprgKsA/oB3OCtPlw6Qh0NuSjP2lICp9iDnVhS/7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuBHoulb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723205788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ/Qbn4+wFIzIrFecYlUjlnZIOHPjnXZe+4zEUX6pqU=;
	b=BuBHoulb4ZFFke4VIpasmt6Yez07hkgXtFXpCCOg68wub7rGwSPlMZN2wrK/w7EdOVgxPC
	NbBrRAh6BtFShoE+SHFGdnuldUSekzbi/4sSLxZKeVSNnjUx5T8CXdyGYbgTGIno6E6yHu
	NaX+D8NuBJOdOA9BDn6nhb92iQkyVMQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-jtLL3mwbOjqk2AxOrlTP4A-1; Fri,
 09 Aug 2024 08:16:25 -0400
X-MC-Unique: jtLL3mwbOjqk2AxOrlTP4A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15C131955F42;
	Fri,  9 Aug 2024 12:16:24 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25DC819560A7;
	Fri,  9 Aug 2024 12:16:23 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B2ADCA80E86; Fri,  9 Aug 2024 14:16:20 +0200 (CEST)
Date: Fri, 9 Aug 2024 14:16:20 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Jan Tluka <jtluka@redhat.com>,
	Jirka Hladky <jhladky@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] igb: cope with large MAX_SKB_FRAGS.
Message-ID: <ZrYIlDqUc9obiyt9@calimero.vinschen.de>
Mail-Followup-To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Jan Tluka <jtluka@redhat.com>,
	Jirka Hladky <jhladky@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20240806221533.3360049-1-anthony.l.nguyen@intel.com>
 <ZrOcMAhE2RAWL8HB@boxer>
 <ZrUMZy/oxdu7m6F5@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrUMZy/oxdu7m6F5@boxer>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Aug  8 20:20, Maciej Fijalkowski wrote:
> On Wed, Aug 07, 2024 at 06:09:20PM +0200, Maciej Fijalkowski wrote:
> > On Tue, Aug 06, 2024 at 03:15:31PM -0700, Tony Nguyen wrote:
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > > index 11be39f435f3..232d6cb836a9 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > @@ -4808,6 +4808,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
> > >  
> > >  #if (PAGE_SIZE < 8192)
> > >  	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> > > +	    SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
> > 
> > We should address IGB_2K_TOO_SMALL_WITH_PADDING for this case. I'll think
> > about it tomorrow.
> 
> Actually from what I currently understand IGB_2K_TOO_SMALL_WITH_PADDING
> will give us 'true' for case you are addressing so we could reuse it here?

Well, IGB_2K_TOO_SMALL_WITH_PADDING is a constant expression evaluated
at build time.  The SKB_HEAD_ALIGN expression is dynamically computed,
basically depending on the MTU.

IGB_2K_TOO_SMALL_WITH_PADDING switches from false to true with
MAX_SKB_FRAGS set to 22 or more.

So with MAX_SKB_FRAGS set to 17, IGB_2K_TOO_SMALL_WITH_PADDING is false,
while the SKB_HEAD_ALIGN expression is true for MTUs >= 1703.

With MAX_SKB_FRAGS set to 45, IGB_2K_TOO_SMALL_WITH_PADDING is true,
the SKB_HEAD_ALIGN expression is true for MTUs >= 1255.

Given that, IGB_2K_TOO_SMALL_WITH_PADDING might be the more careful
check.  Do you want me to send a v2?


Thanks,
Corinna


