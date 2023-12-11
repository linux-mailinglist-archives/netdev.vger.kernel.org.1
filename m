Return-Path: <netdev+bounces-55980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4867980D1BF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27E21F20624
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AB84CDEE;
	Mon, 11 Dec 2023 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1Q0OB1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24776EBE
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7DAC433C8;
	Mon, 11 Dec 2023 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702312201;
	bh=mpQrixKL+1Ma1tna4knFsiXW5wr9yzvrufama1HEl2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s1Q0OB1z3lAmkNv8Eiw7JxLAob/g22nptkvjB5YehQ7XgAhRv40+uDvtPMglkHSwA
	 76cF51vmn5TFKurZourjNn+gsa0xmIbQa1cggMPrkLFxMtBYVG9vJjQF0V5j/TjglY
	 ry7UqACywJD7AjCZbAeIoB1yj8e/j2W5Jn6BriiKP5nweikppEv3gCSKKvHtS2+Q4i
	 RnkbKY1gu5o0nVFpckKN2T2yYEcpVsi5uVmRWtlEpcd/gauh607GVz/ePw/d7ZYWxf
	 s4pEtBP/WQd4MVZPn62ezIYkoeQewo1l+VuigFhLC2KfYuCURGiL8nopp8rsqsl369
	 k68MMNs+/XGQg==
Date: Mon, 11 Dec 2023 08:30:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
 <horms@kernel.org>, <leon@kernel.org>, Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v5 2/5] ice: configure FW logging
Message-ID: <20231211083000.350bd5e4@kernel.org>
In-Reply-To: <df263bfa-9610-419b-8b17-623f5fb54d26@intel.com>
References: <20231205211251.2122874-1-anthony.l.nguyen@intel.com>
	<20231205211251.2122874-3-anthony.l.nguyen@intel.com>
	<20231206195304.6226771d@kernel.org>
	<75bc978a-8184-ffa3-911e-cceacf8adcd0@intel.com>
	<20231207181941.2b16a380@kernel.org>
	<df263bfa-9610-419b-8b17-623f5fb54d26@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Dec 2023 16:09:40 -0800 Paul M Stillwell Jr wrote:
> This brings up the question of whether I should use seq_printf() for all 
> the other _read fucntions. It feels like a lot of extra code to do it 
> for the other _read functions because they output so little info and we 
> control the output so it seems to be overkill to use seq_printf() for 
> those. What do you think?

My rule of thumb would be to use seq_printf() if you have to allocate 
a buffer on the heap for the output. If you can output directly to user
space or the output is small enough to fit in an on-stack buffer - no
need for seq_printf(). But YMMV.

