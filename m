Return-Path: <netdev+bounces-125205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C51A96C419
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F551F275A9
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB01DFE1F;
	Wed,  4 Sep 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6cooEZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5A1CEE89;
	Wed,  4 Sep 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467217; cv=none; b=OyVMwhoOREZVX6GbkjyB3egMgngX0D4znbDODLPxi+y9HoxATjGw0kJy3UTac9bon1VMnV5B4LsdpJKIUc7wpd8EmB78RQ1YceKfPnB0SUAXFVEimIg1lZ9iZDQcZ2eDm7vzeCwGbZRFwwYYwA15Nwm5NwnzKgAq4S2grBDkUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467217; c=relaxed/simple;
	bh=7j0XF4fV98dLGEL3CqtnSJa083XT0sBfqDuPR+hB+gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAgjdFizemzJ7Yfn0IKGtfHnJmG7Bw+WJrroX0h7+JYxyk5+vk3FqdfJ1FXzyC20E0ctZoF+g0fuVgujPXWbxLuloiNbG8F03fqKu3HNVGjQTrjS+p32Tns8C4NSL1odevUuAf3DGXt8dNlxIftyHUpOkOzMqiZ4VYMSQmFxu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6cooEZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D134DC4CEC6;
	Wed,  4 Sep 2024 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725467217;
	bh=7j0XF4fV98dLGEL3CqtnSJa083XT0sBfqDuPR+hB+gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6cooEZDs685/cCiJF7fR1w63yDIR7tmeb4VdA/qaJspmdd3Ibk0rjbbMByYCUCYd
	 u3O9QgZPdyvP5IDEAYxgEMVbSj03/I0yd/4x7ncDlHX9aua/q+Oe/Pu1Fm0+0SjUvv
	 wgNuzehelYkvDdXPUoGV5yUVUBLXebDUR4Szi4RV3aUNCT/mLeWWgMG+ZH8dasmf7s
	 uxy5psEOeRoEZwlF0uAJ68YLUGVYkZ4xqb2+TEcljQywdeXORfdJC966XhyqEkOjck
	 H/b9oRBIpdvMLTaYErJMvivihra2K15zJz5Oe6z3klUF+vnyH+6jwILqrItvsVrRKF
	 OHsDmcNZ7rcbQ==
Date: Wed, 4 Sep 2024 17:26:52 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: cadence: macb: Enable software IRQ
 coalescing by default
Message-ID: <20240904162652.GB4792@kernel.org>
References: <20240903184912.4151926-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903184912.4151926-1-sean.anderson@linux.dev>

On Tue, Sep 03, 2024 at 02:49:12PM -0400, Sean Anderson wrote:
> This NIC doesn't have hardware IRQ coalescing. Under high load,
> interrupts can adversely affect performance. To mitigate this, enable
> software IRQ coalescing by default. On my system this increases receive
> throughput with iperf3 from 853 MBit/sec to 934 MBit/s, decreases
> interrupts from 69489/sec to 2016/sec, and decreases CPU utilization
> from 27% (4x Cortex-A53) to 14%. Latency is not affected (as far as I
> can tell).
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Nice performance improvement :)

Reviewed-by: Simon Horman <horms@kernel.org>

