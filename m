Return-Path: <netdev+bounces-101173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D478FD9F3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE1C289E98
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203E415FA89;
	Wed,  5 Jun 2024 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihPpbI29"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB3415FA60;
	Wed,  5 Jun 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627198; cv=none; b=VmeTlKEQrDM510lldMQ5E6SxuH802alrThiDYqk4zJh6nJbYOVKDgGBpVFJbbyR38+OM91gPAEDWQCD4H+6l7YotU6yuBGnL5MJDP2GqgtVIfo92bNUVOWCWvxbxAmAxCfqGQhMfNg2R0fCm+xJcPytrPM7dIfCRNR8D/TX6zQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627198; c=relaxed/simple;
	bh=OwgcFchWUmf3GQJJ/1kLWraWpNxrps7U8dsQjqE3d4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqENkUmreYenv5m5B6l9TwgSQH6pCWtCXeiiiLJxWOjnRCGO1Xfo4+p7OJFvvz/JtII3vzjf5uSuVAYMkJsT6Fgy7mlstYdnfQDzfT/OdsIumD0JesgBxTH517hkV3jmCmiH4a99uB+wL+j60omSDXdpriHy5SQGB7z+w23Uz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihPpbI29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59440C2BD11;
	Wed,  5 Jun 2024 22:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717627197;
	bh=OwgcFchWUmf3GQJJ/1kLWraWpNxrps7U8dsQjqE3d4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ihPpbI291P4ecn1GWwOYbFDGM+w4U8V9AHvjEB1x5lOOHV62AI/LnQyVMmP32HKpd
	 xpl/MwrT+EOmwXQuZ7znc4fvG2dODFAS8cCYFavqkBUNAuXXlOTlJo/TOgyCnCKF9S
	 oqAgM+y4B4Fz0lFZ334y44pwqN6/+eraxTDKzgrn4dbnLHEXPJ6mHCwM7oBnOOowHK
	 Puxy9ura2e5iOwL0woOwEEvOcvNUZRjDCdqNZSC76/RHiSpuz6hqv2xU2HkIBH7l9r
	 /4TRAwhBb4gjWiyb8olWin5ufnHBo8NtrRGOEOcDlTfeRpqhQ5q8qg98qHPXwm/d8t
	 e6xRQk0hjQ5uA==
Date: Wed, 5 Jun 2024 15:39:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
 <hkelam@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net PATCH] octeontx2-af: Always allocate PF entries from low
 prioriy zone
Message-ID: <20240605153956.4b31a380@kernel.org>
In-Reply-To: <1716996584-14470-1-git-send-email-sbhatta@marvell.com>
References: <1716996584-14470-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 20:59:44 +0530 Subbaraya Sundeep wrote:
> PF mcam entries has to be at low priority always so that VF
> can install longest prefix match rules at higher priority.
> This was taken care currently but when priority allocation
> wrt reference entry is requested then entries are allocated
> from mid-zone instead of low priority zone. Fix this and
> always allocate entries from low priority zone for PFs.

Applied to net (silently by DaveM), thanks!

