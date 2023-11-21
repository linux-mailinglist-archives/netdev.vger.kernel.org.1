Return-Path: <netdev+bounces-49527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C90E7F2464
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC83B21DAA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D110A2E;
	Tue, 21 Nov 2023 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTOqPk2G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3A79FD
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0CAC433C7;
	Tue, 21 Nov 2023 02:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700535085;
	bh=jzFLypdyexZrCqSF6iFxToybPk02MHrX9JCD9eGPiGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kTOqPk2GoUptxTB0EyMDeuS95/OF2JHICsKOi4lYlkUdxw/QBjscFLghQS/2QNRls
	 moev1Nt00sw/XbtI2ZyKulzNM3dg+Vup8dLI/oBXcAmDeyKO1KMjYVGKbUUuAh4Tgt
	 GiltqJX6/bPRfgFLWd4NkEToY2YalKK6cp5Z0IpBM9b1bXlOYRH9lXcpmy50nHAS8k
	 4R2KKqebM21LAgcs9NACi190EuCthmRxPyxsJ9cZrsQTnHgflXpl0M0LTZAVvY95ui
	 aHEKKScJRfvmppxwRHnXkW3U9+YpUT5F3C4obfaUAkdcNZASJ0Xb34MRxdfQgfX0Z4
	 ZsFHM7Vk/GOdA==
Date: Mon, 20 Nov 2023 18:51:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Message-ID: <20231120185123.020ad0a2@kernel.org>
In-Reply-To: <20231120084657.458076-9-jiri@resnulli.us>
References: <20231120084657.458076-1-jiri@resnulli.us>
	<20231120084657.458076-9-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 09:46:56 +0100 Jiri Pirko wrote:
> +	if (attrs[DEVLINK_ATTR_BUS_NAME])
> +		data_size += nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
> +	if (attrs[DEVLINK_ATTR_DEV_NAME])
> +		data_size += nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;

> +	/* Don't attach empty filter. */
> +	if (!flt->bus_name && !flt->dev_name) {

Should the attrs be checked with GENL_REQ_ATTR_CHECK() then?

