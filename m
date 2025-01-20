Return-Path: <netdev+bounces-159877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E1FA174B8
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 23:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD233A2DBB
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 22:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEC61E0B91;
	Mon, 20 Jan 2025 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KElycg+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6623A9
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412716; cv=none; b=o19R7wMIYeqoJzoee+7md8WJg84C2vH5dgKATi2XEwKHaLJ+BshnZ+MR6qAtQjrWF69/GXR4rOgaS0XqdjXsQEpxBGcU6+rjf99uJvZFwCQX1neGD9bzJ0BZKWG38wlJDe8cjr7cDuoA/mdP1An6iTfPGO3WGKFME4exDDsW6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412716; c=relaxed/simple;
	bh=hrV8xMKN61E7n7K3/052b5OkmKqOqAd7+5gChAOkpDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bckR7HDXkhlXjMi3mhyxh7sMyOPJb+v/DvOEA2BguViQtBVDmuburA95UlsL/rQiGy5ptriflPz9dIWxuysmioOpeOVTVpHUs+wSO5oe5DZ4JtvOdR2PhB5F7NNCA8j3VmVW9oPhX9wBjWTEv6YtADXESu0J+cgHSVf/d7WOL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KElycg+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412C4C4CEDD;
	Mon, 20 Jan 2025 22:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737412715;
	bh=hrV8xMKN61E7n7K3/052b5OkmKqOqAd7+5gChAOkpDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KElycg+6sugH3QuBSh4b2dvz7bHCMSc4VyuK6P7HgqBl2A9tE9ly/qu7cyH9nTkV8
	 xYNtl2I+gsP/+kDQairLhJP/iHr8d3VCa3PrmsRJfWhidzhHO8hKzF1JNheFu4OB8z
	 luEog0cnb/13AguPqQW/8AayR1IP6wMbDy9ijcUKHbp6wtkb7vZxZDFBQMcptKp/8c
	 cSee98C8loa3T9fOGNEO4XGOcTkpwOWdrGsWWfPs5eZpv0+jkjkFfzN8mAhpaPNgC9
	 RtNCJrKI4/+7f1vCEudBsxzt2VtfZRwvA20GzcZAqCeMZeIrKSRXOiEwDVpBtHoM5U
	 GoOUhc/qLbhYg==
Date: Mon, 20 Jan 2025 14:38:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <horms@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 09/11] ipv6: Move lifetime validation to
 inet6_rtm_newaddr().
Message-ID: <20250120143834.38c9992d@kernel.org>
In-Reply-To: <20250120211348.88128-1-kuniyu@amazon.com>
References: <20250120122945.1bfd7435@kernel.org>
	<20250120211348.88128-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 13:13:48 -0800 Kuniyuki Iwashima wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Mon, 20 Jan 2025 12:29:45 -0800
> > On Wed, 15 Jan 2025 17:06:06 +0900 Kuniyuki Iwashima wrote:  
> > > +	expires = 0;
> > > +	flags = 0;  
> > 
> > Any reason not to add these to the cfg struct?
> > Because these are not strictly attributes for the address?  
> 
> Yes, I thought it's for fib6_config, but I have no strong
> preference.  I can post a follow-up or v3.

No strong preference, either. I'll apply v2.

