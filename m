Return-Path: <netdev+bounces-208644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD4CB0C7E3
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37407A3407
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214762DF3FD;
	Mon, 21 Jul 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y5pWmjO9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31D149DFF;
	Mon, 21 Jul 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112661; cv=none; b=P3yVUJit3lDxpo60QLWxSWjoMXAE4HfbZa8VS/51cDr1c2Muzwb0pskjqicTOaW6MPMXA+RaGeDAsH7CPKNA0W32t7Ee7/yta7SrGn82p3Ql4UvYToIOK/+MOtxHuKBXJTfmHjoQfqKlZQqR5PUDvopTWx9zkjfeSYkUQud1nu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112661; c=relaxed/simple;
	bh=JWtyl6NjEoCsBn+cHwU9hfZTPWDVqi/ScvfaoZVO39A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsH6QwQExm2r/Lvm4BkRnazt9D82Y8hCmjOKCJ46YF4TkDuQr9uSe1oS32TlCeeDEgg283femoLyvIIvhXFtZ3Pkwn3rVGw233rqOqqtqQZ0rFTd5jBBrGXXb/j7dl7g/fzN4imhOLLg3Ezdjmm5AA6NTwG7BWo1RnXc18spqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y5pWmjO9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vsxqkfNTc3Im8bZ4TMV6iFTxe9a53JxZhT5n91A2kGo=; b=y5pWmjO9fAJWV6NTwGi6RWk/l/
	+uIzkJOdXWua/bwZ3YHA8ZvMVfgXNu6MuFzXjvdonSPauXHqPQUKe2/l/o59M2PXBdW+qW0WvbZCG
	b/kwPH0pLAAoa122fbd3J9HSOJHD8yis2TdKrbLgGl3KeiTeIoWW27EdXp7sF0zOFG3g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udsg1-002NDF-FJ; Mon, 21 Jul 2025 17:43:41 +0200
Date: Mon, 21 Jul 2025 17:43:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <e66591a1-0ffa-4135-9347-52dc7745728f@lunn.ch>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113238.18615-4-dong100@mucse.com>

>  #define MAX_VF_NUM (8)

> +	hw->max_vfs = 7;

???


>  }
>  
>  /**
> @@ -117,6 +119,7 @@ static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
>  	/* update hw feature */
>  	hw->feature_flags |= M_HW_FEATURE_EEE;
>  	hw->usecstocount = 62;
> +	hw->max_vfs_noari = 7;

???

> +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +		   enum MBX_ID mbx_id)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	/* limit read to size of mailbox */
> +	if (size > mbx->size)
> +		size = mbx->size;
> +
> +	if (!mbx->ops.read)
> +		return -EIO;

How would that happen?

> +
> +	return mbx->ops.read(hw, msg, size, mbx_id);

> +int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +		    enum MBX_ID mbx_id)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	if (size > mbx->size)
> +		return -EINVAL;
> +
> +	if (!mbx->ops.write)
> +		return -EIO;

How would either of these two conditions happen.

> +static u16 mucse_mbx_get_req(struct mucse_hw *hw, int reg)
> +{
> +	/* force memory barrier */
> +	mb();
> +	return ioread32(hw->hw_addr + reg) & GENMASK(15, 0);

I'm no expert on memory barriers, but what are you trying to achieve
here? Probably the most used pattern of an mb() is to flush out writes
to hardware before doing a special write which triggers the hardware
to do something. That is not what is happening here.

> +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw,
> +				 enum MBX_ID mbx_id)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	u32 reg, v;
> +	u16 req;
> +
> +	reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
> +				   PF2VF_COUNTER(mbx, mbx_id);
> +	v = mbx_rd32(hw, reg);
> +	req = (v & GENMASK(15, 0));
> +	req++;
> +	v &= GENMASK(31, 16);
> +	v |= req;
> +	/* force before write to hw */
> +	mb();
> +	mbx_wr32(hw, reg, v);
> +	/* update stats */
> +	hw->mbx.stats.msgs_tx++;

What are you forcing? As i said, i'm no expert on memory barriers, but
to me, it looks like whoever wrote this code also does not understand
memory barriers.

> +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int try_cnt = 5000, ret;
> +	u32 reg;
> +
> +	reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> +				   PF2VF_MBOX_CTRL(mbx, mbx_id);
> +	while (try_cnt-- > 0) {
> +		/* Take ownership of the buffer */
> +		mbx_wr32(hw, reg, MBOX_PF_HOLD);
> +		/* force write back before check */
> +		wmb();
> +		if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
> +			return 0;
> +		udelay(100);
> +	}
> +	return ret;

I've not compiled this, but isn't ret uninitialized here? I would also
expect it to return -ETIMEDOUT?

	Andrew

