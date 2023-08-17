Return-Path: <netdev+bounces-28383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF9A77F454
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5421C21384
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2C1C38;
	Thu, 17 Aug 2023 10:31:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC5134BD
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:31:31 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9BC2D54
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:31:30 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-Nc7mE_lqP3uzAdE5X4GxPA-1; Thu, 17 Aug 2023 06:31:26 -0400
X-MC-Unique: Nc7mE_lqP3uzAdE5X4GxPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1528B3C100A2;
	Thu, 17 Aug 2023 10:31:26 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 54F5CC15BAD;
	Thu, 17 Aug 2023 10:31:24 +0000 (UTC)
Date: Thu, 17 Aug 2023 12:31:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Message-ID: <ZN32-0fwIMtrc9lu@hog>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
 <ZN00NB7RayXAl80f@hog>
 <c28591b1-812f-b593-ef83-72e972d5b7bd@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c28591b1-812f-b593-ef83-72e972d5b7bd@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-08-17, 11:25:36 +0300, Radu Pirea (OSS) wrote:
> 
> 
> On 16.08.2023 23:40, Sabrina Dubroca wrote:
> > 2023-08-11, 18:32:48 +0300, Radu Pirea (NXP OSS) wrote:
> > > Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
> > > the ethernet frame. This operation will increase the frame size with 32
> > > bytes.
> > 
> > "up to 32 bytes"?
> 
> Yes, up to 32 bytes.
> 
> > 
> > The SecTAG and ICV can both be shorter, at least with the software
> > implementation.
> > 
> > 
> > [...]
> > > +static struct sk_buff *insert_tx_tag(struct sk_buff *skb,
> > > +				     struct net_device *dev)
> > > +{
> > [...]
> > > +
> > > +	ctx.secy = &macsec->secy;
> > > +	ctx.skb = skb;
> > 
> > I think it would be a bit more readable to just pass the skb to
> >   ->mdo_insert_tx_tag instead of adding it to the context.
> 
> Since this function requires only the skb and the phydev, I would move
> mdo_insert_tx_tag from macsec_ops to a new structure called mascec_tag. What
> do you think about this?

I think it's ok to leave it in macsec_ops.

[...]
> > > @@ -4137,6 +4211,11 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
> > >   			if (err)
> > >   				goto del_dev;
> > >   		}
> > > +
> > > +		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
> > > +		dev->needed_headroom += ops->needed_headroom;
> > > +		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
> > > +		dev->needed_tailroom += ops->needed_tailroom;
> > 
> > If the driver doesn't set ops->needed_headroom, we'll subtract
> > MACSEC_NEEDED_HEADROOM and not add anything back. Is that correct for
> > all existing drivers? (and same for tailroom)
> 
> It should be. However, I will do this operation only for the PHYs that needs
> to parse a tag.
> 
> > 
> > You set needed_tailroom to 0 in your driver, but the commit message
> > for this patch says that the HW needs space for the ICV. I'm a bit
> > puzzled by this, especially since MACSEC_NEEDED_TAILROOM already
> > reserves space for the ICV.
> 
> The 32 bytes headroom will compensate for 0 bytes tailroom.

Ok.


One more question about the ordering of patches in this series: is
macsec offload with your device functional without this and the final
patch? Otherwise, I would put this patch first, and then the driver
patches (either collapsed into a single patch, or preferably split out
if there's a reasonable way to do it -- patch 3 is really huge and
hard to review).

-- 
Sabrina


