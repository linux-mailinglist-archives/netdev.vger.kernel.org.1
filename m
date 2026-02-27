Return-Path: <netdev+bounces-261913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKSVBUDEoWkVwQQAu9opvQ
	(envelope-from <netdev+bounces-261913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:20:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D51BABA6
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A258F30078A0
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0709744BCB3;
	Fri, 27 Feb 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4fhsAcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5544B67A
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208836; cv=none; b=lLaWwpBG3oMP1bz7Q0oc7APoBjvWm8hiwOe+QxIXxnGJYPRkghZOYKvfcsMbBDJ0uOv0lRe8ijyncyEdlW1CPG4+EVpoOZPpl+t+/VqhPaJwqoT5J4tdTzbwlZdGsS5eX3O1OfxWx2xsXrENrd8G7KINv/ciPX9WlOdWJy1Tv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208836; c=relaxed/simple;
	bh=5N7k/OGyvNvB2Is+dOCWjZ2rAb+AlvIrewr8O6YU0Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmWb5L0jlv7WRXYZIbmhQqG5EyJTlf6oAG7N8QE4EULq+kVSipYbtXqyFWCzRyL9bHiLd6pO3yMrMhGU75W5LyZ0CIIAgOmvQFyVXcrrKUAsEFWVodwlOGMihLYce8CK2jvDxYltrWIxbk25l4XZ0yKMX8bUjQ1SytNbD1jg79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4fhsAcx; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64c9cabfe5dso2810280d50.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 08:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772208833; x=1772813633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wvGYMuq+DTIEbhPW+4wAK7O2eq7RAD+irx86VxuI7fQ=;
        b=V4fhsAcxMwwry68HpJP9ylasEEtzcHFJ+urc45TPzEBjGOA3fdiFxdKu6duVN94h+5
         8+SrKQdd4nuiXcWUAzfNrFzEHEOfILeMOvsuN4z96v1Bjp/JODmMczRxN/YEFP3xA8t8
         7Xsfs+2ixr0XCXuCvUD0lK/mT+p0DIrJYl7If6vPFCrWliIQV6RePXY0C/0hV7n2+BTx
         Cp73f0/U6LwBlMd9LR+o9gO49p+/vxYx1uq9mU9G/WRMWjiToA9JXHO+j3o9lJ5eVChJ
         /b6zpn34X7CHO8gV/kgszsQzpJACeHr0Tus3awFfvzuOSSXnavmNv6e5nVNwoM84ii/h
         8iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208833; x=1772813633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvGYMuq+DTIEbhPW+4wAK7O2eq7RAD+irx86VxuI7fQ=;
        b=sXvjUmXTpLbd/Jt0IjbG3Q5vY3GUcaxiGyrzqvCUMxXhZ08KKt7VnO/jOquFi+Qya5
         8G9Sjfb6TtnEo6RPdbzoE+hExNqlXt6AbWcKZiAJhiwD1PYW/s/Hup+lycJx4czT2On/
         Cwq4iJhXLNm/KKlGyDnp4CyxyyfYfaj/FVKBH+k8NjTNS/iMBiLS+Eee2eeAKD6SLjET
         X5cfb5iCCPEQ4tcZENt5r6k074XBkg5mMKXCNXXL5XBQm8wPd9iL2brek3LE7vtQUpRM
         xkL+y72GZcVGvDX5ZQ7H+YzzVJOC7Ew2SBro9L11G/Xie5Zp9M+6YNeU9d3wdMXjR4jd
         AWug==
X-Forwarded-Encrypted: i=1; AJvYcCUOdkuAceZeplkW4sZd+Te3urBcByGCBxDeVE3cu5YkYk/62xJuIb9e9vzxbdRnaxOsHBZWy3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxit6+vzf1ytxTvJyfRNtAUh4NKRqw+Hk8MlBchE0cQpYkdpbrY
	enS24d/K4uTLVY1SExshb+QxIxU2UhwsQi8OzdKuiwqlw1qYJdLyl+WD
X-Gm-Gg: ATEYQzyX01cZ1ASyfmivNxGya3M6nzRI3xx9PM1NR4iZzlIOCz4NTTB3k+wqOBBfcuc
	y6+o1zvUVp7r47hcuUYZqyhHsXFXnkyY090njUtRnwv3EICY+NXSN9t2jO4bRHXUVOMylJ2sUxx
	ObnGYSfGfQOotMgBGPY3RHp0iMTZeaNmMVY9mduBeXGeu8jDnv/lvDFqFlUhPhnVvgJkAoJakF3
	CJWLr8JfrqKoJBPEKaF+edZXUk6OBWA5hiHdzijUFOQJ60KgcRL2BkjewC+YyOlJ+WTT/xnItqF
	3pUtDSJdCC7wjklP6EjGrTM361RZSq7r6BqAb/uQIjlXV+8RamywMoYS06q6lnEyMhyTF8Ik8nP
	r44lnwxGXi+o53XJMzaBsdGeRFyxV8AzxTMRMc7YSOWD8i4JNUFGv6X3ARznkqHChcs99ybn/la
	WdwLHyis0yzPjCTWwEwMyVvHOVRpNY0CbQJFobL/uVzO2ZHQ==
X-Received: by 2002:a53:ee51:0:b0:64a:d18e:7e81 with SMTP id 956f58d0204a3-64cc2ebf559mr1746274d50.12.1772208832782;
        Fri, 27 Feb 2026 08:13:52 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7657698sm2527943d50.23.2026.02.27.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:13:52 -0800 (PST)
Date: Fri, 27 Feb 2026 08:13:50 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
Message-ID: <aaHCvoskaft4KVL6@devvm11784.nha0.facebook.com>
References: <20260223-devmem-membar-fix-v1-1-37dcae1e49f8@meta.com>
 <aZ5VNkUqkTEzX6PJ@mini-arch>
 <aZ8R5n80NmnPb1J9@devvm11784.nha0.facebook.com>
 <CAHS8izM9gS+4rKaxSdqx3yjn4harxKQ2HeCszPyq6XNbq+UcMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM9gS+4rKaxSdqx3yjn4harxKQ2HeCszPyq6XNbq+UcMQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-261913-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 7F4D51BABA6
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:31:48AM -0800, Mina Almasry wrote:
> On Wed, Feb 25, 2026 at 7:14 AM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > On Tue, Feb 24, 2026 at 05:49:42PM -0800, Stanislav Fomichev wrote:
> > > On 02/23, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > > binding->dev is protected on the write-side in
> > > > mp_dmabuf_devmem_uninstall() against concurrent writes, but due to the
> > > > concurrent bare read in net_devmem_get_binding() it should be wrapped in
> > > > a READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations play
> > > > with the underlying register in unforeseen ways.
> > > >
> > > > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Looks correct to me, and AFAIU Stan is right, we might as well
> annotate all the reads of ->dev as technically there could be a dmabuf
> uninstall happing concurrently on another CPU. I also think it's
> probably good to annotate potential races.
> 
> The ->dev write in dmabuf binding doesn't need WRITE_ONCE annotation I
> guess because it's initialization, it can't race with any reads.
> 
> This makes me wonder what other fields in dmabuf need annotations. I
> hope I didn't miss many more.
> 
> I would add this is really not a critical bug because
> net_devmem_get_binding() is in TX path, and it is more than fine here
> if we fail this check if there is an unbind happening in paraller with
> sendmsg(), but it's probably good to annotate potential races anyway.
> 
> -- 
> Thanks,
> Mina

I also noticed in tools/memory-model/Documentation/access-marking.txt
section "Lock-Protected Writes With Lockless Reads" it is recommended to
also use ASSERT_EXCLUSIVE_WRITER(), with explanation:

"The purpose of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check
for a buggy concurrent write, whether marked or not."

Do we think it is worth adding here? I'd think so but didn't want to
throw it in without checking.

Best,
Bobby

