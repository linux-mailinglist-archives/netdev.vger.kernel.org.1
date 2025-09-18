Return-Path: <netdev+bounces-224609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6DBB86E03
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4203D582466
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB92FBDF8;
	Thu, 18 Sep 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/r5iqrD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9A2E36EC
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226760; cv=none; b=AkO18m8oRglcfcCxEMDfpqfU6A1k6/tnKVOKnOuSxzuupXt40gCnI/H3wreQqm6DuIMKTduRYpRVtEF0B0lSAsrSog9HVWCb0+UhRrU3iuVnA+sFFXYsEpT6npJAuWrNrTqBmC2qbeaxWARhwuejMc7leMNdOJEY0VqvHTDRd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226760; c=relaxed/simple;
	bh=MSrYK5l1Dhtp//b9m4/uCJYqYESGjProA/i+OCdEKLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anEQYZDQyl8bK17GHg/8iL4TxS067q5+0UzmWou/RzbUToBnK35D/ml7tB0t91Xu3FxZVX7JWA/+kQ+EUcduyWmpOP0pAZyR1F8nOvh+nDk/gDsipNxYLhIX3K/W0A/r6k+DqWpjfaK5p1KmICYekEiLvviplt8BT8bCcHqK3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/r5iqrD; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea5c3e8b88bso996178276.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226758; x=1758831558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTahUzbgP+Xa186s0Bbk9WFAxKdyPvX3+HQpicuKF5w=;
        b=c/r5iqrDOqezUvHAb8N0NOJUKMJAeTpLQLLk9b9mR5WTMh4AsfwrPrh4IU4AqP0OTw
         T23PsA9wXuBV3CEUlNbsbzs8SptDILnEERI89NJSTeyRQR5B4hp37WF3TRudmTwh/YUF
         PwRAPFDEld/c26TrgjZot/phvJ+Gy6aCn8rWtIkaUEbBT+7CyyVtlar22GVrUJ2QBbZ+
         ZAbFAH1yfRSIWInZuEgiucgKpx4Gt3g7L+r+90DipXKPixwHF7vvKW36/hFgCD7/mr8J
         ljlOWT52zkd/bXKpabC6gQgdYqgM9TUcDURmTTbl4nSr3DgSpljWIVLdEX4VXIj9TdMD
         IE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226758; x=1758831558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTahUzbgP+Xa186s0Bbk9WFAxKdyPvX3+HQpicuKF5w=;
        b=AxJrRZL6JAh0NMq6xGDskiVCVcJSABCccVTFFp4Ye6wtkWGQzi7jTvN0vP3EERK0r0
         8T6F83EE6cvRLlIY7QiusKB95ePk9YoPpMQ7lwZN9RKbzxk8u6YinzvwlGlJS/cLjABI
         69inuuInNEir5uOA4AV/gnUTTPvB1oeU4WdC2Ao75lagsn5eFnzwOesT7ss5LXfr1Kb6
         B1E2u4g98IcJDZTz6LWZgbSEeiMzdBQvkb6QaJ4Ud/fGeQKMzhyOrDDWeI3pidnTZuLk
         eESdoArFxTTlymOGCzKo4m3dkq0mr9lVL6Um0Wt0HPVmWyLtHDewGLDWwI1/uVXC9/KP
         zGpw==
X-Forwarded-Encrypted: i=1; AJvYcCUdFBhGyuV4+YCnvuciXlnATNzOJc5HVKjEHhEdS647HEwTNIwVZC8sn4oDd0VtgaswplYuJdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLg1xLLSy0Ds3SBp63xrdtnpgdhk8cbt20zKEBdbGzmvclGQW+
	aWM2q+8SzeE+8t93uP18zdw7zyfFY1DTcJ6lr2v9yM2qJ1L9cMOT9kCeSM09SUmvhk1WS/Rdcb+
	PmqSveX/tAI0nKEEWUYqfmjOpR8qb58I=
