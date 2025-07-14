Return-Path: <netdev+bounces-206707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30FB04253
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C7E3AD411
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998CF257AF9;
	Mon, 14 Jul 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrOilTh7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738AD253F2D
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505094; cv=none; b=a1xMNBKiKzMFW3WwfUooAnpsQoe79Yyl3pLrOjiZQMsptuizMyEZj+iQeD+WwmitYG4kO4OL7zHw82QtWERK2YmqaJsDF+EdN41VeG8fI1jH2jV8O/GdskxxjdNpUXv5sHhzfQTI1VTsLqUhaZ4I/omJgtOmejOrXapYMaXqfjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505094; c=relaxed/simple;
	bh=C5eyEDFv4nwgx18b0gkYabeNyMzfmzsJGMHUO9ziknE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nup03eIhiGfa5pybRv1OT7N4qynV69GrVSv5agRxS+R7uxwtyDWpBVGMad3lokDieEXyv8WHJarzxhYk49laBn6YciKs6oB6pvKu9cMDv75oeXc4d/eMdHMVdaB0HFVF2PL1rbHZa6wM/OOY83jxV2I8lXNd9Fkls446eZ5E3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrOilTh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935FCC4CEED;
	Mon, 14 Jul 2025 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505094;
	bh=C5eyEDFv4nwgx18b0gkYabeNyMzfmzsJGMHUO9ziknE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HrOilTh7MQ3a6Vj2AmxUAktMb1VW6crNILq2KGgq7bROJXZ5cavJWmpLE9NpDcwL4
	 OV21j6Q7ktUXgpwyonFpUnT/Vrj4eCrGyGPi6UQQBBAqIgZUGKJUHBLImQ0oaW8AlX
	 AbOyMdY5gUPyY+NqkMyJRnu57EC//qsSmtq9GAt4BVvcFZJuFb7P/CAgjPAJYaCsI+
	 APPRTFhWUjqZ+8Z9OM8GjuNR40QO00drBCkATzBrtba+0LNod1ZIzwYuMZSJomvqQ6
	 T9YNg3xatAFRkp0i6t+ptvs+78yF1FHzjUHIXWjbZliBJVImhYFT5thGyIp0z8LPKc
	 F7tM4BJRwiJow==
Date: Mon, 14 Jul 2025 07:58:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com,
 stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH net v5 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
Message-ID: <20250714075812.3e9adfed@kernel.org>
In-Reply-To: <Xkn0k1T1WExEErBWNX2KpV5LgS9_QyNobWmlUUjcpihDZ5oJrCtZyvuXfiTnrGiOGQnKVQatnw0suv3voQl_6lMrncCe5NdO3NaQliF16mc=@willsroot.io>
References: <20250708164141.875402-1-will@willsroot.io>
	<20250711155506.48bbb351@kernel.org>
	<Xkn0k1T1WExEErBWNX2KpV5LgS9_QyNobWmlUUjcpihDZ5oJrCtZyvuXfiTnrGiOGQnKVQatnw0suv3voQl_6lMrncCe5NdO3NaQliF16mc=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 16:51:39 +0000 William Liu wrote:
> > We already had one regression scare this week, so given that Cong
> > is not relenting I'll do the unusual thing of parking this fix in
> > net-next. It will reach Linus during the merge window, hopefully
> > the <2 week delay is not a big deal given how long we've taken already.  
> 
> If this is going to net-next, will this still be a candidate for
> backporting like other recent net/sched bug-fixes? Or will this only
> be considered fixed starting 6.17 onwards?

It will be a candidate for backporting once it reaches Linus.
The only difference is timing.

