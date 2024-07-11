Return-Path: <netdev+bounces-110963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E832E92F223
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2006283CED
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCD71A01A7;
	Thu, 11 Jul 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqHbgFo6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F41586C4;
	Thu, 11 Jul 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737583; cv=none; b=DlYN60mKVkjqfrEEeE3e1+yTFNt6uki8kee7stXj5EIHeF3na2f19aSAMj7H+EiNqugaArDHZXZxJ1Wci4MdMyKqKw4gvcqBwyxbJl5o1uzoFNoLgC/DDp4ritM2DktcHJaF/1JIXMlhbxPxKUsclPy9YN4TzuCV3aBwTmj/O1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737583; c=relaxed/simple;
	bh=9MA98ezOcJ8m0SPoCcJhX7TcuGhLFmrZ88pnNoswD4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEmR1UmQt0lwTHLfhXgfMaNfU4J4kjFcIyJygGbsDkdtzWKIy4KSZMtF5Fh4JhgPyuxYCCLmZBQQ2fnMstvzAPtSHelmJKDz5VEOfRIEKJ5KBbfjSs2i8rlweKWdiqks72mmzYQw6/kZWlvItb601LBPgO3LAA+5sF8hwdi4I04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqHbgFo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1F9C116B1;
	Thu, 11 Jul 2024 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720737583;
	bh=9MA98ezOcJ8m0SPoCcJhX7TcuGhLFmrZ88pnNoswD4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QqHbgFo6FBjYd3vf0XsaB1S7IXL5FRHdtuMq6qxbVMCIYTFflJgZWBIUma8V0kLwE
	 WScb1iSOXtA7BQbw27GFkbrnfa0ZygU9MXeM9JJ/pFcyAOHJb1kACf/cRPhZU4PctE
	 dZRH85OnDDBnGGqrD936b2HMDd/8BcghZIAIabdJxKeRlO9FtxBmFaMu/a2yWKCXd2
	 vjOnO5HLGSwg0Md6F8JNlrmumcxPGD8a9WtlvvPZpDM2a4zXYeO0IAoytwek23dXIM
	 bwcy2t2fLFSd/nNQ2VgGmQZdXgkxOqwAr9Oq6u3n13xtQg+rl4qaCTPZifEkwNC95l
	 8AvwcsJ7FDg/w==
Date: Thu, 11 Jul 2024 15:39:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 idosch@nvidia.com, amcohen@nvidia.com, petrm@nvidia.com, gnault@redhat.com,
 jbenc@redhat.com, b.galvani@gmail.com, martin.lau@kernel.org,
 daniel@iogearbox.net, aahila@google.com, liuhangbin@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: add local address bind support to
 vxlan and geneve
Message-ID: <20240711153941.752b597c@kernel.org>
In-Reply-To: <20240711131411.10439-1-richardbgobert@gmail.com>
References: <20240711131411.10439-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 15:14:09 +0200 Richard Gobert wrote:
> This series adds local address bind support to both vxlan
> and geneve sockets.

I think that this breaks a lot of vxlan related subtests:
https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2024-07-11--15-00&pw-n=0&pass=0

