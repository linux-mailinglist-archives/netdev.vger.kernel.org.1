Return-Path: <netdev+bounces-16158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3981C74B984
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230291C2107A
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21D317FE3;
	Fri,  7 Jul 2023 22:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4C17ABD
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBCCC433C7;
	Fri,  7 Jul 2023 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688768914;
	bh=MduY+tIX+QMFF8HieEVAgRXxkIT6ZWa7h0RPBNfHhso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hsbSty28tuWmACNvrydN+PN8/q4RBnBQSw+jTNr15MnWiZZq4cLafvKG5IFBNwXfk
	 KdcnVt9sXypbz4MUOj0wPxZi8foP4sNkfI8PI/ayHOQnsCGxjAvj64Ukc4KnI0JbXA
	 2SOTPDfjLrldBPO+jPtpssoIPacHAxAUXwSIp7CeqB4A4AbADmOxwKkJraZikwu1aJ
	 xSOXIQ6dVjSKj4Se12lMUe0MLAhnYT9HuHxcxtXZGI/Qle2CWql2XJ3WNMuXbaj2m2
	 P/Ujl/+WPH0BMTo3P8oqtglKgL+YzyA6wN4vy7P7b2ZGXmjk/7vXHl8jzOFg2bhWRP
	 1lTcj0WQ1o+sw==
Date: Fri, 7 Jul 2023 15:28:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 edumazet@google.com, dsahern@gmail.com, michael.chan@broadcom.com,
 willemb@google.com
Subject: Re: [RFC 06/12] net: page_pool: create hooks for custom page
 providers
Message-ID: <20230707152833.670edcde@kernel.org>
In-Reply-To: <CAHS8izM+o3m_h1SU8D-1XmDVsfqTwWmpcPpsp2Xh-0vVdOo=ew@mail.gmail.com>
References: <20230707183935.997267-1-kuba@kernel.org>
	<20230707183935.997267-7-kuba@kernel.org>
	<CAHS8izM+o3m_h1SU8D-1XmDVsfqTwWmpcPpsp2Xh-0vVdOo=ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jul 2023 12:50:51 -0700 Mina Almasry wrote:
> > -       put_page(page);
> > +       if (put)
> > +               put_page(page);  
> 
> +1 to giving memory providers the option to replace put_page() with a
> custom release function. In your original proposal, the put_page() was
> intact, and I thought it was some requirement from you that pages must
> be freed with put_page(). I made my code with/around that, but I think
> it's nice to give future memory providers the option to replace this.

I was kinda trying to pretend there is a reason, so that I could
justify the second callback - hoping it could be useful for the
device / user memory cases. But the way I was using it was racy
so I dropped it for now.

