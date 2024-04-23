Return-Path: <netdev+bounces-90589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE238AE917
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05371C21C4C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE5137922;
	Tue, 23 Apr 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYeCeLkT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C0137770
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881276; cv=none; b=NhL9wsJK5y9O1QEDMD+yjzPxwfq8u0AfBEHVX6o1t9T5tneHLhyn1E/RI4sFZPZ8BrQrBhY890r31zZG9nlKPv+ULAb9lCQ5lzrvEqpdko3iat9C9wvSd9GOtbNAHHfp1UF9hytuR74aeqv/IZCbvz5gyPp2QAhbn/hD1AjWcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881276; c=relaxed/simple;
	bh=4/s5Pi3TD4IqWjmMXZR4zTyj6n9iiT3kFuakwrGvGEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ptZ98R5w4m/TpmRe7GswUQBCB4s5Ub1BBrQlzgL21P8P4+Jgzi17lejD5OIWyzuPKzSZk2qp+MGQ1rqdqoKLiP3bi+uI0TcGZ8I0TQVqK37rc9s6NoobF1HpOzO3SYI1ZXx7DvGNEah4r2no1B607M+LckkhvC9YpCmshaKSQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYeCeLkT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713881273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3rOb18fNW0jPoLhyg/jh0hv3XgBvPLf8B3AURzI5o3c=;
	b=eYeCeLkTPjMKAp9P+7T/nwsVQSVjEtnJgZ045lpCHd+/jv0t7cKZhI8Q71MBwUThO33q52
	8dGLerbHJvTpv6LVKfhMJDfhzcunmDfFE5J3pvYfMRlIDyUyEX74v7EsTPoTMU/bTxnSlR
	zpfi368EXu63704+1p8HF87JRoPtnrI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-7NSkJpdYNbCrnj9HtOrZuQ-1; Tue, 23 Apr 2024 10:07:52 -0400
X-MC-Unique: 7NSkJpdYNbCrnj9HtOrZuQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-434ed2e412fso26137991cf.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 07:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881272; x=1714486072;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rOb18fNW0jPoLhyg/jh0hv3XgBvPLf8B3AURzI5o3c=;
        b=Gz3hbXlZNV3Bo9g5ngQtx3p6t0HmLCmW8RlIEdubHg44JEE72M4KVmNJ4aQJ1c+Qoq
         BYGCFn78hLxM3x6UbNdGzpaA218sxc8zzu11JvKij2LWyHs0kwU7RNpa5cgWd8Q/fPE1
         lw6WK9JS59AZXJu4w1w4X026aMVWGE3fIWC3yQc8QZgHcBWAu+rESATmBNNgzo4U8lYw
         eVRc+zTuYMGNhfNkzqJ1nGwaNGA6kN8iz6lF3+BoqL5CkY+snUFcz9O43rKOJ5+sx2zf
         v1X/MfsKVnHLqAcy8VUrmQ7M+fR/QNT5CeAgtNxFEMzmCclX6vejxRIYvhTT69Z3QcLg
         S3xw==
X-Forwarded-Encrypted: i=1; AJvYcCVwLnZJRSUDNYJBvdZtqFY0lCDkozr3R2feswSAzZxItGLh6AJ7R5tpchV7R/Cplsj/WX8Giczv6NleKujkDVOoFjYwDbmb
X-Gm-Message-State: AOJu0Yz6F5RfeHHWfsoiTI5g+1IWOWOYqZuu2y6z7opVwl773RCecFrA
	o7VSvQ+wdzYTPyUaBx99CTpAiuhWCgahF33sPXmbx1J5O4U1XTG7lcUvflTyP477vM7pD/YtXw6
	1XRGB4Tvw/oMtGUUm+Fw3QKWwO6Tax8KavXUp/7uBysXscI7TVxD1Yg==
