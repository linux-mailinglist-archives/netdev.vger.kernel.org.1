Return-Path: <netdev+bounces-196553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42041AD5420
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CA53A2FA5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19868248191;
	Wed, 11 Jun 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOFALx/3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E123099C;
	Wed, 11 Jun 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641848; cv=none; b=TvUiziPlcF1tqXYW+l6inNVLUIzKiQwVzo5QB7lWH0ztmuw8ebDUV8JJFU6JPIk8pn0QFRZEcyDHSK1mD7hTObMx3M0kMlSRGasOFH/y39HEFHArXg9R+8tAJ5rtC+xT8z9ibWC1jLnMxOPM78Lzd2i5BCXIVWfvJEh0ZWYlXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641848; c=relaxed/simple;
	bh=t70ZVM9B9jXNQcg1tWA3G669RPWCqOTJ7o+RRmiouFQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=q+wx3bEuN2WEo+G2ZLnhcPatroeHaD8FdQwyXcEPrymRhNfN3NlCgfMHA3xLeHPhjFkv6pqfIs1tBvONX5uqy7tnwM8tHz/adnaXZhx7NBAql0fwsO9zzcp379ZVHySHnY082c+U+mUMIZxj+SWrGmrAvjzI1JLmP++AFs7O8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOFALx/3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d3f72391so84844335e9.3;
        Wed, 11 Jun 2025 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749641844; x=1750246644; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qR6faLEKEsL2HBhlXQ2T+G160lb/jVjJORZfNDkjTgo=;
        b=jOFALx/3NWuRVfaopeyNQFLYmPvj9B36DvaxqLb5Ha/OXMT/cNnJuGY3TO8B+771Ko
         bCPNG07E1CynoCDNAbGOgaoVvZ+++BWWvMtappW16ARnl5Ebe3Dx4KQUR93rJEuuUV8I
         39/DUwCcY7heGZBH2uaQrrXblkApa+uLPrwUybl01+8+ywPbbQLY3EXBaLXJJDNK4qvh
         XffmVMn30uMuTE+4Nv5cHdD6i36HiobAnNXxn6WjsrUW/mbaXAPKiQiwXIAyaisPYOSt
         kRDmfnvZuDwzJ1hgScAqcgEbBBUqgcX3FEEvS6kh1XV4NHoXqmEnzcwzCIpYvpInSa3M
         pEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641844; x=1750246644;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR6faLEKEsL2HBhlXQ2T+G160lb/jVjJORZfNDkjTgo=;
        b=rqzz6FBU4TPUWQD7XxGYreRLW6Gax44P9Vg3cY1n13KL/LsXeX8UPMGN7+HCentpbd
         boTnQQ9LEgsAjLjzSBeeCZyjCgSfp8rSgbxOewxuBbpi33YbqGpO3MlqaTkwtn3gfbPg
         NERxe3NPXNjEelzAmob1VX8SBSGPDwVV6YPNBE/USZ1/Ab34jxlZABRTSxrfgMUwkuDu
         2EIVscIYhcq7t/urjMdoEu+3ZcJ8vi/V0HjfN0MhKoGS5m4V7Y+OrmXo8j0BrTEwu2/o
         fDiTaQkPWGWTCTP7+jCWCbeDLAssoGjUuv8gm8mTRHzUEU08E4onevRCXZ5rAWKG91Op
         /nqg==
X-Forwarded-Encrypted: i=1; AJvYcCU1oy4K2k3qyNscNg9+GEGwEJY95dBoxSFqYJrnzj4CO2XDiwTuD7r3ZOZ70lqvSIdCHWhL9aSc@vger.kernel.org, AJvYcCXPONMxlnZhD8IlxqVjq2z5R5d7OKbvM/CQhaMne4IDuxyYfHjqdj30gAnsGDhpHFuA6R4Jockptvs3X38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWRpon9GUTW+aWkZusoZ1A7oJ5cpETJ7VSDnr3j4UHVhMZxK/
	vhUYTwJmRu+5FPxdCVR/iU6E6v/1Qi9XWurSX4IZI7+PD4oqDhiFitbS
