Return-Path: <netdev+bounces-268846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDrXFun/uWlBQQIAu9opvQ
	(envelope-from <netdev+bounces-268846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B02B4F5F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1B5D305595E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A42522D7B5;
	Wed, 18 Mar 2026 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I4GdSUq1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D215E8B
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797324; cv=pass; b=Q4/6As9G+JicJL5742YCH2JNd7uzERj/QMPewltVDPdTi6dUvByf9i8SYtjdu12N6FBhN/h3dmWSQOUYNFnCDKq6mHEI/0bmpIULNEEMZ//QtNaXC4FjXQBVjGSrLEizuETZSbiJRJ+uHcQcL532oCGuGJ0JRRXKX9delvy9jSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797324; c=relaxed/simple;
	bh=2V6jVvZ8DlZMKMdAwcrjn8MFYhru6PaNYU+Ll7okqFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awUptkPgFboePog+3KuQfRlpfC+N+hhmd62TAl/AzTFURPYcJxvCPwQt1heNbPYYx9kLV2H5pcUiMCChNbyhd8UW08t0nBm0DiX4ITg77YLKbLLoWw7mMZyKM+Vgm7G2H8Xd+AwUCptVuLnw64ZHzhJ9dzU0z97yOB0GwrCS/m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I4GdSUq1; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a871daa98fso47804955ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773797323; cv=none;
        d=google.com; s=arc-20240605;
        b=RMRiygT8fR/liPi5nMfQPTZrG4yC8LIkJa3iWEuYl/R03+o1756R2OKqQVjknscsSt
         t1U9EJfFhBfCPpMqxS/sEHMbM29EnHVOvHApurtuUxFeRKHXcvu9WUH1PDqmNfjkYJ6q
         GUhoN0+GFukPcKT0g8cORZ83GOPoTz5zCDYrYwaQTPNc2kyDRb3XUSrSqK9FApYFZr86
         67aGEjpZfjyf5R6WgJF8/btRB6nWthZAvPmW0uL/qZCDFkVV/Bz6SPnIsdM4un+T8Win
         10PyAqb8w5C5PvPUsXSqaS+ZozqZ5M6wF2DBBx7CxNkN0OYu9PWH1LgPeXX52zumY4eY
         qj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mn+do4vOB08303YGsDqP48zKyD6RFfKsS3ht+al/j4s=;
        fh=5qJtqIeWqTNLvQY9T8OUpqK/32w2gisfQvyf/wx18m0=;
        b=GGPLPx3vn5lhVD4fnAK7wouIOSN7KBlsZ04zGL4tO1Y3WIJ7J6FqBBpNM8Qu5PhUbI
         FyR3c3946cgO6hh/Nh/dYQ7s1YXG7qMfo9B3qoPkGP4Q5VM1jxAwMjfhcqKLPa+yElLq
         mLulDR0QzGFCMaANM6ZG+4wAXoqSfBA0kbSxQFc0/mxev4vTnL45vQWU8YY52HhsZuPN
         6I0EmUcgUjhZVOAYXOGT+PUE9i29sGvDcGJ4tkCOoBVuiY3IIhbsifT9BE0tjyfYP0w8
         EhcZDjfkoaDKKiu9Wwwh2z/bhwkCXmJ5TidcAk701OtXnuVCrUwT4kuwBgDXXWOSA53+
         Hg4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773797323; x=1774402123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn+do4vOB08303YGsDqP48zKyD6RFfKsS3ht+al/j4s=;
        b=I4GdSUq14LMm4VhAg/tLIBIycxMLnPi5Oc3flQnubWNSIZGKBgSNtvQOyW4PRjncDI
         +jh4I0r2+Oo5OuxI2Zp9+netTaeteAXECFiA4bJJ1d8GPV8QbnR70XBny2FJOw69Hjsq
         31q1nMshbbSL7LRC3Ywu2SZLvuTzvN0+xOcHY2mJ+XeCmoYDeNlxaPu584qpkkiVkrGM
         7Rt5m6WUX3ZUYU8M4IgEegRzBHe5WJGRtVR0SYKBzivWulfRqdPkXeG5ulxEKfDiV6ZR
         5piR3A377SMRDBDQ44XWqcCPI5DcJHXCXbNyv7+/l3Mk6KGgVgVxHFR2kPUsAYe9tk82
         PZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797323; x=1774402123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mn+do4vOB08303YGsDqP48zKyD6RFfKsS3ht+al/j4s=;
        b=DWtVRug5YfjPS6eiU3LsjZ++KBCiijDXyH6MpuAuNLIQ5SYTqWGkhfew2mlKZPPxJS
         DM/7IDtY0nLcMvSL5a9EwSGg9JmUfmSG2JRPrim1MUqhicDgoIpnYyUvCXwUJLKCfwy3
         DlKIZqxyt0vNLtvp8bwCAbkVGVLN6ZS5dXNwR9myAwAXSnptGrlMrDoaotDj9v08LVRD
         4az7AvK1qnOe4o/9+Z7lySK+PtRDeQ4m+L65O2dQM5+XroH2bjYEsfPo1yBZiv7Tl3Di
         bQBtcSQj+cXM4bRDIA5+x+edP6KCNEY28B8rrPkAlO9SvA7oTTdZ9AyVxfAYepJ6O9S4
         0K0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqh6I1dm1iHxVG8YkyCJkAs74cu47aRzqBgdIs2bYkDV67f2m8BT4CyS1fHNMrIzZ+LONZw3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyRsZwOljZR81f1TLw0S6/c4974Enx70l4GLCQUZxkfr1MI3g
	ijtBA8eGQ9Y4ErPBtFeMxTpxvan59nyLDcEkuk/biDWh0qqYObRYwzVrMv85z0oxH+36ZCYGNCi
	Z1xuOecL0/HRH6Qbz8HCUzOS5fpe8b3r++IU3t4/D
X-Gm-Gg: ATEYQzzHIyDx74g8Yr5cw+5WH2xdxiBsclgg1fJ9oG3/V6rMGmMkFuOZCOJKTyergS+
	S6RZKFjMTL0MqxBVqekHY9qgAqEOjW0YDRkQI6bNfE0JkK0sKXT96cgDXaGBxgy8DBc5TNobCRe
	glDWW6YjHX1bE8pffg0InfDyC7bypDW2385WYn2hbm2M0HlrkPq4X1MVmLlThKfKedWrKQFoY22
	mgCEPZRj4cbpLIgEiYObyKA16qNS59qeB/oMGfsFnM6FLXLmZu2uFtILjq2YYBtTs0HPQXxdrpp
	UpspA7x5kmC9GQ8g+g==
X-Received: by 2002:a17:903:a86:b0:2ae:80a3:ca7d with SMTP id
 d9443c01a7336-2b06e3f8b5dmr14388345ad.39.1773797322844; Tue, 17 Mar 2026
 18:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2697b9f672967b1318630f2ffa21914f@paul-moore.com> <20260317232041.330576-1-utilityemal77@gmail.com>
In-Reply-To: <20260317232041.330576-1-utilityemal77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Mar 2026 21:28:31 -0400
X-Gm-Features: AaiRm53h-GwzyyaZmhjSG7xFKi5WW3mgA9p3jsbpEqD6OVb1qbMfwU_zcGTi8w4
Message-ID: <CAHC9VhT+scwVSoMNBKgVMnTNdjP_qVSECScmd+i0M3vj-pM-RQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] lsm: Add LSM hook security_unix_find
To: Justin Suess <utilityemal77@gmail.com>
Cc: bigeasy@linutronix.de, brauner@kernel.org, demiobenour@gmail.com, 
	fahimitahera@gmail.com, gnoack3000@gmail.com, hi@alyssa.is, horms@kernel.org, 
	ivanov.mikhail1@huawei-partners.com, jannh@google.com, jmorris@namei.org, 
	john.johansen@canonical.com, konstantin.meskhidze@huawei.com, 
	kuniyu@google.com, linux-security-module@vger.kernel.org, m@maowtm.org, 
	matthieu@buffet.re, mic@digikod.net, netdev@vger.kernel.org, 
	samasth.norway.ananda@oracle.com, serge@hallyn.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268846-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmail.com,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,digikod.net,oracle.com,hallyn.com,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A50B02B4F5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 7:21=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> Paul,
