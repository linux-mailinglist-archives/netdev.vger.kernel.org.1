Return-Path: <netdev+bounces-227301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81DBAC190
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6BE18922AF
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C524886E;
	Tue, 30 Sep 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGu/QJE6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626D23BF9E
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221724; cv=none; b=rR1t4DR/CfgbH8y/riheWRxNuXRpEQuJEF2xi5OXreNu4hvQd3wdIhq4EiOmUSWlGmxoPuzEltVvAdt09XdYdS+m+rCl/1wJEqBwbTiwo1LkEsBCrtN/k9ToQim+SIDoRW4KnQshIIsMRVjw1P4oJKpiHwRdNF7jQFKtMcd/nWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221724; c=relaxed/simple;
	bh=iUVDtDjP1G9Mecj12ZEM4sqr3FABZSmcPD6No9QUcKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwVRukYwo3iheMB8AlrZw35wYijSlbospK/uQbNX7wwLBETc5JxEyFXu8nYlMX2oL7DHAoyyr6Lo1coiaaT0UvNm8pZo3wOqwWSUi/U+QAFzd9mSt8L1Hz3agwQ3bs8gKLfCPqNQW+aK83dPfNV8+Vz6i8mjShIiqIIHhnVua7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGu/QJE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57764C4CEF0;
	Tue, 30 Sep 2025 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759221724;
	bh=iUVDtDjP1G9Mecj12ZEM4sqr3FABZSmcPD6No9QUcKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGu/QJE653n0utKUNNhvWNDE3DI7usY/TYvdQz6mK8XsCgFIzBTAH5V3zH7pXQAyF
	 nVBeohfo1chA0yp5cJYS9PY7mJhMMsbz4rDom4Wgg4yVH02BSxQfDJ8O+/w0j1oj2a
	 C608SNTkVPsN8NTf6leHKomve+VJf5tG2ZGWAefbTcD19EQXvN8//aG/D42sevah+S
	 H+o6XPm92DkShAtVBZgvyK+hf67x9q1DCkjb3DkZUwCjXCM2Wj316WxVtw4n6YdAV1
	 IjgbfYHIOAJwo/2m4zMsNw4DGpD5eov98xdUD1koc2a0WTRLzV0xWADqyVJ7Z3xRAw
	 Nr5Z+KBfM6d1A==
Date: Tue, 30 Sep 2025 09:42:01 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 iwl-net] ice: fix destination CGU for dual complex E825
Message-ID: <aNuX2T6WisaUoNzy@horms.kernel.org>
References: <20250929152905.2947520-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929152905.2947520-1-grzegorz.nitka@intel.com>

On Mon, Sep 29, 2025 at 05:29:05PM +0200, Grzegorz Nitka wrote:
> On dual complex E825, only complex 0 has functional CGU (Clock
> Generation Unit), powering all the PHYs.
> SBQ (Side Band Queue) destination device 'cgu' in current implementation
> points to CGU on current complex and, in order to access primary CGU
> from the secondary complex, the driver should use 'cgu_peer' as
> a destination device in read/write CGU registers operations.
> 
> Define new 'cgu_peer' (15) as RDA (Remote Device Access) client over
> SB-IOSF interface and use it as device target when accessing CGU from
> secondary complex.
> 
> This problem has been identified when working on recovery clock
> enablement [1]. In existing implementation for E825 devices, only PF0,
> which is clock owner, is involved in CGU configuration, thus the
> problem was not exposed to the user.
> 
> [1] https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20250905150947.871566-1-grzegorz.nitka@intel.com/
> 
> Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1->v2:
> - rebased
> - fixed code style coomments (skipped redundant 'else', improved
>   'Return'
>   description in function doc-string)

Reviewed-by: Simon Horman <horms@kernel.org>


