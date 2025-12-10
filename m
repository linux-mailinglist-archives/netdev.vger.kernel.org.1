Return-Path: <netdev+bounces-244251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE45CB2F54
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 13:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C71E30084CE
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B22DF709;
	Wed, 10 Dec 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uat44MHH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE941FBEA6;
	Wed, 10 Dec 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371315; cv=none; b=VrlCvHHaYPjlz4DL2kEp7eQBp9Y13gmgXT0VtUGh6p9r+jA55i9zjy6VbeK5FT4EM2CcdGncpKW3fNREPvQVoMkiyKGHN3B03kvFT5TzY9JZfa/ZYqzHHV2d7v9xP5rO0SAVL2g/3JfquYZ+SCcSbMo72p3UaYm5vwDrmRTE3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371315; c=relaxed/simple;
	bh=AMM5tslVkbbIYqib572k0aJ7AzSoCOPNOPhDAofsPlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaMh1ycRHnhend+2X+peyGuafAAhRfC8/mOIdkOQIp1IBO3qoOHI5wJzmVZbJjQeOpf/myrSB7K45LD4+ikyc4fvK7xIA7fDDPvM30Osw9ByrDTN+PZUJwIgtGlg8MUQARejJwMoyQs3qpMtCNtY8VhzqzZF4hxzjeUpsUEc5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uat44MHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6851C4CEF1;
	Wed, 10 Dec 2025 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765371315;
	bh=AMM5tslVkbbIYqib572k0aJ7AzSoCOPNOPhDAofsPlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uat44MHHIroemCuWLVRXvd7Rl8ZLr1Zs5/luZRSKJRohwRSl041QT3HWNay//zGT+
	 3i1gyRk4fEz+jWWouFDw9WVIZEgwtc6bjCHK20pW/jlpsPTP8RtQIDXOm+Kq5dxuEv
	 x3JDmIlmJqzzH9vzkWBpSX7dpRs/yTGKd9fgtBpnzildweevO+JZe1/qYhOpDt1pEu
	 6+DMzeXIRZRxe4cW0fthRHW/Y+gf/tqVa51g4mmLmDAE8MkI2q2J6ImGEjKsCz0goP
	 EpKC8bLkATvS0jmjhaNzzpmmqV6xoR94n3MAI1IR/YCkvtvn3dp8DRmfMPkdPezOcD
	 F0R6b4L4zjB2A==
Date: Wed, 10 Dec 2025 12:55:09 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com, lantao5@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: hns3: add VLAN id validation before using
Message-ID: <aTltrTvzGwsLuL6G@horms.kernel.org>
References: <20251209133825.3577343-1-shaojijie@huawei.com>
 <20251209133825.3577343-4-shaojijie@huawei.com>
 <aThTRWe3iHB7HQAZ@horms.kernel.org>
 <0db6625e-db77-4042-a0cc-43e1ed003d10@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db6625e-db77-4042-a0cc-43e1ed003d10@huawei.com>

On Wed, Dec 10, 2025 at 02:39:11PM +0800, Jijie Shao wrote:
> 
> on 2025/12/10 0:50, Simon Horman wrote:
> > On Tue, Dec 09, 2025 at 09:38:25PM +0800, Jijie Shao wrote:
> > > From: Jian Shen <shenjian15@huawei.com>
> > > 
> > > Currently, the VLAN id may be used without validation when
> > > receive a VLAN configuration mailbox from VF. It may cause
> > > out-of-bounds memory access once the VLAN id is bigger than
> > > 4095.
> > > 
> > > Fixes: fe4144d47eef ("net: hns3: sync VLAN filter entries when kill VLAN ID failed")
> > > Signed-off-by: Jian Shen <shenjian15@huawei.com>
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > Hi Jijie,
> > 
> > Can you clarify that the (only) oob access is to vlan_del_fail_bmap?
> > 
> > If so, I agree with this change and that the problem was introduced in
> > the cited commit. But I think it would be worth mentioning vlan_del_fail_bmap
> > in the commit message.
> > 
> Yes, the length of vlan_del_fail_bmap is BITS_TO_LONGS(VLAN_N_VID).
> Therefore, vlan_id needs to be checked to ensure it is within the range of VLAN_N_VID.
> 
> I will add this in V2

Thanks.

Feel free to also add:

Reviewed-by: Simon Horman <horms@kernel.org>


