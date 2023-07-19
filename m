Return-Path: <netdev+bounces-18802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E14758B18
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8352E1C20EA7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407AA17D0;
	Wed, 19 Jul 2023 02:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380517C8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0248AC433C7;
	Wed, 19 Jul 2023 02:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689732023;
	bh=YJwEPUJUXPlvFsSXH2e3p2Mw9pqwhdhxV4QFcastR9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fgan/RFxYujq4+DYr8RrKxbXGaI5zPyPE9U8OR8/uSsGVIEQNSqq4XBxKdXzNiwGn
	 56OlXgaFreH172ua/f2A1iJQxo0e4lrquYY78ceHZ0/qgDz14pmn9yqcUBj5uud2WZ
	 QPhVb7HBWN9QphAXDZdmx2NxDFD9ebKUFMl5v6rx5RSzG4U7cyOeq/hLBGR+qETajH
	 Gum+sqxdr6yStAgrnVe7hBF4fhX6+aMycDby6DAmXT3LXpWrsqUmAvP5ayhOLT1+8W
	 plK75tKEyf5NVx879BhFcfwbnrfpKXcohEAp6/4I+HEImplJl40XOa3YbKKZ0ohyjj
	 4FWNVJzADbdgw==
Date: Tue, 18 Jul 2023 19:00:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jeremy Kerr <jk@codeconstruct.com.au>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 3/3] mctp i3c: MCTP I3C driver
Message-ID: <20230718190022.66268d21@kernel.org>
In-Reply-To: <20230717040638.1292536-4-matt@codeconstruct.com.au>
References: <20230717040638.1292536-1-matt@codeconstruct.com.au>
	<20230717040638.1292536-4-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 12:06:38 +0800 Matt Johnston wrote:
> +/* Returns the 48 bit Provisioned Id from an i3c_device_info.pid */
> +static void pid_to_addr(u64 pid, u8 addr[PID_SIZE])
> +{
> +	pid = cpu_to_be64(pid);
> +	memcpy(addr, ((u8 *)&pid) + 2, PID_SIZE);
> +}

put_unaligned_be48() ? That or you need a local variable or something,
because otherwise sparse is not happy (build test with C=1).


