Return-Path: <netdev+bounces-190963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF6AB9823
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB57179C57
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CFA22D7B4;
	Fri, 16 May 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV9sJX8f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21627202F87
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385682; cv=none; b=XLGbe2ZU3smKrwK2ZrB1NDimXMmp1R8MhIBDttHaHqKimh5i8GQbgsSbKrpFjMjEO2H1shPJKLyLh9UPjFygReSUcBmnUTmJsrxF6ye4ZTipF/AzySXZf4CNytQO6e/8kRxeN7WmXhwBowByJ3cIhUIknprWm8gzr0BXiYhdobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385682; c=relaxed/simple;
	bh=u8TUVqVjYDyhOaOG/FJpKIxvaeKUcVwocQ7ArsZD7vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iONi+1/dJ83MfETBKePp6N+8S6c8ZvegJUMmH8aI4lkk1341G33Bo1GRg0v1+JIQPhU1puE7zEy6JyiwjTABkZIB4zuvKJfgWj9fyF7P3OK9QOqxWWEOWzSWuQKbMHywyR0vNqsaWvG3UqlYCQOahaxKcbHl+MDyMaRnBm9aBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV9sJX8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75666C4CEE4;
	Fri, 16 May 2025 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747385680;
	bh=u8TUVqVjYDyhOaOG/FJpKIxvaeKUcVwocQ7ArsZD7vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eV9sJX8fBavKm2fZjgdXMGtzUCI55F3/klLf/upOQIXT7lfzLO8M3R58mhhTmjM3q
	 dgt1z42T4+6fca/lrkfo9KcHlxltu5OPDYwqwRlPgmcSSTWZpwgAmNivSJShk9kwVR
	 9FqJ7p8dS6X5aRHbAhPdpQLsTqwEmzQetdwdx2zctKLrqPNFZnR+Q9NzO0oREhfVjB
	 0RXEObiG6+hhJIAEzVrqDQxr9ffF3coMKZKAPdEMabmrt1zGeBQcqu5v19AhqiNB64
	 CLQeqVyY2UCja9cL5Mvo7D+5dVkiwsc1bXwff/8KqPRNYCBuFxuHAUv1/cY/Ky1hy2
	 HiRr7POdhsIiA==
Date: Fri, 16 May 2025 09:54:35 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com, dinesh.kumar@intel.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, almasrymina@google.com,
	willemb@google.com, pmenzel@molgen.mpg.de
Subject: Re: [PATCH iwl-next v5 2/3] virtchnl2: add flow steering support
Message-ID: <20250516085435.GD1898636@horms.kernel.org>
References: <20250423192705.1648119-1-ahmed.zaki@intel.com>
 <20250423192705.1648119-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423192705.1648119-3-ahmed.zaki@intel.com>

On Wed, Apr 23, 2025 at 01:27:04PM -0600, Ahmed Zaki wrote:
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> Add opcodes and corresponding message structure to add and delete
> flow steering rules. Flow steering enables configuration
> of rules to take an action or subset of actions based on a match
> criteria. Actions could be redirect to queue, redirect to queue
> group, drop packet or mark.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Co-developed-by: Dinesh Kumar <dinesh.kumar@intel.com>
> Signed-off-by: Dinesh Kumar <dinesh.kumar@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


