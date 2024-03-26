Return-Path: <netdev+bounces-82222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D6188CB93
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 19:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A9EB230E0
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BBA8662C;
	Tue, 26 Mar 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBE5bhAN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEEB1B59A
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476504; cv=none; b=MC3fqK6cHpjRUnspwAvvuxoqYbSitaIx43nnUU7tluvHAodVieBkuFwRubOTRxUtdlRGpOJny9rx4LkteHXyOL9aQ/BuuUCBs/9RhZo5VI1cporqK8iH4DEoxlLjYO4fqWLsEPEyOsyNiPKdzYgIHMDPRLIMnn1fnUsQCiM8ry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476504; c=relaxed/simple;
	bh=gQivpQXQ1i5VWKCld7cyvCzkisXrBvr46LNSzeN1xpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvUSm4+uSMqVmzkaQmMHvHv3RwhohwUvKc4fX8Q8CTG61QOj2bXWuiABzrzS0D+qX2YL6EIHWoMYj4McqCt/esX3kMwFP4wgU72lNwI+56/UTuk0Y8mM5SlKPzHMtDqPThGB6VubQiYPxyDm2WGz1GEe1O7yxK+Gj5wyA61BNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBE5bhAN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so1914a12.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711476500; x=1712081300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9Fih/+9PDXO+qntssbstbtSjBYLkHwpt/fkCd1ZUos=;
        b=YBE5bhANEFtaOxTv6lFe+afHh1voRYlOegybUpRWrQCBa8isVbBJYaDyiA6Ss19ZF9
         MTBIzNp4yo3w77ejHdMhCMSyq84//OUAeQyHhy9L8wGDpnTgZfRHkhoc8WlBrwWmpmGB
         /A4FB2YLJWCxrV5dy3NA28yhjNreCtsXRaObJPRJpfG1ywE74HGj8aIXbml8TGmalPXp
         tfSCvMIXaWkSc3g6hCgIYEy1zYb7w2dDJRyOKPGx9A8enzuVmqiR6dCdQMDcLt2++D2L
         t250h9PaabG4Cs/tLEkX8zIMxtit6WDrPm6YShupScrWQ59p1EBOgin7N2yQUgXUOUI3
         Y8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476500; x=1712081300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9Fih/+9PDXO+qntssbstbtSjBYLkHwpt/fkCd1ZUos=;
        b=VFJHn1zOwTxYETfnWslE6iFTFCu27HTBD6OWpi2uu7Mg/kMYaK7aCnA0svpNZcg3kE
         PCmgVkEXtH6PHK3hEp88ItE5SA0bD2RDaF5BWwhInQ9+LyKgMy1613y/c+6rUPOy+nfK
         ZVMP3rvx5+bQETXIzorc28lEdytfjv9xt9c52NJ6KGl/Oeyc41L3RAdxV5wjOKFuT5ss
         FHJLARm8y0WPhANTGnDRGnRZX+G7XAbr6x7rY/MIM44nQ91KTBZvPUW0tH0G5ze8H/KA
         8I5Vvc6AhUkUeoTvAMtfjjkuRpMMD1VXSbk6/kF0P7eRPQ9PRxU+Nhb5kPGPmhfRbfX9
         HFKw==
X-Forwarded-Encrypted: i=1; AJvYcCXr/SNd9wX/GPHmIRe+73rtupp9l6papU+1bkkpOH4NhefaArYoh5+M3czSd9B3NGUHkPtqMfxDBYPYi+HYzWNwQZp9r0mA
X-Gm-Message-State: AOJu0YxbQEWJMWQ0DCRscphkGp/e29Cr7D4s8SMs3V/+HDs1oin6TdZG
	ObK7ybCwAVUmHX3c40n2MmFO0LbG2SzSc5tpjr/h6Te4gavOMiJ9Er8ZNV3R8Doa3/BlXq7s5Xs
	kHMPxjtJ9COwVw3GZQHOCRHu06DOTg2tzubdC
X-Google-Smtp-Source: AGHT+IH0Dy3ilgzfG2eqeM1W2dis2G2NR8sjFcX61Ee0XDx+7jWdenJffz4htuJPh9tF8qH0AJUGDO57EmIE2Jk6uYU=
X-Received: by 2002:a50:fc02:0:b0:56c:18df:f9e1 with SMTP id
 i2-20020a50fc02000000b0056c18dff9e1mr3186edr.5.1711476500214; Tue, 26 Mar
 2024 11:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322122407.1329861-1-edumazet@google.com> <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
 <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
 <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
 <CAADnVQ+OhsBetPT0avuNVsEwru13UtMjX1U_6_u6xROXBBn-Yg@mail.gmail.com>
 <ZgGmQu09Z9xN7eOD@google.com> <d9531955-06ad-ccdd-d3d0-4779400090ba@iogearbox.net>
 <CANn89iJFOR5ucef0bH=BTKrLOAGsUtF8tM=cYNDTg+=gHDntvw@mail.gmail.com>
 <CANn89iKZ0126qzvpm0bPP7O+M95hcGWKp_HPg+M7vgdDHr0u0A@mail.gmail.com> <3050c54d-3b3c-53b0-6004-fa11caca27b6@iogearbox.net>
