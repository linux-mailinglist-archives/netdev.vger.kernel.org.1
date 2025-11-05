Return-Path: <netdev+bounces-235848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68700C36A52
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F5B1A23DF2
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935C6333745;
	Wed,  5 Nov 2025 16:04:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119C320A24
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358688; cv=none; b=BrolHl9SOW1DL84KboKSmYBAZpZkyCI8cB5kLhjVhsDhi1T2GzIytY0Z8IJIqK9zaKjrb9IoOy7PLwgQekjg0RW2z6EpY311ieM5hzF4TRi/nLFaf9NVwkgJfiU3PoqFcvWUvxcZuCPctHyktYUVIyloUtaJQKxARF+S2GQ5E74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358688; c=relaxed/simple;
	bh=JofqSWCzl11ihkf1QS7aH5EerIGWNBW0jBvqMlbq2a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4EKlXJ1ZszkMzm8Fx21yuaO0VEI4GZyUlhA5DmKUrWBMLBS9gQFnUy7CRBuBIaRb4irBT1jdVhW/556XgUja1EWibp4Jn6a5HSApxTB1ZXB3UStyVq1iPRY/9PZgMPBeqm/o98LSuzqZVeNKOnc9gk5OkOEfywl7IGOWt/MxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b70fb7b531cso570532666b.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 08:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358685; x=1762963485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQtbK0HPx+N0NDzFM7oR+NUAI3H2NYy2UQCcQpjJkTY=;
        b=TlZuyjFgRAC/Nny2aLMzrklGL74OtIcL4IY9a/Ry4KBfGw8MYjxYyq5HhlV5V/7PQe
         ezJmduSggL+4vwgUDvZBv6/27cBYspXx/Xs++ftpP46FnWE4VauWH6e9TaQcPHs9bUvI
         J/A5BqPb7FDB3BPMHTIL0pQ/OrZpmHwa/K4AsN4Fxod3yuwR2RJd2mkcxq36Az2UtWpK
         keLm0iIu9ql5sBnJAOfvWeCF68RG3Kyo5KfqGhNH7Pt0MEZSxSC7K8qOeUX/EW7TM7k4
         J4DhY8itVwR4A+O5UiJET+XjuUgc66spim5cf07fj8qQh4lQdWu8WXpUm3ktKJ7nopsz
         ynBg==
X-Forwarded-Encrypted: i=1; AJvYcCVeHBSa3/0QHAVmkwCgTtYiQYOZHT6g+5FSj5HmJ3Ug+ZVsv8+ttm55EvbWarhsWd2uNXf6G/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFIbda469VY0+teEjTQaDyzeo9oCeQ1I8TtRI/tfaEA+msI8CA
	07cjOLd3cvaYjcaxGqqAEdiHtqTueQ+FynscscbMYghCsATXwUfjky8i
X-Gm-Gg: ASbGncuFqP+u7PgJ2q516AiLSixziy6i/XguZRQdA55nKZiv9pbK7RBjPMqjq5nnfhD
	iNl3tzqFiawpDy+cqEBR9JK+5h1g8EeJCtoRPV5yp2Hwx8Y0Dsnoa0d5W3ZAFARh6s//tYKbEBl
	7IeTNKAX/rt4iDkexRM1B6uS21GQJJ8OXJGvQkQK8jPpmXQBisIi27adY/SwpxrEhqypl/8yiY1
	02tQzYmBNSlzLWXD//iJgKSF8rJkcazO1jAOqDEB0EHBAboR3Jdb8WB9iHknDLYga3s8lSU9iJW
	elxeURkgKAfr3c9VIT6iXWxPEOGZTAP4oRrV8k1s/uiI4YcfKxeoKITXQ0ARLwYLbDwqrU1X1+h
	Gmm7xqQXRHxUENVRWLK3r0IGslyvPXK2vSDoofaNC9elFwxAyBQP52/o20DJHHbQi+Wo=
X-Google-Smtp-Source: AGHT+IFeg0PfZi72Z71d5ee0yOEa03D5xAyx6X2QALCBR3Xeog/mqq1XoLJB5RS10SM8/uMZFbIGPg==
X-Received: by 2002:a17:907:9815:b0:b71:854:4e49 with SMTP id a640c23a62f3a-b72655edfabmr373939666b.56.1762358685029;
        Wed, 05 Nov 2025 08:04:45 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2597sm528556266b.45.2025.11.05.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:04:44 -0800 (PST)
Date: Wed, 5 Nov 2025 08:04:42 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v8 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <sw7wovxj7l43rj2dkvapzl3w6rrbai5qje4zswz6xrxmmkyxtm@gym66qdsivwh>
References: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
 <20251104-netconsole_torture-v8-4-5288440e2fa0@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-netconsole_torture-v8-4-5288440e2fa0@debian.org>

On Tue, Nov 04, 2025 at 09:37:04AM -0800, Breno Leitao wrote:
> diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> index 6bb290abd48bf..57f5a5d5cea67 100644
> --- a/tools/testing/selftests/drivers/net/bonding/config
> +++ b/tools/testing/selftests/drivers/net/bonding/config
> @@ -1,5 +1,6 @@
>  CONFIG_BONDING=y
>  CONFIG_BRIDGE=y
> +CONFIG_CONFIGFS_FS=y
>  CONFIG_DUMMY=y
>  CONFIG_INET_ESP=y
>  CONFIG_INET_ESP_OFFLOAD=y
> @@ -11,6 +12,9 @@ CONFIG_NET_CLS_FLOWER=y
>  CONFIG_NET_CLS_MATCHALL=m
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_SCH_INGRESS=y
> +CONFIG_NETCONSOLE=m
> +CONFIG_NETCONSOLE_DYNAMIC=y
> +CONFIG_NETCONSOLE_EXTENDED_LOG=y

I've just realized that check_selftest discards the '_' when checking
for the order. This means NETCONSOLE should come before
CONFIG_NET_SCH_INGRESS.

I will wait for additional review, before updating.

