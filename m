Return-Path: <netdev+bounces-122515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F096190B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF1FB21AE7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822371D3656;
	Tue, 27 Aug 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo3pdkxI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB3481CD;
	Tue, 27 Aug 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793256; cv=none; b=M3kVEFVqaFwLPmFsTWcLzSiVhMkJi9nK5jQxf6oMDt3/RFY88mEaPn5Kt7ZxwdCYUhlmgXWlc0TdlBt4MbpVNLOVznPm1nYecPDuce+yIKbbdCM3vY0GL5losmoElMyed0tr4ZVokiD2MlvmbjLSl6WbuMp/OXb5K4gVJ0LIO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793256; c=relaxed/simple;
	bh=Jz11fOTxb75hq3mJuuiDObI+bI82XFXqBPCYA9A5AoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DonbLF4Q12kv+xfhoG6KvADlIrjrZCuEWU/tSI4U2+Kli/MDkGH7dFDD89z9sMprrOCU7m4bAji0DEVb7oLsCqovtOTMwIOin7qPDwqB/tXesHDJfouFwkX1zC+61OwogJw9UdmAGoScU9RTLY6dSRn7xO0bIx91UllyJMkK0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo3pdkxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D76EC4FEA0;
	Tue, 27 Aug 2024 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724793255;
	bh=Jz11fOTxb75hq3mJuuiDObI+bI82XFXqBPCYA9A5AoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eo3pdkxIOcdK4uDdXCs8vfxXGwz6C7bbpJH9yEzKVtvA1tPgEppmR25Luhg0HsGhJ
	 J8ewxi7wRMHUnkL/YsFUU/HVyVAr+mugOPFyEd/hfnBYT4FmSP2zUufIMKglMJ7bTI
	 +Y//bmJHehkXnmN3zvOm3SVVH4YJc6AKhz9jSBkzhv9FIIRtdbbV//tjC7VNUsJqXl
	 /7LuoaQNCWHb3+9oRsxizNnyDqq3VaTaCXYoh8ZBM/CZN8qp3zCu56zh8e3DvJ81Gy
	 MCNEGJaItxq/Chd6GRkN/ydopguBocx32aPRWqPdsz4v1B7/JLApe7aBAH84V8JpZX
	 iMkzLZ4Wce18Q==
Date: Tue, 27 Aug 2024 14:14:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Trevor Gross <tmgross@umich.edu>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v7 4/6] rust: net::phy unified read/write API
 for C22 and C45 registers
Message-ID: <20240827141414.5df849d5@kernel.org>
In-Reply-To: <CALNs47uSeGR_Z_Bor4yKbd848XdohHMam47zwBct39nEmKFb7g@mail.gmail.com>
References: <20240824020617.113828-1-fujita.tomonori@gmail.com>
	<20240824020617.113828-5-fujita.tomonori@gmail.com>
	<CALNs47uSeGR_Z_Bor4yKbd848XdohHMam47zwBct39nEmKFb7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 00:44:50 -0500 Trevor Gross wrote:
> Small suggestion: I think these could all be `#[derive(Clone, Copy,
> Debug)]` so they are easy to `pr_info!(...)`. C45 doesn't have any
> derives.
> 
> This could probably be done when it is picked up if there isn't another version.

Please respin, it's not too much work. It's really rare that'd edit
people's code when applying in networking. The commit message yes
but code very rarely.
-- 
pw-bot: cr

