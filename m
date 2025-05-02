Return-Path: <netdev+bounces-187535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B96EDAA7B60
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 23:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422F87AFF9B
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310C61F7569;
	Fri,  2 May 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="AZhRR/Ev"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0D2AF0E
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221484; cv=none; b=F1p8DhquSNwxqVyg8TUNZNAOhzFgjHW6AopxBLgrYdTMOXU7WgdGY/aO4MtZKJXRYjz8l+CeLsurLv49NhB5PyAXr05txPyeSJ567XnG5FE6q2zlaMjA2yCHo+1mam0mEpBSjzwT3lQg/2sMfGLgPLxb97DMEDbTuPPu3AYbX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221484; c=relaxed/simple;
	bh=RGXQNtLTkh+xIhPnSkMALdI+GFl4K4fNKdAJQESg89U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqgrqS5GMU/FLXiLdw/0IfF580HKpqGYTq7vX7/k5VN3/B18/XJ/V/3vKEC/Ih1j5j+q1LyTkzfaJMSvdCNzHWGChANWf+P4u5tzRv5U7nqVu1RTE6ZVnPb8IWYNZZmW8hMIi3GkhenvB0QpNDnZSjxbvl7/wemTAkJ6UpYVDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=AZhRR/Ev; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f521e77e4dso317196d6.3
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746221481; x=1746826281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RGXQNtLTkh+xIhPnSkMALdI+GFl4K4fNKdAJQESg89U=;
        b=AZhRR/EvdELWEyiIf1WuDbs1PudlLz5g2zTy2AsEo9tsQIyeCR8ktX+2ojLbTpR0v2
         TLgq8pNZF4v5uzHGB7dbgXHTfzgSRFtKRfPioDAVwYJtJ54S8z4Skvsxsii+Sq+jh3dP
         IvTow1kg9KTG12+f4fIx2f+I0kngY6pTdOfPCQ3m3LRlhLJhN4RTi3HvfHqr9Kn/LDAd
         bh5Ry0Uc+wnVTHmTt4vnn7RprxMy9POgcwLnOlsAuuTXkzo52xpIlUgqhfQDhhcQTPlM
         hS9ov2tuRNbt6sWwloZvWwBsyBHNDeh6ybf7Onc2l1NRlJkLD9ewkgm157F8DLxVQt1Y
         /21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746221481; x=1746826281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGXQNtLTkh+xIhPnSkMALdI+GFl4K4fNKdAJQESg89U=;
        b=WAJcJolf+1wt4lYh+TbiTFTHMrry++IRB6Gbsz4osBpKrgDkEq3Un7CZvtX8CgfiX5
         Qw2CzOAkYuVKVwmhAAgxoQ5uQjZu9WatkWqeku6+8GHhReL1oajEfFh5LobXO8hh5V4e
         jSBnZEo6xIhzXZC2R7EGjBpfcMNZs/0WbkqnlHwt3Hv0gmmgVppD5muuk7X4/avMuUWk
         G9WHeOT7wqS+5iemHe17Q5c27a0dXv2tDi7neOdzjNSglnMppRZ/AvWjcCfRHwH++7b3
         yKh9NqPxCzEqYmOLQhk62aRu3qLsy+i1NFjnzwhcALxFfcW7DcFQWM7LqWYFVsqhnejG
         XHHg==
X-Forwarded-Encrypted: i=1; AJvYcCXwo40QvbzPzcHnRAEMEauAUgAJhl06xL9dacXqxbwZ1R4klhBlR2VKkHA9PzQYn4H7lYz2WSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNiBHNVWqSZHXNBzSJkJk5AKS/EFz90hEz1k8svq5MS5ZWnn5E
	AaLmJ9Vr2hyI+96CDBxySCoeXHHjKzd8RNA+olQ6Mjh8Z/YoXijeJMhBfopBjU6lBi6lxS/dA/+
	iIgp8PvXjQyr7b+lw7CssZ9o/cfCQ2SYi4Td2lg==
X-Gm-Gg: ASbGncv5VW3/NWAWvmDsEU4uauIElCkmOqylBLRGpctzG+axmywXwdaLvyzVC9LgTHg
	XFZ72GVCrkp/0zYAmVlQ+inF95dzmY3cOYoxG0g3mh21SGFFEtCWl00Q3Jx/jzTdwFRwxNgrkHG
	W1HNLJjxys52mhxPl1G1pkVpEmKsqstnsePruZFONQ7gvDziQ0w1jSOR4=
X-Google-Smtp-Source: AGHT+IERfHMRWcJQMEva4rkmtn5ehpt9XaNEm3Fv/nxtB2z2K6G25t/gHReTY9xAMlW7M2olUtASjCG9tZusu4eWnO4=
X-Received: by 2002:ad4:5c81:0:b0:6e8:fa58:85fc with SMTP id
 6a1803df08f44-6f5153770c5mr29352856d6.3.1746221481458; Fri, 02 May 2025
 14:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502161528.264630-1-jordan@jrife.io> <20250502161528.264630-5-jordan@jrife.io>
 <77957459-cd64-4d7e-a503-829a1cf892c9@linux.dev>
In-Reply-To: <77957459-cd64-4d7e-a503-829a1cf892c9@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Fri, 2 May 2025 14:31:10 -0700
X-Gm-Features: ATxdqUHL5mMsQfKQeV7aDz9_4D8WLgTmIP7TBLfiWweLEbVP5Zbljy49Y0_yJKo
Message-ID: <CABi4-ojQc-QwOpe_OdMCF4NhAQ5K32HfJt2QVGn8do_vSsudnA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 4/7] bpf: udp: Use bpf_udp_iter_batch_item for
 bpf_udp_iter_state batch items
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I fixed this to "while (cur_sk < iter->end_sk)". Not that matters since the next
patch 5 fixed itself but it is better to keep this patch clean.

Agh, missed this while shifting things around.

Thanks for patching it up!

Jordan

