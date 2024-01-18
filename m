Return-Path: <netdev+bounces-64174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89348831903
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 13:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27E3B228B0
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32D924A0C;
	Thu, 18 Jan 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBZDZnji"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405724218
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580386; cv=none; b=cA/xVmuO/5BFwOYdoBWScs07PaLwM002T1kOyMYtFdqafBWE+VmY4xl/4cWWUnqn8LnSBn2MR8GXloMlZI1I+6z45k7kTUTeSRS+9K3Q1fPCjhDJOJkgnDcXXncXZvyweQu52d3FRrB+NqkZKMRt1J4ePUL4qC335QGkNY3iGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580386; c=relaxed/simple;
	bh=AEevfr9XoEmXV7CtmjTt3x1naHbjv/B6KkwqHnPrMlA=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=q3ca/Mbyl/ykyZ2m6AR2GZiBrzx+GVqc8UBadFi1/BftLt40OTAzzXJLIEF22f8Gq6LTSJSy3fuzHmUT9UGRPxRyNE+8sYYWPKSCXhK9BLbg9zzXpsPqBrlc+8p/zO0if3FMFgX6MYTJPKuJ5Ph6+1OwgZoXSI1IQ9CWBF0IiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBZDZnji; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705580384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AEevfr9XoEmXV7CtmjTt3x1naHbjv/B6KkwqHnPrMlA=;
	b=PBZDZnjiefxySi1LYFaLJenLryOvdIBJAk7fu+7qyvgOUMMPIYKjNwYnl5+f0cLLsb1RPw
	NnT0rEkmTUC1UsTunNxWIMDxMs8X27hGp2Y8go7F2MVHlgyaSkARAtzIKxXiPfzfJmG1GC
	4Hyx1p9pVyuywYCVt1RT+VmyRSL4j9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43--2VImU6ZO5W90bGXmrsWMQ-1; Thu, 18 Jan 2024 07:19:42 -0500
X-MC-Unique: -2VImU6ZO5W90bGXmrsWMQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e4997b828so17098885e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 04:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705580381; x=1706185181;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEevfr9XoEmXV7CtmjTt3x1naHbjv/B6KkwqHnPrMlA=;
        b=QGS5a6yPEpeUTlCDvP2edheSDaYEnBayWqNiut1RNYGRUeThLIB+e7HbyTttQWaEmX
         BjvXQLvjg14wdLDx/IktEOEJIxQb3Yp915AjmITc2f5IZTQ3Lt+xAwonVyJOPZdrAEiP
         KzI1v72D3SGiP1IY+qZpCtW5/5OvZEdMmeEauu/4uwChCQa3qN9OMlSYJ8Ub+3eZ1et2
         ZyWMEn5EXS5cH25UPPt1SwsVoQXgS+Tp3MJQR7UcgkAz+1SyetU0DPCgsnHdHfYKK/Rm
         nAUgvPA39r3V2etG88ynr9NgjtpM7Wz0S/tBR/nwJF/io1T05l6x1k4NrgQpHC6+OKdj
         YSug==
X-Gm-Message-State: AOJu0YyN78ZkUzlw7yhGJ/lAj3GLjE6MdkuZ/m3Vxui/tsxTvYCJTq97
	kg9msr8sKluY7i40ecXSyMn0d8I0vMchWYWfiksQezuvJdGUB3YZOoMtxdBLd8kcSIbr2+ODjWc
	XRL0CH39FqA5Up7e5eCSRySKgksDMlTSsHVu+M6PpkXpJO/yoy6ESKg==
X-Received: by 2002:a5d:508a:0:b0:337:c58a:ac91 with SMTP id a10-20020a5d508a000000b00337c58aac91mr898911wrt.1.1705580381460;
        Thu, 18 Jan 2024 04:19:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcJ8d42KXzo+C7TSGuKsXc6BQMfAYTM/431jeVFDg02NiLe+Zo64bFkUy1DHsrWVEHzzkdzQ==
X-Received: by 2002:a5d:508a:0:b0:337:c58a:ac91 with SMTP id a10-20020a5d508a000000b00337c58aac91mr898901wrt.1.1705580381087;
        Thu, 18 Jan 2024 04:19:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-180.dyn.eolo.it. [146.241.241.180])
        by smtp.gmail.com with ESMTPSA id e40-20020a5d5968000000b00337bfd9bd47sm3908789wri.73.2024.01.18.04.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 04:19:40 -0800 (PST)
Message-ID: <1137d26fb5fc1ca7070f8012ec588116a29a1c8a.camel@redhat.com>
Subject: Re: [PATCH net-next v1] vlan: skip nested type that is not
 IFLA_VLAN_QOS_MAPPING
From: Paolo Abeni <pabeni@redhat.com>
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Jan 2024 13:19:39 +0100
In-Reply-To: <20240117153810.1197794-1-linma@zju.edu.cn>
References: <20240117153810.1197794-1-linma@zju.edu.cn>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-17 at 23:38 +0800, Lin Ma wrote:
> In the vlan_changelink function, a loop is used to parse the nested
> attributes IFLA_VLAN_EGRESS_QOS and IFLA_VLAN_INGRESS_QOS in order to
> obtain the struct ifla_vlan_qos_mapping. These two nested attributes are
> checked in the vlan_validate_qos_map function, which calls
> nla_validate_nested_deprecated with the vlan_map_policy.
>=20
> However, this deprecated validator applies a LIBERAL strictness, allowing
> the presence of an attribute with the type IFLA_VLAN_QOS_UNSPEC.
> Consequently, the loop in vlan_changelink may parse an attribute of type
> IFLA_VLAN_QOS_UNSPEC and believe it carries a payload of
> struct ifla_vlan_qos_mapping, which is not necessarily true.
>=20
> To address this issue and ensure compatibility, this patch introduces two
> type checks that skip attributes whose type is not IFLA_VLAN_QOS_MAPPING.
>=20
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Why are you targeting net-next? this looks like a fix suitable for
'net' - with a proper fixes tag.

Cheers,

Paolo


