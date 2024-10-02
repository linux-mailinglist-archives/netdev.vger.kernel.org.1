Return-Path: <netdev+bounces-131250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B65798DC52
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B13286470
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182F1D0BB0;
	Wed,  2 Oct 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbVvmbmZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24D1EF1D;
	Wed,  2 Oct 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879633; cv=none; b=dxXRO9rrLnBvbz+i6aS9aCkPxtuRGCVhy0TJVzeB3EWK86JXCNa1eBEzt03ilhjkffECjfU/lcYxMZvIZb6J8XhD7cQOK63o0v5CaeLlWa0yN/yxwvVlrn1Wz0pNZln55QR+AZ3YD2OCel0FneL3fLhHhFtqBle8bt9Lkz5r3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879633; c=relaxed/simple;
	bh=gTTUrv/1+CDfpcfWdsIaelYffKdrd3vQbsy+GV/kQvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLj8VEaZtx3931BFYZqHdQillXQhqALeKHKimKp3Uijl5N62aRN/YoSP3Fj0nHqqoOsOOqpPAAGMhcL2yDwEVs5kV7rvdV10g3PLN6X+LH/HtnkaBNs4h/c/6f/NzYgJxERIQqrdLFO73UOJd769pQENNR4VN2uuhoXC8gu//M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbVvmbmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6774C4CEC2;
	Wed,  2 Oct 2024 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727879633;
	bh=gTTUrv/1+CDfpcfWdsIaelYffKdrd3vQbsy+GV/kQvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QbVvmbmZIW4zwtud7YnH4h1pse5FJsH45evwIqlXK5WJBI7J+p/2h9iS66uJzos0N
	 bvTE4uW1a2WSDxVO4Jpgd2ZInMD0lOJ3PmjAfUu/A2fJm6lYUbRXtThLbHDMPiU2qk
	 SyTS6ixX+TZO6oQAOWRTIyPIVd9K1KisKBbBQA+m5qjisJrMGpq97e2jwZ6KqrruXx
	 0p0pvJ1udJDivsR96pTQh3lsKAXWZHw/RxyblThoJT5ik5RYLm1V6eoYVGMQRt8Zdf
	 Vdfdrc32Bdu/bt/2t6Zyr+nwSVI6V7oncOGXxbev7aWBlO+zYCFjHl/pJqKPSpGKnN
	 i9gHITCFpHW8g==
Date: Wed, 2 Oct 2024 07:33:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
 <jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
 <justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
 <jacob.e.keller@intel.com>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 06/15] net: sparx5: add constants to match data
Message-ID: <20241002073352.43a3afb5@kernel.org>
In-Reply-To: <20241002133132.srux64dniwk4iusz@DEN-DL-M70577>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
	<20241001-b4-sparx5-lan969x-switch-driver-v1-6-8c6896fdce66@microchip.com>
	<20241002054750.043ac565@kernel.org>
	<20241002133132.srux64dniwk4iusz@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 13:31:32 +0000 Daniel Machon wrote:
> By "type the code out" - are you saying that we should not be using a macro
> for accessing the const at all? and rather just:
> 
>     struct sparx5_consts *consts = sparx5->data->consts;
>     consts->some_var

This.

> or pass in the sparx5 pointer to the macro too, which was the concert that
> Jacob raised.

The implicit arguments are part of the ugliness, and should also go
away. But in this case the entire macro should go.

