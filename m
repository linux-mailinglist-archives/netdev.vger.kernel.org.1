Return-Path: <netdev+bounces-101812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E319290026B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A62871E1
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1258318F2E7;
	Fri,  7 Jun 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV065jUJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E815DBB5;
	Fri,  7 Jun 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760511; cv=none; b=i/Y7InPeu90nFekTwrMrhMo/7lpSUvZ66LSdp4hdakoePU9p5MK7LZLoL4W9GTtd3zQz+FbExNLma1NiKqXbIYvYYk8aaHBSHzrOpw/hoo0ZwIR9zb1f1EJa9Kp58L2RSaEZHPbyBXU5THGN3htBJgPHchxwQ8nD3Fai6EKYa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760511; c=relaxed/simple;
	bh=B14YDF8ZhEAP2Q+//eOoFIKJTaa3a6h2lMmDseLd61k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/M7bsRR6K5ZLv+i4Vl/Alifgo8LOw9ZKwOzZ1SHxEYftPGMa/eXqLlP+cyiKyla8EVfGGLpb1Rth3NlZxvX12CZthQz9+b6Md13E9d+aAHCD0a8iky75uqjh8d/xn+MxgTrXTy7eWQ1PxKWmhrbPx0hnCSZL61jWYjGh0kpwOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV065jUJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6265d48ec3so242417966b.0;
        Fri, 07 Jun 2024 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717760508; x=1718365308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFr2j3EOGt1xZAeK/USgbUG6yFrdkLhSyiK2Tbl9Nfs=;
        b=IV065jUJfmmRNn5kOVmSMK7sUU9ZqG95YSgGN2w8YbfGA9Ki+sO5EJnvn7xCCyNBNp
         mvxZI0+KV7ejGzQNHlYUlMpllU6123HQiKjrJECTe3JizHKuEGZx9bwF7cRMel50FoG5
         955prYvZq7jcwGepT6l1OssN70TAxZby7oqZAk1DrixndH30+YtsW7FCk9+3W8fBUelK
         NOEcmkoJhYJDCIVWLnu/XbU3dxi9k+S9J5Ps2xWVO8KCP1WqiXtk6hrAYWDEog7nKvew
         jiLHoxFMGVNCNW0eT+0xA8PNvibOr7KE4DP4BSixxFgBjtdG1yUfJncW5Gvx/tSE/YuD
         OUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760508; x=1718365308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFr2j3EOGt1xZAeK/USgbUG6yFrdkLhSyiK2Tbl9Nfs=;
        b=QrnZTG+NCAIbDoxINosDlHedxmlLjiHXzehb/D3F9iQAUyX8KeUeE8QN7dENN5kvbQ
         X8z+TRa8tdUZtXI4GACxyMteZNtSCGLymc2HzzqiQ+TkvrRm/VgKcS1Q8REChdhwIlEX
         5BzRkSc5ik21A5Mc7GBYBJXEV60GOa3ldbUfPJoJtgB6CibVjGNXiw9bJnjsTa6/bZxA
         5e+RDBAdF6Cm32PheNL/xrg19/Wvw69pjYdNWPgozuug0iQSkPI9Rf/Hkx7jxlubbAk1
         4tGDTzKjCH3H/38e065qYIVVp1pmtevxblVyM/gZOREYU0BgP4iNUMpIPEQ7eUavomcG
         a1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJwrMlmQVrYKjHbEmTIyqN7ax1i7I7sT6r20G3GF9IM0Nqjeba98Hk2qD6s7Tz52I+07XnOPpY0mIMs2DZc66rc/b2vwRAjtUShgf9FlzvkzAaiXxDLaScfKMZW+72+iuNEPz2V/oDxv2dveu9A/gcH/lz8lTHLUsS9SL0QXnbkA==
X-Gm-Message-State: AOJu0YwKYyn+2NgH7LAjEDDlN+35NLZcBwrrVcbCLNp+n/pVxF/Q4CFf
	NP9bErBH4DrbQofY49lneh6XF5knNMvLTg0Uf434bg3+JkqQwtv+
X-Google-Smtp-Source: AGHT+IGFKC6yng2d4Fx2aP0UxvSBQeAXG7/GuQtCvU13NoGeF6wwNfCZoasP2Jq7qEos5la1HiIfLw==
X-Received: by 2002:a17:906:3650:b0:a6c:7181:500d with SMTP id a640c23a62f3a-a6cd7a89ad7mr151543166b.45.1717760507562;
        Fri, 07 Jun 2024 04:41:47 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072ac1fsm234971866b.222.2024.06.07.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:41:47 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:41:44 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 13/13] net: dsa: lantiq_gswip: Improve error
 message in gswip_port_fdb()
Message-ID: <20240607114144.knza5aapic2j5txu@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-14-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-14-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:34AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Print the port which is not found to be part of a bridge so it's easier
> to investigate the underlying issue.

Was there an actual issue which was investigated here? More details?

> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/net/dsa/lantiq_gswip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index 4bb894e75b81..69035598e8a4 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -1377,7 +1377,8 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
>  	}
>  
>  	if (fid == -1) {
> -		dev_err(priv->dev, "Port not part of a bridge\n");
> +		dev_err(priv->dev,
> +			"Port %d is not known to be part of bridge\n", port);
>  		return -EINVAL;
>  	}

Actually I would argue this is entirely confusing. There is an earlier
check:

	if (!bridge)
		return -EINVAL;

which did _not_ trigger if we're executing this. So the port _is_ a part
of a bridge. Just say that no FID is found for bridge %s (bridge->name),
which technically _is_ what happened.

