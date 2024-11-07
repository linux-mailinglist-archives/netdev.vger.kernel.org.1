Return-Path: <netdev+bounces-142972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9B59C0D2A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A781B21E76
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5925192B7F;
	Thu,  7 Nov 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIwlieGN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B641917E6;
	Thu,  7 Nov 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001598; cv=none; b=tPdxqYoLcMhaTYGpFyNCtQ48AHEoa6u7xkON2pAy0SguVYWKkHSr2pPKA14wWr43OGi6NBHBTt+m7wuiNAQK4icf5LjlYHMOQ3xRXwGQJ8lAkZX/+y3q9WnF6cMmlSBi2fObN6P/pRyu8S0zh855rVlpZ8QdoZoxRkRCBCtXMMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001598; c=relaxed/simple;
	bh=ZxzQ0We0q+DhXqbnl6jCcwR6CouP+vqd2q3mHq7HMuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP/frYNGSHyfu9z4sbclLG04fpGMuUIvwFEcmQv0FnLmHja1PVye7ATX2ZG4aPc7JDxfsaeujwPNgNbrg4WkvPHJ/5SoJQMYRfqZHU7g7YUwseGueG0qyWnmOHJ5u/IDoEGeD4G1z07QtRc552JnUWDl6lUspEc2i90S5yNCrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIwlieGN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2113da91b53so9656535ad.3;
        Thu, 07 Nov 2024 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001596; x=1731606396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oCDm5TkIQ8O2flDWJYV9Rk95Ql5sknkttmMph639aPA=;
        b=EIwlieGNnzGp9oY1x6sR3yWfZkHLd7v3SEhFQsZ0ExvOvIC36Ki31qsUrvWwGsOUId
         4y5PYL6YVi8UklQCi+OhmVomObzhMx0nFCdtqhLX/tbutX1ZC/9pe80zQFVlGxvcbqSC
         w0gdl7Hgavrc9iqjpxPYrk5VkmZN/9hPkGwHH1ubxAgY2GlG8nklYDbMPpvtu8xmZ1H/
         6gmhEE1uK3TAyvZyALnuYx3S5JHhfjGWIsFd+FpwN+3/FcdTLHZbqGBiR4xEaqCKCXpe
         toYOMsF0rOp3JqwW0zjrJLG2rb8nnxmtjZov3200mejr32F0CUlZfl+Tv1gqqr6OqWC6
         v9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001596; x=1731606396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCDm5TkIQ8O2flDWJYV9Rk95Ql5sknkttmMph639aPA=;
        b=W6C/WxXJ+1yUhTR2RFzjSq7VOVaa8xO+/+s055FVIOQzEt2Mg1XbsnBbVs0AOO6h/V
         gEmU/JwwXpi0l+u9LQ3xjZ/7qWiE77MMQ5+v3VJ7DvNzC7KzsUDlgMhYlqQg4ScRLOR/
         7rxdBoXajFJH/B5MvM2gWBpxzTfflqr/WS4IV1o/Yj9Lq0DET32foWccBPTOLs0Tpf6v
         Jai/QFxfwDQpbJjKPweOK7pEWJ6Q7+jD02Ak8lTZ6axO0+YIVHRvmgFyHzwkrbK2i90K
         GT1Er++SscRxCcCURaYGw7/wLWMO0ilfPWTzyTs7Cym6TUWq1LM1n4eULA/N15G9mchQ
         bkGg==
X-Forwarded-Encrypted: i=1; AJvYcCVFkrQp3jD2SuIrsJ/J+KPjmQUxAT+OxEARKRrGfL5gri14RtmH7PShU6HfNFVNMyD1WY/gwps9cIBgRnE=@vger.kernel.org, AJvYcCVsJUshWjrK4FkORu0avddltPimHKUd2oIDh/F9XiNpCjFDa//Xy35oFn/rh0lYjvbdc36VifG8@vger.kernel.org
X-Gm-Message-State: AOJu0YzVMVvbaVj1/8LfYwPL/csfgJZ+DMJ/5piY67gAGPYiDt4BOERN
	3Mk/yqK/a2dUoQlqLxylOIJz+1ZNGpcD7JHT18fyrOp66zlHzJFO68K/M4aASPLp9dJi9ZZ5Ea+
	Kt3uBBTzSsj3EKFAkS95ha93qyWQ=