X-Gm-Gg: ASbGncug0aLUlQim0jh3kBqWRX0ex43NGgiHJFa6yrnd8h/BqDGmGywjkqn6OKnV4Yl
	m5bYBRX0H6hDhzhoNswF8KAr8nWsrW1d/RtDCAYwDW9STn0JdehF4PStj5xCrvqJgFkPGreICd7
	hoZcedtYkyL4kRc1eSy2NfIRkloctrGja4kDECVXRerG73z/Np/qVkMYiqcKSz+73HfYtJm2MKQ
	6THZQLxR/kY2WaBCVdLEDEIVYKTS7Od1D7Mni+Dsw==
X-Google-Smtp-Source: AGHT+IGa/lyAtk6VPjt0+4TLR++CWIKKMYWagD4EDEIufq1u8rJIfGh+C6LhOZaXrQmeuM3bE6fat2HRkI09+n8n7zA=
X-Received: by 2002:a05:690e:2457:b0:627:ca96:be6b with SMTP id
 956f58d0204a3-6347f61f51emr593192d50.37.1758226757745; Thu, 18 Sep 2025
 13:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917225513.3388199-1-ameryhung@gmail.com> <20250917225513.3388199-3-ameryhung@gmail.com>
 <aMvMxrPsNXbTuF3c@boxer> <CAMB2axMg6unuuO-Reu3qU3cU_u+sDjkpwd5srW+9RyJW9coqig@mail.gmail.com>
