Return-Path: <netdev+bounces-96454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9765E8C5F69
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 05:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E95B21E1E
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 03:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB290376E9;
	Wed, 15 May 2024 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IQFb+fnc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88793838F
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715743965; cv=none; b=Tc1xT3NVGQjm1mpnQuhElOjZtMBtbwkW56xQeOPHH9BzqtnKGpFJ3AWjJe42lPj09Xn8KbsPTygzpmMHDURhEDVjkdeeWmulu5MPqcvQfBirBofN/mQDBd1TP8pdj4gzr6xLQuNimUkrI4CCyhvhbV2V2V4EUBMT6kE93me6vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715743965; c=relaxed/simple;
	bh=IwjxX6lGjtRR4HsC+Tx98ybpDz/8CNenXrNP0R7dQk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqrLoo2bz0xI2+Bwf3HZf9U4XNiLlgV2LACz+/zV+As3EGx/mOSLjG+Tm8rKVPEN7QJzVcFtxD4+FDkztMuXDUOkKdqp9vci2Il3l12xUr3MG8zrUp/ZoE/wQAamffl+QSaA2ClbcOHd3c/cVaRHQPNaRJZIOJbw+J0vXuzNOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IQFb+fnc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-574f7c0bab4so368578a12.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715743962; x=1716348762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n78oaAZRyO+VAfWO7SduK6Bbx6aSAbla91zbFFaUVww=;
        b=IQFb+fnchIRC7GqVva+r8lW7Xi4SHJiGntne8eKqzYa3ARlBxbtWGrrJyALoWIuw7c
         mz4PZmkXItCiBUybEh9TtE4Aj3DdzPeckGDAqDQ5H3XgFWnDYuCEyyGUDFCA6WxmPQ/K
         Gw2poZGgOlhCEx+0YxVFQs+IydHtdsQ4/5x1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715743962; x=1716348762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n78oaAZRyO+VAfWO7SduK6Bbx6aSAbla91zbFFaUVww=;
        b=VXRT04JYsVDbyRTDTUPyJHWwrkbAag8byAoK8vly7yImHBtO/D+eyolHedbsN30+g2
         Hd8mHlbsAzi/fGv9t7lRsnBpykumMoAsPRrRURz429flijhzm1EBS7bKmcJi3qx9Vvvi
         1nP8O7h5xUCHS9x4yjv7pyTzh3WWGxfwUlXbuU48/5eIKlR6posHnA/k2OmhJB/DQ4+H
         P6oK+nYESmBm4NQRtO+C1d3LJPUcXi/s2gRrgAPfRLlJekYvKSbfvZUtcGAVC9lsb8ws
         7T1ROnKg81hPPN26KHJo2pKBGnBmKD9fnWKwiS6g0jvQtZcKvLp79AGD0/O2XGYHDfIL
         btGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFeBt0wa/Lhk92w3TYtbwVoBCqCgURnUcs68oAsu0O3yUMHU9tvp9sOrN7yxw+eXp6G3Uh4w+4RPYAHT05ZVlSPlxmAJHW
X-Gm-Message-State: AOJu0YyXRay0uFDx3yvnLQSoC3tSlUlaLEuMjjvgdvlv+YTseVLqu86P
	LlNO0t+dnmTrDMi0Stcdh3oFtIb0a2JmWpAncETtfQZurY//ZgLiC9DDJ84ZkuHCQhUsw7XGD6s
	CxImt7w==
X-Google-Smtp-Source: AGHT+IEbJqOMEKIuLzdNPxBk6FQnmg6z6AeBmfYHFEkV3IjGq9mlbTX8+pGLMOL/xk0SJj2GV5nN6A==
X-Received: by 2002:a17:906:5293:b0:a58:bcb2:5e33 with SMTP id a640c23a62f3a-a5a1167bb96mr1672922066b.18.1715743962148;
        Tue, 14 May 2024 20:32:42 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01652sm798194866b.167.2024.05.14.20.32.41
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 20:32:41 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a352bbd9so146508766b.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:32:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyOInzfQDsHLrGEwcr83XdqudefcZLzUfXzArpS1Mo88w6Jh0QiNB1bmLnh/FN8K6uQ8jYeCeEAE6BKWIJRHX5NCGjkpSF
X-Received: by 2002:a17:906:70f:b0:a5a:7493:5b68 with SMTP id
 a640c23a62f3a-a5a74935c7emr527515666b.24.1715743960872; Tue, 14 May 2024
 20:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514231155.1004295-1-kuba@kernel.org>
In-Reply-To: <20240514231155.1004295-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 20:32:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
Message-ID: <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 16:12, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Full disclosure I hit a KASAN OOB read warning in BPF when testing
> on Meta's production servers (which load a lot of BPF).
> BPF folks aren't super alarmed by it, and also they are partying at
> LSFMM so I don't think it's worth waiting for the fix.
> But you may feel differently...  https://pastebin.com/0fzqy3cW

Hmm. As long as people are aware of it, I don't think a known issue
needs to hold up any pull request.

Even if that whole 'struct bpf_map can be embedded in many different
structures", combined with "users just magically know which structure
it is and use container_of()" looks like a horrid pattern.

Why does it do that disgusting

        struct bpf_array *array = container_of(map, struct bpf_array, map);
        ...
                *insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);

thing? As far as I can tell, a bpf map can be embedded in many
different structures, not just that 'bpf_array' thing.

That spectre-v1 code generation is disgusting. But worse, it's stupid.
The way to turn the index into a data dependency isn't to just 'and'
it with some fixed mask (that is wrong anyway and requires that whole
"round up to the next power-of-two), it's to just teach the JIT to
generate the proper Spectre-v1 sequence.

So that code should be able to rely purely on map->max_entries, and
not do that disgusting "look up struct 'bpf_array'"

Anyway, I've pulled it - the bpf code looks broken, but it looks
fairly straightforward to do it right if I understood that code
correctly.

              Linus

