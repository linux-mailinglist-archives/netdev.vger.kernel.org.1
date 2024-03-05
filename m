Return-Path: <netdev+bounces-77565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABBD872314
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B99289C76
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA3127B53;
	Tue,  5 Mar 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn93Kep9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01728595F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653627; cv=none; b=p2MyDX6EdNi9iRH7TASn+daIOQfQgRnfmLfzxEMy0LF6bnyXHHAifkF0UISusMBQawhqnvtPWLBbpBJ5gQ8V8DWSbAO1SqYovTzzgAfalWEZMUP5gBE0uyBXjkICuM3Uu/ABBRVTLskLuL99hljldRqu6PM8PoqGWMBThDTdFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653627; c=relaxed/simple;
	bh=FEXuh7aPZCx/CSz8uFmyZcg8wFbn5WBkJuKn4llrKHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CHwaGKsJ7U+kKzYJXRlwlGmeaR3jxrQ0igQy4GrTWvflBk7jHD0KP3lbteMFUmL3TUzZsbbDZOhBUMIr+FEiN21QCI6C7/fMkwVfWi+Fk9k0k6I8bagcfli2hNb72wGCkCn802kbFcoOwcKWXhye9+DWBK1b7H+Ddy1mBnuKptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mn93Kep9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709653624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTHTZFSSmBz46FaV6w2gu++Ghv9Cs7q4lZmhZ9Kca6Y=;
	b=Mn93Kep9mtREBDWmlsoEOqw4INj2+mQnFi67ajRqVxvMSQkf12Pb6gug1BOPtlV6fTYB5t
	wvAekJiS/NLdFSTn2OCj3luz+gMtWwwkkINVic21kkZibUMHl7EoxrTFbHLJyHxBH/AOmc
	Lsa5CpufXQhrflkSiDLwaTIj+A8St0w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-7n3AWmOYOhadJmz8yskmeg-1; Tue, 05 Mar 2024 10:47:03 -0500
X-MC-Unique: 7n3AWmOYOhadJmz8yskmeg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a457845df7aso99780766b.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 07:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653622; x=1710258422;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTHTZFSSmBz46FaV6w2gu++Ghv9Cs7q4lZmhZ9Kca6Y=;
        b=oiC8q6ZMlWG+qs8Xe8TEjqfYHfpgRVd00beQuca+7M3xwGcw5trF+GBoguQXiROVGW
         5O61DfCOO69ACWwr0hVHBGOKtk6bkm2WG9+bYA8pxOIMd4AqE9R6sbR90GGQrvNWO/Ye
         XLFXqm9e/zdXT//3PnR33DPVQy1GDXbPyr8MsYD28Jm7YfY+klXwCdjBxhPww98yPILe
         qJGJKizJfhXGr0a/dlFGEZvf82qverrOc1xgnZ/cDPl+oL23n2M1+25ePwsVxy6RZmMO
         dphVuXStrSk+Z50/Ax4ktS2lhvc7ARm2wB8ytjUuNlFUpu39+aCneFyABeK14mgjnMO/
         eYsA==
X-Gm-Message-State: AOJu0YwUoy6s33RCxCNnDWGd9g9cvJ8YdpbYGNGK8PM+paGOGEW8qObX
	cFUTYKo76jk4vrM2BMpEDMkV4hpBJcdUj0YS9QUYhbUXBWgRdnSsepeQaXd0dpHjHscm48BUFtv
	wDQqAeyIR4SWKj0WmReqwYwjRe69Pf4hKHKw6wmkZAUs3FUPpBhOHfoi9nIOkbg==
X-Received: by 2002:a17:906:7ca:b0:a45:aacb:349b with SMTP id m10-20020a17090607ca00b00a45aacb349bmr1338476ejc.16.1709653621779;
        Tue, 05 Mar 2024 07:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQNmbVLw++QhhSEUPNbxq+9CI0G7fV/SEn4yFqU0DB9KZsF5i2KrFJayRdLs8oJVHcwM7qYg==
X-Received: by 2002:a17:906:7ca:b0:a45:aacb:349b with SMTP id m10-20020a17090607ca00b00a45aacb349bmr1338468ejc.16.1709653621606;
        Tue, 05 Mar 2024 07:47:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lm7-20020a170906980700b00a449fdfe27bsm4838566ejb.170.2024.03.05.07.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 07:47:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D2917112EF0A; Tue,  5 Mar 2024 16:47:00 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Fix up xdp bonding test wrt
 feature flags
In-Reply-To: <20240305090829.17131-2-daniel@iogearbox.net>
References: <20240305090829.17131-1-daniel@iogearbox.net>
 <20240305090829.17131-2-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Mar 2024 16:47:00 +0100
Message-ID: <87a5ncd6kr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> Adjust the XDP feature flags for the bond device when no bond slave
> devices are attached. After 9b0ed890ac2a ("bonding: do not report
> NETDEV_XDP_ACT_XSK_ZEROCOPY"), the empty bond device must report 0
> as flags instead of NETDEV_XDP_ACT_MASK.
>
>   # ./vmtest.sh -- ./test_progs -t xdp_bond
>   [...]
>   [    3.983311] bond1 (unregistering): (slave veth1_1): Releasing backup=
 interface
>   [    3.995434] bond1 (unregistering): Released all slaves
>   [    4.022311] bond2: (slave veth2_1): Releasing backup interface
>   #507/1   xdp_bonding/xdp_bonding_attach:OK
>   #507/2   xdp_bonding/xdp_bonding_nested:OK
>   #507/3   xdp_bonding/xdp_bonding_features:OK
>   #507/4   xdp_bonding/xdp_bonding_roundrobin:OK
>   #507/5   xdp_bonding/xdp_bonding_activebackup:OK
>   #507/6   xdp_bonding/xdp_bonding_xor_layer2:OK
>   #507/7   xdp_bonding/xdp_bonding_xor_layer23:OK
>   #507/8   xdp_bonding/xdp_bonding_xor_layer34:OK
>   #507/9   xdp_bonding/xdp_bonding_redirect_multi:OK
>   #507     xdp_bonding:OK
>   Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
>   [    4.185255] bond2 (unregistering): Released all slaves
>   [...]
>
> Fixes: 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


