Return-Path: <netdev+bounces-177286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E670DA6E943
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 06:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA8116AE51
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 05:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F7C1A2C06;
	Tue, 25 Mar 2025 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRS5CbMo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C65149DE8
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742880118; cv=none; b=m14H3aG1MuV+tSX00Qs7B/L4RbYA5PKYYZ6hb7uqzkSLbySYq8nSXMw++1aObUbqIDlFm/j758H/6q/p8rDgco2bIeDJcz2qcUoSbj9Kdxyu2Jz3M/nnooPMbyksH6yk1tFiqr1mqimAL5+zjoN9a0EhcSDdnejt3llTxYFgb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742880118; c=relaxed/simple;
	bh=km3N0+p5UmnsX6COZ2KgI/JmqmDskXfPNFC8rI68hJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gT0Lvh3bn2VxY7QdvFkSSLW87xNp85dKWQQjVk24oz0dNCube9A+9k4R+wZQvh2G57GqwRybtKbzuCqYBBMDnUAwlu8YALAF5id/cWlDFJgqacThLuIULWt/KYRKeCWl7O2Pl+CA3m8xGp+VayCnTMaRZybVqhWF2s9fup4SHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRS5CbMo; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476af5479feso47615481cf.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742880115; x=1743484915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lomCUCbXgX6nE+LW1PH+Y2bS1fjA57fzR64X+WRuwbE=;
        b=MRS5CbMo6n+bNcsym3mD2jrQ77amVZlbWHLpjNpPqxluA6oml8ikxOL1C9BIc6vLoB
         yh+Nj2mkMcAOr9+PExP0Vs8RF1v+iuXAEBi5RZdPj/wk+E/chpSlWPQrZ7dO+dimutzY
         GNu97O+Ne9SXhGPuncrs0L6nNou2cg5eYVOCJCA9T8iEbVenwn/szMDZ5GQURCXQ6TPu
         g8gAutoOxlFiH2VgGVogzlI2X3ZugRnltK2Gy93PYU8fPwlL7ozj9wlag2qhyManTEqP
         SUBxEpw1W6txUEnwv2phZm21HKrn8ukAWKHRwcawGs2IyUl3mwKkCgVaV4z5S/Kfql84
         p7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742880115; x=1743484915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lomCUCbXgX6nE+LW1PH+Y2bS1fjA57fzR64X+WRuwbE=;
        b=PmjYDdxBdX/zUFHtOJ1K+AOl1q11/14FLZz44Jr8GLlDKXsw7QP7NK4NTAn0ZGUOPC
         1DjGPIZY6BivdA/HbNbz11lNdsp8nWIvg+VogKmeHapS7pvyBsaJ9thi3BVSdAh5nm8v
         yqRGiKb5bWnyYOHG4OYIpGJj+dWiKlsJdJFWSlbVW2duRHeGxCrw27GEzvQ2ICerbiKP
         sqczunGILpb9aRwh2j1qi66v/wcR6HGpoibNdWFxLbBSPdbu7Li3GiW8aEa8G5inXKeq
         xmd2nqC9tEDVx89fIm/bj3ouv8V7VLf2q7I1pV6yNDQGarKMipQUnN/e3PZGf8MTa8oS
         EaPw==
X-Forwarded-Encrypted: i=1; AJvYcCWk+Rm1xWqqylF3XwcSl5Yn81E7urHyB4+8XxSQgmNYFycum1OIlMuNcGFidsOtQ1E90xt4Ilo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZJxNWbHifVMKgyHxh/gif0SzVn8dXeDUrsF45Y2GDMvItx1r
	em8buHHPzFHG9VzFAyanXAgSW/oUHTg2gl+0fjjEZtxrFBpWbqWIBmhuX0cr/NMlMNB2bYguaBD
	9qhRdVdDYa8ZKF8PoLYNEVNBioRf9LGNN5Zh7
