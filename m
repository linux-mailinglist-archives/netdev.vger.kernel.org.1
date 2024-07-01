Return-Path: <netdev+bounces-108140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C66791E000
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 14:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA522B22672
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352A215AD86;
	Mon,  1 Jul 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlDRkMr0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A215A849
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838610; cv=none; b=MhF9+mPk4enJcfbU4C39p+Xu3AxO+OQrp1TMDDRFbktdVEs7K6DRi+6KdnUx+8z0S6MkrEOwY1BkcWLb+IpDQggmH+LWFICdPY5UGkFGfNmRQLmft2a4KIjkteROAg2Zke6BmuT9l//0JMTqMneeCLrnDd3SsHg7RFF4xRq/xvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838610; c=relaxed/simple;
	bh=kO+WM5ZQfB3Sr3j7wPI/DBlkW4XzSfrK+wt4u2ye5qw=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9I1qse8RBI6vVKCULkT/3HlnP+9REbDavaJvNltp/JOxSV5vhkuv+SpzvLsGX7c6sT0PYt5bbQRFZDkiuhDQ4HbkxWg7/agzJqGQhJ+wgqA2TaWXZiWbmjdb5ehEkCN6h5MXp/Dn2xIbpHXaqLeD5aMZ/0wDcwHZCy13jgMfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlDRkMr0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719838607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zt43OVF+seYKp8/P4tWeHcdZ3AJSUDh9yfiJyQfU2oc=;
	b=OlDRkMr0RCpiYAxqUPVv0qQbmRX/DqSib2QPCyNjw76T0uWZUzfffESz300OwpGm3UP+1R
	5Iur8oN9dlSkdY0u4LCJv5eEFFYsS5if9j/2t6qxQxPfUrXFTy3cZqx03MS16QWMBrmwLl
	X6LQfXMM3WhJirKfNuVVDHz9yU8dCz0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-o9mvGR9pMkuqrb88ugyPLQ-1; Mon, 01 Jul 2024 08:56:45 -0400
X-MC-Unique: o9mvGR9pMkuqrb88ugyPLQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b50f078c46so42470126d6.3
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 05:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838605; x=1720443405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zt43OVF+seYKp8/P4tWeHcdZ3AJSUDh9yfiJyQfU2oc=;
        b=Rzx3JZVOmWpHRWQoA/3wRDlt0khZvgRRTJM/ZziFTUfMk90y4QH1a6MxWkd2dJrHZD
         PJwIAHimHli6Dj7nvM6VaQvUePFL3fhTsa+03JGKJd26hub6h+O9fxaahZPW69kwBp5D
         bNY1Ubb1MLFhMWnTLH/SSbYYh09P9x+b+xgHeEYXK/aUyVmd9Ua68Ow/m0hZ2YBcSZkA
         pbCjWDJG2rjgZ0RPJiI3Nw2J/XzZGon1bh7Q56DUs6C0jZ9MSdNlX8I5rAQ3Ox31xj2z
         TfGqqQzkWEsvkm2+s8hUkz25RvYRVULZ4TyFIuFeo5RSQkODgDMEJWW51YrE3yv05ZNq
         SPow==
X-Gm-Message-State: AOJu0YycKhuRP2ZrzgyipkD/bOBpvycDMNN+12llecHKta5uWZzLmZ5g
	yGBRd8w9AyypQ1AJMeL28H0GMlDV1S3Wioj66Tah+82p6YstaqOLgu4uF2KSTnUI27i6APHXXlS
	nGBsJTCR7i2q+Oniio2iiNDgySfy6UFakJOMnibAlscndwPYXMkerPH4OBpcGIcvxvqy5oF2XU+
	km98MkZ8xQvQcjFXiA/te+mmM3Y8JN
X-Received: by 2002:ad4:5746:0:b0:6b5:613:5acd with SMTP id 6a1803df08f44-6b5b70c2d37mr94774866d6.31.1719838605108;
        Mon, 01 Jul 2024 05:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3iY1Jl12VKssIf8agLrYEh9ASyagHF2DXcPKx8Of865/H1uEmWA05jSdI6+6/dVfzpADg7B7+93zqaHY4MF0=
X-Received: by 2002:ad4:5746:0:b0:6b5:613:5acd with SMTP id
 6a1803df08f44-6b5b70c2d37mr94774616d6.31.1719838604782; Mon, 01 Jul 2024
 05:56:44 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jul 2024 12:56:43 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com> <20240630195740.1469727-6-amorenoz@redhat.com>
 <ZoKVtygkVYfaqjRI@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZoKVtygkVYfaqjRI@localhost.localdomain>
