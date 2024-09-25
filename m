Return-Path: <netdev+bounces-129647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB09851F9
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 06:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE865285397
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 04:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF114BF97;
	Wed, 25 Sep 2024 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkcGUdaA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAFC13AA53
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 04:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237928; cv=none; b=u9TXnmvSyUxrOGl1hCS3iTuOX/Ef7UW7HEfahNUK4/4u+FpGA+yWQMIdptqgTe3V6GjhdVygIO48A1xvCz/BdZmyMtitugDlQTuFaOcX4K0oGuJjafBbD5hT2WERSxto8KrmYEpwhgz4jbVTA5ikN6DHCY1LHhylxnFW+qwMZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237928; c=relaxed/simple;
	bh=G3chFIunKoa6UYZkePQmH4EEA+5fZM365dBwiUGSCYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEZP/XGeylxtJXr6udKV4IXv70eyTACMbeO2TM1DHH9+DTuVza1KuxOkiEUcZrigLyHmAkUYUOx9JDq1coheibb07Rn2NB9bO7uWsA7tt7WrbHYx9QbeNvICAyBzwFqHJ5Sm25a6JoYoDpQ8OKGm8G1kq0VADCPtPIZjjpSCs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkcGUdaA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727237924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3chFIunKoa6UYZkePQmH4EEA+5fZM365dBwiUGSCYo=;
	b=KkcGUdaAVRsi6FrbC5uj04+u4m6OvetjE+sgTUeoOQwGoBQdpzFAjwTcl5274uSPbNdk1b
	vQFOk1K54EMsboNmK5SSQ/dTB08Na+ZHIwUGs0pajDI+rUOCcjsvVLHKSAEvBlENiEu/FN
	hSZoLb2is5staFwu2tfElQE9J+hPWW0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-1aG2r8UfO-OBU83PsW8qbw-1; Wed, 25 Sep 2024 00:18:42 -0400
X-MC-Unique: 1aG2r8UfO-OBU83PsW8qbw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e07e7be456so2845a91.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 21:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727237921; x=1727842721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3chFIunKoa6UYZkePQmH4EEA+5fZM365dBwiUGSCYo=;
        b=croP/ogR5ru4yv5Cm4xvTzMENo5DOLdhrqunYxBvV91TuwkOgry9dMxmxz7BJGdG0V
         +iAijWfAv+ppX6SCRURmrzmi7LTSqZPymygRznNW0PbX0vc9GVt/Aj9ap3QRx/J/1bR0
         hWn7NygvITksHXs6U2cyaJ/HxoZDp0FQSIiseGwqkG7GHQ6SvIWOafzllo8bicaU8QYB
         EJTjvSh1fqNb5IPWFKqTnQrABvCk3ThEWiqloytB23kHQkkn8hxNz0xJNUVlN1Nq72sQ
         zF5xRXkXWqMkx+bsPLZA7Jbj0o01OkcAUJFSQLMcXesYNdDDBdtPoQXIOxaxjvk9uZOK
         IlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXegAC5XdDN3ilYAWSxNKDMLKj+Z4OAo+irYRDSb6ILFnPrhxDZzxQ8V281t1VcTlCmweY03bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNLmkcV3v/wA4T6UBpG2xDueFzzvIGKlycmfZzDCqD1DCbnAW
	neYXJps8DKr9TgoqubUeNuTD+RKTkegv35XG80u800ti68IXJA7iAuAVQX+utn50dNtk4ZJ2ZWZ
	HYXZrnvPSzaSVM+5fnx8FIdSbHglrT6RFSbXhDU4OuKEZcig81aLv2HYNy/5b8BOqz7lEehOGqZ
	JxdO4MIh7U0uSfwo5IScFbh7xXGn8P
X-Received: by 2002:a17:90a:9f87:b0:2d3:c664:e253 with SMTP id 98e67ed59e1d1-2e06ae4c868mr1799737a91.10.1727237921635;
        Tue, 24 Sep 2024 21:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/2nCEr5Rgl+muh77Cq7muUEu6owuQxLm2BQIblXASXkR8C6qM167lFWkF2jWG0c97NVdwJzaslcF1/n2mzPA=
X-Received: by 2002:a17:90a:9f87:b0:2d3:c664:e253 with SMTP id
 98e67ed59e1d1-2e06ae4c868mr1799712a91.10.1727237921137; Tue, 24 Sep 2024
 21:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921231550.297535-1-linux@treblig.org> <66f0378ecf981_3b28232942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <66f0378ecf981_3b28232942a@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 12:18:29 +0800
Message-ID: <CACGkMEtVAQKKywHXmeOagik_4pob2Qv-WimLQEKG4NAcM=r9xA@mail.gmail.com>
Subject: Re: [RFC net-next] appletalk: Remove deadcode
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux@treblig.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 11:28=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> linux@ wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > alloc_ltalkdev in net/appletalk/dev.c is dead since
> > commit 00f3696f7555 ("net: appletalk: remove cops support")
> >
> > Removing it (and it's helper) leaves dev.c and if_ltalk.h empty;
> > remove them and the Makefile entry.
> >
> > tun.c was including that if_ltalk.h but actually wanted
> > the uapi version for LTALK_ALEN, fix up the path.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


