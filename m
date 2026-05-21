Return-Path: <netdev+bounces-290173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNQ5Kp5VDmry9wUAu9opvQ
	(envelope-from <netdev+bounces-290173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FA59D61E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFF2630BA8C0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A489925F988;
	Thu, 21 May 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzgAqr8C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208825A2C6
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323999; cv=pass; b=o7BOQNhdnzgY9MBAVzPMjPOuxQ8ydKbP0yrZ55I6anCeP/PD+hfV6ViOSiCq3UkqqER1R17mRXBa30h44KxkZylnacVJKHF4i79M3ldqb+KJyd6gFHv/0s+7DDtFIOn7yF9gibEYD9mZjW1LFTZsRuIf97Pcl3KwGC6B5VqoSeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323999; c=relaxed/simple;
	bh=G4NtzPCJXMi+6LprF4DgBxJXqA2YlW57AUksc3SiBUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaJNNFHrjo/rU6UMedD4jRnblEv4Q19F64Z2BogNU1b/rYQf/cbrS8T5TBxnLG9eh55mdCQfyw+iU52+In2R5MBPlbiahGm8gwrJ0x5nsvBp3iQHNfjv/9e9bV9NGXGsXg9EqCpbWcrsBG9QBfwaxvKFSsAhI+MqYjwKGjHoBrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzgAqr8C; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68707d88626so3704655a12.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779323993; cv=none;
        d=google.com; s=arc-20240605;
        b=bLZ+EyfwFgBERn5ZBrRbETkxfR8sJ7FLCqGYcYUiwMLDjn9N6F6zyDxspQqZ3qt94z
         xyN/2+6860U6fG0JCVioO1MacGPSiVa9YViW2MrGrsFt62SEeErxP+j+Q0eVsr3c1TKY
         dLXVgtO2tFNB4b3yn3ppopPNmQzsDchy5vyHjMT3CBCtcpmjs794qVgAXByJvH8LC2Sw
         M8ef5xe/+qe+dOPE4yXayiJrwWHaBYAtkIdY2rmbhpTYbL2GRlSGtM9bbhNYfyFY54+D
         2lVaO9hO3+6QdoH3zV0kVDIWdSgOCvPKVN9iyUNxeByra4o4mtk2Xtrf5KWn2vyrnqom
         ZLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G4NtzPCJXMi+6LprF4DgBxJXqA2YlW57AUksc3SiBUM=;
        fh=2wiBsgO4ajjbqfXrb0q3PnOXIVSj2VG32cjFJecF/3c=;
        b=kCOsLiIMEwOp5uxgX0kdgVqIZB/rvBvxwubFgK5v4eRvQAuPaK6ZtyK/AfoELaaod5
         JhNYjjS4qLVX1F0LAQ65IXazWht1ArrtcJUVcb8uizaDw5zcIiCXH48xFSJRSoX5Y/ZQ
         egSWuVrakVa8U/Tn9B8cJ3aWgnbubsU9URe1reMPLK50tRnKm27pHBz7F9TBS/WPyAKt
         RaID1XeW6a3RgEhXvcX4YuDppjJQ22IOyi1xUUR1jzGjqjwYWpzvflzaHRCNpKyZ2+xh
         KdhRDzQxjjQEiVqlxK9a6zsrFtZhhy2RKSULafINewn1t1+IEst9FTBCUcL9yj6k3bzA
         29mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779323993; x=1779928793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4NtzPCJXMi+6LprF4DgBxJXqA2YlW57AUksc3SiBUM=;
        b=HzgAqr8CcMdfLYgTcwgYxu0ffIbo9a8bd0suSowiVPajnQHknx90sk35DA383QhkUZ
         wMI5QphsqH56oa+JWpkypfsGRQOauCk6eHW3XtLDGVZh9ySIb+UrkAsL8RViPMjn9QP0
         8FW0qVRdXojxh84gTUFfm436CZVvg6DTde6XDXzzyMhCt76CT4aZvtSFegCkgS/LpgIO
         wgIr7k/NgflKihxsyJQy6c1oLBuNxzyDvZh0k+QWDC9eNK2Lm+Fn8ZfhgIhenURu+3Dr
         EDY7Tbhb5CkR7JTQHj+22e9OQFHAv+cwxZGQtI/amwjL9kCUdAMi5nBGsow5HMghdQ/B
         BEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779323993; x=1779928793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4NtzPCJXMi+6LprF4DgBxJXqA2YlW57AUksc3SiBUM=;
        b=LoLBgHfNMv8aYdq5wZS1o8tqMuRzcpT0ZseeEWyj05NL7/mGhjE8dC6Z5cH9trDE76
         puBi6AQzHGVI2lzDM6KHKmgq4YKG0zLLxMlbXwx5q6YGX+U7NRAIlYOCR9HqU8wolHx0
         /DzdAAn3hFNuwJO5y2Kp4PxNGODTMYtezUY/QgAEl5KbD0se8bcUev7nX26L+lIKwIiy
         4Mky1U0IM4uqdJXZAR2ea8gs3aSYyfbEjm5cS1BrOf2T4ix94GVFuh5nVZ+yjE/+zx/O
         ek7hGswthVMnQqvPGTDBj/5alR+dketyJV/2My23B1+npe/DVLxsX8Gct3SgXIeVan8M
         BjUw==
X-Gm-Message-State: AOJu0YxBzgXzAvEqns+4k0+vvC8xPUKjHuwvr1rBH1vYDlfzc69GIHIb
	fWyzPnLxERmtQ8W/LsyEVAsGti+LmGUFqdXY+Mw/TsHUKiTFr38548iHZF67Jrv7aOgsEhRSDDb
	HEOu0bCpisJ9GToNc6D7sq4NXXf/hZZo=
X-Gm-Gg: Acq92OFILc48Y5z5oQbDBC9xpDPIXii3OiOBJMe8je2e2aey4UJcFy+mA72CtSG1vXK
	C2nHWZpdM+DbGZsAfOUIuQ7w0TV7mL4YT5BA4yCXSXrTGagL8e2KdBZveuWBz0Kv1heJ4uCDYE2
	3oZYb9ak3cBCNunZ/eVJerHjH8BCh+msWNmJr9R3CAya6PecjgMd96fHCQxMlr+2H4I+eLRSkV3
	AVa6sI3tq8D7c1okVgCRTEdBlczXaVLjaRBcXNVYTaVAMY0mZk4doLn+nDrb+RjSuG3nmkHHZuE
	+xlt/rZ9YyIWzJ0bTzDhkXa77pFqYDb5vfpcDwHu3Tn2qpuxtpZPfF/+wtWD84gSIZdSuHS8cUa
	f6ico3O50/0c7cXWvvmMXc1qLNcz0tQaPZTdPKoRVs0lgdK/k/nJ8rNDUnA==
X-Received: by 2002:a05:6402:5291:b0:67e:2624:b8ab with SMTP id
 4fb4d7f45d1cf-68836ecae4dmr158915a12.24.1779323992766; Wed, 20 May 2026
 17:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517192856.3925-1-rosenp@gmail.com> <20260520165746.7ed10c7b@kernel.org>
In-Reply-To: <20260520165746.7ed10c7b@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 20 May 2026 17:39:41 -0700
X-Gm-Features: AVHnY4Lw5Emq_uEem6jfDTwz2sycS-YazTsfYTjdFg9T3qH_c0M9lLZeDT6_kDE
Message-ID: <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290173-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 110FA59D61E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > Collect received skbs on a local list during RX polling and pass the
> > completed batch to netif_receive_skb_list(). This lets the networking
> > stack process packets from a poll cycle in bulk instead of handing each
> > skb up individually.
>
> GRO should be even better.
GRO will result in slower routing performance because there is no
hardware checksum.
>
> > Speedup tested with bidirectional iperf3.
>
> Please mention the platform / board as well.
Will do.
> --
> pw-bot: cr

