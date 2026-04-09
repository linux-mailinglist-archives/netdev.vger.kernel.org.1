Return-Path: <netdev+bounces-276942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJZdMfGI12mwPQgAu9opvQ
	(envelope-from <netdev+bounces-276942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:09:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F973C9858
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 824C33044A4B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED03BF676;
	Thu,  9 Apr 2026 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTO5OSRr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyaC02+H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197826A1AF
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775732868; cv=pass; b=ZqQklsxipcbAGiiUmnWJCOIpICHQMJKUEBUzFs5iouCkaDGaN8g5fpd7pDw4MQhFVNzIGqE4tXk78NaSvj2Ap6ijVvpO2jd53bkj8b+hEylhSdEQ24zJhJF7Zs8RYDtw/6ZCYcaPfs1suQ+zcRDPPuAkspEC8yzqeHGFEKp0Bno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775732868; c=relaxed/simple;
	bh=45tpHNlHtyjRQ43QkrkZhRbP7f6fAu0SZO49IqxWjzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLzmsjaGaGBQGbmyPRkH76GVxlZD8DX2xzZbqWhIlEiqrhk1y7zRqm07Ip0y5P2bw8gBuehbXeSU2MzA/hk2jMhb8dLGShGZUgtlpwa5NWhAnGFEMkDuuh0GOGl7mD64hsb5t6CF3mAbn99HDbmycgnYf/QL6d0KUWJkZCA0K10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTO5OSRr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cyaC02+H; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775732866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45tpHNlHtyjRQ43QkrkZhRbP7f6fAu0SZO49IqxWjzM=;
	b=gTO5OSRrZclHa3rHNmTTX+s/IiWwv5IOPQFBOEr/yyX7KLgXdxwdrHBPKTl7H9U5GFWzfP
	ptbkAgWC/1f4O3XNX+lfWaj6q7sFaIuZ5ypwqfjZCKs4yosS0kB4uOwebXerJsXgHUpbJr
	wMiHf5QvhAZiohJvyceqJB5bzx/nn64=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-lmmUeH-IPlqfw9eDVOMqKA-1; Thu, 09 Apr 2026 07:07:45 -0400
X-MC-Unique: lmmUeH-IPlqfw9eDVOMqKA-1
X-Mimecast-MFC-AGG-ID: lmmUeH-IPlqfw9eDVOMqKA_1775732864
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c741f038f7cso683904a12.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 04:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775732864; cv=none;
        d=google.com; s=arc-20240605;
        b=lZJdqlefq7FR3ExqQ3WZUoRaZl374G6/TrV95SrOEJ0lV+OpRF9mjp6UbK3X2iO0AY
         SqwzVTnnKtGeNoNnHQQ2YVlpTDzlGgYD0Ezw/89iQF6K1bai6Tn7pPMV5v/B/XxR5L7W
         RP3MoXGJGKVi8d4LJNeHb0vWy+sLMR0cxMr/CbQIsviFa0EqXG9Gn6BOCmymjjimeyo8
         kSF3UIni+K52Lxz3BICJnve5fSw3F1jGMRDwHlsBH9Uv/JiO0CLSbk5RpMbLjTp8iSFv
         w6U3T7wfZiMIQC+o2/h0CCvIWKCrOKa/Yzwc00GwmVo1H+FvLWEK8I/t8DnzXB2U1zkB
         gNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=45tpHNlHtyjRQ43QkrkZhRbP7f6fAu0SZO49IqxWjzM=;
        fh=KvT5wlfhFraLWwtbZX4yw3CgGzKo+zLmS+r8P3UPBOM=;
        b=MXux5snAyI7g2FR/CDNKeSE6TFo0DaP2lcbKuoFzRZC55gOu66S74IGMFTtuv088jp
         8F3GsvMiSJ2kvyZDEqWz5P86p+ECXeFDkUpBepGpYcYis0DXCt6ax8L2GQ+agsDMUHND
         gAaJUvYzlvDlrmJ62CTWuJ8AYEtIOXSXw043u+V0c+weNAQ9pc3d5Wa+VlI3WrOlGHiV
         xrCG7jHYlqmcGdxFD5B7En0yVSbNicY2QClsS95T8KJMHOpLQZnXC1Le5iIfHgehwHpP
         UdUUU8/lizwFfjC4QJp9wlnXrbR+WeOcpGGBoBUh0nAHJ+Wm+3zalX2CBj8TOj6knLP9
         THyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775732864; x=1776337664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45tpHNlHtyjRQ43QkrkZhRbP7f6fAu0SZO49IqxWjzM=;
        b=cyaC02+HLlIsq/jhfkaR6lQQ2X6YEKrj9F7Sk+cGY/ou19EMZC/B+YupnV5VCupdO6
         sFqjl8L3dEpnMY25tYGGZwI+HTGqoTuAs5YXjPSRfp6UXrfCx9w/DRrDFdJtS6a2BRQZ
         TpmAghQ4pHkWD4JGV6tjeFhRp7Q3w2+A5AvK1pEVag3XuqO4IT8ynE0/5NBOLV8+ZYpm
         gnQ82lK9KifIQvY2ZFc9NVhPSedqdJCvGZg++WqC4c/m49u6Eu9SyW06mo4k5k6itQNK
         2sCjgBPAAPMwP8kqNw9SmFnKcwBSgSXMqxYYyhuXgCAr48UlIvDyTToLsKltPdawcRgq
         TERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775732864; x=1776337664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45tpHNlHtyjRQ43QkrkZhRbP7f6fAu0SZO49IqxWjzM=;
        b=iazSXtXdu/6VUvSshyQKvRT9gF2wrEBGkvJITBvXWIImQ1DSw5FgSFwHhvv63R6lQt
         FyyhqW4hI1yyf45J2olbEUU8HgGk8jV7+dujxC6BoswoJQ3alCiLoB+MwQFWmjgX95sK
         s74zJufXo67JYQsynzahCW1T0nqemdb4y7lEju8weigEh+wvpuCiBV4xgTxco4n0orbU
         FrL+npX6YXLYpGVe8xjRLJnu6t2XLFRoeNzw1Fgn06SA2UBo8OEgAuxxhp3dGV53cnbA
         iyfHKLTFTrzjD6vE+dwE5cfwOJRTjJNX64l33bo2/pJcnFJTvHBlbbzBQ7wkLkJFBxSx
         1yaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOKwFnIJVdjwMgbsZi/mpco1fUSFD7tntsx4m4YPdCkDu1y4UqG0XwSGH5XYO/+1i/HZdM9hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxojCO9eH37W/E2G3Zk64uNoWPBhbdbvbp19ZboEuZDlGAXoOVV
	y/cDoRHHrt81eTKVCCOWdFhFr5imtDYjQw/FGrmzIOeWtwA7ys1WvslUJDpMlHpykCCVxC8NuJ+
	SP5Ex/WVZYAiw8IAMITOnxi3Yh2rPcfmG3Xe1VMkdycXRK6AOVqdHjrMQy5AcuvbmDizbEo1qUo
	XdTprRpwP6O+k6Opvp06ObZtGU3mVhDXBJ
X-Gm-Gg: AeBDievyih2CpLphz54xn3Tlrq/vy1K8hKVgqbYrK2B/c444gfXaurXdTqgbR53VqNn
	tS+knZVHpwPB69oguVvmOtrXac3ZbLtejok+irLC7m3MhpV7a59F+1wYMl9hkmvTYeBr6Y2Cp3j
	jc+k9RN89cjngMEHuP9Kx3D7YhQnH5kFsUKRsfS8UFZttJnpeFyE3K6xuo4Kp1ZmG5GQ+DxPVgo
	GGzYw==
X-Received: by 2002:a05:6a20:9155:b0:398:65b7:bbdc with SMTP id adf61e73a8af0-39f2f00e450mr25614327637.42.1775732864162;
        Thu, 09 Apr 2026 04:07:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:9155:b0:398:65b7:bbdc with SMTP id
 adf61e73a8af0-39f2f00e450mr25614297637.42.1775732863637; Thu, 09 Apr 2026
 04:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADaZ31BntFddQpK8nnLtGccyKA-kw-usOHZwEscA70+dgB2WSw@mail.gmail.com>
In-Reply-To: <CADaZ31BntFddQpK8nnLtGccyKA-kw-usOHZwEscA70+dgB2WSw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 9 Apr 2026 13:07:32 +0200
X-Gm-Features: AQROBzAksmmNJs8ICf_aTgP4rfKywbkgfgM9s1v8BfNkPCMeAIYWJKkr6fBxsKg
Message-ID: <CAGxU2F6Hdq46+hdMdT99JkqsNxwKNYCypHx+x0c18LteP88a3Q@mail.gmail.com>
Subject: Re: possible deadlock in virtio_transport_release (vsock_register_mutex
 vs sk_lock)
To: weibo Zhang <weibozhang2050@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276942-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39F973C9858
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 at 11:06, weibo Zhang <weibozhang2050@gmail.com> wrote:
>
> Hi,
>
> I am reporting a possible circular locking dependency (AB-BA deadlock) in=
 the
>
> vsock subsystem between vsock_register_mutex and sk_lock-AF_VSOCK, found =
by
>
> syzkaller-based kernel fuzzing on Linux 6.12.47.
>
> The deadlock is detected by lockdep and involves two lock ordering paths:
>
> Path #1 (bind path): sk_lock =E2=86=92 vsock_register_mutex
>
> vsock_bind() =E2=86=92 lock_sock(sk) =E2=86=92 __vsock_bind() =E2=86=92 v=
sock_find_cid()
>
> =E2=86=92 vsock_registered_transport_cid() =E2=86=92 mutex_lock(&vsock_re=
gister_mutex)
>
> Path #2 (connect + transport reassignment): vsock_register_mutex =E2=86=
=92 sk_lock
>
> vsock_connect() =E2=86=92 vsock_assign_transport()
>
> =E2=86=92 mutex_lock(&vsock_register_mutex) [line 469, af_vsock.c]
>
> =E2=86=92 old transport->release(vsk) [line 502, af_vsock.c]
>
> =E2=86=92 virtio_transport_release()
>
> =E2=86=92 virtio_transport_close()
>
> =E2=86=92 virtio_transport_wait_close()
>
> =E2=86=92 lock_sock(sk) [line 1207, virtio_transport_common.c]
>
> The second path is triggered when a socket that already has a transport
>
> assigned (e.g., loopback from a previous CID_LOCAL connect) attempts to
>
> connect to a different CID (e.g., CID_HOST), causing vsock_assign_transpo=
rt()
>
> to release the old transport while holding vsock_register_mutex.
>
>
> A possible fix would be to drop vsock_register_mutex before calling
>
> transport->release() in vsock_assign_transport(), or to avoid calling

Which is exactly what we did with
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df7c877e7535260cc7a21484c994e8ce7e8cb6780

This was released with v6.18 and backported on stable branches.

>
> lock_sock() from within the transport release path when called from
>
> vsock_assign_transport().
>
> This can be reproduced on:
>
> HEAD commit: Linux 6.12.47

v6.12.56 should contain the backport of that patch, can you test it
(or a newer version)?

Thanks,
Stefano


