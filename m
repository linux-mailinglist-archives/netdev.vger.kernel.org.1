Return-Path: <netdev+bounces-164966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2816CA2FED0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D14166A78
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5FC8488;
	Tue, 11 Feb 2025 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxrRS7EL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA025846D
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232504; cv=none; b=MR67m2b3H1t//VG4dLzVQWh0aylh3d8FutDCVOyZ7NApxhIoWqIauUgEaAOKhZtY99La3ISqYNLKqoa43Aag+uOgFB5Wu/8E9Te7qO792e/dfh9K0do30I/0VOIEdBB5h4zKS9iGNvKUAadOT/eB5Xs4JyJ7qAaQNpsDuSrhUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232504; c=relaxed/simple;
	bh=1X6evlCz02j9tkJw+PF84GAsQ6exK0diXH3aOljuI+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrZVhcocwSlT8xp4IK3CLbuGUkzxLKUmJ4MFXm3uwdmxqCdUO1tfI0QIe4RK6Fa+oNIP1fva/JgWDKZWvwT4HgK0hZPaixwa8vIg4ehLKY7SW9TQeXylf+WYANke6yV8MMT7io58uq4zqu7jLBkBMJNwGFYYvm3zZYRD68vADKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxrRS7EL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B82CC4CED1;
	Tue, 11 Feb 2025 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739232504;
	bh=1X6evlCz02j9tkJw+PF84GAsQ6exK0diXH3aOljuI+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oxrRS7ELcx91Tci055PuHWJ8HAzKBNgaBmKgS9A5+cfuFzEKSsCmFqsK6TU7W5N4g
	 nOLZccGGAnU6H/5kYqgzcY9N7OuTEt19C+eyTs7oYzFRxQYz/pkl8Ngu2m0SYJ3L2i
	 VZ2vufsAabmvsW2YGrFEkYytYqwQIT4jJTtwqe8P5VJB/fTY6vCU1YRHbDZBy+v+vw
	 sWz38Kcpi48cMjxDp3AWnv+EuUQ9qtb1EaORD0zhVPGQohVyORV6TMpos0wvkFUOpB
	 Pn9JMxJAK87mFjxYqcNzQHs17mLz5Q9sfUNtbVzQ2P5FnSQf9bRzhpxwZhzh5i585P
	 aTNW3uHNtwjeg==
Date: Mon, 10 Feb 2025 16:08:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, David
 Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 03/10] ethtool: allow ethtool op set_eee to
 set an NL extack message
Message-ID: <20250210160823.2b9c233d@kernel.org>
In-Reply-To: <47a451a8-e253-460f-8e58-dfd2265a4941@gmail.com>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
	<e3165b27-b627-41dd-be8f-51ab848010eb@gmail.com>
	<20250114150043.222e1eb5@kernel.org>
	<47a451a8-e253-460f-8e58-dfd2265a4941@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 00:22:08 +0100 Heiner Kallweit wrote:
> Would this approach be acceptable?

I don't think so. We considered this for ndos, IIRC, global state can
lead to bugs.

