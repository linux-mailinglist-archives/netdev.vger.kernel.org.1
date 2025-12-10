Return-Path: <netdev+bounces-244254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27065CB305D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 14:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 835A43069C91
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA75C2080C8;
	Wed, 10 Dec 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UG9RzAo2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1cI6X4l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DA2EBBB4
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373324; cv=none; b=leKvLHNfLf1dzFXkw2FBbEnR0jGehqXnky2D0ZRPqqlm5gdtGxu65orxD+UtYMtLzSAJcuX6Nroglknzwf6kQ0sL3SB1ZZFPiyJU2+DfJUHTGuzk/Tp9R8aFZYMPGptJCutQc+6aC6pqdeiUfw70PFGHo1sUZWK1qre07Hby3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373324; c=relaxed/simple;
	bh=q2uCR8QQC4UQnkB3lwJ/XlKveQbBaYYYv9QPqyhSSQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJVO82k2wCgc8R+WfhDjS9WWQaSs4fTj3b8Gi03J7aU1RCGmIN3XUkrEGhqbgT/ErzTz9uFPFeXToQPPf4/qdmq8rwCAwDvgPmfozIVmaQsCXBpbg7tZ70iH3A8gW8zgJmDa9cBj9WZtdPNZfjE9vz/uLdJOgBwKQtYdgSmxh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UG9RzAo2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1cI6X4l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765373321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFdr0tsAr4e9VbweFlioJQoAGzREQF+H+QV/Ubn+hH8=;
	b=UG9RzAo27Z+G16OIDwGbMF3ULr7B6rqKIEUFQcg67xfWgeg3qy/3oTP+WPqN6siZFvO8/A
	qLuBJu8rNajay11ayHnm159dOtVJG909gQlrtlmltB1OstjHAWL0J/k+lIc1NyRxC8iMdZ
	79yOXyFSjZIKfGpSJw+zrWoSCjrA7ws=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-0l6yX7m7PmWEFwbNWl4afA-1; Wed, 10 Dec 2025 08:28:40 -0500
X-MC-Unique: 0l6yX7m7PmWEFwbNWl4afA-1
X-Mimecast-MFC-AGG-ID: 0l6yX7m7PmWEFwbNWl4afA_1765373319
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7a041a9121so651381166b.3
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 05:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765373319; x=1765978119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFdr0tsAr4e9VbweFlioJQoAGzREQF+H+QV/Ubn+hH8=;
        b=I1cI6X4lsZ2HQ0eEm4Jo6T0f3bHjPaI0zzBL4HNyM7RXn9kM7pySELqWQ3Ptu3Z+p+
         IeAOHOwlmYgHofohYsIOq6NrB1QlYmvl0IaIf57iLA5v7oEHC3OLhMv/I/1lXLr9NSfO
         YWSHVofcyh8yIKMgqRFACmwRn2WFYMnFQExuicRQPyAAg6Vh3OLgYR0N9tvaYUQvXCU0
         Dx56V9e99MW/S+4tAiNLCWo62Qy2FTivTkuPQI7o9ONwxC4NnJaTeOlcSmF9BGjcyuGL
         OIjYptiq3bvxtfrMnTinPGlEtt531+ljslC/8ie0kJm1p9SJOd94iTvJI5oRfEzijjSo
         YV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765373319; x=1765978119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFdr0tsAr4e9VbweFlioJQoAGzREQF+H+QV/Ubn+hH8=;
        b=VM96paZHmoo5+JNjsTigkmE6D41chwSS0dXR+62qFaKrVm94bZdRUp0sj5L9EDp/KR
         /1/isP8eA15SCN8A3b4zlG8YceAoNtOn0wa9uSQOX8Z78bj0vkOswqqKJeiBBumNHL5H
         hYHpkwTD0w/hwIjfUwMRn+GbqcKPwNoFIRmeTNisDR70qr2dKZ1XZJf+wbla47tb/hoh
         C26aO4dEbeiKwTvcChK2Y4jQvg2jkxM7JkVZMYx6dq07lKRMk3BzdKxXYPRcg4Igx7Mo
         VFTnpBJ8PXJjXwGcT8P45aJMnBjzQsmPm2v0DlJ8LJFjXYsehFROU+FiN1K9ZcY5rjwZ
         A6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWNfr1G2VmbF8aqnuokzaZWqxWljoyKR13DQdZAMclJXjh7PHLO7dAVdOyX9d+v/5teXrhNow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkB26boXx+LnUfAX+DzjMHHldKqQ4XVxstmCBz5oj3VryPycV2
	BplsqsE6TbBamp0SpV6NJ7EWYJX8urSfZK5kvRRWqACuhGGHL24mkx/FdC83iDV018Ldfb/8NAL
	IBnJ/iBYFr8JfwnGSOFtqNbYxqC3JBwkLBwiQ5YEWpEE+rgJ9mp3ozTlOvg==
