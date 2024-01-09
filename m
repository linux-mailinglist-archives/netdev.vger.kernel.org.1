Return-Path: <netdev+bounces-62551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C4827D1F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 03:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756391F21D56
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 02:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F05139D;
	Tue,  9 Jan 2024 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAw2IepC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B622063
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 02:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7462C433F1;
	Tue,  9 Jan 2024 02:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704769088;
	bh=HDuOVydgFyWE9ffMato91sAIqwTUhAczbzijRUSkjuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YAw2IepC5P27ANv5DHjFoAQVFPCqwAoARkZULz3cj8yoeYGvPc52l8VkICkBSk8gn
	 8ke+J8NJDFL8Qj4FG9RmtxkMIw3TTgHM+9OvLtGXyDulwfWvjxkKAH1lNaR+4SeLFf
	 5aoggvACoPZ5cOZbhA4bHFp9QLBNTbId3dNpJOHhFefn3Dfo5Fu/2kG6jzWSHx9WNF
	 U2RliHfFuGpXqwEl2ygR/62AnYUyYG0wjTDQT+oM5LDKVQ2QrrnTMzsJRzWBXAKuDw
	 xxybjsejitGltF5unx7Va5onQlipo+cU2tWX58AvN8Jx06Wyx9QMLShBffTxySQrJK
	 vrciFWZARLvWQ==
Date: Mon, 8 Jan 2024 18:58:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Armen Ratner
 <armeng@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [net-next 15/15] net/mlx5: Implement management PF Ethernet
 profile
Message-ID: <20240108185806.6214cbe8@kernel.org>
In-Reply-To: <ZZyDpJamg9gxDnym@x130>
References: <20231221005721.186607-1-saeed@kernel.org>
	<20231221005721.186607-16-saeed@kernel.org>
	<dc44d1cc-0065-4852-8da6-20a4a719a1f3@amd.com>
	<ZYS7XdqqHi26toTN@x130>
	<20240104144446.1200b436@kernel.org>
	<ZZyDpJamg9gxDnym@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 15:22:12 -0800 Saeed Mahameed wrote:
> This is embedded core switchdev setup, there is no PF representor, only
> uplink and VF/SF representors, the term management PF is only FW
> terminology, since uplink traffic is controlled by the admin, and uplink
> interface represents what goes in/out the wire, the current FW architecture
> demands that BMC/NCSI traffic goes through a separate PF that is not the
> uplink since the uplink rules are managed purely by the eswitch admin.

"Normal way" to talk to the BMC is to send the traffic to the uplink
and let the NC-SI filter "steal" the frames. There's not need for host
PF (which I think is what you're referring to when you say there's
no PF representor).

Can you rephrase / draw a diagram? Perhaps I'm missing something.
When the host is managing the eswitch for mlx5 AFAIU NC-SI frame
stealing works fine.. so I'm missing what's different with the EC.

