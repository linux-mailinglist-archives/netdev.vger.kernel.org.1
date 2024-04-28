Return-Path: <netdev+bounces-91977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7118B4A8F
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 09:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BAF1F21597
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989550A67;
	Sun, 28 Apr 2024 07:52:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E8EED0
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714290779; cv=none; b=YFAVEyQY0J9tlEAMWecrrqWjQ1AkDkVfJhThGCqFCREoh5+mrIxA7qq1GWMNndOqkCsik5jl0c1PglRKw0bNnkcWQTrktNQWoldkVDbxap7yZw9VNAEVnd7fpp9oHyDzeG/qV3efMcl3m6J1ujfoCLVcLaS9L+18Zq2j6NO4JxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714290779; c=relaxed/simple;
	bh=DCp8zqaVSCOb63sWtI0P3TDy7Q3138qPZMV2sVHUDPc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=IonzC1+5WDS1d0Jn9AOTElCm44kVBS/tppflfWhwKOLtE5Q6JbAD0E9vKG/a09DQQzZL4eswZ7jS8O4Cmp2NqtM+Zi+YTuzMYIuUF4/4ntzgR36v4MaydIAMtpKkpxslaSunFeZlB6NrjEmsD5ZLgfK+lt6uD+Ws254l73edNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas51t1714290625t841t40527
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.150.70])
X-QQ-SSF:00400000000000F0FUF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2063350975756394499
To: "'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>
Cc: "'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <E1s0OH2-009hgx-Qw@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s0OH2-009hgx-Qw@rmk-PC.armlinux.org.uk>
Subject: RE: [PATCH net-next] net: txgbe: use phylink_pcs_change() to report PCS link change events
Date: Sun, 28 Apr 2024 15:50:24 +0800
Message-ID: <064b01da9940$baa36cc0$2fea4640$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIUC6jdfg6pE2DNQWNBULP0vE7mX7EKaJhg
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Sat, April 27, 2024 12:18 AM, Russell King <rmk@armlinux.org.uk> wrote:
> Use phylink_pcs_change() when reporting changes in PCS link state to
> phylink as the interrupts are informing us about changes to the PCS
> state.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index 93295916b1d2..5f502265f0a6 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -302,7 +302,7 @@ irqreturn_t txgbe_link_irq_handler(int irq, void *data)
>  	status = rd32(wx, TXGBE_CFG_PORT_ST);
>  	up = !!(status & TXGBE_CFG_PORT_ST_LINK_UP);
> 
> -	phylink_mac_change(wx->phylink, up);
> +	phylink_pcs_change(&txgbe->xpcs->pcs, up);
> 
>  	return IRQ_HANDLED;
>  }

Does this only affect the log of phylink_dbg()?
If so,
Acked-by: Jiawen Wu <jiawenwu@trustnetic.com>



