Return-Path: <netdev+bounces-145296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA39CE549
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F26B26C37
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD71CDA3F;
	Fri, 15 Nov 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="oxnyUFwf"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538F1CEE88;
	Fri, 15 Nov 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681632; cv=none; b=ZHllZlWv5ZsBeze7emEiSMIJItf05vLAEDpoF+bFsByCHmLzjk+77/GpcJByuTNcn5BDnfgc/8a4HJrTmQ8ktk0Dfnmj1wPE98/BiBsu9oizf96sWmxesP7qyvRsKY2hH2UDDedgatr6oQre2p28qFoyjuQAgBEvJJT/y93+YOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681632; c=relaxed/simple;
	bh=959MsTQz65hf3eOqxrdEOR8H94M1v6fwbz0kNjifmac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=opEz2xhWcd4jg2oQ+AbnW1bcCTqs9JxCz6k397hj5LOFK9zSFqlMF72p48A1WlFp27naAPsMR2p7wKyXZS2hbgSuTdbUWhVT5xMoTfzcTzL8WOzPYFjecoh5/eF8ZKtbPJDMA8BhX7Sy2b8dgCpIaYqyQ65phqBlmD9cduuFvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=oxnyUFwf; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 22A27A03F3;
	Fri, 15 Nov 2024 15:40:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=6/2MUpA9iiZewuVkOsHA
	/MenPovLnhmD8c1npxgNkyA=; b=oxnyUFwf1GBAuF54WohUVoYHLcYbWL5OC3JN
	WfA6bBY0jbXYlYO0X0OUeeG/zNgj7vAbK/cBQyDUoSQC6cSXzrdK5/k1nPazM8yk
	Hh+pSItTYkGibeGcJsACpTu9q5JTS/Ku8FXsFloK/tnUSu4KcYIdUJcPO3IxkO7J
	1XO0SVUDUDwv7z1PsQ2FodflkSI8p0iB97ELYYyYL57mFs+lWucXRZr+maV2Jf1a
	DJjYLKzIr2cJDthaaYaqnWZ3HERHddc0wf64awhMLUHCMih4K37EOrqcISI3OqBT
	xIvqdEeAp9HSHss45nlH6rcYVAtqugLc9tN5k2YGjzT0z8jSHUYuNzV/Ez+8C0fW
	93E131l5/5ZbVJaRlwmOHVNxfEnrVTyJ8MT3TPqtk8J+rw1mjh4NklLiUah+e89f
	TFJRhGlFZn5wWHG3QYyK80zHtDQfUfZx9JFhQgrJKx28ntiSsmsCroTzH1dKV5B4
	TuDi0L+RPwCaLe/DDsyWv2f9FktlCwO0tKNAok/npQjyQtRyy71OTBi2SiyZ2iFy
	65jt7ggA10MYoTb3K+Koh2LeuoE+JLE+uvEPnXhik7Jx5GpWnX63IjlShTeXI1In
	UiUUxT9K3jti9wuAMRYqnGdTzeoJrMn3BVph3qon+PLd6kw+JHw4i0AIOPIh0osh
	RCqgwsI=
Message-ID: <f50ee921-277e-4aad-a96e-378c08ec8288@prolan.hu>
Date: Fri, 15 Nov 2024 15:40:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/13] net: fec: fix typos found by codespell
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>
CC: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-1-de783bd15e6a@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241016-fec-cleanups-v1-1-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855617C6B

Hi,

On 2024. 10. 16. 23:51, Marc Kleine-Budde wrote:
> codespell has found some typos in the comments, fix them.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/ethernet/freescale/fec.h     | 8 ++++----
>   drivers/net/ethernet/freescale/fec_ptp.c | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 1cca0425d49397bbdb97f2c058bd759f9e602f17..77c2a08d23542accdb85b37a6f86847d9eb56a7a 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -115,7 +115,7 @@
>   #define IEEE_T_MCOL		0x254 /* Frames tx'd with multiple collision */
>   #define IEEE_T_DEF		0x258 /* Frames tx'd after deferral delay */
>   #define IEEE_T_LCOL		0x25c /* Frames tx'd with late collision */
> -#define IEEE_T_EXCOL		0x260 /* Frames tx'd with excesv collisions */
> +#define IEEE_T_EXCOL		0x260 /* Frames tx'd with excessive collisions */
>   #define IEEE_T_MACERR		0x264 /* Frames tx'd with TX FIFO underrun */
>   #define IEEE_T_CSERR		0x268 /* Frames tx'd with carrier sense err */
>   #define IEEE_T_SQE		0x26c /* Frames tx'd with SQE err */
> @@ -342,7 +342,7 @@ struct bufdesc_ex {
>   #define FEC_TX_BD_FTYPE(X)	(((X) & 0xf) << 20)
>   
>   /* The number of Tx and Rx buffers.  These are allocated from the page
> - * pool.  The code may assume these are power of two, so it it best
> + * pool.  The code may assume these are power of two, so it is best
>    * to keep them that size.
>    * We don't need to allocate pages for the transmitter.  We just use
>    * the skbuffer directly.
> @@ -460,7 +460,7 @@ struct bufdesc_ex {
>   #define FEC_QUIRK_SINGLE_MDIO		(1 << 11)
>   /* Controller supports RACC register */
>   #define FEC_QUIRK_HAS_RACC		(1 << 12)
> -/* Controller supports interrupt coalesc */
> +/* Controller supports interrupt coalesce */
>   #define FEC_QUIRK_HAS_COALESCE		(1 << 13)
>   /* Interrupt doesn't wake CPU from deep idle */
>   #define FEC_QUIRK_ERR006687		(1 << 14)
> @@ -495,7 +495,7 @@ struct bufdesc_ex {
>    */
>   #define FEC_QUIRK_HAS_EEE		(1 << 20)
>   
> -/* i.MX8QM ENET IP version add new feture to generate delayed TXC/RXC
> +/* i.MX8QM ENET IP version add new feature to generate delayed TXC/RXC
>    * as an alternative option to make sure it works well with various PHYs.
>    * For the implementation of delayed clock, ENET takes synchronized 250MHz
>    * clocks to generate 2ns delay.
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 7f6b57432071667e8553363f7c8c21198f38f530..8722f623d9e47e385439f1cee8c677e2b95b236d 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -118,7 +118,7 @@ static u64 fec_ptp_read(const struct cyclecounter *cc)
>    * @fep: the fec_enet_private structure handle
>    * @enable: enable the channel pps output
>    *
> - * This function enble the PPS ouput on the timer channel.
> + * This function enable the PPS output on the timer channel.

enableS

>    */
>   static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
>   {
> @@ -173,7 +173,7 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
>   		 * very close to the second point, which means NSEC_PER_SEC
>   		 * - ts.tv_nsec is close to be zero(For example 20ns); Since the timer
>   		 * is still running when we calculate the first compare event, it is
> -		 * possible that the remaining nanoseonds run out before the compare
> +		 * possible that the remaining nanoseconds run out before the compare
>   		 * counter is calculated and written into TCCR register. To avoid
>   		 * this possibility, we will set the compare event to be the next
>   		 * of next second. The current setting is 31-bit timer and wrap
> 

Otherwise, LGTM.
Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>

Bence


