Return-Path: <netdev+bounces-22338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEDD7670F3
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A59E2827BD
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDFE14279;
	Fri, 28 Jul 2023 15:49:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B4134B0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961F1C433C7;
	Fri, 28 Jul 2023 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690559343;
	bh=lxqglJYknCo8CfWOKOayQXUGyKrV7uOvRItRobwjvUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iabOlKeqBc2naHOaAS/tt6fMJ8hiRHkxEppX+IghDbdeQ2DDQFMISlGVctK3nTh5I
	 Z7jVktei7DooTU4MVtVEhpfdjAnIXtmn2kAKMpFWto4HV5/mK8VxsYBKSNNOCp4Eoq
	 /kM/oQ3yIdj59Ksfl1NRPh3m9/V6y6BpOxz5yEcf4LG2oa5++EMtgDFGDv52K9ZR8I
	 J7b9W6c4PvnnX70Bac9KX5PMVJbpNCZNoRhrKtkNS/jSCsZDLQ6TcbfGbpGaeg9Trs
	 CdzOE5z4BtPl99b2U66H5yzXynQ5gmXAMWQFtBYXv7k0c6DguR6w6KKls0ch21JUv/
	 essPJy2YbVnQg==
Date: Fri, 28 Jul 2023 08:49:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v2 0/2] tools/net/ynl: enable json
 configuration
Message-ID: <20230728084902.1dd524c5@kernel.org>
In-Reply-To: <908e8567-05c8-fb94-5910-ecbee16eb842@redhat.com>
References: <20230727120353.3020678-1-mtahhan@redhat.com>
	<20230727173753.6e044c13@kernel.org>
	<908e8567-05c8-fb94-5910-ecbee16eb842@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Jul 2023 11:24:51 +0100 Maryam Tahhan wrote:
> On 28/07/2023 01:37, Jakub Kicinski wrote:
> > On Thu, 27 Jul 2023 08:03:29 -0400 Maryam Tahhan wrote: =20
> >> Use a json configuration file to pass parameters to ynl to allow
> >> for operations on multiple specs in one go. Additionally, check
> >> this new configuration against a schema to validate it in the cli
> >> module before parsing it and passing info to the ynl module. =20
> > Interesting. Is this related to Donald's comments about subscribing
> > to notifications from multiple families?
> >
> > Can you share some info about your use case? =20
>=20
>=20
> Yes it's related. We are working towards using YNL as a netlink agent or=
=20
> part of a netlink agent that's driven by YAML specs. We are
>=20
> trying to enable existing Kubernetes CNIs to integrate with DPUs via an=20
> OPI [1] API without having to change these existing CNIs. In several
>=20
> cases these CNIs program the Kernel as both the control plane and the=20
> fallback dataplane (for packets the DPU accelerator doesn't know what
> to do with). And so being able to monitor netlink state and reflect it=20
> to the DPU accelerator (and vice versa) via an OPI API would be=20
> extremely useful.
>=20
>=20
> We think the YAML part gives us a solid model that showcases the breadth=
=20
> of what these CNIs program (via netlink) as well as a base for the grpc=20
> protobufs that the OPI API would like to define/use.

So agent on the host is listening to netlink and sending to DPU gRPC
requests? From what you're describing it sounds like you'd mostly want
to pass the notifications. The multi-command thing is to let the DPU
also make requests if it needs to do/know something specific?

> >> Example configs would be:
> >>
> >> {
> >>      "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
> >>      "spec-args": {
> >>          "ethtool.yaml": {
> >>              "do": "rings-get",
> >>              "json-params": {
> >>                  "header": {
> >>                      "dev-name": "eno1"
> >>                  }
> >>              }
> >>          },
> >>         "netdev.yaml": {
> >>              "do": "dev-get",
> >>              "json-params": {
> >>              "ifindex": 3
> >>              }
> >>          }
> >>      }
> >> } =20
> > Why is the JSON preferable to writing a script to the same effect?
> > It'd actually be shorter and more flexible.
> > Maybe we should focus on packaging YNL as a python lib? =20
>=20
> I guess you can write a script. The reasons I picked JSON were mainly:
>=20
> -=C2=A0 Simplicity and Readability for both developers and non-developers=
/users.
>=20
> - With the JSON Schema Validation I could very quickly validate the=20
> incoming configuration without too much logic in cli.py.
>=20
> - I thought of it as a stepping stone towards an agent configuration=20
> file if YNL evolves to provide or be part of a netlink agent (driven by=20
> yaml specs)...

Those are very valid. My worry is that:
 - it's not a great fit for asynchronous stuff like notifications
   (at least a simple version built directly from cli.py)
 - we'd end up needing some flow control and/or transfer of values
   at some point, and it will evolve into a full blown DSL

> >> OR
> >>
> >> {
> >>      "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
> >>      "spec-args": {
> >>          "ethtool.yaml": {
> >>              "subscribe": "monitor",
> >>              "sleep": 10
> >>          },
> >>          "netdev.yaml": {
> >>              "subscribe": "mgmt",
> >>              "sleep": 5
> >>          }
> >>      }
> >> } =20
> > Could you also share the outputs the examples would produce?
> > =20
> Right now the output is simple, an example would be for the first config=
=20
> in the email:
>=20
> [ linux]# ./tools/net/ynl/cli.py --config ./tools/net/ynl/multi-do.json
> ###############=C2=A0 ethtool.yaml=C2=A0 ###############
>=20
> {'header': {'dev-index': 3, 'dev-name': 'eno1'},
>  =C2=A0'rx': 512,
>  =C2=A0'rx-max': 8192,
>  =C2=A0'rx-push': 0,
>  =C2=A0'tx': 512,
>  =C2=A0'tx-max': 8192,
>  =C2=A0'tx-push': 0}
> ###############=C2=A0 netdev.yaml=C2=A0 ###############
>=20
> {'ifindex': 3, 'xdp-features': {'xsk-zerocopy', 'redirect', 'basic'}}

My concern was that this will not be optimal for the receiver to parse.
Because the answer is not valid JSON. We'd need something like:

[
 { "cmd-id": "some-identifier?".
   "response": { ... }
 },
 { "cmd-id": "identifier-of-second-command".
   "response": { ... }
 }
]

> Or for the second config in the email (note: I just toggled the tx ring=20
> descriptors on one of my NICs to trigger an ethtool notification):
>=20
> [root@nfvsdn-06 linux]# ./tools/net/ynl/cli.py --config=20
> ./tools/net/ynl/multi-ntf.json
> ###############=C2=A0 ethtool.yaml=C2=A0 ###############
>=20
> [{'msg': {'header': {'dev-index': 3, 'dev-name': 'eno1'},
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'rx': 512,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'rx-max': 8192,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'rx-push': 0,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'tx': 8192,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'tx-max': 8192,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'tx-push': 0},
>  =C2=A0 'name': 'rings-ntf'}]
> ###############=C2=A0 netdev.yaml=C2=A0 ###############
>=20
> []
>=20
> At the moment (even with these changes) YNL subscribes-sleeps-checks for=
=20
> notification for each family sequentially...
> I will be looking into enabling an agent like behaviour: subscribe to=20
> notifications from multiple families and monitor (babysteps)....
>=20
> [1] https://opiproject.org/

Modulo the nits it sounds fairly reasonable. Main question is how much
of that we put in the kernel tree, and how much lives elsewhere :S
If we have a dependency on gRPC at some point, for example, that may
be too much for kernel tools/

