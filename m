Return-Path: <netdev+bounces-127949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255709772C7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F4B281732
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD111BF7F9;
	Thu, 12 Sep 2024 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpbLkVR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272AF1BF7FD
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173381; cv=none; b=oJj47SxPw/yT5o9idGhJeun7112ykZRa9U79Fy5bkeSzXiM8e6XcEg9801loVsWZGiJiDWIJOgjiW6JtK3PO1sGy7o75I1DkoV3BygsGjNO3WGMBhxoHed0dpJzgJbOHt8H224NnzSW8IbctpnSF9d7O6mEvsSbldpsyGM6haJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173381; c=relaxed/simple;
	bh=SUcQGr5PfNMlHz5e9Y6nWUJTf3WLLLtWM0coQgIUDwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOt4vqU26sxltSz8w4EUx3PuzdqHKzp+N2S3pQXsX56xOEzxYyTMZ8v1bHlMJ/S66SKGsLTwl3+jQpew21SkFMZQyuPGO0m1ODenSVM14N9xBUBth3plua+bUO+UmtQiiUxb5WAxfF5yhnrnIRBTop08ZFS1dXP8PmO1D5W+RoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpbLkVR4; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4582b71df40so16341cf.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173379; x=1726778179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUcQGr5PfNMlHz5e9Y6nWUJTf3WLLLtWM0coQgIUDwo=;
        b=xpbLkVR4W73vkeP5boaCU8r/UGWplkAqifYCor+4teJMaKDDQWo7q76EqoZn/g0e1o
         lIjvicTZJDmdKnpeBdRj2clYxTWzVMlzyfOo4CkaTiLDtzqae19G7vULixN6Bnii6cPB
         Pgw4Hg/vULLN4D3toEj3zSLajZ9+chIh/pvroM/zUPFbJS5WXvUy0qyL6CTuzjncZguh
         M9TFMTIPx4iljbfCJIlpcH0X5IHufztcUO65bjIvtgBDGyL/G+GkXZtSP5rBk9MRLSKg
         Vzn9bFBQCohplRBgs0IVqCQ3TVP/H1HThRvdTJH4BjbKDZDLxS7YsjUjm7KbXGpXYNFh
         D++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173379; x=1726778179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUcQGr5PfNMlHz5e9Y6nWUJTf3WLLLtWM0coQgIUDwo=;
        b=TRbKohnCKQ87UjdJigLx4pHcN3UUSP7nWTkO5ZlB24ttlEmr5ipQ/QxQkzqxjt+s1a
         jUuvZqBOtsOCFNW4b+RRXROPJoweqGuCxKWrvYTJ2KkSyY58ZOHEb9xAsZhakS6Jiwp6
         MEp/iw5neA3eoU+euf707mqMnuQjlloPonOH0k+bB2zlDxGK8U91RB5e5Ll+z3Hvrv4p
         iHnYVMJsJ+v/Rzos5aYbW0pguqxKSYQsmS0PTwk3Ya7ho2jC+w74J63ddK8ieuBlom0l
         DmqYL3bTcLB8u5TpESGTIoqYtZqN0/yB3ZhlAosNEXN2fZgYIpiYgCOdJuP9kogHX+cR
         licw==
X-Gm-Message-State: AOJu0Yz1gKD++vcl+2+eXuV7a4lfLtsFVgVh/r0VL2mHusUnYAckJgy5
	uPyZPuA3NVaDz8BEpfyFTlAg+JtJkaqj62smFjeAo23MLcZTVPTjlq6a+k/A0GR1O97coFpC1ZD
	BwAbTaDPFTZsqP4HLbqwzvm+4vKbWC7r8BUb+
X-Google-Smtp-Source: AGHT+IFmDNfpqi0M7SgAnL34Cqo56IEygwKQDBAJrD1/TBkxUtyZPGUNs0o6ALmA6bKW4FyO83z4nPYan2C0fkW2t7s=
X-Received: by 2002:ac8:5dca:0:b0:453:5b5a:e77c with SMTP id
 d75a77b69052e-4586079cbd9mr5757001cf.10.1726173378727; Thu, 12 Sep 2024
 13:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-5-sdf@fomichev.me>
In-Reply-To: <20240912171251.937743-5-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 13:36:07 -0700
Message-ID: <CAHS8izNcJ2=HhFiSp9ZaE1XK7NSd9TnPXmFintdBkOEQ42Uj4Q@mail.gmail.com>
Subject: Re: [PATCH net-next 04/13] selftests: ncdevmem: Separate out dmabuf provider
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> So we can plug the other ones in the future if needed.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Absolutely wonderful to see! It will make it much much easier to plug
in io_uring mem or others in the future.

Probably maybe at that point to rename to ncpm (netcat memory
provider), since it could be more generic than just devmem.

I'll take a closer look and test and provide reviewed-by


--
Thanks,
Mina

