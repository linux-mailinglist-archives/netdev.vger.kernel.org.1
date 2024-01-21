Return-Path: <netdev+bounces-64504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D34835741
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 19:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9FE281CAC
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C54364A1;
	Sun, 21 Jan 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="FFL943iU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CE26AC3
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705861972; cv=none; b=mTc9x83eFCBMJDVXI8CuqUepXS4Zm48lYYJKDbaEoGT8GlnmcFwMyeIJeA9QfCbur5wnS8EBGGsDce6kWUiC8DHFqjQpRD23kAZ99S6JZJ6iIdiNNXK+o4UC8k+7EHUi3SQkvlixEZCJpCaOGZAhbWTz47nvioHs1wxVMqjPuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705861972; c=relaxed/simple;
	bh=4rC7PwmQO61SrWq6Xh35YxV7rzOXaU8xtmO0FhewRAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7qynuJDhAJLX7gisZm9DE32o95/yqM2smG7MdpGw3YDq7rv+M4w+QYiJF5nxV+tKiep+yb7RYqZRm02x4FvhBVN2GjPIcvF4oK84YPsUNDVIJHAJPEwhMzGKHmEWqILvfdwuLiJLZk7fQPtxQMSK2vMejF6qFQzj8nbx6vySvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=FFL943iU; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc2540a4c26so1391689276.2
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 10:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705861968; x=1706466768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBM2r2Uw5uUoSx1OdqNeMA+j1N+1o1cAQiZ1FGSgOHA=;
        b=FFL943iU52jvc8jkWA/8nz8YS9WKgitOvpARQTTCwI9evCFHmv42JTgC3pLILq1dcf
         2H0jX8fv/mD4ZmDKehAhYvnzZMUnzR1h6ncRpbqbd57bF7WrA/s5mwfyXrfxk2MUhUSm
         y+6Dsbk1QzEzJ/moVLFobOG2wGreTEWnXFZwqg8b+09rsJB78OlJT/mo/xkSrJziGEPP
         jEugPra+qN0VFtwcGBPGmlhYQJi4zW3H7nYtnLSBObaqGVWSZ6nHxXq4g9eiZIjB4XKn
         rcvngx9yWINKRdGj65GTTjaxo7wKrqY0teLQlQQUO97NN7b3mhfHIas05Sode2xAc+Gw
         ZqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705861968; x=1706466768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBM2r2Uw5uUoSx1OdqNeMA+j1N+1o1cAQiZ1FGSgOHA=;
        b=D6ekg7vbRo++8Gm94YVuysqyRUQIhAMDtO5txNCOJPVM6QMa+UWTcxVC3dxdBVUW3v
         44vOrKZKdbQtguJGlxiInNpQFBTJfwAZ9TyINEmx5GiE9nN0vrxIpNqUwFXmhgo51bpe
         Zuo4fmCcY5OaD0enyJhOsYSVbgmmijiQjiG2jBPCe4/C6EF5d2Rxrzu41xNSec/hOnM+
         0QZWoPgJ5a9mpVAdO1bLAKwPC+FjLv6bzy8coqi3iAsTfRPIg+Z74Cgt3YQgLYHYKKVN
         2zgIyQnXTpXIatDzG9ME0RrHlAjC2SkU/WZxqI2VlQ1AjBQvQdCfykNNcuP+KDd9CXxa
         FIng==
X-Gm-Message-State: AOJu0Yyck/yblaIJ17NM6pBmtH/3PAGw5G/cq2NtkNAxpKJ/jyHCtxYb
	aEum6Pj9njfZWB8lL8X2N7E+55EUanr6EmOBWfbGOmeTDEDQi5XXtfQkhrJQgCeiQx4LynRcFFj
	AFTmYwvD1ypmXjcyOOHSXiyg6VxJdHpMou9v5
X-Google-Smtp-Source: AGHT+IHagUo+IOisjpAkz9h6DxKXYabLp8ZwCVSHbjTfsN+AlodH49MdmoRQSeyfqLXql4lEiFd+tmZLk95yG81IGtQ=
X-Received: by 2002:a05:6902:108e:b0:dc1:f71f:9fe9 with SMTP id
 v14-20020a056902108e00b00dc1f71f9fe9mr1340593ybu.123.1705861968533; Sun, 21
 Jan 2024 10:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104125844.1522062-1-jiri@resnulli.us> <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
 <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
 <878r4volo0.fsf@nvidia.com> <CAM0EoMkFkJBGc5wsYec+1QZ_o6tEi6vm_KjAJV8SWB4EOPcppg@mail.gmail.com>
 <87zfxbmp5i.fsf@nvidia.com> <CAM0EoMmC1z9SzF7zNtquPinBDr3Zu-wfKKRU0CMK3SP4ZobOsg@mail.gmail.com>
 <87v87ymqzq.fsf@nvidia.com> <CAM0EoMmLhg7DW4qOT0FZTpYN5rFX+406oNY3-wZv98td4X4Uhg@mail.gmail.com>
 <875xztmqoz.fsf@nvidia.com> <CAM0EoM=g23GRRK-OfRijmqv_deaW1VvytykwawdJ+rk1MseCOA@mail.gmail.com>
 <874jf9jmi3.fsf@nvidia.com>
