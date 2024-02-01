Return-Path: <netdev+bounces-67760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB268844E27
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3E5B215A6
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F61FB5;
	Thu,  1 Feb 2024 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRZEcMRF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D986FBFA
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748304; cv=none; b=HWq7HFIvcVDkEY0u46tcdXfGlhhofkObNUrDRmh4jvwdt5pKVS1e9URwyibxfPVlQhQFQAQrLD/k1GTRxXJbKFALN/jGqFgvQr5C2jEhEhS1n6ZvzaSaL2FfxaBt4VatUs60iguy4UFSLTbZu3UAgdlx8dopNI1B9wo5l7XqwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748304; c=relaxed/simple;
	bh=MKxbIlbE/ItrBHLkTVW7xv3F9cS80aX1XEtWBTfyMO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMPkJZZzl2GCfqvPC8fM9sb44r2hlrcwnSDbTcIqUuqweHHT9z71v3YOk+2MPH2cT5WFNn+HRXSV8ZgUDTTJ8biXsHY9iNs48QitvoDHcbqhMa9tRmiKSKO/iQaKNRBzItN03vaO4K//2w+Aml6sdItwdZRRDXjtBEmy3m+6xlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRZEcMRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F7AC433C7;
	Thu,  1 Feb 2024 00:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706748303;
	bh=MKxbIlbE/ItrBHLkTVW7xv3F9cS80aX1XEtWBTfyMO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TRZEcMRFKRMO0VyE2F9XCfHwUAIUIH1/A6R51IekxK77dovOerkBi/3DnT57/bSAK
	 /9kR97XvdBYz6VMhhcH7+oF+oKHFsFUrEtHrrCVEZBxQ4xprPa5GreiilYwfLEbqCf
	 tjC5XBrsMERbjtXKLn3LHMO++Xt4Ni5zOrPX1Nr91TMV/fACdTDS69Ph/FLjYKZmYp
	 AhkjEt63LU2mvdpbfA0KVZ2Bqg6Ag+lMRI1NFgmwGsYoGgr/571+gS8/yfOk67L2Az
	 MMFiWLOwlSZN/Z+p832b16avWsuQXZo2I7U6RkhzjmkgFWLg2/qcJbJxrd4r/WQ1mm
	 2ANBrHy2PeVuw==
Date: Wed, 31 Jan 2024 16:44:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 0/5] netdevsim: link and forward skbs
 between ports
Message-ID: <20240131164459.314a809b@kernel.org>
In-Reply-To: <20240130214620.3722189-1-dw@davidwei.uk>
References: <20240130214620.3722189-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 13:46:16 -0800 David Wei wrote:
> [PATCH net-next v8 0/5] netdevsim: link and forward skbs between ports

There's only 4 patches here, you'll need to repost because you promised
patchwork 5 by saying 0/5 :(

