Return-Path: <netdev+bounces-298785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8zYUH5BjLGpLQQQAu9opvQ
	(envelope-from <netdev+bounces-298785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE5367C331
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:52:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ta3AeayL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298785-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298785-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C94311096D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AFB38398D;
	Fri, 12 Jun 2026 19:50:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57510340283
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:50:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293820; cv=none; b=XDvgo7ZjBQMy6OV7GjEiNd2ZSHN2Adrfhh+Q4Dp51QatHvrv0U+bwIQOiBcdiU2sLyfWv1f7NJokB2gWiuqx8vr2dxIP2l/lidIs/4q9q4YsFRwy0ninjoVWgU/Ij0vKyoyR+FdzsXgs9wRj+JdMvoAlgbCwKSoMvDSipcj+l+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293820; c=relaxed/simple;
	bh=gX5y+wqAP96q+Fv7j8iUel+Mkqn2h3ystDL7w/XRTwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LRuicLa4Fk86k5Dme5lTX3deg1NsQWQqNFWVkR1wbTmNo3jvUypkiXgF7NGeozPdClsW/N2AfvwMnlBqxkxs25gMFsFOItMDGtXhXHVehAfYjLQEQQPcntO1Rc2uI8slgiI2KvsJjMg2sJ0X/FUGLYQsEU7b2FnmsRhvErpWNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ta3AeayL; arc=none smtp.client-ip=209.85.128.73
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490ae3bcf4cso6180035e9.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781293818; x=1781898618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yJtaeor/RMdRA8pDnzGdMSIMMP892NMMkV6Jr1/bAH8=;
        b=ta3AeayL5FR/ttBmcZBINLkdp+y//oHpmtd5Vwgi8QJxcE8ZMuFDqluHPvXBygtl3/
         mpgx26166EHs3WUyXUReIXBzqQ7f264lV+opppnt/oVcJLZBydgClhfuw6ufphaQIhaG
         12uBHY8yhO/40lpPbblPgP1xOCY8jKAX9MxmRVf6eXz+W2hAvyuakysHWrgdB5l5M3xK
         qKDsafO0UJIECWUvai9iE4quidiNL1PNcENTKyOq1X9VVD5t44+KOyTDdudGyQMKNwol
         wizsY0LhzRIOvQPUKpeR2611oLsUy2K4cYP7n/9d50m5+puWeMCH+aSPGkd+oLNeNX3y
         HEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293818; x=1781898618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJtaeor/RMdRA8pDnzGdMSIMMP892NMMkV6Jr1/bAH8=;
        b=B/TnCZdpXgaRzJD90cNTrTy5dXDdd7iB9dh3QB/oqo8HhOowVtV8O609bOXpE+j1Ml
         VTVkChQ5tpYQCHsKbX/GMIatiiKEoTwzIWCvqTnNbbru1JBWzFvDNj2Cc0F/fDduh9qw
         YXzdu/vrVQfyBpbKhJIJo7U9f4Vls/5ZPOSMgpCYysucfyXM+co8qLlwMEPF5ZqPyCv6
         64QtpgvAyQwK7vRzs5aWzrx6RtmNjSw6O6qdaQSX/ixkDeIK5YdeUDyGnM6/CnmJTvD8
         Qrv1nv6Vb4qPmgb1wZgjq4sZpeP5jBJB2L58P5TocEgeGROy+PnQsPtLGyTC0NJNKXVM
         cNvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oaHjAUIpeiUFqVbfe+Ew6oXEked+t7ezYzoVV4hkRbODJB9xFVhCjHyVgn30z9nWdAoEqWJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKq5qGEdkUvrYR0yNQmmLrAgHRuLIHiiTxjwo02NXK4aN+q6cs
	4vU73tw7G6sJcsCHqCeVbhke5tx2z84P9rjEwOeZvKcgWqMvsrxPY7tW2f6UBrRTXoED9lti1T9
	6cSERBueKbsKh6qJ3Ng==
X-Received: from wmsk6-n2.prod.google.com ([2002:a05:600d:8486:20b0:490:3fd8:77de])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1790:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-49220092ec4mr6888375e9.11.1781293817496;
 Fri, 12 Jun 2026 12:50:17 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:50:16 +0000
In-Reply-To: <2da031dd-4442-45b7-9515-72ffc60e8d8c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230413.D68967BC@davehans-spike.ostc.intel.com> <aipphZ5iCnbXVNSR@google.com>
 <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com>
 <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org> <876077cc-db6a-4517-9d81-cdfbb43e599e@intel.com>
 <CAJuCfpFh60wULMkFc7hzxWNg+qmZ2R_HMw_QZe5CNcDRFuoN6A@mail.gmail.com>
 <e9e196ff-7428-43bd-8e06-dc2cf0628c9e@intel.com> <CAJuCfpFo_avdhpOviX7EsPqLgDJ3DfeGpth+yu1-ahfawqaSzw@mail.gmail.com>
 <2da031dd-4442-45b7-9515-72ffc60e8d8c@intel.com>
Message-ID: <aixi-DxMuc0MiGeO@google.com>
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
From: Alice Ryhl <aliceryhl@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Carlos Llamas <cmllamas@google.com>, 
	Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@intel.com,m:surenb@google.com,m:vbabka@kernel.org,m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298785-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBE5367C331

On Fri, Jun 12, 2026 at 11:47:59AM -0700, Dave Hansen wrote:
> On 6/12/26 10:44, Suren Baghdasaryan wrote:
> >> It's not impossible, but I do think it is irrelevant. Or at least that
> >> the *VMA* is irrelevant in this case. binder_alloc_is_mapped()==false
> >> means that the binder VMA is gone. It's not in the maple tree, and it's
> >> not coming back. If a VMA is found, it's an impostor.
> > Right, but before your change we were bailing out early. With your
> > change we would be generating the traces and freeing the page. I think
> > that's a functional change. Was that your intention?
> 
> Yeah, it was intentional.
> 
> I think the existing behavior is buggy. It also complicates the goal of
> removing the mmap lock fallback. I've broken that behavior change out
> into a separate patch. (attached here)

I think you can just:

1. do a lock_vma_under_rcu().
2. if it fails, check binder_alloc_is_mapped().
3. if still mapped, return LRU_SKIP, otherwise behave like a failed
   vma_lookup() does today under the mmap read lock.

Or you can even skip steps 2 and 3 and treat failed lock_vma_under_rcu()
as LRU_SKIP because processes that unmap their Binder vma without
immediately closing the fd (freeing all the pages) does not really exist
in practice.

Alice

