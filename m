Return-Path: <netdev+bounces-80335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF7A87E5D5
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49697282EF4
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D325E2D050;
	Mon, 18 Mar 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tBMENFCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD262CCBA
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754305; cv=none; b=B6PJ1+FBRJZGOqEFloLITogHiQ8NRTPqE5Fh9b14bBGuPGI8I5DBWBXYbVdGIUjGrOqc3+2c2O4uTiL/m4Yjwls6X5TQ9Poii4PqYC46l/9AJ3oElD8oHq5viGu5r48b+jEC8nwpjphRfUW7jj/CTAq9N37rDytlh8VwJNcA5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754305; c=relaxed/simple;
	bh=Ajn4nW5TctGlY7P30GqcwlTD491StV7D3ht+Vp4iU34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq8Q/iGuRykEvO2zAOexPaPFwDdzevdm0uyovli85I27wMVeERJfMGKySJI6OZtRpP34yOOsCrUbd6DGezy36/LKdUDRLjMjhoDKPGdsQy1hiG2CxZNtXbkJZeFTlQ19ywnYtuDcEIIsIMgXI5OSI8crPn1Q6HPkiqbL/fluRDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tBMENFCH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45f257b81fso526830666b.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710754302; x=1711359102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWtISUwodUWf5D9bpBRIELFTYk3MIhDt6SrYrOAR6uA=;
        b=tBMENFCH9XxZo2OCR33HVbhvmxgyf9Kan5d1e7eQMaDslGwGa4avRDAw88BGy1XUUh
         TChk9l6BazVjW8esDBNf5Su/oqSoyLLmg0SdRByP92ByunbXEDGvHkkYcLD4ZVQj+Jk5
         iD+EgDJPegiG7WJ0WjFsUXhuCftJ40CSa5ILvxVfxM7UH5rowc1AH6tJ0MnzgXZXFfWG
         Dvw39ERINbXjxwvVugiJoFDqLQqRfxaMWHEMkftECLjzq1QFsBeE4XBnCy3uelyfrjaP
         GasHMepoLrvN5kg9EiAZm2ElSxA64AzvzPyo9Y9OzMsq8S7sip8J1UTaFCeX9qm5cndO
         m41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710754302; x=1711359102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWtISUwodUWf5D9bpBRIELFTYk3MIhDt6SrYrOAR6uA=;
        b=ijA2XLJsjHZ0O3K460OiLv3NnRgUu9G70d9XopnQ3VatnncvszPF2w8ZRIzy4RsYch
         BDPEnlHVdGTStnzsAVM74fkRE9Sgz51eeoOTcQkgKLwe3IQhv91WXvIukSjUrK4IL25r
         GXMsVCrF957eNZRqCzyo2ZOWf9nwrYTAI23XPzMTq7HHGwk/xRe/6x6hKBAyWxInbxUr
         1d/KOIuk0MAD17hjnrKOUefERHFBhlV1gH4HgOmPoWVPw9yEGVay7UuWiQj9lPN4YJEd
         Nz/R/XYj5LHqfhhUzg1n4kVYDxeKOHNpASEH3rmQkxQb5BjIm5tr7JqlJ44Wazthn1FY
         ++3g==
X-Forwarded-Encrypted: i=1; AJvYcCWqe6U+tp0ValZonvTMamlY8qHOjvSsxTadL4xuII2IJkrnV6TToqLa2YYd/JPh3cFAz/iMe+GnBLrp4nVMoCCl46qlIsbh
X-Gm-Message-State: AOJu0YwG9CtdrZpRIgEYNkepDLlI19kb3ZUUJrYRo3ekj8lHH6zKXVF9
	hJnx4RlXeqwMrIaaXYHFugrgKGQuhyG8YsxpaHspV3lPsHqSAfl2Q9UaawamsAA=
X-Google-Smtp-Source: AGHT+IEElJf6OpoXT/IYnUgbZjxy4zC9n3rIf3Ps9Xs6xT6OeL7DHm2VbgcjBwJIJaCapan+63Wf+A==
X-Received: by 2002:a17:907:8dce:b0:a45:ab8d:7271 with SMTP id tg14-20020a1709078dce00b00a45ab8d7271mr8014963ejc.14.1710754301913;
        Mon, 18 Mar 2024 02:31:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id wu5-20020a170906eec500b00a46bf6d890bsm841419ejb.91.2024.03.18.02.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:31:41 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:31:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Coco Li <lixiaoyan@google.com>
Subject: Re: [PATCH net] net: move dev->state into net_device_read_txrx group
Message-ID: <ZfgJ-txT-lTSrt6J@nanopsycho>
References: <20240314200845.3050179-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314200845.3050179-1-edumazet@google.com>

Thu, Mar 14, 2024 at 09:08:45PM CET, edumazet@google.com wrote:
>dev->state can be read in rx and tx fast paths.
>
>netif_running() which needs dev->state is called from
>- enqueue_to_backlog() [RX path]
>- __dev_direct_xmit()  [TX path]
>
>Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

