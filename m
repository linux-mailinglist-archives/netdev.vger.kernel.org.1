Return-Path: <netdev+bounces-177332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A467A6F77F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680C53ADE0C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C01D7E42;
	Tue, 25 Mar 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT6Z990L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C1481C4;
	Tue, 25 Mar 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903271; cv=none; b=SNp51RXHAcEbX7lYJSlH2KarwAmxgv2K+irSsUq6qex/nJ0CdrU0n+DMrZQsSCKYLdJOp2MP7BJ+/rF7r4bYfnd3T8zE67TzyrLnZW3TNpyvMVwbsa7+3qD5ydJUWftKtXNoLMchorG1P0lJv7GrY5IJG6q0v7KkZpXZrtGuVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903271; c=relaxed/simple;
	bh=JRYPMeT+Qd/dzMFpPLo2PxbuHDPYZ+U80zhDwqO0+jA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLqj2FEkURxK0Cypxmg337+TJepVy/ZyaAS+FMiJJjg6NOoLHIg16WwBUb4PJJ9WffLnshFSVTzksWtiWjVR+1yXTq/28NV509RmIDmvGcEJu/jyixt40ZPpLYEaa9Lfj0lm6yzmkh+PK035bNCZWec5obDQ9Dr/CV5Ik9jjKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT6Z990L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA54C4CEE4;
	Tue, 25 Mar 2025 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903271;
	bh=JRYPMeT+Qd/dzMFpPLo2PxbuHDPYZ+U80zhDwqO0+jA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eT6Z990L67n9q9GSa2zvHLJcKVVTfH29PKqxe4aJkDy+DxgcqEhf7nsYXK6SDB+AU
	 +2O6OOL2hHzQfknz36n/clAwBPkflzRVbt8IhpyJwxHGSkaXEE+M7w1ZFUxbevksU/
	 5HIea/168RL1Jhqa2T24Y9e0uQNnE/BexB1y8mM9FWsJe24NG6syVujI2zHLQ3f8TO
	 yZJwc9ZMWS2z/QPnmYF3/pOO0Yk+mEp1PtiP2YqmaaTO28QzCk8WWvd7vWR+TZyuKA
	 i/nh62mtK4ZL1ZE45Oi5M8ezPudAQKU1ggjNO6fZ58U3ziMCU+xV68po6IUk68RQsL
	 sZwg25ATTRCwQ==
Message-ID: <bfb749bd1c9580225270657130b1516168e000f3.camel@kernel.org>
Subject: Re: [PATCH] net: add a debugfs files for showing netns refcount
 tracking info
From: Jeff Layton <jlayton@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 25 Mar 2025 07:47:49 -0400
In-Reply-To: <CANn89iL44SvNKgK-fbm2+bWUpCk+cT0LFVaMGj7HdVOkRiW9Vg@mail.gmail.com>
References: <20250324-netns-debugfs-v1-1-c75e9d5a6266@kernel.org>
	 <CANn89iL44SvNKgK-fbm2+bWUpCk+cT0LFVaMGj7HdVOkRiW9Vg@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-25 at 06:21 +0100, Eric Dumazet wrote:
> On Mon, Mar 24, 2025 at 9:24=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > CONFIG_NET_NS_REFCNT_TRACKER currently has no convenient way to display
> > its tracking info. Add a new net_ns directory in debugfs. Have a
> > directory in there for every net, with refcnt and notrefcnt files that
> > show the currently tracked active and passive references.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Recently, I had a need to track down some long-held netns references,
> > and discovered CONFIG_NET_NS_REFCNT_TRACKER. The main thing that seemed
> > to be missing from it though is a simple way to view the currently held
> > references on the netns. This adds files in debugfs for this.
>=20
> Thanks for working on this, this is a very good idea.
>=20

Thanks. I needed it when I was tracking down refs held by NFS and RPC
clients. My thinking was that we could add the netns specific dirs to
debugfs with the refcnt and notrefcnt files in it for now, and could
add new files to it later as needed for other netns-related things.


>=20
> > +#define MAX_NS_DEBUG_BUFSIZE   (32 * PAGE_SIZE)
> > +
> > +static int
> > +ns_debug_tracker_show(struct seq_file *f, void *v)
> > +{
> > +       struct ref_tracker_dir *tracker =3D f->private;
> > +       int len, bufsize =3D PAGE_SIZE;
> > +       char *buf;
> > +
> > +       for (;;) {
> > +               buf =3D kvmalloc(bufsize, GFP_KERNEL);
> > +               if (!buf)
> > +                       return -ENOMEM;
> > +
> > +               len =3D ref_tracker_dir_snprint(tracker, buf, bufsize);
> > +               if (len < bufsize)
> > +                       break;
> > +
> > +               kvfree(buf);
> > +               bufsize *=3D 2;
> > +               if (bufsize > MAX_NS_DEBUG_BUFSIZE)
> > +                       return -ENOBUFS;
> > +       }
> > +       seq_write(f, buf, len);
> > +       kvfree(buf);
> > +       return 0;
> > +}
>=20
> I guess we could first change ref_tracker_dir_snprint(tracker, buf, bufsi=
ze)
> to ref_tracker_dir_snprint(tracker, buf, bufsize, &needed) to avoid
> too many tries in this loop.
>=20
> Most of ref_tracker_dir_snprint() runs with hard irq being disabled...
>=20

Ouch, yeah that sounds like a good idea.

