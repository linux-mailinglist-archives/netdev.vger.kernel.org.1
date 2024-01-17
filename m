Return-Path: <netdev+bounces-64050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F68830E28
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 21:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DE31C21443
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B60250EC;
	Wed, 17 Jan 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CFxlJAXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373E250E8
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524270; cv=none; b=sjUTH2/8dQkZ8LCDVPEmqDqkpa149vmiY+/o1DnIvqKVEBBHKO9gPj5IOmFp6xRvHSwT1dRQnv1NcBehl2B72UaVoYmp7lXxIFD1B6vemJXJhuGd6FVeQ7FmPVeZPFb/eD1/mNT7IYV92Zb992WQGGygRfG8NR7vZQ//t9pkEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524270; c=relaxed/simple;
	bh=eCs+DQ8WHpE4k9pxW6PXFbBrWF1eTM/QnYrpL4yr++M=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=MwLp/TK7pKvHF4vXLcXWq12PotKTTE+udm4xc+w+1dzSxUSxOl8KQ0iLyE21tZsC8rzCRXcPCmpBO9+KMrRXtBUMzqt6i1VTXlM9QdVCD6i14+caWjqLvS8Ok1gNAU+gdqdv/+vD+kVsKMNOV85doVR0ewPm49F02AptFD692AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=CFxlJAXI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5f00bef973aso118954517b3.0
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 12:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705524266; x=1706129066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF7GCL/S21BdbRkwT/LSXQRW0zmqAF/CvKlW2et3mV0=;
        b=CFxlJAXI0ypgP/tTKiHAt2p2b1XZPmkVwiDOFXui7Y0cR6d4+AYWQNyswFnESqrD1L
         5Bw74Rz6IceW9IXjJCXx4wdB216u/rbyfgXV9vJCYLf58heVZ+bY7Xn91zI0dpS/+LDO
         qBD0RsXJqRcwVHVbHMsna+SnlC16kDyFxxd5psKFuc7Th/2evU+5XI6w/Ac6nnQThqll
         lMTI4r5Cm1WOqSTORajGM7WF57KGxb2wak5xdkauCBCdrmQt0OQK5Zte0H8fie5jJ5uh
         SNnPxVU1KLETAJkQUJ8XpweRTnZSDzsWyxhtkBXZRt125tUCAdouO2IY0+dvwlV7036H
         A/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524266; x=1706129066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF7GCL/S21BdbRkwT/LSXQRW0zmqAF/CvKlW2et3mV0=;
        b=iN3XpDNCRh0xNdrpk8XUeJFXWYPaM7NrsTZ9oqPgeSKxK025cQkYDUJre3l88yaCTq
         lhxLvnw8xxYz2VJBywxIUAnmvgXwo4mpV1x3D7g5CqoHTv2sB6EIiT+d4Jr6MR5qE/hV
         jocojVVuW84kzEHVjPiyMhMP/5wiSQSW1UQljyQyoyNMOKJKL2rNHYwRfVeC60Jf4QmK
         lqFtsedUDtEiCcfWtf9SH9TeWsqWmnXgDfReIh//UfiZaIqllBcyzdyWUWjHv/d8y3g7
         g+WTEjtcVPMX7PhIpDhhPDfVltAb6/nMavvmuqImMBlc94hQSDZcWEdH8ObyNYesH6CB
         gb3w==
X-Gm-Message-State: AOJu0Yy8a1XSpdDe0mEhaSf7+5aF2E3jLVra4VGDrHtnaT4F0yti6qQ8
	9rRUBYAZa58PSn2ALX4+I2Q45Y4Rp5QwPv+KAvS44tryztSMqyJ9KVbJ/4GmyA==
