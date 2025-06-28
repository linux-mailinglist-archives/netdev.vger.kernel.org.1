Return-Path: <netdev+bounces-202170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F80AEC7D0
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838F017CB6C
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7164C24888A;
	Sat, 28 Jun 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGXE5oG3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428124676B
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122141; cv=none; b=Yityt1fWnnFLlQO1+wKw0TUgmpEQCDaeBgRI+Z1G+musfeDhv5F+RvngulkNtmeqY4D81CWsO9fomaZhvyLQdTd0NzJiAGQ6hiWVk9MqxWjxJTZUV3e7tyYJMno7ZY4whYQQGloU5dlaYjnJqgVbx+BiZ4e7u5tWm7doltjDbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122141; c=relaxed/simple;
	bh=WkX0dwZXK33LK2H6RLAuDqTRYZrytcTCLu7lpXlS2BA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fBPzme40e6EgGT9bnZV74+P9Y3HQBBTtiOvpY6lzbaUzzEkb5vnu0GfveGXAnSlg90QfUKlaMHEBCUhcTa8yxw5SvSQ7ARF3jet6tqkDW5Ud8xKTTslSW+EG3WisXNq05yCck4eRjIscYxYeROS7AUvlNtCK2MGpgcrlBdxjjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGXE5oG3; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e73e9e18556so3178537276.0
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751122139; x=1751726939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cZFBog71uQHawRLRh+uAWxKVmzteB/Z8SFpAcvGjUY=;
        b=IGXE5oG3CpN33/dVDVTaemODodO615W1KhU3BVYfPsl05iDiNqJ5Z1A+qwcV45npko
         F6Dx+WgrGQxzo+fJi0zlVU6fGakmUWXzASmQ+ewhpRKo9tGSoBs+/HM6BupYPOK4SNmq
         G0llRLYknJJqTuk76eLaFxSXsH6svze0w0WuP/NA9V1xhwcDeaFVqnq2Bf/R8ZfwfYC2
         sFlZIVDVivxWylgU4Xm/rE+baV5s1gKEoAH2/uTv1cwLUVJrFrdC4PmX5dtrKvtQLHN6
         2vUkXifsHqgnpzFMeDKzl5Rxxgm6IW3qhtLW8SkyMSaZKw2XO/boDdOmCYeUVI5RCCs3
         yRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751122139; x=1751726939;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5cZFBog71uQHawRLRh+uAWxKVmzteB/Z8SFpAcvGjUY=;
        b=Ci5W7JxEOhD7ArY2kVxptlggu38D/2whITWpOum8wtLKzxaiJKe1GXJzXEyV2jjpsU
         VlHnxvGclOJybwmOimkBw17GJI5j4L+YXU6iRANQHPjNd0L/EAy1fhzlpzYu+VAOrivi
         GoNAXSGlsA4XHKN+jUAp1lo5F6CED9EYUmIpLT2GDuv4ivh5JnuChglzdop89L8JBWza
         kE8QxV1ras3z45c2HZZofmlB4bqpHb7a1XPWSgZR9ZaQe8Zt7k9KvC+4PtnI6jtK3cPz
         YADgcLX4V7WwOU4obMzCBAKRufCTrEMVLu0pCKzhPX5vf91upQyOsw18q1RTLmhIjK7K
         ExCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5MhzEVmytR8eSLYUmZtXX1YdwOhzSCQheT5Xp0rMPGvjfm1mUcB2EACB6O3xvzBxvIy7sah8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBk4FQVNKfV3gRa0TIq7kkiL1AgLRHTyWfWm601gzu9suqMHwH
	MXsRHM6kluc1D5TR3KXGd07WqSldEyAdOc2qdbsuSs3l5yMwql0ZkOCc
X-Gm-Gg: ASbGncvJlj2fBj8nYJhgxsyPqZyvjK2Ff6xsCpHX0VsMk8IZE8bkGKcQVyJSLSxi1uD
	20m3ek4+EPe2ykhYIS0/RZbPxyJc/PWGp14lCg3bsmkECnl+MrhymAZTGq4FwihtLi/zXvWDtww
	pj4wGMI9mkqDUzVTvSMmHTFKCxDTtcqtpRi/FyUUSHFSxZbjkJpLY7qgGvFxdPiHT2ETgOhuqVU
	NJ8KTwaeXHrRU23uiBQw4bFUzYB/BKD7gqzxdzCLdC7Y0d3tYhoO5kbi+fJx5/5fLzcigvbAni9
	4aXoAfT/YPHZorJ16Y4Cva3eiCWhdtVZfpRXTAxM8NKpS18FqnJRJHTsGJ9nIbVXtR6jkZrqGE2
	J4CX8Ri1Mf6rVQQAMncy1bcmclfej6A6d5nI8OZu3ApFFzsVi4g==
X-Google-Smtp-Source: AGHT+IGistoat8x5l0JQQZ7vpIluaQcaJCt7hSOVW7ki34v+zZYKS5ztBYAYlhjNSLLKO5sQ5NMQUQ==
X-Received: by 2002:a05:6902:460a:b0:e81:b89f:3fb with SMTP id 3f1490d57ef6-e87a8502571mr8773447276.24.1751122138826;
        Sat, 28 Jun 2025 07:48:58 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e87a6b4c9aesm1205654276.10.2025.06.28.07.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 07:48:58 -0700 (PDT)
Date: Sat, 28 Jun 2025 10:48:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <686000d9a7c7c_a131d294bd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250627200551.348096-2-edumazet@google.com>
References: <20250627200551.348096-1-edumazet@google.com>
 <20250627200551.348096-2-edumazet@google.com>
Subject: Re: [PATCH net-next 1/4] net: add struct net_aligned_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> This structure will hold networking data that must
> consume a full cache line to avoid accidental false sharing.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

