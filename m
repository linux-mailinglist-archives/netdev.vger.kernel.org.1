Return-Path: <netdev+bounces-186874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6A3AA3B4B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791159A212E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B104D270ECE;
	Tue, 29 Apr 2025 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrFUy+Fl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235426FA42
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965106; cv=none; b=RZARrbFK0OeHvJD1BU/mchhDRF1CCnR3CnVBJ+AB77g5Yr7w9AgvL3gztoMnui7e95ugAZ+4cPQAKAPzcU6dJ04aWe+nPZMyQuUbBWA8fKp1LuRdD9mITDO/nbGUTC07r3BlAROtmSi8s8ZmulMhRhacN/D5QECjcBIFYjuKBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965106; c=relaxed/simple;
	bh=EZKicf62EHgGO/Dl6l5qWuNORwkjnrqrd3wKjaOALs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuxtgXCSCn9pAKlm8zHse/8YhnTQTA9nNgL2WAKaKVJcZrZ8s0vBNJWV7mkS//Rx5TKDZxereZYsiXc5TBjhsKLU+jP4dfJ/WbVTN/JITyuoQZvkZKpRkEzpvErWf2RjqMjxOqDo+qJBjyGMIJ/QtfgqbU/4d0anesGWTPQSwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrFUy+Fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5B4C4CEE3;
	Tue, 29 Apr 2025 22:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745965106;
	bh=EZKicf62EHgGO/Dl6l5qWuNORwkjnrqrd3wKjaOALs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mrFUy+FlVp0wimcMjj3rs0wwnR7WjXk3Vcv2Kv62G1idDcXQAHJVJL422QEIeZwEf
	 HKBAf36A4LYFwyAOetoA754CI8ddat24j1mFIWtvSC9dlwV8OFNvrZtUd/UxACaCjL
	 4meA4er0o/s1yALWMzZi5rGpPqwjYlOBIS64QZ6sCJug2dqQHzEdi/NDBNi+oY1M0d
	 PURv957GPtJpjyWaTUJzL48GotN/gut+ajtpj7aF7iUrpKIkGH+iedvlUvLTIkqxSw
	 IAnAPVoP4VxxhxPFjLxNWN3novQkzQ3SCILk6sV9ciALyXS32M1yNJIuGIo4jxj+11
	 PH2ZDuEORavYg==
Date: Tue, 29 Apr 2025 15:18:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] bnxt_en: add debugfs file for restarting rx
 queues
Message-ID: <20250429151824.6d20ea0c@kernel.org>
In-Reply-To: <20250429000627.1654039-1-dw@davidwei.uk>
References: <20250429000627.1654039-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 17:06:27 -0700 David Wei wrote:
> Add a debugfs file that resets an Rx queue using
> netdev_rx_queue_restart(). Useful for testing and debugging.

I think we need stronger justification to add reset triggers
in debugfs. If you just need this for development please keep
it in your local tree?