In-Reply-To: <3050c54d-3b3c-53b0-6004-fa11caca27b6@iogearbox.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Mar 2024 19:08:06 +0100
Message-ID: <CANn89iK25-UnBaz_=15SCZKzAmh2-vgMhfStv5GqFg=95VJE+A@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Guillaume Nault <gnault@redhat.com>, patchwork-bot+netdevbpf@kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:57=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 3/26/24 2:38 PM, Eric Dumazet wrote:
> > On Tue, Mar 26, 2024 at 2:37=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >> On Tue, Mar 26, 2024 at 1:46=E2=80=AFPM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >>> On 3/25/24 5:28 PM, Stanislav Fomichev wrote:
> >>>> On 03/25, Alexei Starovoitov wrote:
> >>>>> On Mon, Mar 25, 2024 at 6:33=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> >>>>>> On Sat, Mar 23, 2024 at 4:02=E2=80=AFAM Alexei Starovoitov
> >>>>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>>>> On Fri, Mar 22, 2024 at 7:10=E2=80=AFAM <patchwork-bot+netdevbpf@=
kernel.org> wrote:
> >>>>>>>>
> >>>>>>>> Hello:
> >>>>>>>>
> >>>>>>>> This patch was applied to bpf/bpf.git (master)
> >>>>>>>> by Daniel Borkmann <daniel@iogearbox.net>:
> >>>>>>>>
> >>>>>>>> On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
> >>>>>>>>> Some drivers ndo_start_xmit() expect a minimal size, as shown
> >>>>>>>>> by various syzbot reports [1].
> >>>>>>>>>
> >>>>>>>>> Willem added in commit 217e6fa24ce2 ("net: introduce device min=
_header_len")
> >>>>>>>>> the missing attribute that can be used by upper layers.
> >>>>>>>>>
> >>>>>>>>> We need to use it in __bpf_redirect_common().
> >>>>>>>
> >>>>>>> This patch broke empty_skb test:
> >>>>>>> $ test_progs -t empty_skb
> >>>>>>>
> >>>>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> >>>>>>> [redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
> >>>>>>> [redirect_ingress]: actual -34 !=3D expected 0
> >>>>>>> test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redirect=
_egress] 0 nsec
> >>>>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> >>>>>>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> >>>>>>> [redirect_egress]: actual -34 !=3D expected 1
> >>>>>>>
> >>>>>>> And looking at the test I think it's not a test issue.
> >>>>>>> This check
> >>>>>>> if (unlikely(skb->len < dev->min_header_len))
> >>>>>>> is rejecting more than it should.
> >>>>>>>
> >>>>>>> So I reverted this patch for now.
> >>>>>>
> >>>>>> OK, it seems I missed __bpf_rx_skb() vs __bpf_tx_skb(), but even i=
f I
> >>>>>> move my sanity test in __bpf_tx_skb(),
> >>>>>> the bpf test program still fails, I am suspecting the test needs t=
o be adjusted.
> >>>>>>
> >>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>>>>> index 745697c08acb3a74721d26ee93389efa81e973a0..e9c0e2087a08f1d8af=
d2c3e8e7871ddc9231b76d
> >>>>>> 100644
> >>>>>> --- a/net/core/filter.c
> >>>>>> +++ b/net/core/filter.c
> >>>>>> @@ -2128,6 +2128,12 @@ static inline int __bpf_tx_skb(struct
> >>>>>> net_device *dev, struct sk_buff *skb)
> >>>>>>                   return -ENETDOWN;
> >>>>>>           }
> >>>>>>
> >>>>>> +       if (unlikely(skb->len < dev->min_header_len)) {
> >>>>>> +               pr_err_once("__bpf_tx_skb skb->len=3D%u <
> >>>>>> dev(%s)->min_header_len(%u)\n", skb->len, dev->name,
> >>>>>> dev->min_header_len);
> >>>>>> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> >>>>>> +               kfree_skb(skb);
> >>>>>> +               return -ERANGE;
> >>>>>> +       } // Note: this is before we change skb->dev
> >>>>>>           skb->dev =3D dev;
> >>>>>>           skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb));
> >>>>>>           skb_clear_tstamp(skb);
> >>>>>>
> >>>>>>
> >>>>>> -->
> >>>>>>
> >>>>>>
> >>>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> >>>>>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> >>>>>> [redirect_egress]: actual -34 !=3D expected 1
> >>>>>>
> >>>>>> [   58.382051] __bpf_tx_skb skb->len=3D1 < dev(veth0)->min_header_=
len(14)
> >>>>>> [   58.382778] skb len=3D1 headroom=3D78 headlen=3D1 tailroom=3D11=
3
> >>>>>>                  mac=3D(64,14) net=3D(78,-1) trans=3D-1
> >>>>>>                  shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=
=3D0 segs=3D0))
> >>>>>>                  csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 =
level=3D0)
> >>>>>>                  hash(0x0 sw=3D0 l4=3D0) proto=3D0x7f00 pkttype=3D=
0 iif=3D0
> >>>>>
> >>>>> Hmm. Something is off.
> >>>>> That test creates 15 byte skb.
> >>>>> It's not obvious to me how it got reduced to 1.
> >>>>> Something stripped L2 header and the prog is trying to redirect
> >>>>> such skb into veth that expects skb with L2 ?
> >>>>>
> >>>>> Stan,
> >>>>> please take a look.
> >>>>> Since you wrote that test.
> >>>>
> >>>> Sure. Daniel wants to take a look on a separate thread, so we can sy=
nc
> >>>> up. Tentatively, seems like the failure is in the lwt path that does
> >>>> indeed drop the l2.
> >>>
> >>> If we'd change the test into the below, the tc and empty_skb tests pa=
ss.
> >>> run_lwt_bpf() calls into skb_do_redirect() which has L2 stripped, and=
 thus
