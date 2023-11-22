Return-Path: <netdev+bounces-49911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786EF7F3CAD
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 05:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CA228102D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF5BE73;
	Wed, 22 Nov 2023 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5E1ZvHW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64385BE6C
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 04:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2902DC433C7;
	Wed, 22 Nov 2023 04:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700626368;
	bh=cMEDDio7Z6OURfHpU46qr4lxVTQ/u0ZagmwTmCa+yF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h5E1ZvHWi3BlyFkQ6LcK1Zyof1cSmvX69csTwaZOShPhogZk3VOZf/P25AnQmmiP6
	 3oKsVSNYfuTtyQVFrq+TmEXhf35K0v/K6KBFd+T3e31FHGVtsNYIdUvI457WbgF2u6
	 PtjMgASn7FnfzYIik7Th89Goyr807ry/hS9gJS3Rdy7N11ibKQhYt8WOmOINULZVeM
	 fVwLPbr42Jd28wu0IliQY14FEl0th1zqGU7itVGDfsrd7jdImEkWEvhs4mh9PhImrW
	 jW1bC9dtW4TU88Z4sE/a8cUsM/HdvPQfTVIfQoVyGE5zXlhIDBFY8Wg6d+aL2sgVEu
	 57PXedrgpLSBA==
Message-ID: <c7c8b15d-cb4e-4c5f-8466-293b437f04e6@kernel.org>
Date: Wed, 22 Nov 2023 14:12:44 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phylink: require supported_interfaces to be
 filled
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <E1q0K1u-006EIP-ET@rmk-PC.armlinux.org.uk>
 <13087238-6a57-439e-b7cb-b465b9e27cd6@kernel.org>
 <650f3c6d-dcdb-4f7e-a3d4-130a52dd3ce9@lunn.ch>
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <650f3c6d-dcdb-4f7e-a3d4-130a52dd3ce9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 22/11/23 00:29, Andrew Lunn wrote:
>> The 6350 looks to be similar to the 6352 in many respects, though it lacks
>> a SERDES interface, but it otherwise mostly seems compatible.
> 
> Not having the SERDES is important. Without that SERDES, the bit about
> Port 4 in mv88e6352_phylink_get_caps() is
> incorrect. mv88e61852_phylink_get_caps() looks reasonable for this
> hardware.
              ^^^^^^^^^^
The problem with mv88e6185_phylink_get_caps() is the cmode check fails
for me. For my 6350 hardware chip->ports[port].cmode is "9", so set to
MV88E6XXX_PORT_STS_CMODE_1000BASEX. But that is not part of the defines
used in mv88e6185_phy_interface_modes[].

Doesn't it need to be checking in mv88e6xxx_phy_interface_modes[]
for the cmode?

I see another similar function, mv88e6250_phylink_get_caps().
But that is only 10/100 capable.

So I am thinking that something like this actually makes more sense now:

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -577,6 +577,18 @@ static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
         config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
  }
  
+static void mv88e6350_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
+                                      struct phylink_config *config)
+{
+       unsigned long *supported = config->supported_interfaces;
+
+       /* Translate the default cmode */
+       mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
+
+       config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 |
+                                  MAC_1000FD;
+}
+
  static int mv88e6352_get_port4_serdes_cmode(struct mv88e6xxx_chip *chip)
  {
         u16 reg, val;
@@ -5069,7 +5082,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
         .vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
         .stu_getnext = mv88e6352_g1_stu_getnext,
         .stu_loadpurge = mv88e6352_g1_stu_loadpurge,
-       .phylink_get_caps = mv88e6185_phylink_get_caps,
+       .phylink_get_caps = mv88e6350_phylink_get_caps,
  };
  
  static const struct mv88e6xxx_ops mv88e6351_ops = {
@@ -5117,7 +5130,7 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
         .stu_loadpurge = mv88e6352_g1_stu_loadpurge,
         .avb_ops = &mv88e6352_avb_ops,
         .ptp_ops = &mv88e6352_ptp_ops,
-       .phylink_get_caps = mv88e6185_phylink_get_caps,
+       .phylink_get_caps = mv88e6350_phylink_get_caps,
  };
  
  static const struct mv88e6xxx_ops mv88e6352_ops = {


>> Using the 6352
>> phylink_get_caps function instead of the 6185 one fixes this:
>>
>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>> @@ -5418,7 +5418,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
>>          .set_max_frame_size = mv88e6185_g1_set_max_frame_size,
>>          .stu_getnext = mv88e6352_g1_stu_getnext,
>>          .stu_loadpurge = mv88e6352_g1_stu_loadpurge,
>> -       .phylink_get_caps = mv88e6185_phylink_get_caps,
>> +       .phylink_get_caps = mv88e6352_phylink_get_caps,
>>   };
>>
>>   static const struct mv88e6xxx_ops mv88e6351_ops = {
>>
>>
>> The story doesn't quite end here though. With this fix in place support
>> for the 6350 is then again broken by commit b92143d4420f ("net: dsa:
>> mv88e6xxx: add infrastructure for phylink_pcs"). This results in a dump
>> on boot up:
> 
> PCS is approximately another name of a SERDES. Since there is no
> SERDES, you don't don't want any of the pcs ops filled in.
> 
> Russell knows this code much better than i do. Let see what he says.

Ok, that makes sense. Russell had a suggestion for this one and I will
follow up with that.

Thanks
Greg



