Return-Path: <netdev+bounces-137070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D6A9A4431
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409281C21060
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73232038AD;
	Fri, 18 Oct 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ODGXfY48"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E9200C87;
	Fri, 18 Oct 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270575; cv=none; b=lE/mz8vWX+xGefEyx+GH61hCR/7WaBTKBFx36MBEy5xxfOZoH8QHsBxjHkg7TMjDnPByg4IWBJIlQ+4g6kjYqjr/gg7qdOMfEaXc0f61W9LJfQJznpFtNBYv6Qu3RTnok5f3a20/rWKHB+fcSEgFqRJgg76sK7yokpxSEDuBEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270575; c=relaxed/simple;
	bh=2nkCyEzm6YDm0J1JHlfuBkEtCsAIcHcfPw3Ho6IwEYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsXKW0MlW/07uvFDjhh6BCBYz5leeyN+VFlSoq4SxaxwB/UivC0pwzI6vgo2HrU3eJFYAbkeu0sZRhIhklD+9sIu34HoPvi5oqjL5emMIGGzfQSc8eOca0uY96/jFw5GPOLlX+k8O9VI+GWN3Oc2WB9t70yRpJGIL68Po1Sc8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ODGXfY48; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=YvTm0/Ddj2Aj9F+19cWeS71uKbiUkGYK6MuTaacqz6g=; b=OD
	GXfY48tKICvEHrtQ/5BICPYlWREVkMvkhIbI+gV5wadqZngYMRNoqeAjKAdgE06oS91S8+HodIHLp
	WFbmC/se7C3sY06Rl099bVJVFNiIoO+IKmsFpKbRLG4c97DE/3Nxi/8z49fB5C5TjcdMrG7d4R2SP
	7fc3GSqCGg51Wm8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1qGX-00AYEk-Mr; Fri, 18 Oct 2024 18:55:53 +0200
Date: Fri, 18 Oct 2024 18:55:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
Message-ID: <940d2002-650e-4e56-bc12-1aac2031e827@lunn.ch>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-3-fujita.tomonori@gmail.com>
 <6bc68839-a115-467f-b83e-21be708f78d7@lunn.ch>
 <CANiq72=_9cxkife3=b7acM7LbmwTLcXMX9LZpDP2JMvy=z3qkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=_9cxkife3=b7acM7LbmwTLcXMX9LZpDP2JMvy=z3qkA@mail.gmail.com>

On Fri, Oct 18, 2024 at 04:31:34PM +0200, Miguel Ojeda wrote:
> On Fri, Oct 18, 2024 at 3:50 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Wasn't there a comment that the code should always round up? Delaying
> > for 0 uS is probably not what the user wants.
> 
> This is not delaying, though, so I don't see why a method with this
> name should return a rounded up value.
> 
> Moreover, `ktime_to_us` doesn't round up. The standard library one
> doesn't, either.

Did you see my other comment, about not actually using these helpers?
I _guess_ it was not used because it does not in fact round up. So at
least for this patchset, the helpers are useless. Should we be adding
useless helpers? Or should we be adding useful helpers? Maybe these
helpers need a different name, and do actually round up?

	Andrew


