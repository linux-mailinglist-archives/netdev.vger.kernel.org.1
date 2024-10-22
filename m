Return-Path: <netdev+bounces-137783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA19A9CBD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8439A2830EF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B089156F34;
	Tue, 22 Oct 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0Chc5sA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB927735
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586156; cv=none; b=YHgsLnwGxNgY5AjbSdy2OPq8xeV2ELnF+lf3Pz4BMRXzDULLGkVm+zKe97JmqclLNuwTljGNwn9eUxye8Nu/DJdsQaYNEo4mKnUeBvPXsRegRWXAIbH47UpQlGQuaRYL9YhtPwvBijlih3vxiqV18WFOo+Fu+9X7Xa8bBGlp34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586156; c=relaxed/simple;
	bh=AJd4nz3SwmMQN1Fl54one4+xJDpxWhjRKzA/JLD4xeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8axPcPMw0bvUkb0WkSaOEhiZ0oHjgfuYhIa54OxwwAeXcw0Mqzf3LC0jCi2yvaevCSMC/UqTGwOb+bM9Z33lhvz+/Y7uP4Fcppx8n87v2BUDN+GGLqxYNUnB1DVSzk85XMf0lppsTtuVL+y7p9pUp17N3YAm1huu7m9hplPZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0Chc5sA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729586153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzjKklXzo6OrrskJkfn/WE8tXPOW2rhmU19eAy/0Lwc=;
	b=Y0Chc5sAPTYGCF73qNsfawhOWiuVWUtrbLs1N16q3BoBkWxdmuSjby986YG9HGVbptYXTG
	3E/prrNhyJtPc4BjRCnptBywicCVRfZsDuAR71x7nLz++OYkA2ZRl98sYJTJaHAzvZAupL
	alhEPqQfI2GDxeTAbCeNVnbPNe1jHHE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-xZ_WuHgANaOma34d4ggw6Q-1; Tue, 22 Oct 2024 04:35:52 -0400
X-MC-Unique: xZ_WuHgANaOma34d4ggw6Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315af466d9so37139715e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 01:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586150; x=1730190950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzjKklXzo6OrrskJkfn/WE8tXPOW2rhmU19eAy/0Lwc=;
        b=SQm4YsJfXpvE8+AdwVxeDMNiscuvOxhh5kAGtkI93oR3dQ3FNi2Jh2jadDpYiMqgr6
         S+SLlf90Sib9/BzdvdV/BuwNTTbIFMA4Xtaf1WD9HzkDzPt0jTVr2Snv63146jrGfkRY
         8kjCLGgE03nnUztdClPSAB4Bzglpuelw8q7H7wQs5reh1kNPEEemefdIy+xTTzW6cNCG
         PxdWoVWebykah7eQheHazPwhxGX/rKiyu+hOTYjj8wb/Dyv0JK/KrM1SIDQZTpkZXv0/
         6iIc/fz27H6qezQKwXba3b+Sq9N87FcyitYP08bda4FeGTwnS9BpOqKRAQRIZcLBMozX
         MyGg==
X-Forwarded-Encrypted: i=1; AJvYcCXb7qZrSEERR5kqudFg8adCKdvCUVaSc0svpFF6MVJGYvch2QyuBNa+lqlNpe4IMoCuvykRpRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5dax18tU1oBrSoWjjAVlUX4wdHb1Eusq1No7ktUUFHmmAuqj
	nEimvK5DqD086IYd2kpkfvBGsPNws81jPWpJqnES0rM4crHmQWrTGohjSmxfbzhTEF2o21ChKbw
	oeVYPeCxcZ7a7cRqHoo+KwnX0wCnaKQcDW8y9SFY6ce2spCna7py91TKs+Ajx8MCN
X-Received: by 2002:a05:600c:1c95:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-43161655ff1mr116620915e9.15.1729586150405;
        Tue, 22 Oct 2024 01:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENMnWqhohFK9XsPvwXv/N+ctxRpVll7hYuMyQxSroTiUr5UDlOlnF3W50MOgFsfGichCSm1A==
X-Received: by 2002:a05:600c:1c95:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-43161655ff1mr116620675e9.15.1729586149978;
        Tue, 22 Oct 2024 01:35:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fc36sm81629975e9.18.2024.10.22.01.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 01:35:49 -0700 (PDT)
Message-ID: <5b7dcc2b-b3e5-4889-b0ff-6c341e4d9154@redhat.com>
Date: Tue, 22 Oct 2024 10:35:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 07/14] rtnetlink: Protect struct rtnl_link_ops
 with SRCU.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241016185357.83849-1-kuniyu@amazon.com>
 <20241016185357.83849-8-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241016185357.83849-8-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/16/24 20:53, Kuniyuki Iwashima wrote:
> @@ -457,15 +457,29 @@ EXPORT_SYMBOL_GPL(__rtnl_unregister_many);
>  
>  static LIST_HEAD(link_ops);
>  
> -static const struct rtnl_link_ops *rtnl_link_ops_get(const char *kind)
> +static struct rtnl_link_ops *rtnl_link_ops_get(const char *kind, int *srcu_index)
>  {

This lacks an 'acquire' annotation to make sparse happy. Similar thing
for the _put() helper. Also if let such helper to cope with NULL ops,
some dups checks could be avoided in later code.

Since the netdev backlog is huge, I don't consider this blocking, but
please follow-up ASAP,

thanks!

Paolo


