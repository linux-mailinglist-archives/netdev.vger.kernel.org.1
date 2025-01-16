Return-Path: <netdev+bounces-158954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E85A13F32
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B2D18862C5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7CD22BADF;
	Thu, 16 Jan 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLyrLP7P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468D1E47A5;
	Thu, 16 Jan 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044522; cv=none; b=RL7HXcKKL6JyyLc1LOPzKLAZEXTkQ4PYoQ875AmdST0lNTioHQEuBzHSh+o1ECQDcWjlKdquI3YNY34eoiyLH8umk4F8yLq/c+dL5mkQf2zIuRpQeGvdxnOQHVNF0sq8VnrEbnWD4aEK0g8ahRSCwFWoLiVUk7Z+BmiYJsfLlzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044522; c=relaxed/simple;
	bh=WgE/p3xzfDcfy+4UqXL6yaoPsBBg9iLOUF8LYdyM5AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rulv8shA/T3esMxV/848j/kS29MTR7eItAV7KL03Ylc00hn7joHlVvVIQcESv5W7sXFfEGP90b7+ojfpB0u1qzrmH63PQDA3/m8/X0LyDVNTBFoDpYMipZPwTP6Fb/UXb4heFGwsIEjyn0cF3GKhsQi2mFBZA1rllkX8d3pmXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLyrLP7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F50C4CED6;
	Thu, 16 Jan 2025 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737044521;
	bh=WgE/p3xzfDcfy+4UqXL6yaoPsBBg9iLOUF8LYdyM5AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLyrLP7Pzcle2tB2k7AFT8NUQASehqKLJLacu+N21q7RB2Ou/Zf4/PFhmgR4aRNGT
	 66xgBZCswLakLRRkNY+b5dth4SigytqG5GJpF3fw9GcSm0TwLiaU8vcKZDfrPIlsT1
	 SsoKNcEN92PQhduwNqDKCVbWUIY50PbpBfx9D3y8IBPQzl+68cLUMeIToTU8Oec/VB
	 WDjUhhoGtpbQPJv0rOHCIMUJATeOzQmmgDHIsrpAPy6GcXSPCYfQ+0m/+5pye3mspO
	 Nbpc0e514wYZzOEVh7MnrwVSkNBXb0aTEefsABEztj31KsKcq6qyRECGaSLD3CsJlV
	 xovcDwwAJ4+rA==
Date: Thu, 16 Jan 2025 16:21:57 +0000
From: Simon Horman <horms@kernel.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.swiatkowski@linux.intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI
 descriptor registers
Message-ID: <20250116162157.GC6206@kernel.org>
References: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>

On Wed, Jan 15, 2025 at 09:11:17AM +0530, Dheeraj Reddy Jonnalagadda wrote:
> The ixgbe driver was missing proper endian conversion for ACI descriptor
> register operations. Add the necessary conversions when reading and
> writing to the registers.
> 
> Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602757
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>

Hi Dheeraj,

It seems that Sparse is not very happy about __le32 values appearing
where u32 ones are expected. I wonder if something like what is below
(compile tested only!) would both address the problem at hand and
keep Sparse happy (even if negting much of it's usefulness by using casts).

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
index 6639069ad528..8b3787837128 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
@@ -150,6 +150,9 @@ static inline void ixgbe_write_reg(struct ixgbe_hw *hw, u32 reg, u32 value)
 }
 #define IXGBE_WRITE_REG(a, reg, value) ixgbe_write_reg((a), (reg), (value))
 
+#define IXGBE_WRITE_REG_LE32(a, reg, value) \
+	ixgbe_write_reg((a), (reg), (u32 __force)cpu_to_le32(value))
+
 #ifndef writeq
 #define writeq writeq
 static inline void writeq(u64 val, void __iomem *addr)
@@ -172,6 +175,9 @@ static inline void ixgbe_write_reg64(struct ixgbe_hw *hw, u32 reg, u64 value)
 u32 ixgbe_read_reg(struct ixgbe_hw *hw, u32 reg);
 #define IXGBE_READ_REG(a, reg) ixgbe_read_reg((a), (reg))
 
+#define IXGBE_READ_REG_LE32(a, reg) \
+	le32_to_cpu((__le32 __force)ixgbe_read_reg((a), (reg)))
+
 #define IXGBE_WRITE_REG_ARRAY(a, reg, offset, value) \
 		ixgbe_write_reg((a), (reg) + ((offset) << 2), (value))
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 3b9017e72d0e..8d9b91375584 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -113,7 +113,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 
 	/* Descriptor is written to specific registers */
 	for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
-		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), cpu_to_le32(raw_desc[i]));
+		IXGBE_WRITE_REG_LE32(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
 
 	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
 	 * PF_HICR_EV
@@ -145,7 +145,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_SV)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = le32_to_cpu(raw_desc[i]);
+			raw_desc[i] = IXGBE_READ_REG_LE32(hw, IXGBE_PF_HIDA(i));
 		}
 	}
 
@@ -153,7 +153,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = le32_to_cpu(raw_desc[i]);
+			raw_desc[i] = IXGBE_READ_REG_LE32(hw, IXGBE_PF_HIDA_2(i));
 		}
 	}
 

