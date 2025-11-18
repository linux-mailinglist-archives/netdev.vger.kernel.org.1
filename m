Return-Path: <netdev+bounces-239675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A776C6B4A7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80BAE358FF0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6B2DF714;
	Tue, 18 Nov 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfjsZ+cn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F02DF128
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491900; cv=none; b=Zp4TpuouZdvFZ3c00Scn10NMairz8ZMR9FH8CWsRWad1KV8NtEWp10o5+JDDTjg6pqsxfFL2UXcP4lRtlwSONt1L9xDnSKmooWcbVb7huBT9nc3gFQ94bgcVzXV0ageBh04oaUGtqKTSxuqEDhJzk+dCGbM/WUnPERiNVxYVmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491900; c=relaxed/simple;
	bh=81Sp+D+laB+03Tt7GS7Ug4TPjoj/pq6tLpAp2spnHLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkboXzeYnsXNVS5EGEDSuqL6Zix2m5X3LeV5Uue7L/qxBFUxRsIHvVD/mjy5u/JFsCaxxjP+ubSD8DQX9AtRzC+wIwERlNghw/WF/4p/FWjJjSaXBCyhPqJjPyQHs92S+sE+iBGksZT8mkTcnlaJBRP+MFyp8v/dlpmy9g87OBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfjsZ+cn; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63fb5a43d0aso890214d50.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763491897; x=1764096697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmJ1r+Yly7snQXkHFNnjZN8vcx+B6ZlSZ9GX621gT18=;
        b=EfjsZ+cnv1wHgig/mJwoJxuniaakJMKlEvfubMuS83oRH57Onp4uRAceKsoVmurjY9
         mQeOcPvD6RKghVCaDZlt1/RRvgKsEsa2xXtSFOglnQfyBDQEYzUXfyu2P1S9tByNhFLK
         FKCV6cPNuNXa49xSGW5Fo/GIRpfwyInnS/PJiyBy9r0wAP0VTIgQzpt6Sd1qcsl1jDgy
         8thrDAYEgaxOE2dc5SQKpkMa/Ow2efsFwfPFIDU+XLLJQxAHOwL+j0WETa9E7bLeIQOj
         VVckWSIgJARCoiwqgu79QrEKKBErCXYS0pYDyjshO3x8w6Z0wXE9BgKbgE859zj7Dkge
         3txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491897; x=1764096697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmJ1r+Yly7snQXkHFNnjZN8vcx+B6ZlSZ9GX621gT18=;
        b=QFvz5Jd5sU0TgBtHcms6YMoh/ot2zhnOh3hr/lX0+C/PHOVFgtctn9nYTCioYrGfyq
         m6LwuOfYiP2CEZuZKykV3Wv9/wT+FebZwehdPGYVm0rUpE61b2U+naeVAL34iustaT28
         LmL63jTh2EUtCcuVY7iui0ZsftKWHRHjN5QWF+j8gxIbzTShAjoGLivGvJCMYOy4fXZp
         ZHzDA0qydkSFDVkuUwNirsUL1VyBahjRJpZlW+xPh9tlab8J71MGlerz+dKIdcZd+nHq
         GhKhw+duGomT0HIUCLq1MTEyldGxBpnt8tHKq2CuXJ0WCcPRi8shK/Q2ZNtyEwcAzBID
         1I0g==
X-Forwarded-Encrypted: i=1; AJvYcCVUsCGY8yRmGEleY/fm597Jxac/lZLHJNXxISgSEZZxX0TULN7MrQMCI6FuNN2/sUED4QtmJtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeqcyvCun2TilDAo2kqmCVpIoIfQbtFeQH7zv7yUVnIbmNBJl
	REgqhVrH13/su/q4d5uGG59WhaOUa1IlbM/VaQ6ZRtlh/kip3nsd5Lga1BxlQH7RLIeE8h/b68u
	VngR57Zhnq/yWzMB8DitSE54y4mcxv+o=