X-Google-Smtp-Source: AGHT+IFs2nP3eHPsB1liLxY4kT+5niVv5pggJOGFPlj+avTNLc/kb+NCV6tiD7v3MA+iwoL14+fN3ytfssc14oFIH1c=
X-Received: by 2002:a25:c788:0:b0:dc2:3a01:4764 with SMTP id
 w130-20020a25c788000000b00dc23a014764mr1602798ybe.96.1705524266280; Wed, 17
 Jan 2024 12:44:26 -0800 (PST)
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
 <875xztmqoz.fsf@nvidia.com>
In-Reply-To: <875xztmqoz.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 17 Jan 2024 15:44:14 -0500
Message-ID: <CAM0EoM=g23GRRK-OfRijmqv_deaW1VvytykwawdJ+rk1MseCOA@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Petr Machata <petrm@nvidia.com>
Cc: Petr Machata <me@pmachata.org>, Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com, 
	victor@mojatatu.com, pctammela@mojatatu.com, mleitner@redhat.com, 
	vladbu@nvidia.com, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Tue, Jan 16, 2024 at 7:03=E2=80=AFAM Petr Machata <petrm@nvidia.com> wro=
te:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > On Fri, Jan 12, 2024 at 11:55=E2=80=AFAM Petr Machata <petrm@nvidia.com=
> wrote:
> >>
> >>
> >> Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >>
> >> > On Thu, Jan 11, 2024 at 6:22=E2=80=AFPM Petr Machata <me@pmachata.or=
g> wrote:
> >> >>
> >> >> Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >> >> > So a packet tagged for early drop will end up being processed in =
some
> >> >> > filter chain with some specified actions. So in the case of offlo=
ad,
> >> >> > does it mean early drops will be sent to the kernel and land at t=
he
> >> >> > specific chain? Also trying to understand (in retrospect, not arm=
chair
> >> >>
> >> >> For offload, the idea is that the silicon is configured to do the t=
hings
> >> >> that the user configures at the qevent.
> >> >
> >> > Ok, so none of these qevents related packets need to escape to s/w t=
hen.
> >>
> >> Like yeah, I suppose drops and marks shouldn't be /that/ numerous, so
> >> maybe you can get away with the cookie / schedule from driver that you
> >> talk about below. But you've got dozens of ports each of which is
> >> capable of flooding the PCI on its own. I can see this working for lik=
e
> >> connection tracking, or some other sort of miss that gets quickly
> >> installed in HW and future traffic stays there. I'm not sure it makes
> >> sense as a strategy for basically unbounded amounts of drops.
> >
> > I misunderstood this to be more to trigger the control plane to do
> > something like adjust buffer sizes etc, etc. But if you are getting a
> > lot of these packets like you said it will be tantamount to a DoS.
> > For monitoring purposes (which seems to be the motivation here) I
> > wouldnt send pkts to the kernel.
> > Mirroring that you pointed to is sane, possibly even to a remote
> > machine dedicated for this makes more sense. BTW, is there a way for
> > the receiving end (where the packet is mirrored to) to know if the
> > packet they received was due to a RED drop or threshold excess/ecn
> > mark?
>
> Spectrum supports these mirror headers. They are sandwiched between the
> encapsulation headers of the mirrored packets and the actual packet, and
> tell you the RX and TX ports, what was the mirror reason, some
> timestamps, etc. Without this, you need to encode the information into
> like parts of IPv6 or what not.
>

Makes sense given the available options.

> But it's a proprietary format. It could be expressed as a netdevice, or
> maybe a special version in the ERSPAN netdevice. But there's no
> standard, or public documentation, no open source tools that would
> consume it. AFAIK. So adding code to ERSPAN to support it looks like a
> non-starter.
>

This is the kind of problem that P4 is well suited to solve. We are
stuck with current kernel implementations and current standards.
Spectrum can do so much more than the current ERSPAN standard
provides. It can do so much more than the current kernel code can
express. I am sure there are at least 5 people who want this feature
we are talking about but status quo says the only choice to make this
acceptable is to convince the masses (meaning likely years of chasing)
and do the ERSPAN standard mods alongside kernel and user space
implementation. And then in standards bodies like IEEE, IETF, etc you
politik to death trying to get people to sign onto your proposal with
+1s (sorry for the rant, but it is one reason i stopped going there).
Alternatively, just have those 5 people write a P4 program in a very
short time and not bother anybody else...

> I was also toying with approaches around some push_header action, but it
> all seemed too clumsy. Also unclear how to express things like
> timestamps, port labels, mirror reasons, latency, queue depths... It's
> very, very HW-oriented header.
>

So at one point Yotam Gigi was trying to use IFE for i think this,
which makes sense since you can add arbitrary metadata after the
ethernet header and transport it to a remote machine on the wire or
terminate on local cpu. You may want to look at that again because he
seemed to think it works closely to the h/w approach. Of course it
suffers from the same "fixed implementation" so both the producer and
consumer would have to be taught what those metadatum mean i.e the
kernel and iproute2 code updates will be required. IIRC, the Cumulus
people pushed back and converted this into traps coming out of the
spectrum in order to make use of standardized tooling to avoid
retraining (I think it was sflow as the consumer).

> I suppose with P4 there might be a way for the user to describe the
> encapsulation and for the driver to recognize it as the mirror header
> and offload properly. With some squinting: frankly I don't see anybody
> encoding things like queue depths, or anybody writing the driver code to
> recognize that indeed that's what it is.
>

You can define whatever metadata you want and make your datapath
generate it. As long as you also have a P4 program on the consumer to
decode it. My fingers cant resist, so let me show extract from a
simple test program we have for P4TC which transports skb->mark
between machines:

// define the headers
header customl2_t {
    bit<32> skbmark;
    bit<16> anothermetadatum
    bit<16> etherType;
}
..
struct headers_t {
    ethernet_t   ethernet;
    customl2_t   customl2;
    ipv4_t       ip;
    //rest is considered payload
}
...

//the parser
 ....
    state parse_ethernet {
        pkt.extract(hdr.ethernet);
        transition select(hdr.ethernet.etherType) {
            ETHERTYPE_IPV4: parse_ipv4;
            ETHERTYPE_CUSTOML2: parse_customl2;
            default: reject;
        }
    }
    state parse_customl2 {
        pkt.extract(hdr.customl2);
        transition select(hdr.customl2.etherType) {
            ETHERTYPE_IPV4: parse_ipv4;
            default: reject;
        }
    }
    state parse_ipv4 {
        pkt.extract(hdr.ip);
        transition accept;
    }

...

Then you have a match action table definition which in our case
matches on dst ip, but you can make it match whatever you want. Add a
couple of actions; one to push and another to pop the headers. Here's
one that pushes (not showing the other part that pops and sets
skb->mark):

action push_custom(@tc_type("macaddr") bit<48> dmac, @tc_type("dev")
PortId_t port)
         hdr.ethernet.dstAddr =3D dmac;
         hdr.customl2.etherType =3D hdr.ethernet.etherType;
         hdr.ethernet.etherType =3D ETHERTYPE_CUSTOML2;
         hdr.customl2.skbmark =3D meta.mark;
         hdr.customl2.setValid();
         send_to_port(port);
}

