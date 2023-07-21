Return-Path: <netdev+bounces-19796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666B75C5BF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61901C21670
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940A21D2ED;
	Fri, 21 Jul 2023 11:18:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F23D78
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961CAC433CA;
	Fri, 21 Jul 2023 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689938290;
	bh=+1pRznIJZVGaXfyHrneWrC6bYAtsOlit/tS0KrtG2yM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZkemUooeRUEBMXoT+eZuwXtiItz8nm/fDLuhMM6XoA0+EU916wGv+BgIRm9/xgMuX
	 SHioymbBApSyxanIRzsRJlh1H1xIrmrEecxMCb2eiIpMa2MDza+a4Lq7s8MEmglIDe
	 ez4c8dEMJ4yU8fNNE27hJRQDS67tU5s8hkkkchIZQ2TJUr2H0Pp5kPNTLBrZ7BE1tE
	 XtM4lvoh9Le7pYU5tDl1ZWsi1wmd04lf2V4ROGk/Ku3L6+VkMgVjYdls3FN1H/kiR2
	 xtTShhij+hbZh33BcJIHIG5mmO1W021HSeM9yzvPFkgCtgYQYflWAvK86K6XkJEDCq
	 e88ULpSvyQglQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so2891849e87.3;
        Fri, 21 Jul 2023 04:18:10 -0700 (PDT)
X-Gm-Message-State: ABy/qLb6/q4WRjT4XwdfpkRnqdmVnGhq3BwMzyUEwNPjp3RI6y+k+JvW
	V37nq1skh4rnl+G7VU76euusfgRNlpu94+0Gjsk=
X-Google-Smtp-Source: APBJJlGgzNV4bS4ZImEmRoMMfW0jhmUui+8qThAJBRzr+dpV1Qj1REJCRGaubl5KmDySuU4gh04KMBTQZciuHQWvik4=
X-Received: by 2002:a05:6512:6d4:b0:4f9:58ed:7bba with SMTP id
 u20-20020a05651206d400b004f958ed7bbamr1221034lff.16.1689938288556; Fri, 21
 Jul 2023 04:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230718125847.3869700-1-ardb@kernel.org> <20230718125847.3869700-21-ardb@kernel.org>
 <ZLpoDumeF/+xax/V@corigine.com>
In-Reply-To: <ZLpoDumeF/+xax/V@corigine.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Jul 2023 13:17:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE4BFjracdzsM87Kq40t683RnT4VXEZjU0d0gRVwso=vA@mail.gmail.com>
Message-ID: <CAMj1kXE4BFjracdzsM87Kq40t683RnT4VXEZjU0d0gRVwso=vA@mail.gmail.com>
Subject: Re: [RFC PATCH 20/21] crypto: deflate - implement acomp API directly
To: Simon Horman <simon.horman@corigine.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Haren Myneni <haren@us.ibm.com>, Nick Terrell <terrelln@fb.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Richard Weinberger <richard@nod.at>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, qat-linux@intel.com, 
	linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jul 2023 at 13:12, Simon Horman <simon.horman@corigine.com> wrote:
>
> On Tue, Jul 18, 2023 at 02:58:46PM +0200, Ard Biesheuvel wrote:
>
> ...
>
> > -static int deflate_comp_init(struct deflate_ctx *ctx)
> > +static int deflate_process(struct acomp_req *req, struct z_stream_s *stream,
> > +                        int (*process)(struct z_stream_s *, int))
> >  {
> > -     int ret = 0;
> > -     struct z_stream_s *stream = &ctx->comp_stream;
> > +     unsigned int slen = req->slen;
> > +     unsigned int dlen = req->dlen;
> > +     struct scatter_walk src, dst;
> > +     unsigned int scur, dcur;
> > +     int ret;
> >
> > -     stream->workspace = vzalloc(zlib_deflate_workspacesize(
> > -                             -DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL));
> > -     if (!stream->workspace) {
> > -             ret = -ENOMEM;
> > -             goto out;
> > -     }
> > +     stream->avail_in = stream->avail_out = 0;
> > +
> > +     scatterwalk_start(&src, req->src);
> > +     scatterwalk_start(&dst, req->dst);
> > +
> > +     scur = dcur = 0;
> > +
> > +     do {
> > +             if (stream->avail_in == 0) {
> > +                     if (scur) {
> > +                             slen -= scur;
> > +
> > +                             scatterwalk_unmap(stream->next_in - scur);
> > +                             scatterwalk_advance(&src, scur);
> > +                             scatterwalk_done(&src, 0, slen);
> > +                     }
> > +
> > +                     scur = scatterwalk_clamp(&src, slen);
> > +                     if (scur) {
> > +                             stream->next_in = scatterwalk_map(&src);
> > +                             stream->avail_in = scur;
> > +                     }
> > +             }
> > +
> > +             if (stream->avail_out == 0) {
> > +                     if (dcur) {
> > +                             dlen -= dcur;
> > +
> > +                             scatterwalk_unmap(stream->next_out - dcur);
> > +                             scatterwalk_advance(&dst, dcur);
> > +                             scatterwalk_done(&dst, 1, dlen);
> > +                     }
> > +
> > +                     dcur = scatterwalk_clamp(&dst, dlen);
> > +                     if (!dcur)
> > +                             break;
>
> Hi Ard,
>
> I'm unsure if this can happen. But if this break occurs in the first
> iteration of this do loop, then ret will be used uninitialised below.
>
> Smatch noticed this.
>

Thanks.

This should not happen - it would mean req->dlen == 0, which is
rejected before this function is even called.

Whether or not it might ever happen in practice is a different matter,
of course, so I should probably initialize 'ret' to something sane.



> > +
> > +                     stream->next_out = scatterwalk_map(&dst);
> > +                     stream->avail_out = dcur;
> > +             }
> > +
> > +             ret = process(stream, (slen == scur) ? Z_FINISH : Z_SYNC_FLUSH);
> > +     } while (ret == Z_OK);
> > +
> > +     if (scur)
> > +             scatterwalk_unmap(stream->next_in - scur);
> > +     if (dcur)
> > +             scatterwalk_unmap(stream->next_out - dcur);
> > +
> > +     if (ret != Z_STREAM_END)
> > +             return -EINVAL;
> > +
> > +     req->dlen = stream->total_out;
> > +     return 0;
> > +}
>
> ...