>=20
> diff --git a/drivers/gpu/drm/i915/intel_wakeref.c
> b/drivers/gpu/drm/i915/intel_wakeref.c
> index 87f2460473127af65a9a793c7f1934fafe41e79e..6650421b4f00c318adec72cd7=
c17a76832f14cce
> 100644
> --- a/drivers/gpu/drm/i915/intel_wakeref.c
> +++ b/drivers/gpu/drm/i915/intel_wakeref.c
> @@ -208,7 +208,7 @@ void intel_ref_tracker_show(struct ref_tracker_dir *d=
ir,
>         if (!buf)
>                 return;
>=20
> -       count =3D ref_tracker_dir_snprint(dir, buf, buf_size);
> +       count =3D ref_tracker_dir_snprint(dir, buf, buf_size, NULL);
>         if (!count)
>                 goto free;
>         /* printk does not like big buffers, so we split it */
> diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
> index 8eac4f3d52547ccbaf9dcd09962ce80d26fbdff8..19bd42088434b661810082350=
a9d5afcbff6a88a
> 100644
> --- a/include/linux/ref_tracker.h
> +++ b/include/linux/ref_tracker.h
> @@ -46,7 +46,7 @@ void ref_tracker_dir_print_locked(struct ref_tracker_di=
r *dir,
>  void ref_tracker_dir_print(struct ref_tracker_dir *dir,
>                            unsigned int display_limit);
>=20
> -int ref_tracker_dir_snprint(struct ref_tracker_dir *dir, char *buf,
> size_t size);
> +int ref_tracker_dir_snprint(struct ref_tracker_dir *dir, char *buf,
> size_t size, size_t *needed);
>=20
>  int ref_tracker_alloc(struct ref_tracker_dir *dir,
>                       struct ref_tracker **trackerp, gfp_t gfp);
> @@ -77,7 +77,7 @@ static inline void ref_tracker_dir_print(struct
> ref_tracker_dir *dir,
>  }
>=20
>  static inline int ref_tracker_dir_snprint(struct ref_tracker_dir *dir,
> -                                         char *buf, size_t size)
> +                                         char *buf, size_t size,
> size_t *needed)
>  {
>         return 0;
>  }
> diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
> index cf5609b1ca79361763abe5a3a98484a3ee591ff2..d8d02dab7ce67caf91ae22f93=
91abe2c92481c7f
> 100644
> --- a/lib/ref_tracker.c
> +++ b/lib/ref_tracker.c
> @@ -65,6 +65,7 @@ ref_tracker_get_stats(struct ref_tracker_dir *dir,
> unsigned int limit)
>  struct ostream {
>         char *buf;
>         int size, used;
> +       size_t needed;
>  };
>=20
>  #define pr_ostream(stream, fmt, args...) \
> @@ -76,6 +77,7 @@ struct ostream {
>         } else { \
>                 int ret, len =3D _s->size - _s->used; \
>                 ret =3D snprintf(_s->buf + _s->used, len, pr_fmt(fmt), ##=
args); \
> +               _s->needed +=3D ret; \
>                 _s->used +=3D min(ret, len); \
>         } \
>  })
> @@ -141,7 +143,7 @@ void ref_tracker_dir_print(struct ref_tracker_dir *di=
r,
>  }
>  EXPORT_SYMBOL(ref_tracker_dir_print);
>=20
> -int ref_tracker_dir_snprint(struct ref_tracker_dir *dir, char *buf,
> size_t size)
> +int ref_tracker_dir_snprint(struct ref_tracker_dir *dir, char *buf,
> size_t size, size_t *needed)
>  {
>         struct ostream os =3D { .buf =3D buf, .size =3D size };
>         unsigned long flags;
> @@ -150,6 +152,8 @@ int ref_tracker_dir_snprint(struct ref_tracker_dir
> *dir, char *buf, size_t size)
>         __ref_tracker_dir_pr_ostream(dir, 16, &os);
>         spin_unlock_irqrestore(&dir->lock, flags);
>=20
> +       if (needed)
> +               *needed =3D os.needed;
>         return os.used;
>  }
>  EXPORT_SYMBOL(ref_tracker_dir_snprint);
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index ce4b01cc7aca15ddf74f4160580871868e693fb8..61ce889ab29c2b726eab064b0=
ecb39838db30229
> 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -1529,13 +1529,14 @@ struct ns_debug_net {
>         struct dentry *notrefcnt;
>  };
>=20
> -#define MAX_NS_DEBUG_BUFSIZE   (32 * PAGE_SIZE)
> +#define MAX_NS_DEBUG_BUFSIZE   (1 << 20)
>=20
>  static int
>  ns_debug_tracker_show(struct seq_file *f, void *v)
>  {
>         struct ref_tracker_dir *tracker =3D f->private;
>         int len, bufsize =3D PAGE_SIZE;
> +       size_t needed;
>         char *buf;
>=20
>         for (;;) {
> @@ -1543,12 +1544,12 @@ ns_debug_tracker_show(struct seq_file *f, void *v=
)
>                 if (!buf)
>                         return -ENOMEM;
>=20
> -               len =3D ref_tracker_dir_snprint(tracker, buf, bufsize);
> +               len =3D ref_tracker_dir_snprint(tracker, buf, bufsize, &n=
eeded);
>                 if (len < bufsize)
>                         break;
>=20
>                 kvfree(buf);
> -               bufsize *=3D 2;
> +               bufsize =3D round_up(needed, PAGE_SIZE);
>                 if (bufsize > MAX_NS_DEBUG_BUFSIZE)
>                         return -ENOBUFS;
>         }

--=20
Jeff Layton <jlayton@kernel.org>

