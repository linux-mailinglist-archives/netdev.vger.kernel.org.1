Return-Path: <netdev+bounces-56566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C680F671
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E13B20DE1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4C81E2E;
	Tue, 12 Dec 2023 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJnt4hSj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D57B3A1
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 19:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CECC433C7;
	Tue, 12 Dec 2023 19:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702408748;
	bh=VxUoH5W5QC5FMheEWzI9jkp0t9473bp8pPVB/cabv8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EJnt4hSjmhNoJdTQBC3pAIpLXXR60HMnuj7GY98aRzTVrTSMiSR7FQbNGgf04MACC
	 UEJ1I75/BzQawTP6amcrMVoo0fzVVH7OlW78OY6upyqPsEBEtzu9wXuOK4cq0IQcMB
	 FY1j3CqXTyoH0rLYlxeUcXAkSHJ694vOd9CmFZA1LTtN2Aw6hvxBwfuCRR2ZBcUic2
	 vZakpo64JMHxfEPwV5B47K7y5b12bTDGFDkhaPDhK97iLDYpjLBuEOBVsbTlMpDQM5
	 eqanzn7KJPQhcAk5KQfqIiu+NkkKPr66qK4V6//XNdTbTj6zMhgO0WG4zrZO7B8kbR
	 oY8UG/MKLO46w==
Date: Tue, 12 Dec 2023 11:19:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 09/13] rtase: Implement pci_driver suspend
 and resume function
Message-ID: <20231212111907.543e8f04@kernel.org>
In-Reply-To: <20231208094733.1671296-10-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-10-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 17:47:29 +0800 Justin Lai wrote:
> +static int rtase_suspend(struct device *device)
> +{
> +	struct net_device *dev = dev_get_drvdata(device);
> +
> +	if (netif_running(dev)) {
> +		netif_stop_queue(dev);
> +		netif_device_detach(dev);

detach stops the queue, you don't have to call both

> +		rtase_hw_reset(dev);

