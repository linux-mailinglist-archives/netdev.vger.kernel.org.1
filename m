Return-Path: <netdev+bounces-279915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD97LriB5mnyxQEAu9opvQ
	(envelope-from <netdev+bounces-279915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509443367C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F173026332
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A013C9EED;
	Mon, 20 Apr 2026 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioJuHZ+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F73C7DEB
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714165; cv=none; b=Z4HpCqJjUvnsGPXP48N/uEJHDI8CXrvUxXcnG6OXaXhVlIlE7a+qJ00Sl/J3X22+TwU51ZTHt/npVJlLwh6BsuBcBpkbCGFubdocAq4jb1zgfITM6l8F2YGNKtyawE6UvM2/Y044+k1QS+Er+9HaXyHjJ8Q7gF4IHiW2eOL17Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714165; c=relaxed/simple;
	bh=gGhv5aBvag8GkJJw8oK+HvN5ptj86XyPHMattSfFigo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ICITDK0qqGQDP4bAET8gOWIYIu4rvOamiSGkuczmjU4FaH9VBh42+LLfayAgtliACRRzrmjWrQH4ixBFnxC0q1kXhr2Ioyoctsh3dWBBSvtjjgXccEvdADyAYpXCjnqJqAKlnW4i51FsVLiToOSB/VssGy9O/5dw9EJOQEyKnkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioJuHZ+j; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-799001d73bdso22808707b3.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714163; x=1777318963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar9A5QrYRWGb5NIZabW3eNiZEMmSWnS35Z/zWd2ipnM=;
        b=ioJuHZ+jKiUhtlsNSOyP3QlO4YWFOh20tActa3Kup9u2YnAy5zNVLxuYYRAeKcAc1l
         sX3MeNQFoCigoYRqXNB373NG/iQVAhrotHG5wsmPUES/UE59cNaSz9jSa8mAjDzTvpZY
         rCnLpv/i7T6wbWZZ70HC8zF7spr3wFQwzr2vPdiooaRgQgplZoaCxPCybss+1EpILpty
         6CP84QEcyJc6fyyx/Uh45pHH4RCQ1efS3KyoGmjuXXbphWfFJDUdsoIDcpgvH2VgVcWU
         I+bGIVjKGb2eJuRrLi/dv9azrTqFonXSNUaZy6XVNPwyCVSRndjvYX0+sTBQ/FtLqNlT
         T3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714163; x=1777318963;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ar9A5QrYRWGb5NIZabW3eNiZEMmSWnS35Z/zWd2ipnM=;
        b=RXHUwXYVcVymIUgaGrPVTA8/gP7HBuyvhLieDs5976/mSCBKTvCZjDBD7EZ3V/Lp2z
         1DaEnBrpn+MR20Dk3vUiJZscE7ONAmsdNMAwtOvxRgjmiQm6CLxLwYiPKIX9/7FXLfQP
         TTb4aWVBbx8EJrbIPZ2uGOq5k1l9H9WZYzie4ppHX7zPiO1XR//llNFPSdULL4ADlngr
         j1AUwRUgxk6Wo+VfsoaGVH6HHDyJG+qQM6lX3bzEYzUcLy+v/byPWrAtV6zVyidNdDdd
         gEZbBfRYJwfBxKQprZCjuXTELyI3TCAX+Hl/F4ywW+UIQUOTRGRNl9PnlH8cbgMEWNNJ
         E0dg==
X-Forwarded-Encrypted: i=1; AFNElJ/dGslykXlmVS57lQjEtzE20AhjTkz2T2vdMQlb+hXnvt48gLD9wxLqZBMv3kcwvpMgo83GRGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfLp57gno7BsnqotGbdEs3/fqz/YjcOqriwq0roRFXLeFvflm
	8nbMw0vXT7O+jLrx8Qw1J8txO9ATy/yk2ZLmTfuzlMvl/YnrldT6kIyg
X-Gm-Gg: AeBDietoZQ3WmJsl9WbzhYUeqww5zraB9RBnC9J+O1GyADjvZEvY5vWBYlwVoYQWxbj
	T/ZOx0ceIMS3hW3y3J76B/mzbwWKaBk247MoBNjbBjTb3ejgc3xMzGgSKsr1nJHW6sZSmg37LCa
	5VNfB/9zp0i4kw6JwevxSg8PkrYOqwh3d3vUnQJ85JSzwlAo5k3GSBYI+yK2bWQB5rEYZvMg5xw
	vs5p4kct4wYiZfM1HKAbq9Tf8Uaqin2PnshKQV/1zPPCU+/nnZyGEA/XIWujQMXpPSxq378OJD0
	iJGc/Saxabwq1c/MjYB8e6gcJQ95iqLv0og7IcqWHz4YEbEo7rHs949c0si5r/DzgdFVuyzo1me
	I4lvn97bR0HHXqk+3mPckRrY2rQvSDidVU2MsaK+tRum9Cu0ER914jXt97WlLRNF8RoUsQxVNtK
	rXnbjI+ISPCMJT/brQkz+Fsp3VBsMeRoWyd4Tgy2gB1Jjdkj4kypgys7NbxPcTtDZVNMPJLjE5l
	XeQhH7jh22S60CM9yTMmTkwJQ==
X-Received: by 2002:a05:690c:9201:b0:79c:ff02:a048 with SMTP id 00721157ae682-7b9ece6ad3fmr142245957b3.4.1776714162988;
        Mon, 20 Apr 2026 12:42:42 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89b259sm47551907b3.2.2026.04.20.12.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:42:41 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:42:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.29f88e1183282@gmail.com>
In-Reply-To: <20260420104051.1528843-3-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-3-nhudson@akamai.com>
Subject: Re: [PATCH v5 2/6] bpf: refactor masks for ADJ_ROOM flags and encap
 validation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279915-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1509443367C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Refactor the helper masks for bpf_skb_adjust_room() flags to simplify
> validation logic and introduce:
> 
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
> 
> Refactor existing validation checks in bpf_skb_net_shrink()
> and bpf_skb_adjust_room() to use the new masks (no behavior change).
> 
> This is in preparation for supporting the new decap flags.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

