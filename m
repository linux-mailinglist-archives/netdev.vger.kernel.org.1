Return-Path: <netdev+bounces-33547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B959279E7C9
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EF91C20B31
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6A91EA8C;
	Wed, 13 Sep 2023 12:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E01EA7B
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 12:20:25 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B579519A8;
	Wed, 13 Sep 2023 05:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9fjohWWyeQwCPIoP4ypoYm41HAX/BcH8sWQeNzqML3s=; b=tO6wyliQMAg4HHakrUy4uugtK8
	0pr0AC+xQRdcusx7kPBY09WkFgvz4bXZHUcJ8QT6OMnd3IdMci0otVUK+Bo0JxJDfH73F+8kjvJ8C
	v5OrXwRktbaKnvhjJR5+rHgu8BPO6m06kPrx5u5m6RjiDeiC4AaACEkTrmbHSOBMmCus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgOqb-006Iux-2J; Wed, 13 Sep 2023 14:19:57 +0200
Date: Wed, 13 Sep 2023 14:19:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	r-gunasekaran@ti.com, Pekka Varis <p-varis@ti.com>
Subject: Re: [RFC PATCH net-next 3/4] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware on AM654 PG2.0 EVM
Message-ID: <055e781e-f614-4436-9d8d-e60e17fac5c9@lunn.ch>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-4-danishanwar@ti.com>
 <1fb683f4-d762-427b-98b7-8567ca1f797c@lunn.ch>
 <0d70cebf-8fd0-cf04-ccc2-6f240b27ecca@ti.com>
 <12c11462-5449-b100-5f92-f66c775237fa@kernel.org>
 <3fbf9514-8f9f-d362-9006-1fd435540e67@ti.com>
 <09931a97-df62-9803-967f-df6135dc3be7@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09931a97-df62-9803-967f-df6135dc3be7@ti.com>

> As discussed on this thread, switching operation can work with the ICSSG
> switch firmware, without creating bridge. However without bridge only
> forwarding works. If we want the switch to consume packets bridge is
> required.

What packets will the switch consume? The only packets i can think of
are pause frames. Everything else get passed to the CPU.

You also need to think of what happens when a single switch port is
added to the bridge, and an external port, like a tun/tap device for a
VPN is added to the bridge.

For most switches, a port not being a member of a switch means the
port is pretty dumb and every frame is forwarded to the CPU. There are
however some switches which perform address learning as usual,
learning if an address is on the port, or on the CPU. Maybe you can
see if that is possible.

It might be you need your firmware people involved to produce a new
firmware version which combines both firmwares in one.

	 Andrew

