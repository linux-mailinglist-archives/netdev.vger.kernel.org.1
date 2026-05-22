Return-Path: <netdev+bounces-290656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEhlCwjLD2obPwYAu9opvQ
	(envelope-from <netdev+bounces-290656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:18:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 356DD5AE497
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAB16300F60D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5C32DCBF4;
	Fri, 22 May 2026 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tT6DMvI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46928313535
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419790; cv=pass; b=fdyTHw4BLKIRE0Fm3y3qQPVpvMngZ30kSDUNEEfxQ8oKCbkCaumK78ckmYV/PymcZmDbD9/n9/SFy6htPdt2jsucexA+LSe7Kj2t3PxpkilgdIl8u651Euj2C/FILc0MT3Tq8DJ7cS4cX8tij9uK816vjoDHTsSbOWl8g3zubDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419790; c=relaxed/simple;
	bh=zN8ioqqqheHAPLmA8puOf4xfsx474VJCIL9l5fVBl8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ5NH0d4n9cIyVOVoqRsg3Uo7MNjbSjc/K67ZWgUD0Y/66K/mHlBK8427y+ubHpcgnK+VornshIQ6JlXcLEDrK92pyqX5OKndTuhdgzfdogbahUcnThMjwUhQp6LwR/uUzxqZcYeUlZETVD8vHqfDUkK30TIu3ts/zWZefw1SbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tT6DMvI0; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1363e78746eso1681466c88.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779419788; cv=none;
        d=google.com; s=arc-20240605;
        b=NXEp/BQn5wbqH/DU31VjnweqAmblCJNQ/8ATq+20NJn6l1gGpr08lTWz/xbu2Wdm0B
         qAgHpA9jMV1UqiprY3XYLmy05KgtNGSO9WHzJ9rxOsrv9OPtYmH+mrsXV7L14ibsaEPd
         TV9r/143xevjWfpkl2Cgad53GymfPwbDkA2kNJNpyxXvQ5O1EMpVDXqYup6wWAdxhLJd
         yA13J+06TslggdesuqTR4p24mM3Qmq6FQmAMHtB7RYCY5u02fArhSasGnxf649WAuUy+
         nNLAA+HfTOyLwDQUo5ZVkJfnODgylZ6BlpIdVUxvcBcVlmns2Fe59Tpuc1KHK0m5yZLK
         fstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zN8ioqqqheHAPLmA8puOf4xfsx474VJCIL9l5fVBl8w=;
        fh=tZlyISpnbx4bBOivOjIU8SzRpFjELGXKCQT/j/+kynY=;
        b=PRYZMw4HgZJ9KPsWquPYFiDuXKW0R+GiwAT+986S2EfryvCn6GOdf/2MhDghbJZA23
         Q5NoI42xH+nnNkEd+KHtgcekQ+VRuFnr4+SRKdxxZvMnJ2Hdex4wQnpiKi+Q8/4PNuhU
         HNBMag0b99SYLJ06LqmHDuB2w3ZDI2H/REC/TIxLHLRWo3zxbRxXgYRJfDmLoa5XgJzY
         YiUjLafseeScwuhMLrTSYrr8bCYPjkhWSidosFt6RvArl+IZ6p7LedqW4Oo3It83KxDr
         POcy4wxbVsFaR3Hu7R7UEcvGQ8up6rEHZvbi3980P9AxCqW2hIiW4N+GFW2fAYhlxRnW
         NcoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779419788; x=1780024588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN8ioqqqheHAPLmA8puOf4xfsx474VJCIL9l5fVBl8w=;
        b=tT6DMvI0QeuqzxKZ4S7fqcqQ9ZbYzSykgN3B4pFUBvDHPmQ+fJ7bH87+N02htZIzjh
         NuYJAKlqR+37tMWcew4FYhVaLZJSD1DXRdTA8Q4sInL05OCJPUFxyM0FCqCHKZEkFafm
         w4VFer2SFK+MjVzFg3DQVL9mdLBrl42zDeji319xlBHMeHxBaWEY/x75H9R7CAKVkYAt
         RGl8LPu5Izi/Xthr0FBBvH68jlBfJw31E0NSPcbkx+bohXTHg5BzzysLFNF4fCRX+Su5
         c7LmJuOBXBsO0zV6Dag0PV6ZwRWcQpJ5GPppfrUvC/zTjxXkiBXSTAW7Jmr1CLqZKxlu
         SkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779419788; x=1780024588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zN8ioqqqheHAPLmA8puOf4xfsx474VJCIL9l5fVBl8w=;
        b=dkglVayky7E+TEl+zwV2JIbHVrq4nUjQyMzPqQHRvWwy2jFFmsGp/alWokcDE+y9g6
         PL+20feyjc8PWlSeBiwrCc9xWb/+kjl2GZoBNipuoRaLNOYRz8/HO2CliaDh3Q6Gp4JH
         QqfWnONv3NEzP0VJZWG4uPFu8iO+T/8M9L0nZS3Qsr6UMaztgUoOuicxu5BcwLhc+c34
         qnzroYts9Fq5bD3ELjSwShB0tepbL6B8SSyMWGrxuL7rB8FNba2gMGfutFSNDOGZkb3Z
         jczoUgK4+CrcBsUuO15IWmieB7cggC2Hrl9SqTqJumShad1t+0Qp5lbwVgk37Bgygqaz
         GOgg==
X-Forwarded-Encrypted: i=1; AFNElJ+h2TEHdqIeqm9Jp3JiFqFGAR/E5JhcvllQdff6Sy2N35MX+A99KNkpZYoO4R544YO5PMQitD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqq15jkrIG8vRs+D2b13i9TcYTEYm57I6cpN9GzR+9uDOv6EQp
	j/QCfhRtbb2eU8jnY1vgG49ED0AhOHSFefNMsIGKB325KCt+oZv3qoQH07av8mUziiz4enrVhNZ
	epKSbbyTPSuafDEsJ7YxrCUpm1A2ShyLgWG6fGjte
X-Gm-Gg: Acq92OGVUwxrEHw0XfFB7OTIosCwRenLjQbb97gQ1s3hp2VO2xV+CHLlAk2thCdcc+j
	0I/Vw6meizFVXfOoX6XoWLZE+SfEDeC1pQ/sDFoau7OXVW8+3rPIS0Vtli3BnTWGjJ8tcdOkSR2
	C7hFUTSEg6s1yTDsdIO8TeK1uJ0J4O7ZLXu+QyO+kBC2gfrYCR+ClzG5D1AYZ1UtqSv4TukuTRB
	wfpmKMs/BoMGuuKZYZWSujVWKPZhHHnwL7b/PsHWczaWBsmYR/wl27DpJgRy+TZYHyy4gg/tM3z
	75zzihU+T4WcOWXnEKgbYdicx7k6RTsem8DrlKGB0flIYMIDqQ2fJfWYCXMI/6o5L66eTgMIZmy
	YLO9W1H2Z9Egz/ds07VqXuMzHn6+3QdZXrYhaGUgGhICu/P+P33WkNntCvHO2KeM=
X-Received: by 2002:a05:7022:4393:b0:135:d76a:aedc with SMTP id
 a92af1059eb24-1365fb50bbdmr629900c88.33.1779419787496; Thu, 21 May 2026
 20:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520103227.1133277-1-edumazet@google.com> <20260520103227.1133277-2-edumazet@google.com>
In-Reply-To: <20260520103227.1133277-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 21 May 2026 20:16:16 -0700
X-Gm-Features: AVHnY4ITr-AmXCWcmYWY-wgIjZ0UAuRn17BmuH-iKATI7Wa6QGZXhZLAIfWect0
Message-ID: <CAAVpQUA93U15=dZMbcnLWD_vbNYp-x8v3dBmWh0OKN1_A0B-cg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-290656-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 356DD5AE497
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 3:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Avoid corrupting a netlink message and confuse user space in the
> very unlikely case rtnl_fill_prop_list was able to produce a very big
> nested element.
>
> This is extremely unlikely, because rtnl_prop_list_size()
> provisions nla_total_size(ALTIFNAMSIZ) per altname.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

