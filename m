Return-Path: <netdev+bounces-260458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHdzO06EnWlsQQQAu9opvQ
	(envelope-from <netdev+bounces-260458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:58:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA9185BC1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46D1302DB52
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A193C379999;
	Tue, 24 Feb 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgjYZtwk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+/mhzpO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D936B054
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930699; cv=none; b=SaQ8h3N9MWK9bU0FpqXEbyAP9d1UNyyWprxzZnpt3M/TP6urBoiJU81yLaWmCxlFCymIc8GBzA9whfcQzHMOI+H9sH7hPgsD7MkyXMvnUYcgCLoBgM5S/p1mpZGpYkILDBZpd5dU9RMTpm5mx5bJcjP5t/1iNOWg+R4nyWTvgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930699; c=relaxed/simple;
	bh=4oKOtmEtfvLwnqMA7pFkspC1lNzXym9piPx1zp9Q3rw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TcBZasmbakA/QNFXHXFSOfRJGHs9jjsMtaEidZ+0zHpo3lB3va1BapqijavJ8CmD6QZfF3BXlANTrLbxRAX/dmTGB2/6NpDggvBBHLCy1C1niZ88vA4cZJ0w55yQwlgNKxH8YNTO92CuElQmErBtBSY3DaE2blRiSnq4SQKdy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgjYZtwk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+/mhzpO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771930697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oKOtmEtfvLwnqMA7pFkspC1lNzXym9piPx1zp9Q3rw=;
	b=SgjYZtwkmDLReFzqu4AoQOburbZN+2wCMjtZASbNciy7gClPGwslYYdFHRR+sRWCIq3c66
	NX81qeBzoVCnLeEcyU0XNOaraipFQExARV5oIu6q53rvwiSjQmhNnwn+CIqI5kJnHO30IC
	H6GOJBCoLsybgjGufy0Tp+XXIOsXp1w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-vWNrrSwnOFekZEhGu-9MBg-1; Tue, 24 Feb 2026 05:58:15 -0500
X-MC-Unique: vWNrrSwnOFekZEhGu-9MBg-1
X-Mimecast-MFC-AGG-ID: vWNrrSwnOFekZEhGu-9MBg_1771930694
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-483a24db6ecso56677215e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771930694; x=1772535494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oKOtmEtfvLwnqMA7pFkspC1lNzXym9piPx1zp9Q3rw=;
        b=e+/mhzpOlzqxGLfmyOCJqFuGGlpTCu9SGsxQc04DDitfZhiEsjziHElnhLftZ4Xzx/
         b0QjB5DVxXS7GKJSSdljBVUc81pj3GGszpBYC1UY55hPQJxd2KTabheerFf9gA0aschS
         gRUWfQJaf4gyX9rSVQfI+3gidaJ4ZjPg+dB7IZ0EVnHNT8hI9bqoZomxf2zJCJ94Wh+K
         5ciGuuNx2a2v1OteTtDd+S1cvvBFNl7Fs3cm3JyLWxb2OdUlz+/Fv/iQmQNdoHZy+u+c
         5UmgovxLGJ8UVZsffdhuanLhL32eikzfcL4/dwngmobPz4xLd3tK/fKJ0wRX6+Yq+qNR
         X2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771930694; x=1772535494;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4oKOtmEtfvLwnqMA7pFkspC1lNzXym9piPx1zp9Q3rw=;
        b=ZcwTR4Ok24z0huzN420Wczjdf3qs3AY1A4aXuNUr9UiA/gpOJfDCtRh7XTnAuWU73B
         guusoAepL2THi3A2gXqp/b3RqNDJ+yMBsWq/OIgozbni9w3I+/BO1zU13wL8oDZK8CSe
         yiCAUmXeDBlh/dx/oW++lJge86LKXGNHt3OyhVyqAGlq/QCPKCiKZ29DKkRDwTo1QE+n
         G0qHusLHGPAe8b3OEttV4hubnxaRXuomTRkQm/m1VWqoVH1ZMKJBuYlQ+YShBPh5+HlV
         wjxWJ3+GvjjQNHN5yLJFyDg7AyWzpM6o4929zD44XmEWQQUCjD2Lsr3ekdMwMfT9l45P
         TA2A==
X-Forwarded-Encrypted: i=1; AJvYcCWo+WsYPbnFX2kK6j3jMiLBW8/fchKuzyRm9ovE7r9/qn6ud4OZZLzf6sPYX6Q+Bo9n4yKNJog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxihIU2uUeS8lD1V9+RZ6I1IqMCM434Zf6TQZA5xu6QwFOReoLW
	0GWN6O00RafZsXAK/dgqjnHwi/AH/FNqtCL5qGA6wTIl430U2i/5P8etZ6mBgkmFghbGv9dcskw
	sz+Vme6Bi2uak8FFFRDkntnZezzLuaCaazKgrzmNqtiFOR5cXFDX+MyoqQQ==
X-Gm-Gg: AZuq6aJZ6cPrhiJP3eQP1J4N8S6gAAaqcbBGjAZjt/8f71uRbYH8vk8wrSc3lJ6MTt0
	AQXklWJfU0XRdf8exwxgj++ay7VWrh76yu67dJFw422Xo3TG0hpD7Wph8ZMee5WPQEi8JsQ04Id
	I1FZWgKGwCdxRMNGKlb+28DvM3VHDRQPNOXWKGsKjMZ5TK9RRW/E4EnHH+ZC41JdIS7R4XGzKZ2
	+5HmlJscSXDKkDHQ12QDHSnOrspZuUa4/rx8QaCSCRgU9xSW3fbCgPaHnioljDGjB8y2dKLeNRh
	JiANFZbudDOQNPksXCwcfmq3amuWoX5zDLUa6F7r5VfcBxCfMgl3SmxpTXL+E0U0QqkgAX9Lsm+
	s0NPCIuJj+KhKSGT143oPIT2+jtcgMZ7VDjKIkdarC3y8ZA==
X-Received: by 2002:a05:600c:c4a5:b0:483:a2ce:f461 with SMTP id 5b1f17b1804b1-483a95eb453mr192990055e9.4.1771930694293;
        Tue, 24 Feb 2026 02:58:14 -0800 (PST)
X-Received: by 2002:a05:600c:c4a5:b0:483:a2ce:f461 with SMTP id 5b1f17b1804b1-483a95eb453mr192989615e9.4.1771930693778;
        Tue, 24 Feb 2026 02:58:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm493903085e9.8.2026.02.24.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:58:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 478EF5168ED; Tue, 24 Feb 2026 11:58:15 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <kohei@enjuk.jp>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jussi Maki <joamaki@gmail.com>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>,
 syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 bpf] bpf: devmap: fix stack-out-of-bounds write in
 get_upper_ifindexes()
In-Reply-To: <20260224031556.38398-1-kohei@enjuk.jp>
References: <20260224031556.38398-1-kohei@enjuk.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 24 Feb 2026 11:58:15 +0100
Message-ID: <87ldgimmrc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260458-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,enjuk.jp,syzkaller.appspotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,enjuk.jp:email,toke.dk:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,10cc7f13760b31bd2e61];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 51EA9185BC1
X-Rspamd-Action: no action

Kohei Enju <kohei@enjuk.jp> writes:

> get_upper_ifindexes() iterates over all upper devices and writes their
> indices into an array without checking bounds.
>
> Also the callers assume that the max number of upper devices is
> MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
> but that assumption is not correct and the number of upper devices could
> be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
> stack-out-of-bounds write.
>
> Add a max parameter to get_upper_ifindexes() to avoid the issue.
> When there are too many upper devices, return -EOVERFLOW and abort the
> redirect.
>
> To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
> an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
> Then send a packet to the device to trigger the XDP redirect path.
>
> Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@goo=
gle.com/T/
> Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device=
")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


