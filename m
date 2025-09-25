Return-Path: <netdev+bounces-226218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF56B9E303
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFCC3B7392
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DABB25A631;
	Thu, 25 Sep 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTzDyKt/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481F2550BA
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791167; cv=none; b=j7eduP4IIkAzE9A9yIiGXCEr8zmhMP1Uv8z3lN0XV++eIjMAVgE9SwSnuaTBM/1K1iW4yqLkA929AkBHOyU1Nzl9lSaFsLclQINyDyIxQ+XjvVF3mPmR1Vjl8Ww/fNbMeuO2WsEcaHaeQz6dh4XhQ6g53vyqvxLcFZi/mJf2TX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791167; c=relaxed/simple;
	bh=evH85ZXVgvASBVLJCrFyA0wbOO92qgXpZfCju2sS+H8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=IEUSalxGor2f6+IaCMZlLNGDUXwT2BpoCib4byuf23WFlETlBhcXbNdSlvGookhIzvIJ5y0kbrd5aTBUeFLuLsiphSKLQufAQGD3GmFJTbKD4YmmpCXqbnp8rLaK+YFw4RWm3UcCxczSVTYhs8sPrgZ/63PRTWPniAfcL1XXMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTzDyKt/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso456411f8f.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758791163; x=1759395963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NNrpyJFfgvgCiux0aBl6SIFccp73bP8aAdH+wBEeNY4=;
        b=iTzDyKt/+MwDxpFtVjHQW9PvUuz5dnze3BDOXWMo/K0Ear6gfRhrZeTkW9J7qUw4cP
         ws8JECAmfg4rN2ZJsRPDQTgs57/3ex0U1VyqY9BK4RPd8h2BEO/GhazNps6mNKebKUsL
         wWyZJknZqO+jSgfo71lIfnvDCY1XX9h1P06jczae2DJKsD6cEvBHaGjLfgtUCYjFyt+m
         j/CbM/alICmFnHBgPSSvrSmms5gfHPiVhkgmH6sTUtxz1WevALRSBVFhramDiE8lBlIW
         HqtNfW/t48Rrej2ydm6u58yHmAnL1DjkBMpEcOrAE40exsDbt6btsddgSPzr4p0HUEab
         Y7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758791163; x=1759395963;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNrpyJFfgvgCiux0aBl6SIFccp73bP8aAdH+wBEeNY4=;
        b=VNgrJALxdoQSy/7jxLGXo+ghzqQ63W14inBpdF2tjeslpnpYLjbYAKd3FD9V9Ow2jB
         X70nNVbP9E/knsUrHlD8rbWmbDwEItBQmDkljpUO/i04Z/jaE6ggdcEUNNcb0ZVSDgbt
         HJrrmASTX5Kmi6RId2+EfXJHEr5PlgfJSCKkX49O3v6zNizQ/ijJcRFC99HkMslJGrGb
         ph44WuRvNStHQQQCkNgiBNcLvVySuOIgp9kGdMZJkGvFGB8A1vyaJk8PvW0q0jqHJJ8Z
         cg+XbjcUYQUJ3wWo5rMlFfYj0zrwy1v3WjJeYelV4hYnZedj5Rszsmv/MkyjSwAU5wTc
         w2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVcZYISTkWwrASL9R4vQqcHDE7Bw1eGTanZLEcsRwtk9/1NFQs8x4bNJv4iTHOeIO/LSkAv+8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYO3T2WJyxoKtyguYTzsFcRVwLguwEDRVEXQPVtWL7dbpJDo3
	/Zm/WDoRKVfzPLJG55/+j0NSZa4x4mGu5nonlGo3ezCrOAOVSlXVbB9CnKFZR3rC
X-Gm-Gg: ASbGnctA8q/lXwWDOAKyVIGvvqXvHjswezU5xV7nhmVDQvxScYvGtkbThyQS7R36dcF
	WedvQUDBP4h17HDgV3H/IqcRY/emyCqn+M0tpAdjCEuizwfS10gQE1oAZZivtG53cV/kT/CS51Q
	GnRh3eUtwWK4Z+yQC6fzCpL/cJ5jleGJu0Jas97lqsjfHgwUmgivkJUzqxNjtZWdS20P++euQvU
	prbHzzN4VVw8SmLF8lq0z9DZ4zEPUCmNbUhbA/e6DglWBh5rMpFy9M74WmPs0S/m3wJ50KcnAeE
	omS/LwtrpLcXNSz3ftOWcy2nISIt2JpT1XSc8BAtdUTaAw1S3B7UCVPyuorSPL+0bJIp5sjJd9M
	MwzE0LC0+FKpcH8Ko13DopfRN+nFeW9/E3Q==
