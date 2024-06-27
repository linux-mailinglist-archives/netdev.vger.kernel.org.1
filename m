Return-Path: <netdev+bounces-107467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521CC91B1B6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0A928402F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E6F19ADB1;
	Thu, 27 Jun 2024 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBhZqyD8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89BA3D
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525102; cv=none; b=LUhPktahnFWusjNvRTuD3lpY/eGhi+3b8kfnJ8a3b063/bn3RfLQvExfLwpQ452TGx1Li5BUqvhpa3zwFv8nEW0vXX1TAGKCDQYS0UDgnB2hl8rDxwPorP4b1fdyCLYQjRYb70ge7u/ojrnMRrm+D7ZHfojsZyeWQP1Oppl4BTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525102; c=relaxed/simple;
	bh=JQhrKuvNp4uSS9DMSG1r/8GaDS9vZjIlmk+7lvqNxlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cACQBd11KXtrwqhsd7Miv2tQ2Z4BXX4oZVhiVgTHx9TN1ya7aAGbu+68JJEO0DLA+Cnwmx18NtWC7W+o9hDXarb22fZ7YOLreAmmDbKjDPeHPvnqNGQDETk+FAxTVyIdc6xY9VOL+HAvAjlLsXkb+GQLC6VAe0a8kA+EzG6JMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBhZqyD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6251C2BBFC;
	Thu, 27 Jun 2024 21:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719525102;
	bh=JQhrKuvNp4uSS9DMSG1r/8GaDS9vZjIlmk+7lvqNxlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tBhZqyD87kx5vAVhsQELwx9+UMAjDF5gnaiaCcMagdc8aYWE653v+XCihs2MYxZFF
	 4Qye2cZC/kase2FDdb+Dl/6+radcl8nrbPvD4YSpfL1oYq4445RDZXCI6v9DYtLrAq
	 hzxqWDCBiu4Le1gzlI/907Jvbxw340y8lRDBgLltYj3J6JBsMRgDLxjK7Eez9FgXpa
	 Oq6jPz+QbAL/ierCZ4dMswDKrfA9sV4cIrNWkcbi/UOMMlQQgbx6VBFKdBWnazZ6av
	 sgFzzlba7SdiZA9b92At54X9UzKsDElqaBJqIMyB68EV1EuirTYbMT4jYspXfGRI+L
	 1SQ90Qh6E2gHQ==
Date: Thu, 27 Jun 2024 14:51:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
Subject: Re: [PATCH net-next v6 2/4] sock: support copy cmsg to userspace in
 TX path
Message-ID: <20240627145140.675bbf86@kernel.org>
In-Reply-To: <20240626193403.3854451-3-zijianzhang@bytedance.com>
References: <20240626193403.3854451-1-zijianzhang@bytedance.com>
	<20240626193403.3854451-3-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 19:34:01 +0000 zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Since ____sys_sendmsg creates a kernel copy of msg_control and passes
> that to the callees, put_cmsg will write into this kernel buffer. If
> people want to piggyback some information like timestamps upon returning
> of sendmsg. ____sys_sendmsg will have to copy_to_user to the original buf,
> which is not supported. As a result, users typically have to call recvmsg
> on the ERRMSG_QUEUE of the socket, incurring extra system call overhead.
> 
> This commit supports copying cmsg to userspace in TX path by introducing
> a flag MSG_CMSG_COPY_TO_USER in struct msghdr to guide the copy logic
> upon returning of ___sys_sendmsg.

sparse complains about the annotations:

net/socket.c:2635:30: warning: incorrect type in assignment (different address spaces)
net/socket.c:2635:30:    expected void *msg_control
net/socket.c:2635:30:    got void [noderef] __user *[noderef] __user msg_control
net/socket.c:2629:49: warning: dereference of noderef expression
-- 
pw-bot: cr