In-Reply-To: <874jf9jmi3.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 21 Jan 2024 13:32:37 -0500
Message-ID: <CAM0EoMkKAzKqff4nfmQ+oiNydceNWHn-PYvLCk2VYMNxfdYXeA@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Petr Machata <petrm@nvidia.com>
Cc: Petr Machata <me@pmachata.org>, Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com, 
	victor@mojatatu.com, pctammela@mojatatu.com, mleitner@redhat.com, 
	vladbu@nvidia.com, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 11:51=E2=80=AFAM Petr Machata <petrm@nvidia.com> wr=
ote:
>
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > On Tue, Jan 16, 2024 at 7:03=E2=80=AFAM Petr Machata <petrm@nvidia.com>=
 wrote:
> >>
> >> Spectrum supports these mirror headers. They are sandwiched between th=
e
> >> encapsulation headers of the mirrored packets and the actual packet, a=
nd
> >> tell you the RX and TX ports, what was the mirror reason, some
> >> timestamps, etc. Without this, you need to encode the information into
> >> like parts of IPv6 or what not.
> >>
> >> But it's a proprietary format. It could be expressed as a netdevice, o=
r
> >> maybe a special version in the ERSPAN netdevice. But there's no
> >> standard, or public documentation, no open source tools that would
> >> consume it. AFAIK. So adding code to ERSPAN to support it looks like a
> >> non-starter.
> >
> > This is the kind of problem that P4 is well suited to solve. We are
> > stuck with current kernel implementations and current standards.
> > Spectrum can do so much more than the current ERSPAN standard
> > provides. It can do so much more than the current kernel code can
> > express. I am sure there are at least 5 people who want this feature
> > we are talking about but status quo says the only choice to make this
> > acceptable is to convince the masses (meaning likely years of chasing)
> > and do the ERSPAN standard mods alongside kernel and user space
> > implementation. And then in standards bodies like IEEE, IETF, etc you
> > politik to death trying to get people to sign onto your proposal with
> > +1s (sorry for the rant, but it is one reason i stopped going there).
> > Alternatively, just have those 5 people write a P4 program in a very
> > short time and not bother anybody else...
> >
> >> I was also toying with approaches around some push_header action, but =
it
> >> all seemed too clumsy. Also unclear how to express things like
> >> timestamps, port labels, mirror reasons, latency, queue depths... It's
> >> very, very HW-oriented header.
> >>
> >
> > So at one point Yotam Gigi was trying to use IFE for i think this,
> > which makes sense since you can add arbitrary metadata after the
> > ethernet header and transport it to a remote machine on the wire or
> > terminate on local cpu. You may want to look at that again because he
>
> I did look at IFE way back, but it looks like I should do that again.
>

Ping me if you need details.

> > seemed to think it works closely to the h/w approach. Of course it
> > suffers from the same "fixed implementation" so both the producer and
> > consumer would have to be taught what those metadatum mean i.e the
> > kernel and iproute2 code updates will be required. IIRC, the Cumulus
> > people pushed back and converted this into traps coming out of the
> > spectrum in order to make use of standardized tooling to avoid
> > retraining (I think it was sflow as the consumer).
> >
> >> I suppose with P4 there might be a way for the user to describe the
> >> encapsulation and for the driver to recognize it as the mirror header
> >> and offload properly. With some squinting: frankly I don't see anybody
> >> encoding things like queue depths, or anybody writing the driver code =
to
> >> recognize that indeed that's what it is.
> >
> > You can define whatever metadata you want and make your datapath
> > generate it. As long as you also have a P4 program on the consumer to
> > decode it. My fingers cant resist, so let me show extract from a
> > simple test program we have for P4TC which transports skb->mark
> > between machines:
> >
> > // define the headers
> > header customl2_t {
> >     bit<32> skbmark;
> >     bit<16> anothermetadatum
> >     bit<16> etherType;
> > }
> > ..
> > struct headers_t {
> >     ethernet_t   ethernet;
> >     customl2_t   customl2;
> >     ipv4_t       ip;
> >     //rest is considered payload
> > }
> > ...
>
> So let's talk about the queue depth in particular. How would the driver
> recognize the field?

