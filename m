Return-Path: <netdev+bounces-283968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oODrFZrU+Gm41AIAu9opvQ
	(envelope-from <netdev+bounces-283968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:17:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D32504C1D1D
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 616D0300C93C
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 17:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58523E2745;
	Mon,  4 May 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO7qZNEx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F97238C1A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914916; cv=none; b=FRnAGjPHjASjp1eNj4Oes+1Gki10drbr3i4d0NScX6P5/2PPPWA7nt4BPRsAbKWyILVd5ek5GvQCIvTMtF3S3uMSUuxWfoPUSSxuV0FSqn7JaaF1YeX2gwhqnHDzrPW6Plgfgm42oF52PJVb+lIUqSGL1H1UWbtz50EmKrZMWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914916; c=relaxed/simple;
	bh=ZF0b5k6QZhASJhGoG2LmpZvetDnSN8wEAPWc9ASZ37o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I4u4SmLgyXsWrjTEmO9gLlBl41AVJ3x78SfpNFgfko8wVTDCR8H63Sd5zac5k9x5reW53GwJ3zfLB0rPlI6HP2G+o2c3CqPYUNobdQdk5UjKRVIa3P4dHyP7XMIluLciJ+8GkEtZFWVVtn9iHfewglBk2ut6d2K/zGX6mJj9fnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO7qZNEx; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64eb84d1e37so3304713d50.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914914; x=1778519714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPjKfclZpuBGr4xr8o/9fBtma70T3K5CPwubsAor7+c=;
        b=lO7qZNExMB1ZmiSztIGEx4pyhabxfqLpdaZB4tmiWkCk3VBUpbeUqmz4j/9tQSUzsP
         196dzppjzbfA+7+DtpVUYj47RkF9xP8lE+0riwvbIpjCw/5cmSCE+hldhZpHLTjZNRLw
         4CuGAUh4OUQ5W7rFlkbbox3dmWzWZXNBH0uZcQvAt1ptaJS0pfGXS3E9HRanzCRtveQU
         EvqEoPtg9XOlc5+ONmv00D4yCQTG3izh9v/Ac3g2++vszPk60bJ2RkEw4zPyr8jPsI19
         wkTSgv0NhwqepDSTxdmQ0t7Lje6oVWMJHLydNKwOPzvRNXOgmwbwC1asl/iNFIlnuafH
         U6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914914; x=1778519714;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPjKfclZpuBGr4xr8o/9fBtma70T3K5CPwubsAor7+c=;
        b=k3839yyYpmNXHsDFP+iLpSzxcbLhVotysFLXI8oGDG1ZZ87brE4Ngr/zE4LAYBT/Zl
         ZN48BTENYaXub7I7xxcfceafN+xLNkn+kNNOfZ0SMCkK0TBtjdRFGIi7XEOSQ+MWdUrH
         /tDNMN539Ad1Lv+4B7K7Jbvzj/F3Ru4qVFNRbyGm21uEigaqBf1Of9kJXfZ27g5VdoMm
         kgnrt7tTv3LJFh9BjdUIrXpuN7ZTcjnMwVvgX6rvGpjfXM0EEyf7p1VDX0qKj4bPIst4
         Vk7qLlKLJwp9eK1ez4gcIaXxYMBjPYjeyTgjBGbxs4ajASxeeTDo7jzTYDm0bw+9Xdd3
         lFJA==
X-Forwarded-Encrypted: i=1; AFNElJ+P75OGKIwQ77I9tXRS5XMG1DMXy14GEXkKNpZR0XHjAy2UlzMaS0W88L18MXtSuhF4dv8J6TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6lsib40zT0dfe2hBPP6BWpaekKfkuy0O/NSNOHJr1dbZftXi
	JGMOug0zWXnTYpir0qkJBjMprsCdIZNGVbSzFbhFmXNRwyIw1dzxUZSj
X-Gm-Gg: AeBDieuSHSaS2qJ/KnsOK7WjRwEb0RZf0SS/6goXBiZCIPrGzbFzab4tjjD9NMI0L9A
	pUaziTn++9h4NbqBPlYcLhRPA8auRcBFYhkhXGBVmwdlIBj1M6oCXWkDjzK5P2nrwMVpNH74iMw
	Ru9oXAJ810ExAHcBoKVl3NH/BTagAtH2vbzDlhtEWJ9a9TNIfAOR2xtsOc0lSQ6EmECVhWFkjkS
	guZK5W1pwLuWMGZGsFaOvCLpsVBCDbZkc0grI1xEPD47rOryyZShLgUclbBhCJFdT6gzw+B2Slo
	f05T1X+cXsccwG/uruB5+cmir+YlzXA6b6fz0NuxpyZqVRRgknfN8b+vSDbtXhnhg3NXeTVR+zT
	mucRoTfxEbMUGFJo1+FXOiBnxOVbhdStDniJOMZHBsGpfGhiAf4fTgOFlXAgtASblEMxWvYiTcE
	1M5s0boxWojY1qv61K3Jzu9UhfuhSUjPTPVqhN9B4KUXvGT+bouzKC+z1QRaGXr7n1MSXGjITe6
	fHzwzVxh5ce5alcmmWKygB50w==
X-Received: by 2002:a05:690e:bcb:b0:651:bd70:1622 with SMTP id 956f58d0204a3-65c3da0c96cmr10543400d50.10.1777914914418;
        Mon, 04 May 2026 10:15:14 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e86e35csm5782052d50.16.2026.05.04.10.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:15:13 -0700 (PDT)
Date: Mon, 04 May 2026 13:15:12 -0400
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
Message-ID: <willemdebruijn.kernel.3b7e1901d86e3@gmail.com>
In-Reply-To: <20260504101759.3319427-6-nhudson@akamai.com>
References: <20260504101759.3319427-1-nhudson@akamai.com>
 <20260504101759.3319427-6-nhudson@akamai.com>
Subject: Re: [PATCH v6 5/6] bpf: clear decap state on skb_adjust_room shrink
 path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D32504C1D1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283968-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Nick Hudson wrote:
> On shrink in bpf_skb_adjust_room(), apply decapsulation state updates
> according to BPF_F_ADJ_ROOM_DECAP_* flags.
> 
> For GSO skbs, clear only the tunnel gso_type bits that correspond to the
> requested decap layer:
> - DECAP_L4_UDP: SKB_GSO_UDP_TUNNEL{,_CSUM}
> - DECAP_L4_GRE: SKB_GSO_GRE{,_CSUM}
> - DECAP_IPXIP4: SKB_GSO_IPXIP4
> - DECAP_IPXIP6: SKB_GSO_IPXIP6
> 
> Then clear skb->encapsulation only if no tunnel GSO bits remain, keeping
> encapsulation set for cases such as ESP-in-UDP where tunnel state remains.
> 
> For non-GSO skbs, there are no tunnel GSO bits to consult, so clear
> skb->encapsulation directly when DECAP_L4_* or DECAP_IPXIP_* flags are set.
> 
> This keeps decap state handling consistent between GSO and non-GSO packets.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

