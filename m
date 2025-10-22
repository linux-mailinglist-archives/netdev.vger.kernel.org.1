Return-Path: <netdev+bounces-231558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D429BFA82E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68B63BAF08
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4482F616A;
	Wed, 22 Oct 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbKSnHJn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C32F49FC
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117748; cv=none; b=R4tMPmYPH5CX3tnbD9iwLVz9Up2B+0P3RsaCmG4qKvFoCREuwnGXcfGJQ9DRJVr4VT5THolJvfWQZEHGDhptEZ9CN2eIbsJOveqPYyA4lMIWegfHeUyxIajrq7gDv7yFJ/U3123K9DWiu1ySJn2aYno++yCF5GwpCHLdf53a1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117748; c=relaxed/simple;
	bh=TwvetbWdKUMVFU6QjT4CxeRWEq57eDBbx7k02Vd8Xwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iq3E5MVCuDFwM+wun7i0Imfqn1XYhRQiy0uCLCLJYTHRwCigyIqyWYd2PPClZ8C/NclNQ9DrbIqRHKdfKl+RuzWXfpsOMJvz2uPhxG1dwcwl6ygGiJsWGiRQ7p/UmhKi3LcKOWWu8f5skURuG7wVfTwog+vqJEiT1BZxqy3VXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sbKSnHJn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cdba2663dso539400a12.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 00:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761117746; x=1761722546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwvetbWdKUMVFU6QjT4CxeRWEq57eDBbx7k02Vd8Xwg=;
        b=sbKSnHJnGdnh+SChtyk2b/0waFj4rbMcqOv4ob03KHBOzUErCS4Bn3r1oF0OZBIRWV
         IKzKO7IrmChUpAXw+N8CYcCIKP4X5DzySIglYxMovlWcuTkByG5AZj4pXSxM/cTk32JT
         v/UjqrlTFvvK3IyNGByKQR/UdTXv5UOO440oqI6fcXsU1dFpNzWMRSGcDklEsMwpNDRC
         OdxGa0mksyoxyAupeIgNxQe5/nReB+PpBpnNsJw/OJDoctvGvimAWTPMuwgj52Lg/Buy
         NMeh5cXxKMhFS1xcQa2g7mprNs+WpcRpA1xi9/J12lTiEsqExqboyTYGRsE3+UXmAD/+
         g7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117746; x=1761722546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwvetbWdKUMVFU6QjT4CxeRWEq57eDBbx7k02Vd8Xwg=;
        b=YMetjH4woxKXR7FAbQ2c2SJCg1IRJqx/6dwmEZI3IbuPS/4941e/T7vozxx4GDVWgk
         zS5Ref28obStdCo4i31DUqJNQkcELkr8qBofLq+jJwqtfWTiTMk999CZ8ilUf6Oonn4J
         lolrgeKEtsScGsKSE+xuHoSSkvpbwJtPxjoJVdeXxPY6rCFjYsrRpbiB6TjDO14W9TxR
         gsuLkeSOdP58sQyPdlUXR9GKVhvyQybfLq4lcIT2eEbAo6oKf5/b2rA00DbtZmz6EEdd
         VVbix1clRlWzsdMzJs2Ad4FrYERvnBueF8UXOxwYrDFfiRCs2vNjvxumI7hAAj2AcXNR
         RYtg==
X-Forwarded-Encrypted: i=1; AJvYcCV1vEEfHYSePbb9+MBNRPh8/J9rOp7l78kg0Ee0I486M7bXJAmPAVzgyFNLbxKhTM5dKBsCakQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJo/+H5MMGbK0d1c4HWPNCrIrqVZA/vQ/P+k1ySv+CfQ1R6rXR
	b7ET3aqwfXYbsneuMPDrwroH5+H7pdeSupazsuFVDpenb6f7dHI2TxQ5pyS7z07AWr2gVYbmtr4
	zGTczmv2C55wQTP6/MZbx7ax8W2CT2tCUVQeqHFqZyXlYSDW1YMoCAcEK3m0=
X-Gm-Gg: ASbGncuwMpVuSlG8End+Dkuhfr/uz3RpLurloZ2mW0xp6FNE3JsSxDCU2do8qApus+n
	rbyAtydIlzrNbc/OxEDVV+0CM4zDUduPI+z1eHakGKOSPleULEJVDlhWBlhD9XyJf9F6EKCEeoi
	usk8h8aOHkd6qt/PYJ0mLShCLzaJtDXIAx9DPPk31BH55epiBEhrnlzNpAYJux1ayFjTui0Cs0q
	g7ChN3XEUYVA7Bf+a3B9KMOOtcXsHw0GHW0HcdSr45ds0PlkweTB0vHlt+7wj8gIK80oEO5+6zp
	S4Mma/ku0ju2hakZ+A==
X-Google-Smtp-Source: AGHT+IHFIZ0C34j+sahAzN6WmAzcBj8zZCC8xVi4muVmwKBX9i9JtWfdmefM51LsQSvwB9xwcIwZOiFOi/DKJceh1yw=
X-Received: by 2002:a17:903:8c6:b0:26d:353c:75cd with SMTP id
 d9443c01a7336-290c9cc30b8mr247581035ad.21.1761117745989; Wed, 22 Oct 2025
 00:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021195906.20389-1-adelodunolaoluwa.ref@yahoo.com> <20251021195906.20389-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251021195906.20389-1-adelodunolaoluwa@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 22 Oct 2025 00:22:14 -0700
X-Gm-Features: AS18NWDYOZ-Ja2ju3PTAqCAsY0yiy5CA_MHH0MVY47CpxTMi1dFAZm_Pu3fijwA
Message-ID: <CAAVpQUCqiTUQM6gfFE_qps19vcsE12QsMifzqPc19M_2arWtsQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: unix: remove outdated BSD behavior comment in unix_release_sock()
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:59=E2=80=AFPM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> Remove the long-standing comment in unix_release_sock() that described a
> behavioral difference between Linux and BSD regarding when ECONNRESET is
> sent to connected UNIX sockets upon closure.
>
> As confirmed by testing on macOS (similar to BSD behavior), ECONNRESET

I tested on FreeBSD and the behaviour was the same with macOS.

---8<---
$ qemu-system-x86_64 -drive file=3DFreeBSD-14.3-RELEASE-amd64.qcow2 \
-enable-kvm -cpu host -serial mon:stdio -nographic
...
root@freebsd:~ # uname -r
14.3-RELEASE
root@freebsd:~ # python a.py
test 1
b'hello'
b''
test 2
b''
b''
test 3
[Errno 54] Connection reset by peer
---8<---

> is only observed for SOCK_DGRAM sockets, not for SOCK_STREAM. Meanwhile,
> Linux already returns ECONNRESET in cases where a socket is closed with
> unread data or is not yet accept()ed. This means the previous comment no
> longer accurately describes current behavior and is misleading.
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>

The comment is outdated anyway, so

Link: https://lore.kernel.org/netdev/20251018235325.897059-1-kuniyu@google.=
com/
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