And at runtime:
tc p4ctrl create mycustoml2/table/mytable dstAddr 10.99.0.1/32 \
action push_custom param dmac 66:33:34:35:46:01 param port eno1

And when hw supports it, you could just say skip_sw above..
That's it - no need to argue about tomatos or tomateos on the mailing
list for the next 6 months or longer.

> >> >> In the particular case of mlxsw, we only permit adding one chain wi=
th
> >> >> one filter, which has to be a matchall, and the action has to be ei=
ther
> >> >> a mirred or trap, plus it needs to have hw_stats disabled. Because =
the
> >> >> HW is limited like that, it can't do much in that context.
> >> >>
> >> >
> >> > Understood. The challenge right now is we depend on a human to know
> >> > what the h/w constraints are and on misconfig you reject the bad
> >> > config. The other model is you query for the h/w capabilities and th=
en
> >> > only allow valid config (in case of skip_sw)
> >>
> >> This is not new with qevents though. The whole TC offload is an exerci=
se
> >> in return -EOPNOTSUPP. And half VXLAN, and IPIP, and, and. But I guess
> >> that's your point, that this sucks as a general approach?
> >
> > Current scheme works fine - and in some cases is unavoidable. In P4 it
> > is different because resources are reserved; so by the time the
> > request hits the kernel, the tc layer already knows if such a request
> > will succeed or not if sent to the driver. This would be hard to do if
> > you have dynamic clever resourcing where you are continuously
> > adjusting the hardware resources - either growing or shrinking them
> > (as i think the mlxsw works); in such a case sending to the driver
> > makes more sense.
>
> The HW does some of that, in the sense that there are shared tables used
> by various stages of the pipeline for different things, so more of one
> means less of another.

