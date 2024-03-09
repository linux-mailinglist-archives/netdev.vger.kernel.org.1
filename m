Return-Path: <netdev+bounces-78997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F7287741C
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 23:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C316A1C2099D
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490331A94;
	Sat,  9 Mar 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="epPTNwV/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553E3C32
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710023733; cv=none; b=EJWTFYE0SqCpPFbU2Co68Ab4o3mvu5xVTHlUBVoSxWLY4Xoju8JC3RXGlE8guX4JnTx+t7tMUApyBNfUTJmtUlMtT7ICkXAz/APviAMXwB/DW5BCEUKXrEg7hkDwnFkuOVgau7hnBq5JX6oHOUzdLWEwrwruyCVgsy4cZFmCYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710023733; c=relaxed/simple;
	bh=DLARn6WutcT92wszThPbF5j/Zn7hKLv3J9m6baeEOnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAKjQJ51diinXax7yw7f0sK65YQhLF8KGIskcIwuaiVkon8N/jcacKrVk2VP1KdbNkkENSxpg4y+d+M9Nkp986fYv2sU69LTqkuWXuuInjX1rzGS3ByooxQD93KZtdCfBuI90hxLD69gyriSp4dhVQfrQP+RAnmTtCISzBpGwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=epPTNwV/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2714336a12.1
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 14:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1710023731; x=1710628531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euUIUFxAA1qT7vkhDymAmb4P59zQtw0t+qtEjnSmsoA=;
        b=epPTNwV/mityMnne8G+p6lE/qKrHDi+IJGZPFQ+Ag5w3+rmi4Kn1R/zfyCEkpdA7Ol
         fCzhl2HLcSnt2bTH3YAGN8OAgysTBNCQ0ndMRP4IsSN+v/pyncXLmYHUta3kesHpSIaT
         +AGLVbNmELyYBIYGqTRc8VnX8xYZPFuN43JWCBA1VobkLzD22jYsvTqSFYsO8X9g0xCe
         bqNx2t8KHQzl63NjgKsiI5dj7J7rChmsTIP3KYHOZ7+skGh0New25nrb/BKFZ92exxi3
         McTDhpmtsBknbof0B89c0/4VCjG5SZ1+/bTionIFv4PBzQAkS7zl+0urLwkkgtwgl3ck
         ZJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710023731; x=1710628531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euUIUFxAA1qT7vkhDymAmb4P59zQtw0t+qtEjnSmsoA=;
        b=Aj7bkrOPyZoqJrS4ptW6wyCuNkxd0LwX3nOei9b2ClI+sVJJFnJVTC+EfJa1AaSM/8
         s1XBtJ5TpPQrQB4kRYnh9tSzs1v8oJxKbCZmbG/HueuCk4NDfu2Ilv4XtQ+ojF9ROuQt
         PhAmCpnl3LdB548Yns94dtepGxyeffmJglH7JyGxWfzjP8Xtx6Se8DZFsoHanWF30Qak
         iVrcKiPBS6muLZLoCvnniGb8RJwCQ+0xGZA1KoNfsl5Jixg+sWhwHF5IFon/XikGoxvP
         9bYC5Sj0rp+gjA7imTMnyVIVBAUFEEnL00oL8FyWI0dyOSIqoTR7Nw1M+mGJMUg8i64N
         bSmQ==
X-Gm-Message-State: AOJu0YwdvyHvrr8A4ckfpuAQHomBJmSvEKCiJoK9/c7oY60HG1QcOLt/
	5zYsF7dnRTHNql0YxPTFYRUeXDIC8Q6c1cwaxdc8wRiHRiRPtpy9DCB0kILpmBY=
X-Google-Smtp-Source: AGHT+IF+n1w+NSs91R8SBvElyFi0a9Ix/d9IP0CzuScunpfAJ7yLOz0q3q7Wicz6VdZL05Y+rXTHaw==
X-Received: by 2002:a05:6a00:812:b0:6e6:3920:7a26 with SMTP id m18-20020a056a00081200b006e639207a26mr3024985pfk.3.1710023731427;
        Sat, 09 Mar 2024 14:35:31 -0800 (PST)
