Return-Path: <netdev+bounces-214942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA0B2C395
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438081885585
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC2305042;
	Tue, 19 Aug 2025 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBY6yyiU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85730504B;
	Tue, 19 Aug 2025 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606430; cv=none; b=iGLiemTawOq+zxgehQnh+pxHZwylrI86j2EOsGpOl0/GvPtbh7LXkyIcOK+lPvhD0RQnJokKNg3KiUNNg6yfE3U/XEzU8zOpUN3Ozp2AlWVZ96lomgv5RK7JVq0zN1eBmpz6GlHJcV37qJJoxsGmvcBwDgBXPmx2mBHql0/hssU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606430; c=relaxed/simple;
	bh=sVy+VJbFD3YF1p4lFrRtr69nxZbQWOec0xOFwgGmD0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyDR8miErcvkfmBTOMXkhgGm0PJRpmXSXmWlBIrzIdY4tL6TTqeu6y9VUn+XWnwDPCg4onJ4gPh/X6F7bv3GK8GPp2vngvqnkaf7i3UgaILoEFe3GLtMQQPIdXaYjfCMFdxJZE/e5X+JRLbIGd9KuyI58iMjUifwSbFNZNA/jb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBY6yyiU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e87061d120so512337785a.2;
        Tue, 19 Aug 2025 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606428; x=1756211228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLo6P75Te8N885LOfTcwvSUBepuV8X4lYUZFLoZoR8Q=;
        b=UBY6yyiUEFFX7LBAuWaCFqhG2/Q0NScX5V7WqcmQQXs9PseJYJuofEblY7tSgIJwhw
         1av3ppDE9z/ag5Tss9XUUPWSpbXpiFtrtCjPgbDTO//P8Qzlhgiyuon14EJCzjuenuGD
         35LbbYmnqQJPD/08oZZdrQ8CxsdBKnZU8O2KU9RYExM2e0+hX6uy3XN09mZsxikQSGPm
         p9XpXXHUif0jAzPEZhAE0jKnBfO+BA2YjOeSZ/cZBGl+9qdjcCbSDlFcN8JMFfctn9p3
         dpYMpBet0dsy4zKLtuO1OGRin/gtxditX88oOrLyBa/UDqTVzF/0gf9Zs9XpjSQG0lQc
         XUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606428; x=1756211228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jLo6P75Te8N885LOfTcwvSUBepuV8X4lYUZFLoZoR8Q=;
        b=axffrR0UM95Kj6XOG2uRhGdi5nBs2Qj0nbKc654TJ9BXYv5ACMiJw66z6jB9A3/GOp
         3DJiJ5PmRLu8YnmRnJZ+6i8zo+0oZVjcXlMDGBpJv9mMpIrUM6OnQWTQKfTeQ2TksGES
         VgicFk1BF8mAXXi/F7Kq4DBR6S8eQxKwopDkylsKEhgRNSaFx5kWrYg1C/HkJYicWoUO
         B9fOpvRPinoTQ+zBzf6aaQKdu7GzOkxWDA2rKAd+koKJO7aao835WkI9OHwCg3C8VlGH
         Zjv2hMCYZwuJvH4eN78cAvuVqLlq/3Ph8xdLL2hbmPwneDeX/Xy34XgG8dwpt8D+hQBK
         qUXA==
X-Forwarded-Encrypted: i=1; AJvYcCV0eRuCbA6xAMBbFExf1iXkQnopPRYj0wFcUHFBrUDZ+d0R/Nvgb+Oqd+x3OprgkhX3jF+KRSuD2araO+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfD07BLvHr4xspV0B0LlF+J0gl9DROe31UvXgKCME90Lg+Mi7
	xCPczL3dUrKqg7FRAsHDHADQiOJT3/XvAK1RSjp6lNHq5vGVN96koF77
