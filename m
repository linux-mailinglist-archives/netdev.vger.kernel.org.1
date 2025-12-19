Return-Path: <netdev+bounces-245457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F6CCE1AE
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 01:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C73D309F4A5
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 00:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7701B217F29;
	Fri, 19 Dec 2025 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaB9aXW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696719F137
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105770; cv=none; b=oCeIlvoDUmil+5y9KcaxGsWbTmGImaU/rf3634lMcgZueSlncyTDo83WRSiLc5Vw3OedDITGZscFSFJPqd/BkRDBMz7trxor2TYLZgOyzQcU8ajnKlFgQK1iW0KDFQQAjLML8GcQHAW93TBVEKn4nPpVXRjezocnHcWP3CWp9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105770; c=relaxed/simple;
	bh=fm6DLt40Gkvxum0nz8ZKvDL8LBXQnHabqCmSW0Cq1as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiFJjeUh5q9koVSTtEDWK0FCRaVsXrV+GHdV8xtNXSgL9lp+KieBlWnQULgygY7Lt0SoRriScaCMrlo9IXuBqef+4gVCcyb92NyGwQAg+P2W86AWQVoWIysx5Qk9nOlWOvE735z4tDXFYFXGN0g6GoO3DwfNrunBAO/ZJoVKKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaB9aXW4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34b75f7a134so959949a91.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 16:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766105767; x=1766710567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxUbs212GolP99ubwroUnuR8M6cZ3ivXyS9dobEaII0=;
        b=MaB9aXW4AXWq4Myuk5dUoSdpYX86A7sIccXRSOG7neGAaBvpzqGtuKH+C/Mk+Nf007
         MN0DVmZZGej2Se/Mrkn52gUi2aAYHji7BAtr8Sz3fkxMYU7t6jdp+eeWgGukN/ycJ+Au
         Qpm5Arhpl9PYMYVFf9G7rqE/9tUl/ct5Wrot+n3BTD+zeT91pG9lHtEWXQYg/HWBwFp8
         sROK62gk6lum33G6FPucTeH/xXI3l/Hvua9+K+7VzLdr9UONp1W6oLuNCL5r9doATaRk
         zY6PayWpu+cWEl//wAhdf9/GWRu12aUMGzjqzz4WWJHXgtcXIIzspGs8GUGEUn/vZPB0
         +ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105767; x=1766710567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JxUbs212GolP99ubwroUnuR8M6cZ3ivXyS9dobEaII0=;
        b=FTMXgpMNKSs5DlRuCGaY1VujvDN7aGfw83i4zrJp2pfT8TRQDKqyAcE4Dkk/kStQs5
         2GiHsr+I8oSWSSWTjDSbgNFhC324g4LT9/EIuxmnBr2iD7eU+B/GFz6K1Ko5wxHXNUOD
         A68jA1bU7UI74HFdak0FSHhmD2+Z6aGLclEQp4VnWz64eO9tNcCx1l+wnebn+ic6+zLA
         CY6SCwUdhOpDxbZ63LYFe4R2HjCKYqa/z0/ECVnJwXpyDq2oeGqeyk4vXY8XdxpRXyIV
         WSn3NU+93nlDTqbiBsbusOtU/nTz+VNCCCj+wBFggERhSPmqWeVTLoijJR+ivjlBVN97
         HMQg==
X-Forwarded-Encrypted: i=1; AJvYcCWCszzS/OtYjxETT+K1+bKvq9ZWP+1G4NKhbFqt8qqp8YqR0aBU93RHtcOyrdlEAkO/K+bzJos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQzRZhiOBaKD2PtCdVu482AFGgaCDHZS9jbHqPRi9XZFXDESYf
	mxbel+w0uhUm+fIvUC+h/DWV8Pd/kEjYS864DfWXGKZeeAAOWc8JeatecAm2yo8L1JGvxzUkaMh
	GaqEphzaU/6VgZXS+joh1yOhnhkOv4Qk=
X-Gm-Gg: AY/fxX4iyZR4yj0mFieP4lEsAk9SXfQn3S/Z6bhriyVrqIm7D4uUHE78hG+R5sHm+vM
	xfQiZ8TsrqYGq+nn15oXnRxfv0CusbMXtbGkvsAOMH68WSRfdp2n5RgNpOoRHHNvcSRSSISwGwO
	x7QoClatIzjdmlB5da8Nnciucy0DMrAyhunH5sr6kYWEm7brXGG/MUNV0VOntwrq4s/+KRqw2p8
	oAFzWKHWaka3NWVGbVzl/UUmqdHR7f2fxXql824lwSA+IR1d5HV+AMWssj721EJk3fCi+JOF5B9
	lbM8KE/HpDQ=
