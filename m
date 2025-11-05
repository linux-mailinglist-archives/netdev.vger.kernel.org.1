Return-Path: <netdev+bounces-235741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C912C3473F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 09:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8824622C2
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0132E25F99B;
	Wed,  5 Nov 2025 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSvnUixA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F02AE89;
	Wed,  5 Nov 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331127; cv=none; b=MHfdAuWrHGBmJW/V+QLrvu/uAu0lcaI+U8wpP3+tHstgulJ6mwcLIBhMmG46FRZ4RHpPZHQw97VT3nmcwkTtukqo2OtbOu1nxxQ5tMGjWg6YXBJHic5VzvvhIvvZCxZDKdh3tkgMpvEBwJSSmghIyFsfMzK1zgyOQ/Ep4kJs74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331127; c=relaxed/simple;
	bh=GFrmdT/6vh6KitZbPk5RwLAg24STo8UOkiJxvnUUROM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLKwDjW/eaPwiiM8dMvXOwYOmqu9x9DlRIdtYo8aQnpsE2Y1m6S6MQTe2mBTKgbNeXvu8R1CsbhERKX2xpORDFpw/vNV8QgiOo3QGepOgAFdjLex7tmp5o/xlrNZKlHY58s4OMdoIdg7ibA4i2P8ldmk8Y001bEgcQqUbmEFaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSvnUixA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799CAC116B1;
	Wed,  5 Nov 2025 08:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762331127;
	bh=GFrmdT/6vh6KitZbPk5RwLAg24STo8UOkiJxvnUUROM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSvnUixAH7/lM170v6NohX/PiUR2BPHEycruL3+BtLy8LHbjuBLZVsLQ5Y3S8xxch
	 6yc2F0InengDSLn3VwbgtwQV46+azBAQy5eDtoQCS6IhngoqBgUphJjF+NG2kYrcOQ
	 OH+PqfB+LBWeyAb3DZWXKvOzYY6tE7imFCcbtqpfduHtlQ10Sud0GCrei197vV8gmK
	 SAS+7XcxQw0BdYTE8owjL7LwfvDb2bzjXM43ZsSDauC9pn5N30S5RLM5JQJq6ZwDuw
	 b542dok4FUX/Qc1NRMJFxEFnSF2tJIzr2NmsvO/34/q2ro3lRC5ntT5oKBpZGntGXY
	 oFYbVAAU7H4jA==
Date: Wed, 5 Nov 2025 08:25:21 +0000
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Markus.Elfring@web.de,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v04 2/5] hinic3: Add PF management interfaces
Message-ID: <aQsJ8a4XXE3HXR7A@horms.kernel.org>
References: <cover.1761711549.git.zhuyikai1@h-partners.com>
 <2acb500c38c11b0234e8616da7c2a941c344659f.1761711549.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acb500c38c11b0234e8616da7c2a941c344659f.1761711549.git.zhuyikai1@h-partners.com>

On Wed, Oct 29, 2025 at 02:16:26PM +0800, Fan Gong wrote:

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c

...

> +static void hinic3_print_link_message(struct net_device *netdev,
> +				      bool link_status_up)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	if (nic_dev->link_status_up == link_status_up)
> +		return;
> +
> +	nic_dev->link_status_up = link_status_up;
> +
> +	netdev_dbg(netdev, "Link is %s\n", (link_status_up ? "up" : "down"));

Hi Fan Gong, all,

Coccinelle suggests that str_up_down() could be used here,
which does seem like a reasonable suggestion as it seems
there will be a v5 anyway.

> +}

...

