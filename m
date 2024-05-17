Return-Path: <netdev+bounces-96833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040BA8C7FF2
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B040E282F96
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C958F54;
	Fri, 17 May 2024 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7xex74P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADD8BEA;
	Fri, 17 May 2024 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913429; cv=none; b=Tzu/bVxUmFzCtdmqkiwuCVX3QLGhTJMGwk1oQt4CM2gKY4h4HzeFrnqERdb0iRGreCcPiquTEcgbEdZRFTd4RXx+aPwI2r5TKGTcGp7G+syA5hkAJ4IhnuCRRBP8ZPfnTdEt+gE/Qg6Dk/7QA9etJTupG2XseVt0vHWKPfDN490=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913429; c=relaxed/simple;
	bh=vK6hDEZj6iw56d+EQlyUthdBpd/wO6dYjpHajJrlOns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1uybVqfAG73MYqQlyITSdLjMQOWiHGQCI0MmQdEKCTx9p/xSaTYFk8sAxpkV2gCN5gcz7SOEhQxKitwuhZLtVoyomjU6TekI6TSohRJoDiMV8yqCzJL0gdQjyPBjpiAoq54fnji/LT0r4JeSIvh95thTFh0LISBhrywOaT9Nys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7xex74P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB0BC113CC;
	Fri, 17 May 2024 02:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715913428;
	bh=vK6hDEZj6iw56d+EQlyUthdBpd/wO6dYjpHajJrlOns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O7xex74Pnf+wd1PKZW5ptyd9v1xDWGMwCTRYYlZJ/Op33bcy/GD9XbvBOelyZr3/v
	 UTDixV625kRJV/rGW+G1jH/8iQ5MmooVbGnncQGhysFKL/L+VPR0DC8iZGIV3p205h
	 rkYs5c6c4fnTWf8+wjVX1mY5N6+O0BB0qgsc6jAGpP6Qi8UQd6HPzVwwy2wUijIyP4
	 GBdWBQVsozeg0wNRjdNYFYQmFjyNtHFhEZRYwyv00B1fn3eewduowtkcteVG7ih4Xi
	 LBYMMmgwLLr7HqAwfsu2Xo7tfuzYN3kfr6M50Qs3NqbPpeqJQU3kXoml+NOHdJ6JNH
	 B3VtYF7d0jhAA==
Date: Thu, 16 May 2024 19:37:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, Jeongjun Park
 <aha310510@gmail.com>, Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 "David S . Miller" <davem@davemloft.net>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: always initialize seqpacket_allow
Message-ID: <20240516193707.676ed88f@kernel.org>
In-Reply-To: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
References: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 May 2024 11:05:43 -0400 Michael S. Tsirkin wrote:
> There are two issues around seqpacket_allow:
> 1. seqpacket_allow is not initialized when socket is
>    created. Thus if features are never set, it will be
>    read uninitialized.
> 2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
>    then seqpacket_allow will not be cleared appropriately
>    (existing apps I know about don't usually do this but
>     it's legal and there's no way to be sure no one relies
>     on this).

Acked-by: Jakub Kicinski <kuba@kernel.org>
-- 
pw-bot: nap

