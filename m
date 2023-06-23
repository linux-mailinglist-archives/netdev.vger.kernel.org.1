Return-Path: <netdev+bounces-13479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073373BC14
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29276281C62
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA1DC8D3;
	Fri, 23 Jun 2023 15:53:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F955C2FD
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:53:08 +0000 (UTC)
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 08:53:06 PDT
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:1::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FA126BD;
	Fri, 23 Jun 2023 08:53:05 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:1::3])
	by unicorn.mansr.com (Postfix) with ESMTPS id 62CB315360;
	Fri, 23 Jun 2023 15:58:03 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
	id 5590D219FD4; Fri, 23 Jun 2023 15:58:03 +0100 (BST)
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, netdev@vger.kernel.org,
 Mugunthan V N <mugunthanvnm@ti.com>, Grygorii Strashko
 <grygorii.strashko@ti.com>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)"
 <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: cpsw: fix obtaining mac address for am3517
References: <1477668756-2651-1-git-send-email-jhofstee@victronenergy.com>
	<20161028155213.2t3nwwe3lqaynaer@atomide.com>
	<d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com>
	<20161028181914.mskebckucukzhxhz@atomide.com>
Date: Fri, 23 Jun 2023 15:58:03 +0100
In-Reply-To: <20161028181914.mskebckucukzhxhz@atomide.com> (Tony Lindgren's
	message of "Fri, 28 Oct 2016 11:19:14 -0700")
Message-ID: <yw1x7cru445g.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tony Lindgren <tony@atomide.com> writes:

> * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 11:19]:
>> Hello Tony,
>>=20
>> On 28-10-16 17:52, Tony Lindgren wrote:
>> > * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 08:33]:
>> > > Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading=
 mac
>> > > id to common file") did not only move the code for an am3517, it also
>> > > added the slave parameter, resulting in an invalid (all zero) mac ad=
dress
>> > > being returned for an am3517, since it only has a single emac and th=
e slave
>> > > parameter is pointing to the second. So simply always read the first=
 and
>> > > valid mac-address for a ti,am3517-emac.
>> > And others davinci_emac.c users can have more than one. So is the
>> > reason the slave parameter points to the second instance because
>> > of the location in the hardware?
>>=20
>> Sort of, the slave parameter gets determined by the fact if there is one
>> or two register range(s) associated with the davinci_emac. In davinci_em=
ac.c
>>=20
>>     res_ctrl =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>     ...
>>     rc =3D davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1,
>>                           priv->mac_addr);
>>=20
>> So it there are two ranges, the slave param becomes 0. It there is only =
one,
>> it
>> will be 1. Since the am3517 only has a single regs entry it ends up with
>> slave 1,
>> while there is only a single davinci_emac.
>
> OK thanks for clarifying it:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Is there some reason this patch was never picked up, or was it simply
forgotten?

--=20
M=E5ns Rullg=E5rd

