Return-Path: <netdev+bounces-304922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pxgQJCeBS2o1SgEAu9opvQ
	(envelope-from <netdev+bounces-304922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:19:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C61770F130
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:19:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YeEEcneT;
	dkim=pass header.d=redhat.com header.s=google header.b=Epe6GwoU;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304922-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304922-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E55376B75D
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B142CB12;
	Mon,  6 Jul 2026 09:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21614189B9
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:24:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329876; cv=pass; b=DMl6fudsvoUsMVM8l4GCNhInS/IOpvWT0pGqNVTs8U9teGVSky35zCYjO1HqXoTtlvItxbilDccdnjbzINTapWo2SaVPZEmyOVNt1aE8FRDNLZdyWi+EFoeaAXTd05aDj9GF74I4k+aUDirkEQR72gH4Rmn54mONgiC4m4oknw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329876; c=relaxed/simple;
	bh=bjF0BZXpIAjW/Uu1wH2j5e53ZR+HCAlpR+B3xXBi2vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tL0PkbK8twp8y8AFrwqcJSbfGc9xc3okwisG0A/pWKn9YaDcYnEIcMlXaQ3PsygR1TWG3xEZJnrCyqbUXT3qXNi6J6McWgXMnrWGKobEzgMqVc0oJ1jT93dyzPIMbLQi+sX0ZpbKyEpzHnuJQmQokfFDAwT8jsHnng9hEymGfT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeEEcneT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Epe6GwoU; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
	b=YeEEcneTDuoA8HclJbWODd7y85a135/YMx/e5hTctWgAhg14S4TFnDw6XR5QXzixyuoeLV
	9bUP7d0wSG64TrZQ0u2RlD9JaC/JPHf7TweDQSggjrSTw72PMoMnVlstY2FAexVSaN2GP5
	IzAEYrMOqnvo4+GEwKhwjxLUaJPBWMs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-P5aFtPOkOfCSjazM0QgXPg-1; Mon, 06 Jul 2026 05:24:26 -0400
X-MC-Unique: P5aFtPOkOfCSjazM0QgXPg-1
X-Mimecast-MFC-AGG-ID: P5aFtPOkOfCSjazM0QgXPg_1783329866
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ca5d2474c7so66498885ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783329866; cv=none;
        d=google.com; s=arc-20260327;
        b=oKvwTAbAa4CvaB+HiZdwPfuwcCblDJ1z9hrjiT57A+FegwHNUhZRuI73hqSI+SpnQp
         G76nDy3m2cMNGY68/Y/wx9jT3zdemU5E0cF1LKJ35bd9g2kLYfpjw5+fSx/SgqPCpGc/
         VMpe+mALI43f4e5NJAvJIHCuWE/Tenyhn2rxKQ0OQ6jfXe9hLKEn+GLughTP0B93mtKJ
         Tb+LU2zMqu/9tQbzUhgUiiNCoyAqhjWB7kU/u1ZFViBVgRpaWhky1X2ag9AAOS8FHLN7
         9S6fxB8+U/zvEpA2f/JX8tnSOVGWpBilsEariEbyDYPZsrA5uvMgWkPz0hlGIhatDlm3
         2/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
        fh=qQ6KMyahUZGAOmvTIWXJa0l5M5RGTLcq8cqnzLxJTtI=;
        b=hrxllF1NSwao96mUKy4xU0RNzOpvTaaWtiZOHjHrdtE1xhjYPTCwWPVNC/0SKAA1y6
         K3MMpx+DhxuJU5BjZ3qfajo/680nZ8wMevSDJlAweAx2Rre2z+uW04P9nA2oRyxmV5n/
         wn9I88LMJ57P98YdIqbTA4XA6E0dK2ufjBfCMDqYd2+woqFs0xEbfoNeUWcHgJZJo17c
         4pjsDuLbHeeV3ohTKRr+11eOiE3gkkm12iskR9tKxa2nX81/BFjmWARf3NuT255wqrjz
         aEN29mmjaFRIAT81LnTG2uDHU8Agwv2gf1OBjgDHL85dGWckn0IevZu7kj7EU4klI2Aq
         sYzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783329866; x=1783934666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
        b=Epe6GwoUOBnbONT7YcIhfs12CZJy8Y3wtxJCq8yIbetb8cOmCSythtfH/RGGVGE8fA
         nilhsdeR5w+1CLS4XltqtEb1NeZJPcBdRw9U6kyhUTjitvCugK4KIX/K6xjcNDRP7I29
         k4kU51D3hjgMm0Q6kO05dI+TBwh+HH7jCDbY9KbyUU5eioATVQV8b0q0tuUUNuugm/Ka
         QT+YIPtDmz3D7hKlv9dUh07+nJfdOqPmyWx1YEqA4gGjccabUtXkuobH9IClTKz4clV2
         klQaiZXsuJgqzgBdddi4NKfOPb6+spsmnkvnc4lY2hIIoFP+rRXIK9sEKimnAcZP9MjK
         IytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783329866; x=1783934666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yn0KzcK21NnwKHwgbzUJWvl8KnNJxuskf2Di9W9STHQ=;
        b=WhaVaGed3lX4lZLMzWjusP2i51mer8Nac8qU5TkRceWmzUerLPL15qKo4gxv7+2U5k
         g+a3T2ETJjqdPbHufIjOHK4rf9DTSwJZSPOCYoSVo/8O/FnrmjBE6ziZCb8JNhAjI0uE
         3lNvUSJFwWLtl51yoDa0tlJFyFOjb61ehcXKDbtnCYRz9VGlVZ6pxIHKOz9ei5YplKcE
         zmiZ7NPXw9NkbGIrQE1erRX4Dl+GWeHKSGbArqM4F5OrCtAe0UkiXFZz6NcT6oonhODG
         feipW+ov2Wt3KlpC5802AfKilgi2ZZK71tGr6goUuY+XW7OVOAt5q73bfXHUFt1IIfRk
         n24A==
X-Forwarded-Encrypted: i=1; AHgh+RqF6uMdcS3pIl/Rw4ryQnNkyvNbD3Z6omY5bExYh4Z2Ct7B6SJj2eCznFmiEY2/oS9lw1x6ldU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9mA5l5AzC3ftO5vyETTr3T2PjPCvE5RnKdG9KeOiJqRR8kIZ/
	n5m2DJ7rtBRdnW2tYaDXPKQfGPw85ShQHi/gQp2NydMfsGv44EjpRtHweBByYI2dxxslc9hjM8T
	axZg2lG4znPKc0pPJXdzju5c3oSJbkIFmAYMK2rZJOHa1Sqp6wYeXxVnQMDQPRfsf/tq0O8kaFF
	s3WMh8CUimzwzC9lLg/51KQVktVlmkhJXU
X-Gm-Gg: AfdE7clr5jy/ER8Zjkf2LOqLDYRM0DACk0pGuIrMTaKQUC0jwnxZ9HqA2NL0QhwP+C+
	4FW5163GyfZmQHbQj3FaloNp/8r7uZZMW+rwisxsc+L3yxxeXM1ZoZ7cKaN8tGCN48y5yQ/yeVU
	U4WQn3ThzO7JeTBw0a7nmOywzWd8qc0q7Q36C844deoq1LPIwJTqphDNk/A2erZeLp
X-Received: by 2002:a17:902:d4c8:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2cbb7511a14mr91874265ad.18.1783329865769;
        Mon, 06 Jul 2026 02:24:25 -0700 (PDT)
X-Received: by 2002:a17:902:d4c8:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2cbb7511a14mr91874005ad.18.1783329865282; Mon, 06 Jul 2026
 02:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com> <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
In-Reply-To: <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 6 Jul 2026 11:24:14 +0200
X-Gm-Features: AVVi8CdUM8gLEd1esj3vEBaF7KM2cPEVYji_lbVGfB2Yvj6K1tMDr3_xJ0gDydo
Message-ID: <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com>
Subject: Re: [syzbot] Monthly virt report (Jun 2026)
To: mawupeng <mawupeng1@huawei.com>
Cc: syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, stefanha@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-304922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mawupeng1@huawei.com,m:syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:virtualization@lists.linux.dev,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:stefanha@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:netdev@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,listbf7b8eeeb8dda31d6de1];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,syzkaller.appspot.com:url,vger.kernel.org:from_smtp,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C61770F130

