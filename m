Return-Path: <netdev+bounces-199957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0987DAE289F
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 12:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A796C1897A54
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDEF1E5B73;
	Sat, 21 Jun 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3In1HUI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02E1624E9;
	Sat, 21 Jun 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750502188; cv=none; b=AFWEqiRBcw6rKsL04QvKGjKaql+8IDZOhwo7vOeA1vf91MYPi6hAgsRn1I1RXv+WOFBl2imTWlS+ByCGKJGrSlqUZODHDaCtNH1GzJGAuv12yK1+xVoztkeUoCT2n1cuTtfg+pEHBj4G1CQH4YqMesxf1d/36FVjz2xjZD5lmL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750502188; c=relaxed/simple;
	bh=XdhXJ6xgtEXxF6yH2/iVd6cbk2kpHK0jLlVvy4AbYBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl63OInrHQLKHWO/gDbcx72rtfl0ML/mXpF7dYhIgah4XJjL9N69u47lEpP5u2yQ6vjZLijrqTX5Nt7McIMU9UbJlIUj3lJW+G38yq+IsIOsvKFKi74R9d3pg+vW41HdqQuy3vtFycd6069hH6YhtfYImz+nuQxKCZTmw/UK9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3In1HUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1061C4CEE7;
	Sat, 21 Jun 2025 10:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750502188;
	bh=XdhXJ6xgtEXxF6yH2/iVd6cbk2kpHK0jLlVvy4AbYBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3In1HUIGF53PwoOpZt39X/4nPxZYqMpOneJJ/Jap14f0/AWjnp5znxKJSYSu35G3
	 skFxN+tDbpi4T03ooAwHY7SxmtXwVI/+t6EiSC+56WU9uIDcHG6MA3SebwIi+Y1D7N
	 9cQ+G9gPjdp6ea8IhygJykAPh3Tp38uWHXIJFLCqYvDhe+wtPURqz/vwBXvMPWxIyB
	 mfizEMaNie3s+81xGjQ3XcU2FEKkpA18TJOG2OMamcFD7tls6J8orOmqaRivLI2Ude
	 7ptRl+Uf2iwrJbqZsjEcz+w4rJw8IPop3JX2BedH5DCh6AkE912g8AH9Fv80jqyMbR
	 IeApTrpuRqTVw==
Date: Sat, 21 Jun 2025 11:36:23 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 2/3] net: enetc: separate 64-bit counters from
 enetc_port_counters
Message-ID: <20250621103623.GB71935@horms.kernel.org>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620102140.2020008-3-wei.fang@nxp.com>

On Fri, Jun 20, 2025 at 06:21:39PM +0800, Wei Fang wrote:
> Some counters in enetc_port_counters are 32-bit registers, and some are
> 64-bit registers. But in the current driver, they are all read through
> enetc_port_rd(), which can only read a 32-bit value. Therefore, separate
> 64-bit counters (enetc_pm_counters) from enetc_port_counters and use
> enetc_port_rd64() to read the 64-bit statistics.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

This patch looks fine to me, as does the following one.
However, they multiple sparse warnings relating
to endianness handling in the ioread32() version of _enetc_rd_reg64().

I've collected together my thoughts on that in the form of a patch.
And I'd appreciate it if we could resolve this one way or another.

From: Simon Horman <horms@kernel.org>
Subject: [PATCH RFC net] net: enetc: Correct endianness handling in
 _enetc_rd_reg64

enetc_hw.h provides two versions of _enetc_rd_reg64.
One which simply calls ioread64() when available.
And another that composes the 64-bit result from ioread32() calls.

In the second case the code appears to assume that each ioread32()
call returns a little-endian value. The high and the low 32 bit
values are then combined to make a 64-bit value which is then
converted to host byte order.

However, both the bit shift and the logical or used to combine
the two 32-bit values assume that they are operating on host-byte
order entities. This seems broken and I assume that the code
has only been tested on little endian systems.

Correct this by converting the 32-bit little endian values
to host byte order before operating on them.

Also, use little endian types to store these values, to make
the logic clearer and is moreover good practice.

Flagged by Sparse

Fixes: 69c663660b06 ("net: enetc: Correct endianness handling in _enetc_rd_reg64")
Signed-off-by: Simon Horman <horms@kernel.org>
---
I have marked this as RFC as I am unsure that the above is correct.

The version of _enetc_rd_reg64() that is a trivial wrapper around
ioread64() assumes that the call to ioread64() returns a host byte order
value?

If that is the case then is it also the case that the ioread32() calls,
in this version of _enetc_rd_reg64() also return host byte order values.
And if so, it is probably sufficient for this version to keep using u32
as the type for low, high, and tmp.  And simply:

	return high << 32 | low;
---
 drivers/net/ethernet/freescale/enetc/enetc_hw.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index cb26f185f52f..3f40fcdbc4a7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -502,15 +502,15 @@ static inline u64 _enetc_rd_reg64(void __iomem *reg)
 /* using this to read out stats on 32b systems */
 static inline u64 _enetc_rd_reg64(void __iomem *reg)
 {
-	u32 low, high, tmp;
+	__le32 low, high, tmp;
 
 	do {
-		high = ioread32(reg + 4);
-		low = ioread32(reg);
-		tmp = ioread32(reg + 4);
+		high = (__force __le32)ioread32(reg + 4);
+		low = (__force __le32)ioread32(reg);
+		tmp = (__force __le32)ioread32(reg + 4);
 	} while (high != tmp);
 
-	return le64_to_cpu((__le64)high << 32 | low);
+	return (u64)le32_to_cpu(high) << 32 | le32_to_cpu(low);
 }
 #endif
 
-- 
2.47.2


