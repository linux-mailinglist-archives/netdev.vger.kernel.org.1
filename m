Return-Path: <netdev+bounces-187979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8394AAAE5B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3257AA4F7
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 02:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6338B4EE;
	Mon,  5 May 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="JE/2zT+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338FD2D47BB
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485625; cv=none; b=I8xqmtZzDWNenmUI+kdA/JotcJoJWDlnES1pE8qgYFZ0GF2sKSky/KEmWmY5wAjDC/DhKhNQs6jtMEwb16wtdePE3zp2WZyKlm6x7Jb1gGzYlRrM4S8VmIgpNcvn07EeQg/ZVimgg5Z+QLTMUlAHZ/VuFthXNYxXMPnmKIgDjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485625; c=relaxed/simple;
	bh=vtQJCct6hQsBhQdcgfNqlkz15EDdeFhIYhf9s6naFSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/a0UOFwISi1OSkW1p7LmkncDSMT1W5iob8J38NDF6ruYpyeg2wQ7xTz+3AWm5ImQmoT2PwNCmlRr9wsqAN/z2NoL3iFkVY0q1upesawTjp9DLxHTBKWs0lAgKWeP7XXY/2MNIR+ToMnG9r7ELZj7DEdBprp+z2VcBtzQtY6vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=JE/2zT+H; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BWIsDAIAABq4aX9t63Ep5DxcKnrpjYvMCl9JdFgagf0=; t=1746485624; x=1747349624; 
	b=JE/2zT+HifDxkOcG0kHx2TaNbLYNMjFkfHTAXcrj2pv9HyfOeIq3lThJJaGgrSmo7+aoMwOEYxw
	PdOYZbwlbZOSW11KNTof5zo2O8Azj0GFTzmeEwUzsb9bGnb2cXJSHfwAqhcedMYaITZ/spQUoBkTu
	V8SUENgZi/elsp/b86KepKVusUYtSTWhi8b0hu9/JUtmCrMNkx2x7e2kfEkwt+h8QB2rWD/gpY+62
	lIjJSk5+3sKxmuvMVFdod84Xf/OMZj4VZLQTEq5Fx5JdO/76+I+CfU3oUtV6X/qhfGijjkMKx7ZWj
	xo3lTjo6Pe3c1ou7f6B4Ksk/jP9l2PF6emUQ==;
Received: from mail-oo1-f53.google.com ([209.85.161.53]:43084)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uC4gv-0001Fs-Em
	for netdev@vger.kernel.org; Mon, 05 May 2025 15:53:42 -0700
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-601ad30bc0cso3716004eaf.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 15:53:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YxKaEpA0QBB2BpbmhGWLbc26irAewcBSLPJ79TbpGRr86snstZu
	szkNm+ljQ4eqvZ4xsd/gDIBchNWybYCdCqcYfUQsFHfbJpvtwV5055iKHnuw2nPWX/WcmAy49Le
	fuc2z09ozdgekcNeMvtUcDF5+NLc=
X-Google-Smtp-Source: AGHT+IH5xheY/a1uLcWmnbUZD7CuOUGKjtX6dr2NTu0PPIfMYE2qeTRaAk8HqGFr5ji8tp78h0eekx1GRDzq2Ycu7t0=
X-Received: by 2002:a05:6820:4086:b0:607:de46:fa94 with SMTP id
 006d021491bc7-6081da3a6b6mr957018eaf.4.1746485620916; Mon, 05 May 2025
 15:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-2-ouster@cs.stanford.edu> <7addde54-1b77-4376-b976-655a2776a31e@redhat.com>
In-Reply-To: <7addde54-1b77-4376-b976-655a2776a31e@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 5 May 2025 15:53:05 -0700
X-Gmail-Original-Message-ID: <CAGXJAmx8xGAn8GWNFZ6bw7z_5nCnzCLRHAhjaWM6W_Z91pNvzg@mail.gmail.com>
X-Gm-Features: ATxdqUEXtrBKNf-g_qLlfKo7ggKaP4AEromPPP-PksCQNByk5MZvbFTcbnE-KBU
Message-ID: <CAGXJAmx8xGAn8GWNFZ6bw7z_5nCnzCLRHAhjaWM6W_Z91pNvzg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 01/15] net: homa: define user-visible API for Homa
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 9dddbef7dbf47a29383c7a3c8e5dce6e

On Mon, May 5, 2025 at 1:03=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 5/3/25 1:37 AM, John Ousterhout wrote:
> > +/* Flag bits for homa_sendmsg_args.flags (see man page for documentati=
on):
> > + */
> > +#define HOMA_SENDMSG_PRIVATE       0x01
> > +#define HOMA_SENDMSG_NONBLOCKING   0x02
>
> It's unclear why you need to define a new mechanism instead of using
> MSG_DONTWAIT. This is possibly not needed and deserves at least a good
> motivation in the patch introducing it.

I'm not sure why that flag still exists (or HOMA_RECVMSG_NONBLOCKING
either), since Homa supports MSG_DONTWAIT and that seems to provide
the same functionality. Maybe these are leftover from earlier Homa
versions that weren't layered on sendmsg and recvmsg.

I have removed both HOMA_SENDMSG_NONBLOCKING and HOMA_RECVMSG_NONBLOCKING.

-John-

