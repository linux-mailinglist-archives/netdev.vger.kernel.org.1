Return-Path: <netdev+bounces-39232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A697BE5E7
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211422818BA
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEBE37CA5;
	Mon,  9 Oct 2023 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nneWO9Mh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B135894;
	Mon,  9 Oct 2023 16:09:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A7691;
	Mon,  9 Oct 2023 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tkLoPuAmDfRZ3pQKJbR2tXFKWqRix4Ak4xxSNx1VgGY=; b=nneWO9Mh/dNKEIJx//R4XX9bRW
	L30QML+UJ8JEu1lJtm1zWTrlyvgqRlotSEh8ZOCMIeYe02JDHGJvhj/ckYIqF532byVYu2Y+OnxT5
	iRu+vG2412jAZ3HEIiSTVxjnXSk7Inook2udnZnbVBdElAGJ/lGmu1ev2mH0c5lZ94QA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qpsp4-000vpT-Ct; Mon, 09 Oct 2023 18:09:34 +0200
Date: Mon, 9 Oct 2023 18:09:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <59affc74-862f-45e1-ac42-9a2007db4c97@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-4-fujita.tomonori@gmail.com>
 <ZSOqWMqm/JQOieAd@nanopsycho>
 <bdfac30f-364f-4625-a808-fcffab2f75b4@lunn.ch>
 <CANiq72k4F4EY-cLYMsRFsAnjd9=xyMN_4eHS9T7G1s=eW7kHjw@mail.gmail.com>
 <fd715b79-3ae2-44cb-8f51-7a903778274f@lunn.ch>
 <CANiq72=OAREY7PNyE2XbFzLhZGqaMPGDg3Cbs5Lup0k5F7fnGg@mail.gmail.com>
 <CANiq72mVRO18ZCFBnKPbJfxkD6A5hsOoVwk8Sef7rVX7GnTBzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mVRO18ZCFBnKPbJfxkD6A5hsOoVwk8Sef7rVX7GnTBzg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The goal of the call is to get the different parties involved, since
> there are quite a few trying to upstream different bits and pieces
> around networking. In particular, we want to discuss having
> a`rust-net` branch where everybody can work together on the networking
> abstractions and iterate there.
> 
> So that is another alternative. Of course, the `rust-net` branch could
> be in the networking tree instead.

My experience is, you need to use the netdev mailing list. Anything
which is not developed in full few of netdev is very likely to get
ripped to shreds and has no chance of being merged. As an extension to
that, you should be targeting net-next.

The mailing list has multiple purposes, one of which is education. The
netdev community needs to learn about Rust, in the same way the Rust
community needs to learn about netdev. If this experiment is a
success, i expect Rust code to be no different to C code. It gets
posted to netdev, it gets run through the netdev CI, and eventually
merged via net-next.

	Andrew

