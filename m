Return-Path: <netdev+bounces-142966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556289C0CFF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794A21C23860
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC302161E6;
	Thu,  7 Nov 2024 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xduqvc7e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2319146E;
	Thu,  7 Nov 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000967; cv=none; b=X2Wt2B9THlYTupi8VSA10EZTmhp0nrb2kHsdUuYMbD5COispmAWP/nrizOkurYu3dDNcUFa5JCct9f0h7O80bh1sa+adQa8+zmKZHcSg+OPfdSOptIF5yPbXllX1fszGk+qMzR9NlIJ6iWiaV9MG8+7ThJjmvxisciQ9u27HMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000967; c=relaxed/simple;
	bh=UKuYG8FwCoF6QshUo8ov5ArilZTdcaVcHFVwlxyNXm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru2DrRFXRX1jbTwEXfegFejCVrAaju8hFaB7KICmy2wv5+0KMxXZHry52yaIoo2PPAaGEWjUSqxR96ohcvr6AdfMTYs/Lszu2Ly9ZYo34OWIfm92rsGZQG1hBspXRtSGoz5++EofYp7rCmSlA6U0lzl8nWP/BcE2skMmykCpcvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xduqvc7e; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so944277a12.1;
        Thu, 07 Nov 2024 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731000965; x=1731605765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+BKvueAMurCuyYxOiQu6I3rkTTp3EWgPYTH4la0hQU=;
        b=Xduqvc7eUS89FCM9I3Nf5FN04havrVIqxJPtknOWX9N9UXJbyZ3Cd4fNi6QbUTDIsZ
         sXkw51Rfc4vjgzP3bSW6e1IqxbgMnbjsR5NOrDr71Z5JZL8DEZmOAGz4NHKb4q6UWsOD
         Pigm+2QXLIa2Lz2geVJ6QJEEEY0jmYzEkjNyBPU8jRI9OdbtRAoRfpa7q7XhP6miIa15
         xkJPfsNutQxhIMrJ7Rzz8I3+X8/2g9cWp0Uf8xxqNsKK8g+UI+zyK6bkr1tAO7HADgCb
         5CHqwWhdLRl9udQtr0d60Hf/F7tHfcTbDOIiv7eAdyRMHik37BnCdW0b0lK8l/3UmRZm
         fDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731000965; x=1731605765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+BKvueAMurCuyYxOiQu6I3rkTTp3EWgPYTH4la0hQU=;
        b=pGxtAHvfkrvzgJQVSrJj/BD3LK3ITFk7oK/h90hliQIF7Nuh9vRljVC1sUaPctOc+j
         600KTAYI01VtGCbHQCBqI0NwwVZkjMrCPESLQh0gcN9kFhGyKfvxN7shCTaz7plhyX6U
         F7HSQZd2mZg11Pm+gu9L6/rSK2RhAJmD5usVJ6Hqqk0DMt7GvbxgAl+iTr5wm6AbGRAp
         eigXg+4END6sbE0QdjsL0+vFXFedJnQoXVC1u7Et/ah4tamPZ1AUU6yjaMBw93jOcXdU
         Q+hS/Urgrt2hpvPrCuHwyPWCRmClLCLuUbOoFXsvIO3Tr5eEdt7WY3AC+XNvrUWjBYWt
         yZNA==
X-Forwarded-Encrypted: i=1; AJvYcCUGo+hwjfencijXUvP0zGD895BoJWjRnTKGJwIjhXZ9Dgq8+vEqYadMXPh7KEjdtv7HP8FUO5Oj@vger.kernel.org, AJvYcCWGC2JFee0G+XCQKgM0hxh14DQ4eHjdxJ/B5rV1+pUeKweLvpmbv+BrbcwXuK5NhEB3TiRrkoJlzatgjGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUq4FZCWrZU5e8pArgkoNKack+/QstohPXMAKz4a7JhTK5INmT
	ezcn7PN4Oo5myHcBzbhIah4eTlYu5WFzXeG4d7bnRs8o5S7admxHYbqvgptrsv+3T6i4BVMiFhd
	GhSCXovP4WOHCp2OPlh/q+gXyqt8=
X-Google-Smtp-Source: AGHT+IFHHsqtP1ozsre70rwHiZZJRlOml9ng0+oaLj617ngkIPN4BI70Dx9d93qcde0Zwp8covoqQhifviG9JAPqKoI=
X-Received: by 2002:a17:90b:3890:b0:2e2:ca4d:9164 with SMTP id
 98e67ed59e1d1-2e9b168241fmr9018a91.12.1731000965342; Thu, 07 Nov 2024
 09:36:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106-tcp-md5-diag-prep-v1-4-d62debf3dded@gmail.com> <20241107002133.56595-1-kuniyu@amazon.com>
In-Reply-To: <20241107002133.56595-1-kuniyu@amazon.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 7 Nov 2024 17:35:53 +0000
Message-ID: <CAJwJo6bnYm9cuJ=-xXw4n5dscq+CG4mpbtOc_vLMFmWKD2GD1g@mail.gmail.com>
Subject: Re: [PATCH net 4/6] net/diag: Always pre-allocate tcp_ulp info
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: devnull+0x7f454c46.gmail.com@kernel.org, borisp@nvidia.com, 
	colona@arista.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, geliang@kernel.org, horms@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Kuniyuki,

thanks for your review,

On Thu, 7 Nov 2024 at 00:21, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
> Date: Wed, 06 Nov 2024 18:10:17 +0000
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Currently there is a theoretical race between netlink one-socket dump
> > and allocating icsk->icsk_ulp_ops.
> >
> > Simplify the expectations by always allocating maximum tcp_ulp-info.
> > With the previous patch the typical netlink message allocation was
> > decreased for kernel replies on requests without idiag_ext flags,
> > so let's use it.
> >
>
> I think Fixes tag is needed.

Yeah, probably, wasn't sure if it's -stable material as I didn't
attempt to create a reproducer for this.

[..]
> > @@ -97,6 +97,53 @@ void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk)
> >  }
> >  EXPORT_SYMBOL_GPL(inet_diag_msg_common_fill);
> >
> > +static size_t tls_get_info_size(void)
> > +{
> > +     size_t size = 0;
> > +
> > +#ifdef CONFIG_TLS
> > +     size += nla_total_size(0) +             /* INET_ULP_INFO_TLS */
>
> It seems '\t' after '+' was converted to '\s' by copy-and-paste.

Thanks, will correct

[..]
> > +static size_t subflow_get_info_size(void)
> > +{
> > +     size_t size = 0;
> > +
> > +#ifdef CONFIG_MPTCP
> > +     size += nla_total_size(0) +     /* INET_ULP_INFO_MPTCP */
> > +             nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
> > +             nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
> > +             nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
> > +             nla_total_size_64bit(8) +       /* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
>
> While at it, let's adjust tabs to match with MPTCP_SUBFLOW_ATTR_MAP_SEQ.

Sure

[..]
> > +static size_t tcp_ulp_ops_size(void)
> > +{
> > +     size_t size = max(tls_get_info_size(), subflow_get_info_size());
> > +
> > +     return size + nla_total_size(0) + nla_total_size(TCP_ULP_NAME_MAX);
>
> Is nla_total_size(0) for INET_DIAG_ULP_INFO ?
>
> It would be better to break them down in the same format with comment
> like tls_get_info_size() and subflow_get_info_size().

Good idea! Will do in v2.

[..]

Thanks,
             Dmitry