X-Gm-Gg: ASbGncvzoNWWQkltlgu10FOih9+1xf2xHSfMrbBLjQQPbkqha9UgARV/B8ukyhDhjzA
	N/WpQIyARKMFb1msNGGO+wJGZdiqBChjTPVzJWpuX/03Af9SNzK0LVB6CzQp2vH+bxeeqvUMjtS
	SKeZEqRX7EkY5N3YU8uycS2X1onguprYPBwiVmVFfS2/sz8SpfLT7GurrlSxWxrsYWF221bEfp0
	gpNNklPrG+Oo4+TqbvWOeToOzq1niDyqbYZmG/l+z26+T/6vjORKDuM8LeBYhuuJ/CdY8cEFWh0
	7c4Kredl5Gyql+PEJp/r4x+OEfsyrAjYjr7/s7Ctj69Ar5SF55WjC03c+Ae98W8l8fh4fVFYmmn
	KMEwlEzXuS3+pzY2s6IiACKFozze2ZyNk6pUOB5oc/faaBuidPNjJvFw5oys=
X-Received: by 2002:a17:907:1ca2:b0:b76:74b6:dbf8 with SMTP id a640c23a62f3a-b7ce831e2e3mr253395366b.14.1765373319267;
        Wed, 10 Dec 2025 05:28:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAU24CehXasPvHx6jcPc3vVrMoWIf6zOTsD8QmYV2p1kOUcW+E6DKKRjQtR0ZRYSpTwif4sg==
X-Received: by 2002:a17:907:1ca2:b0:b76:74b6:dbf8 with SMTP id a640c23a62f3a-b7ce831e2e3mr253391966b.14.1765373318780;
        Wed, 10 Dec 2025 05:28:38 -0800 (PST)
Received: from [10.45.225.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4976027sm1661260866b.39.2025.12.10.05.28.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2025 05:28:38 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Alexei Starovoitov <ast@kernel.org>, Jesse Gross <jesse@nicira.com>,
 Adrian Moreno <amorenoz@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net] net: openvswitch: Avoid needlessly taking the RTNL on
 vport destroy
Date: Wed, 10 Dec 2025 14:28:36 +0100
X-Mailer: MailMate (2.0r6290)
Message-ID: <B299AD16-8511-41B7-A36A-25B911AEEBF4@redhat.com>
In-Reply-To: <20251210125945.211350-1-toke@redhat.com>
References: <20251210125945.211350-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10 Dec 2025, at 13:59, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

> The openvswitch teardown code will immediately call
> ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notification=
=2E
> It will then start the dp_notify_work workqueue, which will later end u=
p
> calling the vport destroy() callback. This callback takes the RTNL to d=
o
> another ovs_netdev_detach_port(), which in this case is unnecessary.
> This causes extra pressure on the RTNL, in some cases leading to
> "unregister_netdevice: waiting for XX to become free" warnings on
> teardown.
>
> We can straight-forwardly avoid the extra RTNL lock acquisition by
> checking the device flags before taking the lock, and skip the locking
> altogether if the IFF_OVS_DATAPATH flag has already been unset.
>
> Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
> Tested-by: Adrian Moreno <amorenoz@redhat.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  net/openvswitch/vport-netdev.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-net=
dev.c
> index 91a11067e458..519f038526f9 100644
> --- a/net/openvswitch/vport-netdev.c
> +++ b/net/openvswitch/vport-netdev.c
> @@ -160,10 +160,13 @@ void ovs_netdev_detach_dev(struct vport *vport)
>
>  static void netdev_destroy(struct vport *vport)
>  {
> -	rtnl_lock();
> -	if (netif_is_ovs_port(vport->dev))
> -		ovs_netdev_detach_dev(vport);
> -	rtnl_unlock();
> +	if (netif_is_ovs_port(vport->dev)) {

Hi Toke,

Thanks for digging into this!

The patch looks technically correct to me, but maybe we should add a comm=
ent here explaining why we can do it this way, i.e., why we can call neti=
f_is_ovs_port() without the lock.
For example:

/* We can avoid taking the rtnl lock as the IFF_OVS_DATAPATH flag is set/=
cleared in either netdev_create()/netdev_destroy(), which are both called=
 under the global ovs_lock(). */

Additionally, I think the second netif_is_ovs_port() under the rtnl lock =
is not required due to the above.

> +		rtnl_lock();
> +		/* check again while holding the lock */
> +		if (netif_is_ovs_port(vport->dev))
> +			ovs_netdev_detach_dev(vport);
> +		rtnl_unlock();
> +	}
>
>  	call_rcu(&vport->rcu, vport_netdev_free);
>  }
> -- =

> 2.52.0


