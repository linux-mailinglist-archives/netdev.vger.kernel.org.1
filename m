Return-Path: <netdev+bounces-83137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A6891042
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652691F2855E
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A8125AC;
	Fri, 29 Mar 2024 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ6LWBK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A50EAE7;
	Fri, 29 Mar 2024 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674932; cv=none; b=Z6Qn5TFYhmN5hhXNuilpaLK2wWhI4x7Of/baGHqoN+JjMGgtxX41ZEDfd0vP2LDlQmW48Yb7sZQZZxPSnoxjOWSRFoMBGzEgezjhoCrkJ7glbZU3gSfbqdgkfRLb4wAJ+UkuphGXZMOfs4ZttIHeoH2FIlthhq3qLiXPXlcTE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674932; c=relaxed/simple;
	bh=L+KoOGPYyJgMGSggg1e+hhW5fHDdsDhMFRNKBhximbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Trr1/kuh/1tbfJxIhtDbZCBWnZRW7H/fNMgqFxe35yPJQFcbFapikyhae55ndLFcJsWkHAntY1n/V/frA1mQ97XbxICiQ3WZ6226QmmuZ/QUx7kIqUmkkWw3lwx7bCGNoYGKwbEz4WOaex04dKWVS4LhAB9mcsQ85ed22lptK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ6LWBK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E82C433F1;
	Fri, 29 Mar 2024 01:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711674931;
	bh=L+KoOGPYyJgMGSggg1e+hhW5fHDdsDhMFRNKBhximbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJ6LWBK5bJHcKOmpsNqB8nU9jKtW5yYR1tL9NUztqGQlgE0xS47YFI+E009LvzAQ/
	 wToaCF3kKrWQEGlOP/cOEeMSkNb8ucwLFXCb0DMDnfkihAqVoSHDPloml5SiJhMV6l
	 swiSu2dSNBWsdamKhaNM4LVtBWQi1UOpzNX/gzBDawkCHrSznt7yUgEMKGKYahJXqi
	 QrlumioCOTZsTxwohsa3qYocj8BFBHWN7YXGVIHP8wvzUzBM2FPJAG5/hd69A9DSfp
	 7f7bFby5wWMR3xVXQt4QX9nDSiy2LQH4UUaYitsGtlQa07gRgLh41dRuenfMnuz/n2
	 cnBtfDtLQHkag==
Date: Thu, 28 Mar 2024 18:15:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
 davem@davemloft.net, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing  <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 3/3] tcp: add location into reset trace
 process
Message-ID: <20240328181530.0d9229cb@kernel.org>
In-Reply-To: <3186e70ecd98893710f829723f866ab92250ea74.camel@redhat.com>
References: <20240325062831.48675-1-kerneljasonxing@gmail.com>
	<20240325062831.48675-4-kerneljasonxing@gmail.com>
	<3186e70ecd98893710f829723f866ab92250ea74.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 12:08:01 +0100 Paolo Abeni wrote:
> > -	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> > +	TP_PROTO(
> > +		const struct sock *sk,
> > +		const struct sk_buff *skb,
> > +		void *location),  
> 
> Very minor nit: the above lines should be aligned with the open
> bracket.

Yes, and a very odd way of breaking it up. Empty line after ( but
) not on a separate line.

> No need to repost just for this, but let's wait for Eric's feedback.

Erring on the side of caution I'd read this:
https://lore.kernel.org/all/CANn89iKK-qPhQ91Sq8rR_=KDWajnY2=Et2bUjDsgoQK4wxFOHw@mail.gmail.com/
as lukewarm towards tp changes. Please repost if you think otherwise
(with the formatting fixed)
-- 
pw-bot: cr

