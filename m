Return-Path: <netdev+bounces-95648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839148C2ECC
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7612839FB
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3355912E5B;
	Sat, 11 May 2024 02:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqcoFL+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25A611E;
	Sat, 11 May 2024 02:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393175; cv=none; b=In/f5R0amzYFbYPDO7chtGpbuHQuokmsv+b5cNvT+KLijUrqV6Nlgh0vCeuMvq/YcaWV6fYqrS1bGonuTlzUH4FhqnOQIBi51++lRKYa18DUyxpRljlnyR1edwvpzXo6qnYze8zDnCjWSAB+aLEF9gBUL2uMzlGYwAeWV3Rqyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393175; c=relaxed/simple;
	bh=gaEDpwoRE7YrdemX74x+O4RlWvRr7swVJqWOPuQ0nT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bl2MRLCHiwB4ot830jLbev1tA17n/kg0PblLELZdTl9COGzOinAqaN57dTZa9iB/k/8Yq0aei6Sk704DqJoYLs6+lW7RXohs2SsaVm5wlf1etEo4DQxiYsSSYs5zke9I3g6Y2djs01vuX3PTONRrTxpIDUTBwxFGmvYZwxw4NYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqcoFL+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7261BC113CC;
	Sat, 11 May 2024 02:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715393174;
	bh=gaEDpwoRE7YrdemX74x+O4RlWvRr7swVJqWOPuQ0nT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pqcoFL+VlKHWtHKexREWKscbXMsEeMhNILBdmQpilhFisDh/qohXX6qiONHa1J7mA
	 SgXrRID1wzxYfm+QHMEPrb4L3cjwpdN3b+JHgohd7zM0wHDzSsNTLbFpsC/lk+UowK
	 2M+taJPNhTHs1P10EV4KU9IMokGC/bYW6jPluoWhPvjZxrPYtK9t/fmBg89ARb3TvB
	 zErwqvymfCLNLs+mhg/6f2dPS0B0m7DimG2QZB9ckae3X4P8S+yIWlWtdNxEV9U1jq
	 B3RN4tuQ2Fs2VGKbogX6eZxBvTm8jkuj/QOO3JQQvnVFTa3+go8ktAEKPG0a3qc96B
	 Vd+knz5bIfntg==
Date: Fri, 10 May 2024 19:06:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syoshida@redhat.com,
 syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <20240510190613.72838bf0@kernel.org>
In-Reply-To: <20240509113036.362290-1-ryasuoka@redhat.com>
References: <20240509113036.362290-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 May 2024 20:30:33 +0900 Ryosuke Yasuoka wrote:
> -		if (!nci_plen(skb->data)) {
> +		if (!skb->len) {
>  			kfree_skb(skb);
> -			kcov_remote_stop();
> -			break;
> +			continue;

the change from break to continue looks unrelated

>  		}

> -			nci_ntf_packet(ndev, skb);
> +			if (nci_valid_size(skb, NCI_CTRL_HDR_SIZE))

> +			if (nci_valid_size(skb, NCI_DATA_HDR_SIZE))


#define NCI_CTRL_HDR_SIZE                                       3
#define NCI_DATA_HDR_SIZE                                       3

you can add a BUILD_BUG_ON(NCI_CTRL_HDR_SIZE == NCI_DATA_HDR_SIZE)
and save all the code duplication.

