Return-Path: <netdev+bounces-288256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKoJAyLpBmpwowIAu9opvQ
	(envelope-from <netdev+bounces-288256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:36:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7109754C863
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B3130D884C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2B043C07C;
	Fri, 15 May 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt3/GBq1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF5vXZf+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CAE43C055
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836864; cv=none; b=aYKQrlForv0FBNdHaHweQ/egsiKgbqGkxBRxk9OQVVZxuqpwOTRSiZJo5bmJU4//qdfbpmFhJI9x4pxo2ZEfngzNMj64Zx3KqAYUuPHp5nnbZxobSxKpTdSa64ZofOmKOmv75mqKZ1xizH8LAbmm0xwMrSc9klUxr7tU0vqrDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836864; c=relaxed/simple;
	bh=kvhGlFT183z46f4prQv9UsB0406P5Y8xm81IA80kJuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yt3TgJiVk746Zqe+nWBsofP+q+xJ5HsUO4pQwzL9C5+IEXsuSl9WWBALkCsbqIzvFY1dWic1YRTAk5bI2WBzYae3ASpTmEx+z60djnR9WyKxer5jxYEsUhoIHaP1DcQEIh6J1VhbB2xidCdQFECd6bmx3xscOQsjNukhCktFMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yt3/GBq1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QF5vXZf+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778836862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=coiGVgNORCz4Zh3xYVYNCYPRQwJYgr83BYwKKI9/FxM=;
	b=Yt3/GBq1DO0niy895jD/jfvRihZNkjYC1Iz/5C4r8xAic17jM3wY4maSZfxHa70KDHdbNp
	+I2I7b+WeXYEKeMjaM/yraYSMJKLdGfQhhe4YRFxVWuobYY2ed5pMg+o3N93Czm6ZUGC8M
	VV59lT+T2+ALPsaCbQdOh30yC4hhvk0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Otf-iYdRNTSXlQXghtplzw-1; Fri, 15 May 2026 05:21:00 -0400
X-MC-Unique: Otf-iYdRNTSXlQXghtplzw-1
X-Mimecast-MFC-AGG-ID: Otf-iYdRNTSXlQXghtplzw_1778836859
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so984927f8f.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778836859; x=1779441659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=coiGVgNORCz4Zh3xYVYNCYPRQwJYgr83BYwKKI9/FxM=;
        b=QF5vXZf+qj2rP1C8g15kd1q9ts1TniBoPkpIWgHDfe2tGZpUePCoqt7J0vumweTA6y
         4Ocjpi1Cj8DeC8ceqScBo3eNSGCSx/STJk+1I+hgJwlQpQp9mDCXUz+TCpbc44lNOodM
         B4Qg/Wm62qq0enr7oUiXq2h2vj/Mdqt6pQB9hnntiebNTIxKJBZDftJ0o8ZEX2Exi5/p
         FrSqpCQ+3SbsD6Ar1rH0uzuhmMZtbxfuHRUom0RIIV1OB/nm67tLwWcnhAb4Pm8xKXzC
         tXjBmoYkn968WbjdicGNgcfblb9Vs81pgGEMEq5NqrX/pib126OQfAUkTUQHtwc2n+C7
         bY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778836859; x=1779441659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coiGVgNORCz4Zh3xYVYNCYPRQwJYgr83BYwKKI9/FxM=;
        b=XXKYMSKJSrz2omJEYueOkqMmJiCRTrhVz2QmiOYDqo/PEsXxeYUZ3O8edT77UWTT9V
         d3AWXKY45nsy4+/p5auwbFLyK7GnqOZpUQcGI9J1x5m1ImxjHgZP8DbzPYycg5uXiEBJ
         5PIeZ6XxQsz3a0eNuDdoFTrXufLZuY64TP01prt5pu8lJUw9oHqUVG4CXo7iI+aoEcJT
         I1PEtViR9X3bVAW0WpS+hyJa5HsIchRmzPskuzmlcZUGdzIVvO7x4OnFxbV78eSRaZIn
         ybeygVpZ8PYYH5UXi5dE4dYaAt12Bv5nyPlwFZ/qd05KoiJct1Ur9rPggTgMt/t+YJL4
         vafw==
X-Gm-Message-State: AOJu0YyJ/FOYSMCUsmWmKYGWpjgvmlPZwD3UcbUHXPO3iEhDeaNe35nQ
	0/uocGO+A7XYAO+i5JiA+DLrCgTa/WDmdFIWalYDqnYa+iVEH9vCdIR7p0JLM3ywPoeKyXsx7Q1
	wnfabDMSqNLi4ickP6Vv1Dazzi9Bt/TrASBDLr4CJ9TcNi0yrmellAO/Xbg==
X-Gm-Gg: Acq92OEXpvPfYyLFxTVRytaGuI6xL7vkVDvByeUDW8JFlQ4vDEX2B6RZsXotSELnQWs
	U/sP3UUGskcX6Nyl92tgdpJwXIlX9ACd4IdqsvRDDvyfUUGgC6UpyitmRDzfJ7TGXHnSwFmn85q
	17V8sQMwgdhuhCNXVTJPnGnz3ZPnZcwjFHhJ6bC6+axSAze2GySE202suDmKS3Kuxt8fpZwda6i
	C+X2pagdiDf/YZzfKVAHSkpr7QBKyAPqO2kwtrM0oePujn66g2yGnhP1PiylJgjSA2vFoi4R4fA
	56YLRYzMkhMcuNFrBuUvkD3WO0UHOrzjAPqYvhuhhFnC2Fc9xG2I4e4AOUxyqtQE72pptWyAclm
	sxj8Ov4P5aQSERTegqBhqeYZQewuEu1r5BFfg0KSRuPUojVTMf0U=
X-Received: by 2002:a05:6000:22c5:b0:43c:f5a0:4e56 with SMTP id ffacd0b85a97d-45e5c5f9d94mr3855118f8f.42.1778836858721;
        Fri, 15 May 2026 02:20:58 -0700 (PDT)
X-Received: by 2002:a05:6000:22c5:b0:43c:f5a0:4e56 with SMTP id ffacd0b85a97d-45e5c5f9d94mr3854928f8f.42.1778836856499;
        Fri, 15 May 2026 02:20:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm13634930f8f.10.2026.05.15.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:20:56 -0700 (PDT)
Date: Fri, 15 May 2026 05:20:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <20260515051829-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
 <agbWNqhzvEHVBvC2@sgarzare-redhat>
 <20260515043940-mutt-send-email-mst@kernel.org>
 <agbg-pUhBRB89aEX@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agbg-pUhBRB89aEX@sgarzare-redhat>
X-Rspamd-Queue-Id: 7109754C863
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288256-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:06:42AM +0200, Stefano Garzarella wrote:
> On Fri, May 15, 2026 at 04:57:41AM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 15, 2026 at 10:29:55AM +0200, Stefano Garzarella wrote:
> > > On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
> > > > > On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> [...]
> 
> > > > > >
> > > > > >
> > > > > > And so the bag of hacks grows. I feel this is energy not well spent.
> > > > > > Please, let us fix this properly *first*. And then worry about how to
> > > > > > backport.  Maybe it will not be so terrible to backport after all.
> > > > > >
> > > > >
> > > > > TBH I don't think this is an hack, but an issue we should fix in any case.
> > > > > Regarding the second patch, I see your point, but it's a big change
> > > > > that worries me. I'd like some more time to fix it properly without
> > > > > rushing. Staying calm without realizing that userspace is broken like
> > > > > we are now without this series :-(
> > > > >
> > > > > That said, evaluating further, I think we have a similar issue also
> > > > > with STREAM on the host side where the skb usually doesn't free space,
> > > > > so we need a merge strategy also there.
> > > > >
> > > > > So, I'd like to have time to fix both definitely. If you have time and
> > > > > want to go ahead, please do.
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Well my patch was a start, we just need a strategy how to avoid copying
> > > > everything, right?
> > > 
> > > Yep, and then there's the question of how to handle EOM without a payload,
> > > but I think that's a special case. In theory, we don't support sending it,
> > > but I'm not sure if POSIX allows it or not.
> > 
> > It seems to, but given we didn't allow it in the past, we probably
> > should not start now without a good solution.
> 
> Agree.
> 
> > Really we should add a feature bit for EOM to steal a byte from
> > buf_alloc. Or several bytes)
> 
> Yes, I agree. At this point, though, could we define a new protocol that
> also takes overhead into account, or would it be too complicated to
> synchronize both?

Well isn't it just X bytes per EOM? The rest can be fixed with
merging?

> > 
> > > That said, is it okay if I send a v4 of this series?
> > > 
> > > (I'm not sure if I'll be able to work on the merging next week)
> > > 
> > > Stefano
> > 
> > 
> > I do worry we are piling up hacks and we'll end up with races
> > for all our troubles. That said, up to you.
> > 
> 
> I see it differently; Patch 1 should have been there from the start.
> Patch 2, unless we completely remove the overhead, we should keep it, or use
> it to trigger merging (e.g., when the overhead reaches a threshold that
> depends on `buf_alloc`).

I'm not sure we need to merge retroactively though. Maybe just start
merging new stuff when over a threshold. Should be simpler.


> I prefer to send a v4.
> 
> Thanks,
> Stefano


