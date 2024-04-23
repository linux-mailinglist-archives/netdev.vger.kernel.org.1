Return-Path: <netdev+bounces-90628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A468AF57E
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DC0B24C40
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA813DB98;
	Tue, 23 Apr 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLz8eO46"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651213D8BE
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893145; cv=none; b=M8ohF3vh/s5Mrh/60TOyFl+hYG+93QWcqHFX+HSgvfOqBJXorqIjqk3UZ2fqWrVaNu2OlLu9T9NncUmNDmklU6p74kDCaHvXmAk8DofMzavdMxUgc7FEHxIfdfWoMtoQ5WuONNflVKSr6+Tc2yuGZszacAaGgImpl6Ko1Q+c6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893145; c=relaxed/simple;
	bh=bOEsH0iPOIpWP6TE3bIOCad7k//K2mp+hslR/5EQT2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5hAxyDVGpuZWwPpGZLHGzHVmvoJX/lc4gp/ofpW8rQRr/RbCSiG0sNOm/MctIAKIXNXL7QFSM6heYFO3/hPmMPxd6dlSsedYIr8WuH/BxJzPiOA/QOOy23XYS0tlqBFm24QuAub8zKW+0GcC9GXsxr6RY5To1sKxhuvGzJlTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLz8eO46; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713893142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OAyafxbBfPXNG4duQ8T05vTAmiPLJyM4tEtBIC2PDm0=;
	b=KLz8eO46BaPNHZVNF9E1gGZSyWmoGZQXE9ZfwVyTBlNxUGc7QvgfcZtedKNqPBQdCHGltl
	lqB+FzwD9nt3qmrNPzOVAHM/YdD2gc1Lxqn0MsSbrFEvAPEd853pYs2EzEN+77W6cTag7v
	KVYJknrkZkCB4qMzmS9mOYyRz3PFjJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-qm3GFOHBNc6vU9U3YIsTIg-1; Tue, 23 Apr 2024 13:25:41 -0400
X-MC-Unique: qm3GFOHBNc6vU9U3YIsTIg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4188d1b90c8so336565e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713893140; x=1714497940;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAyafxbBfPXNG4duQ8T05vTAmiPLJyM4tEtBIC2PDm0=;
        b=ZlJJvSQOip8VsMu/2Re+cQ4KhVmSs+Yx+Bnl1tn3sg/jlbkDtyj1F6uorlxXUyoaXQ
         pZhTX6viXDJgMqJX2Be3DU+J6d2ZBx189q0HHSh3IKukBUR/K9LEqisWn8VjjBZwiK9C
         1zBt5Wy1Uu4bkiFlzDdFJMNxk3Urqqy8G+d52xYw0eDyRDMpEIWvZAll+6jE0/LxYalV
         j4DyxyGgsWRIHAknQHm0Q1Tja6az4mpASDo/o4+WaLSQ2lPBDlQiTl6By0W76zAIaJmu
         KldOw7GXkT0F539Oizve0QI5YPD/q6OnVIszKsmtileWf+ERMej1zqupFokfUmlFr14X
         OisQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8LBD3bmsUFVrhZsMlRHOjoxT9q8HzypEZnM4jBHbBfSqEuknG2JM3hhLzfrdzqgK49RsDdKacm1bz1YyKrJG8++1AEE+T
X-Gm-Message-State: AOJu0YxeLbU+FRs+DAQY5ldkW1thCgqAxkyZVoR3gv5wXUXwLYeuV8ya
	R3yFMpsflbe5ms2bm1vtozqzLSoth3uIcpaZLcnPTt9dzNZidrORBoJyjJ9xQorXanMzO0ZRHqt
	1L+OtfPvmtHKC5C6MY23DGFS4kwgLaraPR7qQwtcu+RF1EGusFGDiRQ==
X-Received: by 2002:a05:600c:4fc3:b0:418:f770:ba0 with SMTP id o3-20020a05600c4fc300b00418f7700ba0mr9811749wmq.0.1713893139833;
        Tue, 23 Apr 2024 10:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZTfcZCyN9ek9qph7rbZH1CiyORcwMqvi5SkqJOYCMbxg82eNj1uDy6hr0NrKmR0kKVFB7Dw==
X-Received: by 2002:a05:600c:4fc3:b0:418:f770:ba0 with SMTP id o3-20020a05600c4fc300b00418f7700ba0mr9811736wmq.0.1713893139397;
        Tue, 23 Apr 2024 10:25:39 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id hg16-20020a05600c539000b0041aa8ad46d6sm3618315wmb.16.2024.04.23.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:25:38 -0700 (PDT)
