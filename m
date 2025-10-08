Return-Path: <netdev+bounces-228238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A048BC56EF
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 16:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EACE3A703B
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4177C28B407;
	Wed,  8 Oct 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3m6+fyJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07282629D
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933699; cv=none; b=Fn5SGPpLk86TOt8ZnYnrKx0i1ykdIJ7dGn2oJ9y9qHC4jRtUS8tyZ18y/35HIEFrG06cis3OWJfdGT+NNrm6SKDUT72ByE7c1lcZ4w7DuDo7Ny1IgPloXB27EX56jZVGNlG/Nqn6TNrhsRw/UahLuno6Gm6YvHWj1DA2dYSalFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933699; c=relaxed/simple;
	bh=7kuSwWgFm/nXKd11wGabd7rfOymGvPQuJ7XIwx9AlAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQ65vjb9acwu4MQ/jCRgU9FgJeu/29GU/AbXzGCHvctKr+xgcpnkGW1PCa0+EWOcokRqR0aD8+BfcOiLKIoc4+J/rj2Afj+V58mBU3noyev2FGbwaoUPGjf3Q8vXfi/BUnJme2v2Cy4Vm9Ct0IKgKabOMYDcdxPq8cgk0fcu7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3m6+fyJF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e6ec0d1683so287591cf.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759933696; x=1760538496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kuSwWgFm/nXKd11wGabd7rfOymGvPQuJ7XIwx9AlAM=;
        b=3m6+fyJFZf4dzvlN7SCcdOgqF57c4Z7ryOhXO6/lwz06iOlbqe0MtWnh9gOjIJT+RX
         4ZPoi7+FARCmqd+rfsKinXNbXtJ7auJH/CShSklnSOUCQXGgIgPYjsIeU64LcZOjx94M
         yt41LH1Tf5j4aZxQjrzcNVTJ5cDTSkyOio4zK0cgPykw+/O/RoNX6XmkkgBQQCWsmTPE
         jPhZ3hcofZgrmpmYvuh6lJt/dX14W1xaz2lqiV3eUzbwu8nga8VJjSYuVGEA4fYhgCmM
         AfYrFlVvLm8uX/RbHlF96NgH7szH2Ya1k2YoHhi+N9C1f4DfME6eDYgcP6SdZhM4ShVs
         sUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759933696; x=1760538496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kuSwWgFm/nXKd11wGabd7rfOymGvPQuJ7XIwx9AlAM=;
        b=oat3hevR3efIEvKax25TWFtrk9IzGBeOi8EgTak+TKZGddfoSyZR7D2USSRiAOfYeF
         w8tA9Vln3jMkcUfbRvbanh0IRZOmC21sRuJqr8gtxVSTwOu9W/194uU+HF+v8rE+TgJn
         qvlPvSVc7I+ydVh/lOQntYpMkyQ3T3sHL7s8w+7FovQSkl95zhaqeOeYBF2pyi0KoLtv
         bSemdnHo/RaErCkqeD54mKPVLoGvJT2K2pPSrqX9ai4fr8pDiHP+vao+lJcI2vqdObqi
         ZIE5yPkxfh5J9/tjlnd6KJslZkDrJ5wgFzohvKtG1fiPy4bUNgLb0KKEU5WK4JqAjYNw
         Kx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9rFgBe37MyS0joHgJjMVSTJxsk8o2j753cGxc4eqd7vaUTG9KFP24vYAj3V0S9wfLKHrQif4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DxgtKaxSXuQtn3KgHoPOyOTH9pkW1RtvUJZXbgZDjSVAb/9n
	N6radQvdI6FFId2h/gVd5KRz5Ct4hTyVzT9Ni2j77X/wuQkVYtwuSr80FWr4M/QYhS2s9V2HSvl
	L/BPXYun85hUqHK1l41D0z1d6TF32amRQUr3X0ka8
X-Gm-Gg: ASbGnct6HwzR4Mz5zfm1nXAdIf4Tzm8JPYive0y4u2dsz+4EAkjx6kmMgTxdCHo3Vxk
	K4Dwl97kGZvzhH/7ayXTVjNH1Qf4OTv5M62Zape3VgYgJHJpjt88aOy9zJtTkzxLHCPcx8aF5in
	UzHoraMMyGJqcl70M6ANncbQEjZevOR0e17yKMhdJ3dGFN27xnbJqQLyaJHgd4rNPo4C7QEel8f
	WSgxGeT6rAKHM8saC7DrB/o6ymSef5eLZeSTEPrUtbPxCoC95kZHElmDqcm1lSvkrXo1ZZgASOj
	X8o=
X-Google-Smtp-Source: AGHT+IFUVZNPIK0AcOI8LDSsBATJuC4gcq/tKXcacLJQjfjjgvMc65YqHi2EyLJKbMbLw0NUZsm1TADkl0TzQ1/+nvU=
X-Received: by 2002:a05:622a:344:b0:4b7:9b7a:1cfc with SMTP id
 d75a77b69052e-4e6eabce6d2mr7590211cf.10.1759933695720; Wed, 08 Oct 2025
 07:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com> <20251008104612.1824200-4-edumazet@google.com>
In-Reply-To: <20251008104612.1824200-4-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 8 Oct 2025 10:27:59 -0400
X-Gm-Features: AS18NWC-3H_J3dkTMbZ6EFBue-JuYUbELZ4WLgT529e7Htmvjia3fEWbIB3XOUE
Message-ID: <CADVnQymesd7iutFS7Dim9nCmByLn==6HSCMuKTkc4N26gD-3UA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/4] net: add /proc/sys/net/core/txq_reselection_ms
 control
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 6:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Add a new sysctl to control how often a queue reselection
> can happen even if a flow has a persistent queue of skbs
> in a Qdisc or NIC queue.
>
> This sysctl is used in the following patch.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Nice! Thanks!

neal

