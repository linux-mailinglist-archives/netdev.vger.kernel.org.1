Return-Path: <netdev+bounces-210515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614F1B13BD6
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B0517DDBF
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AC826A1BE;
	Mon, 28 Jul 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhKlu59N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075C266EFA;
	Mon, 28 Jul 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710399; cv=none; b=ABvh6C6zHIzxudLLvwPtEcxpsAJCAY64katg/Ulc2L1Q4Y7NlF2N/TWW8ckn7vHUDuU+OCVpLMids2XMcncuCKm4tOapDhLYAAKavHlOJJO3ZppKTAPou9rwVRHgXcMR3XW2aqMM0dd2B53nQ2FFEq7SaGkCC2qYgtEo4UFqbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710399; c=relaxed/simple;
	bh=KUryzaERAvJqb9dbVsYlQdERkvnmmSExuWttDIH9Lvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFon/MGqZixA+osanc4sSLf4bIq5RcJ1g8nck+t0XQmW1D8swX2X8TbhX5cUEsfpBiwbUDaHZaDcgNZkQGEJgjIGYyJke4/ZPDMCHUuO3fyyG63Iiuflyx5Scn+8gFOk0wjfTuqcsrZ/2zeGXFzIiaDEem4BPion48X1Px21BDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhKlu59N; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71a142a3930so11267077b3.3;
        Mon, 28 Jul 2025 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753710396; x=1754315196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV3Vlrf+Dcp3pYeQ4RJHqSbiWAgiJsKRLGV52Ma67rs=;
        b=AhKlu59NAUXGZJjK8TmAwu+aTkehIjgUqJl6tgi407BI1WkgsVIAciLKswhpml7csO
         UDDwt/q96MFt80W9gXyqhuLKGL0hJIP5Jnfx8LkhIEw2gMbSjYrRdzcHX/Jz6DkB2xxf
         SbsR4PqapO8eCUOdMcat5ZSWNQoW/87i0EkSQ3EI9K5wL0a5OSa3Kc2mZt5BSdfVMTZ+
         A22iedlfCdjZJYL4uVJybj5cjd9EZiscHGakLVn0SvuJl09/a+UDxURfyCIX5wSL38+A
         EYZhbNsRRTCYibF4rwOyXpL7cKlQKkOfeF5JZR3aOx2LePD9HMlD4lGEqdCKy0sOeOFg
         9ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710396; x=1754315196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV3Vlrf+Dcp3pYeQ4RJHqSbiWAgiJsKRLGV52Ma67rs=;
        b=ZFwKG0BOGA47zUJ2xIo5aaXMBqZqU2TRLefSfSkWqRGzsrOe/Tnqw3E10+gakaAJh8
         ODUdLU54GJGZQ6G7wu4fbrOR31wVQEfOPaVEL1MJ3HHZPg70twJQ286z2fuQLGOzZ1vf
         580M+WASqjI9z/XiyN7zTT5NNPzAUu/pq5xT6cPbFtRc0InijZkGHMfYUBWJ7glz3I59
         X7G0f0q2k/pix/enMTSbXnnwESUGlMA/hgd1UDSWQLH8cIVi0IH5qGbLW1iytcoxcW6F
         WcfdEvjVpNUCZsNJbk5yPpUHmlr02bcGzwSp+axyy1w1TCF/vX4H+VvZPcj/vTlUUWj3
         X4oA==
X-Forwarded-Encrypted: i=1; AJvYcCWNXhWdjWWxcnAbpUg/hvzCqbMiGGlEZ9/3MSpcS9dHL1khcXHvUGOI5t0C0hWuppQVsQgHOsoA@vger.kernel.org, AJvYcCWs8j39e0ifrB5R/zf5xEhOZp9ayA/mPntqytG1YNxGV8Arz4exO8+xTjyJ6BZQwd1rkugTznwWAJHapUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rAsOrG4yAYTruiYbtKf4pJa55AsGaFUPlkKa2zzANZXv53p3
	WGhsWyXD7a+KGM004qvGE7ksbCmAlRsv83q1J9IxBoJRVQ9UR0XWf8xS57htarbnsWPYvrgHOaM
	8Xu4R0L28VUydC2uO9iGEdSJcv28yVbg=
X-Gm-Gg: ASbGncu6Yt9AxWtILhNk3KVxM4T02tLuC/7SVwUBnQpnvPMv5BmrWR0aXi3ik2P+4IH
	0Kwlz5TUz/4wwsXrRax8o+5/nMim0iHBy7HIlqbyZBtO2ALBtQR191AksLDvBTMCl2wY2bYqlsl
	h3fTd96CFhT1t72TXuB+UrN8D9MBxLn0O0kbrJ8ksNxFBAqVgo3icAT96145h7mVlHu3brS1uEd
	mjC3kuWVpUBbRL2hTHqZqkFQ3ko0ewvDok1Cb1cDfBau0RoU04=
