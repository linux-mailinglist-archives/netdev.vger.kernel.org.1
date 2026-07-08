Return-Path: <netdev+bounces-305987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tPH0HKy0Tmr8SgIAu9opvQ
	(envelope-from <netdev+bounces-305987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:35:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1099C72A3F3
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:35:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ip9XoIOX;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305987-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305987-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82830300CB16
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0833E51CB;
	Wed,  8 Jul 2026 20:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B43E0C4D
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:35:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542954; cv=none; b=YALVfa0xP+71K3YS9RlBtejAYUkvTRxRRx65X0Fecd2M9aHDm9wMy/I6DMZ40DiKWUIW/xMNqY6goTWt68ijuhNy4lho/mtecaKUJaE+ocTcVdLIN0tTk6Bh4Dxl9N8Delc2aCUgiIJ4PUvC/q4PWAHzYxhG7OjmiCzTwzakiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542954; c=relaxed/simple;
	bh=3I3mp7KJKi0CVH2nIGOLczzk5TWZIUatXfsGuzb8OvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnsS7BZ1AMxp7V2wTGPs4Qa8abHsqd6ThnJ+TboRfxIIBvjU5Yv1GYr7H+y9hG9Ga3o8hFPsdBVBaRmEr+/BbZgAT0EjfW9TQik2GXS9Veh+KLbXm2NNIY+UQOPoRuLPpTBXX3ENSLaubkAyQ07TxyBB2vKvD+AA1o40a3MoW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip9XoIOX; arc=none smtp.client-ip=209.85.160.45
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4513435cdd2so71039fac.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783542952; x=1784147752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=24xTmwwfHf8GGJ8ej4fMcb3MXrY9M9ELYMVJ6Iyw0KE=;
        b=ip9XoIOXuDEuy1U/8yUG9fQeLr/aaQuWlysRfx7lToefvfkhYNJivSwd1xNSjjl7hL
         clKp27SMWNTJuJijxX3seC5f5CETXySWxhrbnU7I+B08k5y2pJFSb9O2t4JpDHi2FXys
         M73WP5sC1BZigPbqC+7n+l++QsA54baGpliS1fJCymlKxIbsABlzNB/upmQKSMVbOQ7Z
         d0xdq247GSoaPXl3IRFZAsPej6qXUU4XMA7KWlE7LHlMT/PO2pLUtvv+daJOAns6HKZM
         852GFl9wavYTn/WJKiiIiBveGigDrHXL1Gn/S5Nv5K31K7O7cgVkcg50PH4LPLVzk0d+
         108g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783542952; x=1784147752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=24xTmwwfHf8GGJ8ej4fMcb3MXrY9M9ELYMVJ6Iyw0KE=;
        b=QzQRAGclPB/lr8RrFY9x50wroYaVlotRaOOV4xp9yj5TehcRU0M0b+Kb+Autkp3DuZ
         Vk5IzZng2njNGztlOu0Q1UqeRNhE/DRaFUbynPuUbX/ZAKlYTXkUIbT4+Zy2RodeReLh
         oHNcqhqcKRlEiXIaUEkU9UFfr/psTPdkjx5FbpY+Pa2QMbYkvSCtuNd+EEKXttwc0dSo
         FDn0zf68dOgxnkVFegdsW5UcbC9lZhS2E8RfPWw+22so8f1Pz4b/pg/uhUw95oaDXjTj
         pH3zCxucoKEXF9a1RdkWxHmGzh1iQxGEP8W2yQxg4rrGVtzjLc23TJbTKwRNVf0YL+2q
         wmiA==
X-Forwarded-Encrypted: i=1; AFNElJ9ERis+U750Fb5HKgJSxVCqIxhi7ThV2cYxxstjQqphWFdAuWZjjA7fcCUdK4I9YOqw/hRjo48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSAYNFipACG4fps7kiHTjFCg7hmwQ2Q09s3Sy4YPJRyIyMMuD
	mwiN/P4mObybLIBSDotjaB0s0n2FlV68gkPiHYZpMNpoSp1dhxX4/DMq
X-Gm-Gg: AfdE7clwshpl4gGBURGHC0k8I3xqagmmcg+Phn6or3WHGbDjOtV1VXrDb/gZ4pshkN/
	erfhCTTe5N9C+D2ULf7ICRSGlpj5uX1iQsBvYvpXhzwxTBAag5qbHsY/Uu2uQR8RFy+6wRTAdX2
	2OdzunjnGSQ2IqUepQqfgr8wG99PqlXHffWXav9YFziguO2HxQs3kOqZdajCf+bwpcYtoOQ6c7H
	uwlFlX1KHeCz1vw5J8B4mMHw+ZlNRDcQTwCyKWaF6C8kuElev8pfmForXpTYh+oqFhCYNuaz1Tc
	dzN+2RaQ2Yyx0qZIPSwbday59zjrLv3ET7Qj1mK9RqKIpeEZSp4mb14+zjIBpE7vqcVc3LNsDVT
	tA1MIlyZgLfmHJEqr/wL6tbF/U91rcdn7k/eXjhJRmjUfT7V8Qm+sk+I7qYSZNlZMFYWbgQeQ1B
	eqpoChsvOtbJLEunrz6I7TB9iCFH2ofVAD
X-Received: by 2002:a05:6808:6d8a:b0:486:4212:d728 with SMTP id 5614622812f47-4a206116affmr3560063b6e.43.1783542951653;
        Wed, 08 Jul 2026 13:35:51 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1afde6cffsm2535573b6e.11.2026.07.08.13.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 13:35:49 -0700 (PDT)
Date: Wed, 8 Jul 2026 13:35:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, matttbe@kernel.org,
	skhawaja@google.com, dw@davidwei.uk, Joe Damato <joe@dama.to>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <ak60menMXAbi/SCw@devvm29614.prn0.facebook.com>
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
 <20260701-tcpdm-large-niovs-v4-1-ca4654f37570@meta.com>
 <CAHS8izNdJ1LTOr_pLjXef6Yv-=JOFPe1GcZtcbStD93Tkpy1XQ@mail.gmail.com>
 <15e72c82-ca99-481b-bd53-744fabd503b0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15e72c82-ca99-481b-bd53-744fabd503b0@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305987-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:almasrymina@google.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:joe@dama.to,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,gmail.com,kernel.org,davemloft.net,lunn.ch,redhat.com,intel.com,linaro.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,fomichev.me,blackwall.org,iogearbox.net,davidwei.uk,dama.to,meta.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1099C72A3F3

On Wed, Jul 08, 2026 at 12:50:07PM +0200, Paolo Abeni wrote:
> On 7/7/26 10:36 PM, Mina Almasry wrote:
> > On Wed, Jul 1, 2026 at 12:22 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >>
> >> From: Bobby Eshleman <bobbyeshleman@meta.com>
> >>
> >> Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
> >> This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
> >> churn for large flows.
> >>
> >> Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_BUF_SIZE, that
> >> lets userspace request a larger niov size. The value must be a power of
> >> two >= PAGE_SIZE.
> >>
> >> Measurements
> >> ------------
> 
> Checkpatch complains about this separator usage:
> 
> ERROR: Invalid commit separator - some tools may have problems applying this
> #15:
> ------------
> 
> Please replace or remove it in the next revision
> 
> >> @@ -90,16 +90,17 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> >>         struct dmabuf_genpool_chunk_owner *owner;
> >>         unsigned long dma_addr;
> >>         struct net_iov *niov;
> >> -       ssize_t offset;
> >> -       ssize_t index;
> >> +       size_t offset;
> >> +       size_t index;
> >>
> > 
> > nit: I would keep this signed. Some of the most frustrating issues I
> > ran into is some of the underflowing and then passing a > check or
> > something. Although if the LLM is not complaining about this
> > particular case, there is probably no issue with it. I also notice a
> > lot of existing code that deals with indexes and offsets goes for
> > signed.
> 
> At very least the above change should go in a separate patch, as is
> quite unrelated from the rest.
> 
> /P
> 

Sounds good, I'll drop the type change.

Thanks,
Bobby

