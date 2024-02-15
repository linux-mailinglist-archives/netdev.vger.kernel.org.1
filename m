Return-Path: <netdev+bounces-72045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AAC8564B4
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8283BB2EB6F
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA76130AC3;
	Thu, 15 Feb 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYD+Vn6f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9B130AF9
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004164; cv=none; b=jDEwxCC8ed5zCI6X+C/WxjhgQ9MwRhM4aG512Rx1guqvZOkf3QK4CpW4Ld6KsCDrVXitzMn9s93+7gl9+KrgXJPqCVggCvxBSMa3J6zZk7I+Nd6KCU9iH+EsXx78O01Vw3+7iO7YGgQAoRsTdn0Qz8RujC/rSD0Gmmr2H7wO5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004164; c=relaxed/simple;
	bh=a3l5AVYV4A2H6bqECMhlO1rAdI3K3fXbopdYny86144=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+fDkS7Q3JuSUNDjM+gHV+LCwO7m1acesbVAkhJQa5R9G6Uw1hzZk8hlz4x5iw2XiggKeJn3PFrgzvBfKtwPUF2W8d/ZpZs24AenSvHwA8BUexFrltMHogn47qjNk+o2U74izrhWtTT6XJwYxxfxHFnZ9ZqEZ9ApveWF5w+UNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYD+Vn6f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708004161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kPHa3eTqzxC/WkYdFvOjdhOTmbvuGHmnFpgQxouq2s=;
	b=EYD+Vn6fKmGaBad2Oy+m3MfWo6mttguurFgHf2ZJWzXKrVRCbruXPonS/+Hy+zrHMbMIWd
	UmvHq3rdtKa7BC7P1cR6SsUZkI9MrV94sHctzJvqNvGLqgFr4k+huKgorxzxk4StOMqjbC
	gnYIGep1XD0vYB+nNql+e9lWnP+pGok=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-u1050UiNPQq3xJkywBRaeA-1; Thu, 15 Feb 2024 08:36:00 -0500
X-MC-Unique: u1050UiNPQq3xJkywBRaeA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68f0167d7cdso9758926d6.2
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 05:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708004160; x=1708608960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kPHa3eTqzxC/WkYdFvOjdhOTmbvuGHmnFpgQxouq2s=;
        b=T+qLgilsJoYHCodbuMAtu5CBLsWHAoiktQ5GkYAhpBYFPngQDXJ98UAo/NpRDu7kWJ
         9LCxUGhcRKdZmkrD+MbWdsAKgctS6OnCyOs9AhWdj+9FQxxvszodG0dqh8MqwthrcVna
         JTkdiI0rfD8gTyzxOnXQ47AXqqMUYKldT29iP3qFDKGUrLeCsvEIHt0hU4fyFFKQKyYH
         3+0i4onZyvn/fug/YWMUx5aDNP3VZy5MA5P7rtvxQpqRQnt1IFISOHObnUoK9rlEdiyX
         pYc4ESFaxz6iFVm6Wr9YNSiICd6gNQ3AH3jByZEiMDsa4yy3gCRdQL+D2po8C50TCVHv
         4ttA==
X-Forwarded-Encrypted: i=1; AJvYcCUN4RFj/qhUNd3VeZ4ac+AtBr0WO+k0EXM+aGFpM38jC1XSvePATr1kHe6yQ8afm+0m663Bry4TNPkRtJpEtt1tmosSOQJV
X-Gm-Message-State: AOJu0YxFeObw21TNoy4DDcCO/ajTfcoHMZBV1TWztQlcF+wH5mklELYe
	SM7ulHuu1YSw02IP4HBxsrgnt3TW6N8LZBcPHXACSRCH0otSPcAwfIEk+70wbABDu0gU7haD6pn
	KaGQ4XPhube26lN3ijDu14UxjyGqzPA/qS9A7+w8lve/YBZZbDs3NBA==
X-Received: by 2002:a0c:aa5d:0:b0:68e:e9af:b5cd with SMTP id e29-20020a0caa5d000000b0068ee9afb5cdmr1524219qvb.23.1708004159877;
        Thu, 15 Feb 2024 05:35:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELJn6nDqy3rGV0OUx3SQIUtk6caCUWTq2dQf16nnwPm0wLSmDu/s/NDEDgzFQ1bmY42Q/rDw==
X-Received: by 2002:a0c:aa5d:0:b0:68e:e9af:b5cd with SMTP id e29-20020a0caa5d000000b0068ee9afb5cdmr1524204qvb.23.1708004159565;
        Thu, 15 Feb 2024 05:35:59 -0800 (PST)
Received: from debian (2a01cb058d23d60012146f54f8167b72.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1214:6f54:f816:7b72])
        by smtp.gmail.com with ESMTPSA id ld13-20020a056214418d00b0068f1237f904sm655637qvb.77.2024.02.15.05.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:35:59 -0800 (PST)
Date: Thu, 15 Feb 2024 14:35:55 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: Michal Ostrowski <mostrows@earthlink.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com" <syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] pppoe: Fix memory leak in pppoe_sendmsg()
Message-ID: <Zc4TOy4FPn1YaKb/@debian>
References: <20240214085814.3894917-1-Ilia.Gavrilov@infotecs.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214085814.3894917-1-Ilia.Gavrilov@infotecs.ru>

On Wed, Feb 14, 2024 at 09:01:50AM +0000, Gavrilov Ilia wrote:
> syzbot reports a memory leak in pppoe_sendmsg [1].
> 
> The problem is in the pppoe_recvmsg() function that handles errors
> in the wrong order. For the skb_recv_datagram() function, check
> the pointer to skb for NULL first, and then check the 'error' variable,
> because the skb_recv_datagram() function can set 'error'
> to -EAGAIN in a loop but return a correct pointer to socket buffer
> after a number of attempts, though 'error' remains set to -EAGAIN.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


