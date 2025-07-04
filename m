Return-Path: <netdev+bounces-204244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658A5AF9AB8
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E0B189DDA8
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09AE214A97;
	Fri,  4 Jul 2025 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RpWj/QBW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D082E3708;
	Fri,  4 Jul 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653546; cv=none; b=Z8uIKsmNaQcwY7eNNuYOsHcyOEw68f6bI57Wd9trdKlHXTK/VMl4RNXQ9VdiawEBieYEw+jp5ndUpK8cqlNGRy7HiN9d9qybpUdMGfwprgAkF0FXEUcrHUHlB4FJplG7fIWRZujLwAF0FVZuE1zEMu912gXsLaIsQ3GgfmFdYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653546; c=relaxed/simple;
	bh=Tcc2cp1J3hJghNlu06wLU838crKTMjvUyVsC8F7P9uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAvvJY9uHjeky5xt0UU8MUluv/KmY4vTFWycS5/Q3oDiC92D6YwcYK/kWsgYCtXyPQ3sudwYyhpcbI2GSesG0inAikmyw/oD51oXHPfhOhnJEMb7HiIK2JHfRsKFbsk3lBF0HdXVTCNU47eDVEsY/XO6ivZA6RG3YU9TXpjsML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RpWj/QBW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AhTPqugTJeHRSvrLtdRgJO1L1SfOKuOe2n2ufOgp31E=; b=RpWj/QBWWSvK3r8g/3Ln4y8Zy8
	4j4dkrGrEAcgjj+nj908KhaEOrIo5gmYvCXa8Q6MMc9dNKFngrBeTfMMv7h3XpOGl0hLtBN9P+KRJ
	tZl3naIM2dn6E/U2PSXcQ+IVUsg8ci5JpL9EhPyI6lLyHSRxQUf/dd3wXnwlc2tKgc2Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXl60-000HVr-2D; Fri, 04 Jul 2025 20:25:12 +0200
Date: Fri, 4 Jul 2025 20:25:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] net: rnpgbe: Add get_capability mbx_fw ops support
Message-ID: <57497e14-3f9a-4da8-9892-ed794aadbf47@lunn.ch>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703014859.210110-5-dong100@mucse.com>

> +/**
> + * mucse_fw_send_cmd_wait - Send cmd req and wait for response
> + * @hw: Pointer to the HW structure
> + * @req: Pointer to the cmd req structure
> + * @reply: Pointer to the fw reply structure
> + *
> + * mucse_fw_send_cmd_wait sends req to pf-cm3 mailbox and wait
> + * reply from fw.
> + *
> + * Returns 0 on success, negative on failure
> + **/
> +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> +				  struct mbx_fw_cmd_req *req,
> +				  struct mbx_fw_cmd_reply *reply)
> +{
> +	int err;
> +	int retry_cnt = 3;
> +
> +	if (!hw || !req || !reply || !hw->mbx.ops.read_posted)

Can this happen?

If this is not supposed to happen, it is better the driver opps, so
you get a stack trace and find where the driver is broken.

> +		return -EINVAL;
> +
> +	/* if pcie off, nothing todo */
> +	if (pci_channel_offline(hw->pdev))
> +		return -EIO;

What can cause it to go offline? Is this to do with PCIe hotplug?

> +
> +	if (mutex_lock_interruptible(&hw->mbx.lock))
> +		return -EAGAIN;

mutex_lock_interruptable() returns -EINTR, which is what you should
return, not -EAGAIN.

> +
> +	err = hw->mbx.ops.write_posted(hw, (u32 *)req,
> +				       L_WD(req->datalen + MBX_REQ_HDR_LEN),
> +				       MBX_FW);
> +	if (err) {
> +		mutex_unlock(&hw->mbx.lock);
> +		return err;
> +	}
> +
> +retry:
> +	retry_cnt--;
> +	if (retry_cnt < 0)
> +		return -EIO;
> +
> +	err = hw->mbx.ops.read_posted(hw, (u32 *)reply,
> +				      L_WD(sizeof(*reply)),
> +				      MBX_FW);
> +	if (err) {
> +		mutex_unlock(&hw->mbx.lock);
> +		return err;
> +	}
> +
> +	if (reply->opcode != req->opcode)
> +		goto retry;
> +
> +	mutex_unlock(&hw->mbx.lock);
> +
> +	if (reply->error_code)
> +		return -reply->error_code;

The mbox is using linux error codes? 

> +#define FLAGS_DD BIT(0) /* driver clear 0, FW must set 1 */
> +/* driver clear 0, FW must set only if it reporting an error */
> +#define FLAGS_ERR BIT(2)
> +
> +/* req is little endian. bigendian should be conserened */
> +struct mbx_fw_cmd_req {
> +	u16 flags; /* 0-1 */
> +	u16 opcode; /* 2-3 enum GENERIC_CMD */
> +	u16 datalen; /* 4-5 */
> +	u16 ret_value; /* 6-7 */

If this is little endian, please use __le16, __le32 etc, so that the
static analysers will tell you if you are missing cpu_to_le32 etc.

	Andrew

