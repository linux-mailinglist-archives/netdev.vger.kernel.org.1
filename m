Return-Path: <netdev+bounces-264032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAs3HwmSqGkLvwAAu9opvQ
	(envelope-from <netdev+bounces-264032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:11:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D620D20776B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BF3A306EC8E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D3382397;
	Wed,  4 Mar 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V64sl+BM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79538228A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655025; cv=pass; b=Q0arA/N7CLNNf1axnUom91zu35kMtH6hWLh5bocjzeitjCRCP+fEshAfdQ7NNj/ywu4QFG1CsjiUHNF8tuhsxnpsZz7/hyq8HbaDFUo3G/RuqHcWXMe6i9wNWzAGHZ7tJO2LqK9jiwLfgz5HW8NMPdPkwaShECJbnWjy4QZ22j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655025; c=relaxed/simple;
	bh=04LKILsO5rNiAUfHFDSzhrapeXZC7tNvPfppW4ypo34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAQ1l1SJw2LUMCqpaaJdFW1325hvSOze91MVMePDGFTnM8vdl4wZpZD5EnaLsiPADLffmS3c5k8tLfLYVSzDYTmre6ozxsTpYGnVU260GrmjmDJ+01CxELxTvXRlBRFNjlVmvm2gNXAKvzCXFT+ayQ8ezyLNuCGxgr+cWrHFAcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V64sl+BM; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-660bdba9390so2919540a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 12:10:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772655022; cv=none;
        d=google.com; s=arc-20240605;
        b=bLA5y4F8IgyCALIdvVUi8sjFwtXZ7dy9wpCq2J1nyf+P7PaWK/HmKq5qDYiz3DeoBa
         kC2RZHtDq6wqjW/EUFaOtCYn6KA/sOLtM1RYqYP3swv3Ql9SqK4l51IDbmEHs90i8bjk
         eSse25g4r6VKIQ/jVsUqgXRu/vH73yzrwLKagViGuuSFImjdBeKu7vD/2nsemDQXYfQd
         8oGjvN6l+L15Ca2nyiqFYFCcm8upF4VDNEkz4VZWj3qzXvgleBTe1CFaluQ3BM1vlBYJ
         fW9966FGiPJ84OS0Pf67Av5yCjSBNYTBUwW07M470tNmEhq6waSRvOxzDL5dCzZqZMx1
         EYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=04LKILsO5rNiAUfHFDSzhrapeXZC7tNvPfppW4ypo34=;
        fh=6Bz2mGO/XMPpXTlYcE2toBrRM+UjcqmRGK7gHrsIgJc=;
        b=IAbxCQbSYaYacZeW4xu0y4KjFPOrjXeE5CwH1POtCTrwpsmHlKRyHAmFA7OeCle2Z9
         STVNaNxrNkfVe/rVRWghZvmgEgFJYXXGLkQT1ElxvTlKhgyt907p8wuaKoaXEjMFhXFu
         ALNC8tWRKAkhuPtC2G7iGCRcrrjvm/Crm17kbVStP9FaEz4X1BYy/VBswfPZfzsuYoX+
         rPnHHTJTzqdvdsU+rfd8Wx51IBgkLhh0b/9lwsaRXPysSWXwA+x+2Y6aIyrJk/F8JdHt
         yU48Xam/ctJliwOSD5ITWqfw/cKr6pKZKQ5h/cu8x/QRO7a4byYuIG9foY5om0f8TagZ
         6SyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772655022; x=1773259822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04LKILsO5rNiAUfHFDSzhrapeXZC7tNvPfppW4ypo34=;
        b=V64sl+BMSg4zPXZRnPsXVARtaGQVo/8+G//RqWaONUXEUmMReWfRq2pv1b6t9TJaSs
         81w1csb5a0Rk54GhyhVfMoOs8k/hTuYNlGW1wLonARrtwI1vQOoa+ZSLADE7RbPocpvc
         PGU/Y3YkFaFExYr889o716bMoN0zOhkxGLObANDE9+m7kFRn+CwoiIaIGbl5439ro6pL
         xxAETba7rbOnZTpJ6Y/e/C1UqrpF/J8JALuQEt3zrzdn8RvBi39wtEytQMjB8T5lHcY4
         mJDamM5InRi3p11Of2QbagUt4YILkrviGdGoYB8GXYoJaIbwtGXKNKHjIEGtKJTT5CdG
         fNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772655022; x=1773259822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=04LKILsO5rNiAUfHFDSzhrapeXZC7tNvPfppW4ypo34=;
        b=v4Ml9nWpIGc3nYSj2wXA8HQ1gP//UUvUCpaFgstbbBgG+bUWajJ+CS+BNBNhZjV/Y/
         UnsTZ8jR4zdugwIhaJUwTu+Vy5cGi8SE7/tlO5FlPKX/cxDqe9pWypaAia2qk/uts7Rj
         OpbCcbeSDEhW1jBlIJpeSXuR+fU8A/2dPLgnnnCBsA+1INmVNu2lRvJm2d+R7n/DFBhs
         MWJml4WH/hoATck+MGSEmIrx3kqBpNmEqgMLVk5bxeY/swxUAXeOWWuUADexjq1zvAUE
         mwiaBkHsfhjfgXTizssI5gs/E/AkpNwhOaLjQ7MGCRyY7wQdHYxSa5oTGKg0P7unLxfL
         kDNg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Wob2tKbzoa8jC4NOcAf3tTZeIPB+SRab+RQ5qRjpOyfwIw100nktDB+8sCejdLPWxmSYGoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zweNCU44PbCclD218T11xJNTMAfKM4/J2hb7Ac74sUhBSvRS
	YEnXd5eyhuZ2VhtTilGtb0DfcSg7rf51VvZaA1VlnzWoAkUp/s5LcOaOVYCraSs+30xyHUZOdw3
	wnpJX/hLGEGJCmejXRZsSDOVupbJr6oJO+wJ4KFOa
X-Gm-Gg: ATEYQzz3w1mJCqoiez0xbXnCOiUnj+PnOquTKwG7SLak2ogYBmr67VBFtt26EmZSkiQ
	b3Op41yjLEJXsvtphXaxIJf9jTWDMXVJTbvcM7RjDOK46NbsQWVQbE92OpsfSDazIImKKi2zVWs
	+PdAxSiqvnfaSRvoTp09QCEjhxbZHfi4Fr/++knEUI0c6tc9l4haQIsNeb4c7VXy4LulXlPnTBg
	yjMtWF2eu5H8ttS6xw+ROnmSXrOlfqGgW7HVJewSuIWPFEtTILjeR3G8YJUr2huVqLvs8BhOFSd
	AodO+rWbRdw1FTYpupc0v6HDgO3kvlFMfkwnoFnoqEYItu0Qiau5R3TB8ZMwzWimhxU3r4FMhst
	jX+Dn
X-Received: by 2002:a05:6402:40cb:b0:659:4853:5382 with SMTP id
 4fb4d7f45d1cf-660f06dbdaemr1874810a12.32.1772655022124; Wed, 04 Mar 2026
 12:10:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com> <aaiNufodmq7l94ZN@strlen.de>
In-Reply-To: <aaiNufodmq7l94ZN@strlen.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 12:10:08 -0800
X-Gm-Features: AaiRm53hzYllwoOcVNb9iNEeYqSvIBRggW0yf9XSsAEu8_kyIXQilzxLYrNbejY
Message-ID: <CAAVpQUB5bpTS5oR6nEKU4bjnnTJaga5PFAjtZig6htoQnvtQHA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 00/15] udp: Retire UDP-Lite.
To: Florian Westphal <fw@strlen.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D620D20776B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264032-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 11:53=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Kuniyuki Iwashima <kuniyu@google.com> wrote:
> > In 2023, syzbot found a null-ptr-deref bug triggered when UDP-Lite
> > attempted to charge an skb after the total memory usage for UDP-Lite
> > _and_ UDP exceeded a system-wide threshold, net.ipv4.udp_mem[1].
>
> Thanks, I think removal makes sense.
>
> I'll followup with NF_CT_PROTO_UDPLITE removal once this has been merged.

Sounds good !
I plan to remove UDP-Lite bits in fou/gue and tc act_csum later.

