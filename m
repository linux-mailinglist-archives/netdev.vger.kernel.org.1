Return-Path: <netdev+bounces-132929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D169993BE9
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26491282F72
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893EE79C2;
	Tue,  8 Oct 2024 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF3DdmB7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44FC147
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348436; cv=none; b=ldbK8quxxZNzJXx03LmLtNzy6ueTZnlpPrTYuqtN+Q41Ah57oGsxcd9e7PiUg9BNmo0HRWhFfJCWqGa7FCAygxz56CP4dioMCkl1IUM2LqbquFPLDh9sDMLTtJGYVJVDyldsvMT4xDSWDwQeZEpBk1lF+L68BkfL16O4SJD0Tqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348436; c=relaxed/simple;
	bh=0z1ea1NFLo3/TNPjuIlKz+PecBxbDclGW/UlI0OHe5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxGNnSIT++1DHRFYYizDTiQI0alrC/Ow1CnaljVrvPKSudJPAQrGyueylbmJ5tRiWNp33SjV90PA0THOsJ3dJDPtEWJ7m9LqOFuCpDM3nAaBSrqxCuadFuhoDBZdL5qhu2RZhWw5xaUw9MJuJ0j96xnJXgqxm/gDcsG6aQklJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF3DdmB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD748C4CEC6;
	Tue,  8 Oct 2024 00:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728348435;
	bh=0z1ea1NFLo3/TNPjuIlKz+PecBxbDclGW/UlI0OHe5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZF3DdmB79HpVQD+ISybnDFMhi+gQSjchmZSFeEO7tcwCVXNl+IzPBzj/GisQuyHac
	 Ak523IhFS/RhqOW1OAoMHXh38OdPKCAXIBPhDTXh2ymJcN/5IP0/9VejfKQ5AdXBNW
	 LYQk83N9lzKZPf3oSRGgeMpb6dKg7q7TrgHDkIeLXQnI9BNk3kMGO1Kx4bBJ++f8ws
	 NhWgtdTZW7ZIihMpGYWFyhRj5L/kflVBNcl+z9vJwgcuNOeGvb6EpyrLeCT2iVfG9e
	 RCaPinwckDAGSrHvkOgvKdfwiHcfYloUsPVKYRNy9V1ncHzrQa0JJmfFCyH2QVYs8t
	 f/rb1h151lZUw==
Date: Mon, 7 Oct 2024 17:47:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: add tally counter fields added with RTL8125
Message-ID: <20241007174714.548f2efc@kernel.org>
In-Reply-To: <248a0f5f-46d8-42aa-971c-d7a410c7ba62@gmail.com>
References: <248a0f5f-46d8-42aa-971c-d7a410c7ba62@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 20:42:23 +0200 Heiner Kallweit wrote:
> RTL8125 added fields to the tally counter, what may result in the chip
> dma'ing these new fields to unallocated memory. Therefore make sure
> that the allocated memory area is big enough to hold all of the
> tally counter values, even if we use only parts of it.

doesn't seem to apply
-- 
pw-bot: cr

