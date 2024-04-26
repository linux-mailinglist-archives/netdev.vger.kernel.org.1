Return-Path: <netdev+bounces-91728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE038B3A10
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9ED1C24081
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC601DDD6;
	Fri, 26 Apr 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnAPieR8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCDE1DFFC
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141852; cv=none; b=PrgH0spWrFj8ZGU/eAYBPU0ccJo23wZuk2G2j9iHHryopvsuSEmylJ5KvnzVG54Ff7oxsTB8APGxvbO9OcTx32vQMOonylFg/zNek2bNkHnYYMDMkA/PY5T7tB8uzRTV0atbzxbroMG5QiaoD1bUf4WbZKoRjYSVbpwkMdZcwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141852; c=relaxed/simple;
	bh=oPAF65Iv0IVA9xoI/dCjL7CezohA2J2fKenKSVL0DM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHFP/NOLs681Uj09xmyQXnIhFm5ykEX7iaMV3Uaq0RK7A0iZHfsTM3Jxl4fvkXUp4hSfX2/BSNcelDckbQrfUBbsTkzJ0GUfRn0XMWmutz/ioL3B9F8Vsd7UYwqgRGmi/aJeYtAyNUm7o11PgOtgVmIQGi6bUWjPlrx2KE7IE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnAPieR8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714141849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Po/iEila9vOgF/cEwaFixGoYPv3NXGuCxcYDjenzE0=;
	b=JnAPieR8UzOeQk5crIFGtl1VblGnI3np71U9/h2hcIcLYeUJlusG/2J6kitQU+Gen4RChS
	Fp4BWBoJ6A6hURAW3J7YrjFu0rI9P6VBkdp7k4pN6CAF2nhnqqG7Qc1Zul20gfUI6i1zUp
	PN64if2sNdFEk5miIJewLcarWCcIGPY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-Tp7iL8TsOVCes_nIrxZPwg-1; Fri,
 26 Apr 2024 10:30:45 -0400
X-MC-Unique: Tp7iL8TsOVCes_nIrxZPwg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0A033819C61;
	Fri, 26 Apr 2024 14:30:44 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 952C140F566;
	Fri, 26 Apr 2024 14:30:44 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 41EC3A80B9E; Fri, 26 Apr 2024 16:30:43 +0200 (CEST)
Date: Fri, 26 Apr 2024 16:30:43 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
Message-ID: <Ziu6k5cjXsaUpAYH@calimero.vinschen.de>
Mail-Followup-To: Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240423134731.918157-1-vinschen@redhat.com>
 <CANn89iKv1J3AS3rEmEhFq5McHmM+L=32pWg3Wj4_drsdKUx77A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKv1J3AS3rEmEhFq5McHmM+L=32pWg3Wj4_drsdKUx77A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi Eric,

On Apr 23 16:10, Eric Dumazet wrote:
> On Tue, Apr 23, 2024 at 3:47 PM Corinna Vinschen <vinschen@redhat.com> wrote:
> >
> > From: Paolo Abeni <pabeni@redhat.com>
> >
> > Sabrina reports that the igb driver does not cope well with large
> > MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> > corruption on TX.
> >
> > An easy reproducer is to run ssh to connect to the machine.  With
> > MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.
> >
> > The root cause of the issue is that the driver does not take into
> > account properly the (possibly large) shared info size when selecting
> > the ring layout, and will try to fit two packets inside the same 4K
> > page even when the 1st fraglist will trump over the 2nd head.
> >
> > Address the issue forcing the driver to fit a single packet per page,
> > leaving there enough room to store the (currently) largest possible
> > skb_shared_info.
> >
> > Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")
> > Reported-by: Jan Tluka <jtluka@redhat.com>
> > Reported-by: Jirka Hladky <jhladky@redhat.com>
> > Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> > Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> > Tested-by: Corinna Vinschen <vinschen@redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v2: fix subject, add a simple reproducer
> >
> >  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index a3f100769e39..22fb2c322bca 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
> >
> >  #if (PAGE_SIZE < 8192)
> >         if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> > +           SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
> 
> I wonder if adding IGB_SKB_PAD would be needed ?
> 
> adapter->max_frame_size does not seem to include it.
> 
> I would try using all mtus between 1200 and 1280 to make sure this works.

Erm... did you mean between 1500 and 1580 by any chance?  1200 doesn't
really seem to make sense...

I tested this patch now with mtu 1500, 1540 and 1580 successfully.

Either way, I'm just heading into vacation, so I guess I'll pick this up
again when I'm back, unless Paolo takes another look during my absence.


Thanks,
Corinna


