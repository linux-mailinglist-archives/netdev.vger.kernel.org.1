Return-Path: <netdev+bounces-137467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688A69A68C8
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737A0B29550
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10FD1F12F6;
	Mon, 21 Oct 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNy8Cw1s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2D1EBFFC;
	Mon, 21 Oct 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514136; cv=none; b=tPG8uhXvzu5JbggnLcgib5B/pFWfzhhbLqlreUVoBCpfivDxL/fSNrRwT1a5jpQirinelThvOaTMiWKoGDy7IjDN830cJ8aDw0XU5AKP402qkrAgOyMziEkC5NKBQKvtYa18hatd4HZZSH00IqP+OksTR+QUAdEmIYQUKF/3T0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514136; c=relaxed/simple;
	bh=ryJesFhPuWpmoKJ2oG3ambIjEDeppljJufZmd9Iqq7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJKxMYXddIuDQW95YP17/J5aW0JySN1Pg1N0CanWZwxb8s02Wfqve6RyZzn4IdrTsIITJFe7d0kNd+MTr5l6O74uP9+RNhGUbgZCOHK5QUWXCfkFl7v9hWSRJgyk4J8t0XtaDIn7Z4X8SMhD3OsPTQpSJmXs2AL3TBDam6Ivbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNy8Cw1s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c805a0753so37211375ad.0;
        Mon, 21 Oct 2024 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514134; x=1730118934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8DKm0b75v2mFIzfoBXeqnQ9qh0nJB5sh3E9iN+6t+g=;
        b=bNy8Cw1sqIm69N1+sHJuBTeFam+//c3uXd+8rc65PgnVuCKSqcDPXYL1YqEUhiIEiH
         Ypd/xnecxfHRUcCNic69/5lx2L3ReB1t//7jFkCbBjhSjXVa1E4qZzy7sFqI97EQ9PuA
         yxGEcEPiXU8OAPyxRUoSiF4Q8k8G90xPTuQitC7hmpEKQ6gDMIHppIR1zM0eKj6GfaYY
         VR2qTAvcvXMgVRnqtGTsk45i9+g/h8oE8qdovqr5KfLcUD/0shZztl3pk0gaQikgMheh
         wbTV5mLnKXxTHQ3BqobLbPh9VZU3NUh5qpr3K8U5+SvWV5A7vfgHrsajMojah1UiyQQd
         Pzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514134; x=1730118934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8DKm0b75v2mFIzfoBXeqnQ9qh0nJB5sh3E9iN+6t+g=;
        b=uQKyDiphpEi5FBlxipBxsAIpG0hu9KB19FJ7ORSkEonYu79tgLO4xLs7Q/3Y3uUON7
         QN7oeJAkm7u0DlHMp8xVPs5YujONLLmBji8suKr/ZWztm1YMYYB/NLos6OcfLANqJWB1
         vUgGsbgiynGZYsjcWgswHOfsA7a33JdQCLqSsj1RVCY7Yt7HgKGZVN1qyVTuMwjqr6+9
         xgcXFSRqpedvL2OxWeH/RGGdvs4hk3jeLrmnJFDKsxZLUB1oqSkaGkSRNMQBwY5SvNj9
         jjmbarWeCWsW5kCp8x7dAnHbDheyb44E7loejuFP6yOVYUcJoFhJj8PAfdqGNCXejyER
         toQw==
X-Forwarded-Encrypted: i=1; AJvYcCW/G1o7d9pQFvNOH74Jxm9G4fbNmgukqcLwJn+XkwKYBW6dhLB4MaopBd5Y1XSbatR0QLNJN9UG@vger.kernel.org, AJvYcCWpIbV7r5rF7yTefi+oNgmif/IcyHXU4xzwaI5lriwk7EPlDqOyl5LoD9mah4vr6RTFch3uUTMKWTFcOzCB@vger.kernel.org, AJvYcCWrO3THSaFfkmSJyvbqZdmE8CREGOsI+25PYTg+sdvxewMD2xBituqjQ40rRsJVHdxkhqTPMmwTwwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFhvr5g/CF35VmCfFC1Q8iKRCL6xRmvrKtEmtJKk3xIiC8hHq4
	vzWz0/W4QtcfyVwBAYStXz5VqGoV+j3oMPEWh71eFv3K9fP12CrO
