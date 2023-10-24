Return-Path: <netdev+bounces-44036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC5F7D5E7A
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62E71C20C65
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2273F3CD04;
	Tue, 24 Oct 2023 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAp+yNek"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065752D61B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B7CC433C8;
	Tue, 24 Oct 2023 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698187827;
	bh=W3TPVz7rLd21JGqEPDAEJs+jKvIGpkLC6u9flcWdrmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fAp+yNek/tC+JdWYlmvH/5g86wZcQSQFRg4j7udVvB1IwYPAbMpOWi558XtTLbsml
	 aEQ1ZSXKzrzaYiYOKkLEM+kZ1QTtctQzBPiJ6PcqYqbbe9UZlYzqfkcZDC5zhRTSDK
	 /O+zk53eUCShShkk12bihyzsrCnhpcwpjFBTITpyn1+8Db05b8lb0gcLw8PoqM4Et9
	 Wu+6rZmgN+J5vMrzkF5JWYmLX4qPhIeb40/GZl/d8Iv9gL5fQf+VvHywDENe/OgmWA
	 CZOd0cvkrrR/2njFeVwl0eIBgrjbPuAUU8nl+0vuvtj8iTiU1a8o8lBfMqukwDAU3U
	 UGiRL5vQg5Lgw==
Date: Tue, 24 Oct 2023 15:50:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v6 09/10] netdev-genl: spec: Add PID in netdev
 netlink YAML spec
Message-ID: <20231024155026.3deb3ed7@kernel.org>
In-Reply-To: <169811124667.59034.10304395300563829113.stgit@anambiarhost.jf.intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
	<169811124667.59034.10304395300563829113.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 18:34:06 -0700 Amritha Nambiar wrote:
> +        name: pid
> +        doc: PID of the napi thread

PID of the NAPI thread, if NAPI is configured to operate in threaded
mode. If NAPI is not in threaded mode (i.e. uses normal softirq context)
the attribute will be absent.

> +        type: s32

Hm. PIDs can't be negative, right? I'm guessing POSIX defines pid_t 
as signed to store errors. We can make this u32.

