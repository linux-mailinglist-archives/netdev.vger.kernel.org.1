Return-Path: <netdev+bounces-221883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BACB52463
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3786F7ADAB9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415012E7BB2;
	Wed, 10 Sep 2025 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzATNfxo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF953282F5
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545548; cv=none; b=SFT8Kx8Tsv8q+nF8Q9jIF43oiJEsEB58eg//BV4HpsH6KZKmVaXaui9eLRs0VbFK1IIAFMY35F/MOfAxtSCwyLxS/Hzk8xj8VBhmBXvLhyObZ/ddlzd0Se5l4DeCUieRgcXGe3wdrPzRAStNnaJV1DPHiiTOZ6DlztX/TE1GIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545548; c=relaxed/simple;
	bh=Wh2fJ2cjdltqtn47C6CJDjjCLq8HT0b+xI/kjb3f8XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMJWbT6U6Wi5sBViVtlvJX+T4ZavOHYebsLenTPcjwCJofRKkEiNOX+aqGlukNBnrAmmsVPQhkV0eZP8oTsbuJDQDurHCz3ketNL0VsQlrMWj5zMnDRRhFIzJR0Q/8GnpnG2LQ1oREUZe+Kq/SK/04Ocki6BJH7GOIURbh3Jrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzATNfxo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24eb713b2dfso722415ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757545546; x=1758150346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh2fJ2cjdltqtn47C6CJDjjCLq8HT0b+xI/kjb3f8XU=;
        b=mzATNfxojQYZoyPpge7j1lPM/fH45rsPlhQ4vYUpl0+4war4e3FeqCmVDVsO5zYD7g
         iOhJNlVM+74wg4dn9ya/z3f+enhNfQmlwdGssjwr0I6CUDrDpYkoaueaOxJcHfmSxifl
         sqXvc0H1V98/L3pDnM3zzpAM0fEsjea+8q3XP06PbCnUkMLEPxmSn8J9G9XMK8J80R9D
         khP+QmbfHBkGgQgu5h2tZdfrum+lyAWgvzuAJ9WZNhvAKAFQksdHvhgCN98OEfdKsKpk
         mFBR9SMb2A2/1E8cdnU5B72DUDIV9OynDRNH02QrSXGFZkmZoLvsckasynSWUH1/cI9u
         QC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757545546; x=1758150346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh2fJ2cjdltqtn47C6CJDjjCLq8HT0b+xI/kjb3f8XU=;
        b=EbwEcWR2cmnHHQwnyFGLt84iG6S+It0LjKk+XyqkB5r95UO3mHYn5mhGu9iwy8qwRT
         S97X37IoOHn8cb8GFvHqf0LW7IUmO/KqulGPAW3UYRV+b8B7asbXyLuPZNHBsey5w+e/
         GwaVcT3rROmqBnWOK0mz4amB9nKgRqjSxL8dLhvvQgGO6mrbWjeGXVgwnBfuFGsz7jmi
         PIfF3PNi4T1L3tlDc47UD6UtLibJVFSa9Qst9rP8J4cX657qKo0GFA0SEFku3amAvcYi
         7tjA2tiJogYD0q7BAqwcNWddxVrRwfZH9oBjj3EdekwyoN8i+n8nxbjOKLmtHX+vi5yb
         F4fA==
X-Forwarded-Encrypted: i=1; AJvYcCXJdKGiWnXgM/66iUKEozBEe4hTGoHizXPbdJck0rG755fC69LhEj8AVLIffQmscszN2QBIWFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYEcxd6zrBSPkEgIPsgRUUS8uMGVsSDE3LSQ7DZDRt327EZ/j
	I8H4a1M21FZcKbMO8uh5slpz6mGqQpXgDVPzR3nhTFltWA0r7G0AvecGrlT/KQXS2uA5kGKX4Oq
	R2aynM4+jURL3+O8FDczqdERiTlRO1bPLqzIknMBT
X-Gm-Gg: ASbGncvgxV0JrLFCyzEVCUjLSIfM0toaWeB4LkUtBIDUhPttCcXwAYRot0iqqqVlhfS
	cFCKXO2m98E5liXYYEYRvvtGWk8xq5BbkRVq1zgDW3HLooVAuXVoC/7jpwux6bR4QOVyGKGHO+0
	5pus0Tu3Ce+PIMeXFC3uuURZb/47FNEXF3sRUy9KZiQSskKloBpKSd3kD4adDYpUUDoXJOT/ub/
	DCbnaFwJbFehLdoMGZmwWmtQfeixTDZtne9ezMEqnBlvTRUnd76xiNV4w==
X-Google-Smtp-Source: AGHT+IEe+LLbtw5rYh3KvV9EyohzugJwjSjzWRmOdtoQmLIZPPz2Nv13k5h7XtNu4rO6IgDRG4vg4yrAsEHgSC/WThM=
X-Received: by 2002:a17:903:4b03:b0:250:ea89:9e0f with SMTP id
 d9443c01a7336-25172483c20mr228183175ad.46.1757545545866; Wed, 10 Sep 2025
 16:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909121942.1202585-1-edumazet@google.com>
In-Reply-To: <20250909121942.1202585-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Sep 2025 16:05:34 -0700
X-Gm-Features: Ac12FXw5sWHgS9BY508CpyGhzdeECbaNcbFq-uHDKOhrw8eZdlLrEomuAXaVDw8
Message-ID: <CAAVpQUDCKzHT3kqzsUOoi9iNx8edHEWzJqbwgjnuBu3GbAzxNQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: use NUMA drop counters for softnet_data.dropped
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:19=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Hosts under DOS attack can suffer from false sharing
> in enqueue_to_backlog() : atomic_inc(&sd->dropped).
>
> This is because sd->dropped can be touched from many cpus,
> possibly residing on different NUMA nodes.
>
> Generalize the sk_drop_counters infrastucture
> added in commit c51613fa276f ("net: add sk->sk_drop_counters")
> and use it to replace softnet_data.dropped
> with NUMA friendly softnet_data.drop_counters.
>
> This adds 64 bytes per cpu, maybe more in the future
> if we increase the number of counters (currently 2)
> per 'struct numa_drop_counters'.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