Your driver doesnt need to recognize anything for either P4TC or IFE.
Does your driver need to know this detail for something it does maybe?
Post offload, on ingress into the kernel:
For P4TC, it will be taken care of by either the XDP code or tc code
(which is compiler generated) i.e no pre-existing kernel code
required.
For IFE, because it is a standard(its an RFC) you will have to write
kernel code to recognize what metadatum called "queudepth" means
(could be a kernel module) to conform to the IFE standard encoding
where each metadata you add is encapped in a TLV. You wouldnt need a
TLV if you prescribe it with P4.

> Does it need to "parse the parser" to figure it
> out? Or use magic field names? Use EtherType to just know what is meant
> by the header?

The example I showed used an ethertype to indicate that "a customer
header follows". But really you can do whatever you want.

> I don't see how to express the idea in the abstract, for
> the driver to recognize it and say, yeah, we can in fact offload this
> program, because it the abstract description matches what the HW is
> doing for mirror headers version XYZ.
>


For the policy offload side, it's mostly the tc ndo.
If you showed me your custom format, I am sure it can be expressed in
P4. Write P4 for mirror header version XYZ and tommorow you can write
a different one for version ABC. Then you generate the code and attach
it to a tc block which knows how to interpret the headers and maybe do
something with them. The trivial example i showed would strip off
customhdr->skbmark and write it to skb->mark.

> > //the parser
> >  ....
> >     state parse_ethernet {
> >         pkt.extract(hdr.ethernet);
> >         transition select(hdr.ethernet.etherType) {
> >             ETHERTYPE_IPV4: parse_ipv4;
> >             ETHERTYPE_CUSTOML2: parse_customl2;
> >             default: reject;
> >         }
> >     }
> >     state parse_customl2 {
> >         pkt.extract(hdr.customl2);
> >         transition select(hdr.customl2.etherType) {
> >             ETHERTYPE_IPV4: parse_ipv4;
> >             default: reject;
> >         }
> >     }
> >     state parse_ipv4 {
> >         pkt.extract(hdr.ip);
> >         transition accept;
> >     }
> >
> > ...
> >
> > Then you have a match action table definition which in our case
> > matches on dst ip, but you can make it match whatever you want. Add a
> > couple of actions; one to push and another to pop the headers. Here's
> > one that pushes (not showing the other part that pops and sets
> > skb->mark):
> >
> > action push_custom(@tc_type("macaddr") bit<48> dmac, @tc_type("dev")
> > PortId_t port)
> >          hdr.ethernet.dstAddr =3D dmac;
> >          hdr.customl2.etherType =3D hdr.ethernet.etherType;
> >          hdr.ethernet.etherType =3D ETHERTYPE_CUSTOML2;
> >          hdr.customl2.skbmark =3D meta.mark;
> >          hdr.customl2.setValid();
> >          send_to_port(port);
> > }
> >
> > And at runtime:
> > tc p4ctrl create mycustoml2/table/mytable dstAddr 10.99.0.1/32 \
> > action push_custom param dmac 66:33:34:35:46:01 param port eno1
> >
> > And when hw supports it, you could just say skip_sw above..
> > That's it - no need to argue about tomatos or tomateos on the mailing
> > list for the next 6 months or longer.
>
> OK, thanks for the primer, I'll try to carve out some time to look at it
> more closely.
>
> >> I'm not sure what semantics of mirroring to a qevent block are, but
> >> beyond that, it shouldn't impact us. Such rule would be punted from HW
> >> datapath, because there's no netdevice, and we demand a netdevice (plu=
s
> >> conditions on what the netdevice is allowed to be).
> >
> > Ok, for the hardware path i guess it's however you abstract it. But if
> > someone did this in sw as such:
> > --
> > tc qdisc add dev ens10 egress_block 10 clsact
> > tc qdisc add dev ens9 egress_block 10 clsact
> > tc qdisc add dev ens8 egress_block 10 clsact
> > tc filter add block 22 protocol ip pref 25 \
> >   matchall action mirred egress mirror blockid 10
> > tc qdisc add dev eth0 parent 10:7 handle 107: red limit 1000000 min
> > 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent
> > early_drop block 22
> > ---
> > Then all of ens8-10 will get a copy of the packet on the qevent.
>
> I meant the other way around. Say someone mirrors to blockid 22.
> Does the packet go to eth0?
>