X-Google-Smtp-Source: AGHT+IEm9MAwcQUDDCAI0PtQDJs+W1QfdU8z4dmmvXWEahWVep9Lfg7Z7aitwOlHvjoD9h5aALX1Cw==
X-Received: by 2002:a05:6000:2308:b0:3ea:c360:ff88 with SMTP id ffacd0b85a97d-40e4ba3a4e9mr2572484f8f.31.1758791162616;
        Thu, 25 Sep 2025 02:06:02 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:7065:f39a:cc4:890d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602eccsm2165854f8f.40.2025.09.25.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:06:02 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,  Jamal Hadi
 Salim
 <jhs@mojatatu.com>,  Cong Wang <xiyou.wangcong@gmail.com>,  Jiri Pirko
 <jiri@resnulli.us>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jonas
 =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
  cake@lists.bufferbloat.net,
  netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 4/4] net/sched: sch_cake: share shaper
 state across sub-instances of cake_mq
In-Reply-To: <20250924-mq-cake-sub-qdisc-v1-4-43a060d1112a@redhat.com>
Date: Thu, 25 Sep 2025 10:04:58 +0100
Message-ID: <m2ecrusy11.fsf@gmail.com>
References: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
	<20250924-mq-cake-sub-qdisc-v1-4-43a060d1112a@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> From: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
>
> This commit adds shared shaper state across the cake instances beneath a
> cake_mq qdisc. It works by periodically tracking the number of active
> instances, and scaling the configured rate by the number of active
> queues.
>
> The scan is lockless and simply reads the qlen and the last_active state
> variable of each of the instances configured beneath the parent cake_mq
> instance. Locking is not required since the values are only updated by
> the owning instance, and eventual consistency is sufficient for the
> purpose of estimating the number of active queues.
>
> The interval for scanning the number of active queues is configurable
> and defaults to 200 us. We found this to be a good tradeoff between
> overhead and response time. For a detailed analysis of this aspect see
> the Netdevconf talk:
>
> https://netdevconf.info/0x19/docs/netdev-0x19-paper16-talk-paper.pdf
>
> Signed-off-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  include/uapi/linux/pkt_sched.h |  2 ++
>  net/sched/sch_cake.c           | 67 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sche=
d.h
> index c2da76e78badebbdf7d5482cef1a3132aec99fe1..a4aa812bfbe86424c502de5bb=
2e5b1429b440088 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -1014,6 +1014,7 @@ enum {
>  	TCA_CAKE_ACK_FILTER,
>  	TCA_CAKE_SPLIT_GSO,
>  	TCA_CAKE_FWMARK,
> +	TCA_CAKE_SYNC_TIME,
>  	__TCA_CAKE_MAX
>  };
>  #define TCA_CAKE_MAX	(__TCA_CAKE_MAX - 1)
> @@ -1036,6 +1037,7 @@ enum {
>  	TCA_CAKE_STATS_DROP_NEXT_US,
>  	TCA_CAKE_STATS_P_DROP,
>  	TCA_CAKE_STATS_BLUE_TIMER_US,
> +	TCA_CAKE_STATS_ACTIVE_QUEUES,
>  	__TCA_CAKE_STATS_MAX
>  };
>  #define TCA_CAKE_STATS_MAX (__TCA_CAKE_STATS_MAX - 1)

Hi Toke,

Could you include this diff in the patch to keep the ynl spec up to date?

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/sp=
ecs/tc.yaml
index b398f7a46dae..f0edc84f9613 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2153,6 +2153,9 @@ attribute-sets:
       -
         name: fwmark
         type: u32
+      -
+        name: sync-time
+        type: u32
   -
     name: cake-stats-attrs
     name-prefix: tca-cake-stats-
@@ -2207,6 +2210,9 @@ attribute-sets:
       -
         name: blue-timer-us
         type: s32
+      -
+        name: active-queues
+        type: u32
   -
     name: cake-tin-stats-attrs
     name-prefix: tca-cake-tin-stats-