> >>> skb->len is 1 in this test. We do use skb_mac_header_len() also in ot=
her
> >>> tc BPF helpers, so perhaps s/skb->len/skb_mac_header_len(skb)/ is the=
 best
> >>> way forward..
> >>>
> >>> static int __bpf_redirect_common(struct sk_buff *skb, struct net_devi=
ce *dev,
> >>>                                    u32 flags)
> >>> {
> >>>           /* Verify that a link layer header is carried */
> >>>           if (unlikely(skb->mac_header >=3D skb->network_header || sk=
b->len =3D=3D 0)) {
> >>>                   kfree_skb(skb);
> >>>                   return -ERANGE;
> >>>           }
> >>>
> >>>           if (unlikely(skb_mac_header_len(skb) < dev->min_header_len)=
) {
> >>
> >> Unfortunately this will not prevent frames with skb->len =3D=3D 1 to r=
each
> >> an Ethernet driver ndo_start_xmit()
> >>
> >> At ndo_start_xmit(), we do not look where the MAC header supposedly
> >> starts in the skb, we only use skb->data
> >>
> >> I have a syzbot repro using team driver, so I added the following part=
 in team :
> >>
> >> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> >> index 0a44bbdcfb7b9f30a0c27b700246501c5eba322f..75e5ef585a8f05b35cfddb=
ae0bfc377864e6e38c
> >> 100644
> >> --- a/drivers/net/team/team.c
> >> +++ b/drivers/net/team/team.c
> >> @@ -1714,6 +1714,11 @@ static netdev_tx_t team_xmit(struct sk_buff
> >> *skb, struct net_device *dev)
> >>          bool tx_success;
> >>          unsigned int len =3D skb->len;
> >>
> >> +       if (len < 14) {
> >> +               pr_err_once("team_xmit(len=3D%u)\n", len);
> >> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> >> +               WARN_ON_ONCE(1);
> >> +       }
> >>          tx_success =3D team_queue_override_transmit(team, skb);
> >>          if (!tx_success)
> >>                  tx_success =3D team->ops.transmit(team, skb);
> >>
> >>
> >> And I get (with your suggestion instead of skb->len)
> >
> > Missing part in my copy/paste :
> >
> > [   41.123829] team_xmit(len=3D1)
> > [   41.124335] skb len=3D1 headroom=3D78 headlen=3D1 tailroom=3D113
> >
> >> mac=3D(78,0) net=3D(78,-1) trans=3D-1
>
> Interesting.
>
> Could you also dump dev->type and/or dev->min_header_len? I suspect
> this case may not be ARPHRD_ETHER in team.
>
> Above says mac=3D(78,0), so mac len is 0 and the check against the
> dev->min_header_len should have dropped it if it went that branch.

mac header is reset in __dev_queue_xmit() :

         skb_reset_mac_header(skb);

So when the bpf code ran, skb_mac_header_len(skb) was 14,
but later the MAC header was set (to skb->data)

>
> I wonder, is team driver missing sth like :
>
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index 0a44bbdcfb7b..6256f0d2f565 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2124,6 +2124,7 @@ static void team_setup_by_port(struct net_device *d=
ev,
>          dev->type =3D port_dev->type;
>          dev->hard_header_len =3D port_dev->hard_header_len;
>          dev->needed_headroom =3D port_dev->needed_headroom;
> +       dev->min_header_len =3D port_dev->min_header_len;
>          dev->addr_len =3D port_dev->addr_len;
>          dev->mtu =3D port_dev->mtu;
>          memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
>


I have confirmed that team min_header_len is 14, nothing seems to be
missing I think.

team_xmit(dev team0, skb->len=3D1, dev->min_header_len=3D14)

