Return-Path: <netdev+bounces-232568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0BAC06A7E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43BAD560D1E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6834B31DDA9;
	Fri, 24 Oct 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1PzIkg9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5379255F31
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315162; cv=none; b=eR8uzGQsHYG1itx9WUTolwnomDyXaqnZDXPVwGD6wOtUY9OaxlnS7zK3/DXCm7kjRtolgQikuRS3rvoWesFqu2vkoEBgCjP4uusVEc+cSjudjMP9I3EvggDameTAT4Ws7w9m97fUS68TtzWVjLfUt9fpmW20MbEQSd+vsaqEqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315162; c=relaxed/simple;
	bh=OK9/lQOmRM72qgAim0TKGE3N+cKFv8A+be/fDyKb6aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baObsGsnMFQySY8nN/2H9bZFDSTsH7gOjTNrkRTx5b/fAZftB74XwSCAdQq+38tC8sML/DLjTwYkn2Fi3wjNRGRigaV1lv7Qy6gwo5Uhm/3KqBlrtq7PD/BGfElRHxXMRHbuyWe2Qv0CdHWKZGbqS9AG3J0f1tdcqMSglxajgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1PzIkg9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7930132f59aso2744334b3a.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761315160; x=1761919960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvyImBAdb6rXKYgmYW9JwwdeMZ17st++GDQENS3K4mQ=;
        b=W1PzIkg9+F8CQYiBGbdnB1XrOnPuHzB9XnG0HHqgswuIR97kSVmd4ameXsHAKKo9et
         GbDzWSYCp1z/vsVPItDaRzx0+EN//fjbUmOuny5JE3WhPcBEHcom1j4A48/qOto0BHTQ
         oIuVje2h1NJDTYbx7jj70ADd2IxpnX0ady2L3ZsX3BiUmAYKMhJU8aCmugMXW6szTnUG
         xp48aWgrScoJwc10VarwyGWtvGPZ0opM20Fp9zus6611Qh7WwPcSsBRvjt3OofCpZ/Fa
         uY+ye5B/r5em0DNC0EsEvioS9GKmqtn0t8/6vYB69Fcez2YsXnM3tCvMnRni3FN83Hr5
         Gkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315160; x=1761919960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvyImBAdb6rXKYgmYW9JwwdeMZ17st++GDQENS3K4mQ=;
        b=QLJ+tMT2jP4Ii0Ch7vM7NROhaQ/jUzJHDVag3twGBia4YuAgCyfTxqj41s+KEi+JHE
         WzGXaGlqcwn+86xyCMBzfntv6PprLJuJ7xg6XfSCJ5LtQJpjTE0sA7c08I3TdTDKX8RT
         Pcta662oo61C8QxEMI6t60fa0Iss00VoSnKFZet6lPfs2momWbucI26aTbr0pAZvljoE
         noEsqZJyafogXUS8bEmaSmpOcUzu/DcKPIPQHP118pAN6EL/tMWUPgedt9x1R1Dpehxx
         bD8Ajqb5q35yaO7dNoEy29WDcFLWGbCXcNMCKPp2Q4ILZAx/uaQF0B2RfX7doZxc2RcC
         jqUA==
X-Forwarded-Encrypted: i=1; AJvYcCWg1/KxmQhDN32HFejhnmPPkodkPAec+AtaCHcz6q7FzOfyxrK6fHDLz2xUkThOXY8ZdnRFTu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93X3VW39dHzdP9lkuyqr7Pq6GvBRG64lqGD1B83+ZoP8mXX+M
	cJpVGJJo6ilPywDTE6nZk7EFIgdMW+h8U9CAY9gImdWd2hzTgB24/qbrEQt5NIFoMvQ3kWhOciu
	YRsFL+yfhFtXm+RokOMHVN71ZKZIN30jN9pWG
X-Gm-Gg: ASbGncthcycXcftp9FsdzwHMrm6D2cXxqXuVaBEA0f6E4J1yg9IyzoSUPSri+LXvs9P
	KFrtHO/ExZ23Ydh58pN7rveqbcM5LFmSq6Nriu+UQxwQDr6n6dZRKFsL7jthdx8wuylTFp7Ivgd
	EyxY2rf5x9mvWrOSHmkC5LfLPQ+hPEtMZh0W0fk7HkmLAhiYVX6oKtNr48rORgaRstr0rJiAm+g
	noPhgigC1Zm0hzYpM1qnWVGUsNJ23PXNMdkhS0RdPr+/E2TIZt0HtlONtFKqcA=
X-Google-Smtp-Source: AGHT+IFaN08L/NgEjkp4mYFHtFOETY6D/Qz+y3hE+IbwqvPh2WW7tZVaAoUrWtZI8Phl20N2JUIHm7SzEnBJms27k90=
X-Received: by 2002:a17:903:1cb:b0:294:9476:494a with SMTP id
 d9443c01a7336-29494764a84mr4844805ad.56.1761315160051; Fri, 24 Oct 2025
 07:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-4-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-4-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 10:12:28 -0400
X-Gm-Features: AWmQ_bne-CfmcVyN7lDHoWatl9jmV41UsDq3Abt_8CRbX1OIxeer8YyCEVb3Eo4
Message-ID: <CADvbK_dWdj5WNWZ82WWCwie6SWidKoWzqWEpzLinm-186x6Tbw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/8] sctp: Don't call sk->sk_prot->init() in sctp_v[46]_create_accept_sk().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> sctp_accept() calls sctp_v[46]_create_accept_sk() to allocate a new
> socket and calls sctp_sock_migrate() to copy fields from the parent
> socket to the new socket.
>
> sctp_v[46]_create_accept_sk() calls sctp_init_sock() to initialise
> sctp_sock, but most fields are overwritten by sctp_copy_descendant()
> called from sctp_sock_migrate().
>
> Things done in sctp_init_sock() but not in sctp_sock_migrate() are
> the following:
>
>   1. Copy sk->sk_gso
>   2. Copy sk->sk_destruct (sctp_v6_init_sock())
>   3. Allocate sctp_sock.ep
>   4. Initialise sctp_sock.pd_lobby
>   5. Count sk_sockets_allocated_inc(), sock_prot_inuse_add(),
>      and SCTP_DBG_OBJCNT_INC()
>
> Let's do these in sctp_copy_sock() and sctp_sock_migrate() and avoid
> calling sk->sk_prot->init() in sctp_v[46]_create_accept_sk().
>
> Note that sk->sk_destruct is already copied in sctp_copy_sock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

