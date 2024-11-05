Return-Path: <netdev+bounces-141772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBAB9BC351
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41291C212AE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE5225A8;
	Tue,  5 Nov 2024 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClxqZHrl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA615A957;
	Tue,  5 Nov 2024 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730774803; cv=none; b=q+rYO4sxt6GF8WojVs9Vev1nWnrZwWZ6Nll6p8D490pYQw7fEC/Y8dc8aCN1Gm5tRhIalMFJx3lmqq6G2VzN2+hwm6k9R0qCh7D2eVUMusqM+McKJQxNZFtmkvk/HYHpgjn3M/7EvifzfZ/rAM2JDsOCDWXtTBDiuKqGvc3Yn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730774803; c=relaxed/simple;
	bh=garE5ScBG/oQypGHEXwdXZbuNsKVUktLBX7i7tPlCpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0zv5SPp1lsb8OQWdMuvC81XWpIixUUc3kSh1iF6c+ZajbiYpsjl8y7QUkjEbzmMTPCfnHNMZccgFKHrxvhN9I5MN+LyxzmWEi+vQo29u2twxR7AWdKx7zrTXORMT3tzKdnkSa1pWpQy6lBW6vPquOKt7A8KQjMegp1tjHlgp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClxqZHrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C50BC4CED1;
	Tue,  5 Nov 2024 02:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730774803;
	bh=garE5ScBG/oQypGHEXwdXZbuNsKVUktLBX7i7tPlCpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ClxqZHrlPFog8jpemI4deI6s4Nmy6Yck7X4W5YGkuLnIMdiN2l4D+/g/tKDR+/9mc
	 1/h+C9sOlECsmV62DiEJnoLMLCj7ZQdTVnAtgNE7k4/Lu3jSz6q/0YA0tq8r5ro7te
	 WMblJnmW2yvKOeIU/6v6Hq0deICcHJuXlMnjyHC3ndcO1vjqF7ZDp07cfMCASiqbhF
	 MVaOydKeXkP16Mwti3NCqDIvc4gCyYc8iLtoEVAV3xRwkrEeuTU1IC9P6oGuG13ozu
	 YyelH4MqZSd1jHHLJznWz93i7Zolcm14Tw6ESPAPaLFVdTB8pRidWmiLYecN3KyMbL
	 mkgDW+6ntdAxw==
Date: Mon, 4 Nov 2024 18:46:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by
 default
Message-ID: <20241104184641.525f8cdf@kernel.org>
In-Reply-To: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 16:46:11 +0800 Xuan Zhuo wrote:
> In the last linux version, we disabled this feature to fix the
> regress[1].
> 
> The patch set is try to fix the problem and re-enable it.
> 
> More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com

Sorry to ping, Michael, Jason we're waiting to hear from you on 
this one.

