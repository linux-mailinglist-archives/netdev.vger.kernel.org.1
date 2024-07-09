Return-Path: <netdev+bounces-110181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D5A92B3D3
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A3B1C20B67
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13A154C0F;
	Tue,  9 Jul 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="q0rztVPm"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2985613C687;
	Tue,  9 Jul 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517359; cv=none; b=HjPWxSFiy2yoK3t0ME7I+iqYTdxGCjn+cGz21Ew7Gkd+qo3FD4F2ORotX0np5/9+g7LZuxTZCjo3+PC5zX15mGOoAk4JtsW1URx88LsTpxanESGm8kPIlPGj3IqqeMQZysglHovjUcqtrmZQ8f1rRPvMYhyFdnVJG8jq1Xgusws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517359; c=relaxed/simple;
	bh=7DWs8NlGzB6ngfSoSC5rIQPo0j9eV+sZdzaBHoXrKkY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=AmHYhCK9JfpJMp15YX+jW3agnMLqps/QLotOUuUTDhG1XHTBIgKCiTk6D9l47GMTlHSk2N/mF22lJGL9Mf6dVKQk1oBAwYKSozqrZp2lI6n0uG+7+b0vPAqtLeJIPujtsnHp0KpxLA0YInOERPdf+z+yFWwsP83KajfrB8Io8/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=q0rztVPm; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:e181:9992:7c46:d034] (unknown [IPv6:2a02:8010:6359:2:e181:9992:7c46:d034])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 1DEAE7DA8A;
	Tue,  9 Jul 2024 10:29:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720517357; bh=7DWs8NlGzB6ngfSoSC5rIQPo0j9eV+sZdzaBHoXrKkY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<9d86ddab-5177-b534-11be-6609065a2ab9@katalix.com>|
	 Date:=20Tue,=209=20Jul=202024=2010:29:16=20+0100|MIME-Version:=201
	 .0|To:=20Paolo=20Abeni=20<pabeni@redhat.com>,=20Hillf=20Danton=20<
	 hdanton@sina.com>|Cc:=20netdev@vger.kernel.org,=20linux-kernel@vge
	 r.kernel.org,=0D=0A=20syzkaller-bugs@googlegroups.com,=20tparkin@k
	 atalix.com,=0D=0A=20syzbot+b471b7c936301a59745b@syzkaller.appspotm
	 ail.com,=0D=0A=20syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail
	 .com|References:=20<20240708115940.892-1-hdanton@sina.com>=0D=0A=2
	 0<a65127e4-544b-27e6-a1e1-e20e5fb4d480@katalix.com>=0D=0A=20<ce597
	 3fe2017177e6f4c1f577fa8309fe7258612.camel@redhat.com>|From:=20Jame
	 s=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20[PATCH=20net
	 -next=20v2]=20l2tp:=20fix=20possible=20UAF=20when=20cleaning=20up=
	 0D=0A=20tunnels|In-Reply-To:=20<ce5973fe2017177e6f4c1f577fa8309fe7
	 258612.camel@redhat.com>;
	b=q0rztVPmBNQ7tseS/E/mEEQyOg8aSo9qWeCgAnkKKbYuJHrRLakQBf2rYEg5H3XrR
	 Dj5jvhcMlo5nCVkT99w/uO7BPfb+v6T+TFeVOrvXKxQnDOLdjNqGbwfpHWy4CupooA
	 oZRDyOsscIoTlhovQGnIlndVJmgMYb+ljmWMOIwFqzXMkncew3VOYe935N89JDvhh/
	 SKdzwRJWHC3a9IOjdOVmgsLeHGTfo7iXveo2mjdUuU52alQR519+1FFMc77iiDUrHc
	 QY/Mf1oZNlxo4erhMX1FKv5l0JkidtRtYPRqaTapBhnCWoiwwMFqxO6geuJ62nZMlW
	 sW2NoRerWBzzQ==
Message-ID: <9d86ddab-5177-b534-11be-6609065a2ab9@katalix.com>
Date: Tue, 9 Jul 2024 10:29:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Paolo Abeni <pabeni@redhat.com>, Hillf Danton <hdanton@sina.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tparkin@katalix.com,
 syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com,
 syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
References: <20240708115940.892-1-hdanton@sina.com>
 <a65127e4-544b-27e6-a1e1-e20e5fb4d480@katalix.com>
 <ce5973fe2017177e6f4c1f577fa8309fe7258612.camel@redhat.com>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next v2] l2tp: fix possible UAF when cleaning up
 tunnels
In-Reply-To: <ce5973fe2017177e6f4c1f577fa8309fe7258612.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 10:03, Paolo Abeni wrote:
[snip]
> AFAICS this patch is safe, as the session refcount can't be 0 at
> l2tp_session_inc_refcount() time and will drop to 0 after
> l2tp_session_dec_refcount() only if no other entity/thread is owning
> any reference to the session.
> 
> @James: the patch has a formal issue, you should avoid any empty line
> in the tag area, specifically between the 'Fixes' and SoB tags.
> 
> I'll exceptionally fix this while applying the patch, but please run
> checkpatch before your next submission.

Thanks Paolo. Will do. I'll be more careful next time.

> Also somewhat related, I think there is still a race condition in
> l2tp_tunnel_get_session():
> 
> 	rcu_read_lock_bh();
>          hlist_for_each_entry_rcu(session, session_list, hlist)
>                  if (session->session_id == session_id) {
>                          l2tp_session_inc_refcount(session);
> 
> I think that at l2tp_session_inc_refcount(), the session refcount could
> be 0 due to a concurrent tunnel cleanup. l2tp_session_inc_refcount()
> should likely be refcount_inc_not_zero() and the caller should check
> the return value.
> 
> In any case the latter is a separate issue.

I'm currently working on another series which will address this along 
with more l2tp cleanup improvements.


