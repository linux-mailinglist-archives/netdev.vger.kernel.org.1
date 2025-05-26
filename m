Return-Path: <netdev+bounces-193517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CA6AC4498
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 23:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89474188D262
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF57139E;
	Mon, 26 May 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="SmBPYy2a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF234376
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748293310; cv=none; b=O2Q7cHxMt7zVvj6wAefsbjWOSyQLeZekscIznIwvFsWh/8JDh8AeFhOhg9dWmGwH6Lbz5Q5gLKI/JCWUNOcn80/lb5RUm2zxqTRR5HYsYMmcTXpt5EtuWwbi9EcVuV3HGhS1OB8zGMozKLvfWqAlRevolpjEL8Vbnk0MV9to+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748293310; c=relaxed/simple;
	bh=+HjWUEMAyCP84YvEGp9jzJXEGgeuUeqGj5yGlvmUrwE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=VWrbK1Du+iCgaiUACt1wEWrtBnF//1o7PzOBYHd9NxO69FCEOYAjha4zvpSRePi1+sFgYsE/CldbcA+MXi2auIMbweD/WIdFGA74mLFGrn8JvxU0H0q5rgJ30O9GNjamZ9+V+k02ThQZPLHjvYtcMVrq3YTJFOOGRjdv74hDJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=SmBPYy2a; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad5574b59c0so495903466b.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748293306; x=1748898106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5r5GBgq9NlsydksY7ZcCwZGqMs+ks73/zp6Wuofad0=;
        b=SmBPYy2aMN/BFPN0jUgzCA3Lk/mhYfOEV5Vb0zH7KQCbuq79E2Fij3c2Txm3h+1EbX
         T0ZUKrmJbjxB5M+Blp1GldiIKuVVyruCktKuPEF6Qhu3kCnHHtGQ72XcBFsLDu4Fueze
         +BodkzKk+Irz263YmVoECpexz6p76v3K3I6gAfPeyDBbGn4CB0SJsj+wjDjZgN8YSO4D
         kAgJDE+z44W990emtG64nvy2/TgZ2yigZgFmZS8u8Lz33uggViv0P9GEFsPPxMQRkLT6
         +IGd4y1Hjytd6+0u32we1/EaqaqPu2qoswfova+kc8I8d0kgotP5zpzZglN54Q3fmskq
         gzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748293306; x=1748898106;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5r5GBgq9NlsydksY7ZcCwZGqMs+ks73/zp6Wuofad0=;
        b=eypZAaeJDjoVHBrOewyKSF1cG+M3PHsZ1pzGDl4Yw18BKVU0RzPuE+GpByDXusi6v6
         4W6uefG6sq+kyfXz1KCCWDlLyQDlEOw0o8x37I6q7YAxrMBqcdellcJGXuNRG/FpgXVf
         ytMe6GD8PKHFYUW+2ksApIjxadk+yqHsKrjyYl/8NXZvRu7zhEloC4/9St920vgeLtlI
         N7hyPVn41LQZEx8WjwV2Yi/SbplZdk00k5FiUedOda3CDmvxV1e6bRLnoN2NhJhRV6VK
         DKzg5eKf6rwSOo042gZZxnb/TdaTK3xzu5qj2ITuolyFMKOytOfBGRALLkzxz4scOwgi
         nteg==
X-Gm-Message-State: AOJu0Ywoo6QFgN0v/odXKXFpbvXdOP9r/o5Nly/JqOlJ5ld+f1l3MfEZ
	ju8LoEl9pwGEymmOqhurKqo4ZFT71duleLWgw1FlJktm1CLyPVXXWsBjO9J/IyoR2xwvwLt7Xks
	LC/8FMZw=
X-Gm-Gg: ASbGnctSrzQzQZOgifBzhIkff8kypRNwtwz/fZWEEr2O4ToZ4ESK0L0u31Uq3dtIHBS
	VK5PhLV1KYZRB1vj97RvYqSRFJyQkRW+A3ARfnVHf085wtsuCIHz3Xk6GhsCHfkCV6atUHYGJ3P
	r0Vpq9a9gfVQLvIcGUCVyY3/fiaud7sRy3hfYnJas735Xv5UVnvWg6KASXDkTcQC23P+pqmqD2l
	1ez5zqwB4WGJTNj74XA6qojhDMxdv/F4CaVpOjtdwkAw+Ut/a0YlqQvVXb4D7w34OKg2OKitlDs
	NaOYv1PSlJObmm4DiGAxTyQvI9N0V7psab/LNwaAtN3+81+XgXPQPiFzexFBm1E+GjBzbnCHDzG
	p8Q22L0do0AywBxCjRhpEI6Ai4YXj
X-Google-Smtp-Source: AGHT+IF0R4s9yTa0bgGbf4vJFl2COvaN6ICdG5SLnvkXlCPQVLheHKvBJA2J7J9CV/OpD6sYXvXqQw==
X-Received: by 2002:a17:907:3faa:b0:ad5:27f5:7189 with SMTP id a640c23a62f3a-ad85b07c2bamr872649766b.13.1748293306174;
        Mon, 26 May 2025 14:01:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4c9e62sm1731571566b.155.2025.05.26.14.01.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 14:01:45 -0700 (PDT)
Date: Mon, 26 May 2025 14:01:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.15 release
Message-ID: <20250526140140.38ba5578@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Regular release of iproute2 corresponding to the 6.15 kernel.
Worth mentioning that color support has changed slightly.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.15.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Anton Moryakov (4):
      ip: check return value of iproute_flush_cache() in irpoute.c
      ip: handle NULL return from localtime in strxf_time in
      ip: remove duplicate condition in ila_csum_name2mode in
      lib: remove redundant checks in get_u64 and get_s64

Ben Hutchings (2):
      color: Introduce and use default_color_opt() function
      color: Handle NO_COLOR environment variable in default_color_opt()

David Ahern (1):
      Update kernel headers

Ido Schimmel (5):
      tc_util: Add support for 64-bit hardware packets counter
      iprule: Move port parsing to a function
      iprule: Allow specifying ports in hexadecimal notation
      iprule: Add port mask support
      iprule: Add DSCP mask support

Jonas Gottlieb (1):
      Add OVN to rt_protos

Jonathan Lennox (1):
      tc: Fix rounding in tc_calc_xmittime and tc_calc_xmitsize.

Jordan Rife (1):
      ip: link: netkit: Support scrub options

Nikolay Aleksandrov (1):
      MAINTAINERS: update bridge entry

Patrisious Haddad (2):
      rdma: update uapi headers
      rdma: Add optional-counter option to rdma stat bind commands

Stephen Hemminger (3):
      uapi: update from 6.15-rc1
      uapi: update bpf.h
      v6.15.0

Yuyang Huang (1):
      iproute2: bugfix - restore ip monitor backward compatibility.

ZiAo Li (1):
      nstat: NULL Dereference when no entries specified


