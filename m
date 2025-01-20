Return-Path: <netdev+bounces-159879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC18A174C0
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 23:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F3C7A1615
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 22:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554B1ADFF8;
	Mon, 20 Jan 2025 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNk6as7G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC014689;
	Mon, 20 Jan 2025 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737413009; cv=none; b=eDbY6PEmpDcgsUAPKzVis6rn8e4Bmme14vMX4fNj9qK2PoXOM8MN2m2N+Ft9IKbem56SglMvWxxae4MD378nkCAk22EbCBWQ9GYNjLtnKP3NTe7od4TldWmi5lxcnmXsZ40HGDsVbkwwRHPI1Rm0smuqdGStHuq+5HbnsVnav8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737413009; c=relaxed/simple;
	bh=z69gFIH//ZlFDvp1P7DiFupCiZ1ouIVMzhlLDxAnnXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkT1XmwM2v27Bvu4GP0AdK+CWJZHS/YWFgALxBMYznfI5pPmd5u5Dqg9qyjXU3w2lKadg9UdzGE0RWs2doLgkyLkrIubjdktBJlmrRwOEwE+BRay3MYqSPZudkPE3ji8yw0wGBpuHVEoWFhC2vVc5f/e79NMWA2jMeiCHLnpE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNk6as7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FF1C4CEDD;
	Mon, 20 Jan 2025 22:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737413009;
	bh=z69gFIH//ZlFDvp1P7DiFupCiZ1ouIVMzhlLDxAnnXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LNk6as7GdZ6b+wJ7wbPb3aqZkb82XYmAc+CO42cjWyeg5lV/K9H7Xpm29HqemY8HW
	 ryTZO7OzSeR8Q5JfyNofnYTZRAg7EUBwkP1/fBdo5BMUFuGYW7K3DogZ6EYMAjz1NR
	 j9uHWautRwZU5RytU5hFyob9pZ8HKtqo+5LE8eULI2BdTvJQXmecd/1acLQqV3LgYs
	 XeQXR3xyvxUc0tHbE5+o2n9fKVtE0jSoKhDyaYwBPvq0XwPIQHMgK1/ZCK+7wd3A4P
	 Z0826f8SVBKZXKP+R69tWnTKkBliTDIi8RNJauqLej+vh2m66QdkirtfW5CXqUGZHq
	 wva9TH1ay8vWA==
Date: Mon, 20 Jan 2025 14:43:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v15 1/1] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20250120144327.4960793b@kernel.org>
In-Reply-To: <20250115195217.729071-2-admiyo@os.amperecomputing.com>
References: <20250115195217.729071-1-admiyo@os.amperecomputing.com>
	<20250115195217.729071-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 14:52:17 -0500 admiyo@os.amperecomputing.com wrote:
> +	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +	if (rc)
> +		goto cleanup_netdev;

devm_add_action_or_reset() calls the cleanup handler on failure,
so just

	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);

directly. As is you'll double free the netdev on failure.

> +	return rc;
> +cleanup_netdev:
> +	free_netdev(ndev);
-- 
pw-bot: cr

