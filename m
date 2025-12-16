Return-Path: <netdev+bounces-244885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69C5CC0F35
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 06:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CB333116E1E
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E792C32FA2C;
	Tue, 16 Dec 2025 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AucSs3Na"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081832571B
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765858000; cv=none; b=hloVRK+sKUnSPYhYfxTXDFVW0wj5SZH9Xq1sQSJgl5wvEmCCs6HVRHI57/Cr+pCf2LzloW7aSXtboBLAgIDkMg5R4E+9sVa1a7UQKDnKcCNeLFDnyeSPd1PGBeChnUlSZxP3YpYcHTl/znOiZZ1KYyA4w5nEXS+0Unb7Uwr5gJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765858000; c=relaxed/simple;
	bh=xZP+twLprQv0K1+jd7CCaPFU8HDDQTV9yaiBXS7TugE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPZNJ2FO8jb/7G8a86wf5M/CV5kbNskQX+LkghzAV8XwwW9eFw8DLPHHp4+mC7TsJHdq8Wk52eRqqTiIxnGZeMuNKemc0959gda41i+xmcbASB1slnehu5//GP75l4u4Nu5bZKtMlpIqo3Rma6mxDYbsxwGJFZOOiRdEYe1iIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AucSs3Na; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so2831254f8f.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 20:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765857986; x=1766462786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNREp8PjCZDYXW0ypWF7XmSCt4g2PxdyE3cOeGMNSLU=;
        b=AucSs3NaTJ5MquLcknVxcgGMcylks8qEQfw2mGZXsOZ5wkRacinqBhG3sqYjY223JU
         dj4BhmXouprHVACvsU1m0hK1ZE9D6l9Y5kUhzTYC5/kZRbDwv+nE44KmnDwEF3FF2HGX
         3/ldc7+BGG6UWdSsITijgpn/k7p4ErjTsVIueyORoxxEiBXcSim6QEnnfimA9RjT/MAE
         5/99wryLio67kQN7sEQxVqngeD2LXANCZPOuald7vrgqs8sQzIIIaF9EWUyp5e25hbNJ
         wJsPoCj7Q3CTy19QXLnURi737JoqOoqetIdT5pK7ty8IE+cNleXTYuWMJ+WTvR+kbKKV
         6ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765857986; x=1766462786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNREp8PjCZDYXW0ypWF7XmSCt4g2PxdyE3cOeGMNSLU=;
        b=gESi3da4I5AEMG5nXs+RyB6aIwQ4Q8MkdYuBJJ1kOiDo4ON1MxeA+lmlCnBdS6oLNO
         vrOdzJDe8R9+iwqYH2VflNQGwZ7CXFhklpnq7M0F0Tb78lhgqqvNS/zq3SL4zNN5Ay77
         6fVaGohyEb2tl9yGm4eXki9xZOILNdtkwunCiqv35S+eketT56YUOo946+fVW+Yyw+iU
         bydH/cX6WtLBtPjuSS1hYyEwbBCKt67IBSY2joUwDWf3TvXQzonNG54TBan0OvHR6gGl
         VihrxDhUbCB41nmrHj5Vecrf2y8B6H7GtPYj9i+I2PjRTquCeKNmIsKaqxV7KRWbMXRn
         n0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVdIUzXoSI08GjJFAGv9CRqCEI2karu2FdPXK3ZQJwb9stkjI76KyEwwa+X5OfCF4kZk4wrSxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLxuHSl+LN5xWpjoN13IBItB+H9kYqjoqBpyCBJVRxx6W/Eas
	hV56VxJBHOnH6Sp4HvaRPriCx5IlgqUc/RV9r9vA3hQ1yYrTm3Ei9I3Za9oAAFwxA3XEuK+bl3o
	oz4gZE4+DAkBNajjH7lNrK8Sl4sqD6nU=
X-Gm-Gg: AY/fxX6drPHWIJmhSODKmUHWmzZC+shN6pCdbQfXN/Dc2QutS0kWWhwnkNCeH5JvVDP
	3xNpRlPKhe0JPjQ7C+TromaLBIaictzIUjrJJkmQZZorzpVbQY1l6Z2JHIINDqBdgacwUvv4nKh
	iYL2CYGKiVDWcva5rRETrR50zI+L+GrfdFRf/te6wUDEZSRVj/X01SgdW9tFk2VM53MwHgX7TZb
	CFF4vxjM3Bi+v/JhXq7SeFfSUCI/x/zy8VFHglTZokh8WZF5J505I1VMhHKCm/LELq41lHAzuIv
	aslrByRTGDEwHFc+SpfYZJeLmsPa
X-Google-Smtp-Source: AGHT+IGg4RK4X0c89fwbUT+qs3xmpvj/KNtnBvTxzR2P62xeszs879WnsX91nzMKck3SYSKeNjHGRHDKi90h0VTKDK8=
X-Received: by 2002:a05:6000:2204:b0:42b:3e60:18ba with SMTP id
 ffacd0b85a97d-42fb44d476bmr12637233f8f.8.1765857985995; Mon, 15 Dec 2025
 20:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69369331.a70a0220.38f243.009d.GAE@google.com> <20251216031018.1615363-1-donglaipang@126.com>
In-Reply-To: <20251216031018.1615363-1-donglaipang@126.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 20:06:14 -0800
X-Gm-Features: AQt7F2oZh6qLy-QoTQsJ9jl61alA3wGuYXO2YwKaufcqONhpSJo0ZebaOx98zgI
Message-ID: <CAADnVQJxso-6vnGDQQitqCjQQRjc4R09ofdFKroZLFtENJq4dw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix NULL deref in __list_del_clearprev for flush_node
To: donglaipang@126.com
Cc: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 7:14=E2=80=AFPM <donglaipang@126.com> wrote:
>
> From: DLpang <donglaipang@126.com>
>
> #syz test
>
> Hi,
>
> This patch fixes a NULL pointer dereference in the BPF subsystem that occ=
urs
> when __list_del_clearprev() is called on an already-cleared flush_node li=
st_head.
>
> The fix includes two parts:
> 1. Properly initialize the flush_node list_head during per-CPU bulk queue=
 allocation
>    using INIT_LIST_HEAD(&bq->flush_node)
> 2. Add defensive checks before calling __list_del_clearprev() to ensure t=
he node
>    is actually in the list by checking if (bq->flush_node.prev)
>
> According to the __list_del_clearprev documentation in include/linux/list=
.h,
> 'The code that uses this needs to check the node 'prev' pointer instead o=
f calling list_empty()'.
>
> This patch fixes the following syzbot-reported issue:
> https://syzkaller.appspot.com/bug?extid=3D2b3391f44313b3983e91
>
> Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2b3391f44313b3983e91
> Signed-off-by: DLpang <donglaipang@126.com>

If you're going to throw AI slop at us, please do your homework
and root cause the issue.
Nothing in this AI generated commit log explains the bug.

pw-bot: cr

