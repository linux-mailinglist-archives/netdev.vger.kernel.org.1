Return-Path: <netdev+bounces-44044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E327D5EC7
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B1C1C20BFC
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A94947365;
	Tue, 24 Oct 2023 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2FYix3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA82749D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 23:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B80C433C8;
	Tue, 24 Oct 2023 23:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191058;
	bh=KQZOMcDJXH8auOf3dgK3MRyHDcYtvTGRCaP4oAGFlEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W2FYix3d3M95CGzwYy7dwyF7N9d4t7nowHgKe7VvCWiQF8XwhtZZ2E/naVYTh/7AO
	 E+k342eoXsChdqJnA1K/cOepIybqGmSWoT/sjIJZ69PC26l24kxULhGaFonUDMgGNV
	 kRcfe3uHd5ErptFlzeSwS2ghP9nuJbBqfRRYf6iM/nD92WuXv1qVZ6g650xmfGbftz
	 TDm1WrKNHct5cd3VghdQEeWpu7VfZ4+Khr1RG3acj8po9IvQizV/UvlPVVU46nG2/t
	 JHWyXAY3kPxgU3J+IPGltijaVIjSJnTeur0s5P6IUCgIRa9cY4sl1PFHxN8CuY7cBc
	 V6aTtcN2dXaHQ==
Date: Tue, 24 Oct 2023 16:44:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, Michal
 Schmidt <mschmidt@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next 7/9] iavf: use unregister_netdev
Message-ID: <20231024164417.0f76f2a4@kernel.org>
In-Reply-To: <20231023230826.531858-9-jacob.e.keller@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
	<20231023230826.531858-9-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 16:08:24 -0700 Jacob Keller wrote:
> Use unregister_netdev, which takes rtnl_lock for us. We don't have to
> check the reg_state under rtnl_lock. There's nothing to race with. We
> have just cancelled the finish_config work.

I can't really convince myself that its indeed the case... but either
way if something can register the netdev past the check - the code is
buggy with or without rtnl_lock, so patch seems sane.

