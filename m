Return-Path: <netdev+bounces-282562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDCXFoOm8mlTtQEAu9opvQ
	(envelope-from <netdev+bounces-282562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:46:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B246A49BD4B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC7D302A6D8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60842046BA;
	Thu, 30 Apr 2026 00:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMlund+d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8515B0EC
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510011; cv=pass; b=BI/EUjU0UZz6OnqVodERHl3t8fb78YjFhx4wpUmPPwWA3iUJSmNNeH4ruY1hbOLj6h4dynC/cC2EjM5KVidEelwR5h7ytiGgOkMc4Unypw5ZRqsU9/IwJxtxGLjyklza7UW1EZzT2Eg/++YJqhny9lA5Jzf8kbe+35URNEFitsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510011; c=relaxed/simple;
	bh=ul1Zy1snP6dGvbj0jfQTlj3grDtk6aI6ACOEOPqZJq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itVa6oGywz1TWZ8WwBHk2GtNtSc3WJCXlG2QF/jxyqlgZ23UeklF80YF1LgFG5kxZVf3vX1y5v35i6SmblzqHdkbGbU9uCcSbeSgft1atZS+zI8NKZzqzCQoUbf158cfV15/K4iEoNhUjjXzt9iqtRXWIH57hzFeXb8ccDck4jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMlund+d; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so5000a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 17:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777510009; cv=none;
        d=google.com; s=arc-20240605;
        b=RiFRRvxBODLUkoUAP0lqtWpDwErr9r1oHNDFL/ssFZ9svwrbbjl6PlsYIG+2+lo7db
         h505wnFbavIiffMbH6r1DihL7At4RGu9gWTRpS0sTOmzC2kiH27R5ZQRHjMHbMU23d0d
         /hz8/pFbdifqXSD81A7FOg7KVJgcbQ9nNxxKpmrScnNfOVCoXjliBLEhA7L8De/xJspN
         DGrlGw9066vDH3bJKvMgiN0yWAnBMLvjXM67kUZyZ1Y6dxpgziALcduw0DJT74UivvAD
         6a/DdOC8ySRJHyGiKYK225JU1k13T5+12g3PRA8GKDmoxeHu9EquJcZ0EKrFCjzzzsKi
         GvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ul1Zy1snP6dGvbj0jfQTlj3grDtk6aI6ACOEOPqZJq4=;
        fh=WM+p7m6qD8dL4gUTs9ervZuDZHN3nnjyV4oLV49L1Vo=;
        b=dsfwt9z/Kxv8BTN9/35jEZ7V/HBH5g12Q7vTeMdijTD7dc3N+xuQWtA3OI/QmVrTOP
         CckPx4GItbZFS7biaUa3NHvswdAHx9JLvFN7cPardCO2EZTds2eV9AsixunnvMTSKzDV
         0cHYOpzzz6bGY6849s6LKrkT0/lxsPd3NCXjKasF0p79xd6+3DuRnTBkmJHA1eB85A61
         cbU6SetwDOp6LXNgDKIYoTVZv08UY52t/2VwR9mw3xanjGK4fw5Hi/kRlSY4w1O9+WxM
         QTqF/BSbz0e9BcztR9PE76j9KyM5Dp11HqEdDjLRBq5BZe+BVT0ZMOrc/35zinis7LbK
         XipA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777510009; x=1778114809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul1Zy1snP6dGvbj0jfQTlj3grDtk6aI6ACOEOPqZJq4=;
        b=bMlund+dCH/jEfDzL3Phu0X0WowOt0DipoYdsHtuI/BUfOD7gHn5QAoL1ZjGSptDOd
         a3N+3x7k5FLGuCKcz3rLZxxHRirzQwT4lnhO8Xvl2HYBK4dSDF0fSl97Ucu3kzeKV669
         sywYJc0jkmnSiLMRTvroFN6v/dee6cyyIdFv5yOOXG8ipAFyNrgPILX0n1SXqwG6MoYE
         tlVH7xLI6EcSnN5/HBjEYKxQpjBeIFoAA01pv2q7LkzFCVuetyribbz3wIPxYkgCHDdc
         0VGV9TQhCfwF9DQ4uxyeqqeBpBsQvp01Ds5txMWOUVhxq48YQL6e6dkmc2XPvlpjO3rV
         Wehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777510009; x=1778114809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ul1Zy1snP6dGvbj0jfQTlj3grDtk6aI6ACOEOPqZJq4=;
        b=Brxtav7u6pkKoRI26ORoslwtEpfszhWDRb1jIRXn6bTD5h20VI3yX4rKlJ/DOpz6/Y
         SivcftvNsNk9lTF6l4WsobEOV73pRi9/mmI7cW39aebyI1hOYNEq4VnGoyJ2fqEHlm32
         JdCHAq83yWJc2zqq7d4ddnwyixc95oDb4UMMkmP5RuPGLqhf83ZuF7AtSoaPxWjAkjqS
         WdvjYJ1IR6GHxHnmPxjtmWtlGBaUulLR97l9gVtIqatowYKBDBzBgZk1yxNHJ5lku3s7
         +FKRxr6aBZ+ZuXKzaFuMWNZeMsKs/k8/kpstBBrkjzz9OnCuIX5muzElOaiB7hSRpDLM
         CBfg==
X-Forwarded-Encrypted: i=1; AFNElJ/tRBHd39/YCkPyDPbvPvc5tIGebxgUyN6E8H/9MYwepa9k/EvkIa/57iUsQ7vqb0r9bdlWM7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYx4SdyGG/IhQqqEJ8WtCcBtqN/8e0/qiBLQeMpKd4VjDYpYXU
	9tX+ilKT++t9Kke6X6sEa9mpiBdgREupP2GKGVSVVV9CmnvQXqSOJqyOU9/fyfEuzEdlF8ftLp1
	9eRYcAFkOrZpibs21/jdo9elFLLT5m7RoyOyGW8lp
X-Gm-Gg: AeBDieuk3/QucRXHjtKSIncmT4ktxC0ZyNQ1BTnS3eXxGMjELPMCTVpGS+6j3YwJErI
	AQNz6b8XxVUWQvIBlnpVv+LLQqvKqTz2ahw0MOCKRPXYB4AcaYemnJPfYf2DLel4GxAFZefePwb
	Wp/lnjzhiYwf0E8gn52HTJYsnqsjlEc9DjhNoFupRSV5vylGx6k5Ru4efOoN2cT/2oVNMk2j/w1
	Y8PWIPWmlcvDBaeY6hGSi1C4feuK0mqmzOdIkRDdIAOoZ+oKCmczArtnIHa1U5LC7+BJbM63535
	ybHST7PBGOuvxgZ0PDOo+uFfVjU2nZ0aiT/bIxtmzFu3/6CkGMSgaK97l0vp1BZPu2j6Bih2EnF
	p92HBLY47wBPUrONZI+eNY10w
X-Received: by 2002:aa7:d652:0:b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-67b4e8723ccmr24146a12.0.1777510008054; Wed, 29 Apr 2026
 17:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com> <20260428184631.40f1f1b7@kernel.org>
In-Reply-To: <20260428184631.40f1f1b7@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Wed, 29 Apr 2026 17:46:36 -0700
X-Gm-Features: AVHnY4Jy0fMk6_hGAzUjMixNh5ciOoMan99mjD7l3RRXz0YY4qnAzi7cmOjDKis
Message-ID: <CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B246A49BD4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282562-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 6:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 28 Apr 2026 22:44:34 +0000 Marc Harvey wrote:
> > Currently, there is no way to disable mlx5 vxlan offloading if vxlan
> > is enabled. We've (possibly) seen some minor udp rr and udp stream
> > regressions when enabling vxlan, and want a way to disable this
> > offloading. Also coupling vxlan offloading with vxlan enablement
> > generally limits the flexability of vxlan setups.
> >
> > Add a new config option for mlx5 vxlan offloading specifically, so
> > that users can use vxlan without automatically opting in to the
> > offloading.
> >
> > To keep the same behavior as before, the new config option is enabled
> > by default if vxlan is enabled.
>
> Can we delay init of whatever makes the device slow down until the
> first vxlan port is registered? A kconfig level optimization of this
> sort will have rather limited applicability.

There would still be the problem of wanting to use vxlan without vxlan
offload. Agree that a kconfig might not be ideal, but it is currently
guarded by a kconfig that offers no choice to opt out.

