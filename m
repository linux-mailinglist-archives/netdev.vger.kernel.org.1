Return-Path: <netdev+bounces-85030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C788990FD
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 00:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388ED1F22E7E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D00F13C3DE;
	Thu,  4 Apr 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgLDaApk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED713C3D9;
	Thu,  4 Apr 2024 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268452; cv=none; b=k2Lru5pNDMO7eG6tdEb8irQKQwPvP6ytdq/DY7pvtSYeh40PpINNteiW1XnWlF3aOhj/htMKAFqaTgtK5XGtx36U8OpKCYfTNPIFoMQZIE9kFU0U1bi85Fs9EVQSiCSnn00PUPXerzQ6QuQe++mZrjlD3H21YfA8gMEkTPlF1Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268452; c=relaxed/simple;
	bh=AjvuPzaZCOzpiQVfLOn/AmFNJ7anIJ2tJ90YdBIhnKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq/1UoQSWGgpkSamhvODRyaWjKhVIF4oDfGLSALaDJwMCi2YrP1c3TOfvicfTXZFPCCB2u86FhK925qGDhMqiG3pck/OqHsl1vckhAlY9JisoUxs0dVMnvwkWsEsxGy3ZubRQPX+kWXx7037hjGdu4Rhfwm1WSKpDqDg/uljJkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgLDaApk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343c891bca5so608824f8f.2;
        Thu, 04 Apr 2024 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712268448; x=1712873248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjvuPzaZCOzpiQVfLOn/AmFNJ7anIJ2tJ90YdBIhnKs=;
        b=QgLDaApkpEkXiMeZ6MtJmWyhxAQnBUVtvfUqAqDRUbO9aw77utl/+M494o8eUqm/el
         yKc99+g0Luif38DVeny5OoGbAToKp1v8a32HCYvmFJU5yIQCWblPa+KYupv8dbP0XeSn
         DkE/oVHXGFIRxdzzKmAt3S7Z77fv/qycihI+MKrTYqpChociVtu3kO7+lZ1K4imZmzj3
         2uoxva7+/tC97VFotDY+430fH0mvDJHksgxqpJ7c/fU41P2BQ3WkYCRHTUrcMRhG7FDx
         eoump2DFU3l8ZnR7BHysGBNK+vwbaSH6WXPvcVxMQY9kLAr4FNBbdNIgPREQTlYXrU/J
         TgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712268448; x=1712873248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjvuPzaZCOzpiQVfLOn/AmFNJ7anIJ2tJ90YdBIhnKs=;
        b=jK0DrW9aFdAPYN+w9PokCFyC70JtiZif3YTi83a9Ivr4d3t1V5d+9zlAHUEYaC+6xK
         qRfISb+TEqq/EnN7PVHHhQqNkmZR1ulSbyi5GLhoVP51OGmkFDPhsDYB8DIGI1p09Mb6
         9K6zhMzyFcO64NAfiRLOYoX7NESPK6faQHK4BZAmZjMKm9h3sW3o3YbhPl5Q4/ujEmiY
         JTzV6JhAFtTeKZxpCfkgagEb4F195zeEHSr4lmXqI3HeiCUxNdwmzlGZFOKBg3AslXH1
         3lO4FqdiRihJGDQ42qtCH1dJ/tIb+d7uxQYR1cxaFNngJDhTOyrJYJk0nGmn8gZNaW6O
         UbYg==
X-Forwarded-Encrypted: i=1; AJvYcCXpl0q+k+JBv8Rbvpo9F2C5u2LjRDvVF5UdqViI7NQ218WY6mmibnw4T2bDo7I/s1Api1uBycKDyLzIYW+PFRukL+If
X-Gm-Message-State: AOJu0Yz9QcDOX+ukU+IzsMpox4JwqFAFQ5LezXCDy1RK7Kwibeb339NY
	DDYrD8WzRsTrJrC3idYgPZyExUcHYjrQIJkBlD3GDkkiJWDAP2ngCA6LwYM0G9bk2AcCkAgpF8x
	19OO/afU2i0OJYqhTbaDxD6P4pno=
