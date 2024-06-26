Return-Path: <netdev+bounces-106738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63C9175D9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF111F219E1
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11111184;
	Wed, 26 Jun 2024 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl3UO4hK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988DBE6C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366435; cv=none; b=oDBl5P35yJvfObeMTUKwqye24T7Qkig1DzB/LEZO3kwq4UBcavLAanxQ67xKzj+90uf0TLTiRZnC0HVDa++7aQOgY7lnOrhCSccRQEvHtpWUSV+gbC8SUsyQyTUuI5NOH6hGZh2xPegXqv8eJyZovOy1Avz4eFh/t/P4iItuxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366435; c=relaxed/simple;
	bh=sXXT0xw4ebgnks4VkeSEqYzP2UJf89TvzByRr/DA4N8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSJjApBmusRY920WpbB8M9PKFgmIMjjEfcRzqPpOZXh3EpbGRB/yK6jBrnTVHTTtf76ic1z1if5WVmLw1jhi+3jYfjSL1BfTmDOyS0oGVJnk/iRPLZhlku6a6leZ+SMQvDHURehX2veyPzWxE2w2VQoHYKDHpb4n7jq/f0Q1oIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl3UO4hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FDEC32781;
	Wed, 26 Jun 2024 01:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719366434;
	bh=sXXT0xw4ebgnks4VkeSEqYzP2UJf89TvzByRr/DA4N8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dl3UO4hK43gkcC3ru7Wivxp2H1kZL+n3LnfeJp85GUnddd0YTTk3ZUAdUrr1x6blk
	 6l41yeOe8fq7q9IA4aQrn93PqsuA+SduMQhpV9+TOfmfBJ5LogOs9vD1jEBANJdDgH
	 n6b6CvanVafHmWkVIopp/AN0YptS6jq9o/KAvT2E6FfcLCoVciyisS8l8YPdpys9rk
	 WHQSTA/+U9GcRVU9eEcERO5N+5XVfAvKYISsqcnwG57ghP3wskFeoKgtwleeNy32ym
	 UZVwxEBe/nAO0cp9UDseOk81hf/L9LLsaDXcnrrNJocERGTLK5XXzYmR+56GzZ6oVe
	 RszMBJwuttIvQ==
Date: Tue, 25 Jun 2024 18:47:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, horms@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com
Subject: Re: [PATCH net v8 0/3] Handle new Microchip KSZ 9897 Errata
Message-ID: <20240625184712.710a4337@kernel.org>
In-Reply-To: <20240625160520.358945-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240625160520.358945-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 16:05:17 +0000 Enguerrand de Ribaucourt wrote:
> v8:
>  - split monitoring function in two to fit into 80 columns
> v7: https://lore.kernel.org/netdev/20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com/

too late, v7 has been applied:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=4ae2c67840a0a3c88cd71fc3013f958d60f7e50c

:(
-- 
pw-bot: nap

