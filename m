Return-Path: <netdev+bounces-244257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78022CB312C
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 14:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81059300721C
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41924325730;
	Wed, 10 Dec 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSE5+JeS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4C3233FA
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765374923; cv=none; b=BkOpX18UOcXhBFKrXLyCa2bAkpKV+KripPosh8T20pTIEl02AdCMbbJv9nvEng3plmxeRqTPfJTSn6uCJ8Zb0vvIsaAvIPvi2sRejc2REwtIyjthCucrHOyv+A2XSTxGDWCyQkoFcvN20mE9R96oId+ABtKdPz+8iIs9/AZ/LWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765374923; c=relaxed/simple;
	bh=rUs9TrsVVSrRHKY3G9FtQ8C8glXBWJ1UxJYOpoCCD5A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lol0RWUCAUC+WWkWhZNA26tjej7DorSVZQSvCfA/GZTFyIdL8v/tjMLeSTb3nSu8tyK+ex4maRDw0JwxW+KBGO5vb4ITWTZCMylJNEmQ0V359ONHhxigNoT2zkcKpcKCjH/alLnrn05iyMhb116/b0B79BiWzTJJVgwvhGmuotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSE5+JeS; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64472ea7d18so459436d50.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 05:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765374919; x=1765979719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTifI29dWJ/cAF0/szoDrGzc4h9LSBx4IloVQSNjGSI=;
        b=PSE5+JeSRkt4ObelTKlhbRjtCmplxv4orKB58yBgc/rEmE3Dx24/6INtUZ28RCK+zU
         zS1xZXCfQLCYuONIkdoR7Y+tGSuvzTC71LGLDikK/aVfcj5H58pk5pvOUhcDCfWFtDIR
         IgjDRR236OytPjmtLZedwGvgGfVXZJiCsCFgs26aDdkIEQOQBMmh5RUGnwEjJQoH4Vgj
         eKVdbNETchlx4CaC7lG/LYsLbyTY3LHvxS9C4Pt9Uk7tj7idpjzlf3H7Ezw0D1mm6q8S
         /Y7q9RPh6oK8NBJ7SZZ0x54hZJDyCJW6htJMKhwHwpl8v+PEqQ77uNukiQo6OX+9D+3S
         QEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765374919; x=1765979719;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTifI29dWJ/cAF0/szoDrGzc4h9LSBx4IloVQSNjGSI=;
        b=PbrrCelkXngHInp//dP1d1MizVeqMDXNSYtzVrjoBqUNBrOPgewUd0XxpPrrDj0ARF
         3bP+CCWAl6+vwqY3EeTvchcL6aRGLwkUxCshfMmssyzFgWBwkLt2E7YIrCNHyOV3h0n5
         4YjsIqopC96Yjwv0KOwV09QrsGc+h1E+W4aHTOxb4ycXqqXDwolJAGzwL/edy9AyUIe8
         0AXWF65c+Pnh0x/MGMRabN7C8tUKnCNB+BzxkICTmiXQBs9Xip7zKOGwWP9svuBBNURg
         43uxEK7Ep9TLqGv3imul/l8T9qBnCYTGIyloORmsaAWyscQi/0VpqRqnPALLIHBD36LO
         /nvw==
X-Gm-Message-State: AOJu0YxID6IFkzQxAJWfdvE/TG4g6qXGr7kqedmA4po3DLSZQ+R2heUE
	qTbYhouhEuDt4cMHEFWcyww4CJfIqxWeTJtJ+bm8eVqOaKPa/JX99BfA