X-Gm-Gg: ASbGncsj9WbxZ6XrRRbxnqik5mJxxoycztl0KjmSJ5V9YQ8tLnkLh7Y0ytkpuW/Xr8n
	syAPFL0LLxI3xE2Gn7DeAEJz+Wy2MYwV717Nf9T2DAC+Me3RL3vJ3esP+fPA7Af81muLe+pOGx1
	G1C+hcs1ZLWLHLTGIBb8EvDSrVc6jVxpDzftPZt40QoEKvPRrsrWMUnFk/BR1j0g8fx4l2+xvOJ
	IkrPpLQMea42KBrb4ilCN9XTUwD3CGOWuFfEEgqD6JX2CBBx/4snVPnM7jDmVnCTRlxSSWnnmja
	Rrxp/ThGqyw0rIieuPJr50RHtgW2MVxXxovr4GvOguf8ionrhX6SoZrEJIgqWMQXFJSuq1jC7Lc
	=
X-Google-Smtp-Source: AGHT+IHUSDusP78EOPiscyfG6WpAmC3o9BMOaRGloOtLN/xk/Tr/sY0jXpO68pJur2TvBqN/0kmB+g==
X-Received: by 2002:a05:600c:4687:b0:453:aca:4d05 with SMTP id 5b1f17b1804b1-4532a2e8b84mr462665e9.31.1749641844216;
        Wed, 11 Jun 2025 04:37:24 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:acc4:f1bd:6203:c85f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532513e758sm18852815e9.5.2025.06.11.04.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:37:23 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  "Jonathan Corbet"
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Ignacio
 Encinas Rubio" <ignacio@iencinas.com>,  "Marco Elver" <elver@google.com>,
  "Shuah Khan" <skhan@linuxfoundation.org>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH 3/4] docs: netlink: don't ignore generated rst files
In-Reply-To: <1cf12ab4c027cf27decf70a40aafdd0e2f669299.1749551140.git.mchehab+huawei@kernel.org>
Date: Wed, 11 Jun 2025 11:44:09 +0100
Message-ID: <m2a56epngm.fsf@gmail.com>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
	<1cf12ab4c027cf27decf70a40aafdd0e2f669299.1749551140.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Currently, the build system generates ReST files inside the
> source directory. This is not a good idea, specially when
> we have renames, as make clean won't get rid of them.

You're right that it's not a great idea, but it's the least bad option
with sphinx because it only supports 1 source dir. It doesn't have the
concept of a generated-sources dir and the alternative is to pollute the
output dir. See e.g. https://docs.kernel.org/media.h.rst

> As the first step to address the issue, stop ignoring those
> files. This way, we can see exactly what has been produced
> at build time inside $(srctree):
>
>         Documentation/networking/netlink_spec/conntrack.rst
>         Documentation/networking/netlink_spec/devlink.rst
>         Documentation/networking/netlink_spec/dpll.rst
>         Documentation/networking/netlink_spec/ethtool.rst
>         Documentation/networking/netlink_spec/fou.rst
>         Documentation/networking/netlink_spec/handshake.rst
>         Documentation/networking/netlink_spec/index.rst
>         Documentation/networking/netlink_spec/lockd.rst
>         Documentation/networking/netlink_spec/mptcp_pm.rst
>         Documentation/networking/netlink_spec/net_shaper.rst
>         Documentation/networking/netlink_spec/netdev.rst
>         Documentation/networking/netlink_spec/nfsd.rst
>         Documentation/networking/netlink_spec/nftables.rst
>         Documentation/networking/netlink_spec/nl80211.rst
>         Documentation/networking/netlink_spec/nlctrl.rst
>         Documentation/networking/netlink_spec/ovs_datapath.rst
>         Documentation/networking/netlink_spec/ovs_flow.rst
>         Documentation/networking/netlink_spec/ovs_vport.rst
>         Documentation/networking/netlink_spec/rt_addr.rst
>         Documentation/networking/netlink_spec/rt_link.rst
>         Documentation/networking/netlink_spec/rt_neigh.rst
>         Documentation/networking/netlink_spec/rt_route.rst
>         Documentation/networking/netlink_spec/rt_rule.rst
>         Documentation/networking/netlink_spec/tc.rst
>         Documentation/networking/netlink_spec/tcp_metrics.rst
>         Documentation/networking/netlink_spec/team.rst
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/networking/netlink_spec/.gitignore | 1 -
>  1 file changed, 1 deletion(-)
>  delete mode 100644 Documentation/networking/netlink_spec/.gitignore
>
> diff --git a/Documentation/networking/netlink_spec/.gitignore b/Documentation/networking/netlink_spec/.gitignore
> deleted file mode 100644
> index 30d85567b592..000000000000
> --- a/Documentation/networking/netlink_spec/.gitignore
> +++ /dev/null
> @@ -1 +0,0 @@
> -*.rst

