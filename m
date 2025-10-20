Return-Path: <netdev+bounces-230780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA22BEF630
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 08:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0105A3E18F2
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 06:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE04218827;
	Mon, 20 Oct 2025 06:01:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73193354AFF
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940081; cv=none; b=nm+XZUjOsL7TT1ZigdrjXsOwAmToeZMeT+Y01jkc5dqga2XyFY9ww1UIMEhibS4CBXpu087kc+ZxgX/zND6uhKfzWkmrkF97rWPjB94K1+R6M+2pnqLM6zhpRYzhQ65m2pfJ1/A2L89j+vFmy/qCjzCZKtZoszVUxSsa7B7m5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940081; c=relaxed/simple;
	bh=zPx/qHajOmP6Qog6UePYyw24VcXnPdZWtnfS4h2h30I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nSu27+0Gh+Xapt4fvvZkvygZ1zn2Iqi8PpZWlSyA59YLMkG943SUq9CCl8wnQZ8FxoUEH9M6mzZBkaU6Y9gxvMomydng5Ue0boHjKVqkHvypWb83dq+STMB7JtDe06dD8HtDEg9jPN2yQ6H5BQe6uG3OZRJfb4hK3Ofi+tLlM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e7f4f7bb1so218748339f.3
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 23:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760940078; x=1761544878;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDD8Ubc5Av0L90IL8EuqGy3Z2uaxhW47eENinTlYn0s=;
        b=CoclELkINkWiUGH70LJ3FQg7DYYFB1j5CLLBSsgATnS/bAv0h9uK634Ywo+K+sDJKB
         Kz6Kp17fe8jK3VmOsj6rlO+CSPfefAhuBn1NFr2bvZPYbXVCTshZ+299w1jTdieQBDCQ
         nzzdWCUKjCvW924AKKKGpL0XhLLObPZFuies2+ynvlHkyDKyIk9Bi8AmeM4bOMjHK2BA
         wOxiU28nWgv5LJcc2ulzRJIyclQXwHCsu442VUFt4/IUYwDtnunRA0wBVDGMnwLu5Mcq
         gUmTusu/6+SuW935i2kvyXAJpP15coNRvy5GnULknzlL4SYwX20+orUMDjIosL7eS/f/
         bDKg==
X-Forwarded-Encrypted: i=1; AJvYcCVunLbVu1lhLsn5cWtRoRvfjMNCgzSx16CJF9SwcBOI+boC9SLdvnbXV3hgW+4g+UDuIG90mJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPH8CDpeHYuKpU9pXzvxng9ryX7UstoJtrGhgP7LHE/w8V49Th
	4w4V+wKECjMpO/+2y5eS+Gtt6GOfgVb68WvmGDzFG2LkQm4pKRK+dkmwL4famx6hN2KWyvK0tza
	CdN9arAsfO6Y3nOJb9EdpweD/Ps5l+BMkoPWpLBnDZUDpcvNuFGrmahNJJTI=
X-Google-Smtp-Source: AGHT+IEj9qyfg/IroSssxxfUTR6ez8zaAKoPAwc6VRxxAK8shZj0Z9kW2XzlzJS26xBJt3sjwCybZih8L4SBskLHCJKfK1iuLHB0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640e:b0:940:d700:3a01 with SMTP id
 ca18e2360f4ac-940d7003b01mr409890539f.3.1760940078571; Sun, 19 Oct 2025
 23:01:18 -0700 (PDT)
Date: Sun, 19 Oct 2025 23:01:18 -0700
In-Reply-To: <tencent_03EA78899E616FF00CC749FE8840EA81410A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5d02e.050a0220.91a22.043e.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: 1599101385@qq.com
Cc: 1599101385@qq.com, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:

want either no args or 2 args (repo, branch), got 7

> From 2edfc8833e43cdf5ccda8bd5be3da5d1bbdc69c6 Mon Sep 17 00:00:00 2001
> From: clingfei <1599101385@qq.com>
> Date: Mon, 20 Oct 2025 13:40:35 +0800
> Subject: [PATCH] fix integer overflow in set_ipsecrequest
> The mp->new_family and mp->old_family is u16, while set_ipsecrequest receives family as uint8_t, 
> causing a integer overflow and the later size_req calculation error, which ultimately triggered a 
> kernel bug in skb_put.
>
> Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
>
> ---
>  net/key/af_key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index 2ebde0352245..08f4cde01994 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff *skb, const struct xfrm_kmaddress *
>
>  static int set_ipsecrequest(struct sk_buff *skb,
>                             uint8_t proto, uint8_t mode, int level,
> -                           uint32_t reqid, uint8_t family,
> +                           uint32_t reqid, uint16_t family,
>                             const xfrm_address_t *src, const xfrm_address_t *dst)
>  {
>         struct sadb_x_ipsecrequest *rq;
> --
> 2.34.1

