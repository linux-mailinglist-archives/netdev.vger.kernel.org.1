Return-Path: <netdev+bounces-279869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGY5OS1n5mmlvwEAu9opvQ
	(envelope-from <netdev+bounces-279869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:49:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAAF432244
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACB9B301A3E4
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 16:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8334B19A;
	Mon, 20 Apr 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhHhWNK1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E7341ADF;
	Mon, 20 Apr 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702372; cv=none; b=Xf2kLBZrSSXbMeOMb5czMtlSnC1WjycEt8L9yqUc9MszlYYkEp8pGQMVpUafZnT6CnRYTB8fnP+sKZa+wlNAyryWTrQy943xOutk1yjHhf0A7fTpJJ6AXQuA717M4N8gCwRSgmPdtH1dGPnMmejJvDh+41Dbm9hUR6sS04JceGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702372; c=relaxed/simple;
	bh=8TBBzd4psxVantp6vJky0hd1cE0JzmC/OkNgHSc7h3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9JiKjZS6KaCs2bY/A+r5+GbtonEJ3qmpGIQWBj+2u8/Q9OMQXRWNCOzGvNam89Skut8awWBLm412xK9tYGWfaqJRL0GiqTopgQ4gshuFjrklksfq8grai+8+iHGXQdkAL056wargaTnlGnx6wSLRgGyIPqeJh6psqeEIXFo+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhHhWNK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65939C19425;
	Mon, 20 Apr 2026 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702372;
	bh=8TBBzd4psxVantp6vJky0hd1cE0JzmC/OkNgHSc7h3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhHhWNK17NbXRtEYL0MtVmVmvG2WDmHxMoDQM6w9Ymk2NSohHlUXwXF/LKArB9KJK
	 oyvQCXfP1JtlS32ve7SWCIu2getR8+NDhWry91zMDD+HJeop4nW1/z3dx8mHSN+ql5
	 QVvP5eEC07X+oH1X8gPrptIirATS4E/Nfre4S0d3RO6u7RMXSwzIvXKLaUcat/2y5q
	 5kl5O6UpFXiCj8EssJXZawdtq3be2k9+7JYXrPQH+1MV0xROA/1BL/dWUL18wRu2cD
	 +DelkLVSWPE0azL3hNlYAyyp95c0xGha/3W7M5W5Ao6sibqzkQDd2YSWf8sqWF1LrY
	 KjfNiCtGoTYzw==
Date: Mon, 20 Apr 2026 17:26:05 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kees@kernel.org, takamitz@amazon.co.jp, kuniyu@google.com,
	jiayuan.chen@shopee.com, mingo@kernel.org, stanksal@purdue.edu,
	jlayton@kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, yuantan098@gmail.com, tonanli66@gmail.com
Subject: Re: [PATCH net 1/1] net/rose: hold listener socket during call
 request handling
Message-ID: <20260420162605.GV280379@horms.kernel.org>
References: <cover.1776327338.git.tonanli66@gmail.com>
 <52776256bf0fc38de92fe3edf39434538b672b69.1776327338.git.tonanli66@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52776256bf0fc38de92fe3edf39434538b672b69.1776327338.git.tonanli66@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,amazon.co.jp,shopee.com,purdue.edu,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-279869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: ECAAF432244
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 07:01:51PM +0800, Ren Wei wrote:
> From: Nan Li <tonanli66@gmail.com>
> 
> The call request receive path keeps using the listener socket after the
> lookup lock has been dropped. Keep the listener alive across the
> remaining validation and child socket setup by taking a reference in the
> lookup path and releasing it once request handling is finished.
> 
> This makes listener lifetime handling explicit and avoids races with
> concurrent socket teardown.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/rose/af_rose.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>

Sachiko has provided some feedback on this patch.
I do not believe they relate to shortcomings in this patch,
and I do not believe they should block progress of this patch.
You may want to look over them for areas to investigate as follow-up
(maybe you already did :)

...

