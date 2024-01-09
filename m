Return-Path: <netdev+bounces-62552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07080827D3C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 04:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA4DB21437
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 03:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3E6D6CE;
	Tue,  9 Jan 2024 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHmUXMWg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2FF4688
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 03:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BA6C43399;
	Tue,  9 Jan 2024 03:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704769692;
	bh=yw5QREq+A+Nr9092ABpoRq94SdCjuOT5qA8Jd44VWUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PHmUXMWgrwWFuKaH4NAdBzQoTj3jyfbH3efVBfJPyUhMaUWZIN0cQDjV6DfYIfCkQ
	 ACe0ogSj4yUNg7SSFuxzGN6aOSBtBgqtxJLoSRFZ2Nk4XQUH/3e2uzwxdyIEnQh1gb
	 ALqumT7bPlDiab88Uk9dZElXmpNrheLPOk4YN9Wlb9QCMs7jjaL/WLHQboiPiB397b
	 JZbqoAJkDVQo+UDam7uWLzhiOyPovsfNRILvio98o5f2YvP3j4kMKFSz0QhR2vN1am
	 wWDzq7I3KQq7rhYw+JJpw91q70BtcyJKXC9UKmw6rF++cd1Rza3uNScjdXnwOwUkYp
	 anM2uNdRAE0UQ==
Date: Mon, 8 Jan 2024 19:08:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [net-next 10/15] net/mlx5e: Let channels be SD-aware
Message-ID: <20240108190811.3ad5d259@kernel.org>
In-Reply-To: <effce034-6bc5-4e98-9b21-c80e8d56f705@nvidia.com>
References: <20231221005721.186607-1-saeed@kernel.org>
	<20231221005721.186607-11-saeed@kernel.org>
	<20240104145041.67475695@kernel.org>
	<effce034-6bc5-4e98-9b21-c80e8d56f705@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 14:30:54 +0200 Gal Pressman wrote:
> On 05/01/2024 0:50, Jakub Kicinski wrote:
> > On Wed, 20 Dec 2023 16:57:16 -0800 Saeed Mahameed wrote:  
> >> Example for 2 mdevs and 6 channels:
> >> +-------+---------+
> >> | ch ix | mdev ix |
> >> +-------+---------+
> >> |   0   |    0    |
> >> |   1   |    1    |
> >> |   2   |    0    |
> >> |   3   |    1    |
> >> |   4   |    0    |
> >> |   5   |    1    |
> >> +-------+---------+  
> > 
> > Meaning Rx queue 0 goes to PF 0, Rx queue 1 goes to PF 1, etc.?  
> 
> Correct.
> 
> > Is the user then expected to magic pixie dust the XPS or some such
> > to get to the right queue?  
> 
> I'm confused, how are RX queues related to XPS?

Separate sentence, perhaps I should be more verbose..

> XPS shouldn't be affected, we just make sure that whatever queue XPS
> chose will go out through the "right" PF.

But you said "correct" to queue 0 going to PF 0 and queue 1 to PF 1.
The queue IDs in my question refer to the queue mapping form the stacks
perspective. If user wants to send everything to queue 0 will it use
both PFs?

> So for example, XPS will choose a queue according to the CPU, and the
> driver will make sure that packets transmitted from this SQ are going
> out through the PF closer to that NUMA.

Sounds like queue 0 is duplicated in both PFs, then?

> > How is this going to get represented in the recently merged Netlink
> > queue API?  
> 
> Can you share a link please?

commit a90d56049acc45802f67cd7d4c058ac45b1bc26f
 
> All the logic is internal to the driver, so I expect it to be fine, but
> I'd like to double check.

Herm, "internal to the driver" is a bit of a landmine. It will be fine
for iperf testing but real users will want to configure the NIC.

