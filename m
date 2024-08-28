Return-Path: <netdev+bounces-122769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DBB9627D2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3BCB23A71
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A55178CF2;
	Wed, 28 Aug 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq/Ta5iW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C415B12F;
	Wed, 28 Aug 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849547; cv=none; b=k9m1MQKvOHKdOCf5UU6s5lvXmpN34JkuVkj4paBYJN5HLdPYQfQ/p4LHK8KoXXY8SpbwHRpKS7wHdqhLBLATJwOOKmHj6Zww7V2/O+bVflfwHVk3bP1l0+l95J7ilvbmHgrM5AzPmHyVzniyOkEQMUG9IPShOaKVZkb5FihY3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849547; c=relaxed/simple;
	bh=g2hMAGnvoRO6n2Q7lnRfLg+Icwjjl00HQPQLTynWNlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CenMStdCGtDG1RgFvWOfw/yAcyUNVywVeWte7GVPmRGtKlJSLHdFq6XD+wOdyrp8WOZOONfo76+aDj7kg3aj0Fh1hBVXgnxLGZqRTY+Xmyh9oxcs3FZc2zHRp/4BHwrxH8mpnt9Usjxxx4XNvkCrNfCgO+mGPRWJLtBERE+vCKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq/Ta5iW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2021a99af5eso60692475ad.1;
        Wed, 28 Aug 2024 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724849545; x=1725454345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g2hMAGnvoRO6n2Q7lnRfLg+Icwjjl00HQPQLTynWNlU=;
        b=Wq/Ta5iWYmpD3CaLeSlwiH2YLHSmk05z7ckGS1JE4JMJDTYv9hrz08Ip4kosz9eT3q
         XWtyI48pMdtO6KkJrXt57GHaQ0pFuYSjyntHCoL1oOucGeA9ZpBZ8EVXFzVN13xGa8Dj
         Djv4LCmJ0CNoBuE6gj2uNQo9Rp66Kc4sHPPa4k1VcIzHJLpR+Hfi48ImAuACpHiNFUpl
         ZOPUwCp8653NbyMn2zvoYwDWgEdno5Fby4pS4pJTA2KsmXKMwhKxMJNJE27XIVYlx3vF
         0mxo2igwh79Kn1cGdNasHFkOIH795F5tk8H64XWMpN7Q63J6+f4R2DFTHi9H8IS+rURb
         gEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724849545; x=1725454345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2hMAGnvoRO6n2Q7lnRfLg+Icwjjl00HQPQLTynWNlU=;
        b=GF5zA752joU0S9yohwIRmuQyjZae1Elks+8BxUmudFf9w+Be9FPJrXIWIuac5bZ6O4
         zwQBuJ6nbxXZIO/39NCZyjyLJO8SM63/ydXvSEqKWkCR5qMO+oKr89+wL4jvgHx4HZZp
         86+/j/QHfvQ+VnrQS7BOzBypQ3YSros4rPbbvuSlsHvZ5N6kF0RUxdQK8YDgt7vi7GgR
         ig6VrAgOGINJCxtJyednlwxpL2HaEYLXwk9LWl4LomJC9/WPv6dFnuu6wFcrIOMKIhyp
         vBLvM7osWiJymLZdzD1yD1cUgWFMut6Vt9nZkegHMmeUV6Xc5qExqKXnBrq+M7OC3y7S
         zXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKPId31TKCHy8VQ/9G0LnauO5kuTGFPfTQOWw87faNhbGN+Ibc407Oi5vLVMVOgfgzsawnLknMd5rwguE=@vger.kernel.org, AJvYcCWmpoJSZtcz4Wq9mu5Pgh6aKf3Eby5Zqr1Z9yyw00yvueo9NvwcKCrqTW1Ta6jNTGFO30wgoa62@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFUwwz9ji1nMMFIxBPaAjrlDGfnCRXBMM5ctOAphqvPl/cdoQ
	eVbOPWEy7stFSKiDDPyahjfrgnpv3EiXBQ/lIDRIz0h7I1weexgE3YsAVooREP/Cd/2c33p+6ct
	Vckl2QwpbG23UM4yNRJf4yyouv5A=
X-Google-Smtp-Source: AGHT+IGK2UffMTh2JEs6OvO7g3s2HyjTdn804wzwOm6obRBkMq9RSUKF79nQzyur3eL7iSr3cVLPMRQrpw3b+WCyRiI=
X-Received: by 2002:a17:90b:1116:b0:2d4:6ef:cb0c with SMTP id
 98e67ed59e1d1-2d646d6fb51mr15192481a91.43.1724849545019; Wed, 28 Aug 2024
 05:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822181109.2577354-1-aha310510@gmail.com> <fd2a06d5-370f-4e07-af84-cab089b82a4b@redhat.com>
In-Reply-To: <fd2a06d5-370f-4e07-af84-cab089b82a4b@redhat.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 28 Aug 2024 21:52:12 +0900
Message-ID: <CAO9qdTGHJw-SUFH9D16N5wSn4KmaMUcX+GVFuEFu+jqMb3HU1g@mail.gmail.com>
Subject: Re: [PATCH net] net/xen-netback: prevent UAF in xenvif_flush_hash()
To: Paolo Abeni <pabeni@redhat.com>
Cc: wei.liu@kernel.org, paul@xen.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, madhuparnabhowmik04@gmail.com, 
	xen-devel@lists.xenproject.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 13:19:59 +0200 Paolo Abeni wrote:
> On 8/22/24 20:11, Jeongjun Park wrote:
> > During the list_for_each_entry_rcu iteration call of xenvif_flush_hash,
> > kfree_rcu does not exist inside the rcu read critical section, so if
>
> The above wording is confusing, do you mean "kfree_rcu does not exit
> from "...?
>
> > kfree_rcu is called when the rcu grace period ends during the iteration,
> > UAF occurs when accessing head->next after the entry becomes free.
>
> The loop runs with irq disabled, the RCU critical section extends over
> it, uninterrupted.

Basically, list_for_each_entry_rcu is specified to be used under the protection
of rcu_read_lock(), but this is not the case with xenvif_new_hash(). If it is
used without the protection of rcu_read_lock(), kfree is called immediately
after the grace period ends after the call to kfree_rcu() inside
list_for_each_entry_rcu, so the entry is released, and a UAF occurs when
fetching with ->next thereafter.

Regards,
Jeongjun Park

