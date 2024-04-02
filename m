Return-Path: <netdev+bounces-84137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB4B895B7B
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 20:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49340285CBB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C415AAD3;
	Tue,  2 Apr 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9snK8mI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211215AAC4
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081423; cv=none; b=hq2teGVnHw+yLExfmDyrQMn3Ojp7tEsP7El7A9PpLBjlMUJX5OeTBcx6QiA0O/Nv2vScV5WmjrQlXlTUGHmQoismTQd1P2tj+DcmJHLcCH1+8c+ATamzQky5x7JAyJQMyojML8+uy85VLYxvT8wuZW9GEn0A8AV3/nDWXqhjETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081423; c=relaxed/simple;
	bh=PZtnS6DseM/bkpdApTTu4OlsczIe4rPTnKfc+6i6cEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpSGoEdxjhYVKmquG4vQ3b5pg/CS3T11RQabgBm9O4gy8DcW48kma7ExOckkDX7RfIaxqVvMXn06c4Z7ptauWktSHpR0mJgkBiDwjRLHHTQlx2A2kuSMbQIwky+gVPk85954P5WR6c9YNCEVlEZiA75Cr/2/UJ+gW9YbTMbVijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9snK8mI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EEFC433F1;
	Tue,  2 Apr 2024 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712081422;
	bh=PZtnS6DseM/bkpdApTTu4OlsczIe4rPTnKfc+6i6cEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9snK8mIJc3ocAh+tbYz4aSybieGT4M4avj5Q0l23K/+wIER8QSUKLLzN1IWsYFs5
	 6eU8qWDA/wCyTWVD+BWGsit5453BaYL3+kd9wqjbNcxjC5of971eO9Ta4+JlpiO2Mm
	 lMpDCq749jtUjC8b53m7ujz0kv4frdKIFvokw1AdD0qrON01LQ+pi9Er6GTSKMRJHV
	 VXAbZ0vXxPeLHgDZa1WTBCeb052u5FAB4jJj0Kq/X5/p2RBRtnsNGV0g29qT+f2CQ5
	 JX3vaz8YG3361mYD7zcxPrmpjZxchtZMKAkc0u8ag0nrO51GwRiOsc9oW6A4syvDrV
	 4n5b6VNxa+dag==
Date: Tue, 2 Apr 2024 19:08:48 +0100
From: Simon Horman <horms@kernel.org>
To: David Bauer <mail@david-bauer.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, amcohen@nvidia.com, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] vxlan: drop packets from invalid src-address
Message-ID: <20240402180848.GT26556@kernel.org>
References: <20240331211434.61100-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331211434.61100-1-mail@david-bauer.net>

On Sun, Mar 31, 2024 at 11:14:34PM +0200, David Bauer wrote:
> The VXLAN driver currently does not check if the inner layer2
> source-address is valid.
> 
> In case source-address snooping/learning is enabled, a entry in the FDB
> for the invalid address is created with the layer3 address of the tunnel
> endpoint.
> 
> If the frame happens to have a non-unicast address set, all this
> non-unicast traffic is subsequently not flooded to the tunnel network
> but sent to the learnt host in the FDB. To make matters worse, this FDB
> entry does not expire.
> 
> Apply the same filtering for packets as it is done for bridges. This not
> only drops these invalid packets but avoids them from being learnt into
> the FDB.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: David Bauer <mail@david-bauer.net>

Hi David and Ido,

I wonder if this is an appropriate candidate for 'net', with a Fixes tag.
It does seem to address a user-visible problem.

...

