Return-Path: <netdev+bounces-204742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D6EAFBF34
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2ED617DEC2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321B288A0;
	Tue,  8 Jul 2025 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfd/Z+0r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2311712;
	Tue,  8 Jul 2025 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751934551; cv=none; b=YGQySIDH2g9ZU0DNtMQelUfvpUTbxzvI9Q31K3hPQVVwF9TZt8Bm6zvhWKT8vJFOBoG67o2l1/JvdqVjhkyhytOEbE+PmwFyvMc2CXOgp5iATrN7dKUHlX/7L7u0aQNPBHMZPPQPO2tB+8RzU8Uel4L197nlqiHxdzkX0X8S6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751934551; c=relaxed/simple;
	bh=BzxUxFNNccp1yP6kh/RH3mA091YWynlqE3j8zqZne54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAW5xTxpj5tRDmAaz7P6+N4DNmIHAa0wu1zb9rNyKSA1wIr2V2pv6kvPnirS61Dv+36MwiaV0VwV06etpKQD2w6PS0Uea/TKl56rPqLMhJiMEARYtvRa/mqCfXtIHQrfUz7fhq7Ye2bmcM40FEO70LqlJYFibvfNCU4WVDNyD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfd/Z+0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7E4C4CEE3;
	Tue,  8 Jul 2025 00:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751934550;
	bh=BzxUxFNNccp1yP6kh/RH3mA091YWynlqE3j8zqZne54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfd/Z+0rtwc6Lq5fng+SR2wMiKFa4ttcQe0qK8ZUlXDzuUgqF2X0pkN8VokuuA1JL
	 Wi/mRqcjue0TaqHqaVaq+AX4+7BeLYzHenGl64shIhjy/+ByhnAjwfPhR5allPClgm
	 VS6V8LnoBXlt8BtztcrUzLyRfIIdudMABnZRSQYzKOeiQL0YSp93LneA95zXsIculs
	 RG7kQnv2bPPiooJ+isgktVkaq9qwfFiEfZbBbmhpMLDD8ONx7C0lY+1r/5lHImhbD+
	 JV1g+WxZQBXR0ESMFDS4l/KbZMjptmWVGYA2BIbsD9r+yB9zl3Y/6taYe8L8c3MFdG
	 DRai9YrzDpdEQ==
Date: Mon, 7 Jul 2025 17:29:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize
 error reporting
Message-ID: <20250707172909.49d40a92@kernel.org>
In-Reply-To: <c7eb3517-2fc3-4d91-8fa3-e5c870acece1@redhat.com>
References: <20250521092236.661410-1-lvivier@redhat.com>
	<7974cae6-d4d9-41cc-bc71-ffbc9ce6e593@redhat.com>
	<20250703053042-mutt-send-email-mst@kernel.org>
	<c7eb3517-2fc3-4d91-8fa3-e5c870acece1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 11:34:55 +0200 Paolo Abeni wrote:
> On 7/3/25 11:31 AM, Michael S. Tsirkin wrote:
> > On Wed, May 28, 2025 at 08:24:32AM +0200, Paolo Abeni wrote:  
> >> @Michael: it's not clear to me if you prefer take this series via your
> >> tree or if it should go via net. Please LMK, thanks!
> > 
> > I take it back: given I am still not fully operational, I'd like it
> > to be merged through net please. Does it have to be resubmitted for
> > this?
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>  
> 
> I just resurrected the series in PW, so no need to repost it.

This was merged by Paolo as b0727b0ccd907a in net/main.

No reply from pw-bot I presume because patchwork is aggressively
marking this series as Archived before the bot can get to it.

