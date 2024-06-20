Return-Path: <netdev+bounces-105149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DB090FDC1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A3928222A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0F4DA00;
	Thu, 20 Jun 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0nW0RDn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3C4AEE9
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868589; cv=none; b=pE215VR85Iz6ZFZ55L7bb6bO2hRAZ5ssvDPUvL0vvPuXA5GYk39tUI/RpU8IxxL7abiwCTPFHr6+T+3LfaY0y3/mIyxIGvitPCDc/yX2BF6kPpRsnaDZft74X7ru7jsdU0SQwd5ptAf59yLWl2tMW/XXmkemYm6CXQfNfycahHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868589; c=relaxed/simple;
	bh=8ZmitoDbH+cVJQHrcxtblPDnuNim+KyNprGyFrJmgUc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WU9k2n9b+0uWIbcnShyUkxU1oOQeMcaZAX6ahc+ifvM2S9xVz1to54K5bgZrSIUObg116lb+aw9yvfFdvPVH8QMjVSvv13t+R5gf8OINhxKLAnbQjizACFmYuh9FgTg97Bq9dyklaMvoFz0fo/Oj4yE1JsFyDgSWLQT0/JJzrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0nW0RDn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718868587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztKOnDGsf2GzDyPBbwHlxz7MtbZW2Vf4Gzu8EVZGA6E=;
	b=H0nW0RDnrxWsyXA1xvO8idgKENQ51VNSTNUWYsaeX3go2RPsFvDpkCaBw2aYoBHJFmIZDQ
	1QkNVnPbG/E17DOtPJMgQHSjomVORPnD67BDeqCZ6T+lzO84yR24H2bTUPAXf/xWLXJgwt
	ayeMT3MqC52Y+NlCiLUICIDeT1etZw4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Wv_kb3rXPZSpGqX5qCv1PQ-1; Thu, 20 Jun 2024 03:29:45 -0400
X-MC-Unique: Wv_kb3rXPZSpGqX5qCv1PQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6af35481ea6so8388466d6.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718868584; x=1719473384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ztKOnDGsf2GzDyPBbwHlxz7MtbZW2Vf4Gzu8EVZGA6E=;
        b=I1imBpuFAIe5rn0T/3K6+QXZHM2yCb6p993ZT8Agv+zpXpfRS8lRsYl/GUIvx0bY92
         zUdCEuWCvuM6vvHfSvwWoFi+HImqOmbMU09FgLGYYPCaF6bSnxn4+bjFM/as8lG1/uUT
         Mf1+VWFIdPr/SlfWCgl/vCwaVZW2DipfGrHr98LVOzezGj/50xdBupgQqYo1P1NxinHs
         ZGHZocuqqgC2TKQ+/68pQfWDtxj9M7mvno35EJ4CwUUvsZ02D/KtJBvZEZpH+qC2MGz5
         cLQkF/vASIy3SX5k4wiXg+8S1Cl0rtUo1gTbUE6yo9di+MfdXisBoIi9/zmhuCv97V0q
         t0Ug==
X-Gm-Message-State: AOJu0Yz6r14w27opnkMHgEOq9Dd24Gu8vf0oEuhZqnFBJq6YA9ZTFBkY
	imsc5uGJmvjKZdY6NvdrCEj/FMavq0Ruuw7FtiY8Tef/e27YoPG7Wm4iWWhhSj2mjN+A8PtwAy0
	+38ZG33RtPBZHlnTA9GMT8xMprtahF5kpY8nHG7k5xUFTMW/sYOG6/wqdWLkeWRIUCLdCbXsLlh
	CifblpgQRJXhO8fw2ybyoy+KVNsUyD
X-Received: by 2002:ad4:558d:0:b0:6b5:6f9:3690 with SMTP id 6a1803df08f44-6b506f936b8mr32298806d6.36.1718868584644;
        Thu, 20 Jun 2024 00:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtucCfTw18OK/4driyigN7DscgMAJqfUMg8ePNH2mvWjujEgVbf0sK3qaDLw4s0/Ak66TSeuNfD+4wwT5BsSc=
X-Received: by 2002:ad4:558d:0:b0:6b5:6f9:3690 with SMTP id
 6a1803df08f44-6b506f936b8mr32298626d6.36.1718868584389; Thu, 20 Jun 2024
 00:29:44 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Jun 2024 02:29:43 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240619210023.982698-1-amorenoz@redhat.com> <20240619210023.982698-6-amorenoz@redhat.com>
 <20240619183943.5a41f009@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240619183943.5a41f009@kernel.org>
Date: Thu, 20 Jun 2024 02:29:43 -0500
Message-ID: <CAG=2xmO5jY7Rj=O+ZToRn=aSLXSPc4anzXfZM+_-PxMvqacWhg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/10] net: openvswitch: add emit_sample action
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 06:39:43PM GMT, Jakub Kicinski wrote:
> On Wed, 19 Jun 2024 23:00:06 +0200 Adrian Moreno wrote:
> > +	OVS_EMIT_SAMPLE_ATTR_UNPSEC,
>
> Are you using this one? Looking closely I presume not, since it's
> misspelled ;) You can assign =3D 1 to GROUP, no need to name the value
> for 0.

Good point, thanks.
The openvswitch header seems full of unused names for value 0.
I guess it's OK to break the local "style" if we're improving it?
Or is it better to get rid of all of them in a single cleaning patch?

>
> > +	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
> > +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> > +	__OVS_EMIT_SAMPLE_ATTR_MAX
>
> kdoc is complaining that __OVS_EMIT_SAMPLE_ATTR_MAX is not documented.
> You can add:
>
> 	/* private: */
>
> before, take a look at include/uapi/linux/netdev.h for example.

Thanks. Will do.
--
Adri=C3=A1n


