Return-Path: <netdev+bounces-236465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3168C3C86D
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6113434A910
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF6258CDF;
	Thu,  6 Nov 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ8O/Vuq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0315287518
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447263; cv=none; b=T/rvKI9EQ+rKDOn3n06QwOvOZIR0SZen4IMF9c+alvKFYFrBkdW+cfAkqPjTh45gFWWhmR5fXg/ZmHGwFJZ85kE+IweZscyXdUn3AQ7ap/OMTRdo6hWS2rcyZvb2uZiIdDP5W8DDONO6eDuimo6pRko6jnDHJ2dejQncY5q+0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447263; c=relaxed/simple;
	bh=TBcIWrbd4TaZLgB/ZJb6p325CdBt3uGaZyZ9kmR9+1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbwDbt0KTjygZ7hpIH9qDMT7FzYO6X+bhMyp7XRWqxb6e0eRhXz2cc8I3dH7OyIA/LHg//iU+EEvT8dxa7YtUSqUwqWgxwPjRZsGndatnjQI+25Q9BrcYVSM7xUCaPunGBaaVZ8xjNC8Iq1N48NzGfZ12XeD9+afJzpEjg5KDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ8O/Vuq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso1042103a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762447261; x=1763052061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvC8dwzzaWG4yq5+kQqkL0SJpAh/HOeEJ2LSeIlJuUc=;
        b=KJ8O/VuqOigHSLXYo0itTJT+08xhB7eilnKIW8TLxrADXPJZrbq50fkH1jQ92qCbhb
         s4QHzHQ7kbgFM3CfcCWjC/blGi8v7a0OMx4oq8DeEg1ac0oPMUVb82Pl/5XzPAzrx79r
         Nsl2ZQ+G/HNaI5xzZupMS+k/0R/hZEplRvm2OBuLvSD0UnCNeOtJQ7y7PCS1Bsfu1UeL
         /5k3+yEGfvb110IhM/1eautmp2m5dfmGkAkPBqQkVfyBnMPzH/UY6m4fSScsaQPyRj+v
         XecbB0WFiErmYJnuE8U/aT+NCMWiT8GA5nyfR2BHgRY2tsxLqqcGlrAGezkNLNG8FaLI
         +M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447261; x=1763052061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvC8dwzzaWG4yq5+kQqkL0SJpAh/HOeEJ2LSeIlJuUc=;
        b=q9d2+hQqwCZfpuiHJv++S8G7gch8MsSDkS3dgagIo2BDxF8Ahf2KQ54O6hOFKlafZt
         9nvJZGB7Mvi19gQHMAN9nMAstwnsTsAsJGR6aIWD4Qxi0KTW8yWPcHVITGdFwhe8R0r+
         NXJ9TubBcxUZXqJes2HyRg8LprcI6kCGwLPxwkZyU/RyVVYnJh5rGGCkNv18/YbXiojd
         ydzwXq3UKddYaDupisccF3jbHk+h93HgGhYWlTLEaF5g2fIqYwLgHjTQ92dFMTLGGsUV
         qEkxFkL0AnBfE/yfffPw4j/N+Od2/e4QwfpRWmrweLnBwLyK4F7PBYeDdDZm5X+PZ9yp
         g7lQ==
X-Gm-Message-State: AOJu0YwZgymM6k3UT4pJxpnzMX94a7KFMs8jfdxZ/EBqHjiEKVslz7q6
	ZgdLfqHCYh1/W5Yn1DAL97DzIP3k0wsIlQ5KVXYwqpqI3aPqa7vH71zGxjLacaC3GkllSu+QiQ9
	Tn6hS9qlQqGpSzSB9RjtYoLS1QPpmajbxg+V0xQY=
X-Gm-Gg: ASbGnctOHErTcQcxuaCIc3S2e/5caEYuLsbpDzvcjE+y8IrYzt/Tr9Kb/6IfqW8BTe/
	pQBt0MHBxaw7JYTEnoO8ye//OC4CXuEcQGm41YD3tqTHzz3T2XZH0YLUl1IzOgqau0aQywWo3lB
	RhFPCiEZZwj9GB8NERATEVm4jGQQbwh1G9WY7rKuzow2HyUCnvnNml9L+Dg2PEFj3Ik06PIfo4B
	BTi+0acBdeEC1yirhQr/jdZ1FBeLcOeo3R05/1pAqc1AEFfYGhCMbQ8cR7XX7rg+s9kfH8TxK1d
	VaVMVa85v5H7vqNx0fY=
X-Google-Smtp-Source: AGHT+IFhNfCSdGalSOf406WxoKMEjh2ITqWtl6zazWFVAs7ueoni8JgesPYbjGRu4NLpQW9g3l96QGzY8CifeXnMhgQ=
X-Received: by 2002:a17:90b:2888:b0:341:8bda:d0ae with SMTP id
 98e67ed59e1d1-341a6dd83b4mr10067477a91.20.1762447260941; Thu, 06 Nov 2025
 08:41:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <a1df61880c9f424b49b2d4933e0d6ea0bf6da268.1761748557.git.lucien.xin@gmail.com>
 <635b0dad-98bf-41e9-b7b6-1f28da48fc00@redhat.com>
In-Reply-To: <635b0dad-98bf-41e9-b7b6-1f28da48fc00@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 6 Nov 2025 11:40:49 -0500
X-Gm-Features: AWmQ_bly4E8gAJHH1RdZ4TnHldWIBRhfNNyves1f0Q8O3wlRAgOEjU9eQ8XrsCA
Message-ID: <CADvbK_ft3jLQcQekNtUjs_Bot5LdfcyWHbrfAUp5XEAYncrs7w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 10/15] quic: add packet number space
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Benjamin Coddington <bcodding@redhat.com>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 7:17=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/29/25 3:35 PM, Xin Long wrote:
> > +struct quic_pnspace {
> > +     /* ECN counters indexed by direction (TX/RX) and ECN codepoint (E=
CT1, ECT0, CE) */
> > +     u64 ecn_count[QUIC_ECN_DIR_MAX][QUIC_ECN_MAX];
> > +     unsigned long *pn_map;  /* Bit map tracking received packet numbe=
rs for ACK generation */
> > +     u16 pn_map_len;         /* Length of the packet number bit map (i=
n bits) */
> > +     u8  need_sack:1;        /* Flag indicating a SACK frame should be=
 sent for this space */
> > +     u8  sack_path:1;        /* Path used for sending the SACK frame *=
/
> > +
> > +     s64 last_max_pn_seen;   /* Highest packet number seen before pn_m=
ap advanced */
> > +     u32 last_max_pn_time;   /* Timestamp when last_max_pn_seen was re=
ceived */
> > +     u32 max_time_limit;     /* Time threshold to trigger pn_map advan=
cement on packet receipt */
> > +     s64 min_pn_seen;        /* Smallest packet number received in thi=
s space */
> > +     s64 max_pn_seen;        /* Largest packet number received in this=
 space */
> > +     u32 max_pn_time;        /* Time at which max_pn_seen was received=
 */
> > +     s64 base_pn;            /* Packet number corresponding to the sta=
rt of the pn_map */
> > +     u32 time;               /* Cached current time, or time accept a =
socket (listen socket) */
>
> There are a few 32 bits holes above you could avoid reordering the fields=
.
I will switch base_pn and time.

For the hole after sack_path, It can't be avoided in this struct, I
will leave it there.

Thanks.

>
> Otherwise LGTM,
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>

