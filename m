Return-Path: <netdev+bounces-253568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KFOFiS0d2nKkQEAu9opvQ
	(envelope-from <netdev+bounces-253568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:36:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 048BB8C249
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F96F303433C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FA7242D89;
	Mon, 26 Jan 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZJlhWu5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7723223DFB
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452553; cv=pass; b=SlIF+Z3TRvgFkhEP0yzS3Cto++DZmcvP1LwtMnfcKXQYtNm33dSPvQ9RwnXXp4Cl3gXWUhrwGTXEbiyn7g8FeK4m9DrtSewNjOYb4g9/pr+grUYwdzQr8zK0YPBBS5s4nZdxRn+QH2pmfjxPk7cR0EgkDsbvdXJ1+d6cEPTuYsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452553; c=relaxed/simple;
	bh=n0d9etoImStOtf180njrpRy40UW+vGni69BcVUKbKH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RH05Aw7AZl1G5JmcwDV1zFm1LH/p4vLpjptnNOpSMud+OHdnnpgCpp+Irx3h3zpC2eBzoZcRR2ntdqQkMZ8M+dBPAnbNgq4zCgVXEkpk8LbZTqhLhC5ECErno8OF+QS60g/3cKJeXan9XwuaL0//rfkgFCSSwjWp33TnTGcjY1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZJlhWu5; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014b7de222so58766251cf.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:35:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769452551; cv=none;
        d=google.com; s=arc-20240605;
        b=WD5IryyaCxKUkGgz9WTXBhqv1ZBc38lz1UyBk8dx1LNlQ744h0/nCl7nFMnz+6kuFS
         axyh1y8dC9L37MN+T+mXozU4DUtW6Y/O+RtwKor7OXG61DIsza76Tut2j4aEIDtjF46u
         7InNivnlVazJzJkhA7RTnNyf7U5CSXC6Hs8rFT3OUNllTrdXLmoPXhXjDAKpxxoAtFNT
         cWG/Bh5Do/RRDByGsBi+YCQ9/gzrKGFFwrjgE9UykNnDwbBp0dcA5Pm52F9XQQ5SvwYG
         11ekb3pigiwj/c7Eb7Dp0uVSSKqBZyPk0szywrHPrkGXrFo+eR2/v1soGqqaWbsukxUr
         Xf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n0d9etoImStOtf180njrpRy40UW+vGni69BcVUKbKH4=;
        fh=OViGm4Y4+YL5/rdN4+wDKif+AOz2KTRjNRn7WVmATkU=;
        b=T0/k6wTn2EsRhZd8lHTIfWNBL4hsjACsMWIYZF3u0lzbvJnNwE4d8UuJU9JbipzCRa
         itv3tpOcgpuW9urS0+0IMd8lImy2zrLlng41j57+xDktVcS71u8X2pQZ5fVxKg5zW+xk
         n6ZCouPZgjuC8lLR34mHEENdgANXFf82Topn9u1msxSDIJ8ruI49yun1MQV/DWFV5ux2
         gNjhOrjhNFOtoGpWDON2umubloHXNzOJcKefO26+bHdKySIhFhfdZkb1zrA+uXl23T0A
         E5fkNmQLzhNJmpvUfJJLBXSCm99G4W9phqeL6HqiM3AbQG/xy3Aqg8+0Bb/KAjtPksk4
         jplA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769452551; x=1770057351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0d9etoImStOtf180njrpRy40UW+vGni69BcVUKbKH4=;
        b=fZJlhWu5RhzyyfNH+oCpZJ/WA2QFLiIAGmjUxjpSxAknYGmjAToQ35kLzHJHplIULn
         dGDZigzoO4BcgSPvAGttGZdOV16fNrEjy/yGooIwi8J5wj2zK89wrFTIkPHp9ByTktAM
         5F7v8vgRfknaUex7EF3qFXNUyxGS7xVhdJXHKTwBxNh0yG8StkN60+CBIR/675jkYMjl
         dwD5NJb1Eh8Yde63gwQIOSWziJmaSzUogeTDq/GrcFBpbk54C2qilrxKYt70lqvHjFYw
         E1aZ5kdTOuIqnh6AESE4ervp4la4wx1eo6nx2UNyUYe10PsBTVvqFOLMMnT7vd72mUW3
         ITrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769452551; x=1770057351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n0d9etoImStOtf180njrpRy40UW+vGni69BcVUKbKH4=;
        b=MxupvZInAqZAxH0BsOb3EwDI8BxNEi3om5MVFxaFohp0GZyL+XJM1zQ5hunSk/lDDH
         o9ARtGiRPUbHnF4wsN/QqMLLYc24Vj9t25ACwWHbcH4nbXJZknYvCTgOLG2yVvtlQF+y
         iRqHw4fH/du17peKqkJxKh2vePYi5vwechKe2Yc/1jqCBuHfClgU2VVP57HhegXepm+o
         aWhtXJgvVjkyR6AzBBlnzgRI52+YnlwoEpcCjr7hpQy9W50L1kaQtVnHORC9j4pYmEHR
         sMt62cSqIunUh67rxE1hBuZkKziZSVSHaOEqI/9GATdKjigf+zz3Tqe7Jvme0fARvwZs
         j29Q==
X-Forwarded-Encrypted: i=1; AJvYcCULJtpbDqntHkdjkSLeC6Y6wkAS2P9JBlXZ6/ZiozJVfcevAEjfeIa0muT7lgZCBgO/l5p+C6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmt2JwGgkVF2rfti5Ed4+jFTIAinm5MjptKyuvccEYpDXIOzeF
	qyrMCikcCeiiTe11gfY0EJHDoT4dsaZCnkeYxIG1LQf6SSOewablLyi4CDdBlvMj1GcjrJK/Ncu
	mwXVL+MFgSXGmP69nxjdTfNRX8ENPl5TdmiM5jsBPXXSSBOYNshYxdvBz
X-Gm-Gg: AZuq6aKEIK4iRRMaIjVWc3UOfQ9U/DlUjDmbAfHLG58sXdgivM2hPrRAZPpvVQdwL+V
	aMLkf3QbB3D+cwVHUz//I3GdmUFZpKEZhUPR2tBCifdkx4F6w0rYqBCxJqku6R3Er8K/tInhZQX
	QsmwZI7rUI0uBJGTfYo1V1JmG8YkppDzvwr1ErVasauwZoCAnqSX5pud7mxA1gRIjILlD9Q7ldE
	MAymJznFJURmrs0uiTBoMU9LaE6vsGbchNc9YScuIQ9HVH3i4jy9L8CwSdLBntGBUkPug==
X-Received: by 2002:a05:622a:1209:b0:4ff:b1e6:3171 with SMTP id
 d75a77b69052e-50314bdcf09mr57249371cf.36.1769452550362; Mon, 26 Jan 2026
 10:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123162159.2877941-1-mmyangfl@gmail.com> <20260123162159.2877941-5-mmyangfl@gmail.com>
 <20260126182928.39ab1d58@pumpkin>
In-Reply-To: <20260126182928.39ab1d58@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 19:35:38 +0100
X-Gm-Features: AZwV_QjdtAOqttmqrhZofjoqPgOB6c8MnEKGSEL6OSsF58gyLqt0ewQyx33dbuU
Message-ID: <CANn89iJrDgD4J=mgWRcQMW70621OUV37hucj76ugZUXBLdy_VQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/7] net: openvswitch: fix load tearing with u64_stats
To: David Laight <david.laight.linux@gmail.com>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	dev@openvswitch.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,ovn.org,davemloft.net,kernel.org,openvswitch.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 048BB8C249
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 7:29=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 24 Jan 2026 00:21:36 +0800
> David Yang <mmyangfl@gmail.com> wrote:
>
> > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > against load/store tearing. struct copying should not be considered
> > tear-free. Use u64_stats_reads() instead.
>
> Except that the compiler doesn't ever generate 'tearing accesses' for
> aligned 64bit accesses on any 64bit architecture.
> Similarly memcpy() won't generate problematic accesses.
>
> The problem is purely theoretical - the C language lets the compiler
> split accesses, but it doesn't.

Yeah, although we still have races that KCSAN can detect.

data_race() or READ_ONCE() would be necessary to avoid noisy KCSAN reports.

While many LCSAN reports are boring, some of them point to real bugs.

