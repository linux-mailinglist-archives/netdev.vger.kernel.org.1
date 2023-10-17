Return-Path: <netdev+bounces-41843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF83C7CC00F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCD61C2086F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB241219;
	Tue, 17 Oct 2023 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F4405D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:00:25 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11D08E;
	Tue, 17 Oct 2023 03:00:23 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8F9C030000860;
	Tue, 17 Oct 2023 12:00:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 824CDFEE3; Tue, 17 Oct 2023 12:00:22 +0200 (CEST)
Date: Tue, 17 Oct 2023 12:00:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	bhelgaas@google.com, alex.williamson@redhat.com, petrm@nvidia.com,
	jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 05/12] PCI: Add device-specific reset for
 NVIDIA Spectrum devices
Message-ID: <20231017100022.GA10711@wunner.de>
References: <20231017074257.3389177-1-idosch@nvidia.com>
 <20231017074257.3389177-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017074257.3389177-6-idosch@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 10:42:50AM +0300, Ido Schimmel wrote:
> The PCIe specification defines two methods to trigger a hot reset across
> a link: Bus reset and link disablement (r6.0.1, sec 7.1, sec 6.6.1). In
> the first method, the Secondary Bus Reset (SBR) bit in the Bridge
> Control Register of the Downstream Port is asserted for at least 1ms
> (r6.0.1, sec 7.5.1.3.13). In the second method, the Link Disable bit in
> the Link Control Register of the Downstream Port is asserted and then
> cleared to disable and enable the link (r6.0.1, sec 7.5.3.7).
> 
> While the two methods are identical from the perspective of the
> Downstream device, they are different as far as the host is concerned.
> In the first method, the Link Training and Status State Machine (LTSSM)
> of the Downstream Port is expected to be in the Hot Reset state as long
> as the SBR bit is asserted. In the second method, the LTSSM of the
> Downstream Port is expected to be in the Disabled state as long as the
> Link Disable bit is asserted.
> 
> This above difference is of importance because the specification
> requires the LTTSM to exit from the Hot Reset state to the Detect state
> within a 2ms timeout (r6.0.1, sec 4.2.7.11). NVIDIA Spectrum devices
> cannot guarantee it and a host enforcing such a behavior might fail to
> communicate with the device after issuing a Secondary Bus Reset.

How does that failure manifest itself exactly?  Is the problem that
the Vendor ID register in config space is read too early and the
device doesn't like that?

It is possible to increase the d3cold_delay in struct pci_dev to
lengthen the delay until the Vendor ID is read.  Have you considered
that instead of using the Link Disable method?

The following commit queued for v6.7 introduces a quirk for a 1 second
d3cold_delay, perhaps you can take advantage of it?

https://git.kernel.org/pci/pci/c/c9260693aa0c

Thanks,

Lukas

