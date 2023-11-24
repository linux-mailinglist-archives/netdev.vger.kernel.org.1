Return-Path: <netdev+bounces-50936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A219D7F79A2
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 17:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33091C20B0A
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E133067;
	Fri, 24 Nov 2023 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4k9m2a4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8B31754
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 16:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48056C433C7;
	Fri, 24 Nov 2023 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700844290;
	bh=NJapw9r3ZsOAeD3DLgBX296z/MrigR0DCtZT3hKOuio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4k9m2a4J9+l7t92XW0tq7E2AGmFIHF8IEv1SRcnzBSfDM0wdUsdiZgHk8vTWBu2N
	 W/DWQx5bh/90B+Ovbi3JN+QIgBg15UmPMVAI2Ovf3gpMa6hkHVVHJTKpGkGEchrgpH
	 BsqjV3yoAPwlpNOf/KUZNB53n132RYkLmRgmjP60xJVwfVEBkXLZfz0PZch2EGZCHi
	 o4gJ2BdTFtzsJBnLv4FmLWhHz61Qvmp5JtblTC7Gl4ZPxnPDvUB0WwZBX+1+aBQ04I
	 86rwDeck8aeosh72G27uZtMgOVcFmz9dAJSl41HAntepBR6IJ4hOjq8JfbpYdULEpl
	 wEcvPyITv6i0w==
Date: Fri, 24 Nov 2023 16:44:45 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231124164445.GS50352@kernel.org>
References: <20231121-feature_firmware_error_code-v2-1-f879a7734a4e@bootlin.com>
 <20231121173022.3cb2fcad@kernel.org>
 <20231122114325.5bacca5a@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122114325.5bacca5a@kmaincent-XPS-13-7390>

On Wed, Nov 22, 2023 at 11:43:25AM +0100, Köry Maincent wrote:
> On Tue, 21 Nov 2023 17:30:22 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Tue, 21 Nov 2023 11:50:35 +0100 Kory Maincent wrote:
> > > No error code are available to signal an invalid firmware content.
> > > Drivers that can check the firmware content validity can not return this
> > > specific failure to the user-space
> > > 
> > > Expand the firmware error code with an additional code:
> > > - "firmware invalid" code which can be used when the provided firmware
> > >   is invalid  
> > 
> > Any idea what this is?
> > 
> > lib/test_firmware.o: warning: objtool: test_fw_upload_prepare() falls through
> > to next function __cfi_test_fw_upload_cancel()
> > 
> > My build shows this on an incremental clang 17 build.
> 
> For my curiosity, how do you get this error?
> 
> Enabling test_firmware and building with W=1 does not show the error.

Hi Kory,

I am able to observe this warning when compiling with clang-16

make LLVM=1 lib/test_firmware.o

...