In-Reply-To: <CAMB2axMg6unuuO-Reu3qU3cU_u+sDjkpwd5srW+9RyJW9coqig@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 18 Sep 2025 13:19:04 -0700
X-Gm-Features: AS18NWC6B_yxln8j0C_g2flCXcGSMGQN7PrElrJ7jLjhfrp2SdmI-UNsOYppKts
Message-ID: <CAMB2axPifKfJxOgoB0m_WejugTKw8yJ1Zu+w0vo+Sz5c4FvNug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Support pulling non-linear xdp data
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:56=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Thu, Sep 18, 2025 at 2:11=E2=80=AFAM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Sep 17, 2025 at 03:55:09PM -0700, Amery Hung wrote:
> > > Add kfunc, bpf_xdp_pull_data(), to support pulling data from xdp
> > > fragments. Similar to bpf_skb_pull_data(), bpf_xdp_pull_data() makes
> > > the first len bytes of data directly readable and writable in bpf
> > > programs. If the "len" argument is larger than the linear data size,
> > > data in fragments will be copied to the linear data area when there
> > > is enough room. Specifically, the kfunc will try to use the tailroom
> > > first. When the tailroom is not enough, metadata and data will be
> > > shifted down to make room for pulling data.
> > >
> > > A use case of the kfunc is to decapsulate headers residing in xdp
> > > fragments. It is possible for a NIC driver to place headers in xdp
> > > fragments. To keep using direct packet access for parsing and
> > > decapsulating headers, users can pull headers into the linear data
> > > area by calling bpf_xdp_pull_data() and then pop the header with
> > > bpf_xdp_adjust_head().
> > >
> > > Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  net/core/filter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 91 insertions(+)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 0b82cb348ce0..0e8d63bf1d30 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -12212,6 +12212,96 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstam=
p(struct bpf_sock_ops_kern *skops,
> > >       return 0;
> > >  }
> > >
> > > +/**
> > > + * bpf_xdp_pull_data() - Pull in non-linear xdp data.
> > > + * @x: &xdp_md associated with the XDP buffer
> > > + * @len: length of data to be made directly accessible in the linear=
 part
> > > + *
> > > + * Pull in data in case the XDP buffer associated with @x is non-lin=
ear and
> > > + * not all @len are in the linear data area.
> > > + *
> > > + * Direct packet access allows reading and writing linear XDP data t=
hrough
> > > + * packet pointers (i.e., &xdp_md->data + offsets). The amount of da=
ta which
> > > + * ends up in the linear part of the xdp_buff depends on the NIC and=
 its
> > > + * configuration. When a frag-capable XDP program wants to directly =
access
> > > + * headers that may be in the non-linear area, call this kfunc to ma=
ke sure
> > > + * the data is available in the linear area. Alternatively, use dynp=
tr or
> > > + * bpf_xdp_{load,store}_bytes() to access data without pulling.
> > > + *
> > > + * This kfunc can also be used with bpf_xdp_adjust_head() to decapsu=
late
> > > + * headers in the non-linear data area.
> > > + *
> > > + * A call to this kfunc may reduce headroom. If there is not enough =
tailroom
> > > + * in the linear data area, metadata and data will be shifted down.
> > > + *
> > > + * A call to this kfunc is susceptible to change the buffer geometry=
.
> > > + * Therefore, at load time, all checks on pointers previously done b=
y the
> > > + * verifier are invalidated and must be performed again, if the kfun=
c is used
> > > + * in combination with direct packet access.
> > > + *
> > > + * Return:
> > > + * * %0         - success
> > > + * * %-EINVAL   - invalid len
> > > + */
> > > +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
> > > +{
> > > +     struct xdp_buff *xdp =3D (struct xdp_buff *)x;
> > > +     struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff=
(xdp);
> > > +     int i, delta, shift, headroom, tailroom, n_frags_free =3D 0;
> > > +     void *data_hard_end =3D xdp_data_hard_end(xdp);
> > > +     int data_len =3D xdp->data_end - xdp->data;
> > > +     void *start;
> > > +
> > > +     if (len <=3D data_len)
> > > +             return 0;
> > > +
> > > +     if (unlikely(len > xdp_get_buff_len(xdp)))
> > > +             return -EINVAL;
> > > +
> > > +     start =3D xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->dat=
a_meta;
> > > +
> > > +     headroom =3D start - xdp->data_hard_start - sizeof(struct xdp_f=
rame);
> > > +     tailroom =3D data_hard_end - xdp->data_end;
> > > +
> > > +     delta =3D len - data_len;
> > > +     if (unlikely(delta > tailroom + headroom))
> > > +             return -EINVAL;
> > > +
> > > +     shift =3D delta - tailroom;
> > > +     if (shift > 0) {
> > > +             memmove(start - shift, start, xdp->data_end - start);
> > > +
> > > +             xdp->data_meta -=3D shift;
> > > +             xdp->data -=3D shift;
> > > +             xdp->data_end -=3D shift;
> > > +     }
> > > +
> > > +     for (i =3D 0; i < sinfo->nr_frags && delta; i++) {
> > > +             skb_frag_t *frag =3D &sinfo->frags[i];
> > > +             u32 shrink =3D min_t(u32, delta, skb_frag_size(frag));
> > > +
> > > +             memcpy(xdp->data_end, skb_frag_address(frag), shrink);
> > > +
> > > +             xdp->data_end +=3D shrink;
> > > +             sinfo->xdp_frags_size -=3D shrink;
> > > +             delta -=3D shrink;
> > > +             if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
> > > +                     n_frags_free++;
> > > +     }
> > > +
> > > +     if (unlikely(n_frags_free)) {
> > > +             memmove(sinfo->frags, sinfo->frags + n_frags_free,
> > > +                     (sinfo->nr_frags - n_frags_free) * sizeof(skb_f=
rag_t));
> > > +
> > > +             sinfo->nr_frags -=3D n_frags_free;
> > > +
> > > +             if (!sinfo->nr_frags)
> > > +                     xdp_buff_clear_frags_flag(xdp);
> >
> > Nit: should we take care of pfmemalloc flag as well?
> >
>
> Does it mean we should also clear this bit in bpf_xdp_adjsut_tail()?

Looking at the code, it makes sense to clear it while it currently
does not make any difference. All readers of this flag check against
it only when there are fragments.

>
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  __bpf_kfunc_end_defs();
> > >
> > >  int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> > > @@ -12239,6 +12329,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
> > >
> > >  BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
> > >  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
> > > +BTF_ID_FLAGS(func, bpf_xdp_pull_data)
> > >  BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
> > >
> > >  BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
> > > --
> > > 2.47.3
> > >

