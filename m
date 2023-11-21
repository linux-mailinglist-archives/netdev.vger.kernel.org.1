Return-Path: <netdev+bounces-49654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C19D7F2DF6
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D11C20850
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545AE48CD2;
	Tue, 21 Nov 2023 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPPRpWpc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCE3E494;
	Tue, 21 Nov 2023 13:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BE3C433C8;
	Tue, 21 Nov 2023 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700571995;
	bh=E2Bt7AUlzEg3/l1h+uPXDSn6RG6TxVi4XHSxzWeJxzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPPRpWpcOlEajjr2/2mLS4ZZmr1chxf8czgU3WWmnUpuz4kPN/stZtGPEx8Yq2oTk
	 BxF1n0pteFLqDdhqTYPiQp4+Ih5OL0bPIj/ZcunUvlvVYyBW/vaBJrJDPSmaciSLKJ
	 JrKCWPn85RebuOLdrAmSmT/OmbPTqcrUemFsw/SeiumWfbJL+bj8mKvNf4tIDcmM9H
	 uIr8O57i9JcMihmLbjIWXTFvUnuORk4ina1tl7DhI08TWv8GwHsQNTxXxYyylUTxUs
	 lE910zg9NzT+suoioazQacXGNGXadlThuBFHXYgFx0p9e5yP8iAgbPt9dEmFa8RItu
	 j63JIJSgqFH2Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1r5QSl-00074q-0B;
	Tue, 21 Nov 2023 14:06:47 +0100
Date: Tue, 21 Nov 2023 14:06:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Lech Perczak <lech.perczak@gmail.com>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/2] usb: fix port mapping for ZTE MF290 modem
Message-ID: <ZVyrZ1Bq5UooD5xq@hovoldconsulting.com>
References: <20231117231918.100278-1-lech.perczak@gmail.com>
 <08e17879fe0c0be1f82da31fdb39931ed38f7155.camel@redhat.com>
 <4b534e6aab6e4cf461f07680466f146e65b3fb25.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b534e6aab6e4cf461f07680466f146e65b3fb25.camel@redhat.com>

On Tue, Nov 21, 2023 at 11:58:56AM +0100, Paolo Abeni wrote:
> On Tue, 2023-11-21 at 11:49 +0100, Paolo Abeni wrote:
> > On Sat, 2023-11-18 at 00:19 +0100, Lech Perczak wrote:
> > > This modem is used iside ZTE MF28D LTE CPE router. It can already
> > > establish PPP connections. This series attempts to adjust its
> > > configuration to properly support QMI interface which is available and
> > > preferred over that. This is a part of effort to get the device
> > > supported b OpenWrt.
> > > 
> > > Lech Perczak (2):
> > >   usb: serial: option: don't claim interface 4 for ZTE MF290
> > >   net: usb: qmi_wwan: claim interface 4 for ZTE MF290
> > 
> > It looks like patch 1 targets the usb-serial tree, patch 2 targets the
> > netdev tree and there no dependencies between them.
> 
> Sorry, ENOCOFFEE here. I see the inter-dependency now. I guess it's
> better to pull both patches via the same tree.
> 
> @Johan: do you have any preferences? We don't see changes on 
> qmi_wwan.c too often, hopefully we should not hit conflicts up to the
> next RC.

It should be fine to take these through the two trees, respectively, as
we usually do.

If the qmi_wwan change hits mainline first and that driver binds first,
all is good, otherwise option continues to bind until that patch is also
in mainline.

I'll go queue up the option patch now. Just let me know if you for some
reason prefer I take the qmi_wwan one too.

Johan

