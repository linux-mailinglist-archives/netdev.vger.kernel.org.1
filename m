Return-Path: <netdev+bounces-140844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2245A9B879D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF141B220E8
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA751A29A;
	Fri,  1 Nov 2024 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6JcSABG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3CDDD9
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420693; cv=none; b=lLGDvGKPDa9dEBIQWy3NgA8S8Z9ZwEkLmsEo+9KjA86gJ+fRtelvTDOxGYacA3QaF0ZI12feuN455wK6wn5fLXW4v9csMo3bUsu2nvLf7GXeCs8CSeR2smxysS2JtoS4QKuxlUxOCrHZOBaf1ySuWSW1ACX6Os8iehndCC6ibRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420693; c=relaxed/simple;
	bh=qugBlEx2BEDuVZIf8VNwaVpMsm7e1PXnMQoFpvD697Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=EGr2O35P1LXDI9+E87bdMOZ573+Sb9fBmB/+ZrLz0F5t/CysuqY0X22mPrmWSKpiok5nmXawn0FTgLg+pX5/lWL832B6BTTCzKPX/eRHuR0J44pmgXzAUGiM8ltjJeZ5q8KauvBA7eUg8dWj3EQ2unsT26VqDx838YYJ3Tn9oJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6JcSABG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so1663503a12.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 17:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730420685; x=1731025485; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:content-language:cc:to
         :subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7luR0BC9ynbXsAhXHAj05/xzL17gS08ODbtP/2InMs=;
        b=X6JcSABGSO1zzOmf7CUFDmWug5qBJNP6ZYDiDX25xvnV16o+d/4wqKFzan24QPi63h
         sUOt0ethpbfHomMksYlQCO7AxBzzUg0OP6UptJT4FD11tVAPnwZ+x3Pz+6nSjUB0a4ii
         y6M2N54NiXzYb3HczGqT9aPHclYFXWgxh4YxNiuk/3Wvab76XqwhCKLRNJRpx7EKJIDb
         rsEq6AWPIcj/MzawT5TMRBEksyVyge1dk+uV0sigV/cyBcSI8tTaR9FEw11eGd+7cfqT
         lRymBO9yeV64Wsf1thsG21Hvj3Sp5W6Zh1BAWM2+WwT49elqMumHmT8t8B9LROPzBM06
         LGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730420685; x=1731025485;
        h=content-transfer-encoding:organization:content-language:cc:to
         :subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7luR0BC9ynbXsAhXHAj05/xzL17gS08ODbtP/2InMs=;
        b=RGEN/bdAg+Hk/eXFUlU7Pb1ohN8psycrXdQY3z1L82fwJ1jVBsQcCURmY6tJ8G1v4Z
         kLIpVf2YDx+fHBTaBTlQ93/9jFp2zfFv/PJOpQEV0upr0/V/9dsOndE5m9sKjiNpviG9
         F74U2BgtDG9EReaLxlFEsn3eg/Y1TG7VNKLA2JsvzUn1KJLJ4pbzpx0+dtL0yLp331dp
         8r6HRhsQeLxtX6fVojp4r2K6lH/g2xsbzCpOK9HySHdvuBHFOiMLEM65nmNY0Re8VfkV
         SNnJYHoYnSzwxnktShEZuaHYwIsgWIs+ADJxGVJ5OkchGDZAF4uqbhFVFG6LE+Oa1Lqx
         NPsA==
X-Gm-Message-State: AOJu0YxqGcKoOi818GD6duBGj+Rw8yfAR/Box6Ss0+mMuviU3g1vPduo
	rH3T0GqFd/EgbHQMf1L80ekvHQ5tsmLrku+F5o0LdAcc8KcQ0XQjxAMLlA==
X-Google-Smtp-Source: AGHT+IHnpWXzEnM9LokF3C+S5rA/6uz/DF50/HOmeuhUVjjLi9PrD1O/m3BiWdN+0T8M8fWcNaN/FQ==
X-Received: by 2002:a17:907:25cd:b0:a9a:4f78:b8 with SMTP id a640c23a62f3a-a9e5089c09amr470832066b.2.1730420684808;
        Thu, 31 Oct 2024 17:24:44 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56649337sm120008166b.183.2024.10.31.17.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 17:24:44 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <74eaea75-5231-4ab9-a11e-4647f9eb8e4e@orange.com>
Date: Fri, 1 Nov 2024 01:24:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: U32 - systematic ht leak since ... the beginning
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>
Content-Language: fr, en-US
Organization: Orange
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

When creating an u32 filter needing a new hashtable, gen_new_htid() is called to
allocate its ID. It is (currently) based on IDR, but "encodes" the
IDR-originated ID in a peculiar way:

  static u32 gen_new_htid(struct tc_u_common *tp_c, struct tc_u_hnode *ptr)
  {
        int id = idr_alloc_cyclic(&tp_c->handle_idr, ptr, 1, 0x7FF, GFP_KERNEL);
        if (id < 0)
                return 0;
        return (id | 0x800U) << 20;
  }

Unfortunately, on the remove side, there is no corresponding "decoding", and the
garbled value it passed untouched to idr_remove():

  static int u32_destroy_hnode(struct tcf_proto *tp, struct tc_u_hnode *ht,
                             struct netlink_ext_ack *extack)
  {
  ...
                        idr_remove(&tp_c->handle_idr, ht->handle);
  ...
  }

As a consequence, the IDR fills up. Eventually, all attempts to create new
filters on the interface get rejected. Additionally, the error is cryptic
("Filter already exists") due to the special handle zero (returned by
gen_new_tid) *not* being intercepted, and being used as a normal value instead,
hence the collision.

Unless I'm mistaken, this dates back to .. the beginning of (git) time; the
problem was apparently identical before the migration to IDR:

^1da177e4c3f4 (Linus Torvalds     2005-04-16 15:20:36 -0700
  326)       return i > 0 ? (tp_c->hgenerator|0x800)<<20 : 0;

Please tell me I'm wrong :}

-Alex

