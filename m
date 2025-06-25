Return-Path: <netdev+bounces-201014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AD9AE7DB1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4508C1655DA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEFB2E11C0;
	Wed, 25 Jun 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQtEamnk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097682BE7AD
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844145; cv=none; b=AVCdE7Jy5hV9IEnpXe5kYyzCxxCALVi+qM3m38WpZOwzHQNjtUkIaRbK2cyiscji2Gx20grzFIKzUCc6EzCSUbSpEMQaWGknYyW/OsDx/7H+51o89hlEbw1t/L4eMcn4ccikwbPbUi9ckT6RsXfpoI306s8wGwfduTv7BgZ/w+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844145; c=relaxed/simple;
	bh=2RnqIA9ku/bqqCrYgJOWavH7d1DuOne7Vlpiy52rcjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYJgCI0KlLj0jLXwaCcS3MB52q3ljKT8hhMf0jOdiAr+BUugB8mRYQdmD/9LUZ4iq4Dzf2RmU6TtTAOhDe/pMnx3K5sPaB3QDgcB5Pep9Zj+p9Up4iM7gM2I08SmRKrjdacK8uh+zqniKPWrrKjdjhJFbHtTZPr2TrareE1Dt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQtEamnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8DFC4CEEA;
	Wed, 25 Jun 2025 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750844144;
	bh=2RnqIA9ku/bqqCrYgJOWavH7d1DuOne7Vlpiy52rcjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQtEamnkEPW/zIUVk4p2EpZVjug+av5LKWhB3ZhA9AlQmR8HI7ER0/LoVNYmdulbD
	 xckH+8xjYbq8JLfnVjkKmvTNGYg5S2SgIzApkr8GqCV1YI/h5gsbCHKrTBQEeAm9Ia
	 ph0Z6LSS1T2A8hfhnYNM4zrmJK3BGQUiecNdGlq4FOedb2vVjJRHFUyA+WBukXHWEl
	 2Mzuhd5imToVckLVIHz39pbYpqCWU/zA4yqN67Pw/wo+4vtZwChEqAY/bVhUvjg+Ab
	 tNCb51JlToqGHBm7C7ptkIDFrN5Fp29hPgntwNJg1JuE/ceMctQcB6tTn8u2mk3r2k
	 xcQNjbOWYlX5A==
Date: Wed, 25 Jun 2025 10:35:40 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net] net: txgbe: fix the issue of TX failture
Message-ID: <20250625093540.GK1562@horms.kernel.org>
References: <9E4DB1BA09214DE5+20250624093021.273868-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9E4DB1BA09214DE5+20250624093021.273868-1-jiawenwu@trustnetic.com>

On Tue, Jun 24, 2025 at 05:30:21PM +0800, Jiawen Wu wrote:
> There is a occasional problem that ping is failed between AML devices.
> That is because the manual enablement of the security Tx path on the
> hardware is missing, no matter what its previous state was.
> 
> Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

nit: failure is misspelt in the subject

> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index 7dbcf41750c1..dc87ccad9652 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -294,6 +294,7 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
>  	wx_fc_enable(wx, tx_pause, rx_pause);
>  
>  	txgbe_reconfig_mac(wx);
> +	txgbe_enable_sec_tx_path(wx);
>  
>  	txcfg = rd32(wx, TXGBE_AML_MAC_TX_CFG);
>  	txcfg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;

Hi Jiawen,

I am unsure if it is important, but I notice that:

* txgbe_mac_link_up_aml is the mac_link_up callback for txgbe_aml

* Whereas for txgbe_phy txgbe_enable_sec_tx_path() is called in
  txgbe_mac_finish(), which is the mac_finish callback

Could you comment on this asymmetry?

