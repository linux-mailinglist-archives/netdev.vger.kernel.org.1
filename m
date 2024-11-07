Return-Path: <netdev+bounces-142878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FACA9C0928
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33D8B2340E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DE2E3EB;
	Thu,  7 Nov 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tkZBwGtU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6EBD26D
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990731; cv=none; b=gUrLdAsk2QgTPkknKhYmWk/ffnIzZkGnGFixTMNMixH0dSF35z/o5Q9/64RyBLTE0LWnvji2ad2lM3Eh1N0+O+tAeRLNWv8GYJFmDs4znA8B3ZGlkrUu6KOV88cEv0Wi/oqum5DmmaPgqN2MAC1eOC7oOZ+s8W/KJaIf7Q4ymIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990731; c=relaxed/simple;
	bh=chBLKrASMPejZmSJaPCnzh94niroLYh2LAz5JIgdsoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fROrPOCPwE+X+X0Or+Q45SFCVGpmHQL7aOxkV3mX+bzTlSkTDD2SGkHAOwAv4ZlO39qph9zy5LtMRuufVgjmS6FrM+X4sa5LNWuC/Apb7tGdfRYowR24qmPR3vJoVPcAG3aBWqyvJGJ1ghrXzim5KKOg96TzkRLeh80hoMGt188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=tkZBwGtU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72097a5ca74so882534b3a.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 06:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1730990729; x=1731595529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha7AwQpqtSa6VcHWlGpf8bDvzGIRWSVR3vVfi4LAx44=;
        b=tkZBwGtUnsVreWXs3nyPGIHksF8s2ngE8DURuawiAHBDmdVd5jdorE6JlzvAyKU2pB
         RtNoSZb+ciBUGaV8g3Pz3vQgA6LBAgdTwZrPcAtBvstOINtEwx9vQxI1rUPVTzcgK47Z
         XVP3ep75nmSgvTRtUtZQ9ulavz64C+W6Xc83czFWCUUlAMMbVO7MCL+DYUCPEj72gHN+
         X6LuS9M+LgIfWzruTLf4elxnP/oGpoV3yPeo2xIpJ1vpZyl7aynVgj5XH359b1ec05fy
         f/ueV/1kHYU9JxxiV1zLW6etVO9GPk92+ZTeLAN6895IKaix1X0tadZgSmvlWc/ByKXI
         PH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730990729; x=1731595529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha7AwQpqtSa6VcHWlGpf8bDvzGIRWSVR3vVfi4LAx44=;
        b=K9sBf+cuG4E75mVjcHAfJhEwTFImHbM7KCULSSjdV29D+P9eUU9Umx2G4A5hTec2X6
         qvGJYIzByD4KOsY/hCg4OvbHpPdQ35AZ/oSGq7S6MIYGQ0nADVtEU6vfxEyYs0NaiLly
         Dk7oiqwAGPCRqlqSh3RRU0L5PSssbMSJtUcfqwM1inqfarMU16vtGDW1VlncHoVAChVG
         NJEzmEWhk32IwzS/hGASPQYwrT50dUMxpjhJEieHJddCrhTGMXkot6VWHL90n6buU8yg
         vNCllCqVvBu1xJk+uYpUemD0i/1UoPMWY85+SEHgqeDeDkC3BSC8i+QQ7fNyQSeJqfHg
         2Z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCURPZX67I1cRCq3MY1J2ekL55Zo+lubLiscBg+0uao/HLeTWoxyUoPXuNTGteZAAj8TkKD+8mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxagCAJrk97hhNKd8XQBPQ6seoJFwau8mK//l3byVsuQHNBQCkX
	VBeH61U49NApTecn0MKtJ/qYhE37MTVUoQBzQCjI5vvejxW+jxs2xSattxW8bBZAXbBrMOkNea7
	bxe4UdvCotYiG9jvn821/kiaOwhMA3di+f1Uo
X-Google-Smtp-Source: AGHT+IFdhs8F0OtVrGy7jYT7tTHk2JpA/IcD01wUWI70/tvR9MzN2HivjaBIKwrGzIGsQeohi9SYTsXlGSfgX6TwiBk=
X-Received: by 2002:a05:6a20:7f86:b0:1db:eb82:b22f with SMTP id
 adf61e73a8af0-1dbeb82b8b9mr17045607637.5.1730990728647; Thu, 07 Nov 2024
 06:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106143200.282082-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20241106143200.282082-1-alexandre.ferrieux@orange.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 7 Nov 2024 09:45:17 -0500
