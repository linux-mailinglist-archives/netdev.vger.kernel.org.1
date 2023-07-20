Return-Path: <netdev+bounces-19333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3199275A4F8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC490281C1F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA361840;
	Thu, 20 Jul 2023 04:08:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285717F4
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1327C433C8;
	Thu, 20 Jul 2023 04:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689826110;
	bh=0selD9EAxs8+ObQeUAlgWi5i698gi448oTA5s+tkNgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvC3fzUK3W75d6yn8lCDqLvabrlG0KE0svRdTT0HxmDW11ncDgfIZMdrwMMIbkwDm
	 3qyPeyerztT4oo7Vp9ncYNPZNhVIG97LEbryb4jS03PuePxdBQs1f6CJ2eQWsxlUYS
	 hlZZ7hNDzDlARZFm3NaYpCNY3MYxvz1fCk1U+kbJ/aKTmZ4+SnASz+f+hxkWQJvRY3
	 vyNmsIf4W57Vf/17205figrrRkN+rBuY8+e+td2uH2FKhXr1oDiHEWv2ujWHxUb52K
	 iw1eaRLrMYE+yAPP50E7gYsXq4KwuaWSjxFqnvlaCqgs9jGkYmEEbk8X3d0Q0PHEFG
	 jAqmayHxrh20g==
Date: Wed, 19 Jul 2023 21:08:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Benc <jbenc@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net] vxlan: calculate correct header length for GPE
Message-ID: <20230719210828.2395436f@kernel.org>
In-Reply-To: <0699747bc9bd7aaf7dc87efd33aa6b95de7d793e.1689677201.git.jbenc@redhat.com>
References: <0699747bc9bd7aaf7dc87efd33aa6b95de7d793e.1689677201.git.jbenc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 12:50:13 +0200 Jiri Benc wrote:
> This causes problems in skb_tunnel_check_pmtu, where incorrect PMTU is
> cached. If the VXLAN-GPE interface has MTU 1464 set (with the underlying
> interface having the usual MTU of 1500), a TCP stream sent over the
> tunnel is first segmented to 1514 byte frames only to be immediatelly
> followed by a resend with 1500 bytes frames, before the other side even
> has a chance to ack them.

Sounds like we are overly conservative, assuming the header will be
larger than it ends up being. But you're saying it leads to oversized,
not undersized packets?

