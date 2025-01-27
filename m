Return-Path: <netdev+bounces-161203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C2A20017
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722B81884D72
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C01418FDBD;
	Mon, 27 Jan 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stNqNdfR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FF1DA4E
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014582; cv=none; b=m8plr0UUKN67oi4QOFRABYPe/mMJDFD157ud3gRb70tlpw1tHydZ9eP+REJNS8KhwkC+59G9iLq45HAZ9L1oOfOhcQ4YWcxaMM92zkLBYfPi65qDNKHJLA4rRAsfN32pFFUd1teqDncmReFSDRnNQBahN3c2qrOy+adH7HUo3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014582; c=relaxed/simple;
	bh=/41i0uJf0GZRP+uRcr/ydEYhb2JNlo6cmnx7qlw5Y4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZgJIIat/RBNCz9zegiswmv4pAIJyppzjG4qVzMNfEA9QxXLDAX/bEo6n8o9SGB0k8JTfkepQyFg67pCCiqX+2NM3E+L/PVzwcbDkhiECYIqkpdErouRrJvFVxAPgTA0XfR/xTyT4NtHRu2RmBWLnHXNvsaYjHYXlxthpiUvWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stNqNdfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7D4C4CED2;
	Mon, 27 Jan 2025 21:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014580;
	bh=/41i0uJf0GZRP+uRcr/ydEYhb2JNlo6cmnx7qlw5Y4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=stNqNdfRA1MP2MA43yfmJlCo9/+FK5UyNHSWQm0cQG0PPN/CtDvUkb85J2pct79Dr
	 IyYIcyCv52mwVdbjeT77p4WLfxMvgtkIr7NCDJBXw+5aHuwXOzOFhb8eg8rTSlIo0/
	 tkrll3bOrtN0OgVwEodDkmGZdI/IkhQ2khqyDeVl9BpnDa5ODNYyh3rNxWR0vSItTk
	 daZ1XvhXwhHpf++28fgIY/NltPrTQKW3EleibvrsOZj+Euge0Dlz9Xj1D9sXoCPalZ
	 tH5o2dcE6P94RefP1ZhbXZJTHCz5DwJi305bspTLjGflnYkyjpEXEl16whvr3h3qeI
	 Iub+/P1PNVhdA==
Date: Mon, 27 Jan 2025 13:49:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, George Zhang
 <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King
 <acking@vmware.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/6] vsock: Transport reassignment and error
 handling issues
Message-ID: <20250127134939.78613534@kernel.org>
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 15:44:01 +0100 Michal Luczaj wrote:
> Series deals with two issues:
> - socket reference count imbalance due to an unforgiving transport release
>   (triggered by transport reassignment);
> - unintentional API feature, a failing connect() making the socket
>   impossible to use for any subsequent connect() attempts.

Looks like the merge window merges made this series no longer apply.
Could you rebase & repost?
-- 
pw-bot: cr

