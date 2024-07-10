Return-Path: <netdev+bounces-110539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1D492CF19
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405BFB276C4
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B9118FDD2;
	Wed, 10 Jul 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVCSFrDq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDB18FDD0
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606862; cv=none; b=JxkO6ht5Qx8+KMYh4G0ZnDUKGRu59EW1b7UsFx7TaXmIbkldL+vt0FRFcR+UL+gmK2LIkYpPAx0edozTHrbJ5tLh9OcRFaRCB05+AAZnZDt6TeNWXrHnJlc3T+E0YEKe9jJ8pe3ZFPKn4wbpFbyacu4CMTAQ2WrdicMWhf7A2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606862; c=relaxed/simple;
	bh=WiNvkVpIVCRRM3eZpny0hs14S0obVT62r3YQoIJJIqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hctjQzL3uNZg/dSx5UI3PiappJe+ssf4wOpiOffSUABOWbjRX4AWZTCMPw1Uc4R3if0jeIhCPdpBMojeo+ZoSfNyyW0Z1H2AAf1Rl9UtozzXi7OMUgcpDItbijxrhFaHqiL+crjfj9T+R7eCOlktQ4AtI3J43n63Epm1pHahcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVCSFrDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05815C32781;
	Wed, 10 Jul 2024 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720606862;
	bh=WiNvkVpIVCRRM3eZpny0hs14S0obVT62r3YQoIJJIqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVCSFrDqh/qJ+umBn6cB9JxHYphWCeMIg7zoJCIJuvfWLEqktgqzYWe5C82w7Acur
	 NwY6D1Xzba4a/SnmGKZa3lUSJ/uSD1xAqZMxcpaQdl9ZSX775xxsM+buKzFOQxKSZn
	 4Jzg/FW4RwSatcfhfz+m7ajybgklNSvyb4p3rW98j5ankDhzyA+2u2OBUq5D/NSdz3
	 jXqMhMe0jOujW0q9VZhknH3xaNV0/0mVC1V8DnN29c/dLzCpwe/FaeB86xXewklj/Z
	 g0o8lYkaIoh9a9sIdDQbdjSgKzSTGzVNPv+YSRmHN9lSlxaKAPTj6u/VYdEpUT0gZn
	 Oq6pS/oONYR0A==
Date: Wed, 10 Jul 2024 11:20:57 +0100
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Vitaly Lifshits <vitaly.lifshits@intel.com>, sasha.neftin@intel.com,
	hui.wang@canonical.com, pmenzel@molgen.mpg.de,
	Todd Brandt <todd.e.brandt@intel.com>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: Re: [PATCH net] e1000e: fix force smbus during suspend flow
Message-ID: <20240710102057.GS346094@kernel.org>
References: <20240709203123.2103296-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709203123.2103296-1-anthony.l.nguyen@intel.com>

On Tue, Jul 09, 2024 at 01:31:22PM -0700, Tony Nguyen wrote:
> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> 
> Commit 861e8086029e ("e1000e: move force SMBUS from enable ulp function
> to avoid PHY loss issue") resolved a PHY access loss during suspend on
> Meteor Lake consumer platforms, but it affected corporate systems
> incorrectly.
> 
> A better fix, working for both consumer and corporate systems, was
> proposed in commit bfd546a552e1 ("e1000e: move force SMBUS near the end
> of enable_ulp function"). However, it introduced a regression on older
> devices, such as [8086:15B8], [8086:15F9], [8086:15BE].
> 
> This patch aims to fix the secondary regression, by limiting the scope of
> the changes to Meteor Lake platforms only.
> 
> Fixes: bfd546a552e1 ("e1000e: move force SMBUS near the end of enable_ulp function")
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218940
> Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218936
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


