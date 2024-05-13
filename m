Return-Path: <netdev+bounces-96068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BAF8C433B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E468628236D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B43153BE8;
	Mon, 13 May 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWkT38Pt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF07152180;
	Mon, 13 May 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610358; cv=none; b=jP83H1NpQMH/3NAb8DuaP0PFynQS8v/MaX4kpOhng0BNmhV4XBn2zX7YnK8XkTfvmqXCyRELpf9r3capyEsGnXeQuUUpqjMADJis08pRqdBW6T1IT5BlkkD/MIRxp1YO2FQfQh9M8AZaMCodNRX3RT9TmEyasf+9aE7GFSSRjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610358; c=relaxed/simple;
	bh=Z0soZAvJTumXWH5oqtMOt5hbcby8BsPnK3uvg1K3qWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhL2opayRf1rIvieqVNOkVjBisiUxcvF7hpMkYorLL8NUrK98qQDhgwnaHGmWKFUfehfu2EUvEh/H+x4QTaDnFNnp2DoxTPq0DsJ+uqaNCFJ+Lm2/avWW2UjJDhZbppwQWwUxo2/arfROqH3ei8qmee0m38rpM/sm1Nfdrgmx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWkT38Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1849C113CC;
	Mon, 13 May 2024 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715610358;
	bh=Z0soZAvJTumXWH5oqtMOt5hbcby8BsPnK3uvg1K3qWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TWkT38PtpcuL9Yc4GgENz80mTgbNv03+YIHJIlSV04+L6M+GFl+CnwJ9/rQ8dI9zi
	 apItoISrU9wvpHMgOpAVdklvtyiOUJx7CgujjbS5jOr8E5NwP2pn/EVdjTXTTIfHqa
	 OiWLfBCHAVZhAGpEuQenXZubonu20NLbsx996j/5GqPHVYcOwbK3eP5Cjz+YjqC0/v
	 WmxYWosqAzLhyAQnKu40in4Xs5S+tcNmoQLlfRFd+5skNJ0+swwvx1HtZ9NtaAZqzW
	 8l2qYPCRzNZYz1ScyYpFMYuh2kRNYzNd5gxZ6s+FuGE0GJ7p9N38xkJvlb1cZCl5QO
	 Uspxdh+mInhEQ==
Date: Mon, 13 May 2024 07:25:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syoshida@redhat.com,
 syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <20240513072556.278df9f4@kernel.org>
In-Reply-To: <Zj9QRIjGLbVdd7MX@zeus>
References: <20240509113036.362290-1-ryasuoka@redhat.com>
	<20240510190613.72838bf0@kernel.org>
	<Zj9QRIjGLbVdd7MX@zeus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 May 2024 20:02:28 +0900 Ryosuke Yasuoka wrote:
> Sorry I don't get it. Do you mean I just insert
> BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE) or insert this and
> clean up the code duplication like this? (It is just a draft. I just
> share what I mean.) I can avoid to call nci_valid_size() repeatedly
> inside the switch statement.
> 
> static void nci_rx_work(struct work_struct *work)
> {
> ...
> 		if (!skb->len) {
> 			kfree_skb(skb);
> 			kcov_remote_stop();
> 			break;
> 		}
> 
> 		BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE);
> 		unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
> 
> 		if (!nci_valid_size(skb, hdr_size)) {
> 			kfree_skb(skb);
> 			continue;
> 		}
> 
> 		/* Process frame */
> 		switch (nci_mt(skb->data)) {
> 		case NCI_MT_RSP_PKT:
> 			nci_rsp_packet(ndev, skb);
> 			break;
> 
> 		case NCI_MT_NTF_PKT:
> 			nci_ntf_packet(ndev, skb);
> 			break;

Yes, that's what I meant. I'd probably merge the nci_valid_size()
check with the !skb->len check, too.

