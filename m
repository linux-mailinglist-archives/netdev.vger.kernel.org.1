Return-Path: <netdev+bounces-71592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC4B85416F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8A91C235A4
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5A4C79;
	Wed, 14 Feb 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ+4fnQv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC838F40
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707877228; cv=none; b=mexsZdPawclvuYrVc5iObNZq8Hohww876lyxX9XqVMgYFSuXT3KcItWXeSPLrpT2WlzIufe77ckySAGWpbgR8FnE6oFCSRvOTnnGFuKU4+wQ1eQSO5vhc4szr0Lsmr4y+osxP5mh5IfF2dhlbfNy/Jws+8q/YcDEalaARF8P2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707877228; c=relaxed/simple;
	bh=IM2w7Nsuxp3F9mzK9O6I93M+uzTRaISlf21iTzuUAWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLHpPhTq86nhkd2Mc7APApvyueWTAVCx2uieUrLHNH4sxN7qF2n6zX+Rj5+Qcl6sLSPUcKBU430E2oOx+N04EsiPnR0kOQD+T81GPNS3RT6eG/v6mx9zS8iCQEOcv0ONWwFZxxb1wU3RQqySjWYw5V9gNL9Z4tp4fi/DUG0hpIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ+4fnQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8F4C433C7;
	Wed, 14 Feb 2024 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707877228;
	bh=IM2w7Nsuxp3F9mzK9O6I93M+uzTRaISlf21iTzuUAWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UQ+4fnQvPPF5reDJ69iCOPONH/aqjJDNnWcDDFXZ/sd893G9FNx++Xi+X9Izhfpiq
	 G9rCLJjcf+pFmzRb838NEfosif83iRigXT3Sj5+Ltt4AoZjXxLEFKBbkPnLiNjUIW4
	 18cV5XJ8p1cTGVDoByZQKUihOoa6zOsgv02iuYfBH1s6SEN1/5/Kex+bGmPJg+wBkf
	 30GdLpi9TQohg9oc5BkiTnr1ZNmpRGeYoMZ+TCPWDghE16EMV1zV7NJPW3hRYcWXIF
	 3tCHLUiDvaLamuBv5n1nZySTzTP9LURSGcGijxybi7ER1VdZnhDbKGZZzabR4l8SAE
	 KXVTgmcM0HZmw==
Date: Tue, 13 Feb 2024 18:20:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>, Kurt
 Kanzenbach <kurt@linutronix.de>, <sasha.neftin@intel.com>, Naama Meir
 <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net-next] igc: Add support for LEDs on i225/i226
Message-ID: <20240213182026.7c14d7d4@kernel.org>
In-Reply-To: <11004b9c-97df-fb6f-efb8-9550ea2b6c03@intel.com>
References: <20240213184138.1483968-1-anthony.l.nguyen@intel.com>
	<7a6ae4c1-2436-4909-bb20-32b91210803c@lunn.ch>
	<24b89ed0-2c2c-2aff-fa59-8ee8f9f22e9a@intel.com>
	<c4f66726-1726-4dd5-98a8-4f8562421168@lunn.ch>
	<11004b9c-97df-fb6f-efb8-9550ea2b6c03@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 13:05:43 -0800 Tony Nguyen wrote:
> > State: Awaiting Upstream  
> 
> For Awaiting Upstream:
> 
> "
> patch should be reviewed and handled by appropriate sub-maintainer, who 
> will send it on to the networking trees; patches set to Awaiting 
> upstream in netdev's patchwork will usually remain in this state, 
> whether the sub-maintainer requested changes, accepted or rejected the patch
> "
> https://docs.kernel.org/process/maintainer-netdev.html#patch-status

FWIW I think it's one of those things where particular cases may look
odd, but for those on the patch handling path always following the same
procedure make the life *so* much easier :(

