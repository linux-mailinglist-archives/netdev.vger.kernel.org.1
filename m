Return-Path: <netdev+bounces-196476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C202AD4EFB
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B023A3865
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36985241136;
	Wed, 11 Jun 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="X7gC7ug8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61CD227E89
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632275; cv=none; b=Kvd/ifblXhQ032DNbEYl8qzxO89yjiR6kHp6VXpyICvQ2jBWnt1ObnNiOv3MVJHLNK7yb2+/FONgQ3nDAwsRWid9D/tIK37w6BFOnefZhGoKiIkmt5hoCDvgrGgiHO6O6gPD6n3/vTyMTyJ80RPTbi5bD10zfvGkaitUad405HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632275; c=relaxed/simple;
	bh=PuA2ndzsf6qV8+DZjFJzpHjynq2dG7WznWmQHytru3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYIl+ATWcOCMRQ1FIqp8pmIiqetE258c04OafSMhiRpb9LKUB40Y8+I2AgqFVnrivu8CZZoHgZNgvOFav9fq2CLbRP+FKj+6WBB++rDcJLI5qTZeUhtho230NKCYVC/amo6KyIIoFEef+fO5Sq7njhAHfx/U95hZRDXF8PVtwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=X7gC7ug8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-703f3830906so243627b3.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1749632272; x=1750237072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjvJV8ZhcGRvupyFP8whmvE6fGj3kxjqSux4Bqr/JI4=;
        b=X7gC7ug8jA2cprDslC41cXhxHpfciejBoUgfTTdJWpwVEQngBHGA+pLPRZgiZJvvsX
         QJoU03RRxtlDmNThT3v5rg3701W9/aMyoRgzqA2gUVKnV5acMtrcnBsDmKGpEgZl4gtx
         HzHH+A/xn7NtHmKGXBp8q4uLPGs8u9NGNaba0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749632272; x=1750237072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjvJV8ZhcGRvupyFP8whmvE6fGj3kxjqSux4Bqr/JI4=;
        b=GxqevT6O3p2Qqn0RAGDIG8Yr4w/rI6MsCscrgoofy6KEVVWGT9x41r5+sTtkdrX9Jq
         lg4Lot/pkosEI/VC5XmoyG1oODhVVVwOcyhP2j3K2tAwV8hlLOe2+95V6ah6If+onLJm
         N1sTZVCwtrVOinIYKdFIn7p8u99hB7yGnjacRLCJXCyrLYeZU41RSJQmgVVo2v4icFIn
         2xqnUvzEn5uaz+YNuZMtgEYPNIdtHGYchflEqfA2gxJvOQ4VSdJ2WnTc1Mn7NNaDoYOU
         sQuMXHwfEedcatvaZXgFtq8usBnkOWIuS0KtN+Ye8Zyp4nYBrLsUfFEMCc7X1gRAgu3j
         B6pg==
X-Forwarded-Encrypted: i=1; AJvYcCUKDSYot8eRlAIBYbxFPNaHFoNltqSJGn0woetaswuyWz7j67ZiKsrfqfnmMyVe6SBN+Ki24Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOy4wtpEWJq74qMyts1Rx4UP7jUzO4WNxwDZxQOmVoIVzjrWp1
	c2YgNd1zIAGcxH57uT3hK9swnOJO2NSXbdyOLBWK3fO2a7KV2fHiu3qxEHKxh3j0xiFqd7IQAS2
	nBOILYIC2MI7vb/8/VfdiyLIYdiSPmnYech4Q15vhbo1in8AhS/bY86I=
X-Gm-Gg: ASbGncvNMncM/Tz7A3QzpXg3sMnW69ASajyULbZFZtzQB0r/e7kkUUCJiCvDRvL0j/G
	Ebz6W+ti9oCmCvcL8pALbNVYBw4YANGTYcyNEwOWy4jxkysKJF5WBVDr/kz0USPKTVGd5EehsLy
	/nz62TERzfAtl9I8fKq5+gQnTyyFmDq9bEICX/VBbH9l7t6DZ4hbD1R65x
X-Google-Smtp-Source: AGHT+IFFUX7swcm0JEVkBkoeXBxQqu33hMdHpH5TkNq62BrSmW92rmo/SE91S3zNAbTom0l5kxhyos7zTLCHUuzheJg=
X-Received: by 2002:a05:690c:3685:b0:70e:4cdc:6e7a with SMTP id
 00721157ae682-71140ae3679mr14818867b3.6.1749632272516; Wed, 11 Jun 2025
 01:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
 <20250609-sockmap-splice-v2-1-9c50645cfa32@datadoghq.com> <20250609122146.3e92eaef@kernel.org>
In-Reply-To: <20250609122146.3e92eaef@kernel.org>
From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Date: Wed, 11 Jun 2025 10:57:41 +0200
X-Gm-Features: AX0GCFthcjUN2-ZcbaCjBFu9eICTHSIis43T6ijos1tz5aAY4JHlgHWN205uMSw
Message-ID: <CALye=__1_5Zr99AEZhxXXBtzbTPDC_KEZz_WCDDavjwujECYtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] net: Add splice_read to prot
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 9:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
> Can we not override proto_ops in tcp_bpf for some specific reason?
> TLS does that, IIUC.

I see that TLS writes to sk->sk_socket->ops to override the proto_ops.
I added some prints to tcp_bpf_update_proto() but there I see that
sk->sk_socket is NULL in some code paths, like the one below.

 tcp_bpf_update_proto: restore 0 sk_prot 000000002cf13dcc sk_socket
0000000000000000
 CPU: 0 UID: 0 PID: 392 Comm: test_sockmap Not tainted
6.15.0-12313-g39e87f4ff7c3-dirty #77 PREEMPT(voluntary)
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x83/0xa0
  tcp_bpf_update_proto+0x116/0x790
  sock_map_link+0x425/0xdd0
  sock_map_update_common+0xb8/0x6a0
  bpf_sock_map_update+0x102/0x190
  bpf_prog_4d9ceaf804942d01_bpf_sockmap+0x79/0x81
  __cgroup_bpf_run_filter_sock_ops+0x1db/0x4b0
  tcp_init_transfer+0x852/0xc00
  tcp_rcv_state_process+0x3147/0x4b30
  tcp_child_process+0x346/0x8b0
  tcp_v4_rcv+0x1616/0x3e10
  ip_protocol_deliver_rcu+0x93/0x370
  ip_local_deliver_finish+0x29c/0x420
  ip_local_deliver+0x193/0x450
  ip_rcv+0x497/0x710
  __netif_receive_skb_one_core+0x164/0x1b0
  process_backlog+0x3a7/0x12b0
  __napi_poll.constprop.0+0xa0/0x440
  net_rx_action+0x8ce/0xca0
  handle_softirqs+0x1c3/0x7b0
  do_softirq+0xa5/0xd0