X-Google-Smtp-Source: AGHT+IElQp2jbvDwNPhXh8KEAqGQrnmUUZt2ln5wHHczzuKnRlmUEXTQ8p2RFA8arvER0DAUg18+Vw==
X-Received: by 2002:a17:902:e543:b0:20c:e65c:8c6c with SMTP id d9443c01a7336-20e5a75a817mr138288505ad.19.1729514133834;
        Mon, 21 Oct 2024 05:35:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de266sm24821415ad.210.2024.10.21.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:35:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A8139438F146; Mon, 21 Oct 2024 19:35:29 +0700 (WIB)
Date: Mon, 21 Oct 2024 19:35:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Breno Leitao <leitao@debian.org>, Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@meta.com, Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: Implement fault injection forcing skb
 reallocation
Message-ID: <ZxZKkY8U4jndx8no@archie.me>
References: <20241014135015.3506392-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BJ7jF2OE9XMZw2nO"
Content-Disposition: inline
In-Reply-To: <20241014135015.3506392-1-leitao@debian.org>


--BJ7jF2OE9XMZw2nO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 06:50:00AM -0700, Breno Leitao wrote:
> +  To select the interface to act on, write the network name to the follo=
wing file:
> +  `/sys/kernel/debug/fail_net_force_skb_realloc/devname`
"... write the network name to /sys/kernel/debug/fail_net_force_skb_realloc=
/devname."
> +  If this field is left empty (which is the default value), skb realloca=
tion
> +  will be forced on all network interfaces.
> +
> <snipped>...
> +- /sys/kernel/debug/fail_net_force_skb_realloc/devname:
> +
> +        Specifies the network interface on which to force SKB reallocati=
on.  If
> +        left empty, SKB reallocation will be applied to all network inte=
rfaces.
> +
> +        Example usage:
> +        # Force skb reallocation on eth0
> +        echo "eth0" > /sys/kernel/debug/fail_net_force_skb_realloc/devna=
me
> +
> +        # Clear the selection and force skb reallocation on all interfac=
es
> +        echo "" > /sys/kernel/debug/fail_net_force_skb_realloc/devname

The examples rendered as normal paragraph instead (and look like long-runni=
ng
sentences) so I wrap them in literal code blocks:

---- >8 ----
diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentat=
ion/fault-injection/fault-injection.rst
index bb19638d53171b..b2bf3afd16d144 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -243,12 +243,13 @@ configuration of fault-injection capabilities.
         Specifies the network interface on which to force SKB reallocation=
=2E  If
         left empty, SKB reallocation will be applied to all network interf=
aces.
=20
-        Example usage:
-        # Force skb reallocation on eth0
-        echo "eth0" > /sys/kernel/debug/fail_net_force_skb_realloc/devname
+        Example usage::
=20
-        # Clear the selection and force skb reallocation on all interfaces
-        echo "" > /sys/kernel/debug/fail_net_force_skb_realloc/devname
+          # Force skb reallocation on eth0
+          echo "eth0" > /sys/kernel/debug/fail_net_force_skb_realloc/devna=
me
+
+          # Clear the selection and force skb reallocation on all interfac=
es
+          echo "" > /sys/kernel/debug/fail_net_force_skb_realloc/devname
=20
 Boot option
 ^^^^^^^^^^^

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BJ7jF2OE9XMZw2nO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxZKjQAKCRD2uYlJVVFO
oytEAP9YGfemitFbC/0IE8EMIUwGjw3v2h/G+ciXGgCKgTo1FAD+K60aXWnG72RM
nv5CO9xfc9eGfkA4nyrWVrnDX5vS5Ag=
=5vQ6
-----END PGP SIGNATURE-----

--BJ7jF2OE9XMZw2nO--

