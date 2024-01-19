Return-Path: <netdev+bounces-64397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13922832D81
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788B1B2365E
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F36C54FB2;
	Fri, 19 Jan 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qm/BTZl8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7852F84
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683062; cv=fail; b=YbVLUhA/+vALRiL3sejZBveV7ur2Dyrka5bkVOQanfVdyBnhqiDb0OQHwwavWVtMNxiQduHL4PZ3+vThKI3yfnSp8RlVXX9fOMIntRMG7e1zGlAzKM1JVLVYkQ0tfTGx9Mm9dFZdzLZyr2d57pGiOxLOokqWo/UPrjlU3HUxfaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683062; c=relaxed/simple;
	bh=MWaqF3n47YbOe+4l0VqPlS5Z7EjnihIrHDxC8ogISTc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tslTKJGnJYzg3ebj72L4F9LcdtSHRix3WKoqgEu/G2p80jviazE2E7KWQGBXisYmwhv8hOStoWrbdx/EFigemPbCdOPSH+8X78lFCsS9Lfi8AveqHRUSYgpZsaRvnxpoxUiRE5zN8yoa0QOq0riXsOvnX780h/b0giytRWY6p20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qm/BTZl8; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVhTjLw1Cv1YnGhc0Anw0GcmRa2a76n3WRJMK40+mwqvG0ZusC462aJiqm1oGc97b0VvQARBbn6b7hvKE2Yrl2+h7tLXjEZxWyy1ThZsaDrEF1aPqNwBhvMb9jUFvkg7pqC30ncYyH8cX4seuehkwCvqPnAxvUzFvESwg5WWYAtPb6+7lID31afRA+3RkSVyRD9VmpKa5zVLUmCaxmWwaRWXUFnbKHdT0GC/YjKhZP+a+H3tefApuBiCUmkdBRLKA1D8f2IvwFbi6GEHYqbQPIOgNhd5C93R1onvvJaUT/Z06wQsUBP39G1FIoPosjvi4N5W20vsdFk2a5Jx1FUB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HbrACOxxGwjdWY0b1zq/cdWctyg9x8tNgC0rV9BsQs=;
 b=ePoXzW0GGz/hlwzjkeIXJHqP6dlGLNht5Toi6vsaj1Dpp3Dw8OXfR0o0V+2ciLzXVwiWXF7u1Et2JIDPs9ys9l/mgLQkMMoebt2U/jUZPmSk0vbEEU4T+PPCd2c+AlFk5kpjl0AGFtokjeP2+Xui+wOEex7M6ZoYQQEAGdAbL6ADCnbUamRuLTjzPQaPPIRjM3Hat98YjKUgXeMFH1mubdGxot7OdKCshMBcOJGSrudFbIoVHy3UZOIyii/BV1+/9F2A+wU1eQYvP40PkqGehe/qQz9XP2ag/f7XycTWvS/K1njrPTH/ZWfYX+ERIK9LNNmqd0k8+KwEIRFLhcuEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HbrACOxxGwjdWY0b1zq/cdWctyg9x8tNgC0rV9BsQs=;
 b=qm/BTZl8+v+GcIqQK7JnHcsyJEw6jdD68yLsZnbnA1oFIYzt4XSYV1NttFmocafKN9ReiDXl7NBvhpBdauS6cSsjV7juodroXe4MQCrhvJTPnpDzgxmam6u5lxlyB50xUpa4Rd2r4kzlbIJwF1dKoXhq/MVj3Ov8uI8r4wC7NwO8NMFCtXh7k3uip2ae5PN5q3jMWGYlNuNnW7hswcDi9oXVovFGaabm2eqHVzCzW6XRRrMTGTZQ3kiP0lgsFWm20wmVf6yjV8O5uquYkzu+6Gbo4Lsn6RrOuwbVuJoLmh5Bij2IkKnRiuFgGou6/OKzCF+fQXpwn7Mdn07NVRD1cA==
