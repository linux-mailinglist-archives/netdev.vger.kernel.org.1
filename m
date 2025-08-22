Return-Path: <netdev+bounces-216061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40BCB31CB5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A26660F36
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1613126DA;
	Fri, 22 Aug 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uJ3Lzm8y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8563126CB;
	Fri, 22 Aug 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873831; cv=none; b=pI2XqfSfG05qA0qfAn8eHrbVu9Q2IIW6n7Gw82aQSdEJnmepkT5ajxVnzS8RMocDvQD7vZ8+5UBDpaA4LEfqlAwLAmpnzGyNoeXz3NSb3sIGq1/bpYH5fB0SFW99EOAIgKbEFVEHmkCJbeXSlazIZcwP31TPu1sTYtPTsl4SM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873831; c=relaxed/simple;
	bh=WPMCrHHzE2hhfHZBnURWyoybvJ5z/YbKy51IBm6AuvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbxXvTTCslgbyeyY99C0rsPJkuiyyvQ6DLQ8w/1hE7XxhkQLOASXkkisJwjsNrxrLa70F7nNwnIZ5Xrv8CRn3qbeqIroUSYXAkKKdy/qLqpUuBDUJBAywh5ZTXytP0l/D1hkipozGso4n9/R5n+yZboQRBzHc1kjS8oJ8SZq8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uJ3Lzm8y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rScHYwZSlxC2HrLw2hQbx6nHAeXoUXmhjKWdXFiabhg=; b=uJ3Lzm8yODr7Mfw7U+hOsyrOxd
	BQEFdwgg9n1pSGQ1qELsnLAXTs0f6Q/CFSFpaMpf0Rb5IMPm1ES0YCaDNieSxpFs6KlVzSmi+5qkN
	0kPYaH9kdL3gYiMBFwoAiLqJ9m37j9RKxiZEw8ti5mIrFw4BbO3Cpi8hm8hAp6iE7A10=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upSz6-005acg-Kr; Fri, 22 Aug 2025 16:43:16 +0200
Date: Fri, 22 Aug 2025 16:43:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <a066746c-2f12-4e70-b63a-7996392a9132@lunn.ch>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822023453.1910972-5-dong100@mucse.com>

> +/**
> + * mucse_mbx_get_capability - Get hw abilities from fw
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_get_capability tries to get capabities from
> + * hw. Many retrys will do if it is failed.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_mbx_get_capability(struct mucse_hw *hw)
> +{
> +	struct hw_abilities ability = {};
> +	int try_cnt = 3;
> +	int err = -EIO;
> +
> +	while (try_cnt--) {
> +		err = mucse_fw_get_capability(hw, &ability);
> +		if (err)
> +			continue;
> +		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> +		return 0;
> +	}
> +	return err;
> +}

Please could you add an explanation why it would fail? Is this to do
with getting the driver and firmware in sync? Maybe you should make
this explicit, add a function mucse_mbx_sync() with a comment that
this is used once during probe to synchronise communication with the
firmware. You can then remove this loop here.

I would also differentiate between different error codes. It is
pointless to try again with ENOMEM, EINVAL, etc. These are real errors
which should be reported. However TIMEDOUT might makes sense to
retry.

	Andrew

