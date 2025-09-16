Return-Path: <netdev+bounces-223782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABFFB7D73F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD7B7B2BC3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CF92D0C69;
	Tue, 16 Sep 2025 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjmbzRB5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506FD2C028D;
	Tue, 16 Sep 2025 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065805; cv=none; b=u19/L4sGPeF7t1DXBoCkHPA8eYOGbqYarITRI8xpdR5R1nWFYurAZ/C41dpfS+IKwaT5AicZUBCpNsLTkiboavGAIsAvBHjvFjw5rnfSiZIimCV1tMn3EXhG/7j1DX3snfC+e8Kil14TAt+K7VWCPosgqtA+Ayp200J4MRh0Dw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065805; c=relaxed/simple;
	bh=SQH5xudHxl/DVG0bkz4UYYwop8WEqzYGuQlIb+6mx58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aj4sJR2qCRf0FjWNFb8GhxVnDEWo+6EakEEopIrgoxyU6W7fBSVTezCAC7CJ4OUhZv6tWtVXt/VFyFFemZACGlOIcQnh1ClDR+gAihB3Af/AiloUF7+DVoWEXyJNEgn4/DmfRx60fzdDCwomuICmvhJcG/guQtMr6hDw5PXpH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjmbzRB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E25CC4CEEB;
	Tue, 16 Sep 2025 23:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758065804;
	bh=SQH5xudHxl/DVG0bkz4UYYwop8WEqzYGuQlIb+6mx58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjmbzRB50Q7JL6CF1eyoNE0rj4gYPB5yEFOSk10mdY7M57hpxU8NALIfOkjV+I/fy
	 vczL+CwiDcD1qE+TgLCJc7zIxvR2rviz77CBSybYsg3YIn81YbF8xcw3SdXfOlTTi+
	 Xwu2SJHtsDm2p8cd3+3WKazJj6hdkTn5MjdPofhe9cAP7kahRVV1d+kwm0RiKmQVag
	 nXocjmEwwpVPHiiK0RslQcumfiAc5US18/gqpKx57M7MiWb9m1dLn2yL4PDUTRD75D
	 6mZ0troJO5kyM0H9ct83sHxAIOEGEo/qK9Tn0R1/usMi4tFRG0zQ0igPn60kPMIvMJ
	 5j5eOb2AMGdpA==
Date: Tue, 16 Sep 2025 16:36:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bbhushan2@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 gakula@marvell.com, sgoutham@marvell.com
Subject: Re: [PATCH net] octeontx2-pf: Fix use-after-free bugs in
 otx2_sync_tstamp()
Message-ID: <20250916163643.36dd866a@kernel.org>
In-Reply-To: <20250915130136.42586-1-duoming@zju.edu.cn>
References: <20250915130136.42586-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 21:01:36 +0800 Duoming Zhou wrote:
> Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
> that the delayed work item is properly canceled before the otx2_ptp is
> deallocated.

Please add info about how the bug was discovered and fix tested, same
as the cnic patch.