X-Gm-Gg: AY/fxX7dhRU6aSDWju2Y6qQthRuyVQ3X55HlQSL9smoHDRJpRsdDDSOYTcjQ6sezLbu
	i49MOYKqhL31TdR83CW6BYZpdbq+Gooo8bERnNbyVm4oYOkD3cjea50nchNFECAcaFP6FqYE0L1
	BmoFj7RIgGqrSpsCvU27RQsuo0s7pJbRDFVqv3DJCLr5ClWGP563XPpOV0aOcOA8HeLKoM2v4vv
	jiVfPRVbNY/BTV3yPeP9uzTbe6ZdGyuh2eUl9lU2T7zQy42e6JbWphukuUyop41w9WRwrozn9qS
	Q7qH/nQBg4MtJsHHX8fuHQoVoLQnxvpbH4rgtARXUCZ0R3f7tVxl5UF1pG9NWCVA5IeRNzIqXJJ
	eFwRhi+poDGCV5ovDyFLDm3nfwa/2l1plES7bZIgwyjOv+FuWWe5IuDrk2p735pIL14Y8PhcWEc
	ND42u+Si72QKp0HHPhsQIdFgYt6kb1DE50xdw5uF2O3mS8QLy8TxycmPjB7siajU/qfII=
X-Google-Smtp-Source: AGHT+IEGWR6SFUkSdSC8NDvIrcTrtp5wIqCeacqwZUJzSb2kOZ9UYdlatQzYHUWCxDGmeNEZBanRJQ==
X-Received: by 2002:a05:690e:128c:b0:644:49be:4b8a with SMTP id 956f58d0204a3-6446e85ca12mr2008217d50.0.1765374919157;
        Wed, 10 Dec 2025 05:55:19 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f5a3ca0sm7613991d50.12.2025.12.10.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 05:55:18 -0800 (PST)
Date: Wed, 10 Dec 2025 08:55:17 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Junrui Luo <moonafterrain@outlook.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, 
 Junrui Luo <moonafterrain@outlook.com>
Message-ID: <willemdebruijn.kernel.3905bafb42307@gmail.com>
In-Reply-To: <MEYPR01MB7886119A494C646719A3F77CAFA0A@MEYPR01MB7886.ausprd01.prod.outlook.com>
References: <MEYPR01MB7886119A494C646719A3F77CAFA0A@MEYPR01MB7886.ausprd01.prod.outlook.com>
Subject: Re: [PATCH net] skb_checksum_help: fix out-of-bounds access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Junrui Luo wrote:
> The skb_checksum_help() function does not validate negative offset
> values returned by skb_checksum_start_offset(). This can occur when
> __skb_pull() is called on a packet, increasing the headroom while
> leaving csum_start unchanged.

Do you have a specific example where this happens?
 
> A negative offset causes out-of-bounds memory access:
> - skb_checksum() reads before skb->data when computing the checksum
> - skb_checksum_help() writes before skb->data

I don't think this is true out-of-bounds as long as the data access
starts greater than or equal to skb->head, which it will.

There are known cases where such negative skb offsets are
intentional. I don't think this is one of them, but needs a careful
analysis.

The use in skb_checksum does seem to indicate that this is not
intentional indeed. Checksumming a packet where the L4 header would
lie outside the data.

    csum = skb_checksum(skb, offset, skb->len - offset, 0);

> Add validation to detect and reject negative offsets.
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 663ead3bb8d5 ("[NET]: Use csum_start offset instead of skb_transport_header")
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  net/core/dev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9094c0fb8c68..30161b9240a2 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3574,6 +3574,11 @@ int skb_checksum_help(struct sk_buff *skb)
>  
>  	offset = skb_checksum_start_offset(skb);
>  	ret = -EINVAL;
> +	if (unlikely(offset < 0)) {
> +		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> +		WARN_ONCE(true, "offset (%d) < 0\n", offset);
> +		goto out;
> +	}
>  	if (unlikely(offset >= skb_headlen(skb))) {
>  		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
>  		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",
> 
> ---
> base-commit: cfd4039213e7b5a828c5b78e1b5235cac91af53d
> change-id: 20251210-fixes-ef9fa1c91916
> 
> Best regards,
> -- 
> Junrui Luo <moonafterrain@outlook.com>
> 



