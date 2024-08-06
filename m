Return-Path: <netdev+bounces-116122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46EC9492B3
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4141F22038
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7F18D635;
	Tue,  6 Aug 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coF4VlFn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C718D631
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953492; cv=none; b=TR/mooqxrPbweTxENl8VJ33RYyBORJz0sYCsCu2+8B1Dijrx+dSSHTV8to3pl8tWlMqmFgXtVRq7ouPGzjDGadiHyIoO7CdGU2lC+H8UvFde6UMgckAvJWTCHpVA9Fyz2mZQ+cS0sL8dAXznsTb9sARbJ9x/8gmf638Dy1EhmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953492; c=relaxed/simple;
	bh=x+MUouu3lN4W35kzOSr/iPomJLHZuTkyLqRUUWyk3+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nu+Ei+bFjyD7zHQ/7MAHMBJZ5YJ1Va+9j8Y2afW6yTjWaUxNPOGH08CkDq7/o74Tg6RL+NmhG2wzWTq1AiwFbvA62PTFtDbld7lqy7wJOvhc3n1QzHFp8znpcHB47g9lOb8B+ka/Zgb+Dv2I/G5ON9PlzSVBh+t5or8Od1YoK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coF4VlFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE11C32786;
	Tue,  6 Aug 2024 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722953492;
	bh=x+MUouu3lN4W35kzOSr/iPomJLHZuTkyLqRUUWyk3+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=coF4VlFn6GloVa+blD09EGYLcwRDsTMsImzSy/TzsKJiXdDQCRIOHSfjAIbtS8fye
	 7SEUvxZKm09721M6j3bc/kEp9l/QTs+Fu0L/aki3EmH7SttaTyFbyOnBpb3GwXAsnw
	 ltC3B52nzIxhwlNs9ZO6AriIbEzMaKv5PKrDOkqBfsayhpKHGkg/SQ6TEh1aQ6q6Fv
	 g58xmYX2vUstfVm+Tc7f3EvFZNwCxyQ7uyL/e2fPbZDhyDqXMlyZSrVaSQDrgt5Ka0
	 cFh1CXJ4oPWl/erRXtlXp/BafPIZJPu5efJ0u+cK7hiXAg/qPGwAmYYQmuMe3ZHq0+
	 omni6o3uS2v9w==
Date: Tue, 6 Aug 2024 07:11:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk
Subject: Re: [PATCH net-next v2 02/12] eth: mvpp2: implement new RSS context
 API
Message-ID: <20240806071130.5f456ec0@kernel.org>
In-Reply-To: <52cbca9f-503f-25b4-aabf-461d09f41e9f@gmail.com>
References: <20240803042624.970352-1-kuba@kernel.org>
	<20240803042624.970352-3-kuba@kernel.org>
	<1683568d-41b5-ffc8-2b08-ac734fe993a7@gmail.com>
	<20240805142930.45a80248@kernel.org>
	<52cbca9f-503f-25b4-aabf-461d09f41e9f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 14:28:16 +0100 Edward Cree wrote:
> > Coincidentally, the default also appears exclusive:
> > 
> > 	u32 limit = ops->rxfh_max_context_id ?: U32_MAX;
> > 
> > U32_MAX can't be used, it has special meaning:
> > 
> > #define ETH_RXFH_CONTEXT_ALLOC		0xffffffff  
> 
> Given that both the default and drivers look more reasonable
>  with an exclusive than an inclusive limit (I assume most
>  drivers with a limit will have an N, like mvpp2 does, rather
>  than a MAX), I guess we should change the code to match the
>  doc rather than the other way around.

Somewhat unclear, because context 0 may not count, so to speak.
At least for bnxt using inclusive max context worked well.
But no preference, with the (obvious?) caveat that if we change 
the definition of the field to be exclusive we should rename it.

