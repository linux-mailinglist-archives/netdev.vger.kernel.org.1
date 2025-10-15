Return-Path: <netdev+bounces-229448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630DBDC622
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5885D3C6483
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2052BD5A7;
	Wed, 15 Oct 2025 03:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BA1umYv2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135BE1A23B9
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 03:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500508; cv=none; b=bxaWc2+7bBSzQHyhiLrkwXnDwGTduWdNwCPQ56XtbtERw5PvVPbZQZF5tB2xzDJyGJqc0O+ER0iPKHrYCHZdyoSSvg/Zlyh2sHsydQE/ICIGopwSj/xDTOa2b9MSS8sMgIFtVdwOHaHlQkgmL5ElHTNBWOmZgoKN51/+8JDycOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500508; c=relaxed/simple;
	bh=uvL7CSwraTYYkSkcNhtPV3G4xg+1Yrr0ekXayq5QaBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEjNzFZu4+59xHtZF2BZKPBP4EYoxWIX4fIO0tD0NqOKslEaGMyD4bults81MrG347OUphxKkANzrp9tRYCNkPUyyMRtmFRMBI0J+G3CM9QEjUxNzYU4X/W7b1DxGXISjTVz8sgo0a12Y/YKDrwNqCbi+lfg9YCui/HsMZkP9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BA1umYv2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2897522a1dfso56641445ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760500505; x=1761105305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViOgeRqkD1TxsXegnjM78cSYaEgamdlTqYkgxO4+VFY=;
        b=BA1umYv2YheOfYw/cijXEsdcCf1znHZr+H+WUrOkZPKHl9WflPS5mgbbUELYngO9vf
         z0EOMpMcfexK+QI17iecu7vGJnqah9ly/YvxHv/lI4a6LcBkFrT5mlLSWKjLLoNLhm1v
         uachcHHkOhoj7Y/8y5ZNQbeg8r39hFL3iiChnEx1RKiuReVd/h7gfBkdraujDmT8ei5h
         7ebiT5A2M4gW5T7B+2Y7yIdIaxi6595jz4Dl4JXNTV5QCdDDkYJfXaylXcPOw9EZbuTw
         iVVA//XU/4NGlyuUDX7ZT2gjOkjPYXkqRlmsAGvGnaX8ZdMzZ+78bVs1Oxe7v0IzXXaM
         EVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760500505; x=1761105305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViOgeRqkD1TxsXegnjM78cSYaEgamdlTqYkgxO4+VFY=;
        b=SekV3LN2KLLGRsukf9hgHX+cJRA2TPLtoRgzR0qX8JuTV+AEZw+zN9gKxPWTwJ9nFt
         u0Z9pKzHgtGjvraDXzQI/yPk0bSO2miHq/1yRn9fGqA3Qv0C/Kwusgxa7tAvv+UCh6EA
         tGfDVsqxATeXNS4RTIm3F7d3Zd7096Bv1x7J14Benm//7If5SaWXsJS+wVrpe7nZgLco
         rr9oDtzo0ibMdjYCzSZaTuff79ofB1uwX3Dqje0q4FUh6k8qke+2W7xBtOVYjbu5VjxF
         Fnb4J9zHXR3EHRW1MjW0/EyvKTW+Ur6Fha12dY1do9MJ0qXhHfCcLMSTBoj7Z/sxlLrG
         X40w==
X-Forwarded-Encrypted: i=1; AJvYcCU0YjJqOsRu7W1q+JhpqtUGeP9O4pbfWnX+Yw0zdILXmEGb0JT5PIJgPtaIDvKxKzfsmzryQkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqmrvhmk45KU6ZW8PryzTr3ubFDrOSzJEByyHhX3EHy2QGU6YL
	1dnPVKxt+Ph9C7taeMpAwl+tf0nfAR3tTqnQJ4ahd23jiH1E0RNjxjNEyXB5yt4SEmS9KaY9oJ8
	5JJTtAotnWVEGJoNtAHYOyjTrLmSCQm8/uQz8jN0D
X-Gm-Gg: ASbGncv2h+g2wO0hMkFZ38RF7tMn/uK1xsimR0LOH5bRkRC3+siURGPNLmqxatHpYxi
	99DAtJwkz6Bt4Isksrd3NXyPNqLR4tVvjnqxYoVD7p7JtjJpI5xJiKlGfYE675afpHNNN6kq9BF
	jOcXiebP6XE8b5ztQVakBopFLvk8DqunmqQd5PWLIaliYk1EHMHPeJ4ZGt3lXPO7+ReY49TQ7Hw
	7lTeogOl39bhts9BTH42SSfuqMUU7X7ywnTJjECeSe7x+wvgqL/fG6UxivgxxR8znIZ3hdSVJ0=
