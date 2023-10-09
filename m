Return-Path: <netdev+bounces-39075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5003C7BDCB9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817B31C2091D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA56101CC;
	Mon,  9 Oct 2023 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nNN9YEwI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DA321D;
	Mon,  9 Oct 2023 12:48:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC92A6;
	Mon,  9 Oct 2023 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cq0Ah4r/9RVySFnKCKXP+J/XM6uImlqRxn1SBUfj2MA=; b=nNN9YEwI3UPla+E3R3aXQLGJft
	vULgXtrELRpx9qWXB0go4iw5maABpV32SX7C0TvIBBDmkoq+Lroxt3UlgREj/HoMOmyqN6Tk75YEn
	zFeRdmH1D1/MMQGANMs429smCH8ztACF2whVUZdGHnm3ji8QQQW0BDgPg2UiJvdyKzvY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qppgO-000sNz-SM; Mon, 09 Oct 2023 14:48:24 +0200
Date: Mon, 9 Oct 2023 14:48:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
Message-ID: <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 10:39:09AM +0900, FUJITA Tomonori wrote:
> This patchset adds Rust abstractions for phylib. It doesn't fully
> cover the C APIs yet but I think that it's already useful. I implement
> two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
> they work well with real hardware.
> 
> The first patch introduces Rust bindings for phylib.
> 
> The second patch updates the ETHERNET PHY LIBRARY entry in MAINTAINERS
> file; adds the binding file and me as a maintainer of the Rust
> bindings (as Andrew Lunn suggested).
> 
> The last patch introduces the Rust version of Asix PHY drivers,
> drivers/net/phy/ax88796b.c. The features are equivalent to the C
> version. You can choose C (by default) or Rust version on kernel
> configuration.

I at last got around to installing a rust tool chain and tried to
build the code. I get what looks like linker errors.

linux$ make LLVM=1 rustavailable
Rust is available!

dpkg says:

+++-==============-============-============-=================================
ii  llvm           1:16.0-57    amd64        Low-Level Virtual Machine (LLVM)

I build with

make LLVM=1

and get lots of warnings like:

vmlinux.o: warning: objtool: _RINvNtCs4KbNGwnAC5t_4core3ptr13drop_in_placeANtNtNtB4_5ascii10ascii_char9AsciiCharja_EB4_+0x0: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RINvNtCs4KbNGwnAC5t_4core3ptr13drop_in_placeFUPuENtNtNtB4_4task4wake8RawWakerEB4_+0x0: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RINvNtCs4KbNGwnAC5t_4core3ptr13drop_in_placeINtNtB4_6option6OptionINtNtNtNtB4_4iter8adapters7flatten7FlattenINtBJ_8IntoIterNtNtB4_4char11EscapeDebugEEEEB4_+0x0: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RINvNtCs4KbNGwnAC5t_4core3ptr13drop_in_placeNtNtB4_3fmt5ErrorEB4_+0x0: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RINvNtCs4KbNGwnAC5t_4core3ptr13drop_in_placesEB4_+0x0: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RNvMNtCs4KbNGwnAC5t_4core3f32f8classify+0x5a: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RNvMNtCs4KbNGwnAC5t_4core3f32f16partial_classify+0x1f: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RNvMNtCs4KbNGwnAC5t_4core3f32f13classify_bits+0x28: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RNvMNtCs4KbNGwnAC5t_4core3f32f7next_up+0x32: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RNvMNtCs4KbNGwnAC5t_4core3f32f9next_down+0x34: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RNvMNtCs4KbNGwnAC5t_4core3f32f8midpoint+0xc3: 'naked' return found in RETHUNK build
vmlinux.o: warning: objtool: _RNvNvMNtCs4KbNGwnAC5t_4core3f32f7to_bits13ct_f32_to_u32+0x4a: 'naked' return found in RETHUNK build

Any ideas?

    Andrew

