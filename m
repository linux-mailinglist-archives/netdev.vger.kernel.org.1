Return-Path: <netdev+bounces-131999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC89901DA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4273E1F214D5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1115855C;
	Fri,  4 Oct 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcW2EnSs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50167156C4B
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040229; cv=none; b=twCHhonks+DrTrxGEn0c7QE6yYftoqjB2cQoayIOAhXBy0f1LTvzdSOxPQLL1DQ7R/42vxdPItXYO1JvgZeknlENf+pbJ7/IDMWEPM54VbbG6DfsVRveCpmC4luN7+38Nh3nefhBHCZ9xRs/OVNE6JNLMhojjrtzn/xpHSaFdE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040229; c=relaxed/simple;
	bh=BGHd0mQDXIt/7ZN/yzt92layYldK0FHr4D8mtzdJcIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3joCvGyqKKZMXwLMetmxAV6ZL5juxo8KKP25uaepllYlmndnbhwdwFFyNQOf60cOsvxScNqdIR1e3ur13dpj/D3+6iXJbTTH2WGkYDpPwmBMmXWpMtUi7EIRE0axzDgxf0ZXsqU7noW+OyV0ORVLmM3an37FmHVmbwK1T0sSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcW2EnSs; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c89bdb9019so2315686a12.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728040225; x=1728645025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaW8TFAncXhn0Cwqxjl66SWCYSgKEp3p9UiROlWEgpM=;
        b=qcW2EnSsO8NPRufHq8Ycd+rS3xYB1vQM4GmgpyIBsCrydNqM4gltP0t1gFnVZEjUcM
         0en7HtcCx/bHHGxiG/uY55xf0cwB0rTcZvFXE8k54saLqZT+yLMv0cN0XLDATp6vneU2
         X55YFEUl9IHyKFk0XzSvZSeNoWqGHW9k7rFSGu7LvMsanS0P1SWCp355p0Edu5V2m4/y
         RuztzV++llYH4Vu08SL8hvJBnB3rrWqWq56tjDgGAgtbpb77iDZGE+Au41zX46PhK7PG
         JSHrXKkuyJq1MXQ9TSsRf87UHrdJEa5Aa3qNZ8nOXxPEac+NAleKe0IkXBwDMAsXguSt
         zosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728040225; x=1728645025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaW8TFAncXhn0Cwqxjl66SWCYSgKEp3p9UiROlWEgpM=;
        b=sDiqlYjWzO4Xq41a9UfW+aqO9DwS+S901iZ1b1MynhZ9z1WbHQGmgNWcZj5CGPh1hX
         qZtemQVSexFenlaE9C2g06PorLrti5o0uYGNQiwiz/R44zvIeB+wfTv5epPQgvQmnuiL
         hTa+mux+oXq19rVpvaoOz98uZAqEYtBhBLeV6qg8gDBXxdvikaRzaoXRiie20aBbcg7O
         1W24rZAqLdydLc6zG6YTK5UbbzosoC8udFR7zt7IyupzTjODX/TGeEXBtdYzdv5UBvkn
         2RqmxmD9zjtxUjBeU+4sYQoeet9MXx6jFg1TGQ+XSHKqBItAebd/o8RxwmUPPXGLWBND
         XUEg==
X-Forwarded-Encrypted: i=1; AJvYcCWhPnmvuA3YH5sqjQHnCn3rcpIHyckR1IYYJWzBNg4j26/NqOLG2XOCL0b6eZE3KB2Z6yqa/fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfXQKcWqauQbBsP831O2NSQVsWku14MiRwMwwewuugTUXxDbZ
	Jrk4n1euS1JMnJaS4xnBpSPd/3pzTeI6olNV9xWDL590qU/vYmXZZVIfUyU4Ju3fNfLof26Mp0z
	wouJp9oWHHHrDiIyQmnP3tv7wUumRlv4/NXBt
X-Google-Smtp-Source: AGHT+IGOx+sjUEpBvLuJQZ7D80YqoePH1MPItV9+JfFy15uOHRtviD93lUm/cq5b1VGUHnLGkBCPl5aP+M2CEUWUKYs=
X-Received: by 2002:a05:6402:360e:b0:5c8:7c58:6588 with SMTP id
 4fb4d7f45d1cf-5c8d2ea086emr1262519a12.32.1728040225211; Fri, 04 Oct 2024
 04:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002151240.49813-1-kuniyu@amazon.com> <20241002151240.49813-4-kuniyu@amazon.com>
In-Reply-To: <20241002151240.49813-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 13:10:13 +0200
Message-ID: <CANn89iKur1PF5Whp9yG+ObS89Q4ryEnghLyFSzgY6jc02c=qgw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/4] rtnetlink: Add assertion helpers for
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> Once an RTNL scope is converted with rtnl_net_lock(), we will replace
> RTNL helper functions inside the scope with the following per-netns
> alternatives:
>
>   ASSERT_RTNL()           -> ASSERT_RTNL_NET(net)
>   rcu_dereference_rtnl(p) -> rcu_dereference_rtnl_net(net, p)
>
> Note that the per-netns helpers are equivalent to the conventional
> helpers unless CONFIG_DEBUG_NET_SMALL_RTNL is enabled.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

