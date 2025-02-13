Return-Path: <netdev+bounces-165794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B9A33681
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB33A4A43
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD7204F6C;
	Thu, 13 Feb 2025 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpvGkPoa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CE1EA84
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419374; cv=none; b=bUdrtOR35+Qi8R6uxjp26MWKRrGip9ZjbKPQjhTx6Bd8gtQadzjNt4DdvhqUhBywGn/dialv1679xjHcRVqQIca/mOk85FZeDMU/RMB6/QKWFna/Cy6aSIMeYMc+jcL+lOXBQ1nEVa9eAveocnDVJ6u60fubyvaKStsQKO4aHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419374; c=relaxed/simple;
	bh=9rRXEi2v0VIFD6ZpN+qZPMjw7SCcwViZNoY80B5PzJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWBn/3mSoP3KGzw2Bkg+4r0kOFqDDn4sQc0OH/EkUlDdi7+Lpd49mwmKl37Ka5cok/fnNKEGvekQH1vCXyFsYey2/bPnIYSOEyCxkyvpjtB1bYk9goZFnmE8UL+muaxov1hlG3EXjYVw8Qkrd1EVM3PEq1XjGnH6fw2qV+r8wFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpvGkPoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F6FC4CED1;
	Thu, 13 Feb 2025 04:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419374;
	bh=9rRXEi2v0VIFD6ZpN+qZPMjw7SCcwViZNoY80B5PzJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qpvGkPoaRh4nwYObphYPMSnwJc/NPALmV00PoHR/5xGuE65pHYUugdhF9kTld0yak
	 GR66gITRQ5i1420NSqsLX6mAnxDgPZmaFVNg2ShjHjNc+LSXfn3MKB9JceRgNawbaC
	 d6ptLEdsN9soaGoN9YmoPZ1Kr8Lp/B/d/2xhsYC+ANfdL7IK7WFhv57k4tcpsC6Fg/
	 d49PY+nF1kLX6Zf44NDp4hkWRbNSPmLlZHGU0WZ6+zEzhAVySDcEap1TR1v3RJ7upX
	 A3EoxITWyO+ayPrCVAG9fX//91ZRWqmWmYarBeShtemnl/ZejauCaQzOCZPAFbMsBS
	 FvDQyjLxaiQEA==
Date: Wed, 12 Feb 2025 20:02:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, Luigi Leonardi
 <leonardi@redhat.com>
Subject: Re: [PATCH net v3 0/2] vsock: null-ptr-deref when SO_LINGER enabled
Message-ID: <20250212200253.4a34cdab@kernel.org>
In-Reply-To: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
References: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 13:14:59 +0100 Michal Luczaj wrote:
> Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").

I don't think it's a good idea to put Fixes tags into the cover letters.
Not sure what purpose it'd serve.

