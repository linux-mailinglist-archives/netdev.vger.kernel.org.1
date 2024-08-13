Return-Path: <netdev+bounces-118099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759849507FA
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C98285B26
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C739199389;
	Tue, 13 Aug 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTnLXzdI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00896125AC;
	Tue, 13 Aug 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560020; cv=none; b=HU74abfJxunvkPAUXcGI39DCSRCGOlysJH7mDkkx7wHAPcbOxPBciqnOVruDXF2UjFIFYVeP1Fu/6mwSLgenEXBtTnKirNUmG8LYJLOisXMPbSM75c4Kgs+Xp+fhpCMm9domQ0bQmkQDZSUAahLDLvwyIODt+FgpVNTk0wfjvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560020; c=relaxed/simple;
	bh=Tooc2wHSg7kwJQIiG/bosYG3a7jUUALAP82Rlb7hIPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRYsnob3yt9EOr5XF3cn7JHb5oIGZIfNkMbp5ZIiy3GK8EFuDd95k+kXFCc7F/Pheh2N5d+MbxiLB7VOMlXFXxASZutBCwDPTafwN5zRuruhWgGGDareaGxOJXAQ9ZsSbGrAc644G0CVJFflVdMUOCNnrDsIDCxGshKReKP2VTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTnLXzdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B770C4AF0B;
	Tue, 13 Aug 2024 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723560019;
	bh=Tooc2wHSg7kwJQIiG/bosYG3a7jUUALAP82Rlb7hIPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qTnLXzdIUGsEzcTtJNYeHONauOcln2TvphzfGJH9LnpGIhfnOjjBZeK2L9BQ5/Krm
	 UDW6yyNvXqt7zB+3K+Ixju+MFpY3j59PtvtOjKjHSEzY9NB+13A1qRgR+PrvxS29vL
	 6xO5ohpe3vSbpFkgPXUEXB3zCCaaVHBJBj/mVZcjTaUWY+Pk0DwNs5xkNLxZn+PXs7
	 rHCTMLMxeoD5Ng14uU9MFrNhpCZheXiEefKrJa10xOUZh31uEQfV7CUWccD1wndhLM
	 nYbEsuMZ8cggSa3y3KGt9NrvUl/ETTSNX11vPHFhTT2pMjpRf4iGFym6Ud7gvCwWc4
	 AhimXXmaClliQ==
Date: Tue, 13 Aug 2024 07:40:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: davem@davemloft.net, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, edumazet@google.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, inux-kernel@vger.kernel.org, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: Re: [PATCH net-next V6 0/4] virtio-net: synchronize op/admin state
Message-ID: <20240813074018.21afe523@kernel.org>
In-Reply-To: <CACGkMEvht5_yswTOGisfOhrjLTc4m4NEMA-=ws_wpmOiMjKoGw@mail.gmail.com>
References: <20240806022224.71779-1-jasowang@redhat.com>
	<20240807095118-mutt-send-email-mst@kernel.org>
	<CACGkMEvht5_yswTOGisfOhrjLTc4m4NEMA-=ws_wpmOiMjKoGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 11:43:43 +0800 Jason Wang wrote:
> Hello netdev maintainers.
> 
> Could we get this series merged?

Repost it with the Fixes tag correctly included.