X-Google-Smtp-Source: AGHT+IHPMpE7fHgqLf2p9150l2T0IfZa9t0y+Qk6Q0Z4rEOdENqd3TR6U2Q/1CpjYh356V/cQfFgM/RHRmTQZuOqPeI=
X-Received: by 2002:a17:90b:2787:b0:33b:cbb2:31ed with SMTP id
 98e67ed59e1d1-34e91f6398cmr1029773a91.0.1766105767226; Thu, 18 Dec 2025
 16:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217095445.218428-1-dongml2@chinatelecom.cn> <20251217095445.218428-8-dongml2@chinatelecom.cn>
In-Reply-To: <20251217095445.218428-8-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:55:54 -0800
X-Gm-Features: AQt7F2pr69A_eKHttgetzmniZG8HgccFZt9xxb6MndDM4cXhyYiTMVAvCI-bdK0
Message-ID: <CAEf4Bzb+epu=X9w1+11ZojGYL5hn6SSRNdV_pvoiH1xcdLTuJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 7/9] libbpf: add support for tracing session
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:55=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add BPF_TRACE_SESSION to libbpf and bpftool.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  tools/bpf/bpftool/common.c | 1 +
>  tools/lib/bpf/bpf.c        | 2 ++
>  tools/lib/bpf/libbpf.c     | 3 +++
>  3 files changed, 6 insertions(+)
>
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index e8daf963ecef..534be6cfa2be 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_atta=
ch_type t)
>         case BPF_TRACE_FENTRY:                  return "fentry";
>         case BPF_TRACE_FEXIT:                   return "fexit";
>         case BPF_MODIFY_RETURN:                 return "mod_ret";
> +       case BPF_TRACE_SESSION:                 return "fsession";
>         case BPF_SK_REUSEPORT_SELECT:           return "sk_skb_reuseport_=
select";
>         case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:        return "sk_skb_re=
useport_select_or_migrate";
>         default:        return libbpf_bpf_attach_type_str(t);
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 21b57a629916..5042df4a5df7 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -794,6 +794,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>         case BPF_TRACE_FENTRY:
>         case BPF_TRACE_FEXIT:
>         case BPF_MODIFY_RETURN:
> +       case BPF_TRACE_SESSION:
>         case BPF_LSM_MAC:
>                 attr.link_create.tracing.cookie =3D OPTS_GET(opts, tracin=
g.cookie, 0);
>                 if (!OPTS_ZEROED(opts, tracing))
> @@ -917,6 +918,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>         case BPF_TRACE_FENTRY:
>         case BPF_TRACE_FEXIT:
>         case BPF_MODIFY_RETURN:
> +       case BPF_TRACE_SESSION:

no need, this is a legacy fallback path for programs that were (at
some point for older kernels) attachable only through
BPF_RAW_TRACEPOINT_OPEN. BPF_LINK_CREATE is sufficient, drop this
line.

>                 return bpf_raw_tracepoint_open(NULL, prog_fd);
>         default:
>                 return libbpf_err(err);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c7c79014d46c..0c095195df31 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -115,6 +115,7 @@ static const char * const attach_type_name[] =3D {
>         [BPF_TRACE_FENTRY]              =3D "trace_fentry",
>         [BPF_TRACE_FEXIT]               =3D "trace_fexit",
>         [BPF_MODIFY_RETURN]             =3D "modify_return",
> +       [BPF_TRACE_SESSION]             =3D "trace_session",

let's use fsession terminology consistently


>         [BPF_LSM_MAC]                   =3D "lsm_mac",
>         [BPF_LSM_CGROUP]                =3D "lsm_cgroup",
>         [BPF_SK_LOOKUP]                 =3D "sk_lookup",
> @@ -9853,6 +9854,8 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("fentry.s+",            TRACING, BPF_TRACE_FENTRY, SEC_AT=
TACH_BTF | SEC_SLEEPABLE, attach_trace),
>         SEC_DEF("fmod_ret.s+",          TRACING, BPF_MODIFY_RETURN, SEC_A=
TTACH_BTF | SEC_SLEEPABLE, attach_trace),
>         SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC_ATT=
ACH_BTF | SEC_SLEEPABLE, attach_trace),
> +       SEC_DEF("fsession+",            TRACING, BPF_TRACE_SESSION, SEC_A=
TTACH_BTF, attach_trace),
> +       SEC_DEF("fsession.s+",          TRACING, BPF_TRACE_SESSION, SEC_A=
TTACH_BTF | SEC_SLEEPABLE, attach_trace),
>         SEC_DEF("freplace+",            EXT, 0, SEC_ATTACH_BTF, attach_tr=
ace),
>         SEC_DEF("lsm+",                 LSM, BPF_LSM_MAC, SEC_ATTACH_BTF,=
 attach_lsm),
>         SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTACH_BTF =
| SEC_SLEEPABLE, attach_lsm),
> --
> 2.52.0
>

