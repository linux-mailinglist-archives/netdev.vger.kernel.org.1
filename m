Return-Path: <netdev+bounces-275705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE88MV7+02lbpAcAu9opvQ
	(envelope-from <netdev+bounces-275705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:41:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EBD3A64EE
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59121301DAF2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D5393DDC;
	Mon,  6 Apr 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="bMVo7aU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC387390220
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500886; cv=none; b=QPQ1rP/KNmlLP/qrWpVC01f9mgbcX3lGSiWQv4Pg91ZisthcEZuTIdq+poxCCy66nD1dkKysWqXHnsOo7zrexiawbn7Wt6+pPUw6Spe+yql3/UWAD8UeeptwMZF3mUpvm6kTkARxk3dNd9Ufb01yf1usBIxV0Ca8r8B40Uo9vmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500886; c=relaxed/simple;
	bh=kyZtKgfDTMnWtgVFhQnsWqmq0e21Xma/ta0AOxW1IEk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LdMa5/OzIFa/qhcHVj5rLCfNidcuZhqeqKz0ddhT45JXJ2gql+GVVjQKI4UcMRRvCOhmXdMrKSEhCQat8o3ndGN1aOqrTJY3ndedmPnozib7UeBGXPrHQ2Bz+SrO3M+aGMAs4UdY4dyzVBzq+brZtr5shIie7/OUnMQNXb16TiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=bMVo7aU3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f97c626aaso709263466b.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1775500883; x=1776105683; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP/yvoRepvhIHG6haXf5odvDzcCl89qKQZxzI6ipHkE=;
        b=bMVo7aU3Al5MOyC/sYwZZOckhFsVuNKcmjyx9yNgnvTtPy1OmQtCf+57TnN8LUQW+b
         /Kvtt7u1MVKgd9UBJi536dkENnVKHU/bEu53nMh72D++SDDywuzSQc1IH0YbrDg3fUGu
         dEa02pXHKlJmuyjO5dsXuoT1FK7OXngIQCWjjQDFMOaBR4Tkys6qSILzK7fHaAjhooUj
         wZhq2BQu2XDvO3QURsPhM4r9jWhByAipwN9Q782cOihLYLoeZJ7kIrjF/1ZKYbsAeh1N
         C6ocApGWFszPRb8qzt9EdeCPmdNiX2fSYLGnnioQZZ5DIoeh4BZQsHdvFC6nwvulFuFs
         JJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500883; x=1776105683;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vP/yvoRepvhIHG6haXf5odvDzcCl89qKQZxzI6ipHkE=;
        b=YRZjnig7BJiJFFo4H9aJ8MTFhMe9m1UFaYek/e+Ya67mARbpAuGhzuqihJ11NUDwBP
         yqDnPFc5i8DQifWRlbmm35td1Y9MNNWIe5BPsX5u/yuXe+9s4mem1miEZmH7+aqYcKwF
         +mtbf4qXDTEnrU2noLJnRC6p/5LI+o7twr7HaDgejA3YATXazfaTKg/GQcB9HDMkla9M
         uC6Jnk17SSzcOzGiSaHFbqVzSE/AOZOjUR32C4VOrZdCiZ6TdmgROGb5vklPbARs1kuu
         imp8YspacHntl99aXL+7yS8BnK3pScj40nX1hIh0w1TCOrvJFj/1Y7U+0rtObKFhZ7xS
         4rRA==
X-Forwarded-Encrypted: i=1; AJvYcCWHZmzw+vsPUAmkoihPynGpie0xc0FjG2c4kE8lpL5VcYBcMu2QvRzlWLVVgZ/n0K90Rb5EqFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfHfvpFRJYU/lZ9vIJQELnMe2gC8tZnYlhi/or4aa1t3iI4sD
	/++G3v4GxW0Wl8ZoIBiB1tXXRORC8me/RNdDz7131r/rsXiqaoSKcr6QvPwLfRKmGvI=
X-Gm-Gg: AeBDiet3GqIgWT0zQkna9uMtFy7CJxK00tDgzEA3ee4aV+M0DVOZGv9MriMtncpWGC6
	KKLw2Sm7bxcUxzq1QbabUSYOnonGkrdNmnWVjSgiHzV9PlEzrO1GAyxvqGkJUDio8lr0vH3ekn5
	7nP7LUPk3jBdgHe454U4AAc5OduRvU+H5W6ut7Myxv2olRx/GnK7x6odvHw1Fsoud9J5M+i55Ro
	K9KXtWTd/Ai+kt4dFsdtLHLTY8oeEoUsWLaBxahHLFQCxUPbvNQSbnPJUtW7Gd8wUwFMS8Kr8cB
	0yyKPhYKnppaodIwErsXFRQXk8gA2I99f3AMw9GHgpenPUh3681R6At60J8uwIoKSyFE0mm9xka
	gNGZK27s1o8g/mY+MHGI64EmGa93BBPU+KnifuVanR+2mHW8lE9hLilKHrC63hNQR1+SjzPLaQh
	lxyC+k2jJXGd0gClErtdICZhREu88cKO2MTBjajQAFpzb+tZYkPhGGC0UC+BDLrKD+vUJqOUNNp
	HjHnxyWX6uexE8=
X-Received: by 2002:a17:907:3f90:b0:b98:482:8ed7 with SMTP id a640c23a62f3a-b9c679e1ec2mr638754966b.38.1775500882177;
        Mon, 06 Apr 2026 11:41:22 -0700 (PDT)
Received: from smtpclient.apple (83.10.27.44.ipv4.supernova.orange.pl. [83.10.27.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972181sm490323566b.8.2026.04.06.11.41.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:41:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [BUG] vsock: refcount_t saturation and OOM via buffer size
 invariant inversion
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <acuKUpZQq6z1DY_n@sgarzare-redhat>
Date: Mon, 6 Apr 2026 20:41:10 +0200
Cc: davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 John Villamil <john@doyensec.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <102981F1-2CAE-481F-8FAE-4F3085E25E89@doyensec.com>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
 <acuKUpZQq6z1DY_n@sgarzare-redhat>
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[doyensec.com,none];
	R_DKIM_ALLOW(-0.20)[doyensec.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[doyensec.com:+];
	TAGGED_FROM(0.00)[bounces-275705-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[doyensec.com:dkim,doyensec.com:email,doyensec.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28EBD3A64EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Stefano,

I like option 1 the most, as it is the most straightforward way to fix
the issue. I am including the patch below. This fixes the clamping
mismatch, but as you pointed out, it won't solve the root problem
regarding the issue to arbitrarily set a maximum buffer value.

Since VSOCK uses a unified buffer size rather than separating read and
write buffers like the core stack, introducing a vsock-specific sysctl
(e.g., net.vmw_vsock.buffer_max_size) seems the cleanest approach to me.
I was also considering net.core.wmem_max/rmem_max, but mapping to those
feels less natural.

If you agree with the vsock-specific sysctl, or have a different
suggestion, let me know and I will send a follow-up patch for that.
Thanks.

Best, Norbert

-- >8 --
=46rom f5d160167c862c7f2ad6e6a1d4181d01997b683a Mon Sep 17 00:00:00 2001
From: Norbert Szetei <norbert@doyensec.com>
Date: Mon, 6 Apr 2026 19:52:52 +0200
Subject: [PATCH] vsock: fix buffer size clamping order

In vsock_update_buffer_size(), the buffer size was being clamped to the
maximum first, and then to the minimum. If a user sets a minimum buffer
size larger than the maximum, the minimum check overrides the maximum
check, inverting the constraint.

This breaks the intended socket memory boundaries by allowing the
vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.

Fix this by checking the minimum first, and then the maximum. This
ensures the buffer size never exceeds the buffer_max_size.

Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
 net/vmw_vsock/af_vsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d912ed2f012a..08f4dfb9782c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1951,12 +1951,12 @@ static void vsock_update_buffer_size(struct =
vsock_sock *vsk,
     const struct vsock_transport *transport,
     u64 val)
 {
- if (val > vsk->buffer_max_size)
- val =3D vsk->buffer_max_size;
-
  if (val < vsk->buffer_min_size)
  val =3D vsk->buffer_min_size;
 + if (val > vsk->buffer_max_size)
+ val =3D vsk->buffer_max_size;
+
  if (val !=3D vsk->buffer_size &&
    transport && transport->notify_buffer_size)
  transport->notify_buffer_size(vsk, &val);
--=20
2.53.0

> On Mar 31, 2026, at 14:37, Stefano Garzarella <sgarzare@redhat.com> =
wrote:
>=20
> On Tue, Mar 24, 2026 at 06:28:12PM +0100, Norbert Szetei wrote:
>> Hello,
>>=20
>> we have discovered a bug in AF_VSOCK where an unprivileged user can =
bypass socket
>> memory constraints. This leads to refcount_t saturation and OOM. =
While
>> refcount_t prevents a true UAF by saturating, the resulting state =
triggers
>> kernel warnings and kernel panic, depending on the setup.
>>=20
>> In vsock_connectible_setsockopt(), the SO_VM_SOCKETS_BUFFER_MIN_SIZE =
and
>> SO_VM_SOCKETS_BUFFER_MAX_SIZE options are used to update the buffer's =
minimum
>> and maximum values independently.
>>=20
>> The vsock_update_buffer_size() function clamps the buffer size to the =
maximum
>> first, then the minimum:
>>=20
>> // =
https://github.com/torvalds/linux/blob/c369299895a591d96745d6492d4888259b0=
04a9e/net/vmw_vsock/af_vsock.c#L1950
>> if (val > vsk->buffer_max_size)
>> val =3D vsk->buffer_max_size;
>>=20
>> if (val < vsk->buffer_min_size)
>> val =3D vsk->buffer_min_size;
>>=20
>> vsk->buffer_size =3D val;
>>=20
>> By setting buffer_min_size to a large value, the second clamp =
overrides the
>> first, forcing vsk->buffer_size to exceed the intended maximum. The =
transport
>> layer then uses this value, allowing unbounded SKB allocation that =
saturates the
>> 32-bit sk_wmem_alloc refcount.
>>=20
>> The fix should ensure that SO_VM_SOCKETS_BUFFER_MIN_SIZE cannot be =
used to set a
>> value higher than the current buffer_max_size. Conversely,
>> SO_VM_SOCKETS_BUFFER_MAX_SIZE should not be allowed to be set lower =
than the
>> current buffer_min_size.
>=20
> Okay, but that wouldn't change much. As long as the user sets the =
maximum to match the minimum you set in the POC, it behaves exactly the =
same way, right?
>=20
> Maybe we should add a sysctl to set a global upper bound, but this is =
another problem, I agree that we should improve the kernel behavior =
around min/max.  I see 3 options:
>=20
> 1. Just invert the checks, fist check for min, then for max.
>=20
> 2. Simply adjust the min and max values so that they make sense. For =
example, if the minimum value being set is greater than the maximum, the =
kernel could adjust the maximum to the same value. However, this would =
not change the behavior of your POC.
>=20
> 3. Force the minimum to be less than or equal to the maximum. This, =
however, would require a certain order when setting the minimum and =
maximum, especially relative to the default. For example, if you =
increase the minimum beyond the default maximum, you must adjust the =
maximum first; conversely, if you want to set the maximum below the =
default minimum, you must adjust the minimum first.
>=20
> I'm more into 1 or 2. 3 IMO is too much.
>=20
> Do you want to send a patch?
>=20
> Thanks,
> Stefano



