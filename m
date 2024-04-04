Return-Path: <netdev+bounces-84701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00E789810E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 07:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0951C20CE9
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 05:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678AD3DBBC;
	Thu,  4 Apr 2024 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="kZk42A1w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D717991
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209395; cv=none; b=JwxQNZbD3pu47bBsPMaDqkvoovZ4MQO1/Z/R6I1FChrwlLgYCdT5lo8Hi+jnvv6dMGzAvvQfjiCoYax+SPGOuDYqiH7wzWc1eTQUHAkAKs51+4wc7zI80BnYLvgUBb53pf/3jpQTJtmon8z+P4f2MIkG428JDwE8CTvsG90idy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209395; c=relaxed/simple;
	bh=S0PuWJxaX2ucVMnxVzoXt0U7xs1OpRQuy4BrJf8p5qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+kA3GVpm18qTICNFHyhxfQ7I5FNEWfuhBvdczKe2LgBbx0w3G1eKXhA2kvRpzwSO8mXoQjbjAhfhmjLSO5FM2xddjfHumEplZxDqZeWvYg2xq1Rg46p85SVfl6igrPQ0SGhBLSYQLeW25i/DlqrfcS5j6Z+HwXXfsQ+zG8t4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=kZk42A1w; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a450bedffdfso69006166b.3
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 22:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1712209391; x=1712814191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7FHyBbkFqkiMaU45C+JD/nYcu/68KLWR2HD03GIzHQ=;
        b=kZk42A1wATD5DAo2KkqrOIsKRenNyNGUWicJ0FERy9HuCTkroaLFO5VUrnl3+Wrs7C
         Rtqv12WMLrAveMvsN4Ads60mR04oUkbpKKH/eG4h9nBfr80w/nOecTQvkipArUZEqaMg
         q2ldIqBXV9DfU4xtR0HfJ2JTKtI3azMuFAUUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712209391; x=1712814191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7FHyBbkFqkiMaU45C+JD/nYcu/68KLWR2HD03GIzHQ=;
        b=YNBV9qNL64VoEtg+OvI+Ck6a1lykR7YpCFQTHTf0HdvUevs0cjtk/mXPsE1YByGrYM
         p2pTb93zVpSNreA5rXhqJbVNIC/x3sHA51Tg12OUyxWbTXcXw5/Aw5ZFxLu8TxypLADR
         gbJTFnI/jh/jxzE74x/hNwXCsb0HaaUdi66gFczmVw+gLI0cSTODGBkhAKDU63MNmi7G
         46XRBUm8ySxsoecxsm3dPfw3lbfSSl18KVLVFlrqWRYzhMsXPdss9Ru2dGEFq8R13jiX
         g3i685Ul5ypow7obWiwi5W7T5OKKWoD38AucuQVAgg4564tbU5L5Pn0EqVRJf7Xp4sTG
         dchg==
X-Forwarded-Encrypted: i=1; AJvYcCX1SYXgps/yes37EqGKk5lksJLxx9uUXg057cHGpLVeKoeX3+66uiAfuTtHkKQM9clX6BXbGG1sEvC7/bjjv9EMCzu7Dk4w
X-Gm-Message-State: AOJu0YwWVvU6KK1nboj0Tomb9MuaA1r+rt2w23E87ZOnZVp1jHP9WR7t
	l1Jg5IQcH93OQhUIaqi2Xy5MvSDE7g2aAlf0wtXQZBy+s7zCEGKwl9bIxrvDZdHUBvvjcygmtsD
	UywFfutL4sy1q2tmH8/zlmqTWIPfA+82k5pPL
X-Google-Smtp-Source: AGHT+IHjq7FXeivyM9YWZJUdQmoCkVtYBb4kAZduf6LFCae424Btt0hf0wZHiow6M+tVESnVQMIDwVZ2qGylVqIGiSE=
X-Received: by 2002:a17:906:4c56:b0:a4e:1b02:81d6 with SMTP id
 d22-20020a1709064c5600b00a4e1b0281d6mr748578ejw.10.1712209391417; Wed, 03 Apr
 2024 22:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
 <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
 <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
 <CACGkMEt4MbyDgdqDGUqQ+0gV-1kmp6CWASDgwMpZnRU8dfPd2Q@mail.gmail.com>
 <CA+9S74hUt_aZCrgN3Yx9Y2OZtwHNan7gmbBa1TzBafW6=YLULQ@mail.gmail.com>
 <CA+9S74ia-vUag2QMo6zFL7r+wZyOZVmcpe317RdMbK-rpomn+Q@mail.gmail.com>
 <CA+9S74hs_1Ft9iyXOPU_vF_EFKuoG8LjDpSna0QSPMFnMywd_g@mail.gmail.com> <CACGkMEvHiAN7X_QBgihWX6zzEUOxhrV2Nqg1arw1sfYy2A5K0g@mail.gmail.com>
