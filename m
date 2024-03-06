Return-Path: <netdev+bounces-77826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 997EE873219
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3881F24FDC
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51005F57A;
	Wed,  6 Mar 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3OAI87ZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6A5F489
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715664; cv=none; b=m5vpM5HaQpHrH1MBLVVaJRIXmftlzJNN0LG15woPCLuUBXggBq/T0SitfJRdA9+2Yiaj8/KOZk2BmEEAS70hnChb5NzQ0OWmQZDhNJUSppGE8lFeaC3WuodwyvWAPv1NxFiZs+1VuG3su6a14CIPTj3KqiTPsHUV+S3XhsW2Zhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715664; c=relaxed/simple;
	bh=EwEYirvr2jvVvnPjdV6XVx23jWr+FeYoGMbUr8oZySw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCdq1x4UaOAQAGdhdG1g4bvZiD4LmMOEvPQcOxFxgMemHP6MRdw0CqGB+O66PbnCJV2Q4Z1HYAIfeHcnRJkOZJnhc33GWVwJzQax/pG2mHlrVTn8Jr5sSs8qN3WN2+ueKfpAAemGm+fmNFZGmkp2ySunArZGPNkWVnaSuvu5fG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3OAI87ZG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so5657a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709715661; x=1710320461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/84T2ki3/neNxXjBVi8YXXkmoruSAbtUGVHX97k3rw=;
        b=3OAI87ZGm3NF8qlD/9CjCGkmWoHs5xaoRLqIGDXae/Vfe25ViTkom64Lly62EdNzbu
         282dMnCYLKB5IMx2xi1ET4WAdLzY0UZo/eHZamJbn9YMYeKNBkgnXLI61YaDzj6GhWvN
         GthMEyaBFqJues7ueTqlhlWPowWOIoXqM7aw0WBqYtk5BSUgIdPAATAYKLazfsBkLoSo
         fMFw3/KHelIwx6uGOPqBZbNkzzvHPIzCmAfcvUb4nsWeGpzulw02u4n/XH4P2qZ/OL3o
         52GRidf+f3d3DrU/BgaoI/QGQDVgBQplhaI9MfufLd9F3PfxSA7EGXvxxyihdVD2vfmy
         VrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715661; x=1710320461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/84T2ki3/neNxXjBVi8YXXkmoruSAbtUGVHX97k3rw=;
        b=Oz0oeP3ekrDRzPxdSqPBolSSX7lRNfe25/WVsq+eIr/zB/8MllPtmrr5jU7Gydkg9b
         IugsO1CYTZpyxVmIsttk9HfXarA1jQox3dm/WBym1IZcBcV2hLF/DzGf/Qvv10HDe+fU
         h6+eL8I/Cg0Cxws3ULlkmL8hjrvn2In4gJzjAAcolXo9LcHY4bh22HLvitnVKn6o1lPM
         0akVHW3WvhwJKHbjTzZLIlxlpOcR7v+agCHy0ymqKtM6uUtU1d+huHTEBaFnvq8wbvqr
         QfGdRN/IcE63gs5HLUl1Znh8XpqBHSiBgoTXZn0P+HefFZ17EDhbtP3Bc4h3lnJ874xL
         2MtA==
X-Forwarded-Encrypted: i=1; AJvYcCXmlFUM/zO8F5R/G1tPLO0kWRhHNrAW6bgi+Aa2pYMuSj0SgT94PD48to8xwS7zJjmcMeK+FjZu5d9x3xDSkhl2mV83dT95
X-Gm-Message-State: AOJu0YyP3RKXql6d+UpcYhGC//mTSIBx9gEuAG2IyUElonZ97OwwJC4y
	YoBbupYinqa5sCOovBelQeYnQZQ6YOoOZGH2HlZc19QIGanwWsAHThkePhiOOiZvSTblZTbMCt5
	bP4MmIFawXzGeE8Dl6ANdF5PvbqOgKwTYoJy+
X-Google-Smtp-Source: AGHT+IE90eLXuQ/cn4OIYVYGWBfGpFwg3VwdIkidZ6fkNjkHdVuNbVDF1f16qE2ZvMGwmAXb/EBfA7GbXH+JtNTmDJY=
X-Received: by 2002:a05:6402:11ca:b0:567:eb05:6d08 with SMTP id
 j10-20020a05640211ca00b00567eb056d08mr75504edw.6.1709715660520; Wed, 06 Mar
 2024 01:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305160413.2231423-7-edumazet@google.com> <202403061318.QMW92UEi-lkp@intel.com>
In-Reply-To: <202403061318.QMW92UEi-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Mar 2024 10:00:45 +0100
Message-ID: <CANn89iLv8hFUDiash5LTaHg4VrzCS1QdaJR-62WNEmMVYVF7pA@mail.gmail.com>
Subject: Re: [PATCH net-next 06/18] net: move ip_packet_offload and
 ipv6_packet_offload to net_hotdata
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 7:09=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Eric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-i=
ntroduce-struct-net_hotdata/20240306-001407
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240305160413.2231423-7-edumaze=
t%40google.com
> patch subject: [PATCH net-next 06/18] net: move ip_packet_offload and ipv=
6_packet_offload to net_hotdata
> config: hexagon-defconfig (https://download.01.org/0day-ci/archive/202403=
06/202403061318.QMW92UEi-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 3=
25f51237252e6dab8e4e1ea1fa7acbb4faee1cd)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240306/202403061318.QMW92UEi-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403061318.QMW92UEi-lkp=
@intel.com/

Right, all the offloads need to be there if CONFIG_INET=3Dy, regardless
of CONFIG_IPV6

I will in v2 have changes so that the cumulative diff is :

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 7bb6e46aec8f19deff42112041feb47724cdd538..9230052a453c1b959b9a72f1d1a=
4878d76f243b8
100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -14,13 +14,13 @@ struct net_hotdata {
        struct net_protocol     tcp_protocol;
        struct net_offload      udpv4_offload;
        struct net_protocol     udp_protocol;
-#endif
-#if IS_ENABLED(CONFIG_IPV6)
        struct packet_offload   ipv6_packet_offload;
        struct net_offload      tcpv6_offload;
+#if defined (CONFIG_IPV6)
        struct inet6_protocol   tcpv6_protocol;
-       struct net_offload      udpv6_offload;
        struct inet6_protocol   udpv6_protocol;
+#endif
+       struct net_offload      udpv6_offload;
 #endif
        struct list_head        offload_base;
        struct list_head        ptype_all;

