Return-Path: <netdev+bounces-93379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8398BB711
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6741C22AAF
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A554BD8;
	Fri,  3 May 2024 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YlID2bIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92958ACC
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775373; cv=none; b=TS9CX0+/rVWlKXNCqZ0uB6onMlTXhgCyVAohm6PnuGRlmzT+NT7Iy4JjSisR/kgYvIWoysFSXE0dI+UlSVAh0sJKyKvGTYWfR/8bAiLn7iEnOEjoDfsDG9BEEiApDyTZz4lsBuwO6BN2hBp+kPb3dfm5sL5fkG1ED7SDModK6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775373; c=relaxed/simple;
	bh=oXjLAxu+EfKBCqflunyT3eAWT3VI6vsPCn6PVysvIIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxJRHe4ZXFQ/BzEhg/IoWu4oopUmwqlvANfrTHlFiDdpMDSn8C8bIBecrlc1afPiv5y7JDWeLcNW4rj966FAGQDORAMwHy0NFKeXd5/JfjMSpHEvQ/kLQefgp38vEogHooOjDPvTa1U+OEcQmbXP/ts9K66xsE362VRsD5rGBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YlID2bIx; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de59daab3f3so186142276.3
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714775371; x=1715380171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlMjJ5CfnZ4xKYYAFVLOItyc2ZtPoj3gNMYwzfndvZg=;
        b=YlID2bIxq76BfsCMM+V0JTFJLCLKMwXHd1EDZk/SRR+Lh20RzGpEAJhvCoMlwg/Ncm
         0wLUC40u2EXISzQj2udN+cN636djP6YvuXVr24d5dIvlitNX4FAeiu9nJIzgY55W5tUr
         CV88gtt/iDOC/taS0Ygm4ypSZIU5qO0rmn4ei37hIkd62x0xoBNIxoOz1b0z/n+GCmoy
         87DWKzdNHzv4R6WZ2q3o8hBPmGsDdLGIiHDuKOQTepiUl/cQHW35gm4ADxav2YIamLOJ
         tGCXZUeAiz/fQtd2Oq6xQcmsR9Dt6AqXVgKa5dOWbvmif1KjXKwMmgM5D8T+oheYNcFR
         fNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714775371; x=1715380171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlMjJ5CfnZ4xKYYAFVLOItyc2ZtPoj3gNMYwzfndvZg=;
        b=QObfaq+JZpCPG7GgsV915oIOkfKUE91lcC5hAvSEdaKm9rLIJD7UuxIEdBZFo8IGfq
         6muSVpHksa+Aoy+GBgcH6jpTeEevOL6cnPgiC1GE1k43M9X5jgkSAHUFij8gpdcIDSJC
         hbC4CjZl6vlBlquqaIpJxzqOUhjwvVboc8+VQsG3yRo1aovNuKJEj4DBLufiZp8BSfhK
         RYMSyGn3WFcv/8qn1vBoNL8FT+XmZlax3ItcjKL2IV3syRDtQ+x5+MSA9ur9CmFJsn5K
         OPXkCEp+Hx517PIL+x4p8TwozNrQO30VWtImzoHLpBWQaohzhz6sg6U9Xk5nZAqZS3Q1
         H/QA==
X-Forwarded-Encrypted: i=1; AJvYcCUCr5L54h/XDrTDxnk4GjE/QKbcsRNKuo94DlOB5hCXwCIBWKpkrwqEIoAQzS/4jk+O5oB1zIglKc54Ruxzgs0H3FKhfoiL
X-Gm-Message-State: AOJu0Yzt93fsGSw/dI0SzxTc6cuwqGs7yktQ4L+Cbu6LmeaL7l5yOPOO
	baVe2NonNjXwqu6xqGyNFus6mtWpLO45BOJ/bletSzzNBwfFwrl4NaC4KXpUxHxFuE5palqIqZx
	FdCUC15+wzjHRcMH0xCns6jW8SX3Dw89sUNpfmUNEAqpW4kBd19wO
X-Google-Smtp-Source: AGHT+IGnDqMJQjYoT2WywakY88/ZA4ZMnZSc0Ab2HFp6x7jblhlnEo3RFJYg2MQiyf1RDHM/TVdECZJCPiRFQTUDSIM=
X-Received: by 2002:a5b:584:0:b0:de6:1245:c3d5 with SMTP id
 l4-20020a5b0584000000b00de61245c3d5mr4106051ybp.60.1714775370471; Fri, 03 May
 2024 15:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZivhG0yrbpFqORDw@casper.infradead.org>
In-Reply-To: <ZivhG0yrbpFqORDw@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 3 May 2024 15:29:16 -0700
Message-ID: <CAJuCfpHxpZVnpM2bE25MeFK7CrSsO_pGaYuwVNzre47bb1Jh_w@mail.gmail.com>
Subject: Re: [RFC] Make find_tcp_vma() more efficient
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Arjun Roy <arjunroy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:15=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> Liam asked me if we could do away with the "bool *mmap_locked"
> parameter, and the problem is that some architctures don't support
> CONFIG_PER_VMA_LOCK yet.  But we can abstract it ... something like this
> maybe?
>
> (not particularly proposing this for inclusion; just wrote it and want
> to get it out of my tree so I can get back to other projects.  If anyone
> wants it, they can test it and submit it for inclusion and stick my
> S-o-B on it)