No, it shouldnt. One of the potentials for loops is if you say mirror
from ens10 to block 22, so we do have rules to avoid the port equal to
ingressing port.

> > > > Its a "fixed" ASIC, so it is expected. But: One should be able to
> > > > express the Spectrum's ACLs or even the whole datapath as a P4 prog=
ram
> > >
> > > Yeah, I think so, too.
> > >
> > > > and i dont see why it wouldnt work with P4TC. Matty has at least on=
ce
> > > > in the past, if i am not mistaken, pitched such an idea.
> > >
> > > I don't see why it wouldn't work. What I'm saying is that at least th=
e
> > > ACL bits will just look fairly close to flower, because that's the HW=
 we
> > > are working with. And then the benefits of P4 are not as clear, becau=
se
> > > flower is already here and also looks like flower.
> >
> > That's fine mostly because the ASIC doesnt change once it is cast. If
> > however you want to expose a new field that the ASIC already supports,
> > the problem with flower is it is a "fixed datapath". Adding another
> > header requires changing the kernel (tc and flowdisector, driver) and
> > iproute2..
> >
> > > On the upside, we would get more flexibility with different matching
> > > approaches. Mixing different matchers is awkward (say flower + basic
> > > might occasionally be useful), so there's this tendency to cram
> > > everything into flower.
> > >
> >
> > It's a good hammer and if a lot of things can be imagined to be nails,
> > it works great ;->
> >
> > > I mentioned the mirror headers above, that's one area where TC just
> > > doesn't have the tools we need.
> > >
> >
> > Agreed - but with P4 you have a way out IMO.
>
> Yeah, that's why I'm mentioning it. Those mirror headers are the closest
> to where we would want... P4 or something P4-ish, to have the sort of
> flexibility we need. Because the alternatives are non-starters.
> (Though I'll check out IFE once more.)
>

Both should work. With P4 advantage is: you dont have to upstream
anything. You can just publish the P4 program.

> > > > I believe you but will have to look to make sense. There's at least
> > > > one attribute you mention above carried in some data structure in a
> > > > TLV (if i am not mistaken it is queue size either in packet or byte=
s,
> > > > depending on which fifo mode you are running). You are saying you c=
ant
> > > > add another one or a flag at least?
> > >
> > > Not backward-compatibly. The sole attribute's payload is interpreted =
as
> > > follows:
> > >
> >
> > Ok, just took a quick look..
> > > - length<4? Bounce.
> > > - length>=3D4? First u32 is queue limit, the rest is ignored garbage.
> >
> > I think you mean this part:
> >                 struct tc_fifo_qopt *ctl =3D nla_data(opt);
> >
> >                 if (nla_len(opt) < sizeof(*ctl))
> >                         return -EINVAL;
> >
> >                 sch->limit =3D ctl->limit;
> >
> > Yeah, cant stash a new attribute there unfortunately. TCA_OPTIONS only
> > has tc_fifo_qopt. Would have been easier if TCA_OPTIONS was nested
> > (like other qdiscs such as TBF) - then you could add a new TLV.
>
> Yep.
>
> > > So you have to stash any new stuff into the now-ignored garbage, thus
> > > changing behavior. The I-think-safe approach that I mention above is
> > > passing limit=3D0 and serializing the real attribute tree into the ga=
rbage
> > > area. So if limit=3D0 and the garbage parses as an atrribute tree, us=
e
> > > that, otherwise it's really just limit of 0 and some garbage.
> > >
> > > I think this is safe, because the combination of limit=3D0 (already a=
n
> > > improbable configuration) and parseable garbage is unlikely to arise =
by
> > > mistake. But it's kludgy.
> > >
> > > Or maybe the flag could be in the message header, but that seems wron=
g
> > > given we are talking about extending one qdisc kind.
> >
> > I can see the dilema - and if i understood correctly what you are
> > suggesting, something like:
> >
> > if (nla_len(opt) =3D=3D sizeof(*ctl))
> >     do the old thing here
> > else if (nla_len(opt) =3D=3D sizeof(*mynewstruct))
> >     do the new thing here
> > else
> >     invalid..
>
> Basically this, but handle the case that a broken userspace is sending
> payload such that (nla_len(opt) =3D=3D sizeof(*mynewstruct)), but only
> provides the first four bytes with the queue limit, and the rest is
> garbage.

That would be standard checks though, no? i.e
if (mynewstruct->foo doesnt make sense)
      set extack appropriately and EINVAL back

cheers,
jamal

