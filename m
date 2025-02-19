Return-Path: <netdev+bounces-167737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4901A3BF73
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB797A43BF
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5351E1A18;
	Wed, 19 Feb 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="UH9i82fT"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07622AD00
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970502; cv=none; b=uPQczc++bH5EMcmJrlETCpQlQbaXV6b/3ymeD5G+XjKML77UGG4iHUmxAWA3WtSGOdYNPxpMgok02/YG+m81v1qlSN0EkeuTD01mlwaLr6oRh+njm8nExyBxp4Ve6DSTTasB6JV8vs67/ajQ6SgRw+HZxhz4dyR3gca8uu/brxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970502; c=relaxed/simple;
	bh=MUhvxhHnTvoE+duYjJ7YbfPA0nuYQDtOLydS3RR3bNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=di2Ua+RBCZqm2YCyYiB0qetgcuA+5fZjIr2B3NoqTf5tNgKhPd4XdAzFDozLBUvwvu3XGy6JjfwaO+m9DnQuIr/E0PxM8ZSzFsfuPVL3BagYyyaxYiEqSqtnT7ZiQJ1r0roJQg/R8C5dTSB+eQ4zbzZYA6F9Zdi3XslL4APBhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=UH9i82fT; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 00955240028
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 14:08:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739970499; bh=MUhvxhHnTvoE+duYjJ7YbfPA0nuYQDtOLydS3RR3bNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=UH9i82fTg1h7w7390ECacBPovUQoE8P/G5GNVXYseGnWGCVDOfKQ5PyhulAe9YWgM
	 oyTMO0GRgM+BGAb1yk2PX8U0Jez7tWa3rWWsM3L0wN7OiFtRvw8Z86NXQQc00rW0a2
	 bGN9zqUxK+CRxw41x+UPWFS66pL0+d1Bmi0LqYqu41Tltg7EoGEoWN7cUYhyiMIcBi
	 IRGjwKoOVVWBHDLTjvUrytTcrYIVeMYvlhWOcFQgLEEolpENntmiIchN+J48caOyVV
	 anSpO8RUVC/wueOuEqucDUR/JBUQjagjTyrWKotNUIQS6c5YyhA244D7EfF8rJKH+J
	 WyT0bq9Dz/AqA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YycC36ZPlz9rxQ;
	Wed, 19 Feb 2025 14:08:15 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,  tmgross@umich.edu,
  hkallweit1@gmail.com,  linux@armlinux.org.uk,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  netdev@vger.kernel.org,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: qt2025: Fix hardware revision check comment
In-Reply-To: <c83a4d5f-3e98-4fec-a84a-669f04677774@lunn.ch>
References: <20250218-qt2025-comment-fix-v1-1-743e87c0040c@posteo.net>
	<20250219.100200.440798533601878204.fujita.tomonori@gmail.com>
	<c83a4d5f-3e98-4fec-a84a-669f04677774@lunn.ch>
Date: Wed, 19 Feb 2025 13:08:07 +0000
Message-ID: <87jz9m13rc.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Lunn <andrew@lunn.ch> writes:

> On Wed, Feb 19, 2025 at 10:02:00AM +0900, FUJITA Tomonori wrote:
>> On Mon, 17 Feb 2025 23:53:50 +0000
>> Charalampos Mitrodimas <charmitro@posteo.net> wrote:
>> 
>> > Correct the hardware revision check comment in the QT2025 driver. The
>> > revision value was documented as 0x3b instead of the correct 0xb3,
>> > which matches the actual comparison logic in the code.
>> > 
>> > Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>> > ---
>> >  drivers/net/phy/qt2025.rs | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
>> > index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..7e754d5d71544c6d6b6a6d90416a5a130ba76108 100644
>> > --- a/drivers/net/phy/qt2025.rs
>> > +++ b/drivers/net/phy/qt2025.rs
>> > @@ -41,7 +41,7 @@ impl Driver for PhyQT2025 {
>> >  
>> >      fn probe(dev: &mut phy::Device) -> Result<()> {
>> >          // Check the hardware revision code.
>> > -        // Only 0x3b works with this driver and firmware.
>> > +        // Only 0xb3 works with this driver and firmware.
>> >          let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
>> >          if (hw_rev >> 8) != 0xb3 {
>> >              return Err(code::ENODEV);
>> 
>> Oops,
>> 
>> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> 
>> Given that this patch is expected to be merged via netdev, you might
>> need to resend with a proper subject:
>> 
>> https://elixir.bootlin.com/linux/v6.13/source/Documentation/process/maintainer-netdev.rst
>
> Please also include a Fixes: tag.
>
> 	Andrew

Hi Andrew,

Included it, as the documentation states.

A v2 patch is up[1].

C. Mitrodimas

[1]: https://lore.kernel.org/rust-for-linux/20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net

