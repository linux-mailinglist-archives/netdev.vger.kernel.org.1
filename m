Return-Path: <netdev+bounces-24258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED7976F841
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 05:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B632A1C21710
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 03:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A071118;
	Fri,  4 Aug 2023 03:12:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8FE1101
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 03:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049F2C433C7;
	Fri,  4 Aug 2023 03:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691118733;
	bh=JRNDrr8Q5XicQAEnr/UMUDvJf9uks/FyRXeJTq4Lonc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0WGwn2s0vAe/DsI3XGK11OMvfOJmtznPvIDw84m40aHVTpIpcqb2BBYLuzfuLVXk
	 dZ9acA9IAQwtQzTU28t9fuHvoxracxbRDCqOkzLX1LeJe0NAsASu8TMADmINbZgGdd
	 BX1P/gy9WCmjlM0BVG0hX4jELQWFjCNAAo0NB2evy4APrirEumPedKRUVDBkxVBYCa
	 fUd1SRVIjlviVLoEWElgozH8jaA3DN65SmuYGQbu3LeHFnLKFAiUC4/TJ29BR+GhsW
	 RhGkM/EcwsZYTxHL13maI270zR85GYjtNQTRlmot3tdxlHuqRiD6Jvh+6E17duy9Fk
	 pAi6/OWVkJa3g==
Date: Thu, 3 Aug 2023 20:12:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Jeff
 Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, Chuck
 Lever III <chuck.lever@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Boris Pismenny
 <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Gal
 Pressman <gal@nvidia.com>, ranro@nvidia.com, samiram@nvidia.com,
 drort@nvidia.com, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
Message-ID: <20230803201212.1d5dd0f9@kernel.org>
In-Reply-To: <852cef0c-2c1a-fdcd-4ee9-4a0bca3f54c5@gmail.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
	<4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
	<20230522121125.2595254-1-dhowells@redhat.com>
	<20230522121125.2595254-9-dhowells@redhat.com>
	<2267272.1686150217@warthog.procyon.org.uk>
	<5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
	<776549.1687167344@warthog.procyon.org.uk>
	<7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
	<20230630102143.7deffc30@kernel.org>
	<f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
	<20230705091914.5bee12f8@kernel.org>
	<bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
	<20230725173036.442ba8ba@kernel.org>
	<852cef0c-2c1a-fdcd-4ee9-4a0bca3f54c5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Aug 2023 14:47:35 +0300 Tariq Toukan wrote:
> When applying this patch, repro disappears! :)
> Apparently it is related to the warning.
> Please go on and submit it.

I have no idea how. I found a different bug, staring at this code
for another hour. But I still don't get how we can avoid UaF on
a page by having the TCP take a ref on it rather than copy it.

If anything we should have 2 refs on any page in the sg, one because
it's on the sg, and another held by the re-tx handling.

So I'm afraid we're papering over something here :( We need to keep
digging.

