Return-Path: <netdev+bounces-221416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923EAB50790
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CACC564A38
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E83570DD;
	Tue,  9 Sep 2025 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKWEbPvB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3530215F;
	Tue,  9 Sep 2025 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451504; cv=none; b=j2Vhk0M23L75ndwfbCAZojx6YvJjnpJKHcVDKy0JhXP/s+exhIzXzuB0fUzYVoQntI5KJiQc2NOWajD2gOC8zKC9woQDXdJelsXoq62p/K9Dz7G4ZSKhobrwGUSrZ1swhoBXhxq7byUVeFW1S22TEHhkkuBoqTt6pv7exfS0yyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451504; c=relaxed/simple;
	bh=d053UT9D7w+A6kL9ac5x+bCv1+lr5wb0p5BL1ocIRSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXnfOABX6Z1g2dFdoOlHSaykwHp0+COApiDmdtq9Q6iD4/HMqnTK8d6Oxr0E7cAn8eF8g4aIFh5qg62c97jVU0Wf/UI4e6hY+nnoBdfFwX5u/AyXRjFYXuSBH+upIdrDbIhqMRRZ6Mt+cqfN3wK0vkcXF9UipOtghZ+HyFDkI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKWEbPvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120BBC4CEF4;
	Tue,  9 Sep 2025 20:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451504;
	bh=d053UT9D7w+A6kL9ac5x+bCv1+lr5wb0p5BL1ocIRSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qKWEbPvB6B5W1I+8ibL1fUgdngRXAB3lydQg2aEHeC7D1Gx+BvdXO0J+NbxR3tqOS
	 MdUHopDoD4l8MG4EWORwGVqWdLwHZ45uKRLEkmzjaEgdGtTE8XRr5FZz/IPBui06xy
	 FhylzG3vhyQcoxC/yHt3SYEwvVyOt9V/wjk5/1YcPUiDJ8pnmbhFsGcXHlktA4kjkQ
	 js6F3J4WblA9GyVzB+VncGdXirTf0U0qdLzKPeb9rqH96uaJlWZjGfC1TjtJ1y3wnW
	 98RBXYOTZWJ9g5nLrvHu+rbXa9/pPQJnoyOJ9WX4OgNOD36rnWI4Vqhmotd2RDCNA+
	 LpKOFiHC9rTuQ==
Date: Tue, 9 Sep 2025 13:58:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <corbet@lwn.net>, <gur.stavi@huawei.com>,
 <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <danishanwar@ti.com>,
 <lee@trager.us>, <gongfan1@huawei.com>, <lorenzo@kernel.org>,
 <geert+renesas@glider.be>, <Parthiban.Veerasooran@microchip.com>,
 <lukas.bulwahn@redhat.com>, <alexanderduyck@fb.com>,
 <richardcochran@gmail.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
 <rdunlap@infradead.org>, <vadim.fedorenko@linux.dev>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH net-next v11 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <20250909135822.2ac833fc@kernel.org>
In-Reply-To: <68fc2f5c-2cbd-41f6-a814-5134ba06b4b5@ti.com>
References: <20250909120906.1781444-1-dong100@mucse.com>
	<20250909120906.1781444-5-dong100@mucse.com>
	<68fc2f5c-2cbd-41f6-a814-5134ba06b4b5@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 19:59:11 +0530 Anwar, Md Danish wrote:
> > +int mucse_mbx_sync_fw(struct mucse_hw *hw)
> > +{
> > +	int try_cnt = 3;
> > +	int err;
> > +
> > +	do {
> > +		err = mucse_mbx_get_info(hw);
> > +		if (err == -ETIMEDOUT)
> > +			continue;
> > +		break;
> > +	} while (try_cnt--);
> > +
> > +	return err;
> > +}  
> 
> There's a logical issue in the code. The loop structure attempts to
> retry on ETIMEDOUT errors, but the unconditional break statement after
> the if-check will always exit the loop after the first attempt,
> regardless of the error. The do-while loop will never actually retry
> because the break statement is placed outside of the if condition that
> checks for timeout errors.

The other way around. continue; in a do {} while () look does *not*
evaluate the condition. So this can loop forever.

