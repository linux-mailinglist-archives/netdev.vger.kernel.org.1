Return-Path: <netdev+bounces-21604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59AC76401B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D8D281EA8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACB319880;
	Wed, 26 Jul 2023 20:03:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABE4CE9F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 20:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6E2C433C8;
	Wed, 26 Jul 2023 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690401817;
	bh=PaX7dVmnCCB8w0j6I/nVSkPgIRQ/pMH3li/D/asV7FQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C779fouleZVC4ftkiskufd5TPCbV6Bg7uYVVrbOJtrMPbihG/pTDaWqWEggHtFSNt
	 ijZPArvniENHsI88ko70e7DNwyjAqld8urqVoKtkmTpN/9sMOq7Y9Z8ip3t9tfuleg
	 /8HFrQIxmppXyDBlrhdYEwCCCshxqfxrOJpec4TFDRjmYVdMxtrwDtnBF86aF9KuxK
	 tKHCNSACUHzpeqN30yN5CkalBWIkdntjn+Gvyb8Ml9rjVr8EYe6V7JLKBfsVJFPkgt
	 qWoWmqQqloPJQH4tnB32knpYusP3laeaX0E6wuPA4Xfph5dRhcflUr6ytKHPUoh22H
	 vmZDXycnJdoag==
Message-ID: <b28d8028-5167-ff6d-e845-3630519f662a@kernel.org>
Date: Wed, 26 Jul 2023 14:03:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [net-next] net: change accept_ra_min_rtr_lft to affect all RA
 lifetimes
Content-Language: en-US
To: Patrick Rohr <prohr@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Linux Network Development Mailing List <netdev@vger.kernel.org>,
 =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20230725183122.4137963-1-prohr@google.com>
 <1940c057-99c4-8355-cc95-3f17cca38481@kernel.org>
 <CANLD9C1aV3U+GZ3hUE-_AgbeSyCNgUvJPmOPcFEDDgD_fQWJ0A@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANLD9C1aV3U+GZ3hUE-_AgbeSyCNgUvJPmOPcFEDDgD_fQWJ0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/23 11:33 AM, Patrick Rohr wrote:
>> The commit mentioned in the Fixes was just applied and you are already
>> sending a follow up moving the same code around again.
> 
> I got feedback off of the mailing list after the patch was applied.

That offlist discussion should be summarized in the commit message (text
below?)

> In order for
> the sysctl to be useful to Android, it should really apply to all lifetimes in
> the RA, since that is what determines the minimum frequency at which RAs must be
> processed by the kernel. Android uses hardware offloads to drop RAs
> for a fraction of the
> minimum of all lifetimes present in the RA (some networks have very
> frequent RAs (5s) with high lifetimes (2h)). Despite this, we have
> encountered
> networks that set the router lifetime to 30s which results in very frequent CPU
> wakeups. Instead of disabling IPv6 (and dropping IPv6 ethertype in the
> WiFi firmware)
> entirely on such networks, it seems better to ignore such routers
> while still processing RAs from other IPv6 routers on the same network
> (i.e. to support IoT applications).
> The previous implementation dropped the entire RA
> based on router lifetime. This turned out to be hard to expand to the other
> lifetimes present in the RA in a consistent manner -- dropping the
> entire RA based on
> RIO/PIO lifetimes would essentially require parsing the whole thing twice. I am
> sending this follow up patch now to fix 1671bcfd76fd before it is released.
> 