X-Google-Smtp-Source: AGHT+IEnrB2h8PQy9u+30rXIgI+QDgnIuX/15sS4R7MZ+gU/dlU320wOGADvZuef3wKUPGOUC9U6DiROHwdlhpstyBI=
X-Received: by 2002:a17:902:ebd1:b0:24c:caab:dfd2 with SMTP id
 d9443c01a7336-290273032a5mr341007325ad.61.1760500504989; Tue, 14 Oct 2025
 20:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013152234.842065-1-edumazet@google.com> <20251013152234.842065-5-edumazet@google.com>
In-Reply-To: <20251013152234.842065-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 20:54:53 -0700
X-Gm-Features: AS18NWD4sl4qwgecOBOcKUsGjE18ElLcrJqHhzUtURUs3cwnYdMj_qnTchDb_ps
Message-ID: <CAAVpQUCn=Tco5VnkRsJ=3qODdNib5=qYbKA=G-ycG7UR-LOmiA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/4] net: allow busy connected flows to switch
 tx queues
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:22=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This is a followup of commit 726e9e8b94b9 ("tcp: refine
> skb->ooo_okay setting") and of prior commit in this series
> ("net: control skb->ooo_okay from skb_set_owner_w()")
>
> skb->ooo_okay might never be set for bulk flows that always
> have at least one skb in a qdisc queue of NIC queue,
> especially if TX completion is delayed because of a stressed cpu.
>
> The so-called "strange attractors" has caused many performance
> issues (see for instance 9b462d02d6dd ("tcp: TCP Small Queues
> and strange attractors")), we need to do better.
>
> We have tried very hard to avoid reorders because TCP was
> not dealing with them nicely a decade ago.
>
> Use the new net.core.txq_reselection_ms sysctl to let
> flows follow XPS and select a more efficient queue.
>
> After this patch, we no longer have to make sure threads
> are pinned to cpus, they now can be migrated without
> adding too much spinlock/qdisc/TX completion pressure anymore.
>
> TX completion part was problematic, because it added false sharing
> on various socket fields, but also added false sharing and spinlock
> contention in mm layers. Calling skb_orphan() from ndo_start_xmit()
> is not an option unfortunately.
>
> Note for later:
>
> 1) move sk->sk_tx_queue_mapping closer
> to sk_tx_queue_mapping_jiffies for better cache locality.
>
> 2) Study if 9b462d02d6dd ("tcp: TCP Small Queues
> and strange attractors") could be revised.
>
> Tested:
>
> Used a host with 32 TX queues, shared by groups of 8 cores.
> XPS setup :
>
> echo ff >/sys/class/net/eth1/queue/tx-0/xps_cpus
> echo ff00 >/sys/class/net/eth1/queue/tx-1/xps_cpus
> echo ff0000 >/sys/class/net/eth1/queue/tx-2/xps_cpus
> echo ff000000 >/sys/class/net/eth1/queue/tx-3/xps_cpus
> echo ff,00000000 >/sys/class/net/eth1/queue/tx-4/xps_cpus
> echo ff00,00000000 >/sys/class/net/eth1/queue/tx-5/xps_cpus
> echo ff0000,00000000 >/sys/class/net/eth1/queue/tx-6/xps_cpus
> echo ff000000,00000000 >/sys/class/net/eth1/queue/tx-7/xps_cpus
> ...
>
> Launched a tcp_stream with 15 threads and 1000 flows, initially affined t=
o core 0-15
>
> taskset -c 0-15 tcp_stream -T15 -F1000 -l1000 -c -H target_host
>
> Checked that only queues 0 and 1 are used as instructed by XPS :
> tc -s qdisc show dev eth1|grep backlog|grep -v "backlog 0b 0p"
>  backlog 123489410b 1890p
>  backlog 69809026b 1064p
>  backlog 52401054b 805p
>
> Then force each thread to run on cpu 1,9,17,25,33,41,49,57,65,73,81,89,97=
,105,113,121
>
> C=3D1;PID=3D`pidof tcp_stream`;for P in `ls /proc/$PID/task`; do taskset =
-pc $C $P; C=3D$(($C + 8));done
>
> Set txq_reselection_ms to 1000
> echo 1000 > /proc/sys/net/core/txq_reselection_ms
>
> Check that the flows have migrated nicely:
>
> tc -s qdisc show dev eth1|grep backlog|grep -v "backlog 0b 0p"
>  backlog 130508314b 1916p
>  backlog 8584380b 126p
>  backlog 8584380b 126p
>  backlog 8379990b 123p
>  backlog 8584380b 126p
>  backlog 8487484b 125p
>  backlog 8584380b 126p
>  backlog 8448120b 124p
>  backlog 8584380b 126p
>  backlog 8720640b 128p
>  backlog 8856900b 130p
>  backlog 8584380b 126p
>  backlog 8652510b 127p
>  backlog 8448120b 124p
>  backlog 8516250b 125p
>  backlog 7834950b 115p
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Interesting change and changelog!  thanks!

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