Message-ID: <CAM0EoMmw3otVXGpFGXqYMb1A2KCGTdVTLS8LWfT=dPVTCYSghA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	alexandre.ferrieux@orange.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 6, 2024 at 9:32=E2=80=AFAM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> To generate hnode handles (in gen_new_htid()), u32 uses IDR and
> encodes the returned small integer into a structured 32-bit
> word. Unfortunately, at disposal time, the needed decoding
> is not done. As a result, idr_remove() fails, and the IDR
> fills up. Since its size is 2048, the following script ends up
> with "Filter already exists":
>
>   tc filter add dev myve $FILTER1
>   tc filter add dev myve $FILTER2
>   for i in {1..2048}
>   do
>     echo $i
>     tc filter del dev myve $FILTER2
>     tc filter add dev myve $FILTER2
>   done
>
> This patch adds the missing decoding logic for handles that
> deserve it.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>

I'd like to take a closer look at this - just tied up with something
at the moment. Give me a day or so.
Did you run tdc tests after your patch?

cheers,
jamal

> ---
> v3: prepend title with subsystem ident
> v2: use u32 type in handle encoder/decoder
>
>  net/sched/cls_u32.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 9412d88a99bc..6da94b809926 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -41,6 +41,16 @@
>  #include <linux/idr.h>
>  #include <net/tc_wrapper.h>
>
> +static inline u32 handle2id(u32 h)
> +{
> +       return ((h & 0x80000000) ? ((h >> 20) & 0x7FF) : h);
> +}
> +
> +static inline u32 id2handle(u32 id)
> +{
> +       return (id | 0x800U) << 20;
> +}
> +
>  struct tc_u_knode {
>         struct tc_u_knode __rcu *next;
>         u32                     handle;
> @@ -310,7 +320,7 @@ static u32 gen_new_htid(struct tc_u_common *tp_c, str=
uct tc_u_hnode *ptr)
>         int id =3D idr_alloc_cyclic(&tp_c->handle_idr, ptr, 1, 0x7FF, GFP=
_KERNEL);
>         if (id < 0)
>                 return 0;
> -       return (id | 0x800U) << 20;
> +       return id2handle(id);
>  }
>
>  static struct hlist_head *tc_u_common_hash;
> @@ -360,7 +370,7 @@ static int u32_init(struct tcf_proto *tp)
>                 return -ENOBUFS;
>
>         refcount_set(&root_ht->refcnt, 1);
> -       root_ht->handle =3D tp_c ? gen_new_htid(tp_c, root_ht) : 0x800000=
00;
> +       root_ht->handle =3D tp_c ? gen_new_htid(tp_c, root_ht) : id2handl=
e(0);
>         root_ht->prio =3D tp->prio;
>         root_ht->is_root =3D true;
>         idr_init(&root_ht->handle_idr);
> @@ -612,7 +622,7 @@ static int u32_destroy_hnode(struct tcf_proto *tp, st=
ruct tc_u_hnode *ht,
>                 if (phn =3D=3D ht) {
>                         u32_clear_hw_hnode(tp, ht, extack);
>                         idr_destroy(&ht->handle_idr);
> -                       idr_remove(&tp_c->handle_idr, ht->handle);
> +                       idr_remove(&tp_c->handle_idr, handle2id(ht->handl=
e));
>                         RCU_INIT_POINTER(*hn, ht->next);
>                         kfree_rcu(ht, rcu);
>                         return 0;
> @@ -989,7 +999,7 @@ static int u32_change(struct net *net, struct sk_buff=
 *in_skb,
>
>                 err =3D u32_replace_hw_hnode(tp, ht, userflags, extack);
>                 if (err) {
> -                       idr_remove(&tp_c->handle_idr, handle);
> +                       idr_remove(&tp_c->handle_idr, handle2id(handle));
>                         kfree(ht);
>                         return err;
>                 }
> --
> 2.30.2
>