I went through all uses of vma_end_read() to convince myself this is
safe with CONFIG_PER_VMA_LOCK=3Dn and the change seems fine from
correctness POV. However the fact that in this configuration
lock_vma_under_mmap_lock()=3D=3DNOP and vma_end_read()=3D=3Dmmap_read_unloc=
k()
does not feel right to me. Current code is more explicit about which
lock is held and I think it's easier to understand.
A new interface like below might be a bit better but I'm not sure if
it's worth it:

#ifdef CONFIG_PER_VMA_LOCK
static inline void mmap_to_vma_lock(struct vm_area_struct *vma)
{
       down_read(&vma->vm_lock->lock);
       mmap_read_unlock(vma->vm_mm);
}

static inline void mmap_or_vma_unlock(struct vm_area_struct *vma)
{
       vma_end_read(vma);
}

#else /* CONFIG_PER_VMA_LOCK */

static inline void mmap_to_vma_lock(struct vm_area_struct *vma) {}
static inline void mmap_or_vma_unlock(struct vm_area_struct *vma)
{
       mmap_read_unlock(vma->vm_mm);
}
#endif /* CONFIG_PER_VMA_LOCK */

>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9849dfda44d4..570763351508 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -779,11 +779,22 @@ static inline void assert_fault_locked(struct vm_fa=
ult *vmf)
>  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>                                           unsigned long address);
>
> +static inline void lock_vma_under_mmap_lock(struct vm_area_struct *vma)
> +{
> +       down_read(&vma->vm_lock->lock);
> +       mmap_read_unlock(vma->vm_mm);
> +}
> +
>  #else /* CONFIG_PER_VMA_LOCK */
>
>  static inline bool vma_start_read(struct vm_area_struct *vma)
>                 { return false; }
> -static inline void vma_end_read(struct vm_area_struct *vma) {}
> +static inline void vma_end_read(struct vm_area_struct *vma)
> +{
> +       mmap_read_unlock(vma->vm_mm);
> +}
> +
> +static inline void lock_vma_under_mmap_lock(struct vm_area_struct *vma) =
{}
>  static inline void vma_start_write(struct vm_area_struct *vma) {}
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>                 { mmap_assert_write_locked(vma->vm_mm); }
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index f23b97777ea5..e763916e5185 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2051,27 +2051,25 @@ static void tcp_zc_finalize_rx_tstamp(struct sock=
 *sk,
>  }
>
>  static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
> -                                          unsigned long address,
> -                                          bool *mmap_locked)
> +                                          unsigned long address)
>  {
>         struct vm_area_struct *vma =3D lock_vma_under_rcu(mm, address);
>
> -       if (vma) {
> -               if (vma->vm_ops !=3D &tcp_vm_ops) {
> -                       vma_end_read(vma);
> +       if (!vma) {
> +               mmap_read_lock(mm);
> +               vma =3D vma_lookup(mm, address);
> +               if (vma) {
> +                       lock_vma_under_mmap_lock(vma);
> +               } else {
> +                       mmap_read_unlock(mm);
>                         return NULL;
>                 }
> -               *mmap_locked =3D false;
> -               return vma;
>         }
> -
> -       mmap_read_lock(mm);
> -       vma =3D vma_lookup(mm, address);
> -       if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
> -               mmap_read_unlock(mm);
> +       if (vma->vm_ops !=3D &tcp_vm_ops) {
> +               vma_end_read(vma);
>                 return NULL;
>         }
> -       *mmap_locked =3D true;
> +
>         return vma;
>  }
>
> @@ -2092,7 +2090,6 @@ static int tcp_zerocopy_receive(struct sock *sk,
>         u32 seq =3D tp->copied_seq;
>         u32 total_bytes_to_map;
>         int inq =3D tcp_inq(sk);
> -       bool mmap_locked;
>         int ret;
>
>         zc->copybuf_len =3D 0;
> @@ -2117,7 +2114,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>                 return 0;
>         }
>
> -       vma =3D find_tcp_vma(current->mm, address, &mmap_locked);
> +       vma =3D find_tcp_vma(current->mm, address);
>         if (!vma)
>                 return -EINVAL;
>
> @@ -2194,10 +2191,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>                                                    zc, total_bytes_to_map=
);
>         }
>  out:
> -       if (mmap_locked)
> -               mmap_read_unlock(current->mm);
> -       else
> -               vma_end_read(vma);
> +       vma_end_read(vma);
>         /* Try to copy straggler data. */
>         if (!ret)
>                 copylen =3D tcp_zc_handle_leftover(zc, sk, skb, &seq, cop=
ybuf_len, tss);

