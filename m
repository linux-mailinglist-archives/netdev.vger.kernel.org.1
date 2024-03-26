Return-Path: <netdev+bounces-81863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456588B6DD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2E41F3811A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C621CD15;
	Tue, 26 Mar 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ3oEmqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB121CA96;
	Tue, 26 Mar 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416635; cv=none; b=XVYx32sjn6isO0pc6bq1OlPkicZEEo+4xieLTn/vWhebcoftMdNyEBn1pLcuBlzwbNG6+Qo/Pso4cJnG8Vebttg4ea1/672GoWk0u7AZvK1lwa0nGl9bn7t3LsYyhKAqY3fXVccdVn18vTSoLOuZHONlqsSdpHZ234fQvv9Qtpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416635; c=relaxed/simple;
	bh=A7gVtYCFt0xAUbhnOYYUoYd7+54i22DMCpKxd2a5Gvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBUTFgF6RzXiO3pfrIhMc/fF4fy03g5CbW4CeAjPaedILOh8yn7RB42l8EDmfsvByqg8F5JtLSLs2JhdfLyEqEUsV8Kip9mq2bAB5sGV+8Ktcpz0CZk0Arb51IGlUqvoX4QoEh+wRNKwWHXBAI3vUhr7+Km76uEA1Udt9FwME10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ3oEmqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A02DC433F1;
	Tue, 26 Mar 2024 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711416635;
	bh=A7gVtYCFt0xAUbhnOYYUoYd7+54i22DMCpKxd2a5Gvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZ3oEmqKdjmZbJ/Nsxh0guna2tGEVT/DEHDW1NQAdgrmj3rlNB5r4hg0OWsELbPB4
	 vVkDj1IEswFNUGlk3/ewJW6t7vzqQstruzJ/3nxAXEEhKjf8vcCYj9nkuTn8wxp8TZ
	 30W/Ww/PKoAYNMYK27sIEENDBe2RNnK6jn6IXFRhWEIsC/ch5jyo+yAIqHmXn5ik+i
	 KeL1BmXP7lEtpDkAPcv0kTlnbp2H31dSew2CenDLu/cWuldXvU9my5lNkHbhkQPZcD
	 UkIreiC3dGdhIDavXDuPHjx9fCvxPd+eXGkPmi+YqIokOA/zPWWXZlRP9X+6jQUBFD
	 loSROqTvgyCdg==
Date: Mon, 25 Mar 2024 18:30:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, rostedt@goodmis.org, pabeni@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 0/3] tcp: make trace of reset logic complete
Message-ID: <20240325183033.79107f1d@kernel.org>
In-Reply-To: <20240325062831.48675-1-kerneljasonxing@gmail.com>
References: <20240325062831.48675-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 14:28:28 +0800 Jason Xing wrote:
> Before this, we miss some cases where the TCP layer could send rst but
> we cannot trace it. So I decided to complete it :)
> 
> v2
> 1. fix spelling mistakes

Not only do you post it before we "officially" open net-next but
also ignoring the 24h wait period.

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

The main goal of the 24h rule is to stop people from bombarding us with
new versions for silly reasons.

You show know better than this, it's hardly your first contribution :(
-- 
pv-bot: 24h

