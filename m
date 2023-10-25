Return-Path: <netdev+bounces-44305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA07D7851
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D59281DF3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0330FBF;
	Wed, 25 Oct 2023 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6ez/MWU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871027EFF
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D846FC433C7;
	Wed, 25 Oct 2023 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698274881;
	bh=dc5OzQz+3yxkmid1gjdqhpVIA5I2I5TEFAH86dL3QZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c6ez/MWUfpAiKfo3ZGJMo5zniaczG0O0Npl3CJMX0+l57WeLZ0W3jJs1g6vfXwJU8
	 BCTfS8ZAUmaZ2Obj0AKp6Vl1fVoaBDYgbeuxjSsjBhoNe5pzZTnjyDgCmsusA2pZXs
	 FFNxq91UHUWPF6CAvh7kmDcigjDShXeIpLFmvWD57R7n5+qlIyJsfE6VLF8oQAoL3Q
	 b0qU8IqZG3aR4TP36XaUZyvFp28fOIbruSbe/ddRPFa463p2rY6iGgQiMcfXPVeYAm
	 QOrghIw3bBPxkaSUwSimyt96mYMGMZUs1OLOUYTirySYiN2YqPZT8rypXJM1Rj6JSk
	 T1Ad6t/wmQW8Q==
Date: Wed, 25 Oct 2023 16:01:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Willem de Bruijn <willemb@google.com>,
 syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
Subject: Re: [PATCH net] llc: verify mac len before reading mac header
Message-ID: <20231025160119.13d0a8c2@kernel.org>
In-Reply-To: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
References: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 15:49:36 -0400 Willem de Bruijn wrote:
> @@ -153,6 +153,9 @@ int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
>  	int rc = 1;
>  	u32 data_size;
>  
> +	if (skb->mac_len < ETH_HLEN)
> +		return 0;

I think this one may want 1 to indicate error, technically. No?

