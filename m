Return-Path: <netdev+bounces-71135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F16852700
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D86B22176
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399418BFC;
	Tue, 13 Feb 2024 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbtxQSAI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603D816
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787384; cv=none; b=bRBl0Rlmu7RTfItKMX4feHtzX3hruFRPYAvGFQ436EXWoX0XRwjM/Tlf2BBjGGlacp3koRb7fuxadnzVsr+lsUAbuiShLEeGDkIOiLS85qvMrAntFgF2nF3ukUbxsOQIu+6zWZ28gy50v8CmW1DL9DxNA1fOghZp+UPUMfQIgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787384; c=relaxed/simple;
	bh=VGFiFeB/+xr0C82KEEv2S9smOp4yzSHsj8o60hLHOFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3npQe6gn0IoyzFkiz6Anvqk0aEr813uO1TGpwpTp4FrbaZPacZbnRhchRa6lACUaNx4mSE5b8cYwzTj01tEqLfaAlFxedKAkfqwWzHENOJ5xf5UryMkNML7PaJ56qL/+LoxaKEL61vYZKd/1eTM4b4zvl0wjwMRcFQh9i2zG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbtxQSAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0F2C433F1;
	Tue, 13 Feb 2024 01:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707787383;
	bh=VGFiFeB/+xr0C82KEEv2S9smOp4yzSHsj8o60hLHOFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QbtxQSAI5jnNCjImWLEzUDObTLO8BT9QUZ/Cq3vwWdIlGFhXEzl1QqujIafZ8UtfM
	 hlvlpUrIXvpU885XMbSaSuT/VM/cCiF1wUyBoZo6nimybzQngyakDQHEDyxnh0NGqE
	 qbO5JqwEg6kjhfJcZgkXbfMUfTpNucSeYQB+Eh/5jY8DPKsvy45hMNybp8aZ9PkibD
	 kmQcc8zUjkUVfiP5cotRGwZ9MOX/KiOuX3XVM4buBR6hCFLf6ZBhS4p60C5rGwe19M
	 F05M+fJ7Q+YAK+i6OUR6tieccppoQR4QBd4m1O+sFfaiRH4okBcJGnb0vcXtlhAkDo
	 we/heTYyqJKlw==
Date: Mon, 12 Feb 2024 17:23:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 1/5] tcp: add dropreasons definitions and
 prepare for cookie check
Message-ID: <20240212172302.3f95e454@kernel.org>
In-Reply-To: <20240212052513.37914-2-kerneljasonxing@gmail.com>
References: <20240212052513.37914-1-kerneljasonxing@gmail.com>
	<20240212052513.37914-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 13:25:09 +0800 Jason Xing wrote:
> +	/** @SKB_DROP_REASON_INVALIDDST: look-up dst entry error */
> +	SKB_DROP_REASON_INVALID_DST,

The name is misspelled in kdoc.
-- 
pw-bot: cr

