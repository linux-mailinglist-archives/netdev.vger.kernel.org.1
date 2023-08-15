Return-Path: <netdev+bounces-27546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B9B77C607
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234C7281280
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2C17EF;
	Tue, 15 Aug 2023 02:43:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261B622
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64589C433C8;
	Tue, 15 Aug 2023 02:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692067418;
	bh=7blTAewUXh9WclBQZ+mReosFc6JNCK0kdPIFgrfLNQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bL23djTCRcM7r+1Gp9qSDhPMBmz3x/C4x5iSW4nmvHKAbKinIWMu1gpgCHV4bQVvO
	 iocZQpk1ugrWIBmTlyjBYz5Fvl9hd/E+NoXEsPmh+rGNp31RAAKtoxKTO8IEl0Gwoi
	 uUldRosk0KIrHE/IQPDAjJ8cgdfeDS1VMB+IcNrZrxPJL9JgBvr/jscPaqc7XPbxg1
	 2aF7Hq0AWIZ7l7eqt7jdapEwypftzA2y2QjPKmz22u2HCEuwNz3EblWVp3FbN0p5RS
	 cYrQr31icAt0/4PEiCaf6+BlAmGP9viia3Y2nGMjQ9XfUPNzOM+9WK2H4UgWY2UNXz
	 CM5OJBRgrf65Q==
Date: Mon, 14 Aug 2023 19:43:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Milena Olech
 <milena.olech@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com,
 mschmidt@redhat.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org,
 Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v4 2/9] dpll: spec: Add Netlink spec in YAML
Message-ID: <20230814194336.55642f34@kernel.org>
In-Reply-To: <20230811200340.577359-3-vadim.fedorenko@linux.dev>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
	<20230811200340.577359-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 21:03:33 +0100 Vadim Fedorenko wrote:
> +attribute-sets:
> +  -
> +    name: dpll
> +    enum-name: dpll_a
> +    attributes:
> +      -
> +        name: id
> +        type: u32
> +        value: 1

value: 1 is the default

> +      -
> +        name: module-name
> +        type: string
> +      -
> +        name: clock-id
> +        type: u64

I don't see a pad, you have a u64 without a pad?

> +      -
> +        name: mode
> +        type: u8

It's an enum, should always be u32 or bigger at protocol level.
Netlink pads to 4B, you're not saving any space.

> +        enum: mode
> +      -
> +        name: mode-supported
> +        type: u8

Same.

> +        enum: mode
> +        multi-attr: true
> +      -
> +        name: lock-status
> +        type: u8

And here.

> +        enum: lock-status
> +      -
> +        name: temp
> +        type: s32
> +      -
> +        name: type
> +        type: u8

And here, etc.

Why are all attributes in a single attr space? :(
More than half of them are prefixed with a pin- does it really 
not scream to you that they belong to a different space?

> +operations:
> +  enum-name: dpll_cmd
> +  list:
> +    -
> +      name: device-id-get
> +      doc: |
> +        Get id of dpll device that matches given attributes
> +      value: 1

is the default
-- 
pw-bot: cr

