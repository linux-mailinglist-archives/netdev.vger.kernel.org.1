Return-Path: <netdev+bounces-283142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNbzN8Nq9GkfBQIAu9opvQ
	(envelope-from <netdev+bounces-283142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 10:56:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5746F4AB22C
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 10:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19EA1301AB80
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3936BCFB;
	Fri,  1 May 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hrqd3LyH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rp8P3B9c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ACA2D7812
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777625790; cv=none; b=GYvx5ZcolIZ35/INvsqc35V1j/WBZe0k8+vKNC7XtFZATNKEni2aWWt3Sxl0UZ8QT4us/ZELNh4nqw8dDrFLQU+ESRoDAf4U6+0KZvm/isEeZxbtFCxVe0v5XvE5uZQAjii7HLGMrD/G5ZBNjUWtYoqaC8Ppdmc5+RHovjXcP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777625790; c=relaxed/simple;
	bh=VcdTqccw8iCYV5aU2Evk0F5GIMuBCHLxE9epO6wT83c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRgnt0Cw3QToV0ZpwnfBWg09t8vOk9s84WDtvg9JRpX9EQYO+yL1bml40Ls7QAE8ii5zLQHpcbYfr67Y0mS0/fDRFWDBwuQ6h4vQkb/KCrVwffndZAOK4rMtqaB4FbBy/NQf2HJMLg8P/oQJsCa05MTfWhgYU/8MGqTjwzioZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hrqd3LyH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rp8P3B9c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777625787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4FupXqdJDjM6lgFsqsbLspMhnAKLydPwExSEuFrajh8=;
	b=Hrqd3LyHxvtltFvFu8CymMnt9QGc8/u8KXP5qISvlp94yLDLFOS/7A2EDWrDHX6j4sjAA+
	f2bloEonr1vpcd/yYETf9f7iBtphYzHB2Wtc4n58SRTT+cSVOWZETzbJDGDN98yeOamC68
	QBvAS9C8Npeb9r8vwGZRTK3dlbokTR0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-UshOxhYJPuK4bWV9PhLsCg-1; Fri, 01 May 2026 04:56:26 -0400
X-MC-Unique: UshOxhYJPuK4bWV9PhLsCg-1
X-Mimecast-MFC-AGG-ID: UshOxhYJPuK4bWV9PhLsCg_1777625785
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b9c603ec28eso157561266b.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777625785; x=1778230585; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FupXqdJDjM6lgFsqsbLspMhnAKLydPwExSEuFrajh8=;
        b=Rp8P3B9cmHsrwQr6LwznSsrvFRVnK4noA3C6FMJpbKYUkDVvnanYyJzJ6wJofR3Rv+
         XgjvNmY00whtnIJ4NjnUIFW42FLoM8BafFP/v7zh4Vl/bEMq4cWJlqI2y5PVMOcRevHj
         WNfURkPbCgVnTpgCGoVJ0OHFkW0nkLWiRJoS9t4IB6UYdbJNosMXxXpcpkNJ/N9U/p1W
         jvA97uQoxSkkeCe2pMySdaPJesGFYnHufiIB7uNWmM3r82K5dObR1VYe3f+uR3FnXvmW
         ym6/Z5ekbO+b9aqQPG5M2JJIjm7Bd7X9UK763pybmOHRTo1sxC/4FpYhmzg0SYfOp2zV
         TkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777625785; x=1778230585;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FupXqdJDjM6lgFsqsbLspMhnAKLydPwExSEuFrajh8=;
        b=jgGJac6B6/+bTeeAnzCVhVugAUJFYl40be05obUHVqPXYvWI7OdOJfgOps1gGX86Nq
         FZlc4mt6VWxuwIupKRDDAS5+kHBqQZuDnA0bIvy3RMQ3VHlM683Ub6ZYy0hi5tYUfsGg
         Dx8OxjpJFznKndZohME8NAZvxPdU+mn5zuu/pAWG/8DSW/ddSpZzR2aYftPiWBo63RGm
         XjiPpMYulHwL3wbrM4FcE3f5FGEHvIhDhfs0FiYp0cUF9pHe4F0GXfdBUhyh+OCPscmS
         AWa1V64EGLxrN9uzRUPtNkz8CAB57LX2vDcSZK6dbeThh0qKz2TzKLCi0839uhxk0ajS
         8Icw==
X-Gm-Message-State: AOJu0YxfryrdsvPVlOAzt9YY9FxSxAsTb+UbfBKVtMvJ8iNPt5a5s/Cm
	/D781BdS3jF+ZdUe1pVydsETk3ZGAmA22+X30/Cz8QTeMa6cG3KNzWaVb2KsYeR0XvNtU19WttY
	bLE0EG4wnmPlBrSngeRBtOsp2Ek5uMMaburr25/Agjua8dCk5P0Nb7JgaBg==
X-Gm-Gg: AeBDiesdigD6BLR5Z7+ufcegORV56qcZyg2mqlfxDVMscG/y3LLF+JW9221h9o0QEuZ
	FzTC0gku7Ia2Qk/XHNq+tsxYbEYMuWAzJ+OKQKzRH+2LebW0oYc0CHkXv4wvB3ZfDNOYEryrSMZ
	tqAOklLjPnornvVLNPt/8RqW8SHt3vel2/3QcLvyaPU6SLwFbcuyPzgJ7zWm4l8YoqFDxRetnsr
	39cB2L6qWcAmAeIkMvJtqFbsPM6ksA2jJXM4DJc8ZDOc1mtM1z6VoZScmcV5fdzyAyOZQ4/s8bc
	XoI8Yycu/emShPTWVPliP5Hq9QmyPM0mh46o++yznJUSvmgD4JBSG+KbQOEfXddsthG4Ovk80N5
	4QHMoXsAXsOwoMfqYJwz1hzle0hrWZ8sGEaFFnxq8gJZxaj2ne5Mb36Z0PaxCk2HLxZeyH+TD9E
	ZknzuuSQ==
X-Received: by 2002:a17:906:5192:20b0:bab:d8e9:53a7 with SMTP id a640c23a62f3a-bbac6cbea67mr326061566b.29.1777625784839;
        Fri, 01 May 2026 01:56:24 -0700 (PDT)
X-Received: by 2002:a17:906:5192:20b0:bab:d8e9:53a7 with SMTP id a640c23a62f3a-bbac6cbea67mr326058966b.29.1777625784314;
        Fri, 01 May 2026 01:56:24 -0700 (PDT)
Received: from [10.44.33.143] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe69f6d84dsm85387066b.2.2026.05.01.01.56.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2026 01:56:23 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Yuan Tan <tanyuan98@outlook.com>, Yang Yang <n05ec@lzu.edu.cn>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: openvswitch: add tests for tunnel
 vport refcounting
Date: Fri, 01 May 2026 10:56:22 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <89F36D27-11BD-46A1-8C1B-7A1B89B35C27@redhat.com>
In-Reply-To: <20260430233848.440994-3-i.maximets@ovn.org>
References: <20260430233848.440994-1-i.maximets@ovn.org>
 <20260430233848.440994-3-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 5746F4AB22C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283142-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 1 May 2026, at 1:38, Ilya Maximets wrote:

> There were a few issues found with the tunnel vport types around the
> vport destruction code.  Add some basic tests, so at least we know that
> they can be properly added and removed without obvious issues.
>
> The test creates OVS datapath, adds a non-LWT tunnel port, makes sure
> they are created, and then removes the datapath and waits for all the
> ports to be gone.
>
> The dpctl script had a few bugs in the none-lwt tunnel creation code,
> so fixing them as well to make the testing possible:
> - The type of the --lwt option changed in order to properly disable it.
> - Removed byte order conversion for the port numbers, as the value
>   supposed to be in the host order.
> - Added missing 'gre' choice for the tunnel type.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Changes on the v2 look good to me!

Acked-by: Eelco Chaudron <echaudro@redhat.com>