Received: from MN2PR19CA0022.namprd19.prod.outlook.com (2603:10b6:208:178::35)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 16:50:57 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:178:cafe::a7) by MN2PR19CA0022.outlook.office365.com
 (2603:10b6:208:178::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 16:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 16:50:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 19 Jan
 2024 08:50:35 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 19 Jan
 2024 08:50:31 -0800
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
 <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
 <878r4volo0.fsf@nvidia.com>
 <CAM0EoMkFkJBGc5wsYec+1QZ_o6tEi6vm_KjAJV8SWB4EOPcppg@mail.gmail.com>
 <87zfxbmp5i.fsf@nvidia.com>
 <CAM0EoMmC1z9SzF7zNtquPinBDr3Zu-wfKKRU0CMK3SP4ZobOsg@mail.gmail.com>
 <87v87ymqzq.fsf@nvidia.com>
 <CAM0EoMmLhg7DW4qOT0FZTpYN5rFX+406oNY3-wZv98td4X4Uhg@mail.gmail.com>
 <875xztmqoz.fsf@nvidia.com>
 <CAM0EoM=g23GRRK-OfRijmqv_deaW1VvytykwawdJ+rk1MseCOA@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: Petr Machata <petrm@nvidia.com>, Petr Machata <me@pmachata.org>, "Ido
 Schimmel" <idosch@idosch.org>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <xiyou.wangcong@gmail.com>,
	<victor@mojatatu.com>, <pctammela@mojatatu.com>, <mleitner@redhat.com>,
	<vladbu@nvidia.com>, <paulb@nvidia.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Date: Fri, 19 Jan 2024 17:28:36 +0100
In-Reply-To: <CAM0EoM=g23GRRK-OfRijmqv_deaW1VvytykwawdJ+rk1MseCOA@mail.gmail.com>
Message-ID: <874jf9jmi3.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: c39e38c0-28e3-4211-5979-08dc190ece70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t4isZFUa7R2hVzZqCE1S9ErmgeREg7zPeStCvj87F4Bj6N3baMWclOmA1dBWn97I6rDuXKRqUrWPMMkiKg8RIzS8bElU8nfzSGEN+AH5bi18/O3/q/Kx1k8XUAo3qlwKchO8dotvXt8gxihFrPVqS2OFq4fe3EdhfUIDXjt4rkqQuJNEZu0q3eNyT3Chf8wfsMEXn4CCcpEuOfjnYGdDb89+sEoIH3MulAHbn5bps9M7tYzHRi71LZRazBxDeLF1fkNkylVnsOEDmeJnM4bT0C1Z87Zm5XcvrffiREff5jytiY+iMQS42ma26VNsRQ+L2MzY+72aUreKfyouXf0K0oQ9U1hDIQNXe169OcHVIIaafiEZWaplJ77CbtUbpHFBp43d8MX9aG2VJJuzBLpAsAQvbUFcJhbDAnXT4HEdVhIMsDHMONIKQF0dPFt1BBG+HE7hNlcJAQDp+SiJ/7iUUvfebATX9uvpHp7QxdrDTMO+6ebT1OGxvvrM1AYWAFNebhzhUN/baLAwki+rOVjyk6XIhk0qc6gX78zbLCuBvh4L0EvSr837ufMgNoiONQNFmH8KXFtfQFvD7F2PV1AgQ4/AJIQys6qPOc953SNZEw+kx9EBreXeAunna0pex1I0SvakagngwHy/IF9nH3eRB+hSsKmiLMf+CzW8qAtF5CxeClYFhzi8mzwrTKFIKtaQyW0OPeANnbq8B8t6Raa6LzE20S8Z1Be0D+gKxulb06wNdXHmrjj4DvvzT/pbB6qm
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(53546011)(36860700001)(426003)(336012)(107886003)(16526019)(2616005)(26005)(86362001)(36756003)(7636003)(356005)(82740400003)(41300700001)(8676002)(4326008)(316002)(8936002)(47076005)(30864003)(7416002)(5660300002)(2906002)(83380400001)(478600001)(54906003)(70206006)(70586007)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 16:50:56.1286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39e38c0-28e3-4211-5979-08dc190ece70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843


Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Tue, Jan 16, 2024 at 7:03=E2=80=AFAM Petr Machata <petrm@nvidia.com> w=
rote:
>>
>> Spectrum supports these mirror headers. They are sandwiched between the
>> encapsulation headers of the mirrored packets and the actual packet, and
>> tell you the RX and TX ports, what was the mirror reason, some
>> timestamps, etc. Without this, you need to encode the information into
>> like parts of IPv6 or what not.
>>
>> But it's a proprietary format. It could be expressed as a netdevice, or
>> maybe a special version in the ERSPAN netdevice. But there's no
>> standard, or public documentation, no open source tools that would
>> consume it. AFAIK. So adding code to ERSPAN to support it looks like a
>> non-starter.
>
> This is the kind of problem that P4 is well suited to solve. We are
> stuck with current kernel implementations and current standards.
> Spectrum can do so much more than the current ERSPAN standard
> provides. It can do so much more than the current kernel code can
> express. I am sure there are at least 5 people who want this feature
> we are talking about but status quo says the only choice to make this
> acceptable is to convince the masses (meaning likely years of chasing)
> and do the ERSPAN standard mods alongside kernel and user space
> implementation. And then in standards bodies like IEEE, IETF, etc you
> politik to death trying to get people to sign onto your proposal with
> +1s (sorry for the rant, but it is one reason i stopped going there).
> Alternatively, just have those 5 people write a P4 program in a very
> short time and not bother anybody else...
>
>> I was also toying with approaches around some push_header action, but it
>> all seemed too clumsy. Also unclear how to express things like
>> timestamps, port labels, mirror reasons, latency, queue depths... It's
>> very, very HW-oriented header.
>>
>
> So at one point Yotam Gigi was trying to use IFE for i think this,
> which makes sense since you can add arbitrary metadata after the
> ethernet header and transport it to a remote machine on the wire or
> terminate on local cpu. You may want to look at that again because he

I did look at IFE way back, but it looks like I should do that again.

> seemed to think it works closely to the h/w approach. Of course it
> suffers from the same "fixed implementation" so both the producer and
> consumer would have to be taught what those metadatum mean i.e the
> kernel and iproute2 code updates will be required. IIRC, the Cumulus
> people pushed back and converted this into traps coming out of the
> spectrum in order to make use of standardized tooling to avoid
> retraining (I think it was sflow as the consumer).
>
>> I suppose with P4 there might be a way for the user to describe the
>> encapsulation and for the driver to recognize it as the mirror header
>> and offload properly. With some squinting: frankly I don't see anybody
>> encoding things like queue depths, or anybody writing the driver code to
>> recognize that indeed that's what it is.
>
> You can define whatever metadata you want and make your datapath
> generate it. As long as you also have a P4 program on the consumer to
> decode it. My fingers cant resist, so let me show extract from a
> simple test program we have for P4TC which transports skb->mark
> between machines:
>
> // define the headers
> header customl2_t {
>     bit<32> skbmark;
>     bit<16> anothermetadatum
>     bit<16> etherType;
> }
> ..
> struct headers_t {
>     ethernet_t   ethernet;
>     customl2_t   customl2;
>     ipv4_t       ip;
>     //rest is considered payload
> }
> ...

So let's talk about the queue depth in particular. How would the driver
recognize the field? Does it need to "parse the parser" to figure it
out? Or use magic field names? Use EtherType to just know what is meant
by the header? I don't see how to express the idea in the abstract, for
the driver to recognize it and say, yeah, we can in fact offload this
program, because it the abstract description matches what the HW is
doing for mirror headers version XYZ.

> //the parser
>  ....
>     state parse_ethernet {
>         pkt.extract(hdr.ethernet);
>         transition select(hdr.ethernet.etherType) {
>             ETHERTYPE_IPV4: parse_ipv4;
>             ETHERTYPE_CUSTOML2: parse_customl2;
>             default: reject;
>         }
>     }
>     state parse_customl2 {
>         pkt.extract(hdr.customl2);
>         transition select(hdr.customl2.etherType) {
>             ETHERTYPE_IPV4: parse_ipv4;
>             default: reject;
>         }
>     }
>     state parse_ipv4 {
>         pkt.extract(hdr.ip);
>         transition accept;
>     }
>
> ...
>
> Then you have a match action table definition which in our case
> matches on dst ip, but you can make it match whatever you want. Add a
> couple of actions; one to push and another to pop the headers. Here's
> one that pushes (not showing the other part that pops and sets
> skb->mark):
>
> action push_custom(@tc_type("macaddr") bit<48> dmac, @tc_type("dev")
> PortId_t port)
>          hdr.ethernet.dstAddr =3D dmac;
>          hdr.customl2.etherType =3D hdr.ethernet.etherType;
>          hdr.ethernet.etherType =3D ETHERTYPE_CUSTOML2;
>          hdr.customl2.skbmark =3D meta.mark;
>          hdr.customl2.setValid();
>          send_to_port(port);
> }
>
> And at runtime:
> tc p4ctrl create mycustoml2/table/mytable dstAddr 10.99.0.1/32 \
> action push_custom param dmac 66:33:34:35:46:01 param port eno1
>
> And when hw supports it, you could just say skip_sw above..
> That's it - no need to argue about tomatos or tomateos on the mailing
> list for the next 6 months or longer.

