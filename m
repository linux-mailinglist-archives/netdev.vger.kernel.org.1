Return-Path: <netdev+bounces-211704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B1B1B552
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDCD3AAB37
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6E26AAAB;
	Tue,  5 Aug 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cp9dWz+5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80F26D4E7;
	Tue,  5 Aug 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402002; cv=none; b=d44GcWXjg+orvl7d1uyxaRWhfwrIJLCWxhAGto8mmM/XPBgLBLXI144zRkd84/qrj4sO/56cRV2j9e7jS1yxKRtY6hihy24h2s8ByviZD6L95qIUVH5Bs1fYR9a5aGvkEi5BUoX9xrmihNvbD1N1DtOXs7shRaeYIEBRlb54N48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402002; c=relaxed/simple;
	bh=Dh1xulLmFa+Wbzh9QK7AAeJG7aeMiW7pTBbi/2NP52Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sojvsi+qTnCIoKmAKXFC4vvrjLaxWukCzbHke/q+CzTbghzszua2wd3jMJEnM8sFpsXqk5ti+S18Sad2W1h+Qp98P3UZxOpsUUwuFOnyEamSlSzpZb0FApeLrSoae9hdw0TJ8Eua001NABWdFoRjVKZy6nbP2Nn/aAmVqzHk8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cp9dWz+5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ksnOyjjUC1i9o9VD4SN5otzjLK43Pwz1EMeS7uC7dJY=; b=Cp9dWz+5OtIoSh/PAWzDNv8C2z
	ceHKoU/gRLtX3IqQp8xWz5AbGF2gst5fuTDh1iubCGr0lI2JTiITIERXu9jVrKsU4HXxT6rqwBO4M
	ps6ZC7/jKQQRke0yT7hIv4D+bok4oCkjZuWDim/2rJLg5MrlyET288dXjLUU3pegLYaE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujI6I-003nJH-2M; Tue, 05 Aug 2025 15:53:10 +0200
Date: Tue, 5 Aug 2025 15:53:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: dakr@kernel.org, linux-kernel@vger.kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
Message-ID: <a843788e-80f4-49d3-96f1-1da092ee318c@lunn.ch>
References: <DBNPR4KQZXY5.279JBMO315A12@kernel.org>
 <20250802.104249.1482605492526656971.fujita.tomonori@gmail.com>
 <DBRW63AMB4D8.2HXGYM6FZRX3Z@kernel.org>
 <20250805.223721.524503114987740782.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805.223721.524503114987740782.fujita.tomonori@gmail.com>

> I also prefer the example that can be compiled however I can't think
> of a compilable example that is similar to actual use cases (for
> example, waiting for some hardware condition). Do you have any ideas?

Does it have to be successfully runnable? Just read from address
0x42. If it actually gets run, it will trigger an Opps, but it should
be obvious why.

	Andrew

