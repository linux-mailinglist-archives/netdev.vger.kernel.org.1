Return-Path: <netdev+bounces-124340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F6A9690FD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C47128411C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78F81C68B0;
	Tue,  3 Sep 2024 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su3K+Tlh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2151A4E9F;
	Tue,  3 Sep 2024 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327444; cv=none; b=iabYnlUsQDoXHEmnyQCQd357auND1+VsLuMMES2Cdr+wRy0WvRZFXi4xxIUjq+caaJBXNARwxTZclpz1D3JsCnlyYldSKAkAR7TAg8UZi+eLziUj6G10wS7COnAbytbC0HHzF1ACJ9Bi5v+Y2pNW8UEnQcRLVzrfl0z0x0jXZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327444; c=relaxed/simple;
	bh=62vr8jhBaK6+/RKkT07PmnQ35p+SxqADAZ0DIcUZMpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLwgutZzdN/4TbuUzXs7HzJAOnZWOU0Iicm8EiEYu/M9OXB9rPuXxzVX65iwZO45OooORlUrVZX7JEIZBDylnWLEtJ3iRMNIpP3WkjYSpJ0ET6nxX5KxYt5bVRX1hZBh8fEvAFzgpgJEgghcMHxjBi7FXiU7ZqHGPr6k8BPS4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su3K+Tlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA64C4CEC2;
	Tue,  3 Sep 2024 01:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725327444;
	bh=62vr8jhBaK6+/RKkT07PmnQ35p+SxqADAZ0DIcUZMpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=su3K+Tlh9vfi5WIp3Gvg9pV/0kByo1SyPJ/83oAp4bEANJQglPwK3lfHlDzzVflBE
	 6l4AR9xeyGGKZVs6CDTlUvdyeuli0duweWcJ8DaxoHJZq7vmsOtDtQ1TPA0bcgo15N
	 t3Pl7ZZETtxNuCavwXT4PuGPCcm8lPg/OtATZ6LXrfwYvFXLaAHt3FC0Mrh0XnDRyk
	 w6Yzjws65BODjSCSdXADohCeSkiQwTieTuuEe25pLV8ZHJklWsluIghPJd0se/oPaQ
	 eQ/J/E3AW/4TryD2bHhT9oLvvTpOehqHU7BtXZXHWBr27j5crUkv8kC6EAmPTuWDmU
	 K1mKO9AvhEYjA==
Date: Mon, 2 Sep 2024 18:37:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wan Junjie <junjie.wan@inceptio.ai>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 ioana.ciornei@nxp.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] dpaa2-switch: fix flooding domain among multiple
 vlans
Message-ID: <20240902183723.0dd4d192@kernel.org>
In-Reply-To: <20240902124318.263883-1-junjie.wan@inceptio.ai>
References: <20240902105714.GH23170@kernel.org>
	<20240902124318.263883-1-junjie.wan@inceptio.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Sep 2024 20:43:18 +0800 Wan Junjie wrote:
> > > -static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
> > > +static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv, u16 vid)  
> > 
> > This, and several other lines in this patch, could be trivially
> > line wrapped in order for them to be <= 80 columns wide, as is
> > still preferred in Networking code.
> > 
> > This and a number of other minor problems are flagged by:
> > ./scripts/checkpatch.pl --strict --codespell --max-line-length=80  
> 
> It is hard to keep all lines limited to the length of 80 since some function
> names are really long. I have tried to make the line length to 85 without
> breaking some if conditions into multiple lines. You will see in v3.

FWIW it's relatively common to break the line after return type:

static u16
dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv, u16 vid)  