OK, thanks for the primer, I'll try to carve out some time to look at it
more closely.

>> I'm not sure what semantics of mirroring to a qevent block are, but
>> beyond that, it shouldn't impact us. Such rule would be punted from HW
>> datapath, because there's no netdevice, and we demand a netdevice (plus
>> conditions on what the netdevice is allowed to be).
>
> Ok, for the hardware path i guess it's however you abstract it. But if
> someone did this in sw as such:
> --
> tc qdisc add dev ens10 egress_block 10 clsact
> tc qdisc add dev ens9 egress_block 10 clsact
> tc qdisc add dev ens8 egress_block 10 clsact
> tc filter add block 22 protocol ip pref 25 \
>   matchall action mirred egress mirror blockid 10
> tc qdisc add dev eth0 parent 10:7 handle 107: red limit 1000000 min
> 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent
> early_drop block 22
> ---
> Then all of ens8-10 will get a copy of the packet on the qevent.

I meant the other way around. Say someone mirrors to blockid 22.
Does the packet go to eth0?

> > > Its a "fixed" ASIC, so it is expected. But: One should be able to
> > > express the Spectrum's ACLs or even the whole datapath as a P4 program
> >
> > Yeah, I think so, too.
> >
> > > and i dont see why it wouldnt work with P4TC. Matty has at least once
> > > in the past, if i am not mistaken, pitched such an idea.
> >
> > I don't see why it wouldn't work. What I'm saying is that at least the
> > ACL bits will just look fairly close to flower, because that's the HW we
> > are working with. And then the benefits of P4 are not as clear, because
> > flower is already here and also looks like flower.
>
> That's fine mostly because the ASIC doesnt change once it is cast. If
> however you want to expose a new field that the ASIC already supports,
> the problem with flower is it is a "fixed datapath". Adding another
> header requires changing the kernel (tc and flowdisector, driver) and
> iproute2..
>
> > On the upside, we would get more flexibility with different matching
> > approaches. Mixing different matchers is awkward (say flower + basic
> > might occasionally be useful), so there's this tendency to cram
> > everything into flower.
> >
>=20
> It's a good hammer and if a lot of things can be imagined to be nails,
> it works great ;->
>=20
> > I mentioned the mirror headers above, that's one area where TC just
> > doesn't have the tools we need.
> >
>=20
> Agreed - but with P4 you have a way out IMO.