On Thu, 2 Jul 2026 at 04:55, mawupeng <mawupeng1@huawei.com> wrote:
> On =E5=91=A8=E5=9B=9B 2026-6-25 04:32, syzbot wrote:
> > Hello virt maintainers/developers,
> >
> > This is a 31-day syzbot report for the virt subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/virt
> >
> > During the period, 0 new issues were detected and 0 were fixed.
> > In total, 5 issues are still open and 61 have already been fixed.
> > There are also 2 low-priority issues.
> >
> > Some of the still happening issues:
> >
> > Ref Crashes Repro Title
> > <1> 24      No    WARNING: refcount bug in call_timer_fn (4)
> >                   https://syzkaller.appspot.com/bug?extid=3D07dcf509f4c=
013e25dc5
> > <2> 3       Yes   memory leak in __vsock_create (2)
> >                   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8=
708082678
>
> Hi,
>
> This is regarding the still-open "memory leak in __vsock_create (2)"
> bug (#2 in the monthly virt report, extid 1b2c9c4a0f8708082678):
>   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678
>
> I spent some time analyzing the root cause and the previous fix
> attempt; below is a summary and a direction that tested out.

[...]

>
> I'm not subscribed to follow the list at full volume; happy to send a
> formal patch (with the af_vsock.h / pending_work changes folded in)
> if the direction looks right to the maintainers.

Yes, please, a formal patch with a great commit message is much better
than a long text to read IMO.

Thanks,
Stefano


