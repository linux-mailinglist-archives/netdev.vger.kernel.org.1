Return-Path: <netdev+bounces-170181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F20A47A09
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1433B0B72
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C29228CBF;
	Thu, 27 Feb 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyWlOHh9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525121B9EE
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651689; cv=none; b=nbc/61FMIkt4e/5C2137hlnkjHuxEXB9z8a03XY4i7Qdkk+MHXG9o2GAxl2QUdEiaasJoypVkFRXunKuI/152CYAGfUjibMWL69eCkFmVPgaxubUcZ05WsD0wrxsqvLWyrrjnkL82dBxnyqPvccs468LSI3WeHdWgdhoMcssH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651689; c=relaxed/simple;
	bh=o1BZNEVFS1dVMoSsBkXWjgk8R2fxCteTGGv8kH5FZRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWnD0LTwhLRIvJwrXBWlrk8cDqibccGR1YFsYvE7T/l0eDAqfmXZ7cIwGCXy6xZPjs+XguwAw0mvP0bgIRPM+3UFLpz1+OnBsqAwUuMyyffqyt28fKx0zjwhoI4Qo/TiWojA/wOyjYeVr6K59uAXO92uDeXgQKc4IihiMN4XtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyWlOHh9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740651686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srf0UyBfsQhgWVg+kEEi5uq5c/Ijj0vigRW8E83X9mw=;
	b=YyWlOHh96gOJ2Fu72+NeQG22NziiJAWzKRHIbc0zDP9Sc2URYqqu2GjtmigUIx9EBxRL8K
	mrPuDTKY6gi+xS/F/d22NaREuH0uU0pqBH7p8e7L6qtzVS7C75OQvLWGUgThrIPfaJUhsx
	TEEycyKHzN0YNW28EUaSGuv9CHnnHBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-ZhI1z-KGMrexmTDJ1a_q-w-1; Thu, 27 Feb 2025 05:21:24 -0500
X-MC-Unique: ZhI1z-KGMrexmTDJ1a_q-w-1
X-Mimecast-MFC-AGG-ID: ZhI1z-KGMrexmTDJ1a_q-w_1740651684
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so7925685e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651683; x=1741256483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srf0UyBfsQhgWVg+kEEi5uq5c/Ijj0vigRW8E83X9mw=;
        b=tFoSjCA1THUtpgeEnYxRq3vomvypgdSYXIHVk56bwfSJg0AZ6BU7gyGLnj5RFFWrwd
         L0RdwmsgQY/hh0OcVaBXwAQwX8DW1vJOqhZfecrkibyP640yOf1pkYs+rR4+TC2+5hPJ
         TaADpJs2hrs/90SSt5B6yik93pN4/A8RNneJnw6MhmEJf3HOSzv7W9j3ALeB2md9uL1n
         LtXoRfgLSUdsv3eutRbQHGWJNNtpJl8LDB0IZB4b5W17YiYcTZi3apJlg0cF20hHtS9i
         4/IJLH7zQ7aK8TCnUykxBnKreBr2gl1cxvSXLFvfuN6IqUHVW9ue3yne+jge3SHCwVlJ
         Fmaw==
X-Forwarded-Encrypted: i=1; AJvYcCUturoqxL6wrbZIAHg+Cwe9qYf/wL7FBA3AZOZWcDU4Rqiz7dHnCXLA+fJjsLLfMLRydwKu6cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0g2R2ujnyy88JOsZi1Z2mIHF4OUv4CUqtjv2/64e+ETsG6MjL
	cHgsOgkFBc9IQhcSqIeuP44jdIrbFD0J+Mzfen4uW17iaTwz4K8L4+FuKGPA822Ed3NnfGd4LM6
	QHehcdPZHnMVSH6s/ukhoUo1olacpyl5f3TjDE+B/CAQU6uWGiYzhAQ==
X-Gm-Gg: ASbGncv+vVJWJRQexYVhHTpZCi+vs4R1N8y/FAFZsAkI/P5qzOoOOJMELu+6IAVxULK
	mL7CWHVO80ijGjoIWMtoYBV7M6KjDUIBojY0LHOrzzS+fk5vuFnntQ/Vod11tizUPdZUfVDGS3j
	VvLC6smZpGgyKj5jw8KcUz7IpNufpQEcwgsIsY8CS6pKUf6gqUVBQ6g89wfAhZWRDmoSV4sCL+i
	BIsHomCipUezzRcZyJ7loX6AE/0AbEOGQC+S4RODpd71+HKU8p0IqH3q3+MPQ4cjimoBaVSdh/z
	iWhS0kALdsETsRazeFxRXEGDvDc364toTIPrvGuRkW8f5A==
X-Received: by 2002:a05:600c:1e12:b0:439:9536:fa6b with SMTP id 5b1f17b1804b1-43b04dc34d4mr22315395e9.13.1740651683690;
        Thu, 27 Feb 2025 02:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZWDrKeECYxNJn95VcTyTz8lUpAL/ZnP6A7sgL8cGevFRSHtccOSsEA7TN+V3kF26FxGrMmg==
X-Received: by 2002:a05:600c:1e12:b0:439:9536:fa6b with SMTP id 5b1f17b1804b1-43b04dc34d4mr22315175e9.13.1740651683369;
        Thu, 27 Feb 2025 02:21:23 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73704228sm17949285e9.15.2025.02.27.02.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:21:22 -0800 (PST)
Message-ID: <f58b63fc-43aa-47ff-8ee4-4f515f7d7a7c@redhat.com>
Date: Thu, 27 Feb 2025 11:21:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 8/8] selftest: net: add proc_net_pktgen
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
References: <20250224092242.13192-1-ps.report@gmx.net>
 <20250224092242.13192-9-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224092242.13192-9-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 10:22 AM, Peter Seiderer wrote:
> +TEST_F(proc_net_pktgen, dev_cmd_min_pkt_size) {
> +	ssize_t len;
> +
> +	// with trailing '\0'

... same here. Much more occurrences below.

/P


