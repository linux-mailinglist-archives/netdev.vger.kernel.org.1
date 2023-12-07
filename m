Return-Path: <netdev+bounces-54946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C5808FBE
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D211F21169
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB434D5B9;
	Thu,  7 Dec 2023 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u42xpMXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07784D5B7
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033F0C433C7;
	Thu,  7 Dec 2023 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701973240;
	bh=d3Zr38gstGP4uv2JGstuGzxaMjMkMy8eYKYdjcVf4co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u42xpMXQjRF+yCkfkVzJR9hzEI49jYfe3RIri9S6sXuJ2mdNGzL9HY0l1q/Qw3aHc
	 hpnDoOUzChOngV6vxYEZyfC0RCBc+/Fgido+EXh1yELOk3Kj0pKl2saC6W6JNFlcuf
	 oNXeE5cs9LZ8a8USIU7KCQZuVeu/xu78b6QrlIETcMxmWLnXT3BwaEpB1Kp7YtEWof
	 i0GpztIlzyZs76MPN4B44HlEmeRy8TgdfR1WuvtH3Vf81Vhg3V/uUSlIZqq0T9CNBi
	 /QB8XSsIve4evSFeRwJJOYTWWyiZRj1dDE4wOzu1xQbpQV9uwNIR2dwtUIvGktezSC
	 zv/nnX4lIFv1Q==
Date: Thu, 7 Dec 2023 10:20:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, Somnath Kotur
 <somnath.kotur@broadcom.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net v2 1/4] bnxt_en: Clear resource reservation during
 resume
Message-ID: <20231207102038.5e4cde28@kernel.org>
In-Reply-To: <20231207000551.138584-2-michael.chan@broadcom.com>
References: <20231207000551.138584-1-michael.chan@broadcom.com>
	<20231207000551.138584-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 16:05:48 -0800 Michael Chan wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> We are issuing HWRM_FUNC_RESET cmd to reset the device including
> all reserved resources, but not clearing the reservations
> within the driver struct. As a result, when the driver re-initializes
> as part of resume, it believes that there is no need to do any
> resource reservation and goes ahead and tries to allocate rings
> which will eventually fail beyond a certain number pre-reserved by
> the firmware.
> 
> Fixes: b4c66425771d ("bnxt_en: refactor bnxt_cancel_reservations()")

Are you sure this is the right tag? That commit looks like a noop
refactoring. Keep in mind Fixes should point to whether the bug was
first present, not where the patch applies.

