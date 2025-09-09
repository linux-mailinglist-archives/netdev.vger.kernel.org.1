Return-Path: <netdev+bounces-221415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9516B50788
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03C24E3137
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15E3375D0;
	Tue,  9 Sep 2025 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH96TEDV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F741FF5F9;
	Tue,  9 Sep 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451357; cv=none; b=U4B8VUX8JDv+H0/45aYXH3Eyl8+n4/xlMxzfUOfwEDEHaelWeEuGXwD3GwKcDCWfdZxsGg5blIxaX5j8kUOA4SAqmgvWxWso+ypU0Tp2N/El81Jq4XNZXonmZq7pCZkQTTE3j4rUtqT+gsuWKbhc3XCXcl/pjQRBgNVSLisfZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451357; c=relaxed/simple;
	bh=6p5J73eIUs+wFjXX8VTD3kV/VgYHijJObwj/6Vt0D1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kj3aBrJGZ3NGmwIDHBUSStbbzRP9l/niHlbvaT6lgo12+iZhFgHy4jZs0TGy8LSkmRzieiNf+hoU7ZiNuN5Dq+7GubU2sf8Nd6ZIHgESs9l+fTuTuBWD69oYbZsaOxm5K+cxuqlsWylooQeZlGxGoB5isc/ykuTpGgwotsS2akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH96TEDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37299C4CEF4;
	Tue,  9 Sep 2025 20:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451356;
	bh=6p5J73eIUs+wFjXX8VTD3kV/VgYHijJObwj/6Vt0D1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QH96TEDVC7ghNHQurxKv8Rg2iFmu7k5LZmLGo5Ww0sAyGgfsqMTKr+G5YPeyNF/4K
	 KBRHd+DNvOHj/VVQHOYrjo8PH+P0Vnhc28rVeXxryrr0gLUfX/lf+DQH+3O1UIQBWg
	 kGlY5bwb9a3GgJeAqzHcwTQqsuD9s+65HrDm9wP00HGYO0CtLhiE1Z/cn82mC8e2rO
	 dayQWsXaP475onCZbcNkwcowGWGZXBjZrWHVGvGn8qeN1FQ/28l3shJZc1BqIynsng
	 Asz8JL9mq27Vk8FbDU8B7k6vNx3YlhwvowgjB3G3LCPCR/YIaD3oi2sJS3vdZTUEmw
	 e58nET7xC8tQA==
Date: Tue, 9 Sep 2025 13:55:54 -0700
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
Subject: Re: [PATCH net-next v11 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <20250909135554.5013bcb0@kernel.org>
In-Reply-To: <54602bba-3ec1-4cae-b068-e9c215b43773@ti.com>
References: <20250909120906.1781444-1-dong100@mucse.com>
	<20250909120906.1781444-4-dong100@mucse.com>
	<54602bba-3ec1-4cae-b068-e9c215b43773@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 19:52:21 +0530 Anwar, Md Danish wrote:
> > +	for (i = 0; i < size_in_words; i++)
> > +		msg[i] = mbx_data_rd32(mbx, MUCSE_MBX_FWPF_SHM + 4 * i);  
> 
> The array indexing calculation should use multiplication by sizeof(u32)
> instead of hardcoded 4.

Not sure this is really necessary, I'd expect C programmers to intuit 
that 4 is the number of bytes in u32 here. sizeof(u32) is going to
overflow 80 char line limit and cause more harm than good.