Message-ID: <1380ba9e71d500628994b0a1a7cbb108b4bf9492.camel@redhat.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>
Date: Tue, 23 Apr 2024 19:25:37 +0200
In-Reply-To: <20240422110654.2f843133@kernel.org>
References: <20240405102313.GA310894@kernel.org>
	 <20240409153250.574369e4@kernel.org>
	 <91451f2da3dcd70de3138975ad7d21f0548e19c9.camel@redhat.com>
	 <20240410075745.4637c537@kernel.org>
	 <de5bc3a7180fdc42a58df56fd5527c4955fd0978.camel@redhat.com>
	 <20240411090325.185c8127@kernel.org>
	 <0c1528838ebafdbe275ad69febb24b056895f94a.camel@redhat.com>
	 <20240422110654.2f843133@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-22 at 11:06 -0700, Jakub Kicinski wrote:
> On Fri, 19 Apr 2024 13:53:53 +0200 Paolo Abeni wrote:
> > > They don't have to be nodes. They can appear as parent or child of=
=20
> > > a real node, but they don't themselves carry any configuration.
> > >=20
> > > IOW you can represent them as a special encoding of the ID field,
> > > rather than a real node. =20
> >=20
> > I'm sorry for the latency, I got distracted elsewhere.=C2=A0
> >=20
> > It's not clear the benefit of introducing this 'attach points' concept.
> >=20
> > With the current proposal, configuring a queue shaper would be:
> >=20
> > info.bw_min =3D ...
> > dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &ack=
);
> >=20
> > and restoring the default could be either:
> >=20
> > info.bw_min =3D 0;
> > dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &ack=
);
>=20
> And presumably also bw_max =3D 0 also means "delete" or will it be bw_max
> =3D ~0 ?

I would say just bw_min =3D 0, all others fields are ignored in such
case. But not very relevant since...
>=20
> > or:
> >=20
> > dev->shaper_ops->delete(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &=
ack);
>=20
> Which confusingly will not actually delete the node, subsequent get()
> will still return it.
>=20
> > With the 'attach points' I guess it will be something alike the
> > following (am not defining a different node type here just to keep the
> > example short):
> >=20
> > # configure a queue shaper
> > struct shaper_info attach_info;
> > dev->shaper_ops->get(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &attach_inf=
o, &ack);
> > info.parent_id =3D attach_info.id;
> > info.bw_min =3D ...
> > new_node_id =3D dev->shaper_ops->add(dev, &info, &ack);
> >=20
> > # restore defaults:
> > dev->shaper_ops->delete(dev, SHAPER_LOOKUP_BY_TREE_ID, new_node_id, &in=
fo, &ack);
> >=20
> > likely some additional operation would be needed to traverse/fetch
> > directly the actual shaper present at the attach points???
>=20
> Whether type + ID (here SHAPER_LOOKUP_BY_QUEUE, queue_id) identifies
> the node sufficiently to avoid the get is orthogonal. Your ->set
> example assumes you don't have to do a get first to find exact
> (synthetic) node ID. The same can be true for an ->add, if you prefer.

... my understanding is that you have strong preference over the
'attach points' variant.

I think in the end is mostly a matter of clearly define
expectation/behavior and initial status.=20

Assuming the initial tree is empty, and the kernel tracks all changes
vs the default (empty tree) configuration, I guess it's probably better
change slightly the ->add():

int (*add)(struct net_device *dev,=C2=A0
	   enum shaper_lookup_mode lookup_mode, // for the parent
	   u32 parent_id			// relative to lookup_mode
	   const struct shaper_info *shaper,    // 'id' and 'parent_id' fields
						// are unused
	   struct netlink_ext_ack *extack);

so we can easily add/configure a queue shapers with a single op:

	struct shaper_info attach_info;
	info.bw_min =3D ...
	dev->shaper_ops->add(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &ack);

And possibly even the ->move() op:

	int (*move)(struct net_device *dev,
		    u32 id, // shapers to be moved, id is SHAPER_LOOKUP_BY_TREE_ID
		    enum shaper_lookup_mode lookup_mode,=C2=A0// for the new parent
		    u32 new_parent_id,=C2=A0			 // relative to 'lookup_mode'
		    struct netlink_ext_ack *extack);

Since it does not make sense to move around the attach point, the
kernel knows the id of the created/modified nodes, and it should be
useful be able to move the shaper directly under an arbitrary attach
point.

Finally, what about renaming the whole SHAPER_LOOKUP_* values to
SHAPER_LOOKUP_TX_* so we can later easily extends this to RX?=20

> I do find it odd that we have objects in multiple places of=20
> the hierarchy when there is no configuration intended. Especially
> that
> the HW may actually not support such configuration (say there is
> always
> a DRR before the egress, now we insert a shaping stage there).

Regardless of the model we chose (with 'attach points' or without), if
the H/W does not support a given configuration, the relative op must
fail. No shapers will be created matching an unsupported configuration.

Thanks,

Paolo


