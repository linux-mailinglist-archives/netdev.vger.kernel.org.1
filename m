Return-Path: <netdev+bounces-218863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0734BB3EE1D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56B7487D5C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3024221714;
	Mon,  1 Sep 2025 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb9QBB8c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC39E555;
	Mon,  1 Sep 2025 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752729; cv=none; b=RspNIqvOaQH9MwzutOtRTDW9i6sAfU0BrSuzQrw6LampBesVvPPjybVU3TeClfnVbT+D+uKkfZIJjfHzfemTaTMYbTm1rZRkxZ3orGwTIlBBMChTrdsxYKhdxpDQN+nOKYZLYDDJ0ZNzNhQOErmNqT0n/OBKgplsTPgF/o9x4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752729; c=relaxed/simple;
	bh=o6U01W+fl0b/ojC90s2Y/ejJnVHB2bAeWNynsDt5eHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBpqBEosQHM6KRrqJLnvyPorbEsw/osW+ouo7E6txYGt8pDpe6CCNbRND0aidb6eU+kGYWzSim6bXZO3Hn2MtqtGKQBmnIlHoQPuEVdTa5+LT0T93j+N0U25DC6DcFCwENVD7LHjAM7KdTp3uHJBiNh5EzCOwZ9SpziYfvknhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb9QBB8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3736C4CEF0;
	Mon,  1 Sep 2025 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756752729;
	bh=o6U01W+fl0b/ojC90s2Y/ejJnVHB2bAeWNynsDt5eHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kb9QBB8ceUYErFJfBaj9F55TVZOcvFQZ9u3zFE+JJY9/rDwZ4bWPlQkXGEcwglcd3
	 46fJCeeZg0V9Y6Ik7Ai5Gv2iE4yORx1+mArLAGaXq1w+DyeTjPqlwG6e2U1iDZqACz
	 OjOUVCh6bN1FDFGiY49iy8c1D6T/CiizVj/qUED4LSz/ip3rVRrWAiqGgQTmylINWH
	 RAQ4sYtEN+F7Y+qFO+gAD3hIzSs6Q9qPy9NeRms/SlfdGAqu2R11hp7Eb8yLHu8HUh
	 6EBTcWfmu0wzv9N+h8lrj3jHx6ZVAebnvmmmCzHsA9r/z+kxOXBVpY/cEh32MUpBsf
	 nqYLmQAqvKO2A==
Date: Mon, 1 Sep 2025 11:52:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>, David Ahern <dsahern@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/4] tools: ynl-gen: use macro for binary min-len
 check
Message-ID: <20250901115208.0cc7e9a6@kernel.org>
In-Reply-To: <20250901145034.525518-3-ast@fiberby.net>
References: <20250901145034.525518-1-ast@fiberby.net>
	<20250901145034.525518-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  1 Sep 2025 14:50:21 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> This patch changes the generated min-len check for binary
> attributes to use the NLA_POLICY_MIN_LEN() macro, and thereby
> ensures that .validation_type is not left at NLA_VALIDATE_NONE.

Please test this well and include the results in the commit message.
I'm pretty sure it's fine as is.

