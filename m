Return-Path: <netdev+bounces-208980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE61B0DEBC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E057A713A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05C32EA754;
	Tue, 22 Jul 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLocIx/T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A32EA748
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194831; cv=none; b=s/5EVyDLpEVZJz1nlytxSETWMzINvbllOAGD2rBJJtE/yTmjJuwUcvK8E1yisA5Fxrw4ABh6lYuYhCA4S1lJYZizgr7Us+bYPElqY2r4HHmdMFhYwOaPuw75lDylH+3RQzgJzGkmu6rguIT2pSBkNu+VlIx7tyVEGOzkXs4Oxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194831; c=relaxed/simple;
	bh=1XuOmXMmaaWqnvpqCFWTGZCIySJ+eeucJi/seDLbNI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLzlfDn4W05JkKY7blQ0IMe/S1e3R2ddaV16WwTVJOwyE2Qzwuu20ZVA1R5uCSqbsBj/rWjkhH36gW1TL3Z9WD7JyM4/P2qn+rPA0iTtDTBFP3KCutdEInylNRcbYPJAS30Wr7KI6UxFK5xOBanX+touxMn1/f3P9DGEckpDg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLocIx/T; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab9ba884c6so69630971cf.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194829; x=1753799629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XuOmXMmaaWqnvpqCFWTGZCIySJ+eeucJi/seDLbNI8=;
        b=GLocIx/TNETMKHDgXLps1y/0xTwxSr7htq0UfhsD5A8Lh93DkCOuCMaOCoJdA76sya
         5gmRyqf44oPeZzGaSQf4vlaZpaULrqaK4yISNmv8p8UVVCxLNaMRyZdFWIlGs1oGXX2Q
         6es+qa+PU8LZeJJQc6R8+g+6SHwqyRS268SufdyNkV5IEzf+KLcRPDvDy75jXeg+lpX7
         2cY9kPYSbsnljl0hup8diYFXfVUnXhVQtfa69mfkZRvGziZiqcyHCeqXiEL/QPnfp+54
         cPUSKg77bcdtaSikQFQl7NE/VBis2Tz6ZSVytbu8lKx89ruOi4s6JfjNovdvJReSv+N3
         rjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194829; x=1753799629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XuOmXMmaaWqnvpqCFWTGZCIySJ+eeucJi/seDLbNI8=;
        b=QpMp1uxz09zExdnZxUCWQjyPz60YDy7mmF25XkII0MnxJNg7TlX9/7I8NM16vG1a6v
         BM69jqQlktLwDVx8mQzRvoo3u4Rd8siFPk+4VcZhBwdWIQr1eqiFBskun0mZgrjSZcHq
         EtvX33JrKpZJNy5LdTS8VqGDZX/ejAW9I62MT9EI/iPPTUh18ETrUD4KTFtMkoeEQXaf
         ZDnheR05vZwkzSFS1SxdayYQtvSfGThFjNk3LE1mo+Q8VrmKN+nziLDMP6rIdEft+p0V
         PJMVqXqRmx85ZJeekSesl4PzueAYxD5uwvpr+ZvBVYeJ4WneK7H6k3c0ITxl3c1Ybozk
         rhHw==
X-Forwarded-Encrypted: i=1; AJvYcCWx8vajoU7ma3R5YJC3SB8lnF5J11EzPnt6Tc0BWqDGRHd/ZhmRpBZGznyTcZdstUP5yCsVssc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwV9bV+ahrLJUSwiGszq48O8itvqaITC/RoGUEAcs7mk0VznA9
	zWpXZdbO0jlaE3w91h3rzsBoiZ1EuAGJe7TLvElizRi6ccBJ0Zk1jw/NQmfsCs7FC8nIpSk2St0
	VRUZpjg4xGIpSjl297XQ5QoZ+YKKIFBdEO47Gd0AP
X-Gm-Gg: ASbGnctwAwWkW69z8FXGlB2e3ExRDDI6GNFaitQkmA0IhXiFtaOHmcnHFcYTSm61jez
	CQg2dzwy0eYrFbfwqVLG+qjrGWF94CUO7TGL3SYOGK4TkPOe4iAC00Uyn0ihiNAdC7y49wvCkvW
	tLk47w8aww3MVb4R8LU2WkgqUxNOgxbV8O+xo2knaKtd50Th9zt9vC1t184NYNd1qQ2+fk3qonZ
	rqA1Q==
X-Google-Smtp-Source: AGHT+IE5/xC629Z41/ewG1rGRd/vRIyn4/fPdY4AoJKCJUc80AhvNP/9QCPniM9G42/4UNQXgbiL4QSwJejVESK33OU=
X-Received: by 2002:a05:622a:248e:b0:4aa:105c:a0d5 with SMTP id
 d75a77b69052e-4ae5b8c53e8mr53665791cf.16.1753194828653; Tue, 22 Jul 2025
 07:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-3-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:33:36 -0700
X-Gm-Features: Ac12FXxIYBSQCB7BH6twTSCxBz7O9cZS9s2CNGBOnfVcy_wDobXLwLt6phukhSA
Message-ID: <CANn89i+ju=N_JNoCqSMaa7eG-70aXk6ZuNGdjc39cpUFQVvhEQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 02/13] mptcp: Use tcp_under_memory_pressure()
 in mptcp_epollin_ready().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Some conditions used in mptcp_epollin_ready() are the same as
> tcp_under_memory_pressure().
>
> We will modify tcp_under_memory_pressure() in the later patch.
>
> Let's use tcp_under_memory_pressure() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

