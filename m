Return-Path: <netdev+bounces-123687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57A966217
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803A81C231A5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AB19ABA3;
	Fri, 30 Aug 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4JUjpCf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9E17BB0C
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022549; cv=none; b=leYSekaoJfRsuWS83FwJWrLoYuUx5tpuxpMjaGHpMNy8zrYukemQaj1w4YcCDwWkcLUu9RruEgf2uc0rmdLMKDvTa0Z3kkS7d12I926aiXTLM5/FTKTaqUDQXht6yOge3X6Ito1b1ZuHmax1vaIeOjh+LdUQ0cXVJibZBvIAw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022549; c=relaxed/simple;
	bh=irInylxAEO/g9EEQKtW8LWQ6H19qdYnMKqIM2kBnrlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKHAj0Slp1FWbwviSCf4s1sWJeXPzd32o+0Y6Laf3r1a3PeKSedI8ujqdIteGmcu6g4MXz336dVwOYt1C0rZG4XSspy5nj6QCLS8wypvSxEusAbfKrm+gFMNOoYsDVn9cxthsOmmRYybCrhkd98ewR9VDMkNg9uRxWyBZhpXKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4JUjpCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725022546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4rwbSvsPY1zfudmMK7sUCyGMbzPRJgaFLcgZLVvf1s=;
	b=U4JUjpCfMyn3ZQ0BZ4id3b88AUF1VT4Vz2s2SdwIyfPAVTQRjxfEVAhewbvORpDD7ROBrK
	0S1EJPWOOGmfaAVwzW7xqt1Wccc3LRU95eazvqCbem4VVz2F0TVibgn3RZ1l5zArCIUHW1
	6/CJxJzbrjlJhzviVwzzNCqK1Efyi3U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-vp1ioZWLPyWr1izhW1o83w-1; Fri, 30 Aug 2024 08:55:45 -0400
X-MC-Unique: vp1ioZWLPyWr1izhW1o83w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f3f82f55feso18960141fa.0
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 05:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022544; x=1725627344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4rwbSvsPY1zfudmMK7sUCyGMbzPRJgaFLcgZLVvf1s=;
        b=SIbqUxAdxL1ULOnTniogR09bNp+Gn7kGuxXUBnOrrsY46KkexnfvUb9ov5Vk4wrGsd
         KX36xdXWC5lwQgwIs2qQOoj3w0sUQEa9VsnybWCLMWuzBCGYMk7SWmkJhWJS+4SHhk8H
         pkDuckfKvMmZJWoYQom20AU5aE2IflU+1tseOjRzVBf06bJPsoe1lTeUsW+7iWrSxnJq
         BvP1Qwjxc8vP1OR4YSJ4eluQB5gjCzdbtpCezxfpMfp3WcJhTPhDtI/xeX9zaRxBk3YX
         bNOSz3PmRMBfMv8+xGWQfO6mzf0s6ztWUHrAQ9II+CHjKKF8WhrvglfIA4XbWi/Qy9yZ
         sgOg==
X-Forwarded-Encrypted: i=1; AJvYcCXlA1wct4z/OuBPAX6SkdPdJDDxC+Rwkv0q3PtyBoKy+woROLPxaaDJprKLeWGWiCVbgEvq9Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaYYIwS0OYkBjRz3KsdDynZp5pWN5lkVk/gK4oV8j+NQUJr33l
	SX6SS8ji+yGt7x2aOM5z3rBY+ZqdaeoDJyDBgTDfCLybQZrXT4XtuWTvHZ5xtRtquJAzvvV6hOX
	Ow711dtiBdfGc7lJlb+Uney5AGV3j5kB0ujbh/zKZXusUrwgzw6I8foNhHztAW0BHBpB212ucc1
	ZDCYzEpNzjnJ+yDhYZC1fC0gdbjKwu
X-Received: by 2002:a2e:b88b:0:b0:2f4:1d7:e286 with SMTP id 38308e7fff4ca-2f61e0adffdmr7465351fa.18.1725022543579;
        Fri, 30 Aug 2024 05:55:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFsPt6iJVHKK5Qe3E63G1+0fcVq/myUtd8Ucirw56OZNhL5CDzG8T2QsadK401r4Oy8yyJ1qR5wybXoJiHALQ=
