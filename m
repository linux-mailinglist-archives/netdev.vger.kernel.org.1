Return-Path: <netdev+bounces-190821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AE3AB8FA9
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 21:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E73ABA97
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B63298CC6;
	Thu, 15 May 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpulemFz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49E1F4163
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335980; cv=none; b=GYdzqXb7Y3EUBfXPuYJSI7aqdog4DUAibLUCP5P5lE2E7LQctgmXYrbcNFMO9YmYEpgv0SYqsuN1ed3InV9rMeNCgzdPvUXjZBFC89glKDuYG92GuxpaOSboitTT1o9O79mOc0n+QO7Y+3O4rOS7t8QZoMkyKPH8rHIk4GwmaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335980; c=relaxed/simple;
	bh=M7AW3p8ZT74JJJ3KmrdQfiIWxSWVMOWlF7cPjCbzcAE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q//3IReYLXwCVSFjSPNJZcMgxdI8EbX+mkVqIpJDzwvRQS64mHD2V2faQPZDcATcZ9Lcmn2R//Z02Qw8CzhKYP+nzgtiy2V1/a64U9P9GKyp3zovuNekbncUWf29MD8wr6iCqsrjpj19SmzKQwHW/cfW9fUHj0721/VizjqMUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpulemFz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47698757053so17516391cf.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747335977; x=1747940777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31Mc7IErSOsq6mf6wvbGz+K9R8F7D3Am2o8t05lBhj0=;
        b=JpulemFzVluMUOhFdM2KU3r0UaLX/GWsSV/CPWbzZR4UZRnyh1OWe6ZaTrJ2fpIWi9
         eute3JV6TqS0k4aV5agZPsLpsb2AxItQNPaBDlp6rxwO2njH9gg+Jr/Ohccn4Gbk8n8u
         ovBEuErIph7whSm25T9ApAzb44BHd9VKeOnbxRelN0Zlxgn5Je/v8SIJc08Nl5RTQ/vz
         W/AolrWuxQweBbLycxulBA41j9yMFCtjw6GeU4ooehQ8lSE4xl+g99kYzHk+23sQ0Jup
         7EsPAGf7Be2KSRKsfRXJ9ue+JndEs2AkJZRvSFvzRsRVCCgmHRqnCsrHzBoSWZEP97WE
         wRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335977; x=1747940777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=31Mc7IErSOsq6mf6wvbGz+K9R8F7D3Am2o8t05lBhj0=;
        b=D/kWFatsr4RhJEvTQXse3jIRZ/G/PRESmFL9pDgkYBvv8kcZMV76hqzcYqVvgjbpRt
         xIf0Boo4yTE1xYQAd2KCC5xQdaCGAsbuFwMy+J58PLPNWxUo1mvpB5PDosxADP3ooAQP
         aDoux5W/CTu9yUSWFdKU92NhMzhAa5xOAvgv8ePnf9eC9Z8z685GhSX9DNTA/ApbLhot
         i7P1+SRlhHUwD51cseKMiIhznA58WKDkpYkUfAHHtOpVvrqyAU3ZYZ7lFSMBMJ9U12Od
         0FWY5Qyjf72dWunR3bh3wIHDWy2VpK9ymHmaI7oChtJamQHsDmcadOj3tXF2IgKagXt8
         NCRg==
X-Forwarded-Encrypted: i=1; AJvYcCUMc0a0hmJdv+wu/94YJEBk/OWo9miz4+5NAerZfHJ1yvvBbamsmwBL5dUaaveXQrb4L1wRw1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJOexmp9NDBxEjaO82Ulf3Yyc4+I+tO9Dxvde/mu9RiFjHXBB
	/t0X5aUuNLLASn4Phk9J9aZAtZAL/y9S4mOAPX7oYr72VsM1a77649Vc
X-Gm-Gg: ASbGncsC4vU2lnqpOlNOjO3kuY5z2GCXledULYZrYyVGkiwt66ihTiK29rUidDDhS+M
	Nfi/2R5Zj8L1VWNHeLMKOhYn5CYvPXldUecG1oJv6EsL17OIie+S2+w9onMusDSmdVqQVsTHr3h
	mHJqDPVw2oQG2hTIoeXF+cHIpEFiDrZopE7GzdQ3TpOO/xfiUm9vlkmI1ZOi7Hp7HXE3KZBCn9W
	UVE8J4s66K/oRmRNmIB0JN9hShd3722bJvkyeFUwEXp/F1QqZWvYxKPygELL2pr9PcePgIZLzbh
	w+nCDLJDq3JtDxqAOBytbg8OUZQ94myARbr7/pbXLJm4tC4yxtsrpxaSN0jRWPAmcPg+V3FewDc
	dlvnm0o9Q8TBt5Y70rhnktJA=
X-Google-Smtp-Source: AGHT+IEBHhrwJzUmi9i/5NPpvCiCy/Hm8ZR+M1r5jAEuw71R/vzVohV8qDYUaRzZSLkDQsoejzB15Q==
X-Received: by 2002:a05:622a:1c18:b0:481:3f7:f5cc with SMTP id d75a77b69052e-494ae4622dbmr6887971cf.34.1747335977027;
        Thu, 15 May 2025 12:06:17 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae3f8d11sm1577071cf.18.2025.05.15.12.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:06:16 -0700 (PDT)
Date: Thu, 15 May 2025 15:06:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <68263b2847600_25ebe52943d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514165226.40410-8-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
 <20250514165226.40410-8-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 7/9] af_unix: Inherit sk_flags at connect().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuniyuki Iwashima wrote:
> For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> are inherited from the parent listen()ing socket.
> =

> Currently, this inheritance happens at accept(), because these
> attributes were stored in sk->sk_socket->flags and the struct socket
> is not allocated until accept().
> =

> This leads to unintentional behaviour.
> =

> When a peer sends data to an embryo socket in the accept() queue,
> unix_maybe_add_creds() embeds credentials into the skb, even if
> neither the peer nor the listener has enabled these options.
> =

> If the option is enabled, the embryo socket receives the ancillary
> data after accept().  If not, the data is silently discarded.
> =

> This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but
> would not for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file
> descriptor was sent, it'd be game over.
> =

> To avoid this, we will need to preserve SOCK_PASSRIGHTS even on embryo
> sockets.
> =

> Commit aed6ecef55d7 ("af_unix: Save listener for embryo socket.")
> made it possible to access the parent's flags in sendmsg() via
> unix_sk(other)->listener->sk->sk_socket->flags, but this introduces
> an unnecessary condition that is irrelevant for most sockets,
> accept()ed sockets and clients.
> =

> Therefore, we moved SOCK_PASSXXX into struct sock.
> =

> Let=E2=80=99s inherit sk->sk_scm_recv_flags at connect() to avoid recei=
ving
> SCM_RIGHTS on embryo sockets created from a parent with SO_PASSRIGHTS=3D=
0.
> =

> Note that the parent socket is locked in connect() so we don't need
> READ_ONCE() for sk_scm_recv_flags.
> =

> Now, we can remove !other->sk_socket check in unix_maybe_add_creds()
> to avoid slow SOCK_PASS{CRED,PIDFD} handling for embryo sockets
> created from a parent with SO_PASS{CRED,PIDFD}=3D0.
> =

> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