X-Gm-Gg: ASbGnctlzVk0Jiyirg588C2C6qxvv55yj1xzmR9r/jKhQrQJTyPxxK5omUkAavPKaeU
	CPS75d5rDthqT4Fwbcgez2ZGeHTFQslJrsy0oTP/ny/k7jYrLygwNG4vOUIgR3BS077Z6nRy9pI
	udZLpeq1rBMYexsV6eb2D+OTH2qw==
X-Google-Smtp-Source: AGHT+IFuoo9a80CaecGtUHiPU5cNU3ssgrGIkNvDUO0q8i3gYnU/YIjkCXifw+MTT/Xd2THwHK0JYHMFALY2+foT+sc=
X-Received: by 2002:a05:622a:5e13:b0:476:980c:10a8 with SMTP id
 d75a77b69052e-4771dd89817mr275087661cf.21.1742880114991; Mon, 24 Mar 2025
 22:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-netns-debugfs-v1-1-c75e9d5a6266@kernel.org>
In-Reply-To: <20250324-netns-debugfs-v1-1-c75e9d5a6266@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 06:21:44 +0100
X-Gm-Features: AQ5f1Jpo46yjmZxCGvmGXnjpHCubT1YLmkD_YwFqIO8scnLE13pByFExr1SBtRc
Message-ID: <CANn89iL44SvNKgK-fbm2+bWUpCk+cT0LFVaMGj7HdVOkRiW9Vg@mail.gmail.com>
Subject: Re: [PATCH] net: add a debugfs files for showing netns refcount
 tracking info
To: Jeff Layton <jlayton@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:24=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> CONFIG_NET_NS_REFCNT_TRACKER currently has no convenient way to display
> its tracking info. Add a new net_ns directory in debugfs. Have a
> directory in there for every net, with refcnt and notrefcnt files that
> show the currently tracked active and passive references.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Recently, I had a need to track down some long-held netns references,
> and discovered CONFIG_NET_NS_REFCNT_TRACKER. The main thing that seemed
> to be missing from it though is a simple way to view the currently held
> references on the netns. This adds files in debugfs for this.

Thanks for working on this, this is a very good idea.


> +#define MAX_NS_DEBUG_BUFSIZE   (32 * PAGE_SIZE)
> +
> +static int
> +ns_debug_tracker_show(struct seq_file *f, void *v)
> +{
> +       struct ref_tracker_dir *tracker =3D f->private;
> +       int len, bufsize =3D PAGE_SIZE;
> +       char *buf;
> +
> +       for (;;) {
> +               buf =3D kvmalloc(bufsize, GFP_KERNEL);
> +               if (!buf)
> +                       return -ENOMEM;
> +
> +               len =3D ref_tracker_dir_snprint(tracker, buf, bufsize);
> +               if (len < bufsize)
> +                       break;
> +
> +               kvfree(buf);
> +               bufsize *=3D 2;
> +               if (bufsize > MAX_NS_DEBUG_BUFSIZE)
> +                       return -ENOBUFS;
> +       }
> +       seq_write(f, buf, len);
> +       kvfree(buf);
> +       return 0;
> +}

I guess we could first change ref_tracker_dir_snprint(tracker, buf, bufsize=
)
to ref_tracker_dir_snprint(tracker, buf, bufsize, &needed) to avoid
too many tries in this loop.

Most of ref_tracker_dir_snprint() runs with hard irq being disabled...


