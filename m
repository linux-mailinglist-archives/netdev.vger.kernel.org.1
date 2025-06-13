Return-Path: <netdev+bounces-197296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF8AD806A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A081E2CD5
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8C1D8E07;
	Fri, 13 Jun 2025 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsJ5CgWD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E22F4317
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778922; cv=none; b=igD7LCwUrVvHzwckM/ufB2crRSvdVx9ikxok6UKn/cDoZxha7z4/Vm9HxfmwdAMPudzeD6HyR3ALuAid/98Ww0JfqQ737OejCWuzz7TUCL7kAAaNWuCpILPfMye+iiLKX0zB3px6lLqP2D/omJVNyOdZMI6wlQmK79cpywJwxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778922; c=relaxed/simple;
	bh=mHiuV829d769C7JULdVDQ4FmBQu/bzFO9qLh4xyNQzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArMRGcv+rCBnQy0Y/qIR4iZQoNfOFYR9CcowLEEOrj5Rz3UJksmGiknNgC99neTfBB7cyEFwbWiIg4ZYxgeAa6pvMQKbrZIPNufI0NzpES6QsT7whIgvT0r3fYQBgHay6qPDgFVYNy5QKhTPxoW5RobDr39VLwZCaFV68vhE7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsJ5CgWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB183C4CEEA;
	Fri, 13 Jun 2025 01:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749778922;
	bh=mHiuV829d769C7JULdVDQ4FmBQu/bzFO9qLh4xyNQzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZsJ5CgWDxTEbjrT3amWfWWI7/2LAymzCVCL3AsfEc4pITu8DSsoYBlJN/ybCFzPRD
	 7JIW55pRnZI9mbfQ0XRpDX42ZFkG8g1Zdxe4jiOz+mOzefz5s9aAaH0xp+wka9ZeFv
	 Eci9pJc8p7CvNWz+vmL+h9EApS4zLwHJNvjlGAY2YSGqvDeJxTDwwo9W2gvovsTSzv
	 6GUtgcGYwYkC+DBivXoWrue0uecihliCe5owcqU7Plf2OMKexrKpWlHh7FQZtzRarn
	 hiGmAe/RDxN/VEy8gcXa2ag6ElFvjt3v+f7ZSFrenyDP9i8C1frfdFK18KU+78a/M/
	 IhLSpua1/gVgA==
Date: Thu, 12 Jun 2025 18:42:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 faizal.abdul.rahim@linux.intel.com, faizal.abdul.rahim@intel.com,
 chwee.lin.choong@intel.com, vladimir.oltean@nxp.com, horms@kernel.org,
 vitaly.lifshits@intel.com, dima.ruinskiy@intel.com
Subject: Re: [PATCH net-next 0/7][pull request] igc: harmonize queue
 priority and add preemptible queue support
Message-ID: <20250612184200.5ac38d1b@kernel.org>
In-Reply-To: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 11:03:02 -0700 Tony Nguyen wrote:
> MAC Merge support for frame preemption was previously added for igc:
> https://lore.kernel.org/netdev/20250418163822.3519810-1-anthony.l.nguyen@intel.com/
> 
> This series builds on that work and adds support for:
> - Harmonizing taprio and mqprio queue priority behavior, based on past
>   discussions and suggestions:
>   https://lore.kernel.org/all/20250214102206.25dqgut5tbak2rkz@skbuf/
> - Enabling preemptible queue support for both taprio and mqprio, with
>   priority harmonization as a prerequisite.

I'd like to hold these in patchwork for a little longer, in case
Vladimir finds the time to take a look. 
So feel free to send another series for net-next while we wait.

