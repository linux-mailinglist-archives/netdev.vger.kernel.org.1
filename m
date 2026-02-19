Return-Path: <netdev+bounces-259397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGctJ3t+lmlRgQIAu9opvQ
	(envelope-from <netdev+bounces-259397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 04:07:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC8A15BD37
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 04:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 807223014542
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5826B2D3;
	Thu, 19 Feb 2026 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gUZvwfqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE354654
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771470456; cv=none; b=qzFekxv0bvH8HJ80HiySXO4MHCorO3tlMc/Xd8V/0dY7WQTl/hvEjRNKwzL80FfKO1m6Ib+AIfJO4wWgY2m+plvqRuyXN5LVsNtFZvMfwKv7PoyNJMa18Sc2YgrbBb52fXPtqoRJToEWOAnKmNUTq+eRvY9Wr2JXCLMtmLxFJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771470456; c=relaxed/simple;
	bh=CtHkwMSsX/PQHM+rCwTONcEP7ipj9S9lwPqDm1G2TU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHHxwWf6vEB3weBObzX15g5WtEUm2q7gmmvlz2kN33daNregzfax75Sn/wzrUvpvczi5Rktar7ArcUkOLYxLAIbi/GtjLyplAPEMlEdwTfxbGYGRpD+YoPCSIIevfKt+u+H9ie6km32P3Nl6BDTfQV607THJvq8LoJdN3aFsEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gUZvwfqd; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-46413b2c3d8so141185b6e.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 19:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771470454; x=1772075254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxLPkM8L6GLDJDpp1vYLlNTIitTDnz/kCc/Md0UNwPw=;
        b=gUZvwfqdfNgCd2BNpxnJiT2PpMgsG3wgKKvcI3V7xiZGmzvukWE6+WmCorebLaWdSU
         caSlxNEmkKZhXBjXtqMKv8pB+4r16l5kuxye+SSwEklIgHXAwOP6cxhjV5cAWmE1Gcoz
         1Q6Pu1qO8UUQqmX0uuGmAZOIBrNQOtM20FcOAgTrtlpmf796sLyID8MIZe/ZMxUWS5ZE
         oyrfrOzbamsmy3ttAdDm6ND7JNrCCMk2I9d3q05jP73r1f6sbt5oPdHf7MqW/5dJSXpi
         wwrcfpHyKBkuCsCp+00Jkv1rRCa2nry3OP93fY1NMxM9Rv2sMdozCx03GsEkU88pQuUi
         W1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771470454; x=1772075254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxLPkM8L6GLDJDpp1vYLlNTIitTDnz/kCc/Md0UNwPw=;
        b=FkUEiQgB9nK8wqcR39xF/Xt4WuJyVxZJ+rUTyMdAm08lkfOvwAqJEk+UDqCSeVIIYe
         9pbZAcna5u3BePbRHG4sVoPQHAmoptQ7Ym6NURE5VGRxzewDYbxCvfa5CFihjjzHXJCU
         GunnenxjDvlRn0rJ0hsgTDlsmfQ1WZLw7mIHAI7viypWUdjNHnhGj89lzjYdDhE+9IKg
         aSoQiScp8xuI9Yq7lYKSnFxow4QNh7IEpBPlSTqEnETBK6vTSfcHbcV1GTPXJ+yQI8qa
         0upBZD4VkVrKBteSQqyYw1AiwdpnHnxbP/30m6oq1hi70h35qD9Nc2l9dlyns1dr/Vtl
         Z62w==
X-Forwarded-Encrypted: i=1; AJvYcCVFXqzy/ZB/VK86mccpMP/4Awl2X40B2zDlDqcVyR9B3wdJbnZwm0mjgPxMwrrRej7XuRM3VMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rKhfYwMfM9U3HE05wSxH3N23TTbXq5NKb6iPTWb+CkZ6G5Wj
	ZUCCpmlPazmn8C4qi3MEd/6ok8Py/lnjrBb2+Xfl+Cm1jsZhvE7WDM4DCJIY9mfd5pU=
X-Gm-Gg: AZuq6aKTihXL9RleEd5TDX1bpmL6XrdXY+W/bJkLef6QTmDK3gIUI6yKAjaHRg6kiW6
	TAFBFFJr7OfLinQf+lDItXcUtlo2MkUqpWsHG+qWOhllriA2kP6XdMtyLJopIX9c0kSZRKP3HBU
	E0LFE6UxeMD/2ny8SUFB18uucQKCvzlCmhq8rXUdo+tfGgudR3vDjkEN64Xqc6O+t81Gs8d6exJ
	J4oPKD4Xv7MvFK+ya75HGFFN4RnbY/qYkxC/45XXkB2RID11CTB4DI7vTvtnFlWQp7p7Ng4k4T1
	eM7wWapQm56trph0F1Vpq/xRH+WYmPgyg69G1gctuFKtXYNxInkv48nXkqmIMFQpf7ip4XtYRYc
	DYf8u1lS1th5+uKaNZwPpWjgsF65V2/i2ZD3/Bozsfq4cb5JHwyIrHeqJpVNo7B0AfeFds99vhS
	H6x+sfrA==
X-Received: by 2002:a05:6808:16a9:b0:459:9630:3739 with SMTP id 5614622812f47-46410bcbd39mr2220772b6e.18.1771470454220;
        Wed, 18 Feb 2026 19:07:34 -0800 (PST)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::281:62])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40ee62b6f61sm19367758fac.10.2026.02.18.19.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 19:07:33 -0800 (PST)
Date: Wed, 18 Feb 2026 21:07:31 -0600
From: Chris Arges <carges@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	jbrandeburg@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] bnxt_en: Add XDP RSS hash metadata
Message-ID: <aZZ-c1zHJxyldRGm@20HS2G4>
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <aY99llj2HmFNrR_5@20HS2G4>
 <20260213120915.6af2bc65@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213120915.6af2bc65@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,cloudflare.com,lunn.ch,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259397-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EFC8A15BD37
X-Rspamd-Action: no action

On 2026-02-13 12:09:15, Jakub Kicinski wrote:
> On Fri, 13 Feb 2026 13:37:58 -0600 Chris Arges wrote:
> > On 2026-02-13 13:24:26, Chris J Arges wrote:
> > > This patchset adds the ability to use an XDP program to extract the RSS
> > > hash of a given an xdp_md context.
> > 
> > I see net-next is closed: https://netdev.bots.linux.dev/net-next.html
> > I'll re-send with proper target after Feb 23rd.
> 
> Would you be willing to add a test as well?
> 
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests
> existing tests in tools/testing/selftests/drivers/net/

Sure, I'll add this and kbot test fixes when I re-submit the patches.
Thanks,
--chris

