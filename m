Return-Path: <netdev+bounces-266839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEDsBeIbsmnjIgAAu9opvQ
	(envelope-from <netdev+bounces-266839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:50:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C68426C053
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADFCC30557F9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0888375AD8;
	Thu, 12 Mar 2026 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/T4HfxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E534C9A3
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280154; cv=pass; b=UYGVKSnarajS6Vz8agCpiSj8+QtPET0VyYVl/o4z56oHsp6To2iA2+l0ENdHwR2c9HnKZD6jRlHT/9mMBCuTv9tVIlW96EJ0lp8LbchVlokjKXuz+fEyU1Z4vciDjChNJyTsqZthiRKrjFE7J2WdwKX+ivsW/afIQsWY/TX/HjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280154; c=relaxed/simple;
	bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qR/rZtSIQscelnnm7ULh2B2gSvNohI1LCuWcV6Zu+Ws2pouhWYe3hdLw3heUydDxNrVecPWUttH6fAuRop1g0NoXGOjnnu/C264TdJUGA4FXvbvvW6K76xuiA1Ew6CB3wJyriaNogfkanTPq9w9bq/oFeMoaN58smTt4mTrWp3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/T4HfxJ; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a747448dso4275201cf.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 18:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773280152; cv=none;
        d=google.com; s=arc-20240605;
        b=a4/fuQmZoxDrGe7e1C+P4HjPV+w5u81kbaEH+GIZd4zdTyzZS3COYMa16qKYupz6Me
         gwU//MCX56rhP3n21/yypzohMdAZysI/YfYnw2mSn75uMigikH2H3xCifuQ/YQG50ccl
         YH83J/su2vIDlz+MLf9nKfX6OqvxLr7ZTBuHs3Nzy+1qxft91WfU2UfPJLNcafK9YfsH
         rbPQ53qMV2A5c0FVZBejFFYxWBUOtrxD2mOttO+6pMhwevPvHPAv/HeBAwvufhD5YXF/
         jTPF1bnB5OSSUvZddCuvbnrXWVZln81BxoxIIAUrUpYW49yDjMX1ucGXm9MAHVteQ4LI
         GaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        fh=j7SpqaEc5gn5NLMfexUCWOcxL+5cq1Pog4u7oy77ZVE=;
        b=kteGYd8RsbTWOrD3dLA5IbxiPBByHAY0gAq8pokrEBwyF6HRGmk/nVfaYWPOZk5x75
         teNtQl18/GzNQr7K6mxenEn9hcpFol8vpuH+kIS6M2Z6gfUxEuBjMWOV0CZn3CobEkAF
         WVu8dvpv1JbKq6JaH0dAhskU2L9xz6yuT/q8HXilTxEvpi5VFXjH8PDV1NmCbBGqn0ur
         ZToGR3iUZq221qjiDy/tQJXl7U3/DXc9pCFviwQGjkCUxjMyFozvS2zgBrIg1leMyIkQ
         G85GpHzSFyvZdnExpPs25/6DG0/BBeMh60eemclYSvo7TAFIK5j0ufK05f1RE3Q930wg
         0rvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773280152; x=1773884952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        b=g/T4HfxJMQw5J3/IjSdky+zVHOmQsiCKoeovleUvx5h1ws9XT+AIGwoKgoBj+a42Oj
         CPNuouejDGtkNvppsigpAgK/YsDxUHQU9JHbs8bcXEf3feuFlxUkGTriWXeXuy1oJ1dV
         djrRDgmbUP79RQWKoIT+i3Pz2IpYxxM334cZBOzTaKiq4z9gdtmY/6se4G+bQcqkHyWd
         HmqRrq3yp5FK18ciETnIKTki+RA+gMRyWJteFhAUzW77kYRFMp9KkvDd9tsspUUm6wZL
         Zg0fvr9oOpuJcAblDYYO+GCiDiLkW2ZT1yiaBnsjGjl2nN6vsfxPU6Lc98Rx+EC3W8xL
         Ytxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773280152; x=1773884952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        b=CJOjVJFi4OOZc2M7OVGcAmb885F/7B4MzuGBteNpra4NE/zzfXvEaaZOqMF3hXYCLA
         +E5C0vKz2yUvr5D4aozwJD0upJgonivuaLuFTA2TMfTtzkVNUe0mlW7nw+L1JJXuJFym
         6b32KLjFsc0tetRYgzafOTfvsYmOydUBVgZUDH926Gr0/ORn23kEd3VzYpIcb9DqBJea
         JJGRK4GYrOlpPtg5mX6BlrHTRqGoV0bnnJ0el83mI8g7WfVWvDe/bXgyrpA0tz6muLLr
         whxLGIYjJOxlsYa0hLIYQd7a9Bcluyo9B0RTLDRXnvD2vbr4vOiMIbFEhjDT4BCBJS8+
         +oWA==
X-Forwarded-Encrypted: i=1; AJvYcCVF88KQQ23uw8mg8WyngiKwKedlmpXwZIqdpAaX9pzJpF41MeVFU0OhcdJS9Myv1UF6ZvgQ7A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ni0oU6r0E1wyglZObMQ9VL1CQGUNmOVrJUVM5TeCVU6DQsNg
	mws1Rt4XDSa59qOXRfLHR9QL7JFpSypDUoPZtuzCpQ1NSu/Z9gkofojpbQtgUlH7qCQK0ogXbid
	DTzWTJCl1mWYLVIwMbFaerYYoWx+yivPTGacwMe7X
X-Gm-Gg: ATEYQzxJshwk3rYE+7xzpJ4/+p5HEatjJowT0mJ9FXj2QtxB39pdj4PBQtSvCzmy+t/
	vExA9f7ffv+sqO9FzBrbFcj/SePJ5U3s/8pG/P0rn+d+ryX4nIjiVsS4GwjbVFJVy9sAhp6t7q0
	Bq7Hy8LdmI1zmI6NUyXGQayb69kPO08mVSBIlOhTOs8131MlVvFNBi4gJsYH2P+UsvxxFpqggw6
	rH2+mKvLX7RZy7d5EoP9OdcVHHNl+KS/V2e21Yamc5opA/O9ESy2x3ZVrFAotpc8wSrSbwAT5ee
	3rVi0Uc=
X-Received: by 2002:a05:622a:245:b0:509:16ba:d537 with SMTP id
 d75a77b69052e-50939fc6311mr62588591cf.19.1773280152190; Wed, 11 Mar 2026
 18:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311075600.948413-1-atwellwea@gmail.com> <CANn89i+dojcg=TDh6E1++g_TM7qdcpnyu47n2Q9DRW_w73TjzA@mail.gmail.com>
 <20260311174154.5fadb207@kernel.org>
In-Reply-To: <20260311174154.5fadb207@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 02:49:01 +0100
X-Gm-Features: AaiRm52zaoXRZHJbWhVYmknx0ZhJd77Ysbeej4LqlWfvsr4aOTCUEXNpCukM3UU
Message-ID: <CANn89i+8LBnbwGE+4qfXv3uKrwLXog1hXqabSK57dCABJ6Nx0w@mail.gmail.com>
Subject: Re: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across
 receive-memory decisions
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wesley Atwell <atwellwea@gmail.com>, Simon Baatz <gmbnomis@gmail.com>, davem@davemloft.net, 
	pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, kuniyu@google.com, horms@kernel.org, 
	geliang@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	0x7f454c46@gmail.com, linux-doc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,redhat.com,google.com,kernel.org,vger.kernel.org,lists.linux.dev,lwn.net,linuxfoundation.org,goodmis.org,efficios.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6C68426C053
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Mar 2026 09:34:32 +0100 Eric Dumazet wrote:
> > Your series will heavily conflict with Simon's one
> >
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1063486&s=
tate=3D%2A&archive=3Dboth
> >
> > I suggest you rebase/retest/resend after we merge it.
>
> Would it make sense to extend netdevsim and packetdrill to be able to
> exercise scaling ratio a little more? Having it optionally clone the
> skb and truesize +=3D X would be trivial. IDK how many bugs this would
> let us catch tho :(

Yes, I think we mentioned this at some point.
packetdrill uses tun device.
Adding a TUN ioctl() to control how many additional bytes are added to
skb->truesize after tun allocates an skb is doable.

