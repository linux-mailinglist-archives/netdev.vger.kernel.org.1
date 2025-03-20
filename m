Return-Path: <netdev+bounces-176390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847C3A6A038
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD0F188EF5B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2551E2613;
	Thu, 20 Mar 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rqc8qK04"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84942744D
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454741; cv=none; b=Sx31yUESuAc7DaCNZk7nKWEYipCf1nu3P6b0XUDpCb40gwtDZrBatuViUTyAVssALBJNERpKnqPJMxI+DLxlohX08MAs/lQpyEogPYKUue6CK3ciM6fDfW7qzpe9xkilWOnAkqWgmOI7tGxeHoqC06FQ3bbTuZMszMWHAtnbBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454741; c=relaxed/simple;
	bh=EHm4hcfEK0RbqfTmEKHP1+K94kwDi0FBjIz/u9av0T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZQOGTdrqCA0OTPcdWX1P166slKKvwgs0QhPluCoRTv3pTU3S0qlHiBCT+GBYnYa+Vt0i5JtNJO9aGhxIaqryMSoJ3b9Syc3jXA2A7CsX3XOrOmWRCIV7m+U+LbEafVgGRSem1r6brei/s1IfPW4j0bW+1oq9/Chhp1pu6HsfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rqc8qK04; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47663aeff1bso4981151cf.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742454739; x=1743059539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHm4hcfEK0RbqfTmEKHP1+K94kwDi0FBjIz/u9av0T8=;
        b=Rqc8qK04lII6354l9jMm3cAXM1gJPGAR1SorhrED8p4nXDfQajeTRr3ZUW9LzFz9n2
         lA3sb9Mx/V/p2kHXxD4A6tnqybRO4PD/j0hJTCSfWRdlaHRaZ67zqRRDSTLTPyEPFvlB
         Jx5jV4iYyjoyCMXTjVhfroSFHe+muWkLWPt9BfJbCm53wWhRjztdCgNzcUiEdEtckfFy
         jOZVXvGx7xF3e7fQ6ZQDhuV9XCRkuLJqJRMeluTs82A+s9mkw8IoGywERZT4yJ+q7Wpl
         9/EhzObRFhiRyR8fXSxcQBvZM+FWBbPc4jHaur8nWYtGW6m74D+ePV7HZc4u2O44r9zO
         HDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742454739; x=1743059539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHm4hcfEK0RbqfTmEKHP1+K94kwDi0FBjIz/u9av0T8=;
        b=XVBnZggVfDIGes3C5L8fyFgGPpvLRS5XWJfCI9rkkL7x2YxnH/CkT8+16BDje/Q4qq
         ZblU+95/LdBdAUzi8KV8QzaVVy5MWv9ZsIcn0IuFUVekA8IWXP3ZsjeOyzZHR8mwR341
         PVTOT2f2MHEy9xcN3l7GnE/zBxqnCfcMeFXnNnZEvcU7gBc8wKWcrzT/ermZUN0TiCxi
         HADHlvI3iJ1BKDHMXLt41NPMZ/Qy//diyqCWiG2QAQSrU6Q1yy/JIepNr7tj8M6IP1hZ
         QU2JiOK0X9lAwJf8EqizFNeISeGmtRYUocDhG+1zAtsNr5FgjJC9iyCZZfoYfm4vDPT2
         TNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCViKHGD3p+LBukB7yulusAQdbzx7c2ufijE46DvQX16xjW3dZckVqKXPMGzQu7/Q/+wH9MNGkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpxptsxIaPLJUtIcFc7Yd8DAaew3XAdCCo73vAxCjG2kg5CSt
	+P+w+piiXSsCSe5z/Bz8VZ3WVszT2nGwr2S5DqUB/7bC25CsSgCsFvPeo4BTttwN68ZAagGYBMV
	BKtrXAUy9gJexmYKa7omIi+54mSevQqcFIdO6
X-Gm-Gg: ASbGncs2fgS244LNCw471k4vQPo252lmrrzCdEtmMek7gkWQ5aeeqGtnOQIjo6VlixV
	ugUkL49JLg+XqCi6MMInjjSi6AjrEL2chtc/YeRvxTVIWfbh6kHtFTB4IDvqGVTDBZWo+51OYH9
	z9f3Awr9kGyBnglmxQrJZUwXLX
X-Google-Smtp-Source: AGHT+IETs8awZ9XmUygPRWQxvJ256PxswlSToaJdHqf3sErZB4kDgwa4i3kzYvT01Ec67mq94VtUhyWj+ryUdOjJndg=
X-Received: by 2002:a05:622a:5810:b0:474:db2f:bd32 with SMTP id
 d75a77b69052e-4770838f052mr104403371cf.38.1742454738569; Thu, 20 Mar 2025
 00:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230743.65267-1-kuniyu@amazon.com> <20250319230743.65267-7-kuniyu@amazon.com>
In-Reply-To: <20250319230743.65267-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Mar 2025 08:12:07 +0100
X-Gm-Features: AQ5f1JoTVu5hfG3RL9N_xRUyesPX6aoVrogeOVTT8lMkARiEUGwLlR3pXiJsmhk
Message-ID: <CANn89i+LMV55g6h7cvXpwXSbdAkg7g31imVhE1d_vJeyREL_1w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/7] nexthop: Convert RTM_NEWNEXTHOP to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:10=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> If we pass false to the rtnl_held param of lwtunnel_valid_encap_type(),
> we can move RTNL down before rtm_to_nh_config_rtnl().
>
> Let's use rtnl_net_lock() in rtm_new_nexthop().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

