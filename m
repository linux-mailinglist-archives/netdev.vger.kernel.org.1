Return-Path: <netdev+bounces-132651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330C992A53
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF01F23018
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C211D1E8E;
	Mon,  7 Oct 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4hKTL8R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418611D1319;
	Mon,  7 Oct 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301040; cv=none; b=TCs4YnFGevp/2EfwVzRl0M5AcbO3F6OW/50Ofq2lg+MdN/VReX+36ObtrRtKk6SCTP6fvpJkib/X/Z/KnOTZ1zzO5RAGQ0LZKHNFINQrc1lB/A0WgUcQxprDAn8kbB1eI1eEmy1wh8NAGe+yRloyl8Jo7TUbGPQNeSsoM5WSAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301040; c=relaxed/simple;
	bh=qFUVT27XxlMPyHzRaq5Ff0eQB5rJqB+hBA/DiCe/o/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYwDX0OUFjbQLPZY6GnWvVsixAZ9/LiF6LsVVMwpMcZjVQ7dqtPU8+mVj4U+vfIJ+xWVNi6SggsRod8rD1ilTrujCW2zQ6mT/RLZG1IB6C/E4PIbJXub8cVMKwCuF9mI+keDaAUgGLD3VxPyFg5NfGYQEyyKsvHaWD8qysnlZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4hKTL8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7167C4CEC6;
	Mon,  7 Oct 2024 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728301039;
	bh=qFUVT27XxlMPyHzRaq5Ff0eQB5rJqB+hBA/DiCe/o/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o4hKTL8RURekIxn3MQJDE5iddmNjNYcA2R30Crx/qq+AdxknNpfcviUI2dt62l5yl
	 RNoimTsa7XnM/a/SbjS1Gi6cdAJTIeBMs6dw0xzww/965QRNTOkCKqqrPtseUYIjGp
	 wvV0lBMECeHvbhUN/x5cNtZsFpFTGYuebunkwdS1jYmiiH3Ca+BVDknW77M4tOZPRt
	 HwQvJYveq1v7Q6Do1u5Gt/qLcwGIp2hL9MAMt+PIVOOiZImxjdNuQpj2h8ExgoYn8H
	 An2l1EIOvHWimPd51SgxeNsdEg0gf0/t6xub9LJ29OU+73MRV65lE9e3h7IX0en6Xe
	 tnEqdE9p5mqqw==
Message-ID: <48ca3541-df4a-4215-b81b-80d6ed8145c3@kernel.org>
Date: Mon, 7 Oct 2024 14:37:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Grygorii Strashko
 <grygorii.strashko@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241004041218.2809774-1-nico@fluxnic.net>
 <20241004041218.2809774-3-nico@fluxnic.net>
 <b055cea5-6f03-4c73-aae4-09b5d2290c29@kernel.org>
 <s5000qsr-8nps-87os-np52-oqq6643o35o2@syhkavp.arg>
 <f41f65bd-104c-44de-82a2-73be59802d96@kernel.org>
 <500r48s9-6s4o-ppnr-4p2q-05731rnn9qs6@syhkavp.arg>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <500r48s9-6s4o-ppnr-4p2q-05731rnn9qs6@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/10/2024 23:26, Nicolas Pitre wrote:
> On Fri, 4 Oct 2024, Roger Quadros wrote:
> 
>>> If you know of a way to do this differently I'm all ears.
>>
>> I sent another approach already. please check.
>> https://lore.kernel.org/all/67c9ede4-9751-4255-b752-27dd60495ff3@kernel.org/
> 
> Seems to work correctly.
> 
> Still... given this paragraph found in Documentation/process/maintainer-netdev.rst:
> 
> |Netdev remains skeptical about promises of all "auto-cleanup" APIs,
> |including even ``devm_`` helpers, historically. They are not the preferred
> |style of implementation, merely an acceptable one.
> 
> and given my solution is way simpler, I tend to also prefer it over yours.

OK. Let's go with yours as it makes the driver more compliant to netdev
guidelines.

> 
> But I'm not the maintainer nor even a significant contributor here so as 
> long as the issue is fixed I won't mind.
> 
>>> About the many error cases needing the freeing of net devices, as far as 
>>> I know they're all covered with this patch.
>>
>> No they are not.
> 
> As I said yesterday, I do still stand by my affirmation that they are.
> Please look at the entire return path and you'll see that everything is 
> covered.

Indeed, my bad. It wasn't obvious by just looking at the patch but when looking at
the code it is called via am65_cpsw_nuss_cleanup_ndev().

> 
> 
> Nicolas

-- 
cheers,
-roger

