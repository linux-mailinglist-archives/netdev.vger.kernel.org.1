Return-Path: <netdev+bounces-118487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72E951C30
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AF3B2316B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDAE1AD9D6;
	Wed, 14 Aug 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idHyUaVc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF221DA5E;
	Wed, 14 Aug 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643421; cv=none; b=Vq8KDREz32XuLwa+b6g2W8di0mTTSC0iKf2PzAfLQKc5+6iKYZs3SNUZriLjSRXYG15GkO44kOVS1lyUAYoXMq+Sbnr2XCCIRxUDKl7CmwptHIPgTXoFMWrYwQQYeUZFQnpxf6z+8RomvDwqI8je4/7wIaFxBrSf0ooXwKo0soY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643421; c=relaxed/simple;
	bh=Kw+XlTMl2iL53nQYEy4hsiCKGhI9ZACh2cz6PiKd0Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS5YIDJ67Tqjm8So7K4q5T7IPq/2R3ZEmQWNfzPyklCS+rKN/0Q+1LJaTJSjSGX8wkbqW1GNFOziqH+F8zNjQ8Xv8KwbP1fMbgy0EnVooDuZZgmxahctnigmM9Mlw1xNDGWsEOdAATo/jgwhFoTyCFUTLgz94U6HmJ+ceKANO4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idHyUaVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EA8C32786;
	Wed, 14 Aug 2024 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723643420;
	bh=Kw+XlTMl2iL53nQYEy4hsiCKGhI9ZACh2cz6PiKd0Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idHyUaVcWvfxVmA90KoxoIgzCUebYlKNJuASj6XGcJY5KD9cvaDlsksrOoFOPxEN2
	 zL2RGNPWR1F2Hrg9v/N8V2rlfpsVAja0mLveUInj6N31j6qtS6dH6U8nvyw831I2oW
	 f/X/4CufUTlYykN/THi8WTwOw1zkK21xtufeyPmuaiMcAf1+5MZQ17gvCWhv+pw2bK
	 nOgdGI3pOWmb5K52KtlfDwaGHL7YMH6Qf/rjvDh9o0SFteGOnNGLY3/AzlnPaS8IPu
	 fIbz0fWdoOeGxwUGcuikPcx4gqvx8L7mYntXgnEPhhf/zCDqXlXKp3LtJcTRhn0iLX
	 on/wRZiOuG7Jg==
Date: Wed, 14 Aug 2024 14:50:15 +0100
From: Simon Horman <horms@kernel.org>
To: Daiwei Li <daiweili@google.com>
Cc: intel-wired-lan@lists.osuosl.org, vinicius.gomes@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, kurt@linutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com, sasha.neftin@intel.com
Subject: Re: [PATCH iwl-net v3] igb: Fix not clearing TimeSync interrupts for
 82580
Message-ID: <20240814135015.GB322002@kernel.org>
References: <20240814045553.947331-1-daiweili@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814045553.947331-1-daiweili@google.com>

On Tue, Aug 13, 2024 at 09:55:53PM -0700, Daiwei Li wrote:
> 82580 NICs have a hardware bug that makes it
> necessary to write into the TSICR (TimeSync Interrupt Cause) register
> to clear it:
> https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/
> 
> Add a conditional so only for 82580 we write into the TSICR register,
> so we don't risk losing events for other models.
> 
> Without this change, when running ptp4l with an Intel 82580 card,
> I get the following output:
> 
> > timed out while polling for tx timestamp increasing tx_timestamp_timeout or
> > increasing kworker priority may correct this issue, but a driver bug likely
> > causes it
> 
> This goes away with this change.
> 
> This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").
> 
> Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
> Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
> Tested-by: Daiwei Li <daiweili@google.com>
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Daiwei Li <daiweili@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


