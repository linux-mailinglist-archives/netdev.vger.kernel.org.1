Return-Path: <netdev+bounces-32141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6079304C
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACC92810FD
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF99DF69;
	Tue,  5 Sep 2023 20:49:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D73DF5B
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 20:49:10 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD0413E
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CeNDtAB6gX7J33VWSLt6t2SaI82aFj4GEgmz7lB1s3w=; b=4Islq8jbsBDZqHRIth7nHYXgiP
	082gn69IOpNbdmVFIsPAgWJdW6hzRY4n0AAVuuN0iIHPD+K++gr9WfQTFUbx4hs70nU+tDCMd28+L
	QH5uyf28dU+JuhKvWhd3REcS6LOsXkHshycrVkZ2luJFSKxOJCjVd9Mqy7Um4M6qNaxw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qdcyx-005pTK-TO; Tue, 05 Sep 2023 22:49:07 +0200
Date: Tue, 5 Sep 2023 22:49:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sergio Callegari <sergio.callegari@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Regression with AX88179A: can't manually set MAC address anymore
Message-ID: <0612d8cc-50ef-4787-bb4d-9661655cdd72@lunn.ch>
References: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 01:02:22PM +0200, Sergio Callegari wrote:
> Hi, reporting here as the issue I am seeing is cross distro and relevant to
> recent kernels. Hope this is appropriate.
> 
> I have a USB hub with AX88179A ethernet. I was able to use it regularly,
> until something changed in recent kernels to have this interface supported
> by the cdc_ncm driver. After this change it is not possible anymore to work
> with a manually set MAC address.
> 
> More details:
> 
> - before the kernel changes, the interface was supported by a dedicated
> kernel driver. The driver had glitches but was more or less working. The
> main issue was that after some usage the driver stopped working. Could fix
> these glitches with the driver at
> https://github.com/nothingstopsme/AX88179_178A_Linux_Driver
> 
> - after the kernel changes, loading the ax88179_178a.ko does not create a
> network device anymore. The interface can be used with the cdc_ncm driver,
> however it is not possible anymore to use a manually set MAC address.

The cdc_ncm driver has a .ndo_set_mac_address implementation which
only changes the MAC address in the net_device structure. The
ax88179_178a driver however performs a hardware access:

       /* Set the MAC address */
        ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN,
                                 ETH_ALEN, net->dev_addr);

So it is quite likely that with the cdc_ncm driver, the hardware is
still performing ingress filtering based on the manufacturers assigned
MAC address, not the MAC address configured via ip link set.

I don't know the CDC NCM protocol, so i've no idea if this access is
part of the protocol. If it is, the cdc_ncm driver should be extended.

     Andrew

