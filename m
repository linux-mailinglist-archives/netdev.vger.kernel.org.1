Return-Path: <netdev+bounces-167509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38886A3A86C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6013B447C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB21BD017;
	Tue, 18 Feb 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dW6X0DGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC6B1AF0AE
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739909457; cv=none; b=FVD69V1wyv6u/V3nB3ZcvQ/BVdZQOM0wkGUZBaNP7Z+K/HPyd+Ta9mmDofzAhR2GnWy9FjcFC1Nn2ul2FiG/Rz94ZjdMmlvsuO7xYcx2QrRVuVb8ZwkFoXA4lOZHEELoqI7YJKuDR11bTHNKiCgWuI1xB5gKxXW8y9m9Nt3Z68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739909457; c=relaxed/simple;
	bh=s6pe+lxbDyzqtbrK2nqAP8STXo0k60i3ZO2QL5s3AgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pK9w/wReDqS87B1JWAzrz2lWDpULUtQAWJybEarXP/qfU++WAeES1w/q5BrSaG/ojdazzlHXO3MMHQ2ZKiUvfRYrvck/zUfGoOZDgS6sz42DQVJgxS0QdgFro8eTjsc8j8PbCjXgjy7UY970nM18GY3OkLCb+Umgd9dpyIZYdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dW6X0DGk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f6ca9a81so515495ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739909455; x=1740514255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6pe+lxbDyzqtbrK2nqAP8STXo0k60i3ZO2QL5s3AgY=;
        b=dW6X0DGkVo16cSedPrGRL1cnyNIcbOuPIs1ayBQTigw1RkKC7/QiwRp1GgFiEhb/26
         FGDC4xy/WMVmsa+uhPO+fqj1Qy/WAtkJXGKrf1e7KdN4vLyYUcDcVy9OPpbaQ/6R0NOb
         yWJNT2K9/IlMBLN/UeVpMQTKWaO4CFO7VOhUpjIqSoogQaBl8hODSxsE+4WOk5cglUXN
         yqaKBxLUrlbNcwNfOSBRaSC6Fxoo6JquockrGgoef9WEMOArS3ZfWWgBFzZATOrZntHx
         8Tx66+uLtnkdzglU+3i/OJsNUrR59bKT0Bt6azs8GknDBPjChZ4ae2Gav+NHGrT8ynjH
         HWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739909455; x=1740514255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6pe+lxbDyzqtbrK2nqAP8STXo0k60i3ZO2QL5s3AgY=;
        b=DFSlH+iJcaK3NLIFHfL+J8+VfrFHZ+ynMban4bbhIXwi863sPeYmwT0uXnJJlze02F
         zKu51U9A5BFmPA/+BAUCyjogDM6/FZj3RD061/Pl/ROmClnMtmfQdeBIlVeMYMJ6pv7t
         4KBNr1KRa/9OKrqsTF8j8Pii8ZU1c0QS/X69ICGbzrxfbmVzXMPGGzVVrphSNgdN2GPw
         4IBK3tHI3RoZqtaT0zI0dbD2urUND4R2af7nJ24J/VAyB8nbmRnF8HWnNfOs0y0Qv+bC
         zotn8F/Z+TdQlcrUcS4GdaihdlXf4eBS8SMn0dyylWjYK+OH7Ybu+Ov/JE5O7dfhhc20
         ttSA==
X-Gm-Message-State: AOJu0YwwypMwImVshkcNd5KLinJnHLiGUP1BzkI1l6eQGiT5Ogtw9V2k
	c2d1Thdg/4o2ZzZwlvJWEyY7R2pqcgPlISsArNsLdclXs3eJ1qDfhuBijwtV3h/lq7WAiiCgxq/
	cFgQj+Kr+IVm4sR9GV0Q9PXGm9NS7l1H4Jlzl
X-Gm-Gg: ASbGnctVuBmHvpDyYpMQtiPjTdnGUjdjViJS24wx7HUucU3EE/S06nJ+PkDzjp4ykCk
	P8pHJ3X+i03rsBEIq38VxBAFTq3qT2S/GU6rJXAXnQdzZkMnhuLy6uKfH5eZ2GNzgXVOXqc0MvS
	jMeOJ3gs/2+amE9ckemVRy2hGxFe4=
X-Google-Smtp-Source: AGHT+IHhpIDdNyf7Ek2lQ6gcKnJY379iotKfJoLoBRO9B1h5M+cx2GoHkc+dUi27t7J2NDucXOKPCMtFeCNT11NDT9U=
X-Received: by 2002:a17:902:ce81:b0:21c:e29:b20d with SMTP id
 d9443c01a7336-22174438be2mr300215ad.3.1739909455197; Tue, 18 Feb 2025
 12:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218194056.380647-1-sdf@fomichev.me>
In-Reply-To: <20250218194056.380647-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 18 Feb 2025 12:10:41 -0800
X-Gm-Features: AWEUYZl0QUP3urTrXxk-3ugKgOPqB8aTI2mbSiJOxbyTxCE6odBzjYztYoM6IFo
Message-ID: <CAHS8izP7fGd+6jvT7q1dRxfmRGbVSQwhwW=pFMpc21YtGqQm4A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: devmem: properly export MSG_CTRUNC to userspace
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, dsahern@kernel.org, horms@kernel.org, 
	willemb@google.com, kaiyuanz@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 11:40=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Currently, we report -ETOOSMALL (err) only on the first iteration
> (!sent). When we get put_cmsg error after a bunch of successful
> put_cmsg calls, we don't signal the error at all. This might be
> confusing on the userspace side which will see truncated CMSGs
> but no MSG_CTRUNC signal.
>
> Consider the following case:
> - sizeof(struct cmsghdr) =3D 16
> - sizeof(struct dmabuf_cmsg) =3D 24
> - total cmsg size (CMSG_LEN) =3D 40 (16+24)
>
> When calling recvmsg with msg_controllen=3D60, the userspace
> will receive two(!) dmabuf_cmsg(s), the first one will

The intended API in this scenario is that the user will receive *one*
dmabuf_cmgs. The kernel will consider that data in that frag to be
delivered to userspace, and subsequent recvmsg() calls will not
re-deliver that data. The next recvmsg() call will deliver the data
that we failed to put_cmsg() in the current call.

If you receive two dmabuf_cmsgs in this scenario, that is indeed a
bug. Exposing CMSG_CTRUNC could be a good fix. It may indicate to the
user "ignore the last cmsg we put, because it got truncated, and
you'll receive the full cmsg on the next recvmsg call". We do need to
update the docs for this I think.

However, I think a much much better fix is to modify put_cmsg() so
that we only get one dmabuf_cmsgs in this scenario, if possible. We
could add a strict flag to put_cmsg(). If (strict =3D=3D true &&
msg->controlllen < cmlen), we return an error instead of putting a
truncated cmsg, so that the user only sees one dmabuf_cmsg in this
scenario.

Is this doable?

--
Thanks,
Mina

