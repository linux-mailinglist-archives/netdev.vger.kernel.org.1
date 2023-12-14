Return-Path: <netdev+bounces-57587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2992081386A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD70CB215AC
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF665EC2;
	Thu, 14 Dec 2023 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bndVW96a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F565EB3
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 17:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654E1C433C7;
	Thu, 14 Dec 2023 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702574652;
	bh=Lo++xlxLZ+5osBQRnqfeNnIUwruOjg2HtfW4cEdp9TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bndVW96a5dPw/EEN9DFKm+FmNgfhGjXzX4JEA53PfvnIr/6fDD9jZCQCUY23OHDWx
	 guW75UOqAw7zpVGgQpfIaoAeVkaBI/aHT7oKbUhVL1Kuwq6hG5Xruv1hfNvJf23tnV
	 tP0gpoSw90lxSoA9wgaKZWwfD6Za0kzIELtVZUE0KekIai01mfKTXH7jodr0516CGD
	 WfT7/G9j8yxnzNUpyzfcuD6kKkB1UM0+robF39A8VnHsrr8brFHVHQoDQ3mG8IMScP
	 K3bvyH9CAPIdutDduQXm/G9ohUwimh8f1DPDA3ma+03Ye1CJ1yzdaGLireQfyz6Y+X
	 u8yZSm8o0hBPA==
Date: Thu, 14 Dec 2023 09:24:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: JustinLai0215 <justinlai0215@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu
 <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 06/13] rtase: Implement .ndo_start_xmit
 function
Message-ID: <20231214092411.62661528@kernel.org>
In-Reply-To: <ce315d58376c40d4abf82d80bf203c81@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-7-justinlai0215@realtek.com>
	<20231212113212.1cfb9e19@kernel.org>
	<ce315d58376c40d4abf82d80bf203c81@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 13:00:29 +0000 JustinLai0215 wrote:
> > I don't see how this is called, the way you split the submission makes it a bit
> > hard to review, oh well. Anyway - if you pass the NAPI budget here - that's not
> > right, it may be 0, and you'd loop forever.
> > For Tx - you should try to reap some fixed number of packets, say 128, the
> > budget is for Rx, not for Tx.  
> 
> Even if the budget is 0, this function will not loop forever, it will just run all tx_left.
> Or what changes would you like us to make?

Ah, good point. It does seem a little accidental to me :S
In that case perhaps always consume all completed packets?
@budget should not constrain Tx completions directly, see:
https://www.kernel.org/doc/html/next/networking/napi.html

