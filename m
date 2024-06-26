Return-Path: <netdev+bounces-106820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C3917CE2
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2893B25F6A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC14D16EB40;
	Wed, 26 Jun 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGlwwf4M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BE15F3E2
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395370; cv=none; b=XHvEu7/ESakGkqC8hZ1KpvNcX2aFRL0T1bVbxGM2E2avKt9nV0pyWIvyuGuDRnnBuULnP3yuhiNWRsyKEd9VOLVpcaXXLUUDU7kkGjDKIU5EJrwjJo20iXsyAL7igLfW9cpm7p8Vj4V2FGlR1+u5sYDM4lcR/Of5/gxvGkLudCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395370; c=relaxed/simple;
	bh=DWIGWxbl+woKwQpaluXg5n45wCq4JDHrOc+cad4B7fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEppGlEaY0KEkIxbR7m38/fSKSPhGZdpX0WXCp0y8vso6PBq9j7X5SP2Pi3B7763qZ82HPkcYmjvhStXuNYoRQ159/G4K8GQZVuevK2PScMxn9Worbmpz/BOAhLz70stbuGgMJnEFBWDKvjfNALr4MbsRXq8C7L/Olumwp8VMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGlwwf4M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719395367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4djDjoucdiNC3v37pUz0oafRQ2jw1kRnVn3jy6AlRSM=;
	b=RGlwwf4MDauk3BlSkhGH2BfVP/vqR9Aytupo3vwgH3QUSYNbJ/z+1ZWVnDuxn63AhBdQsj
	x6lOpcJguTeVVbz+zcIgr3Hja/aMMPMa/dGIY3bh7v+V9xgCim1ZkO2GcskNnSpVWjs7qx
	V7PsqbBGfangMgMcdjAA0jF2eUX4ylU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-kcO8hFLJNJyRCmMQMCbtTQ-1; Wed, 26 Jun 2024 05:49:24 -0400
X-MC-Unique: kcO8hFLJNJyRCmMQMCbtTQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-422a0f21366so11238585e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 02:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395363; x=1720000163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4djDjoucdiNC3v37pUz0oafRQ2jw1kRnVn3jy6AlRSM=;
        b=GCH+jr91fE3i9HE2t+ItVXY2nFaaH4MsLQ2HFRIhK9Q/xdP/SnF1QXrXi9py8IZhrP
         9Us36YxKqNdBV2Q7Jx15RLLX6QXMG2q0VEuvWceLcppgkePOpzPD2dPNYwldx4uiXhSp
         7FR+nHgWZreK/DS3IrjNmQ45XK4XoX4/o9c7LBCgizEt8AD5hfcPFO3scGTKw06BqBCB
         OqM+18LA4SeGga6mYPiBi1KP1eaPG2UiQw/zJr7h0YmNDz36ZzVRga2h2PY3DytpY6uw
         lhNV9Omhm5SX0VH8J2roIgrOf2Tr1te255wM+5AjB/N+3vhfZMktPqgtWNTvNNQOukzI
         RqiA==
X-Forwarded-Encrypted: i=1; AJvYcCUApvxlzr5UeecATyFt8NJGg8qMnvVaaHU4ZVht7j7WoSSdQ1tS/O+MRAE1gtLkpJENBjHlgIZoko14/yD+Mc2tfA/iJnzh
X-Gm-Message-State: AOJu0YxBPkd7vtx7qk94LxmnQIF/RK2OjMZmDxqquuBm+JbAG/G9vBf4
	q0SClOjo8tiYzN5ydPjfJNvHBsnmRxKK3MzjriUkADWoOevZpW9XXLbp2mjlMkx7v2ek9sCBjTb
	gOBJZVypN/DHC6SMW1sckwW34Itx+ZxtEGNNIXdt869IpPBjqug+IMA==
X-Received: by 2002:a05:600c:4a21:b0:424:aa73:83db with SMTP id 5b1f17b1804b1-424aa7385d9mr16426445e9.3.1719395363234;
        Wed, 26 Jun 2024 02:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/3FLpYFj1lNUdvagVZ//NSmf/wAzF1F50kld50FSwNHiB4Iwf5oXPdzRER19Pywz3nR5htA==
