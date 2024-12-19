Return-Path: <netdev+bounces-153205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B69F72BF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135311606A1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDED4C62E;
	Thu, 19 Dec 2024 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL53v3FD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C414C98;
	Thu, 19 Dec 2024 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576002; cv=none; b=G8qsg3qtj75uXnSxXrTAAdqUktYLMydXSuQ4Jfs7TXLoNWLkdKp+XM8rtXJIiy0orllNG0+vAZEQhC1RpMeqW8LgH+QonRQE5ni/ZMTkgdsWKXDV7kYNzkflZq6xB8tYAd2bSbl0FJGUxd2mwTcWv9Tpl5V2B6ZysR5O+WnkknQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576002; c=relaxed/simple;
	bh=vKLJHw73PJA3RxCFiumx6TzKKYobGTcZsPkxNzzne0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug8I+mVaTwgTjAkPqWy5bv3YdQJHfDAfMzLrjPkPawa+UQGDinYCbtyUplco7HUq6o5aXlBfAnz80ZtiaHfV/BMYznkxZCnT1SBn08qwndtow/HtF5F+10Bodm9JSR4VB0bRnaYYQ54vfO2pbYyntLd0HYvIcaKd5Xef20aICCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL53v3FD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BE5C4CED4;
	Thu, 19 Dec 2024 02:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734576002;
	bh=vKLJHw73PJA3RxCFiumx6TzKKYobGTcZsPkxNzzne0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JL53v3FDMQcVOmaWZzJgoHZZoZNxibG3ElB8G4kFd5GN8rOrgKx2RD3qwGHv9xQML
	 JMgMmn+ecLvTURzHqShyKatg+l/HURjQgqWFdM+0ma89wnyVyhS2K/2bZDPyRasuzJ
	 KkiNvAMcGMwrD2IoKoCAOHYgI1cnld2NcKWbR3VoqY08iRs9NqI97nnQI0AIuSM4cy
	 C7gyGSUNQC7aBNqRuhccpwkXKed7KUswuis1RZ7604goWRDBaWeG15ABGLSV6hIIcN
	 af4+DhzffnlpdfpXdiCiih9XMi64zBI2JQAG7grSOCC2YJn+ZaiG2GBdVk+KS29x0y
	 tEAkcHL9Det5Q==
Date: Wed, 18 Dec 2024 18:40:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com, Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next v6 5/9] bnxt_en: add support for hds-thresh
 ethtool command
Message-ID: <20241218184000.54831119@kernel.org>
In-Reply-To: <20241218144530.2963326-6-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-6-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 14:45:26 +0000 Taehee Yoo wrote:
> +#define BNXT_HDS_THRESHOLD_MAX	1023
> +	u16			hds_threshold;

How about we add hds_threshold to struct ethtool_netdev_state ?
That way in patch 6 we don't have to call the driver to get it.

