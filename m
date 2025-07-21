Return-Path: <netdev+bounces-208557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D5B0C216
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F051890D7C
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397B284B2E;
	Mon, 21 Jul 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTqlP+OS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C521EA7EB
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095762; cv=none; b=C7q8rCKi4to+0UMfCwJj9vzv6Prt42soUb18kx83eR6yhdeW2ayTIZ9TYf8ND+EK4QgAo4xTpr+qOHURF3jvsRTk5RNxh6tvZZAEA+W44HLsW5wxXDxQgGcIByZtsAl8bsVEsPnEyavUEK5eb0gbLFNvHM1NESnfVsQEakQWrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095762; c=relaxed/simple;
	bh=o66KmS0dvmnVwV9kRV+A231A5UVb86BycA3XuJzDjm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeEuac1hHTQkLivHLivGwXqYzkveVY3p3U+ICFn01sUCuXS8AoFKGw8Qc++Qfq9hO91sqtCzEg2Cj1V0o930qCQGBnr8DLyHooEAwpnmWKxjnJ+xHkAJBSLSlENSQzVBSlQ+4ySt8Vz0kSDGpQ+5uUWzbNr5Vr0lAdBqRYy7jbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KTqlP+OS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3140801f8f.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753095759; x=1753700559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnPN47nMXqCMa/5FKC3NpcQPBDzZo2b6pouXJ5vXunM=;
        b=KTqlP+OSRxVjlnfssrIEeIY12LzBXd6h37WeZB407j/gVsJfryA0UNnU/TaU9bR/sc
         0EU1rEqwCm5iTeCZRDThLdGIZSqGqwrKE1uR5OhjhY/HjJ26pcs1gZtg4al7HiIpxJ+O
         To7HTHFJyA/xYHNXzZEvumpE+bIkgVpGvcwQiZnlP5rWm9VrNWG+sm7wXsD+xE66uBsm
         9ksUqANj1zVNk8trXeAIl6tp+rM8JZ395kapvOyVmy45CEuRAMjCfpGLiQe8Y4POHthp
         nTuq05JW0jmA/MhU2MjC3f9jIMVRbYVjRibcxw8M1gbp35oL2CEoCWZP0HKLJiXo8/LG
         zSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095759; x=1753700559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnPN47nMXqCMa/5FKC3NpcQPBDzZo2b6pouXJ5vXunM=;
        b=mn9TfQVIG+Zw8v6WmErxheGo3WEzhI04V5dnqxKsmkisSLxK9ff4yuQ/ohFYtwCUi7
         P3vj2LNC+DVdcovi4UFw9pfP/v/AvIeYWLTgYrMtk4HiAKdvwKlDmOaTAmoeYUvaWvbD
         J+ttjbFM9vG/S3Fm3drCLJc92yvIS/jxP6amLqLempappfTfUDgJwye2ArgEDaBOTnD2
         2lBT5834ErMFZ9vMH56GkuhAU7DHhTsK5rhb1qkpPmNMyTE5GE8+rBlVO0sAmfL6X4GW
         LkvHtlafpC6apqVg8DIded5nUx9qofXtQHqzHJVvX8tTHfrxpkGjwLJdxhoxU+yWT5Rz
         q4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4+UsI/kTFoFv3/8wkR+PNEBh77pn+niqfQjWaoPb809pFGVKeTdjrmFXQd04Q91tMkNuHrcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlF33uIokskU04iZesrd1kxI5lxVdG4TA0Xyd71UnFropCGTxk
	kBpADbUIqb8bwK7e+wPvH1FlJsssuKxSQ01pmPPVfK0G2n4qMIh5JFJdNm6x1SQJ6uo=
X-Gm-Gg: ASbGncvqXT/WamtNoAcRMfGgwmIw24mmRuaKRC/TusQKFM7YxBaPZ0av7TLkrakUzLQ
	j2NGdqVWMaQ41u2ozwNTmEAbIC9dPwGa88cB8MxULJs2Wb/pnPV2WKdh9MknvNi0H/5aitBIZhH
	5k3Vp6/06emtYuCXa6/5e6Mw59mgGDIDqSIxCqo7gmwtrYN8JxDI5bMAP2XDJuOyQhX2S0ECEgE
	TIv+Rj66tssGk0dOWCkYHSOJzOmKEI6KptcAxZ90Ad9Ct9RrPJPAlrubfNUWCw9QCOmMHywxOan
	S+MdTInJwCmbnquDJ1MbnlnkRDvpnxp/Mweh2vanKyVRGY5do4k2/JkOdlmiYYzpUCDX/Pxz1YF
	u5lkTciXJBU+R7XJkFw92C6gdzHgwx/HFwSbrgn0Oj89TViOgnR+aqxlB5jFilZU=
X-Google-Smtp-Source: AGHT+IFGN8mRXN/kZxyJyfdLFb/YDnz/Qv7FQJ0+kN5BasGH8tzT//CVFFtZf1yRBXL9BZ2mDjJbAw==
X-Received: by 2002:a05:6000:2383:b0:3a3:64b9:773 with SMTP id ffacd0b85a97d-3b613ab2bb8mr12942274f8f.10.1753095759171;
        Mon, 21 Jul 2025 04:02:39 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca486edsm10204994f8f.56.2025.07.21.04.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 04:02:38 -0700 (PDT)
Message-ID: <985111fc-3301-4c0a-a13e-ab65e94bdcbb@linaro.org>
Date: Mon, 21 Jul 2025 13:02:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] net: qrtr: ns: validate msglen before ctrl_pkt
 use
Content-Language: en-US
To: Mihai Moldovan <ionic@ionic.de>, linux-arm-msm@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Denis Kenzior <denkenz@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <cover.1752947108.git.ionic@ionic.de>
 <866f309e9739d770dce7e8c648b562d37db1d8b5.1752947108.git.ionic@ionic.de>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <866f309e9739d770dce7e8c648b562d37db1d8b5.1752947108.git.ionic@ionic.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mihai

On 19/07/2025 20:59, Mihai Moldovan wrote:
> From: Denis Kenzior <denkenz@gmail.com>
> 
> The qrtr_ctrl_pkt structure is currently accessed without checking
> if the received payload is large enough to hold the structure's fields.
> Add a check to ensure the payload length is sufficient.
> 
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>
> Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
> Reviewed-by: Andy Gross <agross@kernel.org>
> Signed-off-by: Mihai Moldovan <ionic@ionic.de>

I think this is missing a Fixes: tag?

Kind regards,

> 
> ---
> 
> v2:
>   - rebase against current master
>   - use correct size of packet structure as per review comment
> ---
>  net/qrtr/ns.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index 3de9350cbf30..2bcfe539dc3e 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -619,6 +619,9 @@ static void qrtr_ns_worker(struct work_struct *work)
>  			break;
>  		}
>  
> +		if ((size_t)msglen < sizeof(*pkt))
> +			break;
> +
>  		pkt = recv_buf;
>  		cmd = le32_to_cpu(pkt->cmd);
>  		if (cmd < ARRAY_SIZE(qrtr_ctrl_pkt_strings) &&

-- 
// Casey (she/her)


