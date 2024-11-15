Return-Path: <netdev+bounces-145464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E09CF907
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B205F1F213C5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9341FCC4E;
	Fri, 15 Nov 2024 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO7Lkb9L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3921E1C07;
	Fri, 15 Nov 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706366; cv=none; b=G0E4mbPKP74Ucs9u5VyNm3U2BAq+1/In+pkJw2TYs5wAo6d308jCHka0KP81L68Nz/t7SshdRWcjyfc77OTOnQfjSsAU2cwMJjh9xsrg+B0YrJC1KFbJgoYcy7srZ9S9XI0xW1q2w5Dmktpb1M9mSkAITLDHYU8lrjdR9rQKvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706366; c=relaxed/simple;
	bh=sD2Vh6S7t1SuSC0zfoPnJDz1etOCITqvTKlSzS+QQe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rr93qlBjD4uXlKfPdLxIk5Ix0lcUXGft0H6OCaORJYVw9RlEy5PMkIXJQ7LuMCUaMZDt5BWyHJXRHL+AuqbwdmeyF8nbnDT+pQp2q1q6bmQtn63YPXFANEhQ8raw6i2unNdZOIvp5K9WiFRoDqbNqbODoV6QBJlgp5F6sgM112E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO7Lkb9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A40C4CECF;
	Fri, 15 Nov 2024 21:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731706365;
	bh=sD2Vh6S7t1SuSC0zfoPnJDz1etOCITqvTKlSzS+QQe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WO7Lkb9Lf7wQ4SBYfCz1zb3P/nb0se8O9npT3qT4k3D98brdsiexu/oI74vnP+Sbk
	 uPXZ1q/ZSyO1vY2Akj2E//PtHJ6Jrced0eL9kkwbgDkOJS/FrQaySr0dq6hZgXH6Am
	 t9pKyHnA3JcD3QVNC3R2pEICuWtkD1HPO9Monz6Uwtt9Tr7yt5ml2RZM0A8WjttZlH
	 5nQAig3OzYD98SaOCLdMLDOmBMphvotYF0RPajuXnsxKwG1XBwTJSjDOncR5Ytj6nV
	 EjZKfqBTx1EE2ckJn5qI4144g+kiDLSXTHDsHMaAps3bMz4XXyfY8N+slAqrUSG0gB
	 3zAHj5UVKUKhg==
Date: Fri, 15 Nov 2024 13:32:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 3/8] ynl: support directional specs in
 ynl-gen-c.py
Message-ID: <20241115133244.6e144520@kernel.org>
In-Reply-To: <20241115193646.1340825-4-sdf@fomichev.me>
References: <20241115193646.1340825-1-sdf@fomichev.me>
	<20241115193646.1340825-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 11:36:41 -0800 Stanislav Fomichev wrote:
> The intent is to generate ethtool uapi headers. For now, some of the
> things are hard-coded:
> - <FAMILY>_MSG_{USER,KERNEL}_MAX
> - the split between USER and KERNEL messages

Maybe toss in a TODO: comment or some such on top of
render_uapi_directional(), to make it clear that the code needs 
more love before it can be reasonably reused.

nit: possibly split into two commits for ease of review

> +    if family.msg_id_model == 'unified':
> +        render_uapi_unified(family, cw, max_by_define, separate_ntf)
> +    elif family.msg_id_model == 'directional':
> +        render_uapi_directional(family, cw, max_by_define)
> +    else:
> +        raise Exception(f'Unsupported enum-model {family.msg_id_model}')

You gotta say "Message enum-model", enum-mode alone sounds like we're
doing something with how enums are processed, rather than message IDs.

