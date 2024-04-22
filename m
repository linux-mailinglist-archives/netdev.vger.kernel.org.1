Return-Path: <netdev+bounces-90234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD438AD3A8
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7270D1F2153B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4409154422;
	Mon, 22 Apr 2024 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKHOO+Hi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF2F15218D
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713809216; cv=none; b=iDR5zjtFhTpmuE35WdnuyMlrJtbF44dK5877Q+9J7LlpJMX9EPOHVUQ4VbSpEXsmDbIl4bEaSbK5IMaWbocNNzb0UycnRn+I5OzltkCm0acgFlxMWOMHTEqPPR5Nenh/OJ22Zq5vSmzsddADgpwUqCwolVzPH09bcUD6qn2NCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713809216; c=relaxed/simple;
	bh=4btVgvcKsP6Z+8NO1DNFKNA+wBE7rin0w1/5n+zGoRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJHr+eEI8P+tUDHNUETnHmZzdVfZGINF+P5Mv0t4wpgj1CNDjpbEzYmUxTyAy0pG2CQ3MmRl/wfXK0g8scfiZ+DsprBDILMnQZdEj/lo7hPp3zzdr92bMdIGLwJC2nTu3fN6DVJgGXdb8wGPpX62rTiZkl/QOc1VdVwc4FUFzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKHOO+Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2563C113CC;
	Mon, 22 Apr 2024 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713809215;
	bh=4btVgvcKsP6Z+8NO1DNFKNA+wBE7rin0w1/5n+zGoRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jKHOO+Hi4lHbh9vp6CsCZnE11S7P1ooxIVKGnRdkK6Oh467yz8ZLhae+LgPbdK+60
	 aershtQn61WHtTdKxBpx63JQoPcZkBrRRvdsjczRZt7xeNmkhxevH5mB8dnbsj0kVU
	 pGZIT+OI0mgQrfZCFju+OY9NqvovWsbQ9E+FNHMcIRrgGzwBo5fJ2AwdF/jX8pOl78
	 Ikxq+FO5tGpE59wJs0PIct4gsrA0oIHrSrEuE+oLHItKYe8ow/HRE42aU9DRYK2gw5
	 IhE/gmumXFuTQGj79NvQQ0b77QYOkFh8cyu01RT0r3DYmWKRhLQ+qsoQsxEA3z6yGu
	 mSYaLNgFNjdXw==
Date: Mon, 22 Apr 2024 11:06:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
Message-ID: <20240422110654.2f843133@kernel.org>
In-Reply-To: <0c1528838ebafdbe275ad69febb24b056895f94a.camel@redhat.com>
References: <20240405102313.GA310894@kernel.org>
	<20240409153250.574369e4@kernel.org>
	<91451f2da3dcd70de3138975ad7d21f0548e19c9.camel@redhat.com>
	<20240410075745.4637c537@kernel.org>
	<de5bc3a7180fdc42a58df56fd5527c4955fd0978.camel@redhat.com>
	<20240411090325.185c8127@kernel.org>
	<0c1528838ebafdbe275ad69febb24b056895f94a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Apr 2024 13:53:53 +0200 Paolo Abeni wrote:
> > They don't have to be nodes. They can appear as parent or child of=20
> > a real node, but they don't themselves carry any configuration.
> >=20
> > IOW you can represent them as a special encoding of the ID field,
> > rather than a real node. =20
>=20
> I'm sorry for the latency, I got distracted elsewhere.=C2=A0
>=20
> It's not clear the benefit of introducing this 'attach points' concept.
>=20
> With the current proposal, configuring a queue shaper would be:
>=20
> info.bw_min =3D ...
> dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &ack);
>=20
> and restoring the default could be either:
>=20
> info.bw_min =3D 0;
> dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &ack);

And presumably also bw_max =3D 0 also means "delete" or will it be bw_max
=3D ~0 ?

> or:
>=20
> dev->shaper_ops->delete(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, &ac=
k);

Which confusingly will not actually delete the node, subsequent get()
will still return it.

> With the 'attach points' I guess it will be something alike the
> following (am not defining a different node type here just to keep the
> example short):
>=20
> # configure a queue shaper
> struct shaper_info attach_info;
> dev->shaper_ops->get(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &attach_info,=
 &ack);
> info.parent_id =3D attach_info.id;
> info.bw_min =3D ...
> new_node_id =3D dev->shaper_ops->add(dev, &info, &ack);
>
> # restore defaults:
> dev->shaper_ops->delete(dev, SHAPER_LOOKUP_BY_TREE_ID, new_node_id, &info=
, &ack);
>=20
> likely some additional operation would be needed to traverse/fetch
> directly the actual shaper present at the attach points???

Whether type + ID (here SHAPER_LOOKUP_BY_QUEUE, queue_id) identifies
the node sufficiently to avoid the get is orthogonal. Your ->set
example assumes you don't have to do a get first to find exact
(synthetic) node ID. The same can be true for an ->add, if you prefer.
=20
> I think the operations will be simpler without the 'attach points', am
> I missing something?=C2=A0
>=20
> A clear conventions/definition about the semantic of deleting shapers
> at specific locations (e.g. restoring the default behaviour) should
> suffice, together with the current schema.

I guess. I do find it odd that we have objects in multiple places of=20
the hierarchy when there is no configuration intended. Especially that
the HW may actually not support such configuration (say there is always
a DRR before the egress, now we insert a shaping stage there).

