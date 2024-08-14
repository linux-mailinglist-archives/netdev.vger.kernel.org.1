Return-Path: <netdev+bounces-118521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB633951D7D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE232905CF
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F221B4C58;
	Wed, 14 Aug 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKQV/VEf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675D1B4C35
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646453; cv=none; b=LsogZY51HLuCmV6DAPJ8euWbxq5KEjMaIMqj1ICuq+B6o6z/WNQvx4G2cxbCSDWJ6yK9wOIP+YlQEUpZ/eJm6g2DGQgYXXd31mAAVoP5Gejq9Qr7TLU2DU6JQDzi6w/lADkzmHevrLIycEptvG9zBuRDYgf8CcLVNgbDTnP681g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646453; c=relaxed/simple;
	bh=HsLJabBNysEhbYCg8CsEWQp4/YduJPKbjcYuoFziZ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRKbhuj/+70H5v0qXXXF/njxKCb7wgHlhuu6dHEzwihLSsTxSpVbFZaiVdRgTDG9vfS4F3nknVFqmmmUYBmfYWCVlTKzh/utAfxEe+QPxiIrWHgLFRF1vFhLvIZTLAJbNQNFGEmuvrBNxfdKnDZ9RR1qc7G693c6OFJklrkrD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKQV/VEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F367BC116B1;
	Wed, 14 Aug 2024 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723646453;
	bh=HsLJabBNysEhbYCg8CsEWQp4/YduJPKbjcYuoFziZ8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKQV/VEflwvTsD1oCclWhkTn7Z5Jv6+/r13dX22QmsrhAapLN9yNAIaOBJf8JHY1b
	 X9y5JGeMdQB4C7kGQYkBIhzH3bwza4YR6JQkX0vFukwFRFKN9VLhqpAPfbUUql4uAN
	 hAOCdjye49dMRbGSfHBLbwH1eUwiLcpIrtXeoPeeU98D3H94QGPYRMFzumoe9EmKdp
	 eygjH6s2ew+M+cWW9qsNBharbqtlsMtJUB/6vCwhTG6yK1CG4V4NZhyRHBUtC5FPBA
	 ghUFgy7ap6zH3vH5FQ8ypO2WssjRAcd+UxCiJF/JbBPx5iInfqF/soGoQFJxMTC0tn
	 j4oBPb0FA7QSw==
Date: Wed, 14 Aug 2024 07:40:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Mina Almasry <almasrymina@google.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, David Howells <dhowells@redhat.com>,
 Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH net-next v2 0/6] tc: adjust network header after 2nd
 vlan push
Message-ID: <20240814074052.702546f8@kernel.org>
In-Reply-To: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
References: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 16:06:12 +0300 Boris Sukholitko wrote:
> v2:
>     - add test to tc_actions.sh

Discussion on v1 has not concluded, you'll have to repost once it does.
-- 
pw-bot: cr

