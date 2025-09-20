Return-Path: <netdev+bounces-224950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A370AB8BB25
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699395A1BE5
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A031EDA0F;
	Sat, 20 Sep 2025 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTxqnvQ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0A158874
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758328659; cv=none; b=N7ESBK078FPb9gk2T5Aa+qeRNfhHJzzRhZbHWkyOv+dwf2TwLbk3zDOHJvuRkZkLT/efwgwtx4obH7GwuV4PErY4mOL5B69JBoYvS2eIfEG+Z84yCfwkTooq5r5/9MTHFZSwQIqYcSQA1W7XYn2j50QSRKcb6y+mUOSnIcjcF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758328659; c=relaxed/simple;
	bh=ZiWkPv+VURYH/4lW7QoZWZh3Q2CDdvjkrRtnxxWqmPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jx5SWa3ga6xAxlWEYgB5+sGJ5ELvFWjkOqmgjMoAkPVRKgLIR+4Zil8islW0+tKHgnGsMENQSa9a0WbrOEL44NETiiqVmezH+L3QyWN6JSUuy9V73JmQTqxurBDoM2XvDumEV0QvtLvbCvSjdaWtnaEEYCstoV5gL8MXKGgwjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTxqnvQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A406C4CEF0;
	Sat, 20 Sep 2025 00:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758328658;
	bh=ZiWkPv+VURYH/4lW7QoZWZh3Q2CDdvjkrRtnxxWqmPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pTxqnvQ4Bmq4PYJ0lCaAtN3Z/ZM+XbneBYN9pqvQ73zxFFdndwUeTCijFMhXOBUSv
	 TpuTGldYiSnN0vvSZM+ckdW5A8h71miDGGezj4IfWDUSq3YzzPp53mPjh8rOw/iXAR
	 sLHClzjoTz8/BpZDSD8HwhIT1s4RKkr6Bjj0bc7xlp3Jt1mcEfNHIR7YuI1U2dXBMc
	 WMtMOCCToc2QLL4ehvesSn/vEBhn1HA67CCidALybDf8el19+JpU9NmJ/opnleAyw2
	 P67FX7C90Fr/BhccGl+QiiRI3ENLYv94xSW8B5TIZ4LJvFLS7DOSbfy8ZG8DudgDHQ
	 MQpZiVjNnHmPw==
Date: Fri, 19 Sep 2025 17:37:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: ipv4: use the right type for drop
 reasons in ip_rcv_finish_core
Message-ID: <20250919173737.7f7ce0ec@kernel.org>
In-Reply-To: <20250918083127.41147-4-atenart@kernel.org>
References: <20250918083127.41147-1-atenart@kernel.org>
	<20250918083127.41147-4-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 10:31:16 +0200 Antoine Tenart wrote:
> -		if (unlikely(drop_reason))
> +		if (unlikely(drop_reason != SKB_NOT_DROPPED_YET))

drop_reason of none / "don't drop" is very intentionally 0 so that we
don't have to make silly comparisons of this sort. I'm applying your v1,
sorry for not paying attention earlier.