X-Google-Smtp-Source: AGHT+IFS61YErhMGyE1e7CSJuHP5D8rTcf7usM+suyIOxoVkHE7OEYndNdtcdrJqPiyHkl23c5alRySs4G0b9f6FhnM=
X-Received: by 2002:a17:90b:17cb:b0:2e2:cef9:8f68 with SMTP id
 98e67ed59e1d1-2e9b16ee943mr34257a91.4.1731001596434; Thu, 07 Nov 2024
 09:46:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106-tcp-md5-diag-prep-v1-5-d62debf3dded@gmail.com> <20241107002555.57247-1-kuniyu@amazon.com>
In-Reply-To: <20241107002555.57247-1-kuniyu@amazon.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 7 Nov 2024 17:46:25 +0000
Message-ID: <CAJwJo6aB+GL2fiJDmm=zq_dNOu4pS_6c8NOgKzYgbiEG2e3xmQ@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net/diag: Limit TCP-MD5-diag array by max
 attribute length
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: devnull+0x7f454c46.gmail.com@kernel.org, borisp@nvidia.com, 
	colona@arista.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, geliang@kernel.org, horms@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 00:26, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
> Date: Wed, 06 Nov 2024 18:10:18 +0000
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Currently TCP-MD5 keys are dumped as an array of
> > (struct tcp_diag_md5sig). All the keys from a socket go
> > into the same netlink attribute. The maximum amount of TCP-MD5 keys on
> > any socket is limited by /proc/sys/net/core/optmem_max, which post
> > commit 4944566706b2 ("net: increase optmem_max default value") is now by
> > default 128 KB. With the help of selftest I've figured out that equals
> > to 963 keys, without user having to increase optmem_max:
> > > test_set_md5() [963/1024]: Cannot allocate memory
> >
> > The maximum length of nlattr is limited by typeof(nlattr::nla_len),
> > which is (U16_MAX - 1). When there are too many keys the array written
> > overflows the netlink attribute. Here is what one can see on a test,
> > with no adjustments to optmem_max defaults:
> >
> > > recv() = 65180
> > > socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
> > >      family: 2 state: 10 timer: 0 retrans: 0
> > >      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
> > >              attr type: 8 (5)
> > >              attr type: 15 (8)
> > >              attr type: 21 (12)
> > >              attr type: 22 (6)
> > >              attr type: 2 (252)
> > >              attr type: 18 (64804)
> > > recv() = 130680
> > > socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
> > >      family: 2 state: 10 timer: 0 retrans: 0
> > >      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
> > >              attr type: 8 (5)
> > >              attr type: 15 (8)
> > >              attr type: 21 (12)
> > >              attr type: 22 (6)
> > >              attr type: 2 (252)
> > >              attr type: 18 (64768)
> > >              attr type: 29555 (25966)
> > > recv() = 130680
> > > socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
> > >      family: 2 state: 10 timer: 0 retrans: 0
> > >      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
> > >              attr type: 8 (5)
> > >              attr type: 15 (8)
> > >              attr type: 21 (12)
> > >              attr type: 22 (6)
> > >              attr type: 2 (252)
> > >              attr type: 18 (64768)
> > >              attr type: 29555 (25966)
> > >              attr type: 8265 (8236)
> >
> > Here attribute type 18 is INET_DIAG_MD5SIG, the following nlattr types
> > are junk made of tcp_diag_md5sig's content.
> >
> > Here is the overflow of the nlattr size:
> > >>> hex(64768)
> > '0xfd00'
> > >>> hex(130300)
> > '0x1fcfc'
> >
> > Limit the size of (struct tcp_diag_md5sig) array in the netlink reply by
> > maximum attribute length. Not perfect as NLM_F_DUMP_INTR will be set on
> > the netlink header flags, but the userspace can differ if it's due to
> > inconsistency or due to maximum size of the netlink attribute.
> >
> > In a following patch set, I'm planning to address this and re-introduce
> > TCP-MD5-diag that actually works.
>
> Given the issue has not been reported so far (I think), we can wait for
> the series rather than backporting this.

Yeah, my concern is that ss or or other tools may interrupt the
md5keys from overflow as other netlink attributes and either show
non-meaningful things or even hide some socket information (as if an
attribute is met the second time, from what I read in ss code, it will
put the last met attribute of the same type over previous pointers and
print only that).

Regarding reports, one has to have U16_MAX / sizeof(struct
tcp_diag_md5sig) = 655 keys on a socket. Probably, not many people use
BGP with that many peers.

I'm fine moving that to later net-next patches; I've sent it only
because the above seemed concerning to me.

Thanks,
             Dmitry

