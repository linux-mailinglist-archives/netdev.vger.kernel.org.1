Return-Path: <netdev+bounces-268200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNMGMa0ouGnhZgEAu9opvQ
	(envelope-from <netdev+bounces-268200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:58:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025B29CDD6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14551300D34C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11F43B8BB5;
	Mon, 16 Mar 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrupKDmh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727773B8927
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676711; cv=none; b=GnObcX5ELkBUA3E8rbJ8u1qF4QOPu63YFdipBNvLCuVvBkUXIkFto1xugZigg8Z4+1MX3JieiT1zOi7A8LdBf5ndJ4/cc9Ej70RtB9jdHjn+qswzil/V+Ob9tEHXaHVNc9+aXK/VFLtdhjDOuqH8ZpnCOjBDUBFDhqEpmcEefC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676711; c=relaxed/simple;
	bh=OY1/RbahkP05b+UAHG7/2uToN3q4GobS9evAN13Jo2Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pPr3uCeAeO1ChJJSVfNhOtNKTV1ImWQuc6tFvQm8LO7OyutgV9WqzKOj2/pwPJhtiiUtfirf3t4xQXrpREk2dFAblGS5mp1hYsWbkr1zkKTCZiE5Y9JclfyJn3k6giHs0LhoRk8dQE5sKS5LWqpCFeYRA/AgvPz4uDJN9IUZye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrupKDmh; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd79e43da3so495475485a.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773676709; x=1774281509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UDRIrCeX9M+cuSUyxGBfgBOvHpbuegLtrQs0giUKdaw=;
        b=hrupKDmhAbYsFfiGm2lyTnAun/Y/fTXcnsbDKjQ54LLtoxd6OVJV4U8PCftwuaIx9o
         no9CoskfXvevOXVZ6HeD1aCnqFq0iVEKFN5YiNlPitdfzJ0JdAC5prw/Oj1vOhBuSbh2
         We03QYjPJGvpDuxdsgywyLZe5+AqQJBwmIrSv2LSHlNFvA4Eo/MAbMJfCAjA3D7OLxXx
         VHHG0NU5iIqGhUhH68UFtTkSSjg2bd1LraA/8jZanbdzApiZ6bgL1v5y+HbAauL11RaJ
         9RrlI+GnJnhyBoM432CNp/WYVEFhKt2YjmKU2tFAWCC0vys/FY1vWaYWXjzpyJg2d4zv
         tlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773676709; x=1774281509;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDRIrCeX9M+cuSUyxGBfgBOvHpbuegLtrQs0giUKdaw=;
        b=Rx3t1h5bNSS7gvEvJbQMCK+1Y3Ayj8QifHzC/dMMTMHPwEZ/s9vEk6fL14wl1iyWMS
         zKyIbsPsBJNvAIYg+85snsmMssZShkJXfhemYNFrknmioCmkPK6fgjjogJTqpbNXFqfL
         fniN/6HOd9WnWqBqdAWTcxXNP0vVbQ/avJeTbypYfU95atwJI0C0l82kqdFtELhvvVNp
         L7SP+yXxYXod5P+LQ9Muq1VJ644GyacxyC2J0P+qlPAog4MjRHQnG1orKjqFga/s9Xjq
         XIyf6DV1R3YuLZa5R+He+2axndmOrsLlfAJsYXyP8/gCdijPGRqYfJEMRrQlcFv2s66R
         oSHw==
X-Forwarded-Encrypted: i=1; AJvYcCWLWFMHfGw2H13jk/oGDPRZpR/H3kRX4Yrl0oivoW1+prR4VMeQHC7P+PSq8pyRup3zLPDKFPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqdEWsUEWyaHUElbG3C1JJvWS+/xPhJ+9ZJjCj7Bzktby56zK
	e6YrZSxO2njy8HEL0tEhoMt9I3wDmE9mIBxFShuN+2jRRwR7TxyEEUVl
X-Gm-Gg: ATEYQzzads4sDFtDH5py0AeYtBEsofvNJjMxq/b1/nc3fzArgMW+gsaYdnNaDvy4sj5
	6uIcKXMmbrESzVrFLwuBNqWj4GUVTkGdyOMYvhpJC+UXfCnnzTMT2eFuiSbbshkeIS/RhIuf2Re
	GbMMxkGy06SQRj3YpUOtUbWFODfzfa1J3k64MxfI7AkRFI2UJ0Hut6bNFM+n7cIAT85gEjPeEL1
	Qehyb1+BFGrzfG5rptC66WzgnUyNCv/1qORYI/+ytLX0FBS2rHx0Wm/yLpArKiN+oWJ6KHT1Rf2
	zjZG5/P2sksQnZeQlyfG2ldOrGL3Peb6pe/NUxBxDB87Sd6CZmbC1xVPTUWU6zhkzdH3miCEfj6
	NSEqltj3EpxVE1ud3ioGCeFUqwr6e2kThs0eLHfryo1X7lcUXcWIelT06LyTIA2E00lgxerST31
	kZEAzDhpPCR/PQ9y96K1pDpPazsJjA0mPyNOMaclnJmSvBV0JOp7rbFf9rIuCYWRrOXHXtS0VTM
	50u2yG4cOIuhjY=
X-Received: by 2002:a05:622a:14c:b0:4ec:ef62:8c81 with SMTP id d75a77b69052e-50957e248eamr183509071cf.47.1773676709423;
        Mon, 16 Mar 2026 08:58:29 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:55eb:f818:94d8:c2e8? ([2620:10d:c091:500::2:9015])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939e8e0ecsm122031931cf.5.2026.03.16.08.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:58:28 -0700 (PDT)
Message-ID: <258780b6-f0d1-4a96-87a8-f26cd4fe595d@gmail.com>
Date: Mon, 16 Mar 2026 11:58:28 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: Re: [PATCH v5 net-next 3/5] psp: add a new netdev event for dev
 unregister
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
References: <20260313182804.696100-1-weibunny.kernel@gmail.com>
 <20260313182804.696100-4-weibunny.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20260313182804.696100-4-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268200-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9025B29CDD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/13/26 2:28 PM, Wei Wang wrote:
> +
> +static void __exit psp_exit(void)
> +{
> +	genl_unregister_family(&psp_nl_family);
> +	if (psp_notifier_registered)
> +		unregister_netdevice_notifier(&psp_netdev_notifier);
> +}
> +
>   subsys_initcall(psp_init);
> +module_exit(psp_exit);

INET_PSP is a bool Kconfig option, so psp_exit() is dead code.

