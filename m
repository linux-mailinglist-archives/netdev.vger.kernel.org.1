Return-Path: <netdev+bounces-187579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3211AA7E06
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032047A868E
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 02:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8C4D529;
	Sat,  3 May 2025 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUgwD3Il"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9D17F7
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746238550; cv=none; b=i6vr5bZ+glilKJk/S0bPbe44yCtbmai/gTis0yvcICQS9cOOpn0iLPSgxOrG762N/349pvvzlcsGpDItSnstYwwAMTMsl2GozKDbRXblDjxFy0TsOspM4NVyX8SUijM4TUl1xNmZQ0NqicgEO/lCZm3eoPtBZO1D+XYkY8h+FCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746238550; c=relaxed/simple;
	bh=1tKnZbL8Hboz3gXw6460I3eBAVmQmhe0jp+0mrWQEr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XC5osGwx4btCgdWccItokEKzjZP8ghSuDKBFIqMmHN7RU2a08Hjzhzg6E0WYPLnInverdlJ87Voc261oEepfBCh6ZGNY7nY+djezmWSfCdhzNdi+YFLUcxWE3J7KNhEmpG5Ou22guMTStj8lKgxOCMA+VUYiCN8s4DEVIIS//eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUgwD3Il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A897CC4CEE4;
	Sat,  3 May 2025 02:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746238550;
	bh=1tKnZbL8Hboz3gXw6460I3eBAVmQmhe0jp+0mrWQEr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUgwD3IlHGGQrI9PKa9NEku1V7+aCeyrdEkIk4PDkBK4969GSrGNFGoBJusQJZA1g
	 3S6Y2RzVEQ4Y1MrQZK/6ZgaRrP0ZT4H6EFjxgGuV1FInzUJs9bmjTMUqUSnJ6L5SmH
	 3P6NVzK62hMndRLosyhkDrO1ZP3fOrFAxebQco1AmQulHo9YjuXnf/99g40VTPmsI3
	 kD67DYHMlfw09+mke44AXDTqpF04QRuf6S7maDefvz/QCgCGrUiTyxbcenGNtl/u2f
	 fr+d0G5NA0dz83ntf/sS2rx10zliDUeq28j1LVCY3AyhyWbtRwij2TMwSjMPfkIny+
	 WgwcwPFzqmruw==
Date: Fri, 2 May 2025 19:15:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6] Add support to set napi threaded for
 individual napi
Message-ID: <20250502191548.559cc416@kernel.org>
In-Reply-To: <aBJntw1WwxxFJ9e2@LQ3V64L9R2>
References: <20250429222656.936279-1-skhawaja@google.com>
	<aBFnU2Gs0nRZbaKw@LQ3V64L9R2>
	<CAAywjhQZDd2rJiF35iyYqMd86zzgDbLVinfEcva0b1=6tne3Pg@mail.gmail.com>
	<aBJVi0LmwqAtQxv_@LQ3V64L9R2>
	<CAAywjhQVdYuc3NuLYNMgf90Ng_zjhFyTQRWLnPR7Mk-2MWQ2JA@mail.gmail.com>
	<aBJntw1WwxxFJ9e2@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 11:11:03 -0700 Joe Damato wrote:
>   > We should check the discussions we had when threaded NAPI was added.
>   > I feel nothing was exposed in terms of observability so leaving the
>   > thread running didn't seem all that bad back then. Stopping the NAPI
>   > polling safely is not entirely trivial, we'd need to somehow grab
>   > the SCHED bit like busy polling does, and then re-schedule.
>   > Or have the thread figure out that it's done and exit.  
>   
>   Actually, we ended up adding the explicit ownership bits so it may not
>   be all that hard any more.. Worth trying.
> 
> So based on all of the messages in the v5 and in the past, it seems pretty
> clear to me that this needs to be fixed.

Joe is right, sorry for not replying earlier.
Let's try to stop / start the thread on SET immediately.

IIRC there was also a suggestion to defer start / stop to
napi_enable() if NAPI is not enabled -- that's not needed.