X-Received: by 2002:a05:6214:1d0d:b0:69b:7d34:9f6 with SMTP id e13-20020a0562141d0d00b0069b7d3409f6mr16875849qvd.5.1713881272060;
        Tue, 23 Apr 2024 07:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbq2XGHgn0gTOmp3vOfh+WbtD7mhUt190Wq1PYb2ah8S2ZaZ9KawX/pczmO1S7TpoIt6LNXw==
X-Received: by 2002:a05:6214:1d0d:b0:69b:7d34:9f6 with SMTP id e13-20020a0562141d0d00b0069b7d3409f6mr16875827qvd.5.1713881271726;
        Tue, 23 Apr 2024 07:07:51 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id n1-20020a0c8c01000000b006a03f4d27b4sm4345419qvb.9.2024.04.23.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:07:51 -0700 (PDT)
Message-ID: <64ebeda4a6f7b95adcce533d4ce9a657535ba0c4.camel@redhat.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>, Simon Horman
	 <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Madhu
 Chittim <madhu.chittim@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>
Date: Tue, 23 Apr 2024 16:07:48 +0200
In-Reply-To: <BY3PR18MB47379D035EB5DD965D6D187FC6122@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240405102313.GA310894@kernel.org>
	 <BY3PR18MB47379D035EB5DD965D6D187FC6122@BY3PR18MB4737.namprd18.prod.outlook.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-22 at 11:30 +0000, Sunil Kovvuri Goutham wrote:
>=20
> On Friday, April 5, 2024 3:53 PM Simon Horman <horms@kernel.org> wrote:
[...]
> > /**
> >  * struct shaper_info - represent a node of the shaper hierarchy
> >  * @id: Unique identifier inside the shaper tree.
> >  * @parent_id: ID of parent shaper, or SHAPER_NONE_ID if the shaper has
> >  *             no parent. Only the root shaper has no parent.
> >  * @metric: Specify if the bw limits refers to PPS or BPS
> >  * @bw_min: Minimum guaranteed rate for this shaper
> >  * @bw_max: Maximum peak bw allowed for this shaper
> >  * @burst: Maximum burst for the peek rate of this shaper
> >  * @priority: Scheduling priority for this shaper
> >  * @weight: Scheduling weight for this shaper
> >  *
> >  * The full shaper hierarchy is maintained only by the
> >  * NIC driver (or firmware), possibly in a NIC-specific format
> >  * and/or in H/W tables.
> >  * The kernel uses this representation and the shaper_ops to
> >  * access, traverse, and update it.
> >  */
> > struct shaper_info {
> > 	/* The following fields allow the full traversal of the whole
> > 	 * hierarchy.
> > 	 */
> > 	u32 id;
> > 	u32 parent_id;
> >=20
> > 	/* The following fields define the behavior of the shaper. */
> > 	enum shaper_metric metric;
> > 	u64 bw_min;
> > 	u64 bw_max;
> > 	u32 burst;
> > 	u32 priority;
> > 	u32 weight;
> > };
> >=20
>=20
> 'bw_min/max' is u64 and 'burst' / 'weight' are u32, any specific reason ?

A NIC can exceed UINT32_MAX bps, while UINT32_MAX different values look
more then enough to cope for different weights.

No strong opinions, we can increase the weight range, but it looks a
bit overkill to me.

[...]
> Can you please confirm below
> 1. Does privileged VF mean trusted VF ?

Yes. But keep in mind that given the current status of discussion we
are going to drop privileged/trusted VF reference.

> 2. With this we can setup below as well, from PF ?
>      -- Per-VF Quantum
>      -- Per-VF Strict priority
>      -- Per-VF ratelimit

Assuming the NIC H/W support it, yes: the host will have full control
over all the available shaper.

> 3. Wondering if it would be beneficial to apply this to ingress traffic a=
s well, all modes may or may not apply,
>      but at the least it could be possible to apply PPS/BPS ratelimit. So=
 that the configuration methodology
>      remains same across egress and ingress.

I think the API could be extended to the RX side, too, as a follow-
up/next step. This relatively simple feature is in progress since a
significant time, I think it would be nice try to have it in place
first.

We will try to ensure there will be no naming clash for such extension.

Cheers,

Paolo


