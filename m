Return-Path: <netdev+bounces-289495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A49HrOGDGpMiwUAu9opvQ
	(envelope-from <netdev+bounces-289495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:50:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B60581BF4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4578309D4B3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842C534040F;
	Tue, 19 May 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vg089zLB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D225403EBD
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203896; cv=none; b=PpZ6UI7R1J4LzxNkU1u7JfsS6+EeISqZmiYzbK5tqAtiNdniVNYGQWneKTpVYJTak0vf7uCzknRu9A8fsLHd+FgNmItB2jGuqMojulX2sSpWwByp3ed2nQCXOqwvuV1sLrlpkVsYd+Anej2QVPKqS7Vcz0gQK9d/KoFZZfdVj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203896; c=relaxed/simple;
	bh=4RTPehjCFlvtgU6uh7JhsSqvif2rRRuppKLugeOaSPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGjn6nDJkU4qNtdL4dZTwZgrIAPbpSPTzVMpNrFpEwens62EeTdOUhLBxRpY36qo1pn4Be1fkywHGrHN+C1NWj/9l9uoDDXwZAEAVtFZ606BB3QxSb1W1AOKViH7Wl8y6phoV4Qx5Agwdv95dCRLcQnJgX0m8mj+9DDBtQNzRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vg089zLB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779203892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQZ+RP6K2x79z/nt8Ck0Ogs2qHEqVQNPlYSy8b8wSyA=;
	b=Vg089zLB+JnZ7kFCHkKb3vChiAipU2i74oLNWfDL/nTt8V/rOJ/R50fY+QX1YGoffM6bu0
	2qFBoPZvdNYEe3QXkurZuFmeO4v25b3J8zduc9aWdqyoOVHmuVXH+2z/1QlvDBoc0FbYtX
	2TyzD9xbj5XN0MfLg7v/Bj6ZqZYtjeA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-vzCW5LwqN4KHumqtEmWvNw-1; Tue,
 19 May 2026 11:18:09 -0400
X-MC-Unique: vzCW5LwqN4KHumqtEmWvNw-1
X-Mimecast-MFC-AGG-ID: vzCW5LwqN4KHumqtEmWvNw_1779203887
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B0D7195605A;
	Tue, 19 May 2026 15:18:07 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.89.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD2AD19560A2;
	Tue, 19 May 2026 15:18:03 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,
  echaudro@redhat.com,  i.maximets@ovn.org,  i.maximets@redhat.com,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org
Subject: Re: [PATCH net-next 0/5] selftests: openvswitch: pylint cleanup for
 ovs-dpctl.py
In-Reply-To: <CAJ0BgHcq9Qs__f53kcNzG1+qYXvHP2_q1+mk8=z1Fo3TNY9W8g@mail.gmail.com>
	(=?utf-8?B?IuS+r+aVj+eGmSIncw==?= message of "Fri, 15 May 2026 16:47:47
 +0800")
References: <20260513121240.2590767-1-houminxi@gmail.com>
	<f7tzf21noy8.fsf@redhat.com>
	<CAJ0BgHcq9Qs__f53kcNzG1+qYXvHP2_q1+mk8=z1Fo3TNY9W8g@mail.gmail.com>
Date: Tue, 19 May 2026 11:18:02 -0400
Message-ID: <f7to6ib8m39.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289495-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovs-dpctl.py:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 16B60581BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E4=BE=AF=E6=95=8F=E7=86=99 <houminxi@gmail.com> writes:

> Hello Aaron
>
> Thanks for the suggestion, Aaron.  I dug into this a bit and I think
> it's worth doing.
>
> The good news is that 3 of 4 OVS families already have ynl specs
> in-tree (ovs_datapath, ovs_flow, ovs_vport).  The flow spec is pretty
> thorough -- covers all the key/action/tunnel nested attrs.  pyynl
> handles genetlink, dump, and nested encode/decode, so the library side
> looks solid.  There's even an OVS C sample under tools/net/ynl/samples/.
>
> Gaps I found:
>
>   - No ovs_packet.yaml spec.  We'd need to write one for upcall
>     handling (MISS/ACTION/EXECUTE).  Shouldn't be too bad, maybe
>     100 lines based on the other specs.
>
>   - The existing specs are missing a few operation defs (flow DEL/SET,
>     vport SET, datapath SET).  Small additions.
>
>   - ovs-dpctl.py also uses pyroute2.iproute for tunnel interface
>     creation and NDB for interface lookup.  Those aren't OVS netlink,
>     so we'd either keep a minimal pyroute2 dep for just that or
>     shell out to `ip`.

We could also add support for using just a direct netlink socket to
query for interfaces.  This means we would not need to shell out to
iproute2 binary.  But I think if iproute2 isn't available then the
selftests would also not pass, so subprocess is probably okay.

>   - The ODP string parser (~1500 lines for flow key/action encoding)
>     is orthogonal to the netlink wire format, so that stays regardless.
>
> I think the natural order would be: start with datapath ops (simplest,
> spec already complete), then vport, then flow (bulk of the work), then
> packet/upcall after writing the spec.  The f-string fixes from my
> current series still apply.
>
> Minxi
>
> Aaron Conole <aconole@redhat.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=94 14:53=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Minxi Hou <houminxi@gmail.com> writes:
>>
>> > This series cleans up all pylint warnings in ovs-dpctl.py,
>> > bringing the score from 7.62/10 to 10.00/10.
>> >
>> > This series applies on top of:
>> >   [PATCH net-next v10 1/2] selftests: openvswitch: add vlan() and
>> >   encap() flow string parsing
>> >   https://lore.kernel.org/netdev/20260512070841.1183581-2-houminxi@gma=
il.com/
>> >
>> > Patch 1 converts 86 %-format strings to f-strings.
>> > Patch 2 fixes misc warnings (unused import, bare except, unused
>> > variables, redundant expressions).
>> > Patch 3 renames classes to PascalCase and variables to snake_case.
>> > Patch 4 adds one-line docstrings to all definitions.
>> > Patch 5 suppresses complexity warnings from pyroute2 constraints.
>> >
>> > Tested with vng on x86_64, all OVS selftests pass.
>> >
>> > Minxi Hou (5):
>> >   selftests: openvswitch: convert %-formatting to f-strings
>> >   selftests: openvswitch: fix misc pylint warnings in ovs-dpctl.py
>> >   selftests: openvswitch: rename classes and variables in ovs-dpctl.py
>> >   selftests: openvswitch: add missing docstrings in ovs-dpctl.py
>> >   selftests: openvswitch: suppress pylint complexity warnings
>> >
>> >  .../selftests/net/openvswitch/ovs-dpctl.py    | 794 ++++++++++--------
>> >  1 file changed, 428 insertions(+), 366 deletions(-)
>>
>> Thinking about this series, it might be better to go a bit further and
>> just drop the pyroute2 in favor of using ynl to generate the netlink
>> encode/decode.  The value that ovs-dpctl.py brings is the ability to
>> interoperate with the ovs-vswitchd odp encoding.  That we are using
>> pyroute2 to do the actual 'wire' format of netlink is incidental.
>>
>> Some of the work would still be needed (I think some of the f-string
>> adjustments) but that would allow trimming a good chunk of the code and
>> let us just rely on the in-tree ynl rather than pyroute2 dependency.
>>
>> WDYT?  Ilya and I can work with you offline if you are interested in
>> pursuing this approach.  I think it should make the overall code much
>> better to work with, too.
>>


