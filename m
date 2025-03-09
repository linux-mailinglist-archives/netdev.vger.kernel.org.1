Return-Path: <netdev+bounces-173235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CBCA58164
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 08:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18F3188EAE0
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C9186294;
	Sun,  9 Mar 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q86/6Lfx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F5617BB3F
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741506636; cv=none; b=Af0LoPk74a7CZb+Z1P+WV6eRy3Ddj/NpbanzNMlU2F0R55Qs0y268by1sSXybEgTnK5rS9oDS2SCNqGd39WjND6rWrAyls0G9K+8dJ1NZWwwmeGSxcdYJNp9yNFKpb6KVMP3Rzr4YzujfqpiyaFTmhKcRa8NCLEru36z6/77Z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741506636; c=relaxed/simple;
	bh=6Ijr4KIpQkuwkZSerp6ws7MjW4fMTkdgprv5Qg8nqiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h744izbWfGA6/4Luky//knnVE82ADl1M1NXhE8ivI3BuDzodc/0RKfwpSyKpMCEioFDlsXDein2dF6Rv1toxM75GBi7TpRKx+d16N3cdjsR9AM5+7+/3jNqZFydjSWJe566NupUuk0bQy2FplVsDDW7zBerovBDIqoDeuHp7jlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q86/6Lfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6B1C4CEE5;
	Sun,  9 Mar 2025 07:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741506635;
	bh=6Ijr4KIpQkuwkZSerp6ws7MjW4fMTkdgprv5Qg8nqiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q86/6Lfx4Yyd/QIuIYAjN5jmPEvTtWddCXWqLft3LmTfrrXsFbHKbIVWPJ2RsZehK
	 a7qDo0Z+cFDylotxSULQsJiPZI31wCgiAFgueHrHgThCgkxFiv0bs9q7px1ildrRHJ
	 r9noef0avkuvXyXt/GC7caSbq6f6JH5GbEIOS8ru2rP4duMCWOJZgzm0bzzd1GCNig
	 cGTkuJ5VDfXMM54aZna/mKDU4afcmsRYIOih94R000IzZ0zcHCqsGL1y+dJEyXDP8s
	 auhbbhf4hYPivhH9NCdl0SfnAWyzRCrAOqvUCDx32tfHTH3rRKUiX7BoieySGXkULD
	 YM0LNZd94vuSw==
Date: Sun, 9 Mar 2025 09:50:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <20250309075029.GA10087@unreal>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
 <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
 <20250306114355.6f1c6c51@kernel.org>
 <ahh3ctzo2gs5zwwhzq33oudr4hmplznewczbfil74zddfabx4n@t7lwrx6eh4ym>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ahh3ctzo2gs5zwwhzq33oudr4hmplznewczbfil74zddfabx4n@t7lwrx6eh4ym>

On Fri, Mar 07, 2025 at 01:35:28PM +0100, Jiri Pirko wrote:
> Thu, Mar 06, 2025 at 08:43:55PM +0100, kuba@kernel.org wrote:
>=20
> [...]
>=20
>=20
> >nvidia's employees patches should go via your tree, in the first place.
>=20
> Why? I've been in Mellanox/Nvidia for almost 10 years and this is
> actually the first time I hit this. I'm used to send patches directly,
> I've been doing that for almost 15+ years and this was never issue.
> Where this rule is written down? What changed?

Maintainer?

I'm second to your feelings.

Long standing contributors sent patches mostly directly. It was definitely
encouraged to send long series through Saeed, but simple, one line fixes we=
re
accepted without extra hop.

It was easy and convenient for everyone.

Thanks