Makes sense. But assumedly in this case (for P4), you will know how
much to reserve for one thing or other. And let your compiler backend
decide what it means to allow 1024 table entries... IOW, it is not an
opportunistic/runtime-optimizing/best effort but rather
access-controlled approach.

>The driver is fairly simplistic though, most of
> the time anyway, and just configures what the user tells it to. The only
> exception might be ACLs, but even there it's nothing like noticing, oh,
> none of my rules so far uses header XYZ, so I can use this denser way of
> encoding the keys, to satisfy this request to cram in more stuff. If as
> a user you want this effect, you are supposed to use chain templates to
> give the driver a better idea of the shape of things to come.

Yes, that kind of optimization is one approach (but not the one taken
by the P4 spec).

> >> >> > lawyering): why was a block necessary? feels like the goto chain
> >> >> > action could have worked, no? i.e something like: qevent early_dr=
op
> >> >> > goto chain x.. Is the block perhaps tied to something in the h/w =
or is
> >> >> > it just some clever metainfo that is used to jump to tc block whe=
n the
> >> >> > exceptions happen?
> >> >>
> >> >> So yeah, blocks are super fancy compared to what the HW can actuall=
y do.
> >> >
> >> > My curiosity on blocks was more if the ports added to a block are
> >> > related somehow from a grouping perspective and in particular to the
> >> > h/w.
> >>
> >> Not necessarily. You could have two nics from different vendors with
> >> different offloading capabilities, and still share the same block with
> >> both, so long as you use the subset of features common to both.
> >
> > True, for the general case. The hard part is dealing with exceptions,
> > for example, lets say we have two vendors who can both mirror in
> > hardware:
> > if you have a rule to mirror from vendor A port 0 to vendor B port 1,
> > it cant be done from Vendor A's ASIC directly. It would work if you
> > made it an exception that goes via kernel and some tc chain there
> > picks it up and sends it to vendor B's port1. You can probably do some
> > clever things like have direct DMA from vendor A to B, but that would
> > be very speacilized code.
>
> Yep.
>
> >> > For example in P4TC, at a hardware level we are looking to use
> >> > blocks to group devices that are under one PCI-dev (PF, VFs, etc) -
> >> > mostly this is because the underlying ASIC has them related already
> >> > (and if for example you said to mirror from one to the other it woul=
d
> >> > work whether in s/w or h/w)
> >>
> >> Yeah, I've noticed the "flood to other ports" patches. This is an
> >> interesting use case, but not one that was necessarily part of the
> >> blocks abstraction IMHO. I think originally blocks were just a sharing
> >> mechanism, which was the mindset with which I worked on qevents.
> >
> > Basically now if you attach a mirror to a block all netdevs on that
> > block will receive a copy, note sure if that will have any effect on
> > what you are doing.
>
> I'm not sure what semantics of mirroring to a qevent block are, but
> beyond that, it shouldn't impact us. Such rule would be punted from HW
> datapath, because there's no netdevice, and we demand a netdevice (plus
> conditions on what the netdevice is allowed to be).

