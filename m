Return-Path: <netdev+bounces-185282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3211A999DB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461285A2DE0
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19D26B96B;
	Wed, 23 Apr 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev2iaQ8o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992A2676CD
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442308; cv=none; b=aJNG6wB+cvMnO+kMBDgNZy20A5CM6BfHaq05bI1Ed+wqkg9ZGw5hffGfoN4JkhdXCnvHRf67alHTz6/YZK/UkbfOiM7sakBReFmphAVoSqpdNFUofk4xgorjGU1s5TU7n+mdA1Gqn24clZMErniLEElf7x6EAzl5M13jZR/ymrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442308; c=relaxed/simple;
	bh=gVCtGrcDJPP4LFpLQiVJjtc7w5QBYtFmhIi1Hyc6q0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdNpCi/zUIOHgsrlSwBZs6299aBJxXem3Dz2a8vhCvGYoO15V6msQkZXil45JGao3M/6z5tmG2eT0HEeEM+8Z1aTcQS8ztix/N4Afb/OMqiclW6t2pN3VWyyRNsZg3P/3FmtIxMDtyQ2txg40xnAplQDE0Kb4+S+YimoqfQ2ekM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ev2iaQ8o; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2264c9d0295so67365ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745442306; x=1746047106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVCtGrcDJPP4LFpLQiVJjtc7w5QBYtFmhIi1Hyc6q0Q=;
        b=ev2iaQ8ogdlVbifq/mNf3myZ835iVFcSY9oHQZCoB1gocISvFK3qLX3Fb7n+MRHO2/
         n7Fj4/hJLHqw8sAfJeXom4o3m5hV5XCOHO0rP1yKrBcafDrSBNZSNlkVSqRfFTLT2LdR
         IfDqYq3DYE7e1DGZxg0ftgGHaxd/uCg4KvlYCHdJG02/FiLLf6PYWVUNNVRtnxqp5rOA
         F0MXX+FE/doSQhwac6iuPh4iejYSnn7vbqmj/72oXnWGOpp8WP7oAJ/vxOPtZpaED/AL
         OK8k+Eh2l7lO/S/zFqFSLlX8vMxavV22OLBE/qEUJx1qbv3jQ94HABeuPwByi+u7xFCi
         CPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745442306; x=1746047106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVCtGrcDJPP4LFpLQiVJjtc7w5QBYtFmhIi1Hyc6q0Q=;
        b=Uynk3xeqPYq1MssOX5PT9L2npLDuuJenb3yQYC0f+ioE3Ylo34TMa5oH8QjHhOwlIr
         AT3D/I27lTz25H9mgmHW04/tTiO6fFlE8JKB22WppAhmUHWiFE/5nNNFtiBqo18Bwmtn
         ZQ3u6srKIZOKTsJaLH2gdr+iGSUCNTG+Nx2WDA6TuD3I14m6rYckoa4eDsFjIJMZ1taR
         O4UzsezAPP2V7IT2+d4V93eZYORM0oX/E73UH/ymmrrJ9yvCEoKXafB+/ABHIWBECFPb
         wGf/dJbyfKzurSXJDxgCh13BrQWmCmyVpfl7T1gJIGWtH96OAtle4tUCawsNCuEANKV8
         zSSg==
X-Forwarded-Encrypted: i=1; AJvYcCV7IwuTKcOtBsEpdRWREcw7NATXa7fJLbmi3Xo84VGBTaPYWWXyAg9uhjnnD+Ip/igxrc1s3Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRZj7OsN6ULDeqY3HspgMWEkyMW2FV26ZeXWL1ejMIoCSY5M2
	3oBiSKlVq/lS0T7mAP1hWfJbYuGHa09sw2HEXIMnmUC+TkK2Q6lQzs6tkqXyQL2NcYItem5tPj/
	O57VULxSEPNgKjPHwSYNLfvYaPg1SbWTaHzvu
X-Gm-Gg: ASbGncuBLTVZKUzQma27V46Nym5DMDoPLwk2RFwlUCwNHzFgmHzHFdQE0IZYATTkG8I
	j+2hZe+ToRq9Lp/bpYV2btBPeXl71gm4L9k7SUILdNsHCdlz9SIYYkXl/SVG1K4GYim6yo8KCKx
	Xzyh+Py+twC5fEqqs0aCwHHlKpA+0cW79FOVwY0hgb0UAtVV4xrRUGETvtAtFnvOE=
X-Google-Smtp-Source: AGHT+IH17FUDJdpzdq5TseYsn861iLDhqtSJ4arBwM1adaGGNEcSmFuu4gJettT+LWVYzPU2tHb+KFq1OujDKzFrei4=
X-Received: by 2002:a17:902:8345:b0:21d:dd8f:6e01 with SMTP id
 d9443c01a7336-22db323ece3mr130305ad.5.1745442305587; Wed, 23 Apr 2025
 14:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421222827.283737-1-kuba@kernel.org> <20250421222827.283737-11-kuba@kernel.org>
In-Reply-To: <20250421222827.283737-11-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 14:04:51 -0700
X-Gm-Features: ATxdqUEOBFGQsgU2RTNPz8b_mfidSLuKS_NFMvxoT2inFFMetFOSPsdEWvftJ-k
Message-ID: <CAHS8izOPQ_dF0M0RunYhXnUwUQ_ac3hTRjdNjbNPhOyLU+veJw@mail.gmail.com>
Subject: Re: [RFC net-next 10/22] net: reduce indent of struct
 netdev_queue_mgmt_ops members
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk, 
	asml.silence@gmail.com, ap420073@gmail.com, jdamato@fastly.com, 
	dtatulea@nvidia.com, michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Trivial change, reduce the indent. I think the original is copied
> from real NDOs.

That's exactly what happened :D

> It's unnecessarily deep, makes passing struct args
> problematic.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

