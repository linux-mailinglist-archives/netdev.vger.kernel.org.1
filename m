Return-Path: <netdev+bounces-25943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8357763FD
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A0E281B3F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330EA1AA9A;
	Wed,  9 Aug 2023 15:37:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723618AE1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1E1C433C8;
	Wed,  9 Aug 2023 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691595428;
	bh=ufPZIg/qpiTd4SJjTTNqYUrj5vd1QGcOnX4LIz8tWhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RV1s2dotCeUuPINGSGkqenfwghXCWczbe+YSnk+ipqwHxyoEu10k01UDXZ+WYwmtR
	 b44vdxhnF7HO6XBTxK/ncMyiiXwwiUI2svRFPuGpmkN29seg6XJa+zST79EVX8f3bR
	 IwMOUw4zvtNnqCoLyG6H0KRfCHvD7TpyAq1uQUtRysOP2nnK1CSwuiUOtL3UzAwXtK
	 Y8KLgrj5gQMAfwTbhPoabPI1V56hhX6zPj3BkNz/8EvLHVRZhuAyhO0lUQOW8FJRKx
	 NmfbA0iUP3rfOEAnfTZlfVgwbSzfCoYl7bN38p+sjkCX/1W6CeIvIo6xe7HqGpTNPc
	 LA7/YvC2HF3Jw==
Date: Wed, 9 Aug 2023 10:37:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Liu Peibao <liupeibao@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2 pci/net 1/3] PCI: move OF status = "disabled"
 detection to dev->match_driver
Message-ID: <20230809153706.GA340945@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809144549.ksw3slllph6kqwg7@skbuf>

On Wed, Aug 09, 2023 at 05:45:49PM +0300, Vladimir Oltean wrote:
> Hi Bjorn,
> 
> On Tue, Aug 08, 2023 at 05:21:07PM -0500, Bjorn Helgaas wrote:
> > I think this makes good sense, but let me make sure I understand how
> > this works.
> > 
> > I *think* what's happening is that this Function 0 responds to config
> > reads, so PCI enumeration starts by discovering it normally.  But
> > after 6fffbc7ae137 ("PCI: Honor firmware's device disabled status"),
> > we abort in pci_setup_device() if the DT or ACPI status is "disabled,"
> > which means there's no struct pci_dev for it, no quirks can run on it,
> > and no driver can bind to it.  And, since PCI multi-function devices
> > must have a Function 0, we don't enumerate the other functions of this
> > device.
> > 
> > That's a problem because (1) you need to do some initialization on
> > Function 0 even though you don't want a driver to claim it, and
> > (2) this is a multi-function device and you need to enumerate the
> > other functions.
>
> Correction: on functions 0, 1, 2 and 6 (all have
> PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF), and not just on function
> 0. The particular nature of a hardware IP bug/afterthought makes
> this necessary.

Thanks, so (2) is only relevant to function 0, but (1) applies to
other functions as well.

> You may have given the netdev maintainers some mixed signals with the
> rewording suggestion plus the ack for my wording, and now we have commit
> 1a8c251cff20 ("PCI: move OF status = "disabled" detection to
> dev->match_driver") in the net.git tree.
> 
> I think we are mostly on the same page about what is changing, it's just
> that we are focusing on different aspects of it in the description.
> 
> I hope you're ok if we close the topic the way things are now? :)

Yep, my fault for forgetting how netdev works.  Thanks for your
patience.

Bjorn