Received: from [192.168.1.24] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id 16-20020a631650000000b005b458aa0541sm1683602pgw.15.2024.03.09.14.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 14:35:31 -0800 (PST)
Message-ID: <dce00532-d893-40c6-9ec4-df7ad3f47d7b@davidwei.uk>
Date: Sat, 9 Mar 2024 14:35:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] netlink: create a new header for internal
 genetlink symbols
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, kuniyu@amazon.com
References: <20240309183458.3014713-1-kuba@kernel.org>
 <20240309183458.3014713-2-kuba@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240309183458.3014713-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-09 10:34, Jakub Kicinski wrote:
> There are things in linux/genetlink.h which are only used
> under net/netlink/. Move them to a new local header.
> A new header with just 2 externs isn't great, but alternative
> would be to include af_netlink.h in genetlink.c which feels
> even worse.

Why is including af_netlink.h worse?

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: kuniyu@amazon.com
> CC: jiri@resnulli.us
> ---
>  include/linux/genetlink.h |  5 -----
>  net/netlink/af_netlink.c  |  2 +-
>  net/netlink/genetlink.c   |  2 ++
>  net/netlink/genetlink.h   | 11 +++++++++++
>  4 files changed, 14 insertions(+), 6 deletions(-)
>  create mode 100644 net/netlink/genetlink.h
> 
> diff --git a/include/linux/genetlink.h b/include/linux/genetlink.h
> index c285968e437a..9dbd7ba9b858 100644
> --- a/include/linux/genetlink.h
> +++ b/include/linux/genetlink.h
> @@ -4,15 +4,10 @@
>  
>  #include <uapi/linux/genetlink.h>
>  
> -
>  /* All generic netlink requests are serialized by a global lock.  */
>  extern void genl_lock(void);
>  extern void genl_unlock(void);
>  
> -/* for synchronisation between af_netlink and genetlink */
> -extern atomic_t genl_sk_destructing_cnt;
> -extern wait_queue_head_t genl_sk_destructing_waitq;

Checked these are only used in net/netlink/af_netlink.c and
net/netlink/genetlink.c

> -
>  #define MODULE_ALIAS_GENL_FAMILY(family)\
>   MODULE_ALIAS_NET_PF_PROTO_NAME(PF_NETLINK, NETLINK_GENERIC, "-family-" family)
>  
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index da846212fb9b..621ef3d7f044 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -59,7 +59,6 @@
>  #include <linux/rhashtable.h>
>  #include <asm/cacheflush.h>
>  #include <linux/hash.h>
> -#include <linux/genetlink.h>
>  #include <linux/net_namespace.h>
>  #include <linux/nospec.h>
>  #include <linux/btf_ids.h>
> @@ -73,6 +72,7 @@
>  #include <trace/events/netlink.h>
>  
>  #include "af_netlink.h"
> +#include "genetlink.h"
>  
>  struct listeners {
>  	struct rcu_head		rcu;
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 3b7666944b11..feb54c63a116 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -22,6 +22,8 @@
>  #include <net/sock.h>
>  #include <net/genetlink.h>
>  
> +#include "genetlink.h"
> +
>  static DEFINE_MUTEX(genl_mutex); /* serialization of message processing */
>  static DECLARE_RWSEM(cb_lock);
>  
> diff --git a/net/netlink/genetlink.h b/net/netlink/genetlink.h
> new file mode 100644
> index 000000000000..89bd9d2631c3
> --- /dev/null
> +++ b/net/netlink/genetlink.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __NET_GENETLINK_H
> +#define __NET_GENETLINK_H
> +
> +#include <linux/wait.h>
> +
> +/* for synchronisation between af_netlink and genetlink */
> +extern atomic_t genl_sk_destructing_cnt;
> +extern wait_queue_head_t genl_sk_destructing_waitq;
> +
> +#endif	/* __LINUX_GENERIC_NETLINK_H */

