Return-Path: <netdev+bounces-127157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B9974658
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A191C25418
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9111AAE27;
	Tue, 10 Sep 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxCiXiAa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F6E17E8EA
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010719; cv=none; b=Zsgqm4dLqnElHmS1Orr9I3QtVbocauhuzPe3zAk4OzO/qokslWb8LUPfzkAacWrNQpN9vhROcHLuTtEHfRz4skLbQGUwzMOL4cxABUrZTEwkxZtgXen6Xt4mwYoGI8Oxm4KHkGnbGZiTpVxEoP4WrCDlc7dLMsAFsiESD1xfnQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010719; c=relaxed/simple;
	bh=gR8uWyV+f+ZkUkVX4E42pi0F44CyRXoVLVMmMtpnGnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+UEfspri6hXldRVod/uUj/Qo8pb+ABnmrbjBrnTzliRmRarmLB52fp9ZFQpoLXMxoFBNS9BLaWpOfuYaqUzULsvbj1EwJNiWMGHkJgbVxeub7oP4Z1fd8E9ZI4EZT93xNIJP8+IUTQUe/kizxgxEHktKmx9l1FvcQpKkBam6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxCiXiAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C4CC4CEC3;
	Tue, 10 Sep 2024 23:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726010719;
	bh=gR8uWyV+f+ZkUkVX4E42pi0F44CyRXoVLVMmMtpnGnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JxCiXiAabeycd5lXNVOtGtl8riD4NCcuVCfEVSV6k5TbplbVh+ly2hLtwL1RsEq3R
	 AB/5A5i/PqxG9fX+RUg1eK6zhSuntD7yYzmNAbcfGFqbWdYT3jVmD5+azUOqwNtVX0
	 2WMPQ1vU9Bh/bdGqogsbfXhXEeScfX/w4i5Re3HCRIPcz0CKK/63JRGQl3nIoG3BEw
	 hWuJwM4NTolS9BYb5J4VHttJG4b1ZGxDUQLpUbB3v+zZxv41N8kjnAWJeEjL59WVb5
	 tJopM+aClqu1d0qugg635rT4jLGR6cvTOr3B8OlhRBlAb+DgTo/Vsm2S6rI1M+c0p8
	 Jyztm+imF2N4g==
Date: Tue, 10 Sep 2024 16:25:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>,
 syzbot+3d602af7549af539274e@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] net: hsr: Use the seqnr lock for frames
 received via interlink port.
Message-ID: <20240910162517.2b226a71@kernel.org>
In-Reply-To: <20240909114948.129735b9@wsk>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
	<20240906132816.657485-2-bigeasy@linutronix.de>
	<20240909114948.129735b9@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 11:49:48 +0200 Lukasz Majewski wrote:
> > +	if (port->type == HSR_PT_INTERLINK) {
> > +		spin_lock_bh(&hsr->seqnr_lock);  
> 
> I'm just wondering if this could have impact on offloaded HSR operation.
> 
> I will try to run hsr_redbox.sh test on this patch (with QEMU) and
> share results.

Hi Lukasz, any luck with the testing?

