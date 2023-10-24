Return-Path: <netdev+bounces-43963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7210C7D59ED
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4551C20ADA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFB63A26F;
	Tue, 24 Oct 2023 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz5+LNIl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230546FA6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 17:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C74BC433C7;
	Tue, 24 Oct 2023 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698169751;
	bh=HZFfZ4p5R5ufKIODptS4GZrknXlxe48G7GXWWJWt8uU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cz5+LNIlQsYorQ4WiyOtT7+FVBaFieqyc/EeQ3o7pn/nITIf9dxh8CdcETcx8UKM1
	 J0kbzPuUZA6vEaU/ojoya9vEjmO/yZ2CM/6olbIuiyj+U/sInUReFgnrtYub5L7Dy/
	 BcupzZv2JaXRzICZ5p58i4FVFpQ9HGc7ce5Jf4+nZTHvS7AfH73Ci9IeZKvsyaPSdn
	 9ZUo0aUzRRz10F8H21n5IkxpwWbaaWl5NqvgJAGF1NhAc+rdx0yTcbSJ/AGL9NBul3
	 MGmLxfm85IDenXj4M1eFGovyti3TJBRrTUSIDKybahcoxFVudnE6K575zaf/nfmv9k
	 8UDnI4w1BiwmQ==
Date: Tue, 24 Oct 2023 10:49:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 05/15] net: page_pool: record pools per netdev
Message-ID: <20231024104910.71ced925@kernel.org>
In-Reply-To: <cb0d160b-42bf-40c9-ac36-246010d04975@kernel.org>
References: <20231024160220.3973311-1-kuba@kernel.org>
	<20231024160220.3973311-6-kuba@kernel.org>
	<cb0d160b-42bf-40c9-ac36-246010d04975@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 11:31:46 -0600 David Ahern wrote:
> On 10/24/23 10:02 AM, Jakub Kicinski wrote:
> > Link the page pools with netdevs. This needs to be netns compatible
> > so we have two options. Either we record the pools per netns and
> > have to worry about moving them as the netdev gets moved.
> > Or we record them directly on the netdev so they move with the netdev
> > without any extra work.
> > 
> > Implement the latter option. Since pools may outlast netdev we need
> > a place to store orphans. In time honored tradition use loopback
> > for this purpose.
> 
> blackhole_netdev might be a better choice than loopback

With loopback we still keep it per netns, and still accessible 
via netlink.

