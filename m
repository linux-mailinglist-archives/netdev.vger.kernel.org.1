Return-Path: <netdev+bounces-214127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72977B28533
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28398B06567
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEBE3176F2;
	Fri, 15 Aug 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyleoRpL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541063176E1;
	Fri, 15 Aug 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279190; cv=none; b=tKquJ0oc5ou5yZFl1cC4eCumxIKRf7RfYJ2qwkXPNlHw/cZ1wFDMDrDL3lon3fJcGyzIvbO8FBLPqy7r9h5W3umAV42wOpCEPVqVZLOyrxWmDLEzt3DgusZSfbOFvVoej2Jj5fUvO9J12BI/IJ7c6zuzb9StRNKtJl4XsxTN4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279190; c=relaxed/simple;
	bh=KqrFhdDJ23bZRVUJJNDTEr4LLORQRqcHvKSMPEDqTi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V96Lh1NL55beN+cFEQKpnUvJsZ1cfFv8gC92RwbOsaSH7csqIEHG6BNIKfVk7qHrKxwIEJJJaks3Q5pkFKE39EPbk5rcqDNbw+4FgUPkvhE6mj95MjcWPLf6olIgbNWCE4/0X+CIoLC2I1vAqg6pe4gAKMssvmm9zfA5LQAZ7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyleoRpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DF8C4CEF1;
	Fri, 15 Aug 2025 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755279189;
	bh=KqrFhdDJ23bZRVUJJNDTEr4LLORQRqcHvKSMPEDqTi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YyleoRpL50JxYpJoOnz5OgM6M7T0x89HfYoD+vaK6HQ8pdpoijBcmlFapQGRtPEaN
	 TnzyJc5mZTRBRTcycup5Y/PRlGytS5IkxAYWIfT4b9tRVNv2rRBoXADh4bPVnJuNe8
	 07JsiI1QfqEKxolZ2B6LIm1NpPUQ+tierm8GLuyDCXw+iqE3E2xjs9EhzvIhT3MJ+r
	 pRSYfLC3YIUgL3sNzZS0YMQXIb+iXUqXriF5OQxFQPN5Smh9UHXAbMpekGxQKzjEki
	 X51Ch2nigJER1nyGvDBcYCEqeM+3X43IRhoxVpJOrEQtPYzlGSxmDdGn849FBLe0OT
	 EfLw5Jo4sEdvg==
Date: Fri, 15 Aug 2025 10:33:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, Mike Galbraith <efault@gmx.de>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <20250815103308.4993df04@kernel.org>
In-Reply-To: <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
	<oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
	<20250814172326.18cf2d72@kernel.org>
	<3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
	<20250815094217.1cce7116@kernel.org>
	<isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 10:29:00 -0700 Breno Leitao wrote:
> On Fri, Aug 15, 2025 at 09:42:17AM -0700, Jakub Kicinski wrote:
> > On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:  
> > > On 8/15/25 01:23, Jakub Kicinski wrote:  
> > 
> > I suspect disabling netconsole over WiFi may be the most sensible way out.  
> 
> I believe we might be facing a similar issue with virtio-net.

I could be misremembering but I thought virtio-net try_lock()s.

