Return-Path: <netdev+bounces-30542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1305D787CA0
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 02:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2B6281717
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 00:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A820361;
	Fri, 25 Aug 2023 00:43:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE0179
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDE6C433C8;
	Fri, 25 Aug 2023 00:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692924217;
	bh=3FvToJ9W9Cx3znvSK8L/1cCAS7onIM8VwFyVO0om7vg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9HHb7VVQNnYn7uUVcgDjYRGsKBenG/gndlH87e9I2o4DhzP16TIBmKmYCaS0UXIq
	 yVV4k7s18j8gshoQxYaW367zdOgh7feUNYGNklcLzho0hP9kXhnpSvGC0f0BKrxFsN
	 PRqR6CFRs4M+r2AG5C2FYF1oKTEay3kzJbnYS4D7HQec5X14S82CH+4lG3tRU3FOYq
	 al3FvDRGkHab8I71GaKD915rAxAprO1GE1XYEuvjNWVlWyH7y1OvDttKr/LWgPFqBY
	 FeBELzVHsa/PjxGta0D1X3+/u7Ppw39PDKzOVBgQQCldb7zt6jh0Y878bnLGr0KVYG
	 0w9lEnIGN3Axw==
Date: Thu, 24 Aug 2023 17:43:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>,
 <anthony.l.nguyen@intel.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz
 RSS hash function
Message-ID: <20230824174336.6fb801d5@kernel.org>
In-Reply-To: <849341ef-b0f4-d93f-1420-19c75ebf82b2@intel.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
	<20230823164831.3284341-2-ahmed.zaki@intel.com>
	<20230824111455.686e98b4@kernel.org>
	<849341ef-b0f4-d93f-1420-19c75ebf82b2@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 16:55:40 -0600 Ahmed Zaki wrote:
> When "Symmetric Toeplitz" is set in the NIC, the H/W will yield the same 
> hash as the regular Toeplitz for protocol types that do not have such 
> symmetric fields in both directions (i.e. there will be no RSS hash 
> symmetry and the TX/RX traffic will land on different Rx queues).
>
> The goal of this series is to enable the "default" behavior of the whole 
> device ("-X hfunc") to be the symmetric hash (again, only for protocols 
> that have symmetric src/dst counterparts). If I understand the first 
> option correctly, the user would need to manually configure all RXH 
> fields for all flow types (tcp4, udp4, sctp4, tcp6, ..etc), to get 
> symmetric RSS on them, instead of the proposed single "-X" command? 
> The second option is closer to what I had in mind. We can re-name and 
> provide any details.

I'm just trying to help, if you want a single knob you'd need to add
new fields to the API and the RXFH API is not netlink-ified.

Using hashing algo for configuring fields feels like a dirty hack.

> I agree that we will need to take care of some cases like if the user 
> removes only "source IP" or "destination port" from the hash fields, 
> without that field's counterpart (we can prevent this, or show a 
> warning, ..etc). I was planning to address that in a follow-up
> series; ie. handling the "ethtool -U rx-flow-hash". Do you want that
> to be included in the same series as well?

Yes, the validation needs to be part of the same series. But the
semantics of selecting only src or dst need to be established, too.
You said you feed dst ^ src into the hashing twice - why?

