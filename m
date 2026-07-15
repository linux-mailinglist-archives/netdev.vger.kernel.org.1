Return-Path: <netdev+bounces-307709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CG0POx5GV2rYIQEAu9opvQ
	(envelope-from <netdev+bounces-307709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:34:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D8A75BEEC
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:34:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CQi3XJmN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307709-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307709-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C4D6301BC1A
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700D3CD8B8;
	Wed, 15 Jul 2026 08:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B6362130
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:32:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104347; cv=none; b=WZNw7SegjlsUKOOsaskGir7rIH7g4mrRbMrWv9ETGcOkzWbsoWzJPexzO0GZodPS8S95/mCHy1jmDLb4VBu97kRl4qW0I+70sbYmad7MFUlTUXXHY+hfsQRUrgqJF/yojGcqd7x5cveMQ0Z1AD5QBMvVyz07e0qj+M8Y1NEbQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104347; c=relaxed/simple;
	bh=f+aSwlQd0H4yMA4ovXfX93LCkoOi83P327MTt5nGdKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFxMsEdeNkbk/Y+HtBmVFgkaCqJ5jXAkc2FblTlbxJHN8R/o74TFskbwvETZ5NctvgquM4e/i6455JrJnkgJUsiX46duWiBRaxCA0NNOiSqxteaFZLxMjBNo1bpaUVfvzFJq84FG622kGHROVXzUecr9p8NACMW7JGtYjnq5z5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQi3XJmN; arc=none smtp.client-ip=74.125.227.128
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so35344445ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784104345; x=1784709145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AvK4rlZieqdDEX/C3RF2OhSiSp9tIt5loVtN+a7NID8=;
        b=CQi3XJmNJVCpuMwkWQVonmAV1b35uWn30IQUN7O0kT79rSNY5GtPxCW4mhSuUEbx+/
         pOZXE+X7vh4MQ3nBlnKUTBiBW3/AQXtQhD0i/oHj1mLoxlENbQ3+r/3XJYi2KmdMx93L
         9UMaNXySRfctfxF1qw5urrEMTcO3YjXpQDyujYQ9eSaw3DAolYEJb+7NB1lIJGTQcVhS
         lK1+D1RQ5zNq8K84sUo+dV4GWQgD2e3MC3mjx2BZinetJyucfuvqB9OtPzvOnLhRLPSF
         QQ1LrDTjDLPjGB7hsiLazEd63POzx8c9d25wmltiqNDbQNyiyx8GOvKN3VyumK0aAP0U
         FbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104345; x=1784709145;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AvK4rlZieqdDEX/C3RF2OhSiSp9tIt5loVtN+a7NID8=;
        b=gA9ZQI79Vl0WMUodXdyTeD7svC8Vt4x/rIEmdqpLeVC7yUQj/OZ0l2ZMrsA5yJwQkP
         AHStMcShm+Gb9dnmOyndoLPY6KUpf9XQeSeucx0VICIZ3+Iuf6zNFTECNeqC88gE57EW
         +psoJPvr7iD6aWF9OLHKDzhQjMQ+whV8VaLhecFhQnt4fEdITm4d+TUFUQz+72yLaybr
         YhWMANou7uPZgvAtnHaKp20UIl4yrmtrXKx4P0KxOeUUUdrf30umj9ySvqtwzsafPqA2
         9Po3uPrL4PWVmWk6X8dxBDcc4DnT3GZguntku3gFkHyw6nDMQ1t+fXVyJWSbPMS+jta/
         OnCA==
X-Forwarded-Encrypted: i=1; AHgh+RrcBm4rT/VEC8uBV11IQYhkHgo+gtzXgABC7bDlleeG9PdoiDYRb9G1tLJ175qzywHo8VW7uUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytTdKdGWhvHszDS/TjSI6MUG0TP9/3LGkBnDGn6Rd6D5qs52Ib
	v6KtaMw3FRyG0FPQiHUP9GSRhpecIyvKCb3XR6K+k1nzEXW+FHIWL6PB
X-Gm-Gg: AfdE7cn6NxsWtdjnn7V3rjFO3HUrtC6LbBkittH64NyQXoJL3/HKNjlift18vlfNTmX
	ZYHhKno2NxVvJBdA2JbD2Nwu7MvxjLOa5p2awzusHph+qDPNIisXrTrBaamOqiz+1KOpTDj0liy
	JDfr25KKE5nw3y/1h9B+VDRdJ0AkcQxRDVVJP9bfbf/S7r488sReFrcSjgf6fxEIV+pLP2vzAYv
	d+GgQUR16pq3aM8E3wtj6LKR3Lkb3XWqEkx2yTLllJcdAUF2gTXHO992MEhaWbBmJFuUGYI5iie
	Ck2FZmo+VojA4Coe3Hx82YHUM+tO4KfB4QUqPv5ct65p1yyPCuADI+gy3bB/qtWf5Qco5O6i29d
	b0DlwBB+KU9BDzFXRPwKfC18sObVB6sLjM2XF1BeBpZjXtCQWrBqXUkPBOYZx3hdw8zWtbW0FCG
	6EdXzL
X-Received: by 2002:a17:902:d4c7:b0:2cc:6817:d9b1 with SMTP id d9443c01a7336-2cf03df6a24mr15483195ad.41.1784104344760;
        Wed, 15 Jul 2026 01:32:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb75fsm129307865ad.8.2026.07.15.01.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:32:24 -0700 (PDT)
Date: Wed, 15 Jul 2026 01:32:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aldE7W4T_ylUTLv5@devvm7509.cco0.facebook.com>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-2-deliran@verdict.gg>
 <alE8oBxkrak8n602@devvm7509.cco0.facebook.com>
 <alZtI782RGKb8y4Y@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alZtI782RGKb8y4Y@lore-desk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307709-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:deliran@verdict.gg,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:shuah@kernel.org,m:maciej.fijalkowski@intel.com,m:jakub@cloudflare.com,m:aleksandr.loktionov@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kselftest@vger.kernel.org,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[verdict.gg,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,verdict.gg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72D8A75BEEC

On 07/14, Lorenzo Bianconi wrote:
> > On 07/08, Vladimir Vdovin wrote:
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > 
> > > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > > checksum will be use by devices capable of exposing receive checksum
> > > result via bpf_xdp_metadata_rx_checksum().
> > > Moreover, introduce xmo_rx_checksum netdev callback in order to allow
> > > the eBPF program bound to the device to retrieve the RX checksum result
> > > computed by the hw NIC and reported via DMA descriptors.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> > > ---
> > >  Documentation/netlink/specs/netdev.yaml |  5 ++++
> > >  include/net/xdp.h                       | 18 ++++++++++++++
> > >  include/uapi/linux/netdev.h             |  3 +++
> > >  net/core/xdp.c                          | 32 +++++++++++++++++++++++++
> > >  tools/include/uapi/linux/netdev.h       |  3 +++
> > >  5 files changed, 61 insertions(+)
> > > 
> > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > index 5f143da7458c..6d0d90d3a614 100644
> > > --- a/Documentation/netlink/specs/netdev.yaml
> > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > @@ -61,6 +61,11 @@ definitions:
> > >          doc: |
> > >            Device is capable of exposing receive packet VLAN tag via
> > >            bpf_xdp_metadata_rx_vlan_tag().
> > > +      -
> > > +        name: checksum
> > > +        doc: |
> > > +          Device is capable of exposing receive checksum result via
> > > +          bpf_xdp_metadata_rx_checksum().
> > >    -
> > >      type: flags
> > >      name: xsk-flags
> > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > index aa742f413c35..e255ff786131 100644
> > > --- a/include/net/xdp.h
> > > +++ b/include/net/xdp.h
> > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > >  			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > >  			   bpf_xdp_metadata_rx_vlan_tag, \
> > >  			   xmo_rx_vlan_tag) \
> > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > +			   bpf_xdp_metadata_rx_checksum, \
> > > +			   xmo_rx_checksum)
> > >  
> > >  enum xdp_rx_metadata {
> > >  #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > @@ -643,12 +647,26 @@ enum xdp_rss_hash_type {
> > >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > >  };
> > 
> > [..]
> >  
> > > +/* Please note the driver is required to invalidate the checksum if the NIC
> > > + * reports CHECKSUM_UNNECESSARY or CHECKSUM_COMPLETE and the eBPF program
> > > + * modifies the packet since it can change some fields validated by the
> > > + * checksum.
> > > + */
> > 
> > Sorry, a bit confused about this part. IIUC this is in response to this
> > discussion https://lore.kernel.org/bpf/aaLYfWnuuf_ne72u@lore-desk/ ?
> > 
> > Looking at a few drivers:
> > - bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
> > - mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if there is
> >   bpf prog attached
> > - fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
> > - gve (gve_rx) - can do COMPLETE even with xdp attached?
> > 
> > So none of the drivers invalidate anything (and nether the bpf machinery), some
> > choose to (correctly?) not report COMPLETE when there is XDP. So was the
> > discussion about documenting this and giving some guidance? This probably
> > belongs to that `DOC: skb checksums` section of include/linux/skbuff.h?
> 
> Hi Stanislav,
> 
> re-reading the previous upstream discussion, I guess we should just document the
> expected driver behaviour (invalidate the cksum for both COMPLETE and
> UNNECESSARY cases when the XDP program running on the NIC returns XDP_PASS) and
> add a given kselftest for it. Agree?

Yes, let's have something a bit more detailed about how it works right now
vs the expectation.

By my point is: the comment in this patch also seems wrong? We do not seem
to invalidate the csum, we just disable COMPLETE when there is a xdp program
attached (or I'm missing something).

