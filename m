Return-Path: <netdev+bounces-134246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C9199883B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E67B282D2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4B21C9EC0;
	Thu, 10 Oct 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUYm15EJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AF1C9EA6;
	Thu, 10 Oct 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568133; cv=none; b=rW57xrTRpeQ+bs+0OQ4hb5X5GFAvMbfVdMT3iYG/CAwrlEGIVV5Z8f9ETMKvLMYK7cwHHH3HS5IdGXvDE1R9pZCjlqabSTWMoZSc/U4fmEarKqrtl6p8Spi5sUkPhQwqiWkBC+QCSLsO0gBMvDHbH4Cs+FU43jADL4EsDqSjo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568133; c=relaxed/simple;
	bh=q88PaOXxlyLikiecdx9tJqSk2/WmYt2SNfx/eL4fEtc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=b+2dH7Z68A7+YonipviWCSc+AhGnpULrFy7SeKNe70VPV0uCwzXporS6jM+cAc8LtuU+tByAhYaG8TGz8wbpiREKk2rifotq8/a4Mcy32EgT4+Uu2QraZpRjJq8q5+AyENhlvyXITQaVve6ZpSyd7OXM7xb66165KeOuDYnvxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUYm15EJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460371bfda4so7604971cf.2;
        Thu, 10 Oct 2024 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728568131; x=1729172931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDE361x27Fkhh98NbTeMg0ri1vOug4Eeh4i7aXvOKX4=;
        b=hUYm15EJSta4bmrS4GaSDCH8fi+9HpwRncBw8h/si8+Jo7jB5/hVvMBI9Ty2MERsJM
         O94T7yKMHYZZcPRk2gfIWser/kyRQ/J2OrOUT/c4WpVJ8yHgh5KsIVp1imZxLq3CYgeK
         SDFDIpKkrWPCPYva0acYhnzJ2jVjsOIOvW5LLbWPF6RHs3NT0ezIrLF+XMGn4CsszJLs
         v+ajiap6ORxSxT7OovH2lAxTsUT3gCFwWHXszAWaXCvh2CtwSY+ZXWEx6eoxC/PTETFF
         utkjCpQOTiyk1oiVBG/3o1Ne+FZuocInh52gxjk6wQFhDXzsOuM29/yk2LTxXSlh3Rp6
         sYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568131; x=1729172931;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YDE361x27Fkhh98NbTeMg0ri1vOug4Eeh4i7aXvOKX4=;
        b=aQmSK/CqJGsQxKel6XcmaGNYpyjqqyD4fPIG89HvrNpErw64AVjCE5f9wiLgmgsvVG
         3XbLaGssofb5aBZJsL+64iv9xNiB7wllbZrq9YAoJUN54lMVmsFrHE8JqyMWe/1hVyqu
         NVlN7zm9DvY0rlJH5WA5yJm4li1AfAqm07ok1h8YqUlaSz2vK1vxedqq2K4DIDQDSwVM
         MQusEN8+gHFdGZDUJiayXNFRvxUUZVnrVGuYEWxKpZaPmrYDHw/1jBzYoXZ9KnCUFnfG
         +Wf1vJVb4591pT9pyJcfbsOhDI970SmaUCXQfqwHOJ5MdhrgaXgalMQy+UNXzjVtqI87
         8Lbg==
X-Forwarded-Encrypted: i=1; AJvYcCUbVGqs/K8rznGaEPs+s1Q4+lVmEVKPTmdo7B7PIjylhm/jS6kU5cnFJk5E/PZ3FWEp7BMmwZsK@vger.kernel.org, AJvYcCX4JFfgC4GKqtQg3pU03HfrT7sGrY8oYQOUXslw6nOYY9olA0i7D93C9PvR2xog6jzKwfYLGvGC7dpfMfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya1ofK75/Tk5fmg2M4iO3LXubAaPQocLBlOfdlbE66P4ZnTWyz
	Iheajw8ctEIBhmkBDxnuRQEdh0hOOVQWtlBrApNd22xCsTnAcmR1
X-Google-Smtp-Source: AGHT+IGAhm/q7RCDbWtzdnKOWVcL+Gow0s3PGkI5q0W2fQOP8gDRcELKuNq1CEQ0JZB81+1u2Sxhxg==
X-Received: by 2002:a05:6214:5bc7:b0:6c7:50bf:a443 with SMTP id 6a1803df08f44-6cbe4ab2cdamr37935986d6.30.1728568131209;
        Thu, 10 Oct 2024 06:48:51 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a5b8asm5579586d6.14.2024.10.10.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:48:50 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:48:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Philo Lu <lulie@linux.alibaba.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 antony.antony@secunet.com, 
 steffen.klassert@secunet.com, 
 linux-kernel@vger.kernel.org, 
 dust.li@linux.alibaba.com, 
 jakub@cloudflare.com, 
 fred.cc@alibaba-inc.com, 
 yubing.qiuyubing@alibaba-inc.com
Message-ID: <6707db425cc49_202921294a9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241010090351.79698-3-lulie@linux.alibaba.com>
References: <20241010090351.79698-1-lulie@linux.alibaba.com>
 <20241010090351.79698-3-lulie@linux.alibaba.com>
Subject: Re: [PATCH v3 net-next 2/3] net/udp: Add 4-tuple hash list basis
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Philo Lu wrote:
> Add a new hash list, hash4, in udp table. It will be used to implement
> 4-tuple hash for connected udp sockets. This patch adds the hlist to
> table, and implements helpers and the initialization. 4-tuple hash is
> implemented in the following patch.
> 
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>

> @@ -3480,16 +3486,15 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
>  	if (!udptable)
>  		goto out;
>  
> -	slot_size = sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
> +	slot_size = 2 * sizeof(struct udp_hslot) + sizeof(struct udp_hslot_main);
>  	udptable->hash = vmalloc_huge(hash_entries * slot_size,
>  				      GFP_KERNEL_ACCOUNT);
>  	if (!udptable->hash)
>  		goto free_table;
>  
>  	udptable->hash2 = UDP_HSLOT_MAIN(udptable->hash + hash_entries);
> -	udptable->mask = hash_entries - 1;
> +	udptable->hash4 = (struct udp_hslot *)(udptable->hash2 + hash_entries);

Unintentional removal of the mask assignment?

>  	udptable->log = ilog2(hash_entries);
> -

Unnecessary whitespace line removal

>  	for (i = 0; i < hash_entries; i++) {
>  		INIT_HLIST_HEAD(&udptable->hash[i].head);
>  		udptable->hash[i].count = 0;

