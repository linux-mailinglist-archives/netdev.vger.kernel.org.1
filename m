Return-Path: <netdev+bounces-92762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C272C8B8B76
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F751C210B5
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3DC12C490;
	Wed,  1 May 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srq17NU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C850A77
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571434; cv=none; b=ik/Io/l9cz1xgIA+jnVunWYWYbWxG5dTtVxtIy0fjsPp0jMx6adb0nz7In5Rouh/60R7QuoI46NsjponCGMXFfmBDP5YKYzkFRAblv/AphS2VTZBsGujXMRtBmC9HoIZRXi0lfSiIeBh0sNwE4vc0zTUI/YGiyQB5zgg5LtcMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571434; c=relaxed/simple;
	bh=Vyyk9ljBmybvy12ad5HBGq+8UIdm402uUoIY30qyHW4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WJ1CMSE91KSVnx2RavmryFZWV3YPSQzA5klnYhEViTnQGW1tlOVMwhnqqGt+djqXiUZcBw3yXd4/Y1PT6noD/b0/jWSPtg5N2+lNeO4qW6np/U4sOidqaHy3KlDT0Rw6tDkq3NAcqnlDI07nfBZFhRMqjeARC4v92cBQSzN4fb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srq17NU3; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5af23552167so4193512eaf.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714571432; x=1715176232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kweYxF7a1Tq49aKquv21EyjY+TiTecdaKIqRAFtc5Q0=;
        b=Srq17NU3H/PrWW5tP8l3YiNDXlnXeJtQEMEMHglDgLQGbqpeqY/jtsCaSLNpOalMSK
         Vk9QyL0ImEbYwwxamZPFHdBp5upTzBMroHUtZLQqgexIQcE/D+aJTYiRFdB+mUtjct0Q
         xVe1Uhl8b1X3Ig2g9WRUiB7rqFsth2NZB/J0C9QU0MlVvvsQGpPp0ACXI7W6W02taS8L
         ZsYTojvidwDZvUyY3rZRZjyYV9rjhEeyBFlllYPAESMQ8XGTqvAJqfn/Bbo2csPvWvOc
         IAN86Mmh/JjtmEzKRnTeeHo/R7k6Q6K21EgqMw0vWbRvc58MbQZ/+t5LtJeCeLsgYYF4
         fACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714571432; x=1715176232;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kweYxF7a1Tq49aKquv21EyjY+TiTecdaKIqRAFtc5Q0=;
        b=VJyCnFm2316zmvuISV7jAHhD8GZ2uhVhGBruOgJO3fp92ypZS2WsBB3VR99LN1Dv6P
         h0SkZCDvabMZSc1c+P97SQfYnOfwULejK46hOjsC1EoVZTn7tCdzlC0mfftVWJ1U7/LR
         sMghpq5GzvzRolhXoLSmIfhJhrF+HTW3iXBze97wIDGwUiVkL6WwTFfRvmnsolp7iAIK
         syPJgb5h2NT91QX1k9uW1SY7CU5QH/v36vtpiF6IIn4utapLlRsgu66qVtVTNuTPEH4s
         u1f1a5ZWlMoezzADcl/BsWtgOHc3ie1rpRKMKPeJbDm/bMF/hheHi2zIP3ndnCnV3fvZ
         MJcA==
X-Forwarded-Encrypted: i=1; AJvYcCXr1MtaRDr/7glVIumUnx09vr4UcD8YkGI2pAMZ9C14Jhg69WY0dPLCIYMKYBCYnUgtk6FZ20/cVzQJuhQ0yoRz+ZYM7U8O
X-Gm-Message-State: AOJu0YywGy4gAEV5wgVL/uPYymfuFfN2siBAqu3iKRALxwsoJb9RnmgH
	OXBXXhK0VBzr+ejDzaYXQN9jceVy9RzPhFYi9QVXEm1D/O0qxXk+
X-Google-Smtp-Source: AGHT+IFCKtwU2y+ILzNWsw+mial0TuEXFvn78aUCMJWNpUslmbJ3HwBOINb6gLDoc4XX/Ju1YdMWrA==
X-Received: by 2002:a05:6358:5911:b0:18e:585:617e with SMTP id g17-20020a056358591100b0018e0585617emr3266753rwf.1.1714571432444;
        Wed, 01 May 2024 06:50:32 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id cv7-20020ad44d87000000b006a0d22f23c0sm32636qvb.61.2024.05.01.06.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:50:32 -0700 (PDT)
Date: Wed, 01 May 2024 09:50:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shailend Chand <shailend@google.com>, 
 netdev@vger.kernel.org
Cc: almasrymina@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 hramamurthy@google.com, 
 jeroendb@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 pkaligineedi@google.com, 
 willemb@google.com, 
 Shailend Chand <shailend@google.com>
Message-ID: <663248a7b3624_36251a294d7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240430231420.699177-4-shailend@google.com>
References: <20240430231420.699177-1-shailend@google.com>
 <20240430231420.699177-4-shailend@google.com>
Subject: Re: [PATCH net-next 03/10] gve: Add adminq funcs to add/remove a
 single Rx queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Shailend Chand wrote:
> This allows for implementing future ndo hooks that act on a single
> queue.
> 
> Tested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Shailend Chand <shailend@google.com>

> +static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
> +{
> +	union gve_adminq_command cmd;
> +
> +	gve_adminq_get_create_rx_queue_cmd(priv, &cmd, queue_index);
>  	return gve_adminq_issue_cmd(priv, &cmd);
>  }
>  
> +int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 queue_index)
> +{
> +	union gve_adminq_command cmd;
> +
> +	gve_adminq_get_create_rx_queue_cmd(priv, &cmd, queue_index);
> +	return gve_adminq_execute_cmd(priv, &cmd);
> +}
> +
>  int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues)
>  {
>  	int err;
> @@ -727,17 +742,22 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_qu
>  	return gve_adminq_kick_and_wait(priv);
>  }
>  
> +static void gve_adminq_make_destroy_rx_queue_cmd(union gve_adminq_command *cmd,
> +						 u32 queue_index)
> +{
> +	memset(cmd, 0, sizeof(*cmd));
> +	cmd->opcode = cpu_to_be32(GVE_ADMINQ_DESTROY_RX_QUEUE);
> +	cmd->destroy_rx_queue = (struct gve_adminq_destroy_rx_queue) {
> +		.queue_id = cpu_to_be32(queue_index),
> +	};
> +}
> +
>  static int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queue_index)
>  {
>  	union gve_adminq_command cmd;
>  	int err;
>  
> -	memset(&cmd, 0, sizeof(cmd));
> -	cmd.opcode = cpu_to_be32(GVE_ADMINQ_DESTROY_RX_QUEUE);
> -	cmd.destroy_rx_queue = (struct gve_adminq_destroy_rx_queue) {
> -		.queue_id = cpu_to_be32(queue_index),
> -	};
> -
> +	gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
>  	err = gve_adminq_issue_cmd(priv, &cmd);
>  	if (err)
>  		return err;
> @@ -745,6 +765,19 @@ static int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queue_index)
>  	return 0;
>  }
>  
> +int gve_adminq_destroy_single_rx_queue(struct gve_priv *priv, u32 queue_index)
> +{
> +	union gve_adminq_command cmd;
> +	int err;
> +
> +	gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
> +	err = gve_adminq_execute_cmd(priv, &cmd);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}

This is identical to gve_adminq_destroy_rx_queue, bar for removing the
file scope?

Same for gve_adminq_create_rx_queue.

