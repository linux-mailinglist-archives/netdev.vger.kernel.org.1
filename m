Return-Path: <netdev+bounces-307403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KzMsDL/9VWr9xQAAu9opvQ
	(envelope-from <netdev+bounces-307403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:13:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D10752B55
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:13:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=osBm2kkJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307403-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307403-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 976E8301BA79
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F009943D4FB;
	Tue, 14 Jul 2026 09:13:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748243CED2
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:13:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020412; cv=pass; b=tZv6WGmbSiDp3DxIALZ+uKhrmz1prthyfGCUMmWt3xtpEI7CwDhtCHTMazrCKKZ3CEbQAiWStIdixzrE6by0qCtehdZIGbK4XMcBHCb9MceTsmtnMXhMb886hOVgr73xiWfjGtZSxkO3/ynZsxxrAOjhdFLurXL6IUwCc1sCKcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020412; c=relaxed/simple;
	bh=KAWPuA1M07BhQOglpD9tESCiutl9pSJ8ZzI3k4u1tHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1A6AoVIpdCDbpEeoJ+Gz+sPcr0gGHlerpVCHRfMQW7qZ9wwY0xdNwuz/NlombOiWPEL9K7Fh2JZLRz1P+EgeauoZyRkCbJh18/0tkgKebNR2T1PzqmhyaEvRpzLVAKIqC2FQTVjLW1LBMLhcCKhWvzFT5D+GI885tE5tfpayvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=osBm2kkJ; arc=pass smtp.client-ip=209.85.160.181
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c16ac21acso5143451cf.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 02:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784020410; cv=none;
        d=google.com; s=arc-20260327;
        b=NxP3ApDA6iL1H+yXINun0AkZ9PSp0xun1Ft0mD5JAl2xdocvNCoLNtNQk6rjyYazsc
         G6quztR2BvfrKTEy7JdaA3FHwd3nzzTkZn9ixKtT0dXKaIvDhGiOlF7Xe4bkq14jnyIg
         tRGQS0XMXknB+l5ZpmhPdh1mL2urQeaxsGdPhkxGLTtZa+bqq/7esWg9ap6AJ2emrvNH
         vL8VZko0AydTTUgh9ERIEmt+Wq30niuKDHEdV5OTKVWz3VvsFby6OHpt0wEe9g1Cle3C
         fpOdGAWe9j1gwFjzQhXvT8EinYJIcawcq8tHjzmdNVAwi/jQdj2i6aO2XqeGd9kMx8H+
         BLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KAWPuA1M07BhQOglpD9tESCiutl9pSJ8ZzI3k4u1tHg=;
        fh=885/7SiTzwGrGIC0Mah1A1iR7RfxCDhbnp1/S/qqBfM=;
        b=P+Axjjt0nau5/VFXusxj05SVxMmlLLGh2Z1OHAzPftUPuh79cDyX1IxYYThxrtPj6i
         NhZg44OQQFdgBNk8LyCbbmqhz2NpBfRKtYa6rPvgpXTG7FwguJWPbG8/HNSBOvmvBBG7
         wCL0Y5zqlWt+CID7vuRC/F/6h9XC8sYO/DBvO2sDo6gJS21uwb2/KIV32p9eiiBgY6q8
         S+nGL8nroepoQE8Gg8slC8oiqekf5CLEDkwWuBbuq+ZHNlLw0h4k4ZZBBVRP6YmeQbRl
         +b67wpELMIGY8vll7/vGy6hf1m2PSMJK6rGiyBLBSk8nD+LbY1PTOJM33n6ogZiz++Gb
         Iblg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784020410; x=1784625210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KAWPuA1M07BhQOglpD9tESCiutl9pSJ8ZzI3k4u1tHg=;
        b=osBm2kkJg/gCtOqVsfksOghu+G5PaV9udJNjYSZUi2ALQ4BBb4Ks2DKa7K2iG4og2C
         p4iOsjNr+v/KS6olVLpSZr/PW3bepOevuYCMmlzTVDAqlNFotiuDPyz4jCGM/UUmrOn3
         NY1vX43j2mQgoE58GqLTB5KWGzx9/qenuc+cSdvyXOynEITmsYfkHGm7QMLtD5V5A0/x
         IuYnAL6NmpUlCL4Mrfr7WPlb1ThCiZLvk5GlRjbwNDOyEnlWwnNUn8BIq29TkJS98N64
         jGRu6x8kJ/uCilwitKF1ZHJB5NJTkAywkNUQjnWseI7GN8KAvvBfVfWBYRyL1WuEj+33
         DdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020410; x=1784625210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAWPuA1M07BhQOglpD9tESCiutl9pSJ8ZzI3k4u1tHg=;
        b=MgVDc29DR4CgAn5Pz8dzlPrkN9KPwxqw1UKYrjulkDeyFm50ZzHcyXHnWzIq+N8YNc
         iXGwSTSof9tjtPMVPsbx179A5YdWYm0Ew39VUjnPIe19/idrR3rNVrdbyK9+NEc0W0vh
         0s7ArH6uTBMPe/xUfXNonfge9c+rNNSqVAiysFCFyF/1gj7tiz084UF+dc3I4cirBR9O
         +Zf8UUM5THn/aaffHD2rQlI2+a+/M9o/44x/rnqrxIUkXc2/AK3565L04OcW2+AaAcsk
         l1qpZm4gMunz9o93PDOSHNBg1Du8kaU5aFtQ+qDTiUZ2ZdsSk+He6nVRRAZCeu7YS3AL
         rq6g==
X-Forwarded-Encrypted: i=1; AHgh+RpGLkI8whq9qDvwPiUqZjtKw3LdDh5ZrpYN897PS0W7XILtmkjzQdOAdDHDLk4n6h40XELZWVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbbiOPq8jVnZ5O3Wr9ppOsZhp4VGuodXXJnmMW6QBBRiPa6rx
	hk6ovh4d4QuY4j2VTvw1vuiiE7uHBXGl5ghJfv0lSsL51wW5UtN15NTBvb222ygYUmR7Y56HIqJ
	u7RPe0mbJBhR0Mu8a7fp/JZec0prsK4WM5ov2dgCD
X-Gm-Gg: AfdE7cnSWpaVgjUhqVlaVpJvuOoMGl9U6Va4hAuajX28uRGCs/sIRgoUR083tkuxSmJ
	+RXCMzuDqufDPhUzTSjLNqDS+H9P9iBYdys5rnPBh4rTu5cpz3FqGIl5zqcJdxWzyfvbo56QhcS
	PROOHYTNvzBtzsAarJFtaDuoI7khrzkqw6FAuKSF+WD+PRzz2uGZEy/Fa26RhEfUFPt5rK4KvTW
	I4dGk3uBG8f2RMjpSOXiqVZYVOP2IWCkEASdTkal+RfHWaLD41XCpsL/1uqHFuRWH41pXzwyPZI
	3DosSq/uaYs6goGGH3ek0wFs8okylU0Xn/kkOLn5XVqG1+S+9/rELpb7w6BzObmIgUrGH79niE0
	tAUHI74OmMSw=
X-Received: by 2002:ac8:5710:0:b0:51c:15c5:2bf7 with SMTP id
 d75a77b69052e-51cbf05b838mr114112991cf.12.1784020409735; Tue, 14 Jul 2026
 02:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713233230.3553593-1-xmei5@asu.edu>
In-Reply-To: <20260713233230.3553593-1-xmei5@asu.edu>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jul 2026 11:13:18 +0200
X-Gm-Features: AVVi8CdUge_r3MDnwBk1ze871ePVoddpU4H15_irkbqp4L3bN6ocl-OjeezJpG8
Message-ID: <CANn89iJsDMJR_hLyENfrfjmD3ttt-b6WibrPHK+hHQVWra85yg@mail.gmail.com>
Subject: Re: [PATCH net] bpf: tcp: fix double sock release on batch realloc
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Jordan Rife <jordan@jrife.io>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:jordan@jrife.io,m:martin.lau@kernel.org,m:sdf@fomichev.me,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-307403-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94D10752B55

On Tue, Jul 14, 2026 at 1:32=E2=80=AFAM Xiang Mei (Microsoft) <xmei5@asu.ed=
u> wrote:
>
> bpf_iter_tcp_batch() releases the current batch via
> bpf_iter_tcp_put_batch(), which drops the socket refs and rewrites
> each slot with the socket cookie, then grows the batch. cur_sk/end_sk
> are kept for bpf_iter_tcp_resume(), but on realloc failure the function
> returns ERR_PTR() before resume runs, leaving cur_sk < end_sk over
> slots that now hold cookies rather than sock pointers.
> bpf_iter_tcp_seq_stop() then calls bpf_iter_tcp_put_batch() again and
> dereferences a cookie as a struct sock.
>
> Empty the batch on the failure path so stop() does not release it
> again. The sockets were already freed by the first
> bpf_iter_tcp_put_batch(), so nothing leaks, and a later read() rescans
> the bucket from the start instead of skipping it. The sibling
> GFP_NOWAIT failure path still holds real socket references and is left
> for stop() to release.

Reviewed-by: Eric Dumazet <edumazet@google.com>

