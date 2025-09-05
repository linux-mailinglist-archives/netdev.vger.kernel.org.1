Return-Path: <netdev+bounces-220295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ECFB45554
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2E7A45B1D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8142F744B;
	Fri,  5 Sep 2025 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hndFzSQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC6179BD;
	Fri,  5 Sep 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069639; cv=none; b=PPjdHBanef9m/iUmIk/4WRHWfdfbGJyN6VLzWRwcfBWIo4QXCIPADsdtsemi6btmR7lcTPlLL3/IHxnOk+CnN4E9KR0sXDtBmOR7XMJEPQPH98rvmo8Op16bzzXMCoXuBFtUQ4Feq1/HAF7iLtPEOkAdOahpTdUqW+7Akz1e/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069639; c=relaxed/simple;
	bh=cZ91k52qR45aiWRI11wxOihV1b6M8Vq0BGMkzafS080=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=P+pOQiKgDDBoMDSdXJezxN1ocYbHNpVqtmkdjdf615R/EMRD50mq7xbJgphXjqwUs41X2VkKsYWU/qF/t4t1OGVIQy9GNzWsV9KP6Xm27NWWs9WbeZg3O/6WYG3Mkl9X4OiZ0BnISlblMP0knfistjVuhTzU6Fk3OW/z8xpyvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hndFzSQ7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so12368185e9.0;
        Fri, 05 Sep 2025 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069636; x=1757674436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cZ91k52qR45aiWRI11wxOihV1b6M8Vq0BGMkzafS080=;
        b=hndFzSQ7Hx7h5tMkrdkKg+qx1deX/43svdpcFOU93QgYIJTlR8j/cmONrq0AffyODn
         0/du8IGCpq2QXyRmfHJ9TakIRQ6a2pclMoSqVwXnvOc3EluqFIeD/uLsVOKmk9WeEIgC
         5yJibOXc5i208DKM14NNu6aNQ9+L0qdMJln3yzy1A253vUjqF1EDbr2okT6djG+HcS7E
         4T/YnUqPM/qQ0QpYYJ8pUkRCVPGQRJSp7XnPxf8KGfzPXhlMXb89PF0IMakVaGb9T9R9
         OeV7mqzixRnX4DpQ/B3C+4rKGB+SqyWxQfmrXbJx6NFxGY5vkmPVfZM+E7JZZg1mtVty
         fMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069636; x=1757674436;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZ91k52qR45aiWRI11wxOihV1b6M8Vq0BGMkzafS080=;
        b=nDwZByUEKKMHxvczTvmT5O5r/Q8kTV65mOo1eQtf/CYVSCsXGP3kD3js2rGNqoFEZ0
         LzrQiLB6zl0tdiNuJ5yc2ja52lCZ9buLbi7Lb73MsRUi/eM4FXHKVYn0eljnBpsOnzqd
         WdJNbHu8rgf6XY0QsqBdtzoSqxolagz5xh/I5c0hifMvsMrrC0IdMzeZDlSlTxwZnzCm
         nX+TYjTRJvNN3lAyubXcmwlyRDWu2e5mOEZWG9NhMPL7HlDTSNBIciMWv6WSKZbp6k8D
         hzkWQns8kTUybP1fbLXQNTKaM/h//HllmShMinJapJ3FFuF2r3NCZVD3dax5LOR3ADe5
         3kcg==
X-Forwarded-Encrypted: i=1; AJvYcCUCvXh+PYT4N6IWc2QYx2xWOC0AZ6BIV80+TFq3Zw6hZcdIKebfY3aGiwwnsFLzRWAJCjErB/NBUbQqQHo=@vger.kernel.org, AJvYcCX1tGxFv8/+fZi/kOY+OokWFiWakcJ//F8Fl2rHaA2CNssJt/yOJG5U84Kj9tJHlzk1KsK4i+Ni@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDs+1PRloSA0gVDZb39K6Kt1POpi1m4UU3bmhgFiwfy9S7rDN
	NeniLBEGgRo6WrR+ZRdNyRl4hlxEyCh/fkchZWX9PgCPqwhSFiMaZKYa25zK7gnz
X-Gm-Gg: ASbGncsFcKl1MPbgxNDqvEMfifC03XcaTfnQdxlKhm+t+ORI//s5E8HZPWUnj2raSDl
	iIsETkaDcKtbqg+Kde9l57bFzpz/h4BUQgKCbbUKZIFLwGbpNVO4Mw5dk0wbjvfd/os23xqcFkQ
	0UPt0Qb0mEz002XZqLJEeyrtiMAta+1ctwC6wLO/4l2/gXpXUrA/hEatKY3KOgoo7SeoJ43QVDa
	+CZApmmtp6K3vUELS/r40onLthjw6rW2u4ZhPWrYGG8iL/vBHXm599JW9ifu/Fjz1TC38IGOkJA
	mD28+IBX00i/GlXm67zFYjg2MOz72/tRSAaQArwvJqxvblRKoFFTEAyvsrBVDFVbp0nbSytcjSN
	WuWyCWeipgtz76ScgM/5ejRGwUWXKSMMoFFs=
X-Google-Smtp-Source: AGHT+IGV0V3oPnun7Z+s99bPB1MIypO1yxi1dOVcuTckULlQHv9YRvW4+4DnaXzlyLC9eUlQ9HNgAw==
X-Received: by 2002:a05:600c:c4ab:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-45b855b3032mr173294965e9.36.1757069635818;
        Fri, 05 Sep 2025 03:53:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2df4c8dsm54645465e9.15.2025.09.05.03.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:53:55 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/11] tools: ynl-gen: allow overriding
 name-prefix for constants
In-Reply-To: <20250904220156.1006541-1-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:36:38 +0100
Message-ID: <m2frd1yymh.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-1-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> Allow using custom name-prefix with constants,
> just like it is for enum and flags declarations.
>
> This is needed for generating WG_KEY_LEN in
> include/uapi/linux/wireguard.h from a spec.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

