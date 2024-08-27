Return-Path: <netdev+bounces-122507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD659618A8
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC733B22C65
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA2185931;
	Tue, 27 Aug 2024 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnSkVydC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DB374CB
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791406; cv=none; b=sDAN8piXQ9xJBw86G9LiN+4K65tPA9CboWl2/iVpyQXMirXWSSeLWOiBiXfdwq+LslYWIuzWqTP1CFEwjEybOCgDnBuTFcBpx5bPLaeP1txqdwIF5PzIyCdfwNLdP4hE5V7E1NUc1cv6Ogy1WgEYt7ouIugZLICilU8sGNK6EE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791406; c=relaxed/simple;
	bh=rCe9DaeTCu7Z3d5OXh7f45Fd8m3N6G76HwbC2rTl0BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bji2D6//jt4RjpkV004cu4pHDFLo42p2gFBciYPwyBONWbmUA4nO5OayzfBNL9a3Fip8u8/kIkfwvN0Kuwd5VCfoRhAP/+n6K7/dnKO4nU2ojxaRFHQHMwJWkAVDEyddWq7lhyOqzIIGoZ8nRNOdQI+BplByGlwVAxonE4XLXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnSkVydC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724791403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/56iSIjLjJhdwEDHT9V6Y+0vSfqfpeIsT0ZooUkoMg=;
	b=DnSkVydCFeCuMztcrIuM2IXZXzJzrUHsVbPwyYl1TtHL/e9OZAVG4nsqtnlbJTRxgAg2u8
	MduhIjW4YGApFlw8+WFJh5Fkteys0RR/sEXir3e1JXKWq6JAAEfcIg+SJbsPTBoaurwYvp
	/ZPgIhSOB7GlKvFzbb/yZRWPjkia/00=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-7-hFrK7hPQmUDLSeLKlDDQ-1; Tue, 27 Aug 2024 16:43:22 -0400
X-MC-Unique: 7-hFrK7hPQmUDLSeLKlDDQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-709664a6285so7863016a34.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791401; x=1725396201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/56iSIjLjJhdwEDHT9V6Y+0vSfqfpeIsT0ZooUkoMg=;
        b=g8ShbYj5VOJE7gbR9W3VgBf/vZQsOw8UF77Rf+e4Vs3/AvF898vubPA5UniatvkVV9
         56PbLGhAkqCeUIaBY9/vI7cGp6h2T20cw0ZA1PMT9R1Lf3EC8ZH6vYOQzVrUkNNJxvkO
         2tJx4I8kflz0IK16dOnQrIsbZVfQQ77TQNT7JOwBRKy2b0CFw8MALusZC7MJDR+VuUN0
         KkVIM/8RzWbrd0JzQMo/+tXphEZpV8nxLLqErcm5k2+FdXlGRnd+dLRN8heT8b1evrOI
         Fwu5c8AEQtpcr+U22KpV36yD3UR2SoeLScKwq/Wb4JHf9s5J2JSgwEEd44WYcqVJYeEq
         OWtA==
X-Forwarded-Encrypted: i=1; AJvYcCUXYhEYKUxer1jyOpiYbAkQN2HekkN/pbRe+y+99JrXdad0xG7IR3nEuyN5NfXqf/GXfTUf2P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLhEnX7j4n0OqQ/UAIXGWzgGPpe0NxeoyqZt5kjFLww8oTU41
	8CyKTzmctBdrXUAVjGgnJjcVbRRJTkg++uH2WwytIualYgQ4cMwAUKXt3YkytqDksVVkSsqxmZm
	kNuwogChoKind2cGjIEIi5XitaBa49yIHflH81zJtGucrT3ZPr3VYQAJ6CMtnoYLTUIIn2tfpO4
	1huuy+6MWfbgnQq1MLXInezHATxagE
X-Received: by 2002:a05:6830:368b:b0:709:450b:a3aa with SMTP id 46e09a7af769-70f484590c4mr4071251a34.21.1724791401455;
        Tue, 27 Aug 2024 13:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Lt3M9EtVV2p04wIbXbVZHGiSGXF05jkqljTzuqVcswYeoCBj9Dnz1ern7MB7g5CqJnDuHMfjbhBn5+Q9EpE=
X-Received: by 2002:a05:6830:368b:b0:709:450b:a3aa with SMTP id
 46e09a7af769-70f484590c4mr4071237a34.21.1724791401175; Tue, 27 Aug 2024
 13:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZsMyI0UOn4o7OfBj@nanopsycho.orion> <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
 <Zsco7hs_XWTb3htS@nanopsycho.orion> <20240822074112.709f769e@kernel.org>
 <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com> <20240822155608.3034af6c@kernel.org>
 <Zsh3ecwUICabLyHV@nanopsycho.orion> <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
 <ZsiQSfTNr5G0MA58@nanopsycho.orion> <a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
 <ZsxLa0Ut7bWc0OmQ@nanopsycho.orion> <432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
 <20240827075406.34050de2@kernel.org>
In-Reply-To: <20240827075406.34050de2@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 27 Aug 2024 22:43:09 +0200
Message-ID: <CAF6piCL1CyLLVSG_jM2_EWH2ESGbNX4hHv35PjQvQh5cB19BnA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	Madhu Chittim <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 8/27/24 16:54, Jakub Kicinski wrote:
> On Tue, 27 Aug 2024 16:37:38 +0200 Paolo Abeni wrote:
>>> What's stopping anyone from diverging these 2-n sets? I mean, the whole
>>> purpose it unification and finding common ground. Once you have ops
>>> duplicated, sooner then later someone does change in A but ignore B.
>>> Having the  "preamble" in every callback seems like very good tradeoff
>>> to prevent this scenario.
>>
>> The main fact is that we do not agree on the above point - unify the
>> shaper_ops between struct net_device and struct devlink.
>>
>> I think a 3rd party opinion could help moving forward.
>> @Jakub could you please share your view here?
>
> I don't mind Jiri's suggestion. Driver can declare its own helper:
>
> static struct drv_port *
> drv_shaper_binding_to_prot(const struct net_shaper_binding *binding)
> {
>       if (binding->type =3D=3D NET_SHAPER_BINDING_TYPE_NETDEV)
>               return /* netdev_priv() ? */;
>       if (binding->type =3D=3D NET_SHAPER_BINDING_TYPE_DEVLINK_PORT)
>               return /* container_of() ? */;
>       WARN_ONCE();
>       return NULL;
> }
>
> And call that instead of netdev_priv()?

As I wrote this does not look like something that would help
de-deuplicate any code, but since you both seem to agree...

Double checking before I rewrote a significant amount of the core code:

In the NL API, I will replace ifindex with binding, the latter will
include nested attributes ifindex, bus_name
and dev_name.

Note that 'struct net_shaper_binding' must include a =E2=80=98struct devlin=
k
*=E2=80=99 as opposed to a
=E2=80=98struct devlink_port *=E2=80=99, as mentioned in the code snippet s=
o far, or
we will have to drop the
shaper cache and re-introduce a get() operation.

The ops will try to fetch the net_device or devlink according to the
provided attributes.
At the moment the ops will error out with ENOTSUP for netlink object.
Most core helpers
will be re-factored to accept a 'binding *' argument in place of a
'struct net_device *'.

Full netlink support (for the brave that will implement it later) will
likely require at least an
additional scope (devlink_port), include the net_shaper_ops and
net_shaper_data inside
struct devlink, and likely code adaptation inside the core.

/P