Ok, for the hardware path i guess it's however you abstract it. But if
someone did this in sw as such:
--
tc qdisc add dev ens10 egress_block 10 clsact
tc qdisc add dev ens9 egress_block 10 clsact
tc qdisc add dev ens8 egress_block 10 clsact
tc filter add block 22 protocol ip pref 25 \
  matchall action mirred egress mirror blockid 10
tc qdisc add dev eth0 parent 10:7 handle 107: red limit 1000000 min
500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent
early_drop block 22
---
Then all of ens8-10 will get a copy of the packet on the qevent.

> > Note:
> > Sharing of tables, actions, etc (or as P4 calls them
> > programs/pipelines) for all the ports in a block is still in play.
> > Challenge: assume vendor A from earlier has N ports which are part of
> > block 11: There is no need for vendor A's driver to register its tc
> > callback everytime one of the N ports get added into the block, one
> > should be enough (at least that is the thought process in the
> > discussions for offloads with P4TC).
> > Vendor A and B both register once, then you can replay the same rule
> > request to both. For actions that dont require cross-ASIC activity
> > (example a "drop")  it works fine because it will be localized.
>
> Sounds reasonable so far, but reads like something that misses a
> "however, consider" or "now the challenge is to" :)
>

Yeah, lots of discussions are still going on there in our biweekly meetings=
.

> >> >> Blocks have no such issues, they are self-contained. They are heavy
> >> >> compared to what we need, true. But that's not really an issue -- t=
he
> >> >> driver can bounce invalid configuration just fine. And there's no r=
isk
> >> >> of making another driver or SW datapath user unhappy because their =
set
> >> >> of constrants is something we didn't anticipate. Conceptually it's
> >> >> cleaner than if we had just one action / one rule / one chain, beca=
use
> >> >> you can point at e.g. ingress_block and say, this, it's the same as
> >> >> this, except instead of all ingress packets, only those that are
> >> >> early_dropped are passed through.
> >> >
> >> > /nod
> >> >
> >> >> BTW, newer Spectrum chips actually allow (some?) ACL matching to ru=
n in
> >> >> the qevent context, so we may end up relaxing the matchall requirem=
ent
> >> >> in the future and do a more complex offload of qevents.
> >> >
> >> > In P4 a lot of this could be modelled to one's liking really - but
> >> > that's a different discussion.
> >>
> >> Pretty sure :)
> >>
> >> BTW Spectrum's ACLs are really fairly close to what flower is doing.
> >> At least that's the ABI we get to work with. Not really a good target
> >> for u32 at all. So I suspect that P4 would end up looking remarkably
> >> flower-like, no offsets or layouts, most of it just pure symbolics.
> >>
> >
> > Its a "fixed" ASIC, so it is expected. But: One should be able to
> > express the Spectrum's ACLs or even the whole datapath as a P4 program
>
> Yeah, I think so, too.
>
> > and i dont see why it wouldnt work with P4TC. Matty has at least once
> > in the past, if i am not mistaken, pitched such an idea.
>
> I don't see why it wouldn't work. What I'm saying is that at least the
> ACL bits will just look fairly close to flower, because that's the HW we
> are working with. And then the benefits of P4 are not as clear, because
> flower is already here and also looks like flower.
>

That's fine mostly because the ASIC doesnt change once it is cast. If
however you want to expose a new field that the ASIC already supports,
the problem with flower is it is a "fixed datapath". Adding another
header requires changing the kernel (tc and flowdisector, driver) and
iproute2..

> On the upside, we would get more flexibility with different matching
> approaches. Mixing different matchers is awkward (say flower + basic
> might occasionally be useful), so there's this tendency to cram
> everything into flower.
>

