Return-Path: <netdev+bounces-172479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51945A54EE2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C921896E85
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE751898F8;
	Thu,  6 Mar 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8EStH/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791E158520
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274701; cv=none; b=L4Pk0WzUp8bRJ2lS7faeS41VMTkx2+Be9Aj9/8eucjlsSlFWCc973qPERS4H+Ja53IL+eunBcYSgKRXmXgRhyIcENJnz0dkPZCZDqEDEvPwLu5AW208FthrmKithKgw7j1+fGhmY39pr1YhA6Wbx1dd9gragad4SneX3nps8ulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274701; c=relaxed/simple;
	bh=iihOroEay5wDveNgzHyZU7rMsi0byn97z2Or9139bL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rc0eONgVGzy95ZCw9Ima9qZpCvntsLVJA/6G/VHMvFE2TGSrY3T65cSqnzamKf8/qMS6XyvzCFgP/8VNZpysXbr7h2jnsOJkfAAHWQ+N/2vR8DdJtSeOuhPoTw/JyGqkrAhqtf2tNEN7ocCe0TBREEZBWCW1Q7XvZA0GK5Cq+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8EStH/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ECAC4CEE0;
	Thu,  6 Mar 2025 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741274701;
	bh=iihOroEay5wDveNgzHyZU7rMsi0byn97z2Or9139bL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r8EStH/AJ+iIrzGUx8e0nuUpwE34gOSO+USLviOgbjOdj15PJi94rwFFjPMsaSOAb
	 liRhOaaq69ibngj8w1m3sFweS0uvUsx8L/+ZRs4GnIfBTbHf9ROX/u2I8DUkwHHtHc
	 jM+uVd2QwP8RScErfuIJV6ocOKSZi9yGoyAtBWl+70hqE5DWwjxBH1hAAge/+VoqUg
	 VubqPJkSSLJY2VkiPug9pVrmI1aVqhYPvSInr1bGcO66VW2xzJVSf3GndzKQuhVGWV
	 wZtzD0iTaxKlAwg6ROHx+yKTW30MvndHKpO/yyUp+KVKOIwq0MmrBsjY7ikV4hJj4I
	 cxAcJEtMMr0ZQ==
Date: Thu, 6 Mar 2025 07:24:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next v3 00/10] eth: bnxt: maintain basic pkt/byte
 counters in SW
Message-ID: <20250306072459.658ca8eb@kernel.org>
In-Reply-To: <CAMArcTWwuQ0F5-oVGVt9j-juqyrVibQObpG1Jvqfjc17CxS7Bg@mail.gmail.com>
References: <20250305225215.1567043-1-kuba@kernel.org>
	<CAMArcTWwuQ0F5-oVGVt9j-juqyrVibQObpG1Jvqfjc17CxS7Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 19:54:22 +0900 Taehee Yoo wrote:
> It seems that the driver is supposed to return qstats even if interface
> is down. So, I think bnxt driver needs to store the sw_stats when the
> interface is down.

I think the driver already stores the stats on close and will report
them in "base" values. So all we need in per-queue callbacks is to
return early, when the interface is down?

