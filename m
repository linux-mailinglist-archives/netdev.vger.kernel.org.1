Return-Path: <netdev+bounces-96842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 588498C800E
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E16A9B20AEB
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B88F68;
	Fri, 17 May 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr8sl432"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961778F55
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913946; cv=none; b=mozbkfR79IpMnz36HJNPsdHuO4zZSwBJb+44fxLUGLQa062Ql9kUksSZt6QsC63qjzCRp5OtUbV8T885fVaptnbjp5CYTfJ5HG46hgBw8rHMEKlga+yRStHi4RUl5oKje70nil3KeN6Em/zdm6E4JKVAw/sHP9pa7dorhjE/J9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913946; c=relaxed/simple;
	bh=O/3b3/sqWWrSiGoMJEMH9sNyw5qb9uejGMPFpPXu+/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwWWcgiRM+kaiASR8PTRC6i20NRDZIIm5TPeVFXu3bRmEGYFpPeTl/F8qJfiUqDhJkh8uI6nq7auKgDbmutofyfoRIJym0iBslkzgWBTK4dGsWrtbvgQjH99vvMWlmSs9RIHT1nwk8DW+gxLCkHTuY9h1XwBlD5ZiFZ2BUc+5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr8sl432; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABE7C113CC;
	Fri, 17 May 2024 02:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715913945;
	bh=O/3b3/sqWWrSiGoMJEMH9sNyw5qb9uejGMPFpPXu+/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gr8sl432k3Un2O9BjaUfaNj0FH5tcDdu1oXZ0lvmbDXRbwbx+n3vOtYjbYUiwLUQ/
	 G7igGGT52pPMqLvkJSRnjGCsDpKm02iUixPElVrQu12D/0cx6ey6XHNPQIk6unKoCy
	 JamBfi/UiXsuHyz30XL4qx1tc3pXlQA+XWD4xjBXlRb5lXurdMABj8mAL8XlnldGRZ
	 y+zKfnszykwpktg/hVNl8bluLfY7D/7GvhnbIldHpH++URpLit/Zz/WJIX+0brPTX4
	 RWHZzueYUo/tooF0w/FudMfY1rTeeq5jJlxR6njiKoYq7jbY2Z1Ixt7wmPhS7e+A7c
	 N447DIYX70PIg==
Date: Thu, 16 May 2024 19:45:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com, duanqiangwen@net-swift.com, Sai Krishna
 <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v4 2/3] net: wangxun: match VLAN CTAG and STAG
 features
Message-ID: <20240516194544.67d9249c@kernel.org>
In-Reply-To: <20240514072330.14340-3-jiawenwu@trustnetic.com>
References: <20240514072330.14340-1-jiawenwu@trustnetic.com>
	<20240514072330.14340-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 15:23:29 +0800 Jiawen Wu wrote:
> +#define NETIF_VLAN_STRIPPING_FEATURES	(NETIF_F_HW_VLAN_CTAG_RX | \
> +					 NETIF_F_HW_VLAN_STAG_RX)


> +	if (changed & NETIF_VLAN_STRIPPING_FEATURES) {
> +		if (features & NETIF_F_HW_VLAN_CTAG_RX &&
> +		    features & NETIF_F_HW_VLAN_STAG_RX) {
> +			features |= NETIF_VLAN_STRIPPING_FEATURES;

this is a noop, right? It's like checking:

	if (value & 1)
		value |= 1; 

features already have both bits set ORing them in doesn't change much.
Or am I misreading?

All I would have expected was:

	if (features & NETIF_VLAN_STRIPPING_FEATURES != NETIF_VLAN_STRIPPING_FEATURES) {
		/* your "else" clause which resets both */
	}

> +		} else if (!(features & NETIF_F_HW_VLAN_CTAG_RX) &&
> +			 !(features & NETIF_F_HW_VLAN_STAG_RX)) {
> +			features &= ~NETIF_VLAN_STRIPPING_FEATURES;
> +		} else {
> +			features &= ~NETIF_VLAN_STRIPPING_FEATURES;
> +			features |= netdev->features & NETIF_VLAN_STRIPPING_FEATURES;
> +			wx_err(wx, "802.1Q and 802.1ad VLAN stripping must be either both on or both off.");
> +		}
> +	}

