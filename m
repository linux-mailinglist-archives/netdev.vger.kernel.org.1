Return-Path: <netdev+bounces-300521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /ebONyY4NGqiRwYAu9opvQ
	(envelope-from <netdev+bounces-300521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:25:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDB56A222F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:25:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="dDB0/qkF";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300521-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300521-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59A823040943
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E2F378D8B;
	Thu, 18 Jun 2026 18:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2836494F
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 18:24:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807058; cv=none; b=Vmgd7aDB6E95t0pAIsk55nw266cL9HaKg3GLVs9JzX13CEqfcy5l+CgePmFZDGLY6Fx9VbAE4VlKcYLjvYt8VJyVXaBX/tQtuNpGR4bxBF/jnWEhh4sSr9IrlTCoNdt3QpCPmAtkyy+CngZOh7NQ5PJhAAh4EpLwjWakIHM6IAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807058; c=relaxed/simple;
	bh=zHZHrJPqR/72k8j/7zs76hmEVzjIOpHLv/LDru9J2Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzKZ9gVwU/YLpmkBNyYSOguWDGbVyi83m4/5N/TYDbCvldJGN3ykXh3bmN4o2J88Yevc+PChJmk6jCAIj7eFd73p2j4Ise7ru9uWlZHTYm7JojvTi087QE8ftUqzvAQYQfY3WA6KNcwiKlZjLZmEQqPze3VK8QoEOZfXvkOIEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDB0/qkF; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423610ec93so1129836b3a.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781807057; x=1782411857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHZHrJPqR/72k8j/7zs76hmEVzjIOpHLv/LDru9J2Ns=;
        b=dDB0/qkFO3XZZHSqt5o9++S1aExX8Rnmeeoiu/Pjcv9sz0KC2gNi3y5ZoJDvQGylTO
         fBbXLaIYYYLk/QuT8mhwi2RDPzgYJIodzaUarDNOwh/w4KouVjjs3Oskc/AVIgkLCnJ0
         jxlilf2jE3zoyWVTD6GZNCDBOWi8ZPZrauMxwzcZjIl+OjSSHRFfE8cInWfUnyn3x0ek
         9c3+MtgPzyh6ouP4i6dPtQC/klZewD2t/lW0HlrHALGgKStzCYTIVT29c1YgKnBafldZ
         /ThDOPefZLJtzyk5D8Dx0FtS+iiX6Bp7W4M4p8g3aK2sg6wIrwYrB9zZfpq94fAh8A+/
         Am3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781807057; x=1782411857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHZHrJPqR/72k8j/7zs76hmEVzjIOpHLv/LDru9J2Ns=;
        b=AMTJwSyIz57hwyPizzhY3fkcjtr610kVp8f64DmGK63g2dHkauCly5GqIx6z7rRtRH
         SLRC0gk4uxtRWt0Rn0yyDhJwbrd79QhTJSqn6zltjgnNEv/fhu8gNAzT1Lr/Ty9y5h4o
         f1qTZXes77dYOdVeLDyAqlDV+TNipKjgskF4A1QvV57rBowKWEVl9aS3wNRQhGixDDnH
         uGoK2/8ZGGb5Mt6n2PC9Ha1U/sjL4f1YGsi5QjlsN9ThrV5A5bz+n9IDkMf97cKwVKtg
         rWzYqhCzAg5xVHUd48+IOCf+Hu5n2Qnw1uLew9DmZKUtOgg1qEo6SiM27T8fu5dOZJi8
         1nag==
X-Forwarded-Encrypted: i=1; AFNElJ9B00TBaHriVmHLTTE1Q1563znGQBlagsmVI29BSI8x8uQD39PEY3cIU5GOoCpSfWQICTU5sLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpxtISNLImOeYtJr2DkLQ6RR+meFWLw1ScD+edvYYHJelF/8VD
	J2U/hKfFFYvbARRXwDLEJCP0U3/G4+bf5uH+imMBY5VDYUYnzcEqMmig
X-Gm-Gg: AfdE7cmAavSKiyiGsOuIYxeMH7w5QFIfKLaL2i6aV6vzYcFbebCpu2G8iPjTJcRF04s
	FuIBSFBTeeoh1rf+heVewtWyXdebwq3ysZNZmTn+YYFHAY2pvb1H65Sa3BhkemYPhNEXp/JVA//
	6hogRKEzwq+l+gRBZ1k5XoOnaA9gDH51cbIxyL5g/0VSWNJXXcLgAnY/U87wVSbD53mLJzfe2m9
	2xD0eiks5XxrIlUzwAHXiIQs0dxHuJS7s1x8I8/SyrSARXfavYSzoj6cpLiywyHMTAoU2OWTR2y
	uV3rgEOc0lnd7uPCA/xACtFBM71/HT4a0V+F5Mf1eRoYlfxIMB5NLgwbK82dgIOMVQuu64FxQ2G
	N/TlPbiRMbP5PB6bKOVvL+50wNNNzfyteliwRFZ5OThj2MdMYVe1KNCZys+obE0+OUo9AyWnmML
	EvbQyYGaPExA==
X-Received: by 2002:a05:6a00:339a:b0:842:6004:3fda with SMTP id d2e1a72fcca58-8455087b4c3mr43350b3a.25.1781807057093;
        Thu, 18 Jun 2026 11:24:17 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c474sm18790640b3a.2.2026.06.18.11.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:24:16 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:24:14 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 2/2] selftests/bpf: Add test for bpf_sock_read_xattr()
 kfunc
Message-ID: <ajQ3to7T3eFOpB7q@john-p8>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-2-a1276f7c9da3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-2-a1276f7c9da3@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300521-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:horms@kernel.org,m:kuniyu@google.com,m:willemb@google.com,m:linux-fsdevel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,zeniv.linux.org.uk,suse.cz,vger.kernel.org,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,john-p8:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EDB56A222F

On Wed, Jun 17, 2026 at 01:18:28PM +0200, Christian Brauner wrote:
>Add a selftest that loads the kfunc in sleepable and non-sleepable
>lsm/socket_connect programs and checks that a value set via fsetxattr()
>on a socket is read back.
>
>Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

