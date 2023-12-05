Return-Path: <netdev+bounces-54011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38389805986
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C341C20FE2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8063DD0;
	Tue,  5 Dec 2023 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWB9cmCu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62563DC2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 16:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25AEC433C8;
	Tue,  5 Dec 2023 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701792486;
	bh=yv0oFxHwV+zApnuABh1vjm4SdTM4UlVxB9QLNStdBtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lWB9cmCunmEOwdojFPDFdVQRCePUq0w4CIvREKTs/UxizDcp6eOe7xG53EMI2CDGJ
	 8mzqRcoCi0ml06/ZgOzCerEja1bQMBSKioUHqDW/j/XgPQX1quiRwB6Kvx2nWS6tLd
	 juIg36W4XFFPkT5kSB4d1r3ML7xxyhqKm7VotPh6pCT8NTY2P06Y0bUgIuGAjB+Vwu
	 onue5IJnQYYNguEWWEGiy+//MlmsXtwqnVpqHI8vKx10Jpz0fmWugRfNm7bRBYiU38
	 fz6p/S0tgPTY5xnVU/DVlsFQWH3t0HJbNxQXNp6FtThH+EZD7LAqCjBSwBcuZc37uk
	 54Pd0PBcyKK6w==
Message-ID: <73b28f6e-e6de-41a8-8622-3d58832e1582@kernel.org>
Date: Tue, 5 Dec 2023 09:08:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 2/2] tcp: reorganize tcp_sock fast path
 variables
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
References: <20231204201232.520025-1-lixiaoyan@google.com>
 <20231204201232.520025-3-lixiaoyan@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231204201232.520025-3-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/23 1:12 PM, Coco Li wrote:
> The variables are organized according in the following way:
> 
> - TX read-mostly hotpath cache lines
> - TXRX read-mostly hotpath cache lines
> - RX read-mostly hotpath cache lines
> - TX read-write hotpath cache line
> - TXRX read-write hotpath cache line
> - RX read-write hotpath cache line
> 
> Fastpath cachelines end after rcvq_space.
> 
> Cache line boundaries are enforced only between read-mostly and
> read-write. That is, if read-mostly tx cachelines bleed into
> read-mostly txrx cachelines, we do not care. We care about the
> boundaries between read and write cachelines because we want
> to prevent false sharing.
> 
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 8
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> ---
>  include/linux/tcp.h | 248 ++++++++++++++++++++++++--------------------
>  net/ipv4/tcp.c      |  93 +++++++++++++++++
>  2 files changed, 227 insertions(+), 114 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


