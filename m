Return-Path: <netdev+bounces-131272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440698DF45
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD231F23248
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666D1D0434;
	Wed,  2 Oct 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bXHTMLw6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63A23CE;
	Wed,  2 Oct 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883283; cv=none; b=T/jt2HlcDELk18FD3OeUJQUq1y2Md0kqlAbtkaNlAw0G5/KPIfCeNlCuDX/AX64SkDK4UeiTDMNt/T9PqzLsA3+xCjL3hdgdZxL+CECJoId126ChLyZ0jYiNfa7OqWQkH6XEsDqKBx9NyCQoGBwJNfALs7JYIt5VGiuncAXgkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883283; c=relaxed/simple;
	bh=zGKbB6Rkj8XhSmTSv3puCgtjf4+3gZ2Oewq9ug1a3TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrZuDLT9nc3bWF7FilbIjwrFlUKETlsIMnR87oJbeavimnBY5TW9v/dWW6uUx/Qt/rfEtgMQ1yL1YJYd6ntUZ5xIqEcHfNZidf603wZivjs2nvyAcetDRE+Egv+xyYkRpNpGRShNwVqTYD+xSJqpxfpqs6iLusyWBbiCCzgPRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bXHTMLw6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RF3Yt7mUhMh9oXBfNRlXYo/9TTj+JpEotlqG6mQiyzc=; b=bXHTMLw64O2XzJunhOyTUZn3TK
	p6e+Z2FtDCcDxvP2FrrMqADCT5p80CU+vWpuRJAN3+95RLNLCv4bGCBxT6iz69fcGWiq8/MgboEtL
	bANHYwMi5XO1bZ6OnOrpIeCHp4sadfowduY1EmaVqjiqVmi4UKbDvhE6E4ugdNk/zG3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw1Mr-008sC0-Kh; Wed, 02 Oct 2024 17:34:21 +0200
Date: Wed, 2 Oct 2024 17:34:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Add the dwmac driver support for T-HEAD TH1520 SoC
Message-ID: <99af411c-ff40-4396-a6e2-5aac179ba1be@lunn.ch>
References: <20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com>

On Mon, Sep 30, 2024 at 11:23:23PM -0700, Drew Fustini wrote:
> This series is based on 6.12-rc1 and depends on this pinctrl series:

This is a network driver, so should be based on net-next/main.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

>  20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com

Everything should meet up in linux-next, where it should work since
all the dependencies are there.

    Andrew

---
pw-bot: cr