>
> I updated the hook placement as per your suggestions. Moving the hook int=
o
> the block does require duplicate stubs, but I don't see another way to mo=
ve the
> stub into that block and properly handle the case where CONFIG_SECURITY_P=
ATH is
> defined but CONFIG_SECURITY_NETWORK isn't. If the stub is moved into that=
 #else
> block it will never be defined in that case.

Oof, yes, my apologies, I must have still been thinking about the
LSM_HOOK() change and didn't think through the problems with moving
the declaration.  If you aren't too upset about changing it back, I
would prefer it back the way you had it in security.h originally.

Sorry for the noise :/

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..3f8c23ad1199 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1641,6 +1641,14 @@ static inline int security_watch_key(struct key *k=
ey)
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_unix_stream_connect(struct sock *sock, struct sock *other, =
struct sock *newsk);
>  int security_unix_may_send(struct socket *sock,  struct socket *other);
> +#ifdef CONFIG_SECURITY_PATH
> +int security_unix_find(const struct path *path, struct sock *other, int =
flags);
> +#else /* CONFIG_SECURITY_PATH */
> +static inline int security_unix_find(const struct path *path, struct soc=
k *other, int flags)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_SECURITY_PATH */
>  int security_socket_create(int family, int type, int protocol, int kern)=
;
>  int security_socket_post_create(struct socket *sock, int family,
>                                 int type, int protocol, int kern);
> @@ -1712,6 +1720,11 @@ static inline int security_unix_may_send(struct so=
cket *sock,
>         return 0;
>  }
>
> +static inline int security_unix_find(const struct path *path, struct soc=
k *other, int flags)
> +{
> +       return 0;
> +}
> +

--=20
paul-moore.com

