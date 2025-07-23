Return-Path: <netdev+bounces-209142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB49B0E76C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8CD1CC016A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DCB2E36F8;
	Wed, 23 Jul 2025 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqNvtvzE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3719A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228915; cv=none; b=aHIUlgD45pyA8TGix5Jx9l29ROQ0++auIC6GcU4shfTIRJzoZBX/TIwlnrpNkya2CYsK+JQdokltlEyoDPSVNCmm8owj3zz1PTjmgI42ok6YZj91TaVlnLUt/tDNcQSuI82vG6/RV1S+LV37JJPI7TlSlIPnpk/eq7jiwZS/RMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228915; c=relaxed/simple;
	bh=gPi51dK3oE0zdSbMxyoTJ2j+Kp9ZEpvTgPvxtE9gInE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqU965OVgbLEU39zf8S5x0Y35KuXLV2e8cOb3VBaZpcV1W2CdrW66+AYW46raPYFwxTPuMkrBQXBAJe/ScqYHZ5kOFS9GdVxKahNWrry5gmoQRHw4WX1neZOdHzEidD9wiwRV8/Data3JqCiAf+g+06xZlw/k+2Hde9rDi80iy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqNvtvzE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23694cec0feso58503695ad.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 17:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753228914; x=1753833714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmW+kJOfooutx6wMAE2aHCnhV2kwpGozAvb4QhsmOeU=;
        b=yqNvtvzEJx8CAJWDXglxqzSCndkfMHaCHTnO1mhIRzNhGVNhGyjm9U1u1zEpjsPPMU
         K+NJYKgJn3xFkMGFInFnoAJ6sQfh4fgTcXwPe9uFHKFPu0nnXjE+jm5yuvEKREN8wtGW
         0IK0os0g+5Re7qHOlQC/t/zwH2h7/TsPy9BPBsT1lkU7/TMBvCquYS491QMByqHB9BSI
         D9NwWUccJzqu03TdFBGS3qdVzajQpDq5gzxiYIGr+swRK9X1XPGdV8o4VnZK7BMwkAH/
         f8TNHv9WGs/RI7GZ3He2sHTtaZnpbjBcCk0b02nu05knS8IIeJFFNQfQNh3j2VYd+Bvm
         BCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753228914; x=1753833714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmW+kJOfooutx6wMAE2aHCnhV2kwpGozAvb4QhsmOeU=;
        b=jLDgljVZhPGMmLW+NB0gcFb+PM2SkVnGVGVH5gPkuTZj3EBWE45TLQgxlXdL7qAri2
         QV1MisavI6VaPxqBwHz5Lvllnuo3T7bJVcvHQuP9wQS3yyqDqw5uP9KMK55T59YcoM2b
         j11GZUwips/wwcP+NzMA+ICvSW8B5B1E75c0sbCJB4lKahXzNh/VpfTdmPK8bXC63qjv
         T0iB1mVUqwWG4sRp1/dyqNurqusHSig2qQt8rHyRGoCJE0/7/ep2B584rigOrhotpfnj
         pJIUx0GVErpn8K0MwV2F5cUjrLE/7RLejBMgrApRkERWQaHCZ3P+QPPgY/yC4RiUEfjd
         +tEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQpe34FED1vL1cY6CB7Y+GOxzJm0BNtldzUMgM76wGZj4pGf0j/T+L45vPpdsGH54FKjePBWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9FuS4Tzh2gYR+Sha3WkqRhEIvZMfJboxNdqpBQTvQ8nOsvRs
	QkHVxbRHci/Jaok/p4YdIJGSBEsMlxu67RLqnxrGU+mu/JeWzI/OhQw1bYrNP67q6iSU0N2gExX
	lu0m6SB/5OekCxJkY6mha/lmssZidkQZfrsCBYlNE
X-Gm-Gg: ASbGncu99ctWcPlsGuRLNJiUSG/uu1lEQbv8uLWmG9gIM5m+jYRoDZHxMQMeMCJOtQJ
	PoyBxNZuSgturCK2py+XPdEtie73ILL7KCL+hQC1KyCr/+7BsD+I80ddmGdJcUwk/qzpNwrfleY
	awd7otmJ93rDMq3UGntbS2gKzWzeoRDYopzWRtTW/60/4hdJoVobmRJ6Sb0DlAJqnuNDKUCgeF5
	JDziES4qu3bIItSY6Ds6b9Ccis8bMTq+9UOtA==
X-Google-Smtp-Source: AGHT+IEqqHZkTue9jUT8aBgzW9HXFM4b9QYOnzU5SiGbcOMqJT4zItAuhvKX5pr1J1z8bXy8wQZzWEwQMYnEb1hq4s4=
X-Received: by 2002:a17:902:c946:b0:235:779:ede5 with SMTP id
 d9443c01a7336-23f981df84emr10431745ad.40.1753228913257; Tue, 22 Jul 2025
 17:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com> <1753228248-20865-2-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1753228248-20865-2-git-send-email-haiyangz@linux.microsoft.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 17:01:41 -0700
X-Gm-Features: Ac12FXwOFltqpWqcJyOPdTDnWUTF9s30pio1HgtXH8zT888WCdTjkN8V30YF4KI
Message-ID: <CAAVpQUBuyfnv4BBxnOvheEb7JVnokTEiea5Yp4UZdX=5CuWVHg@mail.gmail.com>
Subject: Re: [PATCH net, 1/2] net: core: Fix missing init of llist_node in setup_net()
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, sd@queasysnail.net, 
	viro@zeniv.linux.org.uk, chuck.lever@oracle.com, neil@brown.name, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 4:51=E2=80=AFPM Haiyang Zhang
<haiyangz@linux.microsoft.com> wrote:
>
> From: Haiyang Zhang <haiyangz@microsoft.com>
>
> Add init_llist_node for lock-less list nodes in struct net in
> setup_net(), so we can test if a node is on a list or not.
>
> Cc: stable@vger.kernel.org
> Fixes: d6b3358a2813 ("llist: add interface to check if a node is on a lis=
t.")

No Fixes tag is needed because we didn't have a need to
test if net is queued for destruction.


> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  net/core/net_namespace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index ae54f26709ca..2a821849558f 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -434,6 +434,9 @@ static __net_init int setup_net(struct net *net)
>         LIST_HEAD(net_exit_list);
>         int error =3D 0;
>
> +       init_llist_node(&net->defer_free_list);
> +       init_llist_node(&net->cleanup_list);
> +
>         preempt_disable();
>         net->net_cookie =3D gen_cookie_next(&net_cookie);
>         preempt_enable();
> --
> 2.34.1
>

