Return-Path: <netdev+bounces-235110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38733C2C1BE
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 14:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC77F4F3E71
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B2E2701D9;
	Mon,  3 Nov 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIfc0l6k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E526F2BD
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176596; cv=none; b=f++g3MnMwpRNZRuSDA2nFj+OMlg/3TeVNx9onUoDlllpNVmweBwRHgVy8HArVY6tmpzP2ioooWx2bGfIcWbF45MhzjjcinIR9KOQMeCzSZkMTE62xskO+ZBVLWRT3/vtkOirMWxeVld5K/frXDfC3DzULia3cQXYKZE0+FTBXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176596; c=relaxed/simple;
	bh=3P4uhXaD5ilvYs+a4RtrwVqLA5w/zngN8+yS2F+4lkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJWm1XH5uylpJQ7v33ic9N5ng1XHMD+plirswRINIBx6JFYOHluC1LoprtkBVlSG3nwt4w3NDrEsDJVHDy6H1W6Hr4pI098CB5Q3NomJspfAE9GuR+LR3Llnk50GEAe0zFTgzrePrQouZm7jGySvC7agC813l+NyJB6Vh7ivoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIfc0l6k; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so2317914a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 05:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176593; x=1762781393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a21JbFZrSRmyl+TIWUp5y75+miyXDqyFyLKW07xgMRE=;
        b=iIfc0l6k9iNQArxxX2qbTR4pYsdaNIZ+O0bZS+XBE8EwQROeAVrFCu2U6PBIjIhraX
         suZNP2HKkCrkhFRfJVo9pyOplIYGW7dcmUuqnY9c40lEekzqbtTY4i73leXVc8hl4+jE
         ZWGuzBP6tGg8MH0wbbwhE09bM1bGXHolSrhfM1prGDB9cyYHmiQ0l86NMY9N9e22F752
         ccz127Qgm/Zwcw4gYj9gylM3DpNnvguc4OeZElaIjAP9QE6YuQMj3CCTOmjmIvcXW2At
         4esTOikzxDAhxUICWw0ISVF7OFAeqdFTaNPpF0fHIOFA39W8YGD9CwZ0m5QUbAAdpKLC
         f7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176593; x=1762781393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a21JbFZrSRmyl+TIWUp5y75+miyXDqyFyLKW07xgMRE=;
        b=wgmYnj7blvvhul/wKz4FS0m206PHkZY8GwgvMESkYJUtG0xSHG9QNKpnbMdzNNJ4w7
         212/H5MBRDrFAcrGxpCJ8/ChhZ6pG2et+CeIsG2S2R2WdlRYbVge9nkMEUaVzPKJbgcp
         TEjpKaEyfh8el9B8xw6U+mNtiqqEVDLlp8xYaQeZPEyqC6D5ta3/BREbfZoVlxvqWfJh
         V/qoEj48Pe1tt7eShZDK0e5hJzxVIGmRKD/59GcUERX7Y9manaxABURICtnfAVAZnjRe
         2uW+dPZh02zVc9uohlI+q5pLXqet9uaFeOj/DokC/eA69PeE8JTHlMFN4lntgZ+hY06F
         yWBA==
X-Forwarded-Encrypted: i=1; AJvYcCUE4YTbsRrv6FRfz3ExiqJSI6PbMq5KSur0UaWAwOcneV47Q8I1kxJIFvS148yHZHW+MNOSnvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDFVyX8EKm5poD4KE7r3LOBcWGN51DndIV0lFHCra2ROn+Oal
	/JZ4rlDOkfktyrxyMeOLSWgFCs5yF+jtNQNl3DM6BFGvHJjqjIpnPMYJmd/SBTGZFyTLhuPNADU
	ivXfw2yrD0HnsA+m8llI4GbF0OnGsGfA=
X-Gm-Gg: ASbGnctD/S+lyYUh+NrNWCnzeymFatS683Y1qCFNjbD1W+vplCEURGOtvDMVKTWYtej
	bl8b+3gJR/AbA9te25t9qfUhbKF4P1ebOhiWymt9jwBxlLbMmSEc8N1Wdh7MojPpK1LF7C2lGRO
	Ev2/Ty3FQlo5aiEpgwd+jz6XAgFjKbeMhhLY1TtOTR2hOhRCQYMiXgRETpBPtvvxwrmiNjRX8Eg
	7Jmy9ZyxuIXvSgHE2zVhB9R8hbcx8g3dBzBsd56g0cjaLbOPaqElSRqB0QwedTlQqET9eKqLbVO
	VMVYlmxD2XuqjBEYFWtDXAjfNpAhe2XLJA9kpnh2
X-Google-Smtp-Source: AGHT+IGWyTZduHZ2AUQOMuHAUDSKDxSYh2Boylo//kHY7uALzcMyPCHh3aobLMS0sfZ3SBLE+RqIGbSBBaWJY8VJe/k=
X-Received: by 2002:a05:6402:5108:b0:640:aa67:2933 with SMTP id
 4fb4d7f45d1cf-640aa672a40mr5173930a12.21.1762176592344; Mon, 03 Nov 2025
 05:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Nov 2025 14:29:40 +0100
X-Gm-Features: AWmQ_bmz-aFyM_2e0ocdnrdFR9IUaRm9-CuMDUtbkHwY8CVjQjk6nDFhXg5Zzks
Message-ID: <CAOQ4uxgr33rf1tzjqdJex_tzNYDqj45=qLzi3BkMUaezgbJqoQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] credentials guards: the easy cases
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 12:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This converts all users of override_creds() to rely on credentials
> guards. Leave all those that do the prepare_creds() + modify creds +
> override_creds() dance alone for now. Some of them qualify for their own
> variant.

Nice!

What about with_ovl_creator_cred()/scoped_with_ovl_creator_cred()?
Is there any reason not to do it as well?

I can try to clear some time for this cleanup.

For this series, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (16):
>       cred: add {scoped_}with_creds() guards
>       aio: use credential guards
>       backing-file: use credential guards for reads
>       backing-file: use credential guards for writes
>       backing-file: use credential guards for splice read
>       backing-file: use credential guards for splice write
>       backing-file: use credential guards for mmap
>       binfmt_misc: use credential guards
>       erofs: use credential guards
>       nfs: use credential guards in nfs_local_call_read()
>       nfs: use credential guards in nfs_local_call_write()
>       nfs: use credential guards in nfs_idmap_get_key()
>       smb: use credential guards in cifs_get_spnego_key()
>       act: use credential guards in acct_write_process()
>       cgroup: use credential guards in cgroup_attach_permissions()
>       net/dns_resolver: use credential guards in dns_query()
>
>  fs/aio.c                     |   6 +-
>  fs/backing-file.c            | 147 ++++++++++++++++++++++---------------=
------
>  fs/binfmt_misc.c             |   7 +--
>  fs/erofs/fileio.c            |   6 +-
>  fs/nfs/localio.c             |  59 +++++++++--------
>  fs/nfs/nfs4idmap.c           |   7 +--
>  fs/smb/client/cifs_spnego.c  |   6 +-
>  include/linux/cred.h         |  12 ++--
>  kernel/acct.c                |   6 +-
>  kernel/cgroup/cgroup.c       |  10 ++-
>  net/dns_resolver/dns_query.c |   6 +-
>  11 files changed, 133 insertions(+), 139 deletions(-)
> ---
> base-commit: fea79c89ff947a69a55fed5ce86a70840e6d719c
> change-id: 20251103-work-creds-guards-simple-619ef2200d22
>
>

