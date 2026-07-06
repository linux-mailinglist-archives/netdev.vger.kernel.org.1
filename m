Return-Path: <netdev+bounces-305095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NEREBaLaS2rpbQEAu9opvQ
	(envelope-from <netdev+bounces-305095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:41:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50993713693
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:41:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="Mmm/8wtV";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305095-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305095-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59ACD35F261B
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9F3A168B;
	Mon,  6 Jul 2026 14:22:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31E39150B
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 14:22:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347722; cv=none; b=LpHig5WvRQ+RVONAYldBMgrEvePFKWZIoYp2Z7XDITezKjcwtarq13AdJKEcuJ7f8E17ZGLTPW7FTLrlSRjsiN8AO0P4X8jJBl30Wqld/5Id5QNAerms6xcM3cmpjfGON2nQf0g21CUT+YJU+yxIKIbdM7tuiXhKBNyAILG/oog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347722; c=relaxed/simple;
	bh=0MQw+3hogzCqZa91Fl8k+NCBucnG1q/SCso4dDdvvaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cj0Yb2R3JK7K0TNXg/mrm5yrjD5hzyqOyDiJkIbb0brrskyoRArtxEPIjrlwn9gMN4ztVHgaq1I4EcrCG7hInqDsKXCqv8bp1sY8UpxQmDs6fF5sAn7T/RjbT8KSlUpS/z35Lw+XrwNa1QuUTQ+hXHoQATPfil5K4TFFqnw/IRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mmm/8wtV; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783347719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oyRLoSa9M/zWflzQHXXInnLUy9T9/5UP5bH8uU/2ok=;
	b=Mmm/8wtVmfNgRhtuAHF9ZqO4qrY807vz4TbQLBqjTgLCpAOupgcIZ5pUSVZtyspta5tP9D
	+fXRHO+1ZrTdlHBBPLvzcyOXjmJZTaLI1w++AkB5L/duYpFfY3tUOUbezi/fe/nedDLwo5
	LmWDLkxVSAMyGq3MdC03jfVDhhIxtEU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-N5MJN1HXONuCokcJCsCjAQ-1; Mon,
 06 Jul 2026 10:21:56 -0400
X-MC-Unique: N5MJN1HXONuCokcJCsCjAQ-1
X-Mimecast-MFC-AGG-ID: N5MJN1HXONuCokcJCsCjAQ_1783347715
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 300B318052F8;
	Mon,  6 Jul 2026 14:21:55 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A02818005A7;
	Mon,  6 Jul 2026 14:21:53 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  Ilya Maximets <i.maximets@ovn.org>,  Kyle Zeng
 <kylebot@openai.com>,  Eelco Chaudron <echaudro@redhat.com>,  Outbound
 Disclosures <outbounddisclosures@openai.com>,  security@kernel.org
Subject: Re: [Security] Vulnerability in: Linux kernel, openvswitch zerocopy
 underflow
In-Reply-To: <CAJ0BgHeKoF7nnwA1_V0PSVETA+T9z9EX=OtSM4vMxQJv=nZAPg@mail.gmail.com>
	(=?utf-8?B?IuS+r+aVj+eGmSIncw==?= message of "Mon, 6 Jul 2026 08:25:51
 -0400")
References: <CAC7i46_c9af0xxn1JZ0afxg6VqK_H2B6Ox_RgfbYKYTMGQ4kDQ@mail.gmail.com>
	<CAC7i46_n4HJ25m+4uDjWCO_8uy10L1RcU3idgESSHnfq=ePU+A@mail.gmail.com>
	<CAC7i46_KASHgxuvj2vmnVr7khUvi1sXqnaR0Q0uZvBirBjdViQ@mail.gmail.com>
	<59fdbe4d-57ce-47e1-a007-bf020a74dc50@ovn.org>
	<749d73be-8748-481e-a69d-a99933e96836n@openai.com>
	<9cbfcd6e-f4b9-4de4-91d3-aa5c8ada8593@ovn.org>
	<FD33750A-9A1B-4764-AC52-8F427CE47B61@redhat.com>
	<f4d21cab-4dcd-48c5-867d-86cd8446999e@ovn.org>
	<CAC7i46_6UtBV32eV=A6Xsy8pstbFWgyqcmE57GrdBkX_ynGmJQ@mail.gmail.com>
	<09c38c10-3ff7-48a3-8c8f-85ad53287ce6@ovn.org>
	<f7tpl102uj3.fsf@redhat.com>
	<CAJ0BgHeKoF7nnwA1_V0PSVETA+T9z9EX=OtSM4vMxQJv=nZAPg@mail.gmail.com>
Date: Mon, 06 Jul 2026 10:21:52 -0400
Message-ID: <f7tcxx02o73.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305095-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:i.maximets@ovn.org,m:kylebot@openai.com,m:echaudro@redhat.com,m:outbounddisclosures@openai.com,m:security@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openai.com:email,ovn.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50993713693

=E4=BE=AF=E6=95=8F=E7=86=99 <houminxi@gmail.com> writes:

>> Just an FYI - this vulnerability is now public after Sashiko scanned
>> a proposed patch:
>
> Thanks for the heads-up, Aaron.
>
> My test_trunc() only exercises the non-GSO forwarding path (veth +
> ping), so neither the GSO segmentation underflow nor the POP_ETH +
> TRUNC combination is covered.
>
> Once a fix lands on net-next, I'll extend the TRUNC test to verify
> the new cutlen semantics.

No need.  Let's keep it as is.  We can look at doing complex 'fuzzing'
stuff in the future, but for now just giving a heads up.

> happy to help with testing if needed.
>
> Minxi
>
> Aaron Conole <aconole@redhat.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=B8=80 08:05=E5=86=99=E9=81=93=EF=BC=9A
>
>  Ilya Maximets <i.maximets@ovn.org> writes:
>
>  > On 6/26/26 5:12 AM, Kyle Zeng wrote:
>  >> Hi Ilya,
>  >>=20
>  >> I just tested the patch. It prevents underflow. However, it leads to a
>  >> BUG_ON crash, the PoC and crash splash are attached.
>  >>=20
>  >> The patch changes `OVS_CB(skb)->cutlen` from "number of bytes to
>  >> remove" to "number of bytes to preserve." That also changes the
>  >> no-truncation sentinel from 0 to U32_MAX.
>  >> Most of the action paths were updated to use U32_MAX, but the
>  >> miss-upcall path was not. It still does `error =3D ovs_dp_upcall(dp,
>  >> skb, key, &upcall, 0);` in `ovs_dp_process_packet()`.
>  >
>  > This is a good point, I missed that part.
>
>  Just an FYI - this vulnerability is now public after Sashiko scanned a
>  proposed patch:
>
>  https://sashiko.dev/#/patchset/20260702074926.1174810-1-houminxi%40gmail=
.com
>
>    > This is a pre-existing issue, but while looking at how TRUNC is hand=
led,
>    > there appears to be an integer underflow vulnerability...
>
>  Minxi has been adding tests for different actions, and proposed a TRUNC
>  action test.  When reviewing it, I looked at the AI comments from the two
>  different Sashiko instances and saw this.  I've CC'd Minxi as well,
>  since he proposed the selftest.
>
>  Further discussion probably doesn't need to be on the security only
>  list, and I think it is best if we go to the public mailing list.
>
>  >>=20
>  >> Under the new semantics, that 0 is no longer "no truncation" It means
>  >> "preserve zero bytes". As a result, `queue_userspace_packet()`
>  >> computes:
>  >> `skb_len =3D min(skb->len, cutlen); /* becomes 0 */` and then: `hlen =
=3D
>  >> skb_len; /* also becomes 0 */` before calling `skb_zerocopy(user_skb,
>  >> skb, skb_len, hlen);`.
>  >>=20
>  >> I adapted your patch and the new patch is attached.
>  >
>  > See some comments below.
>  >
>  >> From 5b2b6f328b339a22c8a96bdacda4b62884640696 Mon Sep 17 00:00:00 2001
>  >> From: Kyle Zeng <kylebot@openai.com>
>  >> Date: Fri, 26 Jun 2026 02:48:14 +0000
>  >> Subject: [PATCH] openvswitch: fix GSO userspace truncation underflow
>  >>=20
>  >> OVS_ACTION_ATTR_TRUNC currently stores a delta from the original skb
>  >> length in OVS_CB(skb)->cutlen. When a later userspace action segments=
 a
>  >> GSO skb, queue_gso_packets() reuses that delta for each smaller segme=
nt.
>  >> A segment can then reach queue_userspace_packet() with cutlen greater
>  >> than skb->len, underflowing the length passed to skb_zerocopy().
>  >>=20
>  >> Store the maximum preserved length instead and derive the effective
>  >> length from each current skb with min(). Use U32_MAX as the
>  >> no-truncation sentinel so the value remains valid if skb geometry
>  >> changes before a consumer handles it.
>  >>=20
>  >> Fixes: f2a4d086ed4c ("openvswitch: Add packet truncation support.")
>  >> Cc: stable@vger.kernel.org
>  >> Assisted-by: Codex:gpt-5.5
>  >> Signed-off-by: Kyle Zeng <kylebot@openai.com>
>  >> ---
>  >>  net/openvswitch/actions.c  | 20 ++++++++------------
>  >>  net/openvswitch/datapath.c | 19 +++++++++++--------
>  >>  net/openvswitch/datapath.h |  3 ++-
>  >>  net/openvswitch/vport.c    |  2 +-
>  >>  4 files changed, 22 insertions(+), 22 deletions(-)
>  >>=20
>  >> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>  >> index 140388a18ae0..596ad1be8b6b 100644
>  >> --- a/net/openvswitch/actions.c
>  >> +++ b/net/openvswitch/actions.c
>  >> @@ -837,12 +837,9 @@ static void do_output(struct datapath *dp, struc=
t sk_buff
>  *skb, int out_port,
>  >>              u16 mru =3D OVS_CB(skb)->mru;
>  >>              u32 cutlen =3D OVS_CB(skb)->cutlen;
>  >>=20=20
>  >> -            if (unlikely(cutlen > 0)) {
>  >> -                    if (skb->len - cutlen > ovs_mac_header_len(key))
>  >> -                            pskb_trim(skb, skb->len - cutlen);
>  >> -                    else
>  >> -                            pskb_trim(skb, ovs_mac_header_len(key));
>  >> -            }
>  >> +            if (unlikely(cutlen !=3D U32_MAX))
>  >
>  > There is no need to trim if cutlen >=3D skb->len.  Is there some probl=
em with
>  > the approach I had in my diff:
>  >
>  > +             if (unlikely(cutlen < skb->len))
>  > +                     pskb_trim(skb, max(cutlen, ovs_mac_header_len(ke=
y)));
>  >
>  > ?
>  >
>  >> +                    pskb_trim(skb, max(min(skb->len, cutlen),
>  >> +                                       ovs_mac_header_len(key)));
>  >>=20=20
>  >>              if (likely(!mru ||
>  >>                         (skb->len <=3D mru + vport->dev->hard_header_=
len))) {
>  >> @@ -1234,7 +1231,7 @@ static void execute_psample(struct datapath *dp=
, struct
>  sk_buff *skb,
>  >>=20=20
>  >>      psample_group.net=E2=9A=A0=EF=B8=8F =3D ovs_dp_get_net(dp);
>  >>      md.in_ifindex =3D OVS_CB(skb)->input_vport->dev->ifindex;
>  >> -    md.trunc_size =3D skb->len - OVS_CB(skb)->cutlen;
>  >> +    md.trunc_size =3D min(skb->len, OVS_CB(skb)->cutlen);
>  >>      md.rate_as_probability =3D 1;
>  >>=20=20
>  >>      rate =3D OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U=
32_MAX;
>  >> @@ -1284,22 +1281,21 @@ static int do_execute_actions(struct datapath=
 *dp, struct
>  sk_buff *skb,
>  >>                      clone =3D skb_clone(skb, GFP_ATOMIC);
>  >>                      if (clone)
>  >>                              do_output(dp, clone, port, key);
>  >> -                    OVS_CB(skb)->cutlen =3D 0;
>  >> +                    OVS_CB(skb)->cutlen =3D U32_MAX;
>  >>                      break;
>  >>              }
>  >>=20=20
>  >>              case OVS_ACTION_ATTR_TRUNC: {
>  >>                      struct ovs_action_trunc *trunc =3D nla_data(a);
>  >>=20=20
>  >> -                    if (skb->len > trunc->max_len)
>  >> -                            OVS_CB(skb)->cutlen =3D skb->len - trunc=
->max_len;
>  >> +                    OVS_CB(skb)->cutlen =3D trunc->max_len;
>  >>                      break;
>  >>              }
>  >>=20=20
>  >>              case OVS_ACTION_ATTR_USERSPACE:
>  >>                      output_userspace(dp, skb, key, a, attr,
>  >>                                                   len, OVS_CB(skb)->c=
utlen);
>  >> -                    OVS_CB(skb)->cutlen =3D 0;
>  >> +                    OVS_CB(skb)->cutlen =3D U32_MAX;
>  >>                      if (nla_is_last(a, rem)) {
>  >>                              consume_skb(skb);
>  >>                              return 0;
>  >> @@ -1453,7 +1449,7 @@ static int do_execute_actions(struct datapath *=
dp, struct
>  sk_buff *skb,
>  >>=20=20
>  >>              case OVS_ACTION_ATTR_PSAMPLE:
>  >>                      execute_psample(dp, skb, a);
>  >> -                    OVS_CB(skb)->cutlen =3D 0;
>  >> +                    OVS_CB(skb)->cutlen =3D U32_MAX;
>  >>                      if (nla_is_last(a, rem)) {
>  >>                              consume_skb(skb);
>  >>                              return 0;
>  >> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
>  >> index f0164817d9b7..66c621a611b7 100644
>  >> --- a/net/openvswitch/datapath.c
>  >> +++ b/net/openvswitch/datapath.c
>  >> @@ -276,7 +276,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, s=
truct
>  sw_flow_key *key)
>  >>                      upcall.portid =3D ovs_vport_find_upcall_portid(p=
, skb);
>  >>=20=20
>  >>              upcall.mru =3D OVS_CB(skb)->mru;
>  >> -            error =3D ovs_dp_upcall(dp, skb, key, &upcall, 0);
>  >> +            error =3D ovs_dp_upcall(dp, skb, key, &upcall, U32_MAX);
>  >>              switch (error) {
>  >>              case 0:
>  >>              case -EAGAIN:
>  >> @@ -458,6 +458,7 @@ static int queue_userspace_packet(struct datapath=
 *dp, struct
>  sk_buff *skb,
>  >>      struct sk_buff *user_skb =3D NULL; /* to be queued to userspace =
*/
>  >>      struct nlattr *nla;
>  >>      size_t len;
>  >
>  > I would still rename this into msg_size.  Having 'len' and 'skb_len'
>  > in the same scope is confusing.
>  >
>  >> +    unsigned int skb_len;
>  >>      unsigned int hlen;
>  >>      int err, dp_ifindex;
>  >>      u64 hash;
>  >> @@ -478,7 +479,8 @@ static int queue_userspace_packet(struct datapath=
 *dp, struct
>  sk_buff *skb,
>  >>              skb =3D nskb;
>  >>      }
>  >>=20=20
>  >> -    if (nla_attr_size(skb->len) > USHRT_MAX) {
>  >> +    skb_len =3D min(skb->len, cutlen);
>  >> +    if (nla_attr_size(skb_len) > USHRT_MAX) {
>  >>              err =3D -EFBIG;
>  >>              goto out;
>  >>      }
>  >> @@ -493,11 +495,11 @@ static int queue_userspace_packet(struct datapa=
th *dp,
>  struct sk_buff *skb,
>  >>       * padding logic. Only perform zerocopy if padding is not requir=
ed.
>  >>       */
>  >>      if (dp->user_features & OVS_DP_F_UNALIGNED)
>  >> -            hlen =3D skb_zerocopy_headlen(skb);
>  >> +            hlen =3D min(skb_zerocopy_headlen(skb), skb_len);
>  >>      else
>  >> -            hlen =3D skb->len;
>  >> +            hlen =3D skb_len;
>  >>=20=20
>  >> -    len =3D upcall_msg_size(upcall_info, hlen - cutlen,
>  >> +    len =3D upcall_msg_size(upcall_info, hlen,
>  >>                            OVS_CB(skb)->acts_origlen);
>  >>      user_skb =3D genlmsg_new(len, GFP_ATOMIC);
>  >>      if (!user_skb) {
>  >> @@ -560,7 +562,7 @@ static int queue_userspace_packet(struct datapath=
 *dp, struct
>  sk_buff *skb,
>  >>      }
>  >>=20=20
>  >>      /* Add OVS_PACKET_ATTR_LEN when packet is truncated */
>  >> -    if (cutlen > 0 &&
>  >> +    if (cutlen !=3D U32_MAX &&
>  >
>  > This changes the logic.  The attribute should be included only if the
>  > packet was actually truncated, i.e., if skb_len < skb->len.
>  >
>  >>          nla_put_u32(user_skb, OVS_PACKET_ATTR_LEN, skb->len)) {
>  >>              err =3D -ENOBUFS;
>  >>              goto out;
>  >> @@ -585,9 +587,9 @@ static int queue_userspace_packet(struct datapath=
 *dp, struct
>  sk_buff *skb,
>  >>              err =3D -ENOBUFS;
>  >>              goto out;
>  >>      }
>  >> -    nla->nla_len =3D nla_attr_size(skb->len - cutlen);
>  >> +    nla->nla_len =3D nla_attr_size(skb_len);
>  >>=20=20
>  >> -    err =3D skb_zerocopy(user_skb, skb, skb->len - cutlen, hlen);
>  >> +    err =3D skb_zerocopy(user_skb, skb, skb_len, hlen);
>  >>      if (err)
>  >>              goto out;
>  >>=20=20
>  >> @@ -644,6 +646,7 @@ static int ovs_packet_cmd_execute(struct sk_buff =
*skb, struct
>  genl_info *info)
>  >>              packet->ignore_df =3D 1;
>  >>      }
>  >>      OVS_CB(packet)->mru =3D mru;
>  >> +    OVS_CB(packet)->cutlen =3D U32_MAX;
>  >>=20=20
>  >>      if (a[OVS_PACKET_ATTR_HASH]) {
>  >>              hash =3D nla_get_u64(a[OVS_PACKET_ATTR_HASH]);
>  >> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
>  >> index db0c3e69d66c..11fa104b6172 100644
>  >> --- a/net/openvswitch/datapath.h
>  >> +++ b/net/openvswitch/datapath.h
>  >> @@ -118,7 +118,8 @@ struct datapath {
>  >>   * @mru: The maximum received fragement size; 0 if the packet is not
>  >>   * fragmented.
>  >>   * @acts_origlen: The netlink size of the flow actions applied to th=
is skb.
>  >> - * @cutlen: The number of bytes from the packet end to be removed.
>  >> + * @cutlen: The maximum number of bytes to preserve on output. U32_M=
AX means
>  >> + * no truncation.
>  >>   * @probability: The sampling probability that was applied to this s=
kb; 0 means
>  >>   * no sampling has occurred; U32_MAX means 100% probability.
>  >>   * @upcall_pid: Netlink socket PID to use for sending this packet to=
 userspace;
>  >> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
>  >> index 56b2e2d1a749..12741485c939 100644
>  >> --- a/net/openvswitch/vport.c
>  >> +++ b/net/openvswitch/vport.c
>  >> @@ -502,7 +502,7 @@ int ovs_vport_receive(struct vport *vport, struct=
 sk_buff *skb,
>  >>=20=20
>  >>      OVS_CB(skb)->input_vport =3D vport;
>  >>      OVS_CB(skb)->mru =3D 0;
>  >> -    OVS_CB(skb)->cutlen =3D 0;
>  >> +    OVS_CB(skb)->cutlen =3D U32_MAX;
>  >>      OVS_CB(skb)->probability =3D 0;
>  >>      OVS_CB(skb)->upcall_pid =3D 0;
>  >>      if (unlikely(dev_net(skb->dev) !=3D ovs_dp_get_net(vport->dp))) {
>  >> --=20
>  >> 2.54.0
>  >>=20


