Return-Path: <netdev+bounces-206706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3274BB04248
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8067716C925
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0AD257AF2;
	Mon, 14 Jul 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8q16are"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77319253F2D
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505005; cv=none; b=PPLD1cCeNFTiGz7fcNwf6FEhlclqEh2MUNuM1lPq6KsNsCc/quDLloPYtUmRMzmO2k+rFMOn5iTisV1DEegFPCJz1qvDxuypNfH8gY40HZo5TYDeQFdRbh5t0OZg9mLUuRLLQVBkCfAYF/NtJLsrGOL1setje76P1NpUGfFl7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505005; c=relaxed/simple;
	bh=qK20ucFAiCL75+Fzw23vQq1RpYA45HbWnk6HGrsRlLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deAbt9dDjvomqgvj9eukwJ+O6eTJEnOtZkEo1WABTSgLqEu9pYNXG+t1fLmjazqz1AJwHpULSrmm1vWP/sti7dnxeVmRigts4sLohPEvLVNXqsbvaK8pb80GxhGw3dGHiUrPSXFvq36hcci/X0MMa4BtXXp24xjzd3w0W4Wr9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8q16are; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60D4C4CEF0;
	Mon, 14 Jul 2025 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505005;
	bh=qK20ucFAiCL75+Fzw23vQq1RpYA45HbWnk6HGrsRlLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E8q16are+VsFJ5NdjV1+t9KtHnEr9JRXtERUOZBKX0jc3pdDwUixYDLrWbLzy+bBT
	 9ajM37/KHgiBGjcgVNOXho7EIxlKd8jZugjADFWsLsDZokZrsmSytIa6/Cvk1MENtJ
	 esJNSiA8bzr3lhuToY5Aex9/fWFqsa7B8HXny4ooIfRNO6lMAaBdtaCm6VKDkFng2J
	 Vj1DTVc70QvrZwweSQ383ghxWh4IBJUcNCz5KZoonK0XuGXUDW81J5DjoNc9b163IJ
	 3JmYE51WhM7t/IBXwHy62y0BeTadtualyJOS97plcAk3GklS/SDafVjxUmACUe+WjM
	 Z5VfWh2BKnh5g==
Date: Mon, 14 Jul 2025 07:56:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Donald Hunter
 <donald.hunter@gmail.com>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net 2/3] ovpn: explicitly reject netlink attr
 PEER_LOCAL_PORT in CMD_PEER_NEW/SET
Message-ID: <20250714075643.5fe7df70@kernel.org>
In-Reply-To: <5bb491d4-11ff-4c63-96c4-de83074e6ae4@openvpn.net>
References: <20250703114513.18071-1-antonio@openvpn.net>
	<20250703114513.18071-3-antonio@openvpn.net>
	<aGaApy-muPmgfGtR@krikkit>
	<20250707144828.75f33945@kernel.org>
	<aGzw2RqUP-yMaVFh@krikkit>
	<20250708074704.5084ccb8@kernel.org>
	<5bb491d4-11ff-4c63-96c4-de83074e6ae4@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 22:04:49 +0200 Antonio Quartulli wrote:
> On 08/07/2025 16:47, Jakub Kicinski wrote:
> > In any case. I think what I suggested is slightly better than
> > opencoding, even if verbose :) So I set the patches to Changes
> > Requested..  
> 
> So you'd want to go with what you suggested on July 7th?
> I.e. using subset-of and defining 'peer-input'/'ovpn-peer-input'.
> Did I get it right?

Yes, please. It will improve the generated userspace C code, too.

> As Sabrina pointed out, I'll also define a subset for PEER_DEL/GET, 
> where we only need the PEER_ID.

GET may be hard but you can try.