X-Gm-Gg: ASbGncuVTXJnXq5drOYOEwgwNKgD/603YSwFtgeSH7criitedOyPG7OUWbNmg6bKlFA
	3U0XvUIxag5B0k5TkaH0A98gYu2XvBi664NOhenbFtYjALLYtZPyIgerSmeos/IK10mE96wkV+E
	oxGQ83JfJUKVvrEIMRypOy+DXT5VTZXJ4lOjvV9OiBRGMNG4CYosVwQd5dj1R05jB92vUoLQi4v
	YNgW1GdrC9k7OVxRnwdIWlC2WJMtzCR4KQPNQWjuD899fO4rhx6hS9Re5NcP4BEf7Hy0UMZVDE0
	mL23yuBPepLXCo7Q7l+f4g==
X-Google-Smtp-Source: AGHT+IFShkDcISZm2LxvfcdYpj0QvJDYeStfFXrrkERqm+AvudmI/Y8s3QmYdw621TlBmZTH/o0S5hkm+1SrE09tqKk=
X-Received: by 2002:a05:690c:2a8e:b0:786:87b1:960a with SMTP id
 00721157ae682-78965771c42mr22430047b3.1.1763491897264; Tue, 18 Nov 2025
 10:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-3-18cf7fed1026@meta.com> <ucjifexudkswvaef5c25hbzszdnzsnx3drdaqkf7ytdpi6qzk6@pd46ih2slt3w>
In-Reply-To: <ucjifexudkswvaef5c25hbzszdnzsnx3drdaqkf7ytdpi6qzk6@pd46ih2slt3w>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 18 Nov 2025 18:51:25 +0000
X-Gm-Features: AWmQ_bm1HKja1h38EaRzKpJFc3jLvJv52aUCJJuXweopUqbndptdtXQQNn2qV0Q
Message-ID: <CAGSyskVSLtG-JyboQ6TLVKwMvHVH8YmgLJE1wFTU2czxCWFCzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] netconsole: Dynamic allocation of
 userdata buffer