X-Gm-Gg: ASbGncsncJL9HF8kjethQTPjDTCBdslUOwe8lB3PUDK/P5RsJHijHaZaKgfsl0wUdEs
	h1n/2Ia5Fg/kxxCGqKNhhS7HtzO71LvdL0CtR+XIUkkFWZ6l4KSJX9KyfeMBSVD9cJaEH4NWwN5
	rWphDugrRDZHP9lknu5H9UrenyU9Hr5Nz9299LUSC5WKiQ87Gd5DWQNPerqj/N2XI37FAGXWNGc
	GjSGZY08YQDXflK/KoMqw2IIER3Rfwmvn660w3GE2DrV6s8BL5GWu1YmcFf/nfuek+rMDmLCBpe
	9rMwa2GKOVsyFXkufPHhycazHfHgWvm6xSRbGRsLQp8T7tHWVZsMeXBj9MRsd8KIxegI67ra//d
	PPnSyZfC8FXwcK/pYXASTv7w/Sii//ad2T9DJBc2XVVRK
X-Google-Smtp-Source: AGHT+IEsNIv+tEsilZmDq6HbF1TCnVCUZ/jSH0J4vWVFSQl2ouFNJOZtUnByHd3uAduNdJd9Cox6hA==
X-Received: by 2002:a05:620a:31a9:b0:7e7:f84c:9d6a with SMTP id af79cd13be357-7e9f341f76dmr216699385a.32.1755606427892;
        Tue, 19 Aug 2025 05:27:07 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1bd862sm751574085a.61.2025.08.19.05.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 05:27:07 -0700 (PDT)
Message-ID: <6533e1fa-2528-4bee-92fa-6f2d1a44d906@gmail.com>
Date: Tue, 19 Aug 2025 14:26:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/5] net: gro: remove is_ipv6 from napi_gro_cb
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250819063223.5239-1-richardbgobert@gmail.com>
 <20250819063223.5239-2-richardbgobert@gmail.com>
 <CANn89iL8XHOeBbq_73SiCEEhYrudeDVagtr=K6wpEkh9JuZV6A@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iL8XHOeBbq_73SiCEEhYrudeDVagtr=K6wpEkh9JuZV6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:
> On Mon, Aug 18, 2025 at 11:32 PM Richard Gobert
> <richardbgobert@gmail.com> wrote:
>>
>> Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
>> This frees up space for another ip_fixedid bit that will be added
>> in the next commit.
>>
>> Using sk->sk_family is reliable since udp_sock_create always
>> creates either a AF_INET or a AF_INET6 socket, and IPv6-FOU
>> doesn't support receiving IPv4 packets.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  include/net/gro.h      |  3 ---
>>  net/ipv4/fou_core.c    | 31 +++++++++++++------------------
>>  net/ipv4/udp_offload.c |  2 --
>>  net/ipv6/udp_offload.c |  2 --
>>  4 files changed, 13 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/net/gro.h b/include/net/gro.h
>> index a0fca7ac6e7e..87c68007f949 100644
>> --- a/include/net/gro.h
>> +++ b/include/net/gro.h
>> @@ -71,9 +71,6 @@ struct napi_gro_cb {
>>                 /* Free the skb? */
>>                 u8      free:2;
>>
>> -               /* Used in foo-over-udp, set in udp[46]_gro_receive */
>> -               u8      is_ipv6:1;
>> -
>>                 /* Used in GRE, set in fou/gue_gro_receive */
>>                 u8      is_fou:1;
>>
>> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
>> index 3e30745e2c09..261ea2cf460f 100644
>> --- a/net/ipv4/fou_core.c
>> +++ b/net/ipv4/fou_core.c
>> @@ -228,21 +228,26 @@ static int gue_udp_recv(struct sock *sk, struct sk_buff *skb)
>>         return 0;
>>  }
>>
>> +static inline const struct net_offload *fou_gro_ops(struct sock *sk, int proto)
> 
> const struct sock *sk
> 
>> +{
>> +       const struct net_offload __rcu **offloads;
>> +
>> +       /* FOU doesn't allow IPv4 on IPv6 sockets. */
>> +       offloads = sk->sk_family == AF_INET6 ? inet6_offloads : inet_offloads;
> 
> 
> Do we have a guarantee sk->sk_family can not change under us ?
> 
> IPV6_ADDRFORM is available to UDP sockets after all.

This is a kernel socket, and FOU doesn't use IPV6_ADDRFORM.


