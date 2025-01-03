Return-Path: <netdev+bounces-154856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF4DA00209
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5C218838FA
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 00:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB748BFF;
	Fri,  3 Jan 2025 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtfBtxof"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7C33F7
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735864671; cv=none; b=NVG/4qhVM4jJ9Glb8xFUIhk7rMuFZjj4rXnZrW3n+stn/HR3H7qmg47zAsOl39JkH6lwDPvwIxMrBASNL/EnA+tq7DPyn8cfFEi9k+1M0Dhxhe57Lxh4fU40dhP7zegv+r4IBjUzcEsjeJPYuEZK+d1GhqisttSE3pmd6ECHEjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735864671; c=relaxed/simple;
	bh=oZXSTk0Milvu0aQ3ACzRlhgU0OgNk3giRwVGYSdtquA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx9S0n5IIDuUBgMZbWcT765CUBwMj8fI+363FJdfP1ZTRaT2Wv4w8nI/MZ7cTCnXemcTsB/TnRv34ylv/M2sBSBCqYzZHyqx7ktIcqD27oO6tPMG7RJZpgzFcqZTwTzRip7ytXCw8VM7HTvDkAY7VcUC63sn86whO83auF9G2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtfBtxof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF99C4CED0;
	Fri,  3 Jan 2025 00:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735864670;
	bh=oZXSTk0Milvu0aQ3ACzRlhgU0OgNk3giRwVGYSdtquA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZtfBtxofcLP22xp9Le+3pQvz6y6A1eYl6H9o3Q/pO37yez6dw9/gmHZc+ngCp/SjA
	 riUzPCQVljfGYFIP3NZNwPidW3H78c62bNnuempfyExXyrq/5spVddH7pHD1nKsb8E
	 bz4b0HG/LYAKyz5KKnoCFmSpTPwN1pAa/AAfsauDPB5vuc3w/XL4yuRv0DURrFXVsr
	 jWCMdavqWVh/dNZX9qKhsp6XM08YIRStI8MUJztYP5Ja7xrAkBeQIhrB/nU+EBVvpH
	 Z0a/fjoUnPURJVoDJhCBh9w9FK+edHmr1sQt6Ogt31/Epb0l9v+w7mr5tDG3yiB6vM
	 S+h6yDwSAGVUA==
Date: Thu, 2 Jan 2025 16:37:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <rmk+kernel@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net] net: libwx: fix firmware mailbox abnormal return
Message-ID: <20250102163749.66d047c9@kernel.org>
In-Reply-To: <028a01db5ce1$7f555f60$7e001e20$@trustnetic.com>
References: <20241226031810.1872443-1-jiawenwu@trustnetic.com>
	<20241230181150.3541a364@kernel.org>
	<028a01db5ce1$7f555f60$7e001e20$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 14:42:30 +0800 Jiawen Wu wrote:
> > >  	/* Check command completion */
> > >  	if (status) {
> > >  		wx_dbg(wx, "Command has failed with no status valid.\n");
> > > -
> > > -		buf[0] = rd32(wx, WX_MNG_MBOX);
> > > -		if ((buffer[0] & 0xff) != (~buf[0] >> 24)) {
> > > -			status = -EINVAL;
> > > -			goto rel_out;
> > > -		}
> > > -		if ((buf[0] & 0xff0000) >> 16 == 0x80) {
> > > -			wx_dbg(wx, "It's unknown cmd.\n");
> > > -			status = -EINVAL;
> > > -			goto rel_out;
> > > -		}
> > >
> > > +		wx_dbg(wx, "check: %x %x\n", buffer[0] & 0xff, ~buf[0] >> 24);
> > > +		if ((buffer[0] & 0xff) != (~buf[0] >> 24))
> > > +			goto rel_out;  
> > 
> > Inverse question here, I guess. Why is it only an error for FW not
> > to be ready if cmd doesn't match?  
> 
> It is to check if the cmd has been processed by FW. If it matches, it means
> that FW has already processed the cmd, but FWRDY timeout for some
> unknown reason.

Feels a little risky. AFAICT the value we're comparing is just 
a checksum (potentially always set to 0xff?) It doesn't seem to
identify the command very well. If the command timed out let's
always return an error.

The other explanations make sense, please include them in the commit
msg.

