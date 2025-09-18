Return-Path: <netdev+bounces-223210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E97B5852C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92492205B6D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91500280CD3;
	Mon, 15 Sep 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEXIVtxf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB7280325;
	Mon, 15 Sep 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963674; cv=none; b=aenJsZFpKRZQftfLDFh1zdKnFDaYPr7CEX8QI/X/H6MafCmu0fkdCMdCd/P5RCugPznYNPnzF8UfWAYynFwL0QHYeWF4m1GTktYBPPdEKjQR3ldpmysJTm0ytDsUiOz/1YR5ri7LM4Cu4djdyPT685dggZRlPOoLnuJzWIc6hBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963674; c=relaxed/simple;
	bh=WR/ccjdVbx7wP+a+ik9GRqSJSOhG72rt+JckoOvOLnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFSp9n7Y6dNfXpYH/vSxPvQeD/JNACg9Fz97S3LZbJwcnbDQ/APdpKp/ZffW16MOlM2w+lXFZ4Qp1IyuZppTaVHmZvNiNhK9OVdP9b8E935vcCTw2NwZhQX2Ma4j7D4WSpK+CeIo95a2qVhEwwJlS1cmk/WD0MU45JZAVuy4wCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEXIVtxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5183C4CEF7;
	Mon, 15 Sep 2025 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757963674;
	bh=WR/ccjdVbx7wP+a+ik9GRqSJSOhG72rt+JckoOvOLnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEXIVtxfguipyPtDLkdghE+b3AhQrYr1WhTDX/i6XDMhNTW5yocjLA7GQHaELAQ1Z
	 ogBFSDttvarY9OafQVB274d9hoD+acfPdEn0eLalnFZW6CA+rajPjxoQ0mbXToDKtk
	 /vlDeaGKp+fVc8NL8QReojfvoSuUaWjAwpY5hGp4k82z8zIXSj/n3dWHqTw4Zdo9W2
	 jARY35mtLTsgTVRKZlycQF3o7Uqx4VcXoEvmokN9+IFXcWWRsUWroIfTxeHE9Y+5JC
	 PgAqlM5PB/YiNWkJsVkIVhAMpWhQbGS/Yl25QynWQS2qHIuW6COpctGbR8o2Wmjjdh
	 wcaycgutQeD+w==
Date: Mon, 15 Sep 2025 20:14:28 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/3] net/mlx5: Remove VLAN insertion fields
 from WQE Ether segment
Message-ID: <20250915191428.GA322881@horms.kernel.org>
References: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
 <1757574619-604874-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757574619-604874-2-git-send-email-tariqt@nvidia.com>

On Thu, Sep 11, 2025 at 10:10:17AM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Now that the driver no longer uses VLAN TX insertion via the WQE
> Ethernet segment, the related fields and flags can be removed.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


