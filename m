Return-Path: <netdev+bounces-218443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AD1B3C768
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82601C25B7A
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535B253B40;
	Sat, 30 Aug 2025 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fNDU22+y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D023ED5E;
	Sat, 30 Aug 2025 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521015; cv=none; b=UQAnEbQvF2mXt8N8hFljbiYYuEpyuXeq2hkofQ1okwpzrhfUmhxXpoNtSaCiFSfWSIwv2O08lSGTJtSGmP0RZPswN1vEVVib1P1a0z7Cnra56YXdoaTQZtCJLpoRx8URIgYx6bvH0rqdJj1d5ri0cImqhlYkV2rN+4yc2vyJ058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521015; c=relaxed/simple;
	bh=D5gt15k78aHffTEzhKrTPz95Mjin89dpWbHlnRGerss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvlQR0oe8FRldlFfgJ4Yx0YANaak18aXfxKDzmMseNaOhebqtR8+R8dl8MZtXU+Ngqafh0oaOOV9ifiLb1AMiKY+qIk5vWPvD6suihiroacFOPK2gqi7vp0fknMyp14k3vZ9GblFDQakEOOJH8eTminM7aDM0nnDGi6Sf0vfne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fNDU22+y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=OnwhoC0SsZmmVunPqr+tDslY/DJMsLPr1yvnJgJ3Mek=; b=fN
	DU22+yNhWuKk2c9vEZuWSKSiuGLMVYg4FNYgaxd/8q2ZcayCrTEymITZh1BMfDvXvkoAVB8cPPXcK
	8tEAGx4O3Xfy0x+qwG81Q2LJBnckaj8YBWqYiBKFHAhW65WRQ3iBvbyrWJS6NbilCBPIlqd2q6P7e
	wVZ+JNOAVP+sVhA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usBLl-006XyV-K0; Sat, 30 Aug 2025 04:29:53 +0200
Date: Sat, 30 Aug 2025 04:29:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: mohammad Hosseini <moahmmad.hosseinii@gmail.com>
Cc: nic_swsd@realtek.com, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] r8169: hardening and stability improvements
Message-ID: <02d0999c-af6b-4bc1-846a-7da7f88e3f6a@lunn.ch>
References: <CAG_zHVWVqe-TXXB8XJQrJiim5uWinzuTQysVnJ8EC5UopktWkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_zHVWVqe-TXXB8XJQrJiim5uWinzuTQysVnJ8EC5UopktWkg@mail.gmail.com>

On Sat, Aug 30, 2025 at 02:21:18AM +0330, mohammad Hosseini wrote:
> From 40b549f1f955a177729374b73b58ec89d40f37a7 Mon Sep 17 00:00:00 2001
> From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> Date: Fri, 29 Aug 2025 21:18:21 +0000
> Subject: [PATCH 1/1] r8169: hardening and stability improvements
> 
> This patch improves robustness and reliability of the r8169 driver. The
> changes cover buffer management, interrupt handling, parameter validation,
> and resource cleanup.
> 
> While the updates touch multiple areas, they are interdependent parts of a
> cohesive hardening effort. Splitting them would leave intermediate states
> with incomplete validation.
> 
> Key changes:
> - Buffer handling: add packet length checks, NUMA-aware fallback allocation,
>   descriptor zero-initialization, and memory barriers.
> - Interrupt handling: fix return codes, selective NAPI scheduling, and
>   improved SYSErr handling for RTL_GIGA_MAC_VER_52.
> - Parameter validation: stricter RX/TX bounds checking and consistent
>   error codes.
> - Resource management: safer workqueue shutdown, proper clock lifecycle,
>   WARN_ON for unexpected device states.
> - Logging: use severity-appropriate levels, add rate limiting, and extend
>   statistics tracking.
> 
> Testing:
> - Kernel builds and module loads without warnings.
> - Runtime tested in QEMU (rtl8139 emulation).
> - Hardware validation requested from community due to lack of local device.
> 
> Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 150 ++++++++++++++++++----
>  1 file changed, 123 insertions(+), 27 deletions(-)
> 
> rtl8169_private *tp,
>   int node = dev_to_node(d);
>   dma_addr_t mapping;
>   struct page *data;
> + gfp_t gfp_flags = GFP_KERNEL;
>  
> - data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
> - if (!data)
> - return NULL;
> + /* Use atomic allocation in interrupt/atomic context */
> + if (in_atomic() || irqs_disabled())
> + gfp_flags = GFP_ATOMIC;
> +
> + data = alloc_pages_node(node, gfp_flags, get_order(R8169_RX_BUF_SIZE));
> + if (unlikely(!data)) {
> + /* Try fallback allocation on any node if local node fails */
> + data = alloc_pages(gfp_flags | __GFP_NOWARN, get_order(R8169_RX_BUF_SIZE));
> + if (unlikely(!data)) {
> + if (net_ratelimit())
> + netdev_err(tp->dev, "Failed to allocate RX buffer\n");
> + return NULL;
> + }

As you can see, your patch is whitespace damaged. Please try to use
"get send-email", or "b4 send" to avoid these issues.

    Andrew

---
pw-bot: cr

