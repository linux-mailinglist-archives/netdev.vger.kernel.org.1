Return-Path: <netdev+bounces-204429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F3AFA647
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 17:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D76189B0D2
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332821F2BAD;
	Sun,  6 Jul 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgJk4ofk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E42E36F4
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751817586; cv=none; b=kLPD87izyfVG/ZoifXPtNZ/K7P3AaJ3mfAan4RPnEcTfIX1VnGqd6hYsgy1EXdI3pKhoTEnQP7k98JlcpwI77sr58cPZBYFWlZU7GMXRj5POFBy0AIXAUMH3VhnpBdvd5I5h9DoW4eTAkck2V/8QX5p80zNGVpK7EP3bza0DMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751817586; c=relaxed/simple;
	bh=3dUiT5cXwB22bAxVd2fcorsZSrhHvb+baEB/Y/uKyTc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aTEjKwEpu2+GPljelH6CYuAp9ErDdlYVSZLndOUZJ8Wk5tpIQVvvouoqULTBGz+NLhxVy0XvDZbMd1Y/wmY24O6VV0hg+nu1vkw0ZEa2ZKn5L51F3yGlf9ASat4XsxRR8Gm8LGKVGQMlAuLm9aNZS+AwD9iJ+AaxNGczBQj2VZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgJk4ofk; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7db5c13088so1841450276.1
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751817583; x=1752422383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKcbKOdHvyccD7b2W68KXw7WI1+4iudciFUGUK6FKug=;
        b=TgJk4ofkss/25d4jr9yhDOuycghGDXr5TmsCxGMFFsygFpyQAtdndZqH4NB2TFtp1m
         UTJmBnM1MVqlHPDWkU+G+f8okRaBzyQ0gUU4DAhEcnLy91lIMjSPXZrPKlyVtq83dWTs
         p0g/wtYAX2llXLo1MPrHDDGS9Xx7SqQwHrnAS1I2H9iyXr7sM7jjQG+6luYdFWJepfhZ
         2S9v/yNtDuqkmnpqviu6m6U8zEyUYa1JU84c+TjmcajmpfATBhZvr+RkwTAppCI/q7z6
         h/Rqs/sUhc4l/FzBcmADA3L27h23ZKGdOPpmoBS30TE5/44zznQhJ8LM4icH4U7Y+6uj
         8H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751817583; x=1752422383;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mKcbKOdHvyccD7b2W68KXw7WI1+4iudciFUGUK6FKug=;
        b=oYb7rBXL+AV3JK/ZPfizbFjCMBJkCYZmOs3NJ8C1JX3vv0qlhRSJl5cuDeHC1AFlv0
         +k8oj0wTWIZbtU31O90BEgbEZVnS19seaHkMU+KljD4FCMmUjeD3CUSay2uQZ5YiH0hd
         P4rehukSZHR3tuX4q8I5gPBNHkGOkf7b2hd/f3LlVTF0NWgF/Qim3iQvoo7xVFTWFGtE
         1u3Sn0HroO8ADjtX4Mwqvya0Hlbb+ZWlN6rA7Gka9NPSVfYseS4gU5tKL9DwWM7jrzjj
         W6FSYLRlVD8v7UFR9rHDHlCb/7uyGD5LwpJuR+8sfs5kyh147hjEb0XfOdUshxJ50rot
         rvzg==
X-Forwarded-Encrypted: i=1; AJvYcCUe7slhiFAvj8EJJXa937NC7LTLyK9P4AclTSkWzABkRl85CPb2YDgTx/g+QAZZi5w4tuoiVeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj26VwrPm34jgnnZmbu6TSSwZs1LxSCDBxesmXime6sITW0kil
	hiyRynq+eLsMGKQv9eRRuizgMkb6fU05FlFJLOMF9SvAoAtYin0qjA8e
X-Gm-Gg: ASbGncskucZP2S7FPjcP3XdGJBbb7qFxdK1jW3hyvF2lEF0Agcg1DkxJ6+K4njZ5pdb
	WMMxj3lC//hLjPElcoZbMwaI8s6juyACLkgaZ6mLzbS3a5ZsYPvyiUEdCDFGUa/yHvmH0l25KxI
	0PBLZIsDFrWsDdR9yGuOexZciWRbH9EUOSpKM6IXYlM2hGolvqBtIuEspHhcM+0yEp6INguWZ8r
	t3GnXqS1pCYoduqq/eQDXBr9K9nRyBgIPPqE73MMzCjV3NeUfiFaKweCBsIh2pcCslnXwHp60pc
	81dhy0FYVdZ0NlzeU05iIM46Lm0ZPnkQQrBcoumH6Ty2fW/Vwo4P306PpPEBBIQU2mPsnbPqIPn
	NxhC+TuTH7iVmMFXY6C1u/W2uBacwPhD72SLYSMo=
X-Google-Smtp-Source: AGHT+IHGzVvvDjXFFrYIyCSUmKy5K9m+yIuIAojG3HT0QNQhZiyLDBXcEp36e4oGPW++DMc8Le1+ig==
X-Received: by 2002:a05:6902:10cf:b0:e89:66a2:4f89 with SMTP id 3f1490d57ef6-e899dd98b29mr11993960276.23.1751817583560;
        Sun, 06 Jul 2025 08:59:43 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c48b086sm2048536276.42.2025.07.06.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 08:59:42 -0700 (PDT)
Date: Sun, 06 Jul 2025 11:59:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686a9d6e4083c_3ad0f32943@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-4-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-4-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 03/19] net: modify core data structures for PSP
 datapath support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add pointers to psp data structures to core networking structs,
> and an SKB extension to carry the PSP information from the drivers
> to the socket layer.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

