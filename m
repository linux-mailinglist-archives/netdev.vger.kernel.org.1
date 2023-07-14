Return-Path: <netdev+bounces-18036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8145375453D
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 01:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AD71C2165F
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 23:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5BE2772E;
	Fri, 14 Jul 2023 23:01:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DBB2C80
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 23:01:40 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FA83594
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qpJvNL+t8Hog1pKq7NUbiWNX/O0ahKnhN2A4HE2k0Zs=; b=kLW4iyp5c6b9WCmDRNaPRKpOzi
	4/phE5zK8Tw6RrnPJPAQE0rW8Wjuic+VH1eN6NRoRItEH2Drvdn8802ue2UNfZRuY5gcdKeUPJVtK
	RbdivElij8XueVnVDn2JeszH/zO6Wkgsn5trNIklx23f4cziyS8yJ8D+hX6bpnYpQZxQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qKRn5-001OcW-Sn; Sat, 15 Jul 2023 01:01:35 +0200
Date: Sat, 15 Jul 2023 01:01:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Query on acpi support for dsa driver
Message-ID: <af5a6be0-40e5-4c05-ac25-45b0e913d8aa@lunn.ch>
References: <5D6DFE0F-940B-4AAD-AD39-B8780389B67E@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D6DFE0F-940B-4AAD-AD39-B8780389B67E@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 12:38:24PM -0700, SIMON BABY wrote:
> Hello Team ,

> I am new to this group . I have a query on adding a switch device (
> microchip EVB-KSZ9897) to my Intel based x86 board which uses ACPI
> instead of device tree. The Intel x86 is running Linux Ubuntu 5.15
> kernel .

> Do I need any changes in the drive code to get the acpi table and
> invoke the functions ? When I looked the code
> drivers/net/dsa/microchip/ksz9477_i2c.c it has support only for DSA.

> Please provide your inputs .

ACPI is generally not used for networking. Nobody who cares enough
about ACPI has taken the time to understand the DT concepts, find the
equivalent in ACPI, write a proposal to extend the ACPI standard, get
it accepted in, and then done the implementation work.

What some people have tried in the past is just accept DT is the way
describe this sort of hardware, and stuff all the DT properties into
ACPI tables. But they often do it wrongly, including all the DT
legacy, deprecated properties etc.

The mv88e6xxx driver can be instantiated via a platform driver. I have
a couple of x86 targets with drivers placed in drivers/platform/x86
which instantiate mv88e6xxx instances. For simple setups, using just
the internal PHYs that is sufficient.

Take a look at drivers/platform/x86/asus-tf103c-dock.c and how it uses
i2c_new_client_device() to instantiate i2c devices. And
mv88e6xxx_probe() and its use of pdata.

	Andrew

