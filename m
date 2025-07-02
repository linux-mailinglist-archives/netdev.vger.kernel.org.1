Return-Path: <netdev+bounces-203423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D4AF5E1F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765DF4A0500
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B22E7BAB;
	Wed,  2 Jul 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5xHOkLS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C122D77E4;
	Wed,  2 Jul 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472657; cv=none; b=K4zMqc0w9UedoLS32rM9U6HIHxucMd9DR6X0f5Q9ZuPhWQUS2MUN6l60IxWvJRDPJeE5iYo6QwuyUYlQwdKKCvvltmibL6C1SJaX5Jr3UIlNcAVfKvD5cNB7NQrIdssuiDpRUVyvQRZ0QSAMsfPgu8+jR/G6fe7mARJdqvLFEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472657; c=relaxed/simple;
	bh=YdCT133p82j/BMPf6XPBFAhX9tGEdrgh/9PMIHJn8ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMbfyvIWrhn8iNXf93N3oG5rKlbk/szivmXZnCxy/A9tqOa3bwfDzhdsVx1aOtyXxkG5v5MBdkBMQKM6+I8+fnRbcQxKho7QqsMGHiK/26Tk9vYWKckwyedWxNJlkCskFVE4f+dR8mZiGyngnNXOrltzh0UuUhn2hnvSfbOtRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5xHOkLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CF3C4CEE7;
	Wed,  2 Jul 2025 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751472656;
	bh=YdCT133p82j/BMPf6XPBFAhX9tGEdrgh/9PMIHJn8ng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L5xHOkLSmVeNk2d9iOrtcD1bQ7piTvl8rrMPPnbXwbxYKPYxqrs0lDRYam3VHOIAd
	 6F6yxcsIgyRbzg50gzQk262bUjAcE/zPlrEFLDCSYE1Zx7icTC7y1vjIQ1vEoUCEkz
	 Of/TgwJoFOr0N3984xFJDDFU34uPkGDzzuNUnbeEiz2crveRXtCLw24Ejl5cOpvCL4
	 Evb8HE14ncX4Scd5qeavGIWrkrc6Pg2DC2Zbn2IoIzVjwTIiUQrJFtruCsyJ3/Tytd
	 41CNdloAawF0jHMhdnZr2kA+JW6FS2QMkTiRzsQhmEUnSxL4tW2wUI9SOZa2dJWQml
	 EamIJPunholxA==
Date: Wed, 2 Jul 2025 09:10:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Gabriel Goller <g.goller@proxmox.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
Message-ID: <20250702091055.3d70a5ee@kernel.org>
In-Reply-To: <7c47cfb6-c1f1-42a1-8137-37f8f03fa970@6wind.com>
References: <20250702074619.139031-1-g.goller@proxmox.com>
	<20250702073458.3294b431@kernel.org>
	<7c47cfb6-c1f1-42a1-8137-37f8f03fa970@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 17:14:42 +0200 Nicolas Dichtel wrote:
> > Should we invert the polarity? It appears that the condition below only
> > let's this setting _disable_ forwarding. IMO calling it "force" suggests
> > to the user that it will force it to be enabled.  
> Not sure to follow you. When force_forwarding is set to 1 the forwarding is
> always enabled.
> 
> sysctl | all.forwarding | iface.force_forwarding | packet processing from iface
>        |      0         |           0            |        no forward
>        |      0         |           1            |         forward
>        |      1         |           0            |         forward
>        |      1         |           1            |         forward

Ugh, I can't read comparisons to zero.
Let's switch to more sane logic:

	if (idev && !READ_ONCE(idev->cnf.force_forwarding) &&
	    !READ_ONCE(net->ipv6.devconf_all->forwarding))