Date: Mon, 1 Jul 2024 12:56:43 +0000
Message-ID: <CAG=2xmMgJcir=mfQuybosg9C8j3Sx1V=Du0ObH1eT_SnBZ7nMg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 01:40:39PM GMT, Michal Kubiak wrote:
> On Sun, Jun 30, 2024 at 09:57:26PM +0200, Adrian Moreno wrote:
> > Add support for a new action: psample.
> >
> > This action accepts a u32 group id and a variable-length cookie and use=
s
> > the psample multicast group to make the packet available for
> > observability.
> >
> > The maximum length of the user-defined cookie is set to 16, same as
> > tc_cookie, to discourage using cookies that will not be offloadable.
> >
> > Acked-by: Eelco Chaudron <echaudro@redhat.com>
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
> >  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
> >  net/openvswitch/Kconfig                   |  1 +
> >  net/openvswitch/actions.c                 | 47 +++++++++++++++++++++++
> >  net/openvswitch/flow_netlink.c            | 32 ++++++++++++++-
> >  5 files changed, 124 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/=
netlink/specs/ovs_flow.yaml
> > index 4fdfc6b5cae9..46f5d1cd8a5f 100644
> > --- a/Documentation/netlink/specs/ovs_flow.yaml
> > +++ b/Documentation/netlink/specs/ovs_flow.yaml
> > @@ -727,6 +727,12 @@ attribute-sets:
> >          name: dec-ttl
> >          type: nest
> >          nested-attributes: dec-ttl-attrs
> > +      -
> > +        name: psample
> > +        type: nest
> > +        nested-attributes: psample-attrs
> > +        doc: |
> > +          Sends a packet sample to psample for external observation.
> >    -
> >      name: tunnel-key-attrs
> >      enum-name: ovs-tunnel-key-attr
> > @@ -938,6 +944,17 @@ attribute-sets:
> >        -
> >          name: gbp
> >          type: u32
> > +  -
> > +    name: psample-attrs
> > +    enum-name: ovs-psample-attr
> > +    name-prefix: ovs-psample-attr-
> > +    attributes:
> > +      -
> > +        name: group
> > +        type: u32
> > +      -
> > +        name: cookie
> > +        type: binary
> >
> >  operations:
> >    name-prefix: ovs-flow-cmd-
> > diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/open=
vswitch.h
> > index efc82c318fa2..3dd653748725 100644
> > --- a/include/uapi/linux/openvswitch.h
> > +++ b/include/uapi/linux/openvswitch.h
> > @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
> >  };
> >  #endif
> >
> > +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
>
> In your patch #2 you use "TC_COOKIE_MAX_SIZE" as an array size for your
> cookie. I know that now OVS_PSAMPLE_COOKIE_MAX_SIZE =3D=3D TC_COOKIE_MAX_=
SIZE,
> so this size will be validated correctly.
> But how likely is that those 2 constants will have different values in th=
e
> future?
> Would it be reasonable to create more strict dependency between those
> macros, e.g.:
>
> #define OVS_PSAMPLE_COOKIE_MAX_SIZE TC_COOKIE_MAX_SIZE
>
> or, at least, add a comment that the size shouldn't be bigger than
> TC_COOKIE_MAX_SIZE?
> I'm just considering the risk of exceeding the array from the patch #2 wh=
en
> somebody increases OVS_PSAMPLE_COOKIE_MAX_SIZE in the future.
>
> Thanks,
> Michal
>

Hi Michal,

Thanks for sharing your thoughts.

I tried to keep the dependency between both cookie sizes loose.

I don't want a change in TC_COOKIE_MAX_SIZE to inadvertently modify
OVS_PSAMPLE_COOKIE_MAX_SIZE because OVS might not need a bigger cookie
and even if it does, backwards compatibility needs to be guaranteed:
meaning OVS userspace will have to detect the new size and use it or
fall back to a smaller cookie for older kernels. All this needs to be
known and worked on in userspace.

On the other hand, I intentionally made OVS's "psample" action as
similar as possible to act_psample, including setting the same cookie
size to begin with. The reason is that I think we should try to implement
tc-flower offloading of this action using act_sample, plus 16 seemed a
very reasonable max value.

When we decide to support offloading the "psample" action, this must
be done entirely in userspace. OVS must create a act_sample action
(instead of the OVS "psample" one) via netlink. In no circumstances the
openvswitch kmod interacts with tc directly.

Now, back to your concern. If OVS_PSAMPLE_COOKIE_MAX_SIZE grows and
TC_COOKIE_MAX_SIZE does not *and* we already support offloading this
action to tc, the only consequence is that OVS userspace has a
problem because the tc's netlink interface will reject cookies larger
than TC_COOKIE_MAX_SIZE [1].
This guarantees that the array in patch #2 is never overflown.

OVS will have to deal with the different sizes and try to squeeze the
data into TC_COOKIE_MAX_SIZE or fail to offload the action altogether.

Psample does not have a size limit so different parts of the kernel can
use psample with different internal max-sizes without any restriction.

I hope this clears your concerns.

[1] https://github.com/torvalds/linux/blob/master/net/sched/act_api.c#L1299

Thanks.
Adri=C3=A1n