X-Received: by 2002:a2e:b88b:0:b0:2f4:1d7:e286 with SMTP id
 38308e7fff4ca-2f61e0adffdmr7465161fa.18.1725022543034; Fri, 30 Aug 2024
 05:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827180236.316946-1-aahringo@redhat.com> <20240827180236.316946-8-aahringo@redhat.com>
In-Reply-To: <20240827180236.316946-8-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 30 Aug 2024 08:55:31 -0400
Message-ID: <CAK-6q+iedvC_b3_dO+7C6S15y2o9uuqwDaNJ=a0wZE3hW=+G1g@mail.gmail.com>
Subject: Re: [RFC 7/7] rv: add dlm compatible lock state kernel verifier
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev, song@kernel.org, yukuai3@huawei.com, 
	agruenba@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	netdev@vger.kernel.org, vvidic@valentin-vidic.from.hr, heming.zhao@suse.com, 
	lucien.xin@gmail.com, paulmck@kernel.org, rcu@vger.kernel.org, 
	juri.lelli@redhat.com, williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 27, 2024 at 2:03=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
...
> +       set_holder_state(lk, our_nodeid, mode);
> +       rv =3D check_valid_lock_holders(lk, mode, our_nodeid);
> +       if (rv) {
> +               /* the whole validation process, this event signals
> +                * everything is fine and DLM works correctly there
> +                * are no cluster-wide locks that violates DLM locking.
> +                */
> +               da_handle_event_dlm(lk, with_others_compatible_dlm);
> +       } else {
> +               /* print all holders of the lock when a invalid lock stat=
e is entered */
> +               console_lock();

I can't hold this lock in some contexts the ast callback can be called from=
.
I will drop this lock as I don't care.

It would be nice to use this msg callback from the refactor but then I
somehow need to pass the lk pointer to it.

This however works for me that I know at least which nodes/modes are
incompatible if it hits.

> +               pr_info("---\n");
> +               pr_info("ls_id %u lkb_id: 0x%08x\n", ls_id, lkb_id);
> +               pr_info("holders:\n");
> +               list_for_each_entry(hl, &lk->holders, list) {
> +                       pr_info("\tnodeid: %u mode: %d\n", hl->nodeid,
> +                               hl->mode);
> +               }
> +               pr_info("---\n");
> +               console_unlock();
> +
> +               /* move into an invalid state change, we don't have a edg=
e for that
> +                * so we just use event_max_dlm.
> +                */
> +               da_handle_event_dlm(lk, event_max_dlm);
> +       }
> +       spin_unlock_bh(&dlm_rv_hash_lock);
> +}
> +
> +/* set the holder to transition state as lock downgrades can issue
> + * grant messages to other nodes we need to ignore if a lock on a
> + * specific node is in state transition. From point of DLM API
> + * the user cannot assume to still hold the lock at this point
> + * anyway.
> + */
> +static void set_holder_transition(uint32_t ls_id, const char *res_name,
> +                                 size_t res_length, uint32_t our_nodeid)
> +{
> +       struct dlm_rv_holder *hl;
> +       struct dlm_rv_lock *lk;
> +
> +       spin_lock_bh(&dlm_rv_hash_lock);
> +       lk =3D lookup_lock(ls_id, res_name, res_length);
> +       if (lk) {
> +               hl =3D lookup_holder(lk, our_nodeid);
> +               if (hl)
> +                       hl->mode =3D STATE_MODE_IN_TRANSITION;
> +       }
> +       spin_unlock_bh(&dlm_rv_hash_lock);
> +}
> +
> +/* after a lock request got validated it cannot fail */
> +static void handle_dlm_lock_validated(void *data, struct dlm_ls *ls,
> +                                     struct dlm_lkb *lkb,
> +                                     struct dlm_args *args,
> +                                     const char *res_name, size_t res_le=
ngth)
> +{
> +       set_holder_transition(ls->ls_global_id, res_name,
> +                             res_length, ls->ls_dn->our_node->id);
> +}
> +
> +static void handle_dlm_unlock_validated(void *data, struct dlm_ls *ls,
> +                                       struct dlm_lkb *lkb,
> +                                       struct dlm_args *args)
> +{

we need to ignore unlock(CANCEL) requests.

> +       set_holder_transition(ls->ls_global_id,
> +                             lkb->lkb_resource->res_name,
> +                             lkb->lkb_resource->res_length,
> +                             ls->ls_dn->our_node->id);
> +}
> +

- Alex


