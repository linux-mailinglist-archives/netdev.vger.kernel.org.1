Return-Path: <netdev+bounces-111586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE49319FF
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 20:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224C0282212
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD54E1C8;
	Mon, 15 Jul 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnneO8P1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DF61FC5;
	Mon, 15 Jul 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067034; cv=none; b=rrvU6NgE6R3e+OQzMA6dcUGoAnXfQjbD7XSrN45nl+4NUybH351HIggpUZbJBjNr8Kp0wkqglsjCwHkHnY8M/s2IwcHZ861GbBP8/6PQZcI52ddwBUCeBJv2p983IN4eDo+BldIhxAOq04OdUdXLeFFuuHoUcYO/XG+DXHV9jNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067034; c=relaxed/simple;
	bh=AHfXE/zFjSs0Vvypq/m23X/tU5Hxrml3aAPDxElyB3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4zcBHEdheabMPjBKUKis6oBOyMxIZcA9mpkb5348/bzTfgVCU5E8Fj2zfuBK46YPe4Malp+bFLA/l9ynRzpZ4pHXgM7CeFn249vctjZuU7I/KwNDJ08E4qqt+IPXaqG7qmo5yUUwtwnJsyYb3yS7oPLp4X80ytX4LvRnsyIP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnneO8P1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A063C32782;
	Mon, 15 Jul 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721067034;
	bh=AHfXE/zFjSs0Vvypq/m23X/tU5Hxrml3aAPDxElyB3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnneO8P1nsDDV15QgsXgg9pYVc/taQ+To8VMTHRdmStWizmDBCIoypTLYBEWBoffF
	 RAok4jCjXZcjWWYPSTZ7mEU2my+xrhV3RJ1tUoJMIcPu5u64gefGGHQCKoksIqxU1U
	 okRm842+xsQv5YCXi8l1XYU9nc2/Nl2TKl85gQAg3x0qH3JqWzcjXdCSfm41dt4bNO
	 8ByGRvncKWzHFHBHrU4LsNdLfP8CpSVT3382AZWHPe9T28CMElVwfnBCs75amRhYwq
	 h3Fkw0ht81J5fdhAmWLyOuH+NB3MN+ij0241ved4ddcyNTY881SFAAj3bbnUBdyKB3
	 NUVaOWn+Aud3Q==
Date: Mon, 15 Jul 2024 19:10:29 +0100
From: Simon Horman <horms@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next] bnx2x: remove redundant NULL-pointer check
Message-ID: <20240715181029.GD249423@kernel.org>
References: <20240712185431.81805-1-kiryushin@ancud.ru>
 <20240713182928.GA8432@kernel.org>
 <11e7b443-c84d-48ff-b7d7-12b4381585df@ancud.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e7b443-c84d-48ff-b7d7-12b4381585df@ancud.ru>

On Mon, Jul 15, 2024 at 04:52:40PM +0300, Nikita Kiryushin wrote:
> I agree, I guess I was meaning to state, that bnx2x_vf_op_prep()
> already contains all the needed checks

Thanks, I agree with that.
Though if it would me I'd just drop the reference
to bnx2x_vf_op_prep entirely.

