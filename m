Return-Path: <netdev+bounces-212702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E7B21A24
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305EC1A21220
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572FC2D8767;
	Tue, 12 Aug 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTNYl7kb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE92D837F
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961969; cv=none; b=q7+AFxs5vxyVyaQur97N8c5cUutMYvemKI2tXuzHTSj/Zyx9lETbBVcSil90D7Ye2YWEr/QWg4Q0SIuGmd2810Ivnreq7Ht4qj7WTDzDJ9wo9CZYXLVyFthG6NDFn8om8jY565UwOCm+UxBaHeKAGnBdHW6NgJIxq5bi/Aj9O/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961969; c=relaxed/simple;
	bh=1oMyt7/aSCQ4OhYgsq1+x1H8voHRosqtt0jExsaDc9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBQDS8JljD5P1rOwgzslcu7yHhK4Fr0vUyENLa2Aj7SCHZCuAK+Wx7LYny21v5X+8/5BE95h4R/FEJov3Bvj3sPWv7ilNm9pz6GOMv9Ev1Eza9Bs7I3rwSvwpj4niHzWLnj77SOn4JHh2EZoZ/llVOUWOgi9biyclFO2xJ0ao0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTNYl7kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575D3C4CEF5;
	Tue, 12 Aug 2025 01:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754961968;
	bh=1oMyt7/aSCQ4OhYgsq1+x1H8voHRosqtt0jExsaDc9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RTNYl7kbrsxa1rJv0nI/epG+hwAgnKN7e6c2Iz8sSyudqPX06iS+IEh8Q7NxLyOyQ
	 eHIZYuCY4ey4srbKFlq7eu4JVLauk+4/BRVtREpgpayOJY0R/lSuNWd53H65jHN3sV
	 zzaaJj8G1Uq4Zsuyswzh3xWeyK0qQXskJGwIMy18/atQdIaKa6e6D3xRexoLUe76CD
	 PDg/oru4/1azudZo7woU8lYgPQbtd4mtACR5MWTHxc9zE30I8R9nVwMvlwR4v7eoj4
	 5vwVnw7ruzNTKw6zK2ZtL9bvNU0R2+w/EE9oG4ZTFM3JRI/Nxu2NYqFU1mjg9ziJKy
	 b+pN3g4ncO7Xg==
Date: Mon, 11 Aug 2025 18:26:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: Davide Caratti <dcaratti@redhat.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Lion Ackermann <nnamrec@gmail.com>, Petr Machata
 <petrm@mellanox.com>, netdev@vger.kernel.org, Ivan Vecera
 <ivecera@redhat.com>, Li Shuang <shuali@redhat.com>
Subject: Re: [PATCH net] net/sched: ets: use old 'nbands' while purging
 unused classes
Message-ID: <20250811182607.222a6f98@kernel.org>
In-Reply-To: <2ac9d393-a87b-4b55-87d6-0b76542e63c9@mojatatu.com>
References: <f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com>
	<8d76538b-678f-4a98-9308-d7209b5ebee9@mojatatu.com>
	<aJmge28EVB0jKOLF@dcaratti.users.ipa.redhat.com>
	<81bd4809-b268-42a2-af34-03087f7ff329@mojatatu.com>
	<c3ffa213-ba09-47ce-9b9b-5d8a4bac9d71@mojatatu.com>
	<aJoV1RPmh4UdNe3w@dcaratti.users.ipa.redhat.com>
	<2ac9d393-a87b-4b55-87d6-0b76542e63c9@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 14:35:50 -0300 Victor Nogueira wrote:
> > @Victor + @Jakub, can we apply this patch to 'net', so that regression is fixed ASAP, and then I post
> > the kselftest in a separate submission for net-next?  
> 
>  From my side, that's ok.

Fine in principle, but is the urgency really that high?
Feels like crashes in qdiscs with net-admin are dime a dozen,
we can wait a day or two for a test and merge them together..

