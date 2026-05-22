Return-Path: <netdev+bounces-290747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO9GIQMkEGqsUAYAu9opvQ
	(envelope-from <netdev+bounces-290747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:38:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E075B1504
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0140130736D6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540783BF667;
	Fri, 22 May 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGygzUI2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFAD3C1F2B
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442285; cv=pass; b=CieeoZmGz0HGcNgaHOWeeZae8b71SNzrILXKD7kehyk9vQv1I1w3M7GCymQmxd1AkumiQYucAEW+k+ldpW9EGEx7nPF+/F9I4SQawPgdNQW4MwU4p6EehkapR1lTfiqqbh1uZdXPJVIxfrEpWix6u00dW7J3dpqSyI1ZPDzLGD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442285; c=relaxed/simple;
	bh=r3oaHnLjPmtW4B4mvYScf58Ds3jatarNFYGgMSGxAuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSRHAIn/Tr/oO/8XwUVVnjiPU6F9VsEtjq3BY1JxwrVe3xE20PVOHgpOEo56g4TvmqK04L9cXOKnVIwtom5oMn50YV8lZAxtufyzmz7EP9CB61oOw0hiN74wSywDPzo7nJd/VcRshVgZgT0SA5QYR0PqKp04a9kUGtpNtGzIL8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGygzUI2; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-911dfc86903so829047085a.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779442283; cv=none;
        d=google.com; s=arc-20240605;
        b=RSD0WEbmAuMK60N9YG6pNE90DB6KZw5+axzH3q4vIAd3J4iQOYgmRn1BHK3LsE82Fg
         Fi+RhouH6QgO+7ks5Ca0cx6EZ1JdD2Fwh+p5ys8bBO1LX/pzgYuPvNTucmqp0CDYJyS6
         tfpRTSp/4u/0otfE/Ea7eoPsxHbo1HQrfXgfr7RJrrHFWzxVh+zJ0U4Uya/qaKqMOrPd
         4fpSHF4BkZHhgA60GnQFcLpDbjuULaWaDpTvYhEFe4zktusbs6iuWc3zq2/xQJ0laFhA
         fAneHHvvsU+WcI8//nNpQ1crLSo+jwi2BGhQifwlQU21yR9c3oYqLiU7a3mc2JQHaPxs
         i5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3oaHnLjPmtW4B4mvYScf58Ds3jatarNFYGgMSGxAuw=;
        fh=whUdV3FwO2jRyhQ/PXCmOtloXUQv+89ZrlC/6/dXcG8=;
        b=JBQ85rNZ8ovbXEM8YuHo1hG0BXAxLSkQdij1D97im/eH0QRXANsl2/rIcPbMKE4rAv
         qzztiTvTHrP7/tifeY6oALi4bGmHwif6LhefaOJTHn2LbycRa2Xn5wumMI795P7sMx14
         oL+D0Q8WA/iv+5ZIJl1mnir532WexGAqCxIPqA27WvApOVd3hWlZSLZ3NEI+RKUrds4c
         svUG8MZ2SEz+ZumeEv/t3h7XVMdhquzKhl3HF7BD0350FpHC/xe9n7ZHGgtv69oRvgN3
         T91+KgzYg+smnCQK1Gmxu4OHhbz1ZSW5MYzMV2Omj/r4eDL4eIFWzUzealcjUypxc7IY
         X6ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779442283; x=1780047083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3oaHnLjPmtW4B4mvYScf58Ds3jatarNFYGgMSGxAuw=;
        b=MGygzUI2WWYflIWOeTuWWo+W6AltEuO8WGkTLJsiEKYKhh2JZRs/Kz7U2HC6rseEvI
         0dp+QkINBDtTKVrAyAvR6PsC6bqrXHIiKGBWuUG424hzSs/K8VeoMdhcZbg4rSSnI4IE
         oxV+XOGCFQ+tYN7uq8jr91TE1zyJ8xIIIcE/+m6U3SkDi99i/jkZC0XNPQFarKRoQf7X
         mRJSPCEmasjy78r2timOoz/zuvUCKWw3EDtK0Y46nKBDeulQim4PFTSNnN7EqJO6oP/x
         cixWBNXRzWqg4jSQAihBS7+Hi0BIuVLyicX3rOgsY3co4sdGeRUYFiZtcy0Ww6xu4K89
         bvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779442283; x=1780047083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3oaHnLjPmtW4B4mvYScf58Ds3jatarNFYGgMSGxAuw=;
        b=qa87mPIAlahVNbfAd1kbRwuKrY1VVqVosueSsNUKu3EB0ZJXqcgsFAcslbBLOV2WOl
         yCOwCfjTK7SIqZMVPhT2wqNfOgO1rdoBkAOfOYUBUPgoGzX8pi9seVehmE83UfYSSVDN
         1tFmoOTtgo4qartEOCsPApvq8wW2C+0YsL87wSinDD9raiJ3+YRKkh95xju/Lo32uazs
         FtESc+0sfS2S3KCOK+hwCbIivZPtJhBCJZ21K7WfX1JNTHuc7Maoyj/5vEu1WL+Phmgr
         cOgvO2m7nb3TrcuXmkKSK6pNiRjQ42PrUTolklaM/mBGojqYL3E5wF3Bz4qeSCB2KQmK
         ZOFg==
X-Forwarded-Encrypted: i=1; AFNElJ/+MF2yb69YNoepdx82sMpisOPTVNdLiklR7sG136FV6PAiUC0hDultl5bN98b1oZJq7FAkSGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyzfKYoaw64UqGAZOeyeLRdLJX7nk7D1bo3vtYgYQtzVn93oqW
	q3VZnOaP1MjsdpcfEC5hjggPdf9dgR4o0FmSTZHmVEnF3h7jgC/QiI5vVsJCP6zBUtqCDjJp8Gc
	khVVLFAlk0Cr6XZjZ6tgIBhnAoWfujD2qUbr1NASX
X-Gm-Gg: Acq92OEhyWrYFkeQnkLQvw7roFynvrQ8WWqd5+Aeb8alU3+tjQxNZadvAvMfGlzZXQn
	mTdga3U62ygFe3L3ubGvvpgamNpgqJkceyI8DXqq5GqmLmd2NOzUufn7EeCYzb0IsXt5NAs7X4t
	Da084zEPrH+RWJQTwhbVlDbi/fGC3GsN4RtzPay1uPVriI866JnJLs4QjQNvi9t5tODfK3017vT
	dXMlwnwPCcoysVbKgvKCJMr5goi4wO5+yvnl1A7B7zMDi9DLJB0JPXoBpHOhkxX1u5BKAKuMMkx
	2CGbsZ9e0QtUrEODciAHrSJcBd6J1aNgLbCjs238+aMNKkhFsv2tgMW8BxHLHDBt7ZnKnd7JcFw
	RCUNa/YZTYp4MpwxnUIUh0/UaBa2zppRRZzMY9Ty1iwG9Quwu7oxtqrPPJmmyMm05
X-Received: by 2002:a05:620a:448e:b0:914:7b4f:cf6b with SMTP id
 af79cd13be357-914b49d868cmr394361585a.44.1779442281766; Fri, 22 May 2026
 02:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com> <20260522084538.GA829572@shredder>
In-Reply-To: <20260522084538.GA829572@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 May 2026 02:31:10 -0700
X-Gm-Features: AVHnY4L5TWm5uC53MfA8SK1d3SNt9l2TCrXGIu6b4Vb9t4iHKGSUnhwtsQHSCuk
Message-ID: <CANn89i+nANjb6=55WzGjBvc+sLyyZpxP3G8tXeNhMcHZq5w3ZA@mail.gmail.com>
Subject: Re: [PATCH net-next 00/11] bridge: prepare lockless
 br_port_fill_attrs() (I)
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-290747-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: F3E075B1504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 1:45=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Thu, May 21, 2026 at 01:19:05PM +0000, Eric Dumazet wrote:
> > medium-term goal is to allow "ip link show" dump commands to run withou=
t RTNL.
> >
> > This round of patches adds/fixes some lockess accesses in bridge.
> >
> > This is not complete, more patches will come later.
> >
> > Ultimately all changes to p->flags should use set_bit()/clear_bit().
>
> Thanks for the patches, Eric. I have two fixes [1][2] that I am planning
> to submit next week where I mention some of these issues. There might be
> a small conflict between both patchsets. I can review on Sunday unless
> it's critical to merge the set before that.
>
> [1] https://github.com/idosch/linux/commit/3350834468428df21c279acca1c37f=
67e68e1626.patch
> [2] https://github.com/idosch/linux/commit/dd63fb916cdeec9e69685726ef65a4=
0b57bd74fb.patch

No problem my series can wait!