In-Reply-To: <CACGkMEvHiAN7X_QBgihWX6zzEUOxhrV2Nqg1arw1sfYy2A5K0g@mail.gmail.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Thu, 4 Apr 2024 07:42:45 +0200
Message-ID: <CAK8fFZ6P6e+6V6NUkc-H5SdkXqgHdZ-GEMEPp4hKZSJVaGbBYQ@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Jason Wang <jasowang@redhat.com>
Cc: Igor Raits <igor@gooddata.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 26. 3. 2024 v 5:46 odes=C3=ADlatel Jason Wang <jasowang@redhat.com>=
 napsal:
>
> On Mon, Mar 25, 2024 at 4:44=E2=80=AFPM Igor Raits <igor@gooddata.com> wr=
ote:
> >
> > Hello,
> >
> > On Fri, Mar 22, 2024 at 12:19=E2=80=AFPM Igor Raits <igor@gooddata.com>=
 wrote:
> > >
> > > Hi Jason,
> > >
> > > On Fri, Mar 22, 2024 at 9:39=E2=80=AFAM Igor Raits <igor@gooddata.com=
> wrote:
> > > >
> > > > Hi Jason,
> > > >
> > > > On Fri, Mar 22, 2024 at 6:31=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Mar 21, 2024 at 5:44=E2=80=AFPM Igor Raits <igor@gooddata=
.com> wrote:
> > > > > >
> > > > > > Hello Jason & others,
> > > > > >
> > > > > > On Wed, Mar 20, 2024 at 10:33=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 19, 2024 at 9:15=E2=80=AFPM Igor Raits <igor@good=
data.com> wrote:
> > > > > > > >
> > > > > > > > Hello Stefan,
> > > > > > > >
> > > > > > > > On Tue, Mar 19, 2024 at 2:12=E2=80=AFPM Stefan Hajnoczi <st=
efanha@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Mar 19, 2024 at 10:00:08AM +0100, Igor Raits wrot=
e:
> > > > > > > > > > Hello,
> > > > > > > > > >
> > > > > > > > > > We have started to observe kernel crashes on 6.7.y kern=
els (atm we
> > > > > > > > > > have hit the issue 5 times on 6.7.5 and 6.7.10). On 6.6=
.9 where we
> > > > > > > > > > have nodes of cluster it looks stable. Please see stack=
trace below. If
> > > > > > > > > > you need more information please let me know.
> > > > > > > > > >
> > > > > > > > > > We do not have a consistent reproducer but when we put =
some bigger
> > > > > > > > > > network load on a VM, the hypervisor's kernel crashes.
> > > > > > > > > >
> > > > > > > > > > Help is much appreciated! We are happy to test any patc=
hes.
> > > > > > > > >
> > > > > > > > > CCing Michael Tsirkin and Jason Wang for vhost_net.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > [62254.167584] stack segment: 0000 [#1] PREEMPT SMP NOP=
TI
> > > > > > > > > > [62254.173450] CPU: 63 PID: 11939 Comm: vhost-11890 Tai=
nted: G
> > > > > > > > > >    E      6.7.10-1.gdc.el9.x86_64 #1
> > > > > > > > >
> > > > > > > > > Are there any patches in this kernel?
> > > > > > > >
> > > > > > > > Only one, unrelated to this part. Removal of pr_err("EEVDF =
scheduling
> > > > > > > > fail, picking leftmost\n"); line (reported somewhere few mo=
nths ago
> > > > > > > > and it was suggested workaround until proper solution comes=
).
> > > > > > >
> > > > > > > Btw, a bisection would help as well.
> > > > > >
> > > > > > In the end it seems like we don't really have "stable" setup, s=
o
> > > > > > bisection looks to be useless but we did find few things meanti=
me:
> > > > > >
> > > > > > 1. On 6.6.9 it crashes either with unexpected GSO type or userc=
opy:
> > > > > > Kernel memory exposure attempt detected from SLUB object
> > > > > > 'skbuff_head_cache'
> > > > >
> > > > > Do you have a full calltrace for this?
> > > >
> > > > I have shared it in one of the messages in this thread.
> > > > https://marc.info/?l=3Dlinux-virtualization&m=3D171085443512001&w=
=3D2
> > > >
> > > > > > 2. On 6.7.5, 6.7.10 and 6.8.1 it crashes with RIP:
> > > > > > 0010:skb_release_data+0xb8/0x1e0
> > > > >
> > > > > And for this?
> > > >
> > > > https://marc.info/?l=3Dlinux-netdev&m=3D171083870801761&w=3D2
> > > >
> > > > > > 3. It does NOT crash on 6.8.1 when VM does not have multi-queue=
 setup
> > > > > >
> > > > > > Looks like the multi-queue setup (we have 2 interfaces =C3=97 3=
 virtio
> > > > > > queues for each) is causing problems as if we set only one queu=
e for
> > > > > > each interface the issue is gone.
> > > > > > Maybe there is some race condition in __pfx_vhost_task_fn+0x10/=
0x10 or
> > > > > > somewhere around?
> > > > >
> > > > > I can't tell now, but it seems not because if we have 3 queue pai=
rs we
> > > > > will have 3 vhost threads.
> > > > >
> > > > > > We have noticed that there are 3 of such functions
> > > > > > in the stacktrace that gave us hints about what we could try=E2=
=80=A6
> > > > >
> > > > > Let's try to enable SLUB_DEBUG and KASAN to see if we can get
> > > > > something interesting.
> > > >
> > > > We were able to reproduce it even with 1 vhost queue... And now we
> > > > have slub_debug + kasan so I hopefully have more useful data for yo=
u
> > > > now.
> > > > I have attached it for better readability.
> > >
> > > Looks like we have found a "stable" kernel and that is 6.1.32. The
> > > 6.3.y is broken and we are testing 6.2.y now.
> > > My guess it would be related to virtio/vsock: replace virtio_vsock_pk=
t
> > > with sk_buff that was done around that time but we are going to test,
> > > bisect and let you know more.
> >
> > So we have been trying to bisect it but it is basically impossible for
> > us to do so as the ICE driver was quite broken for most of the release
> > cycle so we have no networking on 99% of the builds and we can't test
> > such a setup.
> > More specifically, the bug was introduced between 6.2 and 6.3 but we
> > could not get much further. The last good commit we were able to test
> > was f18f9845f2f10d3d1fc63e4ad16ee52d2d9292fa and then after 20 commits
> > where we had no networking we gave up.
> >
> > If you have some suspicious commit(s) we could revert - happy to test.
>
> Here is the is for the change since f18f9845f2f10d3d1fc63e4ad16ee52d2d929=
2fa:
>
> cbfbfe3aee71 tun: prevent negative ifindex
> b2f8323364ab tun: add __exit annotations to module exit func tun_cleanup(=
)
> 6231e47b6fad tun: avoid high-order page allocation for packet header
> 4d016ae42efb Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/n=
et
> 59eeb2329405 drivers: net: prevent tun_build_skb() to exceed the
> packet size limit
> 35b1b1fd9638 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/n=
et
> ce7c7fef1473 net: tun: change tun_alloc_skb() to allow bigger paged alloc=
ations
> 9bc3047374d5 net: tun_chr_open(): set sk_uid from current_fsuid()
> 82b2bc279467 tun: Fix memory leak for detached NAPI queue.
> 6e98b09da931 Merge tag 'net-next-6.4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> de4f5fed3f23 iov_iter: add iter_iovec() helper
> 438b406055cd tun: flag the device as supporting FMODE_NOWAIT
> de4287336794 Daniel Borkmann says:
> a096ccca6e50 tun: tun_chr_open(): correctly initialize socket uid
> 66c0e13ad236 drivers: net: turn on XDP features
>
> The commit that touches the datapath are:
>
> 6231e47b6fad tun: avoid high-order page allocation for packet header
> 59eeb2329405 drivers: net: prevent tun_build_skb() to exceed the
> packet size limit
> ce7c7fef1473 net: tun: change tun_alloc_skb() to allow bigger paged alloc=
ations
> 82b2bc279467 tun: Fix memory leak for detached NAPI queue.
> de4f5fed3f23 iov_iter: add iter_iovec() helper
>

We do not have much progress, I reverted few commits from the list and
they are not causing the issue, look for (no):
--------------------------
(no) cbfbfe3aee71 tun: prevent negative ifindex
b2f8323364ab tun: add __exit annotations to module exit func tun_cleanup()
(no) 6231e47b6fad tun: avoid high-order page allocation for packet header
4d016ae42efb Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
(no) 59eeb2329405 drivers: net: prevent tun_build_skb() to exceed the
packet size limit
35b1b1fd9638 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
(no) ce7c7fef1473 net: tun: change tun_alloc_skb() to allow bigger
paged allocations
9bc3047374d5 net: tun_chr_open(): set sk_uid from current_fsuid()
(no) 82b2bc279467 tun: Fix memory leak for detached NAPI queue.
6e98b09da931 Merge tag 'net-next-6.4' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
de4f5fed3f23 iov_iter: add iter_iovec() helper
438b406055cd tun: flag the device as supporting FMODE_NOWAIT
de4287336794 Daniel Borkmann says:
a096ccca6e50 tun: tun_chr_open(): correctly initialize socket uid
66c0e13ad236 drivers: net: turn on XDP features

The commit that touches the datapath are:

(no) 6231e47b6fad tun: avoid high-order page allocation for packet header
(no) 59eeb2329405 drivers: net: prevent tun_build_skb() to exceed the
packet size limit
(no) ce7c7fef1473 net: tun: change tun_alloc_skb() to allow bigger
paged allocations
(no) 82b2bc279467 tun: Fix memory leak for detached NAPI queue.
de4f5fed3f23 iov_iter: add iter_iovec() helper
--------------------------


> I assume you didn't use NAPI mode, so 82b2bc279467 tun: Fix memory
> leak for detached NAPI queue doesn't make sense for us.
>
> The rest might be the bad commit if it is caused by a change of tun itsel=
f.
>
> btw I vaguely remember KASAN will report who did the allocation and
> who did the free. But it seems not in your KASAN log.
>
> Thanks
>
> >
> > Thanks again.
> >
>

