Return-Path: <netdev+bounces-189747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC7AB37BA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D654A1B60F92
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F72294A0D;
	Mon, 12 May 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwMJlLjY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC528D837;
	Mon, 12 May 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054154; cv=none; b=H7hsLvPLmIBl6XQ+ctUI53RIp1tUU72LWOB1kpzNeOdwBd2xbx7pG9zt9tJZSFTPiq0b9/jnlCKOzPCXYm6Go2sxBhF8Jp4bwAVveF3TBVxjjvFr4FE0/4FlmRhKczy3setIXZXjF1yHJB1AsVN7A54R9/xLq7WlU4fT6W1CM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054154; c=relaxed/simple;
	bh=uXEcchTcO63su+JbMHctt2KTy/tOE1VE6ZfMeTnDk1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuJeQnmwhju2qk+lLiHg0aEurfn/XYCjI6VJisNv7r2QKK6kPPiosJVMydHlOrl7r9gePqSiUwDkViGOuMaz0ip17xDKvUAkrZOvvkSHOfPYZ6oSG0TQrKrt1fAOfaUw2A5SIop8Pl6PFYiuDculIbffmQuxEn4cX2oKZ6UuJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwMJlLjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3731FC4CEE7;
	Mon, 12 May 2025 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747054153;
	bh=uXEcchTcO63su+JbMHctt2KTy/tOE1VE6ZfMeTnDk1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwMJlLjYQGzc0DdFsmf6RtXqsHabVagYiHF9JKeEXSPeEOIThqkuQyMFu2Po1nvxt
	 ByirJmikQ3bCxGfTpM5fd7773amvGS2RTOAwDpqD9QhtNxPSnGEl3bSICbeYz14Dxr
	 JQXqFaby7WFAycfSFR1zEzq4S7Hy6sg8DsKVEv6vFBiIha4jxqLHoSnqQOr4rdlYX6
	 qrCJmTKFxxZ0K6qqHBtfCuvAMwWzNA0xCbF9YvwWc3bEsPxdwQ0XPYaN7bGhzAYgXO
	 eB9lDrzS22MiqLcg7daBEihH221ofrW3WpyGZYJY1C4bJVDZ8i/YYohu2CZBKJEpQW
	 W+6divt6VYZDg==
Date: Mon, 12 May 2025 13:49:06 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: Re: [PATCH iwl-next v3 00/15] Introduce iXD driver
Message-ID: <20250512124906.GA1417107@horms.kernel.org>
References: <20250509134319.66631-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509134319.66631-1-larysa.zaremba@intel.com>

On Fri, May 09, 2025 at 03:42:57PM +0200, Larysa Zaremba wrote:
> This patch series adds the iXD driver, which supports the Intel(R)
> Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
> It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
> exposed by the same card. The reason for the separation is to be able
> to offload the control plane to the host different from where the data
> plane is running.
> 
> This is the first phase in the release of this driver where we implement the
> initialization of the core PCI driver. Subsequent phases will implement
> advanced features like usage of idpf ethernet aux device, link management,
> NVM update via devlink, switchdev port representors, data and exception path,
> flow rule programming, etc.

Hi Larysa,

I am having a bit of trouble figuring out where to cleanly apply this
series to. Could you help me out?