diff --git a/drivers/gpu/drm/i915/intel_wakeref.c
b/drivers/gpu/drm/i915/intel_wakeref.c
index 87f2460473127af65a9a793c7f1934fafe41e79e..6650421b4f00c318adec72cd7c1=
7a76832f14cce
100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -208,7 +208,7 @@ void intel_ref_tracker_show(struct ref_tracker_dir *dir=
,
        if (!buf)
                return;

-       count =3D ref_tracker_dir_snprint(dir, buf, buf_size);
+       count =3D ref_tracker_dir_snprint(dir, buf, buf_size, NULL);
        if (!count)
                goto free;
        /* printk does not like big buffers, so we split it */
diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index 8eac4f3d52547ccbaf9dcd09962ce80d26fbdff8..19bd42088434b661810082350a9=
d5afcbff6a88a
100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -46,7 +46,7 @@ void ref_tracker_dir_print_locked(struct ref_tracker_dir =
*dir,
 void ref_tracker_dir_print(struct ref_tracker_dir *dir,
                           unsigned int display_limit);

-int ref_tracker_dir_snprint(struct ref_tracker_dir *dir, char *buf,
size_t size);
+int ref_tracker_dir_snprint(struct ref_tracker_dir *dir, char *buf,
size_t size, size_t *needed);

 int ref_tracker_alloc(struct ref_tracker_dir *dir,
                      struct ref_tracker **trackerp, gfp_t gfp);
@@ -77,7 +77,7 @@ static inline void ref_tracker_dir_print(struct
ref_tracker_dir *dir,
 }

 static inline int ref_tracker_dir_snprint(struct ref_tracker_dir *dir,
-                                         char *buf, size_t size)
+                                         char *buf, size_t size,
size_t *needed)
 {
        return 0;
 }
diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index cf5609b1ca79361763abe5a3a98484a3ee591ff2..d8d02dab7ce67caf91ae22f9391=
abe2c92481c7f
100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -65,6 +65,7 @@ ref_tracker_get_stats(struct ref_tracker_dir *dir,
unsigned int limit)
 struct ostream {
        char *buf;
        int size, used;
+       size_t needed;
 };

 #define pr_ostream(stream, fmt, args...) \
@@ -76,6 +77,7 @@ struct ostream {
        } else { \
                int ret, len =3D _s->size - _s->used; \
                ret =3D snprintf(_s->buf + _s->used, len, pr_fmt(fmt), ##ar=
gs); \
+               _s->needed +=3D ret; \
                _s->used +=3D min(ret, len); \
        } \
 })
@@ -141,7 +143,7 @@ void ref_tracker_dir_print(struct ref_tracker_dir *dir,
 }
 EXPORT_SYMBOL(ref_tracker_dir_print);

-int ref_tracker_dir_snprint(struct ref_tracker_dir *dir, char *buf,
size_t size)
+int ref_tracker_dir_snprint(struct ref_tracker_dir *dir, char *buf,
size_t size, size_t *needed)
 {
        struct ostream os =3D { .buf =3D buf, .size =3D size };
        unsigned long flags;
@@ -150,6 +152,8 @@ int ref_tracker_dir_snprint(struct ref_tracker_dir
*dir, char *buf, size_t size)
        __ref_tracker_dir_pr_ostream(dir, 16, &os);
        spin_unlock_irqrestore(&dir->lock, flags);

+       if (needed)
+               *needed =3D os.needed;
        return os.used;
 }
 EXPORT_SYMBOL(ref_tracker_dir_snprint);
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index ce4b01cc7aca15ddf74f4160580871868e693fb8..61ce889ab29c2b726eab064b0ec=
b39838db30229
100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1529,13 +1529,14 @@ struct ns_debug_net {
        struct dentry *notrefcnt;
 };

-#define MAX_NS_DEBUG_BUFSIZE   (32 * PAGE_SIZE)
+#define MAX_NS_DEBUG_BUFSIZE   (1 << 20)

 static int
 ns_debug_tracker_show(struct seq_file *f, void *v)
 {
        struct ref_tracker_dir *tracker =3D f->private;
        int len, bufsize =3D PAGE_SIZE;
+       size_t needed;
        char *buf;

        for (;;) {
@@ -1543,12 +1544,12 @@ ns_debug_tracker_show(struct seq_file *f, void *v)
                if (!buf)
                        return -ENOMEM;

-               len =3D ref_tracker_dir_snprint(tracker, buf, bufsize);
+               len =3D ref_tracker_dir_snprint(tracker, buf, bufsize, &nee=
ded);
                if (len < bufsize)
                        break;

                kvfree(buf);
-               bufsize *=3D 2;
+               bufsize =3D round_up(needed, PAGE_SIZE);
                if (bufsize > MAX_NS_DEBUG_BUFSIZE)
                        return -ENOBUFS;
        }

