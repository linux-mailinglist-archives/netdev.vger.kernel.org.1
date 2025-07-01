Return-Path: <netdev+bounces-203014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D10AF01B1
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6749E188249A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF41F1905;
	Tue,  1 Jul 2025 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGjFIWTq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7681DD529
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390453; cv=none; b=uyeujlpNLnhUAChnlh+oS2S2unBBgbnsLbCNEkP82xPX8UstdyqmLB5gWoLzOWkDs+9f+GNoGzGb7e+nCPv8hKt6wiTzXAn2Yi2U9uU9SJPe9yTnIHdYvTvzw5RSQjELInDd/QLgU9uMmViWQ1TbVS3CI74MTAxhadn3oYiLHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390453; c=relaxed/simple;
	bh=YtIpNltsU1T6ENOfW/WWBB2owbV9hnv2w6WtyE6PymU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIJxcpQNPqh8l6AB6dZ65a9kFBP76U2jGIt56Mo6Idcu1PGQuiExZtkjG5TuuBa0U34poBhnL4LIYVJ9Un/N9ndTB5jlRIey7RbgzF7TctUquk8KGOsi4cJGXV20tqAfgXnxW4C4Pk6pW8Qk5SGy/DO7XyNrz9uN4ZRXDq6Jcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGjFIWTq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31c84b8052so7142226a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751390451; x=1751995251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtIpNltsU1T6ENOfW/WWBB2owbV9hnv2w6WtyE6PymU=;
        b=qGjFIWTqNJH8qPKVSKZQKqhq9qQVtz0Lg7v9jXyJUJGIA/PVoI5yhD1l7IHxHE+7Rc
         Rk9R/XA1YoXXnVq+piFbT9cHD/WE/2CHkj+wTNBJeMQWF21zki94DE2phYHoDXUnQmfd
         hhhAnvWtUuOEAXNhRR/emgqNKZu+G43ETgHqfg/ssh1qSjHBArXDSReyuhvlxBBzA+69
         GHDuuz2OeWpyHvEiopkT2KOITOFOtNXYNH6Eb6h49msSbyVDH+L+XDDiec4E2zRrdbDR
         iSZqa59lAZLtsN8ARJhr0GJ+AT0hY8CSIDenMC/MNGrS/KXkYJ9l/e3/L/DhUdCmp3oe
         HeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751390451; x=1751995251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtIpNltsU1T6ENOfW/WWBB2owbV9hnv2w6WtyE6PymU=;
        b=Jy31qX34kBuau+xc7tlMA2biM7Pn47jhyYjQ/YD7agvwnksEfH/HCJm6zvEf760EF/
         ZHAkXfYv2ax/Fm00cctbDFkADxpde5YzMWXUsayFRDcseEhwaR0c2RNXKzLfft4224sq
         H4YI+gGBu7RGt0E3y8+RT0qlHBp8imut2Xaq/lmDrqa1l6u8cPPrkuutlctwJyWVAK+E
         wRNts2zBPLRkcPMdJJ9r9fXqyiNFDdwg4qcyS/b00OelkK7aTY1AtBCUxbakWz45/Ju7
         f6JCO5GK0Ca8K92LkPXwv/1PZ6DQvngl5IJi0UWwcNTbScasRU8/4wlXpZT6l2K0xgfQ
         Zh9g==
X-Forwarded-Encrypted: i=1; AJvYcCVgZ/9ghx/gDuRQ43KBLyzHqMebYYNeDvQeLOz6a/G43H3JCu/h9cpiuw44EME5W8xjD6+eMoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOSPLJAYJ9lbLsULnTBDefm6/ZofJyYWmPIoWsmxzR5T7wp82/
	tTcvWYpYmd0e6dHCMudHvMVFIHSRRxQRYrJwtScuDMo+kOwSGS/iTpgkhX1hYtu/0LA8KuLYLOX
	xDsdALYFYu8N814O+6qdDAKLSE5OClbnKsHugt0lY
X-Gm-Gg: ASbGncuLHWRUmBUBzEvjvW4cPHDO8M2mK3KNUUsyYqb1kddUJXJB6H40ElVMuECLX2y
	jbUZjfgwpXdwHuTVft0OIQsZ7birrNvvK36CfOZJKA2SlDc7LwaWa6o9TGAtjmyAlzFkrUHqa+t
	cW7ERkt8cU96gQaPzVtHgnLZue9/Vrj9+EJIgOIO/IyGVDaLJPNL0z4fHG97kupzwaqxFcjtpoE
	9UtNbI+mDo=
X-Google-Smtp-Source: AGHT+IH1dI2kJBHFzj9usRQqk/CPtOc3u2z5SlqrwUEZN8ve9DbedB7bMbZ2uO4unltY6TCzSz6V3mCY7L9eB3RD0/I=
X-Received: by 2002:a17:90b:1fc5:b0:311:ad7f:329c with SMTP id
 98e67ed59e1d1-318c92ec020mr30652120a91.18.1751390451071; Tue, 01 Jul 2025
 10:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701133006.812702-1-edumazet@google.com>
In-Reply-To: <20250701133006.812702-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 1 Jul 2025 10:20:37 -0700
X-Gm-Features: Ac12FXwg9xLLFzBoL2cXay4jogx6Rmikf83x1Ic51lpKsty8yCXiWCRJSH30cdA
Message-ID: <CAAVpQUAb62eubAvt=u9WMVv8W6XcxuQF58o+QJ3P=HoPdmoZAA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: acp_api: no longer acquire RTNL in tc_action_net_exit()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Vlad Buslov <vladbu@nvidia.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> tc_action_net_exit() got an rtnl exclusion in commit
> a159d3c4b829 ("net_sched: acquire RTNL in tc_action_net_exit()")
>
> Since then, commit 16af6067392c ("net: sched: implement reference
> counted action release") made this RTNL exclusion obsolete.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thank you!

