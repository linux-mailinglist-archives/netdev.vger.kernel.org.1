Return-Path: <netdev+bounces-187820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBAEAA9C24
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E79179B86
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73582557C;
	Mon,  5 May 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHpjbDNx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834795680
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471652; cv=none; b=GA/wh5k7qnFKs1G04KpLnOqML6yXC9YAcl8akdSBGYcJcfNhHMX3/qJwBzbVbjxcoyfUYJe+OmXgtYSE5Mdl7XMiW7ji8h4H4ma7KivihISkofmRVWjPJaXORi4d8/e+56QJdTElwSHH9a/8nzQOZrikVYI/1GWoGDGD8Om0ZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471652; c=relaxed/simple;
	bh=0vspP+B5ayYWMsJ0nfosh2YZpUYZs4yfHDyqPwHT3iE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrEGD0bABZdWyXjceyMSHueMK9UJKVqEHfCStb1gydQSa7vbJ02xNSB7m3QzEAhoNdcUZnUHIxMkR491VxyPuzIkCBO6ideT8ujuheq8jBkESBraCNn3EMDFnBkqV5yjtVYA8CEjTrGZwUT5K3hCxsJS/3BFjVaDbQ55GDmX3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHpjbDNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B14C4CEF3;
	Mon,  5 May 2025 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746471651;
	bh=0vspP+B5ayYWMsJ0nfosh2YZpUYZs4yfHDyqPwHT3iE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHpjbDNxs8nlr0ScjHDGtdCPq8RjEAaPFjjFLqaoIqQCEF75C/6zJP5BlxZ+m/YOr
	 bv0izmtOMt6VxggbOP42++Hfu4TFatNBDAgYgtCuotfaP9omTyPns/u2xNMRrWqD6L
	 FLyqWIzj5YZzbV7Ubvf/VdTpVoI4TemjCQHaeVLLic8ioAc80Hoy8kHcP6mpy4FeQ1
	 eQGDFibPmnWU5y6FvXoqtB9LZdXzrlxNwGQrjEJDEcGVT2dil5gMMGjrdLjo4aQsZh
	 qR/ZFOKxuMwjdTqMuVu4pfiWjnSoaWUf4G2/0dPwl1bC9mmcxR4qXAFdSRa9L5Hkge
	 EJyH/ijXSzSBg==
Date: Mon, 5 May 2025 12:00:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Olech, Milena" <milena.olech@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
 "Salin, Samuel" <samuel.salin@intel.com>
Subject: Re: [PATCH net-next v2 10/11] idpf: add Tx timestamp flows
Message-ID: <20250505120050.129d10ee@kernel.org>
In-Reply-To: <MW4PR11MB5889D9FF1A6F7D10091C6ADB8E8E2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
	<20250425215227.3170837-11-anthony.l.nguyen@intel.com>
	<20250428173521.1af2cc52@kernel.org>
	<MW4PR11MB5889D9FF1A6F7D10091C6ADB8E8E2@MW4PR11MB5889.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 17:08:12 +0000 Olech, Milena wrote:
> I see your point, and I've had a long discussion with Olek Lobakin -
> we tried to prevent all possible deadlocks, and the conclusion was
> that adding lock_bh in BH may be considered as overhead.

=46rom my comment it seems that I saw a caller from a work, not from BH.

> BUT maybe I'm missing something - do you see any scenario where
> the flow may break?