X-Google-Smtp-Source: AGHT+IFE0kEBudBOjM2TNjoxisROStovHMmqFEfJnS8J5sKQu01XtZt6jYIMoXIZwjZpSJpgQfkG85ALBTePR/CBzA4=
X-Received: by 2002:a05:690c:f07:b0:70e:2d17:84b5 with SMTP id
 00721157ae682-719e33cc84emr156139947b3.0.1753710395799; Mon, 28 Jul 2025
 06:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083005.3918375-1-wangliang74@huawei.com>
 <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
 <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com> <68865594e28d8_9f93f29443@willemb.c.googlers.com.notmuch>
 <68865ecee5cc4_b1f6a29442@willemb.c.googlers.com.notmuch> <08399323-6bab-44f6-bc21-21faf68cd73d@huawei.com>
In-Reply-To: <08399323-6bab-44f6-bc21-21faf68cd73d@huawei.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 28 Jul 2025 09:45:57 -0400
X-Gm-Features: Ac12FXw0V6XS8_Onoe8FgszTj9Ab1xxkYHQGTXFFWGDo2oo-bNGqseZEqw5fdfM
Message-ID: <CAF=yD-JUgwSgYhYkOcJUkiuTkDLee6mfR0abikokpZfveCCp4g@mail.gmail.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in virtio_net_hdr_to_skb()
To: Wang Liang <wangliang74@huawei.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	willemb@google.com, atenart@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	steffen.klassert@secunet.com, tobias@strongswan.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 11:36=E2=80=AFPM Wang Liang <wangliang74@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2025/7/28 1:15, Willem de Bruijn =E5=86=99=E9=81=93:
> > Willem de Bruijn wrote:
> >> But so the real bug, an skb with 4B in the UDP layer happens before
> >> that.
> >>
> >> An skb_dump in udp_queue_rcv_skb of the GSO skb shows
> >>
> >> [  174.151409] skb len=3D190 headroom=3D64 headlen=3D190 tailroom=3D66
> >> [  174.151409] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> >> [  174.151409] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D4 type=3D655=
38 segs=3D0))
> >> [  174.151409] csum(0x8c start=3D140 offset=3D0 ip_summed=3D3 complete=
_sw=3D0 valid=3D1 level=3D0)
> >> [  174.151409] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=
=3D8
> >> [  174.151409] priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_all=3D0x0
> >> [  174.151409] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D=
0, trans=3D0)
> >> [  174.152101] dev name=3Dtun0 feat=3D0x00002000000048c1
> >>
> >> And of segs[0] after segmentation
> >>
> >> [  103.081442] skb len=3D38 headroom=3D64 headlen=3D38 tailroom=3D218
> >> [  103.081442] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> >> [  103.081442] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 s=
egs=3D0))
> >> [  103.081442] csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete=
_sw=3D0 valid=3D1 level=3D0)
> >> [  103.081442] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=
=3D8
> >> [  103.081442] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
> >> [  103.081442] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D=
0, trans=3D0)
> >>
> >> So here translen is already 38 - (98-64) =3D=3D 38 - 34 =3D=3D 4.
> >>
> >> So the bug happens in segmentation.
> >>
> >> [ongoing ..]
> > Oh of course, this is udp fragmentation offload (UFO):
> > VIRTIO_NET_HDR_GSO_UDP.
> >
> > So only the first packet has an UDP header, and that explains why the
> > other packets are only 4B.
> >
> > They are not UDP packets, but they have already entered the UDP stack
> > due to this being GSO applied in udp_queue_rcv_skb.
> >
> > That was never intended to be used for UFO. Only for GRO, which does
> > not build such packets.
> >
> > Maybe we should just drop UFO (SKB_GSO_UDP) packets in this code path?
>
>
> Thank you for your analysis, it is totally right!
>
> After segment in udp_queue_rcv_skb(), these segs are not UDP packets, whi=
ch
> leads the crash.
>
> The packet with VIRTIO_NET_HDR_GSO_UDP type from tun device perhaps shoul=
d
> not enter udp_rcv_segment().
>
> How about not do segment and pass the packet to udp_queue_rcv_one_skb()
> directly, like this:
>
>    diff --git a/include/linux/udp.h b/include/linux/udp.h
>    index 4e1a672af4c5..0c27e5194657 100644
>    --- a/include/linux/udp.h
>    +++ b/include/linux/udp.h
>    @@ -186,6 +186,9 @@ static inline bool udp_unexpected_gso(struct sock
> *sk, struct sk_buff *skb)
>            if (!skb_is_gso(skb))
>                    return false;
>
>    +       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
>    +               return false;
>    +
>            if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>                !udp_test_bit(ACCEPT_L4, sk))
>                    return true;

That seemingly is what would have happened before introducing
udp_unexpected_gso. The same for SKB_GSO_UDP_L4 packets actually.

It is not in any way an intended use case. And given the longstanding
breakage clearly not actually used.

UDP sockets do not expect GSO packets, so queuing them might confuse them.

Specifically for UFO, it can be argued that they are the same as large
packets that were build by the IP defrag layer.

Still to avoid having to start maintaining an unintentional code path,
including having to likely fix more reports over time and with that
likely add complexity to the real UDP hot path as well, I think we
should instead drop these.

