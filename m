Return-Path: <netdev+bounces-278101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBBfEhP/3Gk3YwkAu9opvQ
	(envelope-from <netdev+bounces-278101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:34:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0088D3ED5B2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10ABD3012CDF
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEBD3CD8BE;
	Mon, 13 Apr 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBHxkyDe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mU890H6B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55563DEAC5
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090881; cv=none; b=DoD2mBm80a8kx0+M6ZancqPUzC6WNecX1DPSimrlqUKn7WXBn+06+U5vFhA0iCyoch7GMcMAtA9oVmpjkhT/rEzT+gBeEWU1RWzgW3CcM/urJescU1iMDle4XV6qGsxuNbup0iC2/MPVEVFYCkAwag6ONvYX6JyOH7ks7rRUjt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090881; c=relaxed/simple;
	bh=x1ifNN1rcjcfnsQCTrP/kpfGUY+peyLroDHGkro91+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpwA4Gx8UxBUYIPPsR5dvqfWE05E2p6Pqt3JbOAZEdzF/KF/PNbV0C9Fi9QmxPOnkdOQ+gYEZJh1XcDb8OYMfM85If2u6Y35m2lc63CWKlr1zAW0tZj6v/zJrCpXnRcGD9CbQdnW0Xtn7OC2WrfXhgnc40lipLINjL2rE/sl01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBHxkyDe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mU890H6B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776090878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgI4zgdDV6NmMPo5aAmiFT+6Ssq8rA+mnVDfSWSrmkU=;
	b=HBHxkyDeZi0c1dpma6W1FIZ/ePLSre0zDaAVjHdVZT3F59bDVSiVNd4O5lxJlcGAR7r853
	W0I9jQ3OdGEKiA7m+asalvTgqxpmEUuOMcZNW+zH8G5Gf1Q2bMjTHTRyjUUgIKTOjHO5BE
	ROZgjjtyxRwmxW9v558claFbSiWWQL4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-KuZn1V3JNji6hjefI_jVnw-1; Mon, 13 Apr 2026 10:34:35 -0400
X-MC-Unique: KuZn1V3JNji6hjefI_jVnw-1
X-Mimecast-MFC-AGG-ID: KuZn1V3JNji6hjefI_jVnw_1776090874
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d00dd913cso4871439f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776090874; x=1776695674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgI4zgdDV6NmMPo5aAmiFT+6Ssq8rA+mnVDfSWSrmkU=;
        b=mU890H6Bv43ALbYBcZlWJUDdlsBBb5zgCyY2S8h+oPIkN6SaQYZGxp3tNXFELfjOw8
         i9gnW7WJuOm8+4fpZlJXmPodjNyGb586AV0fX/8wLUUGG4XYHHhikgeXRuJutRXyDJoB
         YxgDnfnbHB78+eDjZbx1XJ56lPjF3X7RI79MPLGnzk62IvRnKrK9gGY51fUc4AKscfmV
         HjxaikWKdSwj4jzgq3zFe4SXC6bc9bIgQ/1HYA8kYUvpFxq1GyFp2oPq7fflY9lDFIWU
         EhGLB1oXg0P+uuMCMZ9GP2ElkovlD7GTiG3vvgD5M064NBIQ+vq/Cc+Ii+Cm6Q2O5HP2
         Erow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090874; x=1776695674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgI4zgdDV6NmMPo5aAmiFT+6Ssq8rA+mnVDfSWSrmkU=;
        b=G5Mt9T8ns/FwKxGNPmGXnxFrf45Db65posr6pvisKdOiNFRYydXvOeYRdGzClFKTJv
         FUhxxddz5YcyyyFOnA/GnwtsE4obKPhUYedlNbtCwtVCWqYdP3Ml5HQmny/x+RuWcyvd
         FJbKyP8g47PeI/bZ99VXdVG3n4M1Kx8qgK+MBwl9zyt02Sc1YF8jzV1RlcL/BEMblIPb
         f1AyFJ5wrnkE2UHK/f28GcG1ieY5dAw+cBCdL/LdawBDxdSapyx1E2QG3nO3ficx2ENx
         C0xke6yltrjjLWCCPoGiaYFAbQJndab1lGJMWhkkpvISzJVJrWuTqY3OlZkX6SoT/VIb
         pkxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EDE/KbZ0SrQCg8FeRQczaA5JDxTwvuJkWYwFE807MAK9F/HdzPU9ZHa8iVRawDjoltyJiUCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmenielEAa0MwmS+RBjNlH6Wio3x41dJ6QR0T2EtpwOSosiNa
	pw513WXTfIiNh4PfmZZcz4wzXFVYPWP4IbatMnjLZGbpoNHEcRwPt7cR+TRBhEa+oGXTFLwJI7S
	DRPoqR/70HZJeZwU8r8babk3jtPe+8QgcUdgy0iRX3b9tB20f1sNAflb4cRgxn7CtaA==
X-Gm-Gg: AeBDiesVO4yhB50cBcHkJrSYsat/wDecN2fNxs1iWyfheeu4CjWetOnriCjnjA8mgPm
	tv8PRHgQqzSkXN4VgiwVODEYjmonNBymhonI5ndkIgLyQy+FkaRxa5NkM4gubhyxfOronNdLWyW
	zcEmQNVCDotpp9fI8u/kDifzGENTcf6nMdkyEVRlorhn5cn9I9rZMRlhVsb+WBaHoW7feS8S+YW
	rHYbmH1mfZJDZXsOsJwybA1nrn8WemqvSGLR1Dgh6yPOkJ5gX7HxeDdErmRAD7ovE9H7g0ALyt1
	adgMK7QSItERqJ4Rj+zuYV79M1hUkj8yLhptjUp/zqzStyd13KVjYFp9G6yhBMTuIRaGkm1/lgE
	3Bd8z1PPu3DzoXYJOnEAe4xjYBR64dDKytc1EkDscKlevmI08qVSY5/wr
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr19361064f8f.23.1776090874200;
        Mon, 13 Apr 2026 07:34:34 -0700 (PDT)
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr19361017f8f.23.1776090873609;
        Mon, 13 Apr 2026 07:34:33 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7cf533b7sm4165626f8f.18.2026.04.13.07.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 07:34:33 -0700 (PDT)
Message-ID: <8cba369d-0e63-45cf-9727-d505828afcab@redhat.com>
Date: Mon, 13 Apr 2026 16:34:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260413132247.320961-1-luiz.dentz@gmail.com>
 <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
 <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278101-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0088D3ED5B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 4:11 PM, Luiz Augusto von Dentz wrote:
> On Mon, Apr 13, 2026 at 9:41 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
>>> The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:
>>>
>>>   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13
>>>
>>> for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f:
>>>
>>>   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-13 09:19:42 -0400)
>>>
>>> ----------------------------------------------------------------
>>> bluetooth-next pull request for net-next:
>>
>> Net-next is closed for the merge window. I guess Jakub could still
>> consider merging this, but unless you want it very, very badly, I hope
>> it can just be postponed, as the PW queue is already long.
> 
> This update includes quite a few new hardware supports. This is a
> resend because the last one was dropped due to an invalid 'Fixes' tag.
> 
>  Btw, I don't know why the entire PR needs to be dropped if only a few
> items have invalid tags? Can't we just dropped those?

That's the problem with PR: AFAIK we can just pull whatever the
submitter published. To do any edit, including dropping patches, we must
not do a git pull, and instead applying the patches individually
(meaning they will get the net maintainer SoB, too, which in turn will
make little sense).

/P


