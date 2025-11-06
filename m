Return-Path: <netdev+bounces-236478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D56C3CD44
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B624268E5
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9834EEEA;
	Thu,  6 Nov 2025 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecr6jJ0W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053134EEFA
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449736; cv=none; b=ghTzB87IQA615zMUb6/pLIVC5VBEemsKmxtoeYfz2seeT8kHrrN+E++PH8jTQvT61PES6HwoRd570hyy1ThK0n5itSuqC0yQL8kPDYtyxQiiavw9YmAGet6OnRn9tjn0+cMO0B0zj6U3YplFAi5gu9TnNun0o8Msyy1OgMKWaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449736; c=relaxed/simple;
	bh=NH2hfHppCjrZFVx6eqpdpt03wHQYT9rQOCs3FER3WSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSckT8EAk0kxBYAz/8WvO1lkLJA+AYtKY6wwPpZ/6Pxs5aM3DL3s4GFJ54BDs6lUKUtnprR/oA0eh6IoNuZI7SPVJRz5fpZWE/Octp9/b53/dpYhO3sE1y4rsylNkhCxM29f7Rg00GEAh7z15qMdSJA/A+aShM6a5n28w0vMwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ecr6jJ0W; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1215921b3a.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762449734; x=1763054534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROsaoNagz4I7/dBZaDxwLj1TocAA02sCxxRugnpAtAU=;
        b=Ecr6jJ0W8ehZnjxendHBhQJfsVHKkFWKenIdwRgdz9sZSpKHp3m4xt0oaBey0du3GV
         o3m0440tVDT6tSEIlss0vsm95n9+DZ/bFOBMU1uQmmdEJ6ud9FXTifvYHplJ2lZfCDix
         BpxPGuWBKtCbAqZUoLJxHlucKwcl0zZf5naYzWEJ1adFu+NcJz3qUVTuOzZYamAGtbuX
         ANAdJKUloY/hwG4cwvlmVj53JopAth0/1Zp6/yUSnUlOcZ0D3gknYSVUl1HewPYiMxsl
         0A9hA/lCe0+6S0sAgVZ+G4PgelRxvADX+Lm0tX939d1gHdwfsWwMXjga3xVO5sHeapi0
         y9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449734; x=1763054534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROsaoNagz4I7/dBZaDxwLj1TocAA02sCxxRugnpAtAU=;
        b=u4knL0BK7Xq4MrrtW9pKTo2pwWTd8x3huS8QTrfGOCZxLgXhmcMEx+KN1hoqvdDAO9
         MSR0m3OI3vykORgb13Qal8ea13SN6JnkT1eg3mXMrf8nBFlRxNCcyACr3BS3KtQUcPPD
         7Gi+UL70K90akkFzmcAuF/KTqUT4F9WmKc+Eiotk5qAP6EB+dktZqric4wK+FK74xM9W
         PwGAqkrHe5hPPqcpIMJOggVHgGZbE8S52+by8TT8dKzxc0Jgz0uEsJ0WH5eUwl6LQ1jd
         jkIDMFRc09teCZtw9WcEwQIiCCZHCc5lV6PFS9v6hy84xwTW+MU+ww5jDHrDHvAn+yV6
         UpLg==
X-Gm-Message-State: AOJu0Yzf5O1qaplwaaubDJ8Ij6XAx5X6QbjjoboH1YKMs88LlI8jnj18
	HdqdQd9M2J+aExtpIEBRTWZcfZmfZUDocJUPRVcVnk9eD//oJXvtGpOsu7aDMLSCS1o/kM6LaZP
	CKRyN9W3jdUTlINTdpRwmf+mHdvojw5Y=
X-Gm-Gg: ASbGncuEbZBvlDrP6AGoxgxE+leWj48AgHhNFrTVBNuCVxHWZG66tGFh5aoWXYa/9Nz
	aT8454rMtEefcRn1K0PwiNri6SLMxWzvej9eEq7z/RJc7Pesvrimyxgjk4ZXmZIeeDBmaOEE662
	j0yTer5JulfJGyp++w+ZRCiBnrkSQRHp7XsyqqyEUMx0oFormjk7TftZ9xfc2RgXjJHC3Z/+Tlr
	JAX4AE7WKrYtp9/60SAxX+Jlq9GqP9m7I5HCwxuLlLflIID6dgD/efeg/zvDt+Gbksv0z+nxthC
	BYAhfRmqHa70qw22PxM=
X-Google-Smtp-Source: AGHT+IGhY0NYTXXkTu0P4tB4nC9X5IQVYEkg7KbXM/lxcc2ajgsNtrlqaMsuOSOOG/NPcl8ekPlhnRj1iJwQaZFqVyY=
X-Received: by 2002:a17:90b:2b44:b0:340:6f9c:b25b with SMTP id
 98e67ed59e1d1-341a6c4d3f4mr11082353a91.11.1762449734034; Thu, 06 Nov 2025
 09:22:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <56e8d1efe9c7d5db33b0c425bc4c1276a251923d.1761748557.git.lucien.xin@gmail.com>
 <989d3df8-52cf-41db-bb4c-44950a34ce89@redhat.com>
In-Reply-To: <989d3df8-52cf-41db-bb4c-44950a34ce89@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 6 Nov 2025 12:22:02 -0500
X-Gm-Features: AWmQ_blXBOK6Lm7J_4Le7zJYv7Rj5XNuyVIMzzqJ7AFvKAnEANk67rWLYRhV00Y
Message-ID: <CADvbK_eGPuueR7XL80eagkrAeJraKBMiTVrhiFb_wnTD+N7qVw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 14/15] quic: add frame encoder and decoder base
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 7:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/29/25 3:35 PM, Xin Long wrote:
> > +static void quic_frame_free(struct quic_frame *frame)
> > +{
> > +     struct quic_frame_frag *frag, *next;
> > +
> > +     if (!frame->type && frame->skb) { /* RX path frame with skb. */
>
> Are RX path frame with !skb expected/possible? such frames will be
> 'misinterpreted' as TX ones, specifically will do `kfree(frame->data)`
> which in turn could be a bad thing.
>
Yes, when generating and delivering an event to userspace, it
keeps the frame content into frame->data, instead of frame->skb.

There's no need check !frame->type for RX path,  and I will change it to:

        if (frame->skb) { /* For stream/crypto/dgram frames on RX. */
                kfree_skb(frame->skb);
                goto out;
        }

if skb is set, it will go kfree_skb(frame->skb), instead of kfree(frame->da=
ta).
Because if frame->skb is set, it only needs to do kfree_skb(frame->skb).

Thanks.
> Possibly add a WARN on such scenario?
>
> /P
>