To: Breno Leitao <leitao@debian.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:04=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Thu, Nov 13, 2025 at 08:42:20AM -0800, Gustavo Luiz Duarte wrote:
> > @@ -875,45 +875,61 @@ static ssize_t userdatum_value_show(struct config=
_item *item, char *buf)
> >       return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
> >  }
> >
> > -static void update_userdata(struct netconsole_target *nt)
> > +static int update_userdata(struct netconsole_target *nt)
> >  {
> > +     struct userdatum *udm_item;
> > +     struct config_item *item;
> >       struct list_head *entry;
> > -     int child_count =3D 0;
> > +     char *old_buf =3D NULL;
> > +     char *new_buf =3D NULL;
> >       unsigned long flags;
> > +     int offset =3D 0;
> > +     int len =3D 0;
> >
> > -     spin_lock_irqsave(&target_list_lock, flags);
> > -
> > -     /* Clear the current string in case the last userdatum was delete=
d */
> > -     nt->userdata_length =3D 0;
> > -     nt->userdata[0] =3D 0;
> > -
> > +     /* Calculate buffer size */
>
> Please create a function for this one.

will do in v3

>
> >       list_for_each(entry, &nt->userdata_group.cg_children) {
> > -             struct userdatum *udm_item;
> > -             struct config_item *item;
> > -
> > -             if (child_count >=3D MAX_USERDATA_ITEMS) {
> > -                     spin_unlock_irqrestore(&target_list_lock, flags);
> > -                     WARN_ON_ONCE(1);
> > -                     return;
> > +             item =3D container_of(entry, struct config_item, ci_entry=
);
> > +             udm_item =3D to_userdatum(item);
> > +             /* Skip userdata with no value set */
> > +             if (udm_item->value[0]) {
> > +                     len +=3D snprintf(NULL, 0, " %s=3D%s\n", item->ci=
_name,
> > +                                     udm_item->value);
> >               }
> > -             child_count++;
> > +     }
> > +
> > +     WARN_ON_ONCE(len > MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS);
>
> If we trigger this WARN_ON_ONCE, please return, and do not proceed with
> the buffer replacement.

will do in v3.

>
> > +
> > +     /* Allocate new buffer */
> > +     if (len) {
> > +             new_buf =3D kmalloc(len + 1, GFP_KERNEL);
> > +             if (!new_buf)
> > +                     return -ENOMEM;
> > +     }
> >
> > +     /* Write userdata to new buffer */
> > +     list_for_each(entry, &nt->userdata_group.cg_children) {
> >               item =3D container_of(entry, struct config_item, ci_entry=
);
> >               udm_item =3D to_userdatum(item);
> > -
> >               /* Skip userdata with no value set */
> > -             if (strnlen(udm_item->value, MAX_EXTRADATA_VALUE_LEN) =3D=
=3D 0)
> > -                     continue;
> > -
> > -             /* This doesn't overflow userdata since it will write
> > -              * one entry length (1/MAX_USERDATA_ITEMS long), entry co=
unt is
> > -              * checked to not exceed MAX items with child_count above
> > -              */
> > -             nt->userdata_length +=3D scnprintf(&nt->userdata[nt->user=
data_length],
> > -                                              MAX_EXTRADATA_ENTRY_LEN,=
 " %s=3D%s\n",
> > -                                              item->ci_name, udm_item-=
>value);
> > +             if (udm_item->value[0]) {
> > +                     offset +=3D scnprintf(&new_buf[offset], len + 1 -=
 offset,
> > +                                         " %s=3D%s\n", item->ci_name,
> > +                                         udm_item->value);
> > +             }
> >       }
> > +
> > +     WARN_ON_ONCE(offset !=3D len);
>
> if we hit the warning above, then offset < len, and we are wrapping some
> item, right?
>
> > +
> > +     /* Switch to new buffer and free old buffer */
> > +     spin_lock_irqsave(&target_list_lock, flags);
> > +     old_buf =3D nt->userdata;
> > +     nt->userdata =3D new_buf;
> > +     nt->userdata_length =3D len;
>
> This should be nt->userdata_length =3D offset, supposing the scnprintf go=
t
> trimmed, and the WARN_ON_ONCE above got triggered. Offset is the lenght
> that was appened to new_buf.

Agree. Will use offset instead of len here in v3.

>
> >       spin_unlock_irqrestore(&target_list_lock, flags);
> > +
> > +     kfree(old_buf);
> > +
> > +     return 0;
> >  }
>
> This seems all safe. update_userdata() is called with never called in
> parallel, given it should be called with dynamic_netconsole_mutex, and
> nt-> operations are protected by target_list_lock.
>
> The only concern is nt->userdata_length =3D offset (instead of len).
>
> >
> >  static ssize_t userdatum_value_store(struct config_item *item, const c=
har *buf,
> > @@ -937,7 +953,9 @@ static ssize_t userdatum_value_store(struct config_=
item *item, const char *buf,
> >
> >       ud =3D to_userdata(item->ci_parent);
> >       nt =3D userdata_to_target(ud);
> > -     update_userdata(nt);
> > +     ret =3D update_userdata(nt);
> > +     if (ret < 0)
> > +             goto out_unlock;
> >       ret =3D count;
> >  out_unlock:
> >       mutex_unlock(&dynamic_netconsole_mutex);
> > @@ -1193,7 +1211,10 @@ static struct configfs_attribute *netconsole_tar=
get_attrs[] =3D {
> >
> >  static void netconsole_target_release(struct config_item *item)
> >  {
> > -     kfree(to_target(item));
> > +     struct netconsole_target *nt =3D to_target(item);
>
> Thinking about this now, I suppose netconsole might be reading this in
> parallel, and then we are freeing userdata mid-air.
>
> Don't we need the target_list_lock in here ?

This method is called after drop_netconsole_target(), which removes
the target from target_list. This guarantees that we won't race with
write_ext_msg().
Also, a config_group cannot be removed while it still has child items.
This guarantees that we won't race with userdata or attribute
operations.
So I believe this is safe.

>
> --
> pw-bot: cr