Yeah, that's why I'm mentioning it. Those mirror headers are the closest
to where we would want... P4 or something P4-ish, to have the sort of
flexibility we need. Because the alternatives are non-starters.
(Though I'll check out IFE once more.)

> > > I believe you but will have to look to make sense. There's at least
> > > one attribute you mention above carried in some data structure in a
> > > TLV (if i am not mistaken it is queue size either in packet or bytes,
> > > depending on which fifo mode you are running). You are saying you cant
> > > add another one or a flag at least?
> >
> > Not backward-compatibly. The sole attribute's payload is interpreted as
> > follows:
> >
>=20
> Ok, just took a quick look..
> > - length<4? Bounce.
> > - length>=3D4? First u32 is queue limit, the rest is ignored garbage.
>=20
> I think you mean this part:
>                 struct tc_fifo_qopt *ctl =3D nla_data(opt);
>=20
>                 if (nla_len(opt) < sizeof(*ctl))
>                         return -EINVAL;
>=20
>                 sch->limit =3D ctl->limit;
>=20
> Yeah, cant stash a new attribute there unfortunately. TCA_OPTIONS only
> has tc_fifo_qopt. Would have been easier if TCA_OPTIONS was nested
> (like other qdiscs such as TBF) - then you could add a new TLV.

Yep.

> > So you have to stash any new stuff into the now-ignored garbage, thus
> > changing behavior. The I-think-safe approach that I mention above is
> > passing limit=3D0 and serializing the real attribute tree into the garb=
age
> > area. So if limit=3D0 and the garbage parses as an atrribute tree, use
> > that, otherwise it's really just limit of 0 and some garbage.
> >
> > I think this is safe, because the combination of limit=3D0 (already an
> > improbable configuration) and parseable garbage is unlikely to arise by
> > mistake. But it's kludgy.
> >
> > Or maybe the flag could be in the message header, but that seems wrong
> > given we are talking about extending one qdisc kind.
>=20
> I can see the dilema - and if i understood correctly what you are
> suggesting, something like:
>=20
> if (nla_len(opt) =3D=3D sizeof(*ctl))
>     do the old thing here
> else if (nla_len(opt) =3D=3D sizeof(*mynewstruct))
>     do the new thing here
> else
>     invalid..

Basically this, but handle the case that a broken userspace is sending
payload such that (nla_len(opt) =3D=3D sizeof(*mynewstruct)), but only
provides the first four bytes with the queue limit, and the rest is
garbage.