X-Google-Smtp-Source: AGHT+IGYEE2XWLfYLVC5q1f8MQwSkAGP99QhnhOCs1Cvyyj1GjLUUmSVwvc+eOXYzH6rsY4aPkKDcWxhTuK28Srinys=
X-Received: by 2002:adf:e48c:0:b0:343:ae03:2a02 with SMTP id
 i12-20020adfe48c000000b00343ae032a02mr676485wrm.40.1712268448261; Thu, 04 Apr
 2024 15:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122338.372945-1-jhs@mojatatu.com> <20240404122338.372945-15-jhs@mojatatu.com>
In-Reply-To: <20240404122338.372945-15-jhs@mojatatu.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 15:07:16 -0700
Message-ID: <CAADnVQLw1FRkvYJX0=6WMDoR7rQaWSVPnparErh4soDtKjc73w@mail.gmail.com>
Subject: Re: [PATCH net-next v14 14/15] p4tc: add set of P4TC table kfuncs
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, victor@mojatatu.com, 
	Pedro Tammela <pctammela@mojatatu.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:48=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> We add an initial set of kfuncs to allow interactions from eBPF programs
> to the P4TC domain.

...

> Note:
> All P4 objects are owned and reside on the P4TC side. IOW, they are
> controlled via TC netlink interfaces and their resources are managed
> (created, updated, freed, etc) by the TC side. As an example, the structu=
re
> p4tc_table_entry_act is returned to the ebpf side on table lookup. On the
> TC side that struct is wrapped around p4tc_table_entry_act_bpf_kern.
> A multitude of these structure p4tc_table_entry_act_bpf_kern are
> preallocated (to match the P4 architecture, patch #9 describes some of
> the subtleties involved) by the P4TC control plane and put in a kernel
> pool. Their purpose is to hold the action parameters for either a table
> entry, a global per-table "miss" and "hit" action, etc - which are
> instantiated and updated via netlink per runtime requests. An instance of
> the p4tc_table_entry_act_bpf_kern.p4tc_table_entry_act is returned
> to ebpf when there is a un/successful table lookup depending on how the
> P4 program is written. When the table entry is deleted the instance of
> the struct p4tc_table_entry_act_bpf_kern is recycled to the pool to be
> reused for a future table entry. The only time the pool memory is release=
d
> is when the pipeline is deleted.

TLDR:
Nacked-by: Alexei Starovoitov <ast@kernel.org>

Please drop this patch (all p4tc kfuncs) then I can lift
the nack and the rest will be up to Kuba/Dave to decide.
I agree with earlier comments from John and Daniel that
p4tc is duplicating existing logic and doesn't provide
any additional value to the kernel, but TC has a bunch
of code already that no one is using, so
another 13k lines of such stuff doesn't make it much worse.

What I cannot tolerate is this p4tc <-> bpf integration.
It breaks all the normal layering and programming from bpf pov.
Martin explained this earlier. You cannot introduce new
objects that are instantiated by TC, yet read/write-able
from xdp and act_bpf that act like a bpf map, but not being a map.
Performance overhead of these kfuncs is too high.
It's not what the XDP community is used to.
We cannot give users such a footgun.

Furthermore, act_bpf is something that we added during early
days and it turned out to be useless. It's still
there, it's working and supported, but it's out of place
and in the wrong spot in the pipeline to be useful
beyond simple examples.
Yet, p4tc tries to integrate with act_bpf. It's a red flag
and a sign that that none of this code saw any practical
application beyond demo code.
We made our fair share of design mistakes. We learned our lessons
and not going to repeat the same ones. This one is obvious.

So please drop all bpf integration and focus on pure p4tc.

