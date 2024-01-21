Return-Path: <netdev+bounces-64506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B03835753
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 20:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FE2281AC6
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117338392;
	Sun, 21 Jan 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pb7k3Ur8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE14414A98
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865272; cv=none; b=tEkEALjXiGdlOhOOn6L/jGDVw8jtLw017sh/61WHj7Uj5oNfiKIfNs/TrlWoreD+uugbis6de+P9LNBcdRD2ou3VcxM9DgouNqc4+34GqNFAFcMaIgSHuTJOzNhP2S9+aeRXcl7+JH34ik0V7TXDQnXuSnZcQXbhPkBToFiS/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865272; c=relaxed/simple;
	bh=2FpoKLKzqH8UC9hSwhA9E7HCkyq8gOsBF8dHu25KccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCJkKcmTmUK4/PDGRZgBfR5KCg/vd74aGsiZaVgTInWywSk11lfoDDDNPM6uKccGo0RzJjAFdmSjf387NoRTMs/nRS42ufpIBZcRxJXdh12J7maqHKSau80h5d7Y5w3HX6zvZ1aoFVFGW7FK4AH3z8lbLZSqCuu8hzX27aqnkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pb7k3Ur8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so259370066b.2
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 11:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705865269; x=1706470069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ilsHoBAFLGrxDRmI028SujMWUyj+V2X5SyCrYhyT90=;
        b=Pb7k3Ur8ELXjk8kws/DCquJ0aRwO1f6XiTIz2OawJIrZSJKZ8QJUztXvAfbIVjJ2lq
         d5UAcRcg4PH9UA9zBADHkHbrMhmFv+ciSigR8Yjri7idzif7p0GC++6AbvVWnJKoJZqP
         zgFSJapFb8dYx71PTI53DVJO3kkMUL+l6ax+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705865269; x=1706470069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ilsHoBAFLGrxDRmI028SujMWUyj+V2X5SyCrYhyT90=;
        b=gVj5H9VYRgixfaf5syz7v5ko/kjgAxvt97jFQX0C1MTlXlPM09KWYGsva+Az3XlQxM
         OLHCrzqD1ajdCmxzI5di+3iDCQE+aCGh/Phh1a9XjndPclkDc48UbfQYGuUNr5s5SgaU
         5ao8vGfJE6whUIbECFmyNuKxxNUf7nhfngZwA82lrM1pKCZGUxrufaOxUucu5HkpXeej
         Z7SK7Th+kKlqFxgF3skJvndMqcG+P8RHE/pF+r7fIwq6Qd836wBl+q/cG+GTM9HB8tlE
         o8sr2tCFyXesfGp8O6HiznE8/yigvzrH3oVdXbcHg0I17L1OcHnptQEYjddkzP9Xph3z
         nNVA==
X-Gm-Message-State: AOJu0Yz6F572OQHH4njB9aU0923IUYkhuQEIAMEtHgP7spbBOlmNP+NG
	q781jELDZzkXePtv3y/CK546kYvVRYN/4MoPhoPIeSn3MmU9ZoQ7IN5XWFtcXzIBo79Vuu54PBc
	gdQ5TVQ==
X-Google-Smtp-Source: AGHT+IGMkLfYlU/2SF4qFEyTqg8wGjb+uBJg8PJJenLf4X9mdlvGnRPr2KjMC/GSrCd/vk8rHazSrg==
X-Received: by 2002:a17:906:5c9:b0:a28:b6d9:eed1 with SMTP id t9-20020a17090605c900b00a28b6d9eed1mr924609ejt.206.1705865268919;
        Sun, 21 Jan 2024 11:27:48 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090606c100b00a2a04754eb1sm12646984ejb.8.2024.01.21.11.27.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 11:27:47 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a684acf92so2390550a12.0
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 11:27:47 -0800 (PST)
X-Received: by 2002:a05:6402:26d3:b0:55c:29c1:4186 with SMTP id
 x19-20020a05640226d300b0055c29c14186mr493069edd.26.1705865267510; Sun, 21 Jan
 2024 11:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119050000.3362312-1-andrii@kernel.org>
In-Reply-To: <20240119050000.3362312-1-andrii@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 11:27:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
Message-ID: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
Subject: Re: [GIT PULL] BPF token for v6.8
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 21:00, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> This time I'm sending them as a dedicated PR. Please let me know if you are OK
> pull them directly now, or whether I should target it for the next merge
> window. If the latter is decided, would it be OK to land these patches into
> bpf-next tree and then include them in a usual bpf-next PR batch?

So I was keeping this pending while I dealt with all the other pulls
(and dealt with the weather-related fallout here too, of course).

I've now looked through this again, and I'm ok with it, but notice
that it has been rebased in the last couple of days, which doesn't
make me all that happy doing a last-minute pull in this merge window.

End result: I think this might as well go through the bpf-next tree
and come next merge window through the usual channels.

I think Christian's concerns were sorted out too, but in case I'm
mistaken, just holler.

                  Linus

