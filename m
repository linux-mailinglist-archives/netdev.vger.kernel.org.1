Return-Path: <netdev+bounces-89707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3D58AB465
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 19:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4243A28166D
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A78113A3E5;
	Fri, 19 Apr 2024 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmEri7I+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653C12FB23
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547932; cv=none; b=X0sZj2u5Nwar0NcEFJodUU2LUhw6dm4Zw6EoAs9bZ8CY006mcX9rzlLLcsPCpgvkGxS4aiSXtMBRwhz3uxcUwlTn5bbDR1kx1geW/QhanMo2S7byhXzEZ+zOxwOA3uqB/rgDrgB3/UUAJLg/ihR7m7sHkW9W1t63AV0fI2CgNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547932; c=relaxed/simple;
	bh=zfFcqPGQgRsVMEP61jNK7VFPiewdPs5Dnfgr6LjPP+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rdplxd+gHCPKu3kziBzK6Eiv1e5iuTld1CpQTFCMsjMQ+7DFrKIRDLQWuQCjqSd3N5tVa/wzQumkWXV6MMlnOCXBZDFeULFwSeZnsu1IulUdE8VwEzfFlPYK1GVg/4kUagaOFlVjYnv/qS+rNb7ZVOEVmdA+0LuIEUsgxMC44Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmEri7I+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so524a12.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713547930; x=1714152730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/7XkNtVUlPpqy9TPO+l1wE6wDN8mZN9vh6h8osNmdQ=;
        b=EmEri7I+BpND5LCjULYhNgYH8hYPAUZsaXrb20DpyEfI8QZXGyiILrgGiX9cqyyMKB
         j81yhSWS7d8dA6WfGk5roJpOehI7WpBQJau95kcPS+4musi6RhYx3vz1DcT8cFvXsKWN
         DrewZb5bnZrdy2CRqxUTa7VEHZChS1DTcN40jTnhdlCv5riNWA4pMycxRlQqSm4tZu0e
         MXUSKdJd60SvNbgu5zJjR2ly4jxxjh0969Lwgy+fiZgiQdqvIpSMfKPMamki5hojKSjy
         2Z5dfFkhn/3aC81Zp2pafyDeXBQTP3UruExs/BWjlmQ0RICSJH6UeqArQykNn6PAuM1G
         ZgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713547930; x=1714152730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/7XkNtVUlPpqy9TPO+l1wE6wDN8mZN9vh6h8osNmdQ=;
        b=X/QK1ft0mRyab7Ap/Kt2YCNjKnggKEVmFoxubmnnRM7Fy0lPBAp2lXisu2NDeUyk8Z
         PvBfeDJthfCaDNLBUgSIM9WLSMyQFdvMbApUQx/Riy/XrMLUbliUZLvZG94ipQrWOr94
         YEBjcTzWywTjD+EEf7bGuYYgN5X34hyuL6PLP1FEhbEKnEK3rdx7mOPxWCyXjgJk4Lxq
         ZrcbxLBHhWKCiL35a7FKhV1ir5ajnsbuJNsYSpQHLDGtQ+fyOgnWZsnm0I7bU02cilHf
         4+H0dugiGS1cbb2oGCBehhtKGiC8HfUy0AIAWLryXYlqNf3WOohYqS0e4AEM+Zk1ED5N
         23DA==
X-Gm-Message-State: AOJu0Yw9eZNPOn38yIiBkpYbFHmatRihT7LVfLOlxqTldrBDDcqr4i0e
	nh8rrGpAQLc8Ngtijfal4ZCBAc8woeeUxFlaLP3tQkioz+iJ8HrqX0NiUOcA+pCpKm4nI/J65Uz
	6EU/gifbb3OZx/GtuQ26tr3nk5ZO1hGo4mHYp
X-Google-Smtp-Source: AGHT+IHfJjHNnX0DOR+Ao2TnWv+2l4N+4qaFs909XBsz90RHhq98Lx6Z9yOcs9YqTY/IBjU/tcv+u8FszCMOj0/zMXk=
X-Received: by 2002:a05:6402:1e94:b0:571:b9c7:2804 with SMTP id
 f20-20020a0564021e9400b00571b9c72804mr232037edf.5.1713547929429; Fri, 19 Apr
 2024 10:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI1PR01MB42407D7947B2EA448F1E04EFD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com>
 <CANn89iLO_xpjAacnMB2H4ozPHnNfGO9_OhB87A_3mgQEYP+81A@mail.gmail.com> <VI1PR01MB4240EBA3CE9986FC6A0A9C7DD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com>
In-Reply-To: <VI1PR01MB4240EBA3CE9986FC6A0A9C7DD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 19:31:58 +0200
Message-ID: <CANn89iJDxA5nCTiw9SzHVfzhz2F124Z_PMEf_oJz3DGAp=UeOQ@mail.gmail.com>
Subject: Re: [REGRESSION] sk_memory_allocated counter leaking on aarch64
To: Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:59=E2=80=AFPM Jonathan Heathcote
<jonathan.heathcote@bbc.co.uk> wrote:
>
> I'm very sorry but I won't be able to give this a try until Wednesday nex=
t week (I'm currently working part time) but I'll give this a go first-thin=
g. Thank you very much for your swift response!

SGTM, I rewrote the patch to remove the not needed
preempt_disable()/preempt_enable()

I will test it soon.

diff --git a/include/net/sock.h b/include/net/sock.h
index f57bfd8a2ad2deaedf3f351325ab9336ae040504..bae62604c5ffc8a3ecbe3e996b8=
7c9fb25914c0f
100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1410,32 +1410,34 @@ sk_memory_allocated(const struct sock *sk)
 #define SK_MEMORY_PCPU_RESERVE (1 << (20 - PAGE_SHIFT))
 extern int sysctl_mem_pcpu_rsv;

+static inline void sk_memory_pcpu_drain(const struct proto *proto)
+{
+       int val =3D this_cpu_xchg(*proto->per_cpu_fw_alloc, 0);
+
+       if (val)
+               atomic_long_add(val, proto->memory_allocated);
+}
+
 static inline void
 sk_memory_allocated_add(struct sock *sk, int amt)
 {
-       int local_reserve;
+       int val;

-       preempt_disable();
-       local_reserve =3D
__this_cpu_add_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-       if (local_reserve >=3D READ_ONCE(sysctl_mem_pcpu_rsv)) {
-               __this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserv=
e);
-               atomic_long_add(local_reserve, sk->sk_prot->memory_allocate=
d);
-       }
-       preempt_enable();
+       val =3D this_cpu_add_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
+
+       if (unlikely(val >=3D READ_ONCE(sysctl_mem_pcpu_rsv)))
+               sk_memory_pcpu_drain(sk->sk_prot);
 }

 static inline void
 sk_memory_allocated_sub(struct sock *sk, int amt)
 {
-       int local_reserve;
+       int val;

-       preempt_disable();
-       local_reserve =3D
__this_cpu_sub_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-       if (local_reserve <=3D -READ_ONCE(sysctl_mem_pcpu_rsv)) {
-               __this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserv=
e);
-               atomic_long_add(local_reserve, sk->sk_prot->memory_allocate=
d);
-       }
-       preempt_enable();
+       val =3D this_cpu_sub_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
+
+       if (unlikely(val <=3D -READ_ONCE(sysctl_mem_pcpu_rsv)))
+               sk_memory_pcpu_drain(sk->sk_prot);
 }

 #define SK_ALLOC_PERCPU_COUNTER_BATCH 16

