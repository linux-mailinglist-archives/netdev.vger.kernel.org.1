Return-Path: <netdev+bounces-179462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A114EA7CDDC
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 14:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426B33B209C
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128921C5D60;
	Sun,  6 Apr 2025 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVyZ98ke"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72BDDD3;
	Sun,  6 Apr 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743942298; cv=none; b=uKgQHjKmfxefEYtef6zcCyCu0IP6+a7SklL/KLS4ZmiS4p32AnJ5b+T5vDppTnOGalavrT7kIvi9PXtwisI6oNIKF3QBVOkAiVF3VzFb/E/gd38UK8l8wzk4MLGsUUi1cE3vQzh4BqkDyJqtp+2TQbw0euXTHyPBSKyEVrIkkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743942298; c=relaxed/simple;
	bh=ulVKXkH/+RgxZcuZoOfE34OAlGrOQ0csu2idaaKJ3yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKiMS3EERkcDgkUQvsTiD7jV/bXwn0yYwNBrbhiK0yGrI9pB05OcGTN1iZAQM2cKAvgHhqKmLHjGDPGHVxZKeCCxEHcuuSiyYoubW/D3KCSYKkBx0BDYPYFwySjdzYCAfjlY0QkwrqyXYTQWV+rrmZNyPBwGWRkGEDyF2Nnc5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVyZ98ke; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso2601085f8f.2;
        Sun, 06 Apr 2025 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743942293; x=1744547093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvHQynmGZce7aRtQCozbzhFjGmq8v6e8Sgb2HdqSqLk=;
        b=CVyZ98keelxgikc0dMvD7TGp1pevsJ3CAQX703dNGRloHiGdILKZ1bBNlUWME7ux8O
         e5LsES09TK1hc71gh2oNjQnM+SnUBdsF2spSTfgosNX0RGjaxHLFbIs3nG9r0CQcbOR9
         SyQca+QVrWlrd74exNCXfRHqrjfWUHtwOCiXKBEY44vu9fmLfQRn+O2vYuj08xsN4M0a
         2WvGQP4gt0+L6Xhs/i0GQ2JuhzjG01mHEwprVNIwhq607pZEkclvpQ45TJICKtor3gTl
         u+MFb6k07zmW7MDp/KTRSFV7MrY+DL1XRsDrOvx4Ogzr5mugdoNStLkjQqzGS0bWBJbP
         8hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743942293; x=1744547093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvHQynmGZce7aRtQCozbzhFjGmq8v6e8Sgb2HdqSqLk=;
        b=YfRxF3hXdVN/FgxOWIt3wzNwE1UWR8dTEe+qt9MeelPLGEQEPX1LGGGOH9aGb68yv2
         VY4OdmJ+XDqaOTGS8dJcCDKiTuf2BJSXb0jkMZlS+GYAd1GxJ+eRkY/oDi+3hFtRNFhG
         l6cUudt1HQ2GvRphLP2xIyZn+IV4pfPiTEpKxYn8IADjrjS8dSnzZk+iWDdF9BKU6hl0
         uMSuJrcYs8CUd1m5fFEhjhOGSNU1JTxWpbx77R2RrjMs51Lh+M7oXp24PV0pHEDRGo4Z
         KeLh765Gk/24yqVVMRJRtCz4VdfSzS3BkWIlEuCIlpsOWkA8MTRVeTTvVCe7QWUTyMnH
         HrWg==
X-Forwarded-Encrypted: i=1; AJvYcCVYmYGgNFuMf95dE7csBmLkm974/L8a0oH1TbV1sCwOrNZpCdMAT7hvg9gk1mCHFB+15Qf2i5wO9TuqBzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7up1SJiIvQPyFqR10R/fJPbYDtk0aIDtYo1+mgNL7tAilA+qN
	q8DwTi+7vn2C7d79jK2m9hJtBkJn7P81n/e7IvwXsDwHorKm/u1b
X-Gm-Gg: ASbGnctv10fVv+ah4XV/jPMRUvazKx68Ai9ZcVkkNNGh10gAlwFkncuNMURRLCkM3Gz
	Wjg7M12VjZDaQPnstanjogch3X4nvvezx/NntcjrmQB2/JKhExSccHZvdBzdJbcd544k1FM0J8I
	R3TBS6yGZUunaFJYK1oBTer50JhRLn4/EsAJyvZavJwrgC2M3c5CRDxaDZyj0rJWfdeeQhHRT5m
	MdJTY+mudGgro0rUuekRgPXdrBfyDpro5JcIFr+D8K15wFO/TS9+HnWHu8b1ep57g09mAJI1IQL
	by54+EkEEYL0xRnP/kUK3S6M1eHCBEA7KdKAb6XZLrdmQ1um
X-Google-Smtp-Source: AGHT+IGiqFoxkBvAoDfQ2waLeTQuZpil54oTVze6HjLwcmYRJposbGL7pjJ3RIYj36Zd9uFqShglVA==
X-Received: by 2002:a5d:64cb:0:b0:391:3f64:ed00 with SMTP id ffacd0b85a97d-39d6fc4e930mr4807749f8f.26.1743942293390;
        Sun, 06 Apr 2025 05:24:53 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b6321sm9121025f8f.44.2025.04.06.05.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 05:24:52 -0700 (PDT)
Message-ID: <59e8de49-30d8-4df0-9135-ecd43efc3686@gmail.com>
Date: Sun, 6 Apr 2025 15:25:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: wwan: Add error handling for
 ipc_mux_dl_acb_send_cmds().
To: Wentao Liang <vulab@iscas.ac.cn>, loic.poulain@oss.qualcomm.com,
 johannes@sipsolutions.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20250405115236.2091-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20250405115236.2091-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.04.2025 14:52, Wentao Liang wrote:
> The ipc_mux_dl_acbcmd_decode() calls the ipc_mux_dl_acb_send_cmds(),
> but does not report the error if ipc_mux_dl_acb_send_cmds() fails.
> This makes it difficult to detect command sending failures. A proper
> implementation can be found in ipc_mux_dl_cmd_decode().
> 
> Add error reporting to the call, logging an error message using dev_err()
> if the command sending fails.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> index bff46f7ca59f..478c9c8b638b 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -509,8 +509,11 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
>   			return;
>   			}
>   		trans_id = le32_to_cpu(cmdh->transaction_id);
> -		ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
> -					 trans_id, cmd_p, size, false, true);
> +		if (ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
> +					     trans_id, cmd_p, size, false, true))
> +			dev_err(ipc_mux->dev,
> +				"if_id %d: cmd send failed",
> +				cmdh->if_id);
>   	}
>   }

Looks good. One nit pick. The full stop is not needed in the subject. 
But I believe, this does not worth to resend the patch.

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