X-Received: by 2002:a05:600c:4a21:b0:424:aa73:83db with SMTP id 5b1f17b1804b1-424aa7385d9mr16426215e9.3.1719395362335;
        Wed, 26 Jun 2024 02:49:22 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f696csm15283695f8f.82.2024.06.26.02.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:49:21 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:49:20 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/9] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
Message-ID: <ZnvkIHCsqnDLlVa9@dcaratti.users.ipa.redhat.com>
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-3-ast@fiberby.net>
 <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com>
 <0fa312be-be5d-44a1-a113-f899844f13be@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fa312be-be5d-44a1-a113-f899844f13be@fiberby.net>

hello Asbjørn,

thanks for your patience!

On Fri, Jun 21, 2024 at 02:45:28PM +0000, Asbjørn Sloth Tønnesen wrote:
> 
> Could you please post your iproute2 code?

sure, will clean it up and share it today in ML.
 
> > from
> > 
> > https://lore.kernel.org/netdev/20240611235355.177667-2-ast@fiberby.net/
> > 
> > Now: functional tests on TCA_FLOWER_KEY_ENC_FLAGS systematically fail. I must
> > admit that I didn't complete 100% of the analysis, but IMO there is at least an
> > endianness problem here. See below:
> > 
> > On Tue, Jun 11, 2024 at 11:53:35PM +0000, Asbjørn Sloth Tønnesen wrote:

[...]
 
> It is always preferred to have a well-defined endianness for binary protocols, even
> if it might only be used locally for now.

given the implementation of fl_set_key_flags() in patch 2,

	key = be32_to_cpu(nla_get_be32(tb[fl_key]));
	mask = be32_to_cpu(nla_get_be32(tb[fl_mask]));

when fl_key and fl_mask are TCA_FLOWER_KEY_ENC_FLAGS and TCA_FLOWER_KEY_ENC_FLAGS_MASK,
I assume that we want to turn them to network ordering, like it's already being done for
TCA_FLOWER_KEY_FLAGS and TCA_FLOWER_KEY_FLAGS_MASK.

So, we must htonl() the policy mask in the second hunk in patch 7,something like:

@@ -746,9 +746,9 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[TCA_FLOWER_KEY_CFM]		= { .type = NLA_NESTED },
 	[TCA_FLOWER_KEY_ENC_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
-							  TUNNEL_FLAGS_PRESENT),
+							  htonl(TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK)),
 	[TCA_FLOWER_KEY_ENC_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_U32,
-							  TUNNEL_FLAGS_PRESENT),
+							  htonl(TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK)),
 };

And for the same reason, the flower code in patch 3 needs to be changed as follows:

@@ -676,8 +680,10 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_KEY_ENC_UDP_SRC_PORT_MASK]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_UDP_DST_PORT]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_UDP_DST_PORT_MASK]	= { .type = NLA_U16 },
-	[TCA_FLOWER_KEY_FLAGS]		= { .type = NLA_U32 },
-	[TCA_FLOWER_KEY_FLAGS_MASK]	= { .type = NLA_U32 },
+	[TCA_FLOWER_KEY_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
+							  ntohl(TCA_FLOWER_KEY_FLAGS_POLICY_MASK)),
+	[TCA_FLOWER_KEY_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_U32,
+							  ntohl(TCA_FLOWER_KEY_FLAGS_POLICY_MASK)),
 	[TCA_FLOWER_KEY_ICMPV4_TYPE]	= { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ICMPV4_TYPE_MASK] = { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ICMPV4_CODE]	= { .type = NLA_U8 },

Otherwise it will break the following use case (taken from tc_flower.sh kselftest):

# tc qdisc add dev lo clsact
# tc filter add dev lo ingress protocol ip pref 1 handle 101 flower ip_flags frag action continue
RTNETLINK answers: Invalid argument
We have an error talking to the kernel

because TCA_FLOWER_KEY_FLAGS_POLICY_MASK and TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK
are in host byte order _ so netlink policy mask validation will fail unless we turn
the mask to network byte order.

(And I see we don't have a tdc selftest  for 'ip_flags', this might be a
good chance to add it :-) )

-- 
davide


