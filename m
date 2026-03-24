Return-Path: <netdev+bounces-270864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPm1NJEGwmnOYwQAu9opvQ
	(envelope-from <netdev+bounces-270864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:35:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37302301B72
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8D13018AC9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0C39FCDC;
	Tue, 24 Mar 2026 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pc1uDuAO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0JybkEC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2F39FCC6
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774323196; cv=none; b=IrfcZvQG6d5GQqwRCqE+Jc8sbYf8VatCnFD9dCPNjt0Oj9Ab74aDCAHx2sVO23RV7/ja/65TIAe6zjQWCGhwiXflrGuBFRaAn+s9pVLQZyTPjBmT649MZrYGAd+QgYHF1ZcEjw4Cg9uqwqpXsjXASnd4QjnWATUIDkVtBg1/uvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774323196; c=relaxed/simple;
	bh=f5eH5RegOkM7tGHSLW8Dz7E6BRWVYutqTpKrSDIEH2A=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=KO/i+ap/PEjUHutw6gGuxazU+qPQlqc/ZiiEktl061XjmC8dxZRbCQQu7kYszhEtb+/8Axzq3agptjrM52UaC7xBS2xh9O7PrYPR/pAQximMNnPu0/y6Y4JkRhlaFxJB4ksBkQyVlhANL1//3ElvrPzeAHoT9hPX35bRdf32zDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pc1uDuAO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0JybkEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774323192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bba+U3knOzeMlTadL9yBzgVDq+/4BqrOIHttcs+EzXc=;
	b=Pc1uDuAOQnI7g6b87EJ0uQEDxI/0hFer547ehGlMdszxEgTOxlI3wzIHqWv5yEXyWI45wE
	U9x2OwiLYvWe7WC9e8jpMcjavuItvSLvXezMekMd3fH8eOciHt3OfY7jo4woevUNooyYvl
	QLSA8ESjrRiNw4Tv0bglBhIO6MtcCTQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-lVGxJ7OnNmq52xDCatfEdw-1; Mon, 23 Mar 2026 23:33:10 -0400
X-MC-Unique: lVGxJ7OnNmq52xDCatfEdw-1
X-Mimecast-MFC-AGG-ID: lVGxJ7OnNmq52xDCatfEdw_1774323189
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853a9467c5so33728955e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774323189; x=1774927989; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bba+U3knOzeMlTadL9yBzgVDq+/4BqrOIHttcs+EzXc=;
        b=G0JybkECPPKgl7jP5qzZW9XuxC5JXfTTOgYCR3mhb0y36p4p2xhJIY7P/jfVLzdJWy
         OZ3dHyYLqqG1SdP4JzIDCoYY8nB+9fOPevO2OCtM/Ob3qjKHuUWyFsSEy3vNjl2KD18w
         5mHMuFfvov0kdw9ve33hYp6jzsTVWS+mxodQUkkjdaVjCapJJaHnitwpWQMW/bDddhOP
         KCBtrXxgA6plpLXbMQS/CVTUjivoE9Zj3w+3Yt8BKrGnaWigcXhfGcaoDUesOiTKVFkE
         IiJFd1tw0Ai/4FhY8Bmd00T4d4opPNQ+FpEsi5nCPE19dGSz9JAS91pOiBiM+DAzC/lA
         jc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774323189; x=1774927989;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bba+U3knOzeMlTadL9yBzgVDq+/4BqrOIHttcs+EzXc=;
        b=hfe/LQX+68RQTgpVWr4MfF5StE9E59dXb6j4bvLNt6+GPsEleHawCJV5kTdR7wYXB4
         QqVHU6Al4eMOaleefm1WUN4DY8JpE8CcrVqDrb/fxW+M2C2MIGHiB+H+kw5OfUohAnr0
         0HAedfRNiWekpRt1mkp+Nv4IvQzJzl0rwRpkygrdNXX90vKdELZXyimS55kZSZbWcHJF
         Ip/tuhTAHwmdEMTVBYSsuUfbpZWceGvXUsyZFn5abZPPT4vERnN82XtCh8GlqbeMbJJa
         Bmx6/u6FPuU/uBWpSJ8ZqWrzbl7L5D0gpaCIkF8tUjRHuDg1vlUz5ttApISavDo1Vl1Y
         5yzA==
X-Forwarded-Encrypted: i=1; AJvYcCWFDzWZvjbYvYYgaZct8gma7lNm307WW4idIkZYa7Vys7QTbNfvlV7YNowhQHvy0/uSZIgvmKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RLj4/XMZs/nbNTP0lya4uRMaLIU5P/1NiHyoPbGFRac6e7T8
	AZS5jhk15Up3gtJQ1ZLwRm73bu+bTJDE6whIUTcAfLARRk/g34MvvDURz6ZakhEqhuYTwD65Rkx
	eVo7x4ci2cm8dpvhLc5KxtzyJOPzbj+S+MHVz0Mnl8z+q/CCLSOI+lbM0EQ==
X-Gm-Gg: ATEYQzzR8F0yHbG/4NY+VG651WR9fveo9VznTVrDUN/irN4pc4w5YTzW133zRgu8Es2
	IsHKcPirh1+MSqSwDIcaE0cfOKUvC2gw7TCnPcXrPKGK22p+ozOpRZalDTh+TWvIxp0MunXPCby
	TYBQouJ5AZikUL2q9U2gVKc2xvt1/v5Gz8rgTC2sxqEU1YAades6gIf/sctu5j+RIjGRsts8d9z
	K4PBSMQD8HZt8CPfgMIFxmojU3K/MBH5PIA8vdZNfy88SfPTb2SqVqf8ssGf31tolR12WNwXHPq
	j40xlNxnuytRG09Do3/x75u3eLDqsJ6Yw303WJOnkFXmZKGa1gdvk4opuHw/I2v2gfNAvxtxSIo
	fnKclDXtH+BQ6zKbZ+qAwDeAjSrJa//wh3eK/mGp6tY09VUY7ag==
X-Received: by 2002:a05:600c:3112:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-486fedb8c6emr207657955e9.11.1774323188800;
        Mon, 23 Mar 2026 20:33:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3112:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-486fedb8c6emr207657675e9.11.1774323188210;
        Mon, 23 Mar 2026 20:33:08 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711022f37sm11668195e9.9.2026.03.23.20.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 20:33:07 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aleksei Oladko <aleksey.oladko@virtuozzo.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>, Ilya Maximets
 <imaximet@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net-next v6 0/4] selftests: net: fix false failures due
 to missing features and host interference
Message-ID: <20260324043305.260d26ac@elisabeth>
In-Reply-To: <20260323195813.7ebccd88@kernel.org>
References: <20260321215908.175465-1-aleksey.oladko@virtuozzo.com>
	<20260323195813.7ebccd88@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Mar 2026 04:33:07 +0100 (CET)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270864-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37302301B72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 19:58:13 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat, 21 Mar 2026 21:59:04 +0000 Aleksei Oladko wrote:
> >  tools/testing/selftests/net/pmtu-test.sh      | 2492 +++++++++++++++++
> >  tools/testing/selftests/net/pmtu.sh           | 2492 +----------------  
> 
> I think I asked twice already to fix the test instead of wrapping it in
> another helper.

Oops, I guess both me and Aleksei understood it as "fix the test _by_
wrapping it in another helper":

  https://lore.kernel.org/all/dd1f8981-b8ad-4a4d-b6c8-3333fb05c93b@virtuozzo.com/

hence the current version.

Aleksei, if you need further tips other than what I was suggesting
(assuming the only way is to run everything in a namespace), this could
be another idea:

  https://git.netfilter.org/nftables/commit/?id=a9cadde4add1

-- 
Stefano