It's a good hammer and if a lot of things can be imagined to be nails,
it works great ;->

> I mentioned the mirror headers above, that's one area where TC just
> doesn't have the tools we need.
>

Agreed - but with P4 you have a way out IMO.

> >> >> >> > Also: Is it only Red or other qdiscs could behave this way?
> >> >> >>
> >> >> >> Currently only red supports any qevents at all, but in principle=
 the
> >> >> >> mechanism is reusable. With my mlxsw hat on, an obvious next can=
didate
> >> >> >> would be tail_drop on FIFO qdisc.
> >> >> >
> >> >> > Sounds cool. I can see use even for s/w only dpath.
> >> >>
> >> >> FIFO is tricky to extend BTW. I wrote some patches way back before =
it
> >> >> got backburner'd, and the only payloads that are currently bounced =
are
> >> >> those that are <=3D3 bytes. Everything else is interpreted to mean
> >> >> something, extra garbage is ignored, etc. Fun fun.
> >> >
> >> > FIFO may have undergone too many changes to be general purpose anymo=
re
> >> > (thinking of the attempts to make it lockless in particular) but I
> >> > would think that all you need is to share the netlink attributes wit=
h

> >> > the h/w, no? i.e you need a new attribute to enable qevents on fifo.
> >>
> >> Like the buffer model of our HW is just wildly incompatible with qdisc=
s'
> >> ideas. But that's not what I wanted to say. Say you want to add a new
> >> configuration knob to FIFO, e.g. the tail_drop qevent. How do you
> >> configure it?
> >>
> >> For reasonable qdiscs it's a simple matter of adding new attributes. B=
ut
> >> with FIFO, there _are_ no attributes. It's literally just if no nlattr=
,
> >> use defaults, otherwise bounce if the payload size < 4, else first 4
> >> bytes are limit and ignore the rest. Done & done. No attributes, and
> >> nowhere to put them in a backward compatible manner. So extending it i=
s
> >> a bit hacky. (Can be done safely I believe, but it's not very pretty.)
> >
> > I believe you but will have to look to make sense. There's at least
> > one attribute you mention above carried in some data structure in a
> > TLV (if i am not mistaken it is queue size either in packet or bytes,
> > depending on which fifo mode you are running). You are saying you cant
> > add another one or a flag at least?
>
> Not backward-compatibly. The sole attribute's payload is interpreted as
> follows:
>

Ok, just took a quick look..
> - length<4? Bounce.
> - length>=3D4? First u32 is queue limit, the rest is ignored garbage.

I think you mean this part:
                struct tc_fifo_qopt *ctl =3D nla_data(opt);

                if (nla_len(opt) < sizeof(*ctl))
                        return -EINVAL;

                sch->limit =3D ctl->limit;

Yeah, cant stash a new attribute there unfortunately. TCA_OPTIONS only
has tc_fifo_qopt. Would have been easier if TCA_OPTIONS was nested
(like other qdiscs such as TBF) - then you could add a new TLV.

> So you have to stash any new stuff into the now-ignored garbage, thus
> changing behavior. The I-think-safe approach that I mention above is
> passing limit=3D0 and serializing the real attribute tree into the garbag=
e
> area. So if limit=3D0 and the garbage parses as an atrribute tree, use
> that, otherwise it's really just limit of 0 and some garbage.
>
> I think this is safe, because the combination of limit=3D0 (already an
> improbable configuration) and parseable garbage is unlikely to arise by
> mistake. But it's kludgy.
>
> Or maybe the flag could be in the message header, but that seems wrong
> given we are talking about extending one qdisc kind.

I can see the dilema - and if i understood correctly what you are
suggesting, something like:

if (nla_len(opt) =3D=3D sizeof(*ctl))
    do the old thing here
else if (nla_len(opt) =3D=3D sizeof(*mynewstruct)
   do the new thing here
else
      invalid..


cheers,
jamal

