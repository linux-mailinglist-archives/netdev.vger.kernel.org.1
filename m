Return-Path: <netdev+bounces-141580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111BA9BB844
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4343B1C21668
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2A71B6D02;
	Mon,  4 Nov 2024 14:50:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA1D469D;
	Mon,  4 Nov 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731805; cv=none; b=CSyleboOvpZwyfVn3mj9fTbSUxBAdcnncOIC8WUhl62UnjE8TyDZa1cDahAWDe0sh0vKFtrGt3E/DefVMJ35gUouiVscixODncoza9qz0v8bSzIyITlN1lgBkcnT0RhxSnDqG9S77vsptYckG+ilkMgp1Uw28UwnjtyyWE/NU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731805; c=relaxed/simple;
	bh=4Vv+jv+4Oi8uyoG6jRMsYWTy2VoFnc8oaLa2+MimbdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEJ7OwMeru536pcyCYLAJ32iWQxrE3v5EP8x9mhVd6ihiGl1ifxJbSZqKS9OVDvySHz/iAb1M0sO//ThWkndXS2UdIXDK2af2TY3hxrHNUqLit2+abnjJTnfDyMs78R95O32aolbYlh75QxvnLQ/Q/HmSWznT/jp+f3OXiZFTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xhv8J72RNz9sSR;
	Mon,  4 Nov 2024 15:33:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bWfhLmnpm9tF; Mon,  4 Nov 2024 15:33:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xhv8J6736z9sSN;
	Mon,  4 Nov 2024 15:33:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B3EE88B770;
	Mon,  4 Nov 2024 15:33:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id X3XWHlYHgmaK; Mon,  4 Nov 2024 15:33:04 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 811948B763;
	Mon,  4 Nov 2024 15:33:04 +0100 (CET)
Message-ID: <34c972b7-ba53-46ba-ada9-df741bc21e47@csgroup.eu>
Date: Mon, 4 Nov 2024 15:33:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] soc: fsl_qbman: use be16_to_cpu() in
 qm_sg_entry_get_off()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Radu Bulie <radu-andrei.bulie@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20241029164317.50182-1-vladimir.oltean@nxp.com>
 <20241029164317.50182-2-vladimir.oltean@nxp.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241029164317.50182-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/10/2024 à 17:43, Vladimir Oltean a écrit :
> struct qm_sg_entry :: offset is a 13-bit field, declared as __be16.
> 
> When using be32_to_cpu(), a wrong value will be calculated on little
> endian systems (Arm), because type promotion from 16-bit to 32-bit,
> which is done before the byte swap and always in the CPU native
> endianness, changes the value of the scatter/gather list entry offset in
> big-endian interpretation (adds two zero bytes in the LSB interpretation).
> The result of the byte swap is ANDed with GENMASK(12, 0), so the result
> is always zero, because only those bytes added by type promotion remain
> after the application of the bit mask.
> 
> The impact of the bug is that scatter/gather frames with a non-zero
> offset into the buffer are treated by the driver as if they had a zero
> offset. This is all in theory, because in practice, qm_sg_entry_get_off()
> has a single caller, where the bug is inconsequential, because at that
> call site the buffer offset will always be zero, as will be explained in
> the subsequent change.
> 
> Flagged by sparse:
> 
> warning: cast to restricted __be32
> warning: cast from restricted __be16
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   include/soc/fsl/qman.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
> index 0d3d6beb7fdb..7f7a4932d7f1 100644
> --- a/include/soc/fsl/qman.h
> +++ b/include/soc/fsl/qman.h
> @@ -242,7 +242,7 @@ static inline void qm_sg_entry_set_f(struct qm_sg_entry *sg, int len)
>   
>   static inline int qm_sg_entry_get_off(const struct qm_sg_entry *sg)
>   {
> -	return be32_to_cpu(sg->offset) & QM_SG_OFF_MASK;
> +	return be16_to_cpu(sg->offset) & QM_SG_OFF_MASK;
>   }
>   
>   /* "Frame Dequeue Response" */

