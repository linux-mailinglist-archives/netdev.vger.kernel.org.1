Return-Path: <netdev+bounces-53209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA74801A14
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAE91C20B87
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D87619A5;
	Sat,  2 Dec 2023 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thKnZh+X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C38C17
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 02:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5262DC433C7;
	Sat,  2 Dec 2023 02:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701484625;
	bh=7TxLpYvEmtlsow83j0jT5kvwsPw4rjLxRzvb9Zl7cMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=thKnZh+XhU645J7FTtcZmdC443aYOo2RGAG6K1/bOr0BKyEsUmxTh5rh7CCcBIsCz
	 R8gebA+nTEq4l81+42rWf0X7cWxS7AwryjdVSwylUVcRKdBoac9swHmVdTIK1J1tMi
	 8WH7/N/TMoyu4Ul13X7V+VB6MTNFpI9jJ8rHZTPE4TSYgw1Vb1xKgCv3IKJS2h5Tib
	 Mq27Eh+tsaS+HyR+pguHBSkwfQ+Hr1XRvIDI813QV7EFQnC8/TtLQGHwaHzkWNx/jr
	 PwF36e3WMG0ifmEzJSeFYmiSgjBg+0/fiHG7XPQfE0fKqoKojCr7oq0+ypUs2Rqh+0
	 2WSEW54eNG4Lw==
Date: Fri, 1 Dec 2023 18:37:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pawel Kaminski <pawel.kaminski@intel.com>
Cc: intel-wired-lan@osuosl.org, netdev@vger.kernel.org, Michal Wilczynski
 <michal.wilczynski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v1] ice: Add support for devlink loopback
 param.
Message-ID: <20231201183704.382f5964@kernel.org>
In-Reply-To: <20231201235949.62728-1-pawel.kaminski@intel.com>
References: <20231201235949.62728-1-pawel.kaminski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 15:59:49 -0800 Pawel Kaminski wrote:
> Add support for devlink loopback param. Supported values are "enabled",
> "disabled" and "prioritized". Default configuration is set to "enabled.
> 
> By default loopback traffic BW is locked to PF configured BW.

First off - hairpin-bandwidth or some such would be a much better name.
Second - you must explain every devlink param in Documentation/

Also admission ctrl vs prioritizing sounds like different knobs.

> HW is
> capable of higher speeds on loopback traffic. Loopback param set to
> "prioritized" enables HW BW prioritization for VF to VF traffic,
> effectively increasing BW between VFs. Applicable to 8x10G and 4x25G
> cards.

Not very clear what this means...
So the VFs are Tx bandwidth limited to link speed.
How does the device know it can admit extra traffic?
Presumably this doesn't affect rates set by devlink rate?

> To achieve max loopback BW one could:
>  - Make, as much as possible, fair distribution of loopback usages
>    between groups to gain maximal loopback BW.

Can't parse what this means.

>  - Try to dedicate ports for loopback only traffic, with minimal network
>    traffic.

Or this.

> Changing loopback configuration will trigger CORER reset in order to take
> effect.

Changing config of a permanent param shouldn't trigger anything.
Please see the documentation for expected behavior..

