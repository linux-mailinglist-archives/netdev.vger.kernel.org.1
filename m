Return-Path: <netdev+bounces-217812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B80AB39E3C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE5A7A5F64
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410A53112B6;
	Thu, 28 Aug 2025 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vWlr/4qF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94B252287;
	Thu, 28 Aug 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386629; cv=none; b=m3M9URriVnmLDe9WA7TkiIsXwFgUPtBxET100L5RfOELCTlp4uwXfY8D1/1U15F9JBsxqqn0Ka+gWKsndo1OMPKAW3KoQWVvzoxuExQzbRQsN2Pr1U+HhFjvVZQOocLsdiADQz4IXWnriMXk6riP3BvWN+1+Kn520aqtG2lMnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386629; c=relaxed/simple;
	bh=RP4hhlUZFqr/PXbvOj7ki0OGQu3tUUaRE+88SHWZvUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjBm0fkzFrxlXqi6P3Qbp8/+D2CaOkS4CQ4c6++fmI5OwKEYpxUD7ih8Gn/KyhiFPTH7omstD33ORNguW8WJXVm7mM7L6B3DkGE+hnhoCdST6pCKn5DoHKERFsb5tPMz9U6SIYGvrJpCsvHWZ5FuOi5mhrwSej2FuShJmePlf8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vWlr/4qF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZgHJyH1Thn6hr9eqb7wen/YTFYfIZYXGE3JFBASoTCE=; b=vWlr/4qFD4maCDFmryyaHbSKNc
	vDBk4VOuRvM2LOgooLxRXI7G9yDjtoPY2wAdLKwLBp7yhhiT7Vg9c0UF41LYoNjhFoYjKK4jYNYA+
	CB4Cgtcs2Ulp/cyrjKmIHwGoMSKdTZjQFdOvOU+NUcVEn/075PHygR7YhyBAENoJZCqg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urcNz-006LtL-IA; Thu, 28 Aug 2025 15:09:51 +0200
Date: Thu, 28 Aug 2025 15:09:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v9 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <d61dd41c-5700-483f-847a-a92000b8a925@lunn.ch>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828025547.568563-5-dong100@mucse.com>

> +/**
> + * mucse_mbx_get_capability - Get hw abilities from fw
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_get_capability tries to get capabities from
> + * hw. Many retrys will do if it is failed.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +int mucse_mbx_get_capability(struct mucse_hw *hw)
> +{
> +	struct hw_abilities ability = {};
> +	int try_cnt = 3;
> +	int err;
> +	/* It is called once in probe, if failed nothing
> +	 * (register network) todo. Try more times to get driver
> +	 * and firmware in sync.
> +	 */
> +	do {
> +		err = mucse_fw_get_capability(hw, &ability);
> +		if (err)
> +			continue;
> +		break;
> +	} while (try_cnt--);
> +
> +	if (!err)
> +		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> +	return err;
> +}

I still think this should be a dedicated function to get the MAC
driver and firmware in sync, using a NOP or version request to the
firmware. The name mucse_mbx_get_capability() does not indicate this
function is special in any way, which is it.

> +/**
> + * build_ifinsmod - build req with insmod opcode
> + * @req: pointer to the cmd req structure
> + * @is_insmod: true for insmod, false for rmmod
> + **/
> +static void build_ifinsmod(struct mbx_fw_cmd_req *req,
> +			   bool is_insmod)
> +{
> +	req->flags = 0;
> +	req->opcode = cpu_to_le16(DRIVER_INSMOD);
> +	req->datalen = cpu_to_le16(sizeof(req->ifinsmod) +
> +				   MBX_REQ_HDR_LEN);
> +	req->reply_lo = 0;
> +	req->reply_hi = 0;
> +#define FIXED_VERSION 0xFFFFFFFF
> +	req->ifinsmod.version = cpu_to_le32(FIXED_VERSION);
> +	if (is_insmod)
> +		req->ifinsmod.status = cpu_to_le32(1);
> +	else
> +		req->ifinsmod.status = cpu_to_le32(0);
> +}

Why does the firmware care? What does the firmware do when there is no
kernel driver? How does it behaviour change when the driver loads?

Please try to ensure comment say why you are doing something, not what
you are doing.


    Andrew

---
pw-bot: cr

